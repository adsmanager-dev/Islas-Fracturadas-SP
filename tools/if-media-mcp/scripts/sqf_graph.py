#!/usr/bin/env python3
"""
Construye un grafo de llamadas de las funciones IF_fnc_* de Islas Fracturadas.

Fuentes de verdad, en este orden:
  1. CfgFunctions (cfg/CfgFunctions.hpp o donde se declare) -> registro autoritativo
     de qué archivo .sqf implementa qué IF_fnc_X (tag + file + nombre de clase).
  2. Cada archivo .sqf registrado -> tokenizado con un tokenizador propio (no regex
     ciego sobre texto crudo) para encontrar sitios de llamada (call/spawn/execFSM/
     remoteExec/remoteExecCall) sin confundir strings ni comentarios con código.

No resuelve invocaciones dinámicas (call compile de una variable, call de una
expresión entre paréntesis, etc.) — se listan aparte como "dynamic_calls", nunca se
inventan como si fueran una arista resuelta. Esto es deliberado: un grafo que parece
completo pero esconde sus propios huecos es peor que uno que los declara.

Opcionalmente también lee mission.sqm (--mission-sqm): busca campos `init` reales de
entidades (objetos, grupos, triggers, módulos) — NUNCA `CustomAttributes/*/expression`,
que es boilerplate propio del editor 3DEN (setVariable de atributos de UI), no lógica
de misión escrita por una persona. Cada init se tokeniza igual que un .sqf y sus
llamadas se añaden al grafo con origen `mission.sqm:<ruta de la entidad>`. Probado
contra mission.sqm reales de AI_REFERENCES/A3-Antistasi y AI_REFERENCES/KP-Liberation,
ambos con muy pocos init reales (arquitecturas basadas en CfgFunctions preInit/postInit,
igual que este proyecto) — un resultado vacío o casi vacío es el comportamiento
correcto para este tipo de misión, no un fallo del parser.
"""
from __future__ import annotations

import json
import re
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Optional

from arma_class_io import derapify_if_needed

FUNC_NAME_PATTERN = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")
CALL_KEYWORDS = {"call", "spawn", "execfsm"}
REMOTE_KEYWORDS = {"remoteexec", "remoteexeccall"}
IF_FNC_PATTERN = re.compile(r"^[A-Za-z][A-Za-z0-9_]*_fnc_[A-Za-z0-9_]+$")


def build_function_registry(cfg_functions: dict, altis_root: Path) -> dict:
    """CfgFunctions -> {IF_fnc_nombre: ruta relativa al .sqf}. Requiere tag+file por categoría."""
    registry: dict[str, str] = {}
    root = cfg_functions.get("CfgFunctions", cfg_functions)
    for tag_name, tag_body in root.items():
        if not isinstance(tag_body, dict):
            continue
        tag = tag_body.get("tag", tag_name)
        for category_name, category_body in tag_body.items():
            if not isinstance(category_body, dict) or "file" not in category_body:
                continue
            file_dir = category_body["file"]
            for class_name, class_body in category_body.items():
                if class_name == "file" or not isinstance(class_body, dict):
                    continue
                fnc_name = f"{tag}_fnc_{class_name}"
                rel_path = (Path(file_dir.replace("\\", "/")) / f"fn_{class_name}.sqf").as_posix()
                registry[fnc_name] = rel_path
    return registry


# --------------------------------------------------------------------------- #
# Tokenizador SQF propio — deliberadamente simple pero correcto en lo esencial:
# strings y comentarios nunca se confunden con identificadores de código.
# --------------------------------------------------------------------------- #

@dataclass
class Token:
    kind: str  # "identifier" | "string" | "other"
    value: str
    line: int


def tokenize_sqf(text: str) -> list[Token]:
    tokens: list[Token] = []
    i = 0
    line = 1
    n = len(text)
    while i < n:
        ch = text[i]
        if ch == "\n":
            line += 1
            i += 1
            continue
        if ch.isspace():
            i += 1
            continue
        if ch == "/" and i + 1 < n and text[i + 1] == "/":
            j = text.find("\n", i)
            i = n if j == -1 else j
            continue
        if ch == "/" and i + 1 < n and text[i + 1] == "*":
            j = text.find("*/", i + 2)
            block = text[i: (j + 2 if j != -1 else n)]
            line += block.count("\n")
            i = n if j == -1 else j + 2
            continue
        if ch in ("\"", "'"):
            quote = ch
            j = i + 1
            buf = []
            while j < n:
                if text[j] == quote:
                    if j + 1 < n and text[j + 1] == quote:
                        buf.append(quote)
                        j += 2
                        continue
                    j += 1
                    break
                if text[j] == "\n":
                    line += 1
                buf.append(text[j])
                j += 1
            tokens.append(Token("string", "".join(buf), line))
            i = j
            continue
        if ch.isalpha() or ch == "_":
            j = i
            while j < n and (text[j].isalnum() or text[j] == "_"):
                j += 1
            tokens.append(Token("identifier", text[i:j], line))
            i = j
            continue
        tokens.append(Token("other", ch, line))
        i += 1
    return tokens


@dataclass
class Edge:
    source: str
    target: str
    kind: str  # "static" | "unresolved_name" | "dynamic"
    line: int
    detail: str = ""


def extract_edges(tokens: list[Token], source_fnc: str, registry: dict[str, str]) -> list[Edge]:
    edges: list[Edge] = []
    n = len(tokens)
    for idx, tok in enumerate(tokens):
        if tok.kind != "identifier":
            continue
        lowered = tok.value.lower()
        if lowered in CALL_KEYWORDS:
            nxt = _next_meaningful(tokens, idx + 1)
            if nxt is None:
                continue
            if nxt.kind == "identifier" and nxt.value.lower() == "compile":
                edges.append(Edge(source_fnc, "<dynamic:compile>", "dynamic", tok.line, "call compile ..."))
            elif nxt.kind == "identifier":
                target = nxt.value
                if target in registry or IF_FNC_PATTERN.match(target):
                    kind = "static" if target in registry else "unresolved_name"
                    edges.append(Edge(source_fnc, target, kind, tok.line))
                elif target.startswith("_"):
                    # Variable privada como destino (`call _y`): despacho dinámico real,
                    # el objetivo depende de datos en tiempo de ejecución. Se declara, no se oculta.
                    edges.append(Edge(source_fnc, f"<dynamic:variable:{target}>", "dynamic", tok.line, f"{tok.value} {target}"))
                elif idx + 2 < n and tokens[idx + 2].kind == "other" and tokens[idx + 2].value == "(":
                    # Patrón macro (`call FUNC(nombre)`): el preprocesador no se expande aquí,
                    # así que el objetivo real es desconocido sin ejecutar el preprocesador de Arma.
                    edges.append(Edge(source_fnc, f"<dynamic:macro:{target}>", "dynamic", tok.line, f"{tok.value} {target}(...)"))
                # Un identificador que es un comando SQF nativo (p.ej. `call compile` ya cubierto,
                # o el objetivo de un `then`/`else` no aplica aquí) se ignora deliberadamente: no
                # es un comando de llamada real en esa posición gramatical.
            elif nxt.kind == "other" and nxt.value == "(":
                edges.append(Edge(source_fnc, "<dynamic:expression>", "dynamic", tok.line, f"{tok.value} (...)"))
        elif lowered in REMOTE_KEYWORDS:
            # Patrón habitual: [args, "IF_fnc_x", target] remoteExec [...] — la keyword va
            # DESPUÉS del array; buscamos strings IF_fnc_* en la ventana previa cercana.
            for back in range(idx - 1, max(idx - 40, -1), -1):
                t = tokens[back]
                if t.kind == "string" and IF_FNC_PATTERN.match(t.value):
                    kind = "static" if t.value in registry else "unresolved_name"
                    edges.append(Edge(source_fnc, t.value, kind, t.line, "remoteExec"))
                if t.kind == "other" and t.value == "[" and back < idx - 1:
                    pass
    return edges


def _next_meaningful(tokens: list[Token], start: int) -> Optional[Token]:
    return tokens[start] if start < len(tokens) else None


# --------------------------------------------------------------------------- #
# mission.sqm: solo campos `init` reales de entidades — nunca CustomAttributes,
# que es boilerplate de UI del propio 3DEN (setVariable de atributos), no lógica
# de misión.
# --------------------------------------------------------------------------- #

def extract_mission_inits(mission_data: dict) -> list[tuple[str, str]]:
    results: list[tuple[str, str]] = []

    def walk(node, path: str, under_custom_attributes: bool):
        if isinstance(node, dict):
            for key, value in node.items():
                next_under_custom = under_custom_attributes or key == "CustomAttributes"
                if key.lower() == "init" and isinstance(value, str) and value.strip() and not under_custom_attributes:
                    results.append((path or "mission", value))
                walk(value, f"{path}/{key}" if path else key, next_under_custom)
        elif isinstance(node, list):
            for i, item in enumerate(node):
                walk(item, f"{path}[{i}]", under_custom_attributes)

    walk(mission_data.get("Mission", mission_data), "Mission", False)
    return results


# --------------------------------------------------------------------------- #
# Construcción del grafo completo
# --------------------------------------------------------------------------- #

def build_graph(altis_root: Path, registry: dict[str, str], mission_inits: list[tuple[str, str]] | None = None) -> dict:
    nodes = sorted(registry.keys())
    edges: list[Edge] = []
    missing_files: list[str] = []
    for fnc_name, rel_path in registry.items():
        full_path = altis_root / rel_path
        if not full_path.is_file():
            missing_files.append(rel_path)
            continue
        text = full_path.read_text(encoding="utf-8-sig", errors="replace")
        tokens = tokenize_sqf(text)
        edges.extend(extract_edges(tokens, fnc_name, registry))

    mission_entities_scanned = 0
    if mission_inits:
        for entity_path, init_text in mission_inits:
            mission_entities_scanned += 1
            source = f"mission.sqm:{entity_path}"
            tokens = tokenize_sqf(init_text)
            edges.extend(extract_edges(tokens, source, registry))

    static_edges = [e for e in edges if e.kind in ("static", "unresolved_name")]
    dynamic_edges = [e for e in edges if e.kind == "dynamic"]
    unresolved_names = sorted({e.target for e in edges if e.kind == "unresolved_name"})

    return {
        "nodes": nodes,
        "edges": [
            {"from": e.source, "to": e.target, "kind": e.kind, "line": e.line, "detail": e.detail}
            for e in static_edges
        ],
        "dynamic_calls": [
            {"from": e.source, "kind": e.detail or e.target, "line": e.line}
            for e in dynamic_edges
        ],
        "unresolved_names": unresolved_names,
        "missing_files": missing_files,
        "mission_entities_with_init_scanned": mission_entities_scanned,
    }


def graph_to_d2(graph: dict) -> str:
    lines = ["# Generado por sqf_graph.py — no editar a mano"]
    for node in graph["nodes"]:
        safe = node.replace('"', '\\"')
        lines.append(f'"{safe}"')
    for edge in graph["edges"]:
        style = ' {style.stroke-dash: 4}' if edge["kind"] == "unresolved_name" else ""
        lines.append(f'"{edge["from"]}" -> "{edge["to"]}"{style}')
    return "\n".join(lines) + "\n"


def main() -> int:
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--altis-root", required=True, type=Path)
    parser.add_argument("--cfgfunctions", required=True, type=Path)
    parser.add_argument("--hemtt", default=None)
    parser.add_argument("--mission-sqm", default=None, type=Path)
    parser.add_argument("--output-json", required=True, type=Path)
    parser.add_argument("--output-d2", required=True, type=Path)
    args = parser.parse_args()

    cfg_data = derapify_if_needed(args.cfgfunctions, args.hemtt)
    registry = build_function_registry(cfg_data, args.altis_root)

    mission_inits = None
    if args.mission_sqm:
        mission_data = derapify_if_needed(args.mission_sqm, args.hemtt)
        mission_inits = extract_mission_inits(mission_data)

    graph = build_graph(args.altis_root, registry, mission_inits)
    graph["function_registry"] = registry

    args.output_json.write_text(json.dumps(graph, indent=2, ensure_ascii=False), encoding="utf-8")
    args.output_d2.write_text(graph_to_d2(graph), encoding="utf-8")

    print(f"nodos={len(graph['nodes'])} aristas_estaticas={len(graph['edges'])} "
          f"llamadas_dinamicas={len(graph['dynamic_calls'])} "
          f"nombres_sin_resolver={len(graph['unresolved_names'])} "
          f"archivos_faltantes={len(graph['missing_files'])} "
          f"entidades_mission_sqm_con_init={graph['mission_entities_with_init_scanned']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
