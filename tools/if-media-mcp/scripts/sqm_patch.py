#!/usr/bin/env python3
"""
Parche quirúrgico de mission.sqm: cambia SOLO position[]/angles[] de una entidad
existente (localizada por su `id` nativo, único en todo el archivo — verificado
contra AI_REFERENCES/A3-Antistasi: 1561 entidades, 1561 IDs únicos). El resto del
archivo queda byte-por-byte idéntico — no es un parseo-completo→regenerar-completo
(eso reformatea el archivo entero, ver EVALUATION.md 2026-08-08).

También añade entidades nuevas (`add_object_entity`), pero SOLO dataType="Object"
anexado como último elemento del bloque raíz `class Mission { class Entities
{...} }` — nunca dentro de un Group/Layer existente, y nunca otros dataType
(Marker/Logic/Layer/Group tienen su propia forma de serialización, no
verificada aquí). Investigación previa (2026-08-08, ver EVALUATION.md) confirmó
en 140 bloques `class Entities` reales (proyecto propio + 2 mapas de Antistasi)
que los índices ItemN son siempre contiguos 0..N-1 — por eso añadir al final es
seguro (basta incrementar `items=`), mientras que borrar cualquier entidad que
no sea la última exigiría renumerar todas las posteriores; por eso NO se
implementa borrado todavía.

Flujo de seguridad (excepción AGENTS.md 2026-08-08):
  1. Backup del original (timestamped, nunca se sobrescribe el mission.sqm real).
  2. Parche quirúrgico sobre el texto (no sobre el árbol re-serializado).
  3. Validación por round-trip: re-parsear el resultado, confirmar que SOLO la
     entidad objetivo cambió y que el número total de entidades es idéntico.
  4. El resultado se escribe en un archivo nuevo, nunca sobre el original —
     aplicarlo al mission.sqm real requiere una confirmación explícita aparte.
  5. Toda escritura debe verificarse abriendo la misión en 3DEN/Arma 3 después.
"""
from __future__ import annotations

import json
import re
import sys
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Optional

import armaclass
from arma_class_io import derapify_if_needed
from sqm_inspect import flatten_entities

ARRAY_FIELD_PATTERN = {
    "position": re.compile(r"position\[\]\s*=\s*\{(.*?)\}\s*;", re.DOTALL),
    "angles": re.compile(r"angles\[\]\s*=\s*\{(.*?)\}\s*;", re.DOTALL),
}

# Campos escalares soportados: nombre de variable, texto de marcador/hint y
# atributos numéricos de unidad — verificados contra ejemplos reales en
# AI_REFERENCES/A3-Antistasi (name="airp_mortar_1";, text="Your Headquarters";,
# skill=0.2; anidado en class Attributes). Se excluyen deliberadamente `id`,
# `type`, `dataType` y cualquier campo estructural: cambiarlos puede romper
# referencias cruzadas o el propio parseo, y no son lo que el usuario pide
# al "editar una entidad" (mover/renombrar/ajustar atributos de IA).
SCALAR_FIELD_TYPES = {
    "name": "string",
    "text": "string",
    "skill": "number",
    "fuel": "number",
    "healthLevel": "number",
    "damage": "number",
}

NUMBER_LITERAL = r"-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?"

SCALAR_FIELD_PATTERN = {
    field: (
        re.compile(rf'{field}\s*=\s*"((?:[^"]|"")*)"\s*;')
        if kind == "string"
        else re.compile(rf"{field}\s*=\s*({NUMBER_LITERAL})\s*;")
    )
    for field, kind in SCALAR_FIELD_TYPES.items()
}


class PatchError(Exception):
    pass


def find_entity_block_span(text: str, entity_id: int) -> tuple[int, int]:
    """Devuelve (inicio, fin) del bloque {} que contiene directamente `id=<entity_id>;`."""
    matches = list(re.finditer(rf"\bid\s*=\s*{entity_id}\s*;", text))
    if len(matches) == 0:
        raise PatchError(f"No se encontró id={entity_id} en el texto (¿ya no existe esa entidad?).")
    if len(matches) > 1:
        raise PatchError(f"id={entity_id} aparece {len(matches)} veces — no es única, no se puede localizar sin ambigüedad.")
    id_pos = matches[0].start()

    depth = 0
    block_start = -1
    i = id_pos
    while i >= 0:
        if text[i] == "}":
            depth += 1
        elif text[i] == "{":
            if depth == 0:
                block_start = i
                break
            depth -= 1
        i -= 1
    if block_start == -1:
        raise PatchError(f"No se encontró la apertura del bloque que contiene id={entity_id}.")

    depth = 0
    block_end = -1
    i = id_pos
    n = len(text)
    while i < n:
        if text[i] == "{":
            depth += 1
        elif text[i] == "}":
            if depth == 0:
                block_end = i + 1
                break
            depth -= 1
        i += 1
    if block_end == -1:
        raise PatchError(f"No se encontró el cierre del bloque que contiene id={entity_id}.")

    return block_start, block_end


def patch_scalar_field(text: str, entity_id: int, field: str, value) -> str:
    if field not in SCALAR_FIELD_PATTERN:
        raise PatchError(f"Campo no soportado: {field}. Soportados: {sorted(SCALAR_FIELD_PATTERN)}.")
    block_start, block_end = find_entity_block_span(text, entity_id)
    block_text = text[block_start:block_end]

    pattern = SCALAR_FIELD_PATTERN[field]
    match = pattern.search(block_text)
    if not match:
        raise PatchError(f"La entidad id={entity_id} no tiene un campo {field} existente — no se crea uno nuevo en v1.")
    if pattern.search(block_text, match.end()):
        raise PatchError(f"Más de una ocurrencia de {field} dentro del bloque de id={entity_id} — ambiguo, abortando.")

    if SCALAR_FIELD_TYPES[field] == "string":
        escaped = str(value).replace('"', '""')
        new_field_text = f'{field}="{escaped}";'
    else:
        new_field_text = f"{field}={_format_number(float(value))};"

    new_block_text = block_text[:match.start()] + new_field_text + block_text[match.end():]
    return text[:block_start] + new_block_text + text[block_end:]


def read_field_value(text: str, entity_id: int, field: str):
    """Lee el valor actual de un campo (array o escalar) dentro del bloque de una
    entidad, sin modificar nada. Se usa para reportar old_value/new_value con la
    misma localización exacta que usa el parche, en vez de depender de la
    proyección reducida de sqm_inspect.flatten_entities (que no conoce skill/
    fuel/text/etc.)."""
    block_start, block_end = find_entity_block_span(text, entity_id)
    block_text = text[block_start:block_end]

    if field in ARRAY_FIELD_PATTERN:
        match = ARRAY_FIELD_PATTERN[field].search(block_text)
        if not match:
            return None
        return [float(v) for v in match.group(1).split(",") if v.strip()]

    if field in SCALAR_FIELD_PATTERN:
        match = SCALAR_FIELD_PATTERN[field].search(block_text)
        if not match:
            return None
        if SCALAR_FIELD_TYPES[field] == "string":
            return match.group(1).replace('""', '"')
        return float(match.group(1))

    raise PatchError(f"Campo no soportado: {field}.")


def _index_raw_entities_by_id(entities_node: dict) -> dict:
    """Indexa cada entidad por su id conservando sus PROPIOS campos completos (no
    una proyección reducida como la de sqm_inspect), para detectar cualquier
    cambio colateral en cualquier campo de otra entidad (skill, fuel, text...),
    no solo los que sqm_inspect elige exponer (name/init/position).

    Los contenedores (Layer/Group) anidan un `Entities` con TODOS sus
    descendientes — si se incluyera tal cual en la comparación, cambiar una
    entidad profundamente anidada haría que cada Layer/Group ancestro también
    "pareciera" cambiado, aunque el contenedor en sí no cambió nada (verificado
    contra AI_REFERENCES/A3-Antistasi: patchear una entidad dentro de un Layer
    anidado marcaba como afectados sus dos Layers contenedores). Por eso se
    excluye `Entities` de lo que se compara aquí; cada descendiente ya se
    verifica por separado en su propia entrada del índice.
    """
    indexed: dict = {}

    def walk(node):
        if not isinstance(node, dict):
            return
        if node.get("dataType") and node.get("id") is not None:
            indexed[node["id"]] = {k: v for k, v in node.items() if k != "Entities"}
        nested = node.get("Entities")
        if isinstance(nested, dict):
            for key, value in nested.items():
                if key.startswith("Item"):
                    walk(value)

    if isinstance(entities_node, dict):
        for key, value in entities_node.items():
            if key.startswith("Item"):
                walk(value)
    return indexed


def _line_indent(text: str, pos: int) -> str:
    """Whitespace inicial de la línea que contiene `pos` — se usa para que el
    bloque insertado imite la indentación real del archivo (tabs en los mission.sqm
    de Antistasi, 4 espacios en el de Islas Fracturadas; ninguno de los dos es
    obligatorio para Arma, pero mantiene el diff legible, igual que el resto de
    este módulo prioriza revisiones limpias sobre el mínimo código)."""
    line_start = text.rfind("\n", 0, pos) + 1
    i = line_start
    while i < len(text) and text[i] in " \t":
        i += 1
    return text[line_start:i]


def _detect_newline(text: str) -> str:
    return "\r\n" if "\r\n" in text else "\n"


def _find_root_entities_span(text: str) -> tuple[int, int]:
    """Localiza el ÚNICO `class Entities { ... }` que es hijo DIRECTO de `class
    Mission` (profundidad 1), no uno anidado dentro de un Group/Layer/entidad
    cualquiera. Devuelve (inicio del texto "class Entities", fin incluyendo "};")."""
    mission_match = re.search(r"\bclass\s+Mission\b\s*\{", text)
    if not mission_match:
        raise PatchError("No se encontró `class Mission {` en el archivo.")

    depth = 1
    i = mission_match.end()
    n = len(text)
    entities_class_kw = None
    entities_open = None
    while i < n:
        if depth == 1:
            m = re.match(r"class\s+Entities\b\s*\{", text[i:])
            if m:
                entities_class_kw = i
                entities_open = i + m.end() - 1
                break
        ch = text[i]
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                break
        i += 1
    if entities_open is None:
        raise PatchError("No se encontró `class Entities` directamente dentro de `class Mission`.")

    depth2 = 0
    j = entities_open
    entities_close = None
    while j < n:
        if text[j] == "{":
            depth2 += 1
        elif text[j] == "}":
            depth2 -= 1
            if depth2 == 0:
                entities_close = j + 1
                break
        j += 1
    if entities_close is None:
        raise PatchError("No se encontró el cierre de `class Entities` de Mission.")
    # incluir el ';' final si está presente
    k = entities_close
    while k < n and text[k] in " \t\r\n":
        k += 1
    if k < n and text[k] == ";":
        entities_close = k + 1
    return entities_class_kw, entities_close


def _max_entity_id(data: dict) -> int:
    entities = data.get("Mission", data).get("Entities", {})
    flat = flatten_entities(entities)
    ids = [e["id"] for e in flat if isinstance(e.get("id"), int)]
    if not ids:
        raise PatchError("No se encontró ninguna entidad con id en mission.sqm.")
    return max(ids)


def add_object_entity(text: str, data: dict, classname: str, position: list[float],
                       side: Optional[str] = None, angles: Optional[list[float]] = None,
                       name: Optional[str] = None, init: Optional[str] = None,
                       skill: Optional[float] = None) -> tuple[str, int]:
    """Añade una entidad dataType="Object" nueva como último elemento del bloque
    Entities raíz (hijo directo de Mission). Mantiene sincronizados los tres
    lugares que 3DEN mantiene coherentes entre sí (verificado contra
    AI_REFERENCES/A3-Antistasi: nextID = id máximo + 1 en ambos mapas probados):
      1. `class EditorData { class ItemIDProvider { nextID=...; }; }`, si existe.
      2. `items=N;` del bloque Entities raíz.
      3. El nuevo `class Item{N}` insertado justo antes del cierre de ese bloque.
    """
    root_start, root_end = _find_root_entities_span(text)
    root_block = text[root_start:root_end]

    items_match = re.search(r"\bitems\s*=\s*(\d+)\s*;", root_block)
    if not items_match:
        raise PatchError("El bloque Entities raíz no declara `items=N;`.")
    declared_items = int(items_match.group(1))
    if declared_items == 0:
        raise PatchError("El bloque Entities raíz está vacío (items=0) — v1 no soporta insertar "
                          "sin una entidad hermana de referencia para copiar indentación.")

    new_index = declared_items
    max_id = _max_entity_id(data)
    new_id = max_id + 1
    if re.search(rf"\bid\s*=\s*{new_id}\s*;", text):
        raise PatchError(f"id={new_id} ya existe en el archivo — no se puede asignar sin colisión.")

    root_entities = data.get("Mission", data)["Entities"]
    last_sibling = root_entities.get(f"Item{declared_items - 1}")
    last_sibling_id = last_sibling.get("id") if isinstance(last_sibling, dict) else None
    if last_sibling_id is None:
        raise PatchError(f"Item{declared_items - 1} del bloque raíz no tiene id — no se puede usar como referencia.")

    last_block_start, last_block_end = find_entity_block_span(text, last_sibling_id)
    # find_entity_block_span devuelve el final justo tras el '}' de cierre, SIN el
    # ';' que Arma exige después (`class ItemN { ... };`) — hay que insertar
    # después de ese ';', o se parte en dos la propia declaración de la hermana.
    k = last_block_end
    while k < len(text) and text[k] in " \t":
        k += 1
    if k < len(text) and text[k] == ";":
        last_block_end = k + 1
    class_kw_pos = text.rfind("class", root_start, last_block_start)
    if class_kw_pos == -1:
        raise PatchError("No se pudo localizar `class ItemN` de la última entidad hermana.")

    newline = _detect_newline(text)
    outer_indent = _line_indent(text, class_kw_pos)
    first_inner_newline = text.index(newline, last_block_start)
    inner_indent = _line_indent(text, first_inner_newline + len(newline))
    if inner_indent.startswith(outer_indent) and len(inner_indent) > len(outer_indent):
        indent_unit = inner_indent[len(outer_indent):]
    else:
        indent_unit = "\t"
    nested_indent = inner_indent + indent_unit

    lines = [f"{outer_indent}class Item{new_index}", f"{outer_indent}{{"]
    lines.append(f'{inner_indent}dataType="Object";')
    lines.append(f"{inner_indent}class PositionInfo")
    lines.append(f"{inner_indent}{{")
    lines.append(f"{nested_indent}position[]={{{','.join(_format_number(v) for v in position)}}};")
    if angles:
        lines.append(f"{nested_indent}angles[]={{{','.join(_format_number(v) for v in angles)}}};")
    lines.append(f"{inner_indent}}};")
    if side:
        escaped_side = str(side).replace('"', '""')
        lines.append(f'{inner_indent}side="{escaped_side}";')

    attrs: list[str] = []
    if name:
        attrs.append(f'{nested_indent}name="{str(name).replace(chr(34), chr(34) * 2)}";')
    if init:
        attrs.append(f'{nested_indent}init="{str(init).replace(chr(34), chr(34) * 2)}";')
    if skill is not None:
        attrs.append(f"{nested_indent}skill={_format_number(float(skill))};")
    if attrs:
        lines.append(f"{inner_indent}class Attributes")
        lines.append(f"{inner_indent}{{")
        lines.extend(attrs)
        lines.append(f"{inner_indent}}};")

    lines.append(f"{inner_indent}id={new_id};")
    escaped_type = str(classname).replace('"', '""')
    lines.append(f'{inner_indent}type="{escaped_type}";')
    lines.append(f"{outer_indent}}};")

    new_block_text = newline.join(lines)
    patched_text = text[:last_block_end] + newline + new_block_text + text[last_block_end:]

    items_abs_start = root_start + items_match.start()
    items_abs_end = root_start + items_match.end()
    patched_text = patched_text[:items_abs_start] + f"items={new_index + 1};" + patched_text[items_abs_end:]

    next_id_match = re.search(r"\bnextID\s*=\s*(\d+)\s*;", patched_text)
    if next_id_match and int(next_id_match.group(1)) <= new_id:
        patched_text = (patched_text[:next_id_match.start()]
                         + f"nextID={new_id + 1};"
                         + patched_text[next_id_match.end():])

    return patched_text, new_id


def delete_entity(text: str, data: dict, entity_id: int) -> str:
    """Borra la entidad `entity_id`, pero SOLO si es la ÚLTIMA (`Item{items-1}`) del
    bloque Entities raíz — verificado (140 bloques reales) que ItemN es siempre
    contiguo 0..N-1, así que borrar cualquier otra posición dejaría un hueco y
    exigiría renumerar todas las posteriores; eso queda fuera de esta v1.

    El llamador debe pasar el `id` esperado (no solo confiar en "borra la
    última") para que un desajuste entre lo que el llamador cree que es la
    última entidad y lo que realmente es aborte con un error claro, en vez de
    borrar silenciosamente la entidad equivocada.

    Deliberadamente NO toca `nextID` (a diferencia de add_object_entity, que sí
    lo sube): no hay evidencia de que 3DEN reutilice IDs liberados por un
    borrado, y bajarlo sin esa certeza podría abrir una colisión futura. Dejarlo
    intacto es el lado seguro — como mucho queda "adelantado" en uno, inofensivo.
    """
    root_start, root_end = _find_root_entities_span(text)
    root_block = text[root_start:root_end]

    items_match = re.search(r"\bitems\s*=\s*(\d+)\s*;", root_block)
    if not items_match:
        raise PatchError("El bloque Entities raíz no declara `items=N;`.")
    declared_items = int(items_match.group(1))
    if declared_items == 0:
        raise PatchError("El bloque Entities raíz ya está vacío — no hay nada que borrar.")

    last_index = declared_items - 1
    root_entities = data.get("Mission", data)["Entities"]
    last_sibling = root_entities.get(f"Item{last_index}")
    last_sibling_id = last_sibling.get("id") if isinstance(last_sibling, dict) else None
    if last_sibling_id is None:
        raise PatchError(f"Item{last_index} del bloque raíz no tiene id — no se puede verificar de forma segura.")
    if last_sibling_id != entity_id:
        raise PatchError(f"id={entity_id} no es la ÚLTIMA entidad del bloque Entities raíz (esa es id={last_sibling_id}, "
                          f"Item{last_index}) — v1 solo borra la última, para no tener que renumerar las posteriores.")

    block_start, block_end = find_entity_block_span(text, entity_id)
    k = block_end
    while k < len(text) and text[k] in " \t":
        k += 1
    if k < len(text) and text[k] == ";":
        block_end = k + 1

    class_kw_pos = text.rfind("class", root_start, block_start)
    if class_kw_pos == -1:
        raise PatchError("No se pudo localizar `class ItemN` de la entidad a borrar.")
    line_start = text.rfind("\n", 0, class_kw_pos) + 1
    prefix = text[line_start:class_kw_pos]
    # Si solo hay whitespace entre el inicio de línea y "class ItemN", se borra la
    # línea completa (sin dejar una línea en blanco huérfana); si no, se borra
    # justo desde "class" (caso, no visto en archivos reales, de varias
    # declaraciones en una misma línea).
    remove_from = line_start if prefix.strip() == "" else class_kw_pos

    patched_text = text[:remove_from] + text[block_end:]

    items_abs_start = root_start + items_match.start()
    items_abs_end = root_start + items_match.end()
    patched_text = patched_text[:items_abs_start] + f"items={last_index};" + patched_text[items_abs_end:]

    return patched_text


def patch_array_field(text: str, entity_id: int, field: str, new_values: list[float]) -> str:
    if field not in ARRAY_FIELD_PATTERN:
        raise PatchError(f"Campo no soportado: {field}. Soportados: {sorted(ARRAY_FIELD_PATTERN)}.")
    block_start, block_end = find_entity_block_span(text, entity_id)
    block_text = text[block_start:block_end]

    pattern = ARRAY_FIELD_PATTERN[field]
    match = pattern.search(block_text)
    if not match:
        raise PatchError(f"La entidad id={entity_id} no tiene un campo {field}[] existente — no se crea uno nuevo en v1.")
    if pattern.search(block_text, match.end()):
        raise PatchError(f"Más de una ocurrencia de {field}[] dentro del bloque de id={entity_id} — ambiguo, abortando.")

    new_inner = ",".join(_format_number(v) for v in new_values)
    new_field_text = f"{field}[]={{{new_inner}}};"
    new_block_text = block_text[:match.start()] + new_field_text + block_text[match.end():]
    return text[:block_start] + new_block_text + text[block_end:]


def _format_number(value: float) -> str:
    if float(value).is_integer():
        return str(int(value))
    return repr(float(value))


@dataclass
class PatchResult:
    ok: bool
    backup_path: str
    draft_path: str
    entity_id: int
    field: str
    old_value: object
    new_value: object
    entities_before: int
    entities_after: int
    unrelated_entities_changed: list[str]


def apply_patch(mission_sqm: Path, hemtt_exe: Optional[str], entity_id: int, field: str, value,
                 draft_output: Path, backup_dir: Path) -> PatchResult:
    if field in ARRAY_FIELD_PATTERN:
        patch_fn = patch_array_field
    elif field in SCALAR_FIELD_PATTERN:
        patch_fn = patch_scalar_field
    else:
        raise PatchError(f"Campo no soportado: {field}. Soportados: {sorted(ARRAY_FIELD_PATTERN)} (array), "
                          f"{sorted(SCALAR_FIELD_PATTERN)} (escalar).")

    raw = mission_sqm.read_bytes()
    is_rapified = raw[:4] == b"\0raP"
    if is_rapified:
        original_text_data = derapify_if_needed(mission_sqm, hemtt_exe)
        # derapify_if_needed ya nos da un dict (vía HEMTT JSON); para el parche de texto
        # necesitamos el texto plano equivalente, así que regeneramos con armaclass a
        # partir de ese dict SOLO como línea base de partida (no como resultado final:
        # el parche real ocurre después, sobre texto, con find_entity_block_span).
        base_text = armaclass.generate(original_text_data)
    else:
        base_text = raw.decode("utf-8-sig", errors="replace")

    data_before = armaclass.parse(base_text)
    entities_root_before = data_before.get("Mission", data_before).get("Entities", {})
    entities_before = flatten_entities(entities_root_before)
    if not any(e["id"] == entity_id for e in entities_before):
        raise PatchError(f"No existe ninguna entidad con id={entity_id} en mission.sqm.")
    old_value = read_field_value(base_text, entity_id, field)

    patched_text = patch_fn(base_text, entity_id, field, value)

    data_after = armaclass.parse(patched_text)
    entities_root_after = data_after.get("Mission", data_after).get("Entities", {})
    entities_after = flatten_entities(entities_root_after)

    # Comparación sobre el subárbol crudo completo (no la proyección reducida de
    # sqm_inspect): así un cambio colateral en CUALQUIER campo de otra entidad
    # (skill, fuel, text... no solo name/init/position) se detecta igual.
    raw_before_by_id = _index_raw_entities_by_id(entities_root_before)
    raw_after_by_id = _index_raw_entities_by_id(entities_root_after)
    unrelated_changed: list[str] = []
    for eid, before_node in raw_before_by_id.items():
        if eid == entity_id:
            continue
        if raw_after_by_id.get(eid) != before_node:
            unrelated_changed.append(f"id={eid}")

    backup_dir.mkdir(parents=True, exist_ok=True)
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    backup_path = backup_dir / f"mission.sqm.{timestamp}.bak"
    backup_path.write_bytes(raw)

    # newline="" evita que Python traduzca los \r\n ya literales del texto original
    # (leído como bytes) al escribirlos de nuevo — si no, cada línea queda con \r\r\n.
    draft_output.write_text(patched_text, encoding="utf-8", newline="")

    new_value = read_field_value(patched_text, entity_id, field)

    return PatchResult(
        ok=len(unrelated_changed) == 0 and len(entities_before) == len(entities_after),
        backup_path=str(backup_path),
        draft_path=str(draft_output),
        entity_id=entity_id,
        field=field,
        old_value=old_value,
        new_value=new_value,
        entities_before=len(entities_before),
        entities_after=len(entities_after),
        unrelated_entities_changed=unrelated_changed,
    )


@dataclass
class AddResult:
    ok: bool
    backup_path: str
    draft_path: str
    new_entity_id: int
    entities_before: int
    entities_after: int
    unrelated_entities_changed: list[str]


def apply_add_object_entity(mission_sqm: Path, hemtt_exe: Optional[str], classname: str, position: list[float],
                             side: Optional[str], angles: Optional[list[float]], name: Optional[str],
                             init: Optional[str], skill: Optional[float],
                             draft_output: Path, backup_dir: Path) -> AddResult:
    raw = mission_sqm.read_bytes()
    is_rapified = raw[:4] == b"\0raP"
    if is_rapified:
        original_text_data = derapify_if_needed(mission_sqm, hemtt_exe)
        base_text = armaclass.generate(original_text_data)
    else:
        base_text = raw.decode("utf-8-sig", errors="replace")

    data_before = armaclass.parse(base_text)
    entities_root_before = data_before.get("Mission", data_before).get("Entities", {})
    entities_before = flatten_entities(entities_root_before)

    patched_text, new_id = add_object_entity(base_text, data_before, classname, position,
                                              side=side, angles=angles, name=name, init=init, skill=skill)

    try:
        data_after = armaclass.parse(patched_text)
    except Exception as e:
        # El texto insertado dejó el archivo sintácticamente inválido — no se
        # escribe nada (ni backup ni borrador) y se reporta como fallo de
        # validación, no como un traceback opaco.
        raise PatchError(f"El resultado no es un mission.sqm válido tras insertar la entidad: {e}") from e
    entities_root_after = data_after.get("Mission", data_after).get("Entities", {})
    entities_after = flatten_entities(entities_root_after)

    # Misma comparación de subárbol completo que apply_patch: cualquier cambio
    # colateral en cualquier campo de cualquier entidad EXISTENTE se detecta.
    raw_before_by_id = _index_raw_entities_by_id(entities_root_before)
    raw_after_by_id = _index_raw_entities_by_id(entities_root_after)
    unrelated_changed: list[str] = []
    for eid, before_node in raw_before_by_id.items():
        if raw_after_by_id.get(eid) != before_node:
            unrelated_changed.append(f"id={eid}")

    new_entity = next((e for e in entities_after if e["id"] == new_id), None)
    if new_entity is None:
        raise PatchError(f"La entidad recién insertada (id={new_id}) no aparece al re-parsear el resultado — "
                          "abortando sin tocar el archivo real.")

    backup_dir.mkdir(parents=True, exist_ok=True)
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    backup_path = backup_dir / f"mission.sqm.{timestamp}.bak"
    backup_path.write_bytes(raw)
    draft_output.write_text(patched_text, encoding="utf-8", newline="")

    return AddResult(
        ok=(len(unrelated_changed) == 0 and len(entities_after) == len(entities_before) + 1),
        backup_path=str(backup_path),
        draft_path=str(draft_output),
        new_entity_id=new_id,
        entities_before=len(entities_before),
        entities_after=len(entities_after),
        unrelated_entities_changed=unrelated_changed,
    )


def _main_patch_field(args) -> int:
    if args.field in ARRAY_FIELD_PATTERN:
        value = [float(v) for v in args.value.split(",")]
    elif SCALAR_FIELD_TYPES.get(args.field) == "number":
        value = float(args.value)
    else:
        value = args.value

    try:
        result = apply_patch(args.mission_sqm, args.hemtt, args.entity_id, args.field, value,
                              args.draft_output, args.backup_dir)
    except PatchError as e:
        print(json.dumps({"ok": False, "error": str(e)}, ensure_ascii=False))
        return 1

    print(json.dumps(result.__dict__, ensure_ascii=False))
    return 0 if result.ok else 1


def _main_add_object(args) -> int:
    position = [float(v) for v in args.position.split(",")]
    angles = [float(v) for v in args.angles.split(",")] if args.angles else None
    skill = float(args.skill) if args.skill is not None else None

    try:
        result = apply_add_object_entity(args.mission_sqm, args.hemtt, args.classname, position,
                                          args.side, angles, args.name, args.init, skill,
                                          args.draft_output, args.backup_dir)
    except PatchError as e:
        print(json.dumps({"ok": False, "error": str(e)}, ensure_ascii=False))
        return 1

    print(json.dumps(result.__dict__, ensure_ascii=False))
    return 0 if result.ok else 1


def main() -> int:
    import argparse
    all_fields = sorted(ARRAY_FIELD_PATTERN) + sorted(SCALAR_FIELD_PATTERN)
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--mission-sqm", required=True, type=Path)
    parser.add_argument("--hemtt", default=None)
    parser.add_argument("--draft-output", required=True, type=Path)
    parser.add_argument("--backup-dir", required=True, type=Path)
    subparsers = parser.add_subparsers(dest="op", required=True)

    patch_parser = subparsers.add_parser("patch_field")
    patch_parser.add_argument("--entity-id", required=True, type=int)
    patch_parser.add_argument("--field", required=True, choices=all_fields)
    patch_parser.add_argument("--value", required=True,
                               help="position/angles: 3 números coma-separados (ej: 1234.5,6.0,789.1). "
                                    "Campos numéricos escalares (skill/fuel/healthLevel/damage): un número. "
                                    "Campos de texto (name/text): el texto tal cual.")

    add_parser = subparsers.add_parser("add_object")
    add_parser.add_argument("--classname", required=True)
    add_parser.add_argument("--position", required=True, help="3 números coma-separados: x,y,z")
    add_parser.add_argument("--side", default=None)
    add_parser.add_argument("--angles", default=None, help="3 números coma-separados, opcional")
    add_parser.add_argument("--name", default=None, help="Nombre de variable de la entidad, opcional")
    add_parser.add_argument("--init", default=None, help="Código init, opcional")
    add_parser.add_argument("--skill", default=None, help="Skill de IA (0-1), opcional")

    args = parser.parse_args()
    if args.op == "patch_field":
        return _main_patch_field(args)
    return _main_add_object(args)


if __name__ == "__main__":
    sys.exit(main())
