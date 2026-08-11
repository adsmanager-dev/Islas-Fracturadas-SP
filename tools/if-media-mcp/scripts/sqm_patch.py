#!/usr/bin/env python3
"""
Parche quirúrgico de mission.sqm: cambia SOLO position[]/angles[] de una entidad
existente (localizada por su `id` nativo, único en todo el archivo — verificado
contra AI_REFERENCES/A3-Antistasi: 1561 entidades, 1561 IDs únicos). El resto del
archivo queda byte-por-byte idéntico — no es un parseo-completo→regenerar-completo
(eso reformatea el archivo entero, ver EVALUATION.md 2026-08-08).

También añade entidades nuevas: `add_object_entity` anexa un Object al bloque
raíz, `add_empty_layer` crea una Layer raíz vacía y
`add_logic_entities_to_layer` inserta de forma atómica una o más Logic en una
Layer existente identificada por nombre. Marker/Group todavía no se crean.
Investigación previa (2026-08-08, ver EVALUATION.md) confirmó
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
import hashlib
import math
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


def _find_layer_by_name(data: dict, layer_name: str) -> dict:
    """Localiza una única Layer por su `name` directo, incluso si está anidada."""
    matches: list[dict] = []

    def walk(node):
        if not isinstance(node, dict):
            return
        if node.get("dataType") == "Layer" and node.get("name") == layer_name:
            matches.append(node)
        nested = node.get("Entities")
        if isinstance(nested, dict):
            for key, value in nested.items():
                if key.startswith("Item"):
                    walk(value)

    root = data.get("Mission", data).get("Entities", {})
    walk({"Entities": root})
    if not matches:
        raise PatchError(f'No existe una Layer llamada "{layer_name}".')
    if len(matches) > 1:
        raise PatchError(f'La Layer "{layer_name}" aparece {len(matches)} veces; el destino es ambiguo.')
    return matches[0]


def _find_direct_class_span(text: str, container_start: int, container_end: int,
                            class_name: str) -> Optional[tuple[int, int]]:
    """Busca `class <class_name>` como hijo directo del bloque `{...}` indicado.

    Devuelve el rango desde `class` hasta el `;` final. La búsqueda por profundidad
    evita confundir Entities descendientes con el contenedor directo de una Layer.
    """
    depth = 1
    i = container_start + 1
    class_kw = None
    class_open = None
    pattern = re.compile(rf"class\s+{re.escape(class_name)}\b\s*\{{")
    while i < container_end:
        if depth == 1:
            match = pattern.match(text, i)
            if match:
                class_kw = i
                class_open = match.end() - 1
                break
        if text[i] == "{":
            depth += 1
        elif text[i] == "}":
            depth -= 1
        i += 1
    if class_open is None:
        return None

    depth = 0
    i = class_open
    while i < container_end:
        if text[i] == "{":
            depth += 1
        elif text[i] == "}":
            depth -= 1
            if depth == 0:
                end = i + 1
                while end < container_end and text[end] in " \t":
                    end += 1
                if end < container_end and text[end] == ";":
                    end += 1
                return class_kw, end
        i += 1
    raise PatchError(f"No se encontró el cierre de class {class_name}.")


def _indent_unit_for_block(text: str, block_start: int, block_end: int) -> str:
    outer_indent = _line_indent(text, block_start)
    newline = _detect_newline(text)
    first_newline = text.find(newline, block_start, block_end)
    if first_newline != -1:
        inner_indent = _line_indent(text, first_newline + len(newline))
        if inner_indent.startswith(outer_indent) and len(inner_indent) > len(outer_indent):
            return inner_indent[len(outer_indent):]
    return "\t"


def _validate_logic_entries(entries: list[dict]) -> None:
    if not isinstance(entries, list) or not 1 <= len(entries) <= 50:
        raise PatchError("entries debe contener entre 1 y 50 lógicas.")
    names: list[str] = []
    for index, entry in enumerate(entries):
        if not isinstance(entry, dict):
            raise PatchError(f"entries[{index}] debe ser un objeto.")
        name = entry.get("name")
        position = entry.get("position_sqm")
        if not isinstance(name, str) or not name or len(name) > 120:
            raise PatchError(f"entries[{index}].name debe tener entre 1 y 120 caracteres.")
        if not re.fullmatch(r"IF_[A-Za-z0-9_]+", name):
            raise PatchError(f'Nombre no permitido: "{name}"; debe usar el prefijo IF_ y solo letras, números o _.')
        if not isinstance(position, list) or len(position) != 3:
            raise PatchError(f"entries[{index}].position_sqm debe ser [x,elevación,y].")
        if any(isinstance(value, bool) or not isinstance(value, (int, float))
               or not math.isfinite(float(value)) for value in position):
            raise PatchError(f"entries[{index}].position_sqm contiene un valor no numérico o no finito.")
        names.append(name)
    if len(set(names)) != len(names):
        raise PatchError("Los nombres solicitados para las lógicas no son únicos.")


def _validate_layer_name(layer_name: str) -> None:
    if not isinstance(layer_name, str) or not re.fullmatch(r"IF_[A-Za-z0-9_]+", layer_name):
        raise PatchError("layer_name debe usar el prefijo IF_ y solo letras, números o _.")
    if len(layer_name) > 120:
        raise PatchError("layer_name no puede superar 120 caracteres.")


def add_empty_layer(text: str, data: dict, layer_name: str,
                    atl_offset: float = 0.0) -> tuple[str, int]:
    """Añade una Layer vacía como última entidad del bloque Entities raíz.

    No crea implícitamente puntos ni rutas: sirve para preparar una capa estable
    antes de que 3DEN aporte coordenadas observadas. Conserva un nextID ya más
    alto (Eden puede reservar IDs editoriales) y solo lo incrementa si hace falta.
    """
    _validate_layer_name(layer_name)
    if isinstance(atl_offset, bool) or not isinstance(atl_offset, (int, float)) or not math.isfinite(float(atl_offset)):
        raise PatchError("atl_offset debe ser un número finito.")
    try:
        _find_layer_by_name(data, layer_name)
    except PatchError as error:
        if not str(error).startswith("No existe una Layer"):
            raise
    else:
        raise PatchError(f'Ya existe una Layer llamada "{layer_name}".')

    root_start, root_end = _find_root_entities_span(text)
    root_block = text[root_start:root_end]
    items_match = re.search(r"\bitems\s*=\s*(\d+)\s*;", root_block)
    if not items_match:
        raise PatchError("El bloque Entities raíz no declara items=N.")
    declared_items = int(items_match.group(1))
    if declared_items == 0:
        raise PatchError("El bloque Entities raíz vacío no ofrece una entidad hermana para copiar indentación.")
    root_entities = data.get("Mission", data).get("Entities", {})
    expected_keys = [f"Item{i}" for i in range(declared_items)]
    actual_keys = [key for key in root_entities if key.startswith("Item")]
    if actual_keys != expected_keys:
        raise PatchError(f"ItemN no es contiguo en la raíz: esperado {expected_keys}, recibido {actual_keys}.")

    last_node = root_entities.get(f"Item{declared_items - 1}")
    last_id = last_node.get("id") if isinstance(last_node, dict) else None
    if not isinstance(last_id, int):
        raise PatchError("La última entidad raíz no tiene id entero.")
    new_id = _max_entity_id(data) + 1
    if re.search(rf"\bid\s*=\s*{new_id}\s*;", text):
        raise PatchError(f"id={new_id} ya existe en el archivo.")

    last_start, insert_at = find_entity_block_span(text, last_id)
    while insert_at < len(text) and text[insert_at] in " \t":
        insert_at += 1
    if insert_at < len(text) and text[insert_at] == ";":
        insert_at += 1
    class_pos = text.rfind("class", root_start, last_start)
    if class_pos == -1:
        raise PatchError("No se localizó class ItemN de la última entidad raíz.")
    newline = _detect_newline(text)
    outer_indent = _line_indent(text, class_pos)
    indent_unit = _indent_unit_for_block(text, last_start, insert_at)
    inner_indent = outer_indent + indent_unit
    escaped_name = layer_name.replace('"', '""')
    block = newline.join([
        f"{outer_indent}class Item{declared_items}",
        f"{outer_indent}{{",
        f'{inner_indent}dataType="Layer";',
        f'{inner_indent}name="{escaped_name}";',
        f"{inner_indent}id={new_id};",
        f"{inner_indent}atlOffset={_format_number(float(atl_offset))};",
        f"{outer_indent}}};",
    ])
    patched_text = text[:insert_at] + newline + block + text[insert_at:]
    items_start = root_start + items_match.start()
    items_end = root_start + items_match.end()
    patched_text = patched_text[:items_start] + f"items={declared_items + 1};" + patched_text[items_end:]

    next_id_match = re.search(r"\bnextID\s*=\s*(\d+)\s*;", patched_text)
    if next_id_match and int(next_id_match.group(1)) <= new_id:
        patched_text = (patched_text[:next_id_match.start()]
                        + f"nextID={new_id + 1};"
                        + patched_text[next_id_match.end():])
    return patched_text, new_id


def _build_logic_item(index: int, entity_id: int, entry: dict, outer_indent: str,
                      indent_unit: str, newline: str) -> str:
    inner_indent = outer_indent + indent_unit
    nested_indent = inner_indent + indent_unit
    escaped_name = entry["name"].replace('"', '""')
    position = entry["position_sqm"]
    lines = [
        f"{outer_indent}class Item{index}",
        f"{outer_indent}{{",
        f'{inner_indent}dataType="Logic";',
        f"{inner_indent}class PositionInfo",
        f"{inner_indent}{{",
        f"{nested_indent}position[]={{{','.join(_format_number(float(v)) for v in position)}}};",
        f"{inner_indent}}};",
        f'{inner_indent}name="{escaped_name}";',
        f"{inner_indent}id={entity_id};",
        f'{inner_indent}type="Logic";',
        f"{outer_indent}}};",
    ]
    return newline.join(lines)


def add_logic_entities_to_layer(text: str, data: dict, layer_name: str,
                                entries: list[dict]) -> tuple[str, list[int]]:
    """Inserta Logic como últimos ItemN de una Layer existente, sin tocar el
    contador `items` raíz ni crear la Layer implícitamente."""
    _validate_logic_entries(entries)
    layer = _find_layer_by_name(data, layer_name)
    layer_id = layer.get("id")
    if not isinstance(layer_id, int):
        raise PatchError(f'La Layer "{layer_name}" no tiene un id entero.')

    existing_names = {
        entity["name"] for entity in flatten_entities(data.get("Mission", data).get("Entities", {}))
        if isinstance(entity.get("name"), str)
    }
    collisions = sorted(existing_names.intersection(entry["name"] for entry in entries))
    if collisions:
        raise PatchError(f"Ya existen entidades con estos nombres: {collisions}.")

    max_id = _max_entity_id(data)
    new_ids = list(range(max_id + 1, max_id + 1 + len(entries)))
    for entity_id in new_ids:
        if re.search(rf"\bid\s*=\s*{entity_id}\s*;", text):
            raise PatchError(f"id={entity_id} ya existe en el archivo.")

    layer_start, layer_end = find_entity_block_span(text, layer_id)
    newline = _detect_newline(text)
    layer_indent = _line_indent(text, layer_start)
    indent_unit = _indent_unit_for_block(text, layer_start, layer_end)
    layer_field_indent = layer_indent + indent_unit
    entities_span = _find_direct_class_span(text, layer_start, layer_end, "Entities")
    nested = layer.get("Entities")

    if entities_span is None:
        if nested is not None:
            raise PatchError("El árbol parseado contiene Entities en la Layer, pero el texto no permite localizarlo.")
        id_match = re.search(rf"\bid\s*=\s*{layer_id}\s*;", text[layer_start:layer_end])
        if not id_match:
            raise PatchError(f"No se localizó id={layer_id} dentro de su propia Layer.")
        id_position = layer_start + id_match.start()
        insert_at = text.rfind(newline, layer_start, id_position) + len(newline)
        item_indent = layer_field_indent + indent_unit
        item_blocks = [
            _build_logic_item(i, entity_id, entry, item_indent, indent_unit, newline)
            for i, (entity_id, entry) in enumerate(zip(new_ids, entries))
        ]
        entities_lines = [
            f"{layer_field_indent}class Entities",
            f"{layer_field_indent}{{",
            f"{item_indent}items={len(entries)};",
            *item_blocks,
            f"{layer_field_indent}}};",
        ]
        patched_text = text[:insert_at] + newline.join(entities_lines) + newline + text[insert_at:]
    else:
        if not isinstance(nested, dict):
            raise PatchError("La Layer declara Entities en texto, pero no produce un contenedor parseado.")
        entities_start, entities_end = entities_span
        entities_block = text[entities_start:entities_end]
        items_match = re.search(r"\bitems\s*=\s*(\d+)\s*;", entities_block)
        if not items_match:
            raise PatchError("El bloque Entities de la Layer no declara items=N.")
        declared_items = int(items_match.group(1))
        expected_keys = [f"Item{i}" for i in range(declared_items)]
        actual_keys = [key for key in nested if key.startswith("Item")]
        if actual_keys != expected_keys:
            raise PatchError(f"ItemN no es contiguo en la Layer: esperado {expected_keys}, recibido {actual_keys}.")

        item_indent = _line_indent(text, entities_start) + indent_unit
        item_blocks = [
            _build_logic_item(declared_items + i, entity_id, entry, item_indent, indent_unit, newline)
            for i, (entity_id, entry) in enumerate(zip(new_ids, entries))
        ]
        if declared_items == 0:
            items_abs_end = entities_start + items_match.end()
            insert_at = items_abs_end
        else:
            last_node = nested[f"Item{declared_items - 1}"]
            last_id = last_node.get("id") if isinstance(last_node, dict) else None
            if not isinstance(last_id, int):
                raise PatchError(f"Item{declared_items - 1} de la Layer no tiene id entero.")
            _, insert_at = find_entity_block_span(text, last_id)
            while insert_at < len(text) and text[insert_at] in " \t":
                insert_at += 1
            if insert_at < len(text) and text[insert_at] == ";":
                insert_at += 1
        patched_text = text[:insert_at] + newline + newline.join(item_blocks) + text[insert_at:]
        items_abs_start = entities_start + items_match.start()
        items_abs_end = entities_start + items_match.end()
        patched_text = (patched_text[:items_abs_start]
                        + f"items={declared_items + len(entries)};"
                        + patched_text[items_abs_end:])

    next_id_match = re.search(r"\bnextID\s*=\s*(\d+)\s*;", patched_text)
    required_next_id = new_ids[-1] + 1
    if next_id_match and int(next_id_match.group(1)) < required_next_id:
        patched_text = (patched_text[:next_id_match.start()]
                        + f"nextID={required_next_id};"
                        + patched_text[next_id_match.end():])
    return patched_text, new_ids


def _validate_logic_name_assignments(entries: list[dict]) -> None:
    if not isinstance(entries, list) or not 1 <= len(entries) <= 50:
        raise PatchError("entries debe contener entre 1 y 50 asignaciones de nombre.")
    ids: list[int] = []
    names: list[str] = []
    for index, entry in enumerate(entries):
        if not isinstance(entry, dict):
            raise PatchError(f"entries[{index}] debe ser un objeto.")
        entity_id = entry.get("entity_id")
        name = entry.get("name")
        if isinstance(entity_id, bool) or not isinstance(entity_id, int) or entity_id < 0:
            raise PatchError(f"entries[{index}].entity_id debe ser un entero no negativo.")
        if not isinstance(name, str) or not re.fullmatch(r"IF_[A-Za-z0-9_]+", name) or len(name) > 120:
            raise PatchError(f'Nombre no permitido en entries[{index}]: "{name}".')
        ids.append(entity_id)
        names.append(name)
    if len(ids) != len(set(ids)):
        raise PatchError("Los IDs solicitados no son únicos.")
    if len(names) != len(set(names)):
        raise PatchError("Los nombres solicitados no son únicos.")


def name_logic_entities_in_layer(text: str, data: dict, layer_name: str,
                                 entries: list[dict]) -> str:
    """Añade el campo directo `name` que 3DEN conserva en entidades Logic ya
    existentes y sin nombre, restringidas a una Layer concreta."""
    _validate_logic_name_assignments(entries)
    layer = _find_layer_by_name(data, layer_name)
    nested = layer.get("Entities")
    if not isinstance(nested, dict):
        raise PatchError(f'La Layer "{layer_name}" no contiene Entities.')

    direct_by_id: dict[int, dict] = {}
    for key, entity in nested.items():
        if not key.startswith("Item") or not isinstance(entity, dict):
            continue
        entity_id = entity.get("id")
        if isinstance(entity_id, int):
            direct_by_id[entity_id] = entity

    target_ids = {entry["entity_id"] for entry in entries}
    existing_names = {
        entity["name"] for entity in flatten_entities(data.get("Mission", data).get("Entities", {}))
        if isinstance(entity.get("name"), str) and entity.get("id") not in target_ids
    }
    collisions = sorted(existing_names.intersection(entry["name"] for entry in entries))
    if collisions:
        raise PatchError(f"Ya existen otras entidades con estos nombres: {collisions}.")

    patched_text = text
    newline = _detect_newline(text)
    for entry in entries:
        entity_id = entry["entity_id"]
        entity = direct_by_id.get(entity_id)
        if entity is None:
            raise PatchError(f'id={entity_id} no es hija directa de la Layer "{layer_name}".')
        if entity.get("dataType") != "Logic" or entity.get("type") != "Logic":
            raise PatchError(f"id={entity_id} no es una Logic genérica (dataType/type Logic).")
        if isinstance(entity.get("name"), str):
            raise PatchError(f"id={entity_id} ya tiene un nombre directo; no se sobrescribirá.")
        attrs = entity.get("Attributes")
        if isinstance(attrs, dict) and isinstance(attrs.get("name"), str):
            raise PatchError(f"id={entity_id} todavía tiene Attributes.name; requiere migración explícita.")

        block_start, block_end = find_entity_block_span(patched_text, entity_id)
        block_text = patched_text[block_start:block_end]
        id_match = re.search(rf"(?m)^([ \t]*)id\s*=\s*{entity_id}\s*;", block_text)
        if not id_match:
            raise PatchError(f"No se localizó la línea directa id={entity_id} para insertar su nombre.")
        indent = id_match.group(1)
        escaped_name = entry["name"].replace('"', '""')
        insert_at = block_start + id_match.start()
        patched_text = (patched_text[:insert_at]
                        + f'{indent}name="{escaped_name}";{newline}'
                        + patched_text[insert_at:])
    return patched_text


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
    if declared_items == 1:
        raise PatchError("v1 no borra la única entidad restante del bloque raíz — dejaría el bloque vacío, "
                          "el mismo caso límite que add_object_entity tampoco soporta al revés (sin una entidad "
                          "hermana de referencia, no hay un punto de anclaje seguro para el borrado).")

    last_index = declared_items - 1
    root_entities = data.get("Mission", data)["Entities"]
    last_sibling = root_entities.get(f"Item{last_index}")
    last_sibling_id = last_sibling.get("id") if isinstance(last_sibling, dict) else None
    if last_sibling_id is None:
        raise PatchError(f"Item{last_index} del bloque raíz no tiene id — no se puede verificar de forma segura.")
    if last_sibling_id != entity_id:
        raise PatchError(f"id={entity_id} no es la ÚLTIMA entidad del bloque Entities raíz (esa es id={last_sibling_id}, "
                          f"Item{last_index}) — v1 solo borra la última, para no tener que renumerar las posteriores.")

    _, block_end = find_entity_block_span(text, entity_id)
    k = block_end
    while k < len(text) and text[k] in " \t":
        k += 1
    if k < len(text) and text[k] == ";":
        block_end = k + 1

    # Se borra desde el final de la entidad ANTERIOR (inclusive su ';'), no desde
    # el inicio de la línea de la entidad a borrar — así se elimina exactamente el
    # mismo tramo "\n + bloque" que add_object_entity insertó (el salto de línea
    # que separa a las entidades pertenece lógicamente a la entidad borrada, no a
    # la anterior). Anclar en el inicio de línea de la propia entidad, en cambio,
    # dejaba huérfano ese salto de línea — encontrado en la prueba real de
    # ida-y-vuelta añadir+borrar contra Antistasi (sobraba una línea en blanco).
    prev_sibling = root_entities.get(f"Item{last_index - 1}")
    prev_sibling_id = prev_sibling.get("id") if isinstance(prev_sibling, dict) else None
    if prev_sibling_id is None:
        raise PatchError(f"Item{last_index - 1} del bloque raíz no tiene id — no se puede usar como referencia.")
    _, remove_from = find_entity_block_span(text, prev_sibling_id)
    k2 = remove_from
    while k2 < len(text) and text[k2] in " \t":
        k2 += 1
    if k2 < len(text) and text[k2] == ";":
        remove_from = k2 + 1

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


@dataclass
class AddLayerLogicsResult:
    ok: bool
    backup_path: str
    backup_sha256: str
    draft_path: str
    layer_name: str
    layer_id: int
    new_entity_ids: list[int]
    new_entity_names: list[str]
    entities_before: int
    entities_after: int
    layer_items_before: int
    layer_items_after: int
    root_items_before: int
    root_items_after: int
    unrelated_entities_changed: list[str]


@dataclass
class NameLayerLogicsResult:
    ok: bool
    backup_path: str
    backup_sha256: str
    draft_path: str
    layer_name: str
    layer_id: int
    named_entity_ids: list[int]
    named_entity_names: list[str]
    entities_before: int
    entities_after: int
    layer_items_before: int
    layer_items_after: int
    root_items_before: int
    root_items_after: int
    unrelated_entities_changed: list[str]


def apply_add_logic_entities_to_layer(mission_sqm: Path, hemtt_exe: Optional[str],
                                      layer_name: str, entries: list[dict],
                                      draft_output: Path, backup_dir: Path) -> AddLayerLogicsResult:
    raw = mission_sqm.read_bytes()
    is_rapified = raw[:4] == b"\0raP"
    if is_rapified:
        original_text_data = derapify_if_needed(mission_sqm, hemtt_exe)
        base_text = armaclass.generate(original_text_data)
    else:
        base_text = raw.decode("utf-8-sig", errors="replace")

    data_before = armaclass.parse(base_text)
    root_before = data_before.get("Mission", data_before).get("Entities", {})
    entities_before = flatten_entities(root_before)
    layer_before = _find_layer_by_name(data_before, layer_name)
    nested_before = layer_before.get("Entities", {})
    layer_items_before = int(nested_before.get("items", 0)) if isinstance(nested_before, dict) else 0
    root_items_before = int(root_before.get("items", 0))

    patched_text, new_ids = add_logic_entities_to_layer(base_text, data_before, layer_name, entries)
    try:
        data_after = armaclass.parse(patched_text)
    except Exception as error:
        raise PatchError(f"El resultado no es un mission.sqm válido tras insertar las lógicas: {error}") from error

    root_after = data_after.get("Mission", data_after).get("Entities", {})
    entities_after = flatten_entities(root_after)
    layer_after = _find_layer_by_name(data_after, layer_name)
    nested_after = layer_after.get("Entities")
    if not isinstance(nested_after, dict):
        raise PatchError("La Layer de destino no contiene Entities después de la inserción.")
    layer_items_after = int(nested_after.get("items", -1))
    root_items_after = int(root_after.get("items", -1))

    expected_layer_items = layer_items_before + len(entries)
    expected_keys = [f"Item{i}" for i in range(expected_layer_items)]
    actual_keys = [key for key in nested_after if key.startswith("Item")]
    if layer_items_after != expected_layer_items or actual_keys != expected_keys:
        raise PatchError("items/ItemN de la Layer no quedaron contiguos tras la inserción.")
    if root_items_after != root_items_before:
        raise PatchError("El contador items del bloque raíz cambió al insertar dentro de una Layer.")

    raw_before_by_id = _index_raw_entities_by_id(root_before)
    raw_after_by_id = _index_raw_entities_by_id(root_after)
    unrelated_changed = [
        f"id={entity_id}" for entity_id, before_node in raw_before_by_id.items()
        if raw_after_by_id.get(entity_id) != before_node
    ]

    all_ids = [entity["id"] for entity in entities_after if isinstance(entity.get("id"), int)]
    if len(all_ids) != len(set(all_ids)):
        raise PatchError("El resultado contiene IDs de entidad duplicados.")
    new_entities = [entity for entity in entities_after if entity.get("id") in new_ids]
    expected_names = [entry["name"] for entry in entries]
    actual_names = [entity.get("name") for entity in new_entities]
    if (any(not isinstance(name, str) for name in actual_names)
            or sorted(actual_names) != sorted(expected_names)):
        raise PatchError("Las lógicas insertadas no reaparecen con los nombres esperados al reparsear.")
    if any(entity.get("data_type") != "Logic" or entity.get("type") != "Logic"
           for entity in new_entities):
        raise PatchError("Una entidad nueva no conservó dataType/type Logic tras el round-trip.")

    provider_before = data_before.get("EditorData", {}).get("ItemIDProvider", {})
    provider_after = data_after.get("EditorData", {}).get("ItemIDProvider", {})
    if isinstance(provider_before, dict) and isinstance(provider_before.get("nextID"), int):
        expected_next_id = max(provider_before["nextID"], max(all_ids) + 1)
        if not isinstance(provider_after, dict) or provider_after.get("nextID") != expected_next_id:
            raise PatchError(f"ItemIDProvider.nextID no quedó en {expected_next_id}.")

    backup_dir.mkdir(parents=True, exist_ok=True)
    backup_sha256 = hashlib.sha256(raw).hexdigest().upper()
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ")
    backup_path = backup_dir / f"mission.sqm.{timestamp}.{backup_sha256[:12]}.bak"
    backup_path.write_bytes(raw)
    draft_output.write_text(patched_text, encoding="utf-8", newline="")

    return AddLayerLogicsResult(
        ok=(not unrelated_changed
            and len(entities_after) == len(entities_before) + len(entries)
            and len(new_entities) == len(entries)),
        backup_path=str(backup_path),
        backup_sha256=backup_sha256,
        draft_path=str(draft_output),
        layer_name=layer_name,
        layer_id=layer_before["id"],
        new_entity_ids=new_ids,
        new_entity_names=expected_names,
        entities_before=len(entities_before),
        entities_after=len(entities_after),
        layer_items_before=layer_items_before,
        layer_items_after=layer_items_after,
        root_items_before=root_items_before,
        root_items_after=root_items_after,
        unrelated_entities_changed=unrelated_changed,
    )


def apply_name_logic_entities_in_layer(mission_sqm: Path, hemtt_exe: Optional[str],
                                       layer_name: str, entries: list[dict],
                                       draft_output: Path, backup_dir: Path) -> NameLayerLogicsResult:
    _validate_logic_name_assignments(entries)
    raw = mission_sqm.read_bytes()
    is_rapified = raw[:4] == b"\0raP"
    if is_rapified:
        original_text_data = derapify_if_needed(mission_sqm, hemtt_exe)
        base_text = armaclass.generate(original_text_data)
    else:
        base_text = raw.decode("utf-8-sig", errors="replace")

    data_before = armaclass.parse(base_text)
    root_before = data_before.get("Mission", data_before).get("Entities", {})
    entities_before = flatten_entities(root_before)
    layer_before = _find_layer_by_name(data_before, layer_name)
    nested_before = layer_before.get("Entities")
    if not isinstance(nested_before, dict):
        raise PatchError(f'La Layer "{layer_name}" no contiene Entities.')
    layer_items_before = int(nested_before.get("items", 0))
    root_items_before = int(root_before.get("items", 0))
    target_ids = [entry["entity_id"] for entry in entries]

    patched_text = name_logic_entities_in_layer(base_text, data_before, layer_name, entries)
    try:
        data_after = armaclass.parse(patched_text)
    except Exception as error:
        raise PatchError(f"El resultado no es un mission.sqm válido tras nombrar las lógicas: {error}") from error

    root_after = data_after.get("Mission", data_after).get("Entities", {})
    entities_after = flatten_entities(root_after)
    layer_after = _find_layer_by_name(data_after, layer_name)
    nested_after = layer_after.get("Entities")
    if not isinstance(nested_after, dict):
        raise PatchError("La Layer perdió su bloque Entities tras nombrar las lógicas.")
    layer_items_after = int(nested_after.get("items", -1))
    root_items_after = int(root_after.get("items", -1))

    if len(entities_after) != len(entities_before):
        raise PatchError("El número total de entidades cambió al nombrar lógicas existentes.")
    if layer_items_after != layer_items_before or root_items_after != root_items_before:
        raise PatchError("Un contador items cambió al nombrar lógicas existentes.")

    raw_before_by_id = _index_raw_entities_by_id(root_before)
    raw_after_by_id = _index_raw_entities_by_id(root_after)
    unrelated_changed = [
        f"id={entity_id}" for entity_id, before_node in raw_before_by_id.items()
        if entity_id not in target_ids and raw_after_by_id.get(entity_id) != before_node
    ]
    for entry in entries:
        entity_id = entry["entity_id"]
        before_node = raw_before_by_id.get(entity_id)
        after_node = raw_after_by_id.get(entity_id)
        if not isinstance(before_node, dict) or not isinstance(after_node, dict):
            raise PatchError(f"id={entity_id} no reapareció después del round-trip.")
        expected_after = dict(before_node)
        expected_after["name"] = entry["name"]
        if after_node != expected_after:
            raise PatchError(f"id={entity_id} cambió en algo distinto de su nombre directo.")

    all_ids_before = sorted(entity["id"] for entity in entities_before if isinstance(entity.get("id"), int))
    all_ids_after = sorted(entity["id"] for entity in entities_after if isinstance(entity.get("id"), int))
    if all_ids_after != all_ids_before or len(all_ids_after) != len(set(all_ids_after)):
        raise PatchError("Los IDs cambiaron o dejaron de ser únicos al nombrar las lógicas.")
    provider_before = data_before.get("EditorData", {}).get("ItemIDProvider", {})
    provider_after = data_after.get("EditorData", {}).get("ItemIDProvider", {})
    if provider_after != provider_before:
        raise PatchError("ItemIDProvider cambió al nombrar lógicas existentes.")

    backup_dir.mkdir(parents=True, exist_ok=True)
    backup_sha256 = hashlib.sha256(raw).hexdigest().upper()
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ")
    backup_path = backup_dir / f"mission.sqm.{timestamp}.{backup_sha256[:12]}.bak"
    backup_path.write_bytes(raw)
    draft_output.write_text(patched_text, encoding="utf-8", newline="")

    return NameLayerLogicsResult(
        ok=not unrelated_changed,
        backup_path=str(backup_path),
        backup_sha256=backup_sha256,
        draft_path=str(draft_output),
        layer_name=layer_name,
        layer_id=layer_before["id"],
        named_entity_ids=target_ids,
        named_entity_names=[entry["name"] for entry in entries],
        entities_before=len(entities_before),
        entities_after=len(entities_after),
        layer_items_before=layer_items_before,
        layer_items_after=layer_items_after,
        root_items_before=root_items_before,
        root_items_after=root_items_after,
        unrelated_entities_changed=unrelated_changed,
    )


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


@dataclass
class DeleteResult:
    ok: bool
    backup_path: str
    draft_path: str
    deleted_entity_id: int
    entities_before: int
    entities_after: int
    unrelated_entities_changed: list[str]


@dataclass
class AddLayerResult:
    ok: bool
    backup_path: str
    backup_sha256: str
    draft_path: str
    layer_name: str
    new_layer_id: int
    entities_before: int
    entities_after: int
    root_items_before: int
    root_items_after: int
    next_id_before: Optional[int]
    next_id_after: Optional[int]
    unrelated_entities_changed: list[str]


def apply_add_empty_layer(mission_sqm: Path, hemtt_exe: Optional[str], layer_name: str,
                          atl_offset: float, draft_output: Path,
                          backup_dir: Path) -> AddLayerResult:
    raw = mission_sqm.read_bytes()
    if raw[:4] == b"\0raP":
        base_text = armaclass.generate(derapify_if_needed(mission_sqm, hemtt_exe))
    else:
        base_text = raw.decode("utf-8-sig", errors="replace")
    data_before = armaclass.parse(base_text)
    root_before = data_before.get("Mission", data_before).get("Entities", {})
    entities_before = flatten_entities(root_before)
    root_items_before = int(root_before.get("items", -1))
    provider_before = data_before.get("EditorData", {}).get("ItemIDProvider", {})
    next_id_before = provider_before.get("nextID") if isinstance(provider_before, dict) else None

    patched_text, new_id = add_empty_layer(base_text, data_before, layer_name, atl_offset)
    try:
        data_after = armaclass.parse(patched_text)
    except Exception as error:
        raise PatchError(f"El resultado no es un mission.sqm válido tras crear la Layer: {error}") from error
    root_after = data_after.get("Mission", data_after).get("Entities", {})
    entities_after = flatten_entities(root_after)
    root_items_after = int(root_after.get("items", -1))
    layer_after = _find_layer_by_name(data_after, layer_name)
    if layer_after.get("id") != new_id or layer_after.get("dataType") != "Layer" or "Entities" in layer_after:
        raise PatchError("La nueva Layer no reaparece vacía y con el ID esperado tras el round-trip.")
    if root_items_after != root_items_before + 1:
        raise PatchError("items raíz no aumentó exactamente en uno al crear la Layer.")
    expected_keys = [f"Item{i}" for i in range(root_items_after)]
    if [key for key in root_after if key.startswith("Item")] != expected_keys:
        raise PatchError("ItemN raíz dejó de ser contiguo al crear la Layer.")

    before_by_id = _index_raw_entities_by_id(root_before)
    after_by_id = _index_raw_entities_by_id(root_after)
    unrelated_changed = [f"id={entity_id}" for entity_id, node in before_by_id.items()
                         if after_by_id.get(entity_id) != node]
    all_ids = [entity["id"] for entity in entities_after if isinstance(entity.get("id"), int)]
    if len(all_ids) != len(set(all_ids)):
        raise PatchError("El resultado contiene IDs de entidad duplicados.")
    provider_after = data_after.get("EditorData", {}).get("ItemIDProvider", {})
    next_id_after = provider_after.get("nextID") if isinstance(provider_after, dict) else None
    if isinstance(next_id_before, int) and next_id_after != max(next_id_before, new_id + 1):
        raise PatchError("ItemIDProvider.nextID no conservó su reserva o el siguiente ID requerido.")

    backup_dir.mkdir(parents=True, exist_ok=True)
    backup_sha256 = hashlib.sha256(raw).hexdigest().upper()
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ")
    backup_path = backup_dir / f"mission.sqm.{timestamp}.{backup_sha256[:12]}.bak"
    backup_path.write_bytes(raw)
    draft_output.write_text(patched_text, encoding="utf-8", newline="")
    return AddLayerResult(
        ok=(not unrelated_changed and len(entities_after) == len(entities_before) + 1),
        backup_path=str(backup_path), backup_sha256=backup_sha256,
        draft_path=str(draft_output), layer_name=layer_name, new_layer_id=new_id,
        entities_before=len(entities_before), entities_after=len(entities_after),
        root_items_before=root_items_before, root_items_after=root_items_after,
        next_id_before=next_id_before, next_id_after=next_id_after,
        unrelated_entities_changed=unrelated_changed,
    )


def apply_delete_entity(mission_sqm: Path, hemtt_exe: Optional[str], entity_id: int,
                         draft_output: Path, backup_dir: Path) -> DeleteResult:
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
    if not any(e["id"] == entity_id for e in entities_before):
        raise PatchError(f"No existe ninguna entidad con id={entity_id} en mission.sqm.")

    patched_text = delete_entity(base_text, data_before, entity_id)

    try:
        data_after = armaclass.parse(patched_text)
    except Exception as e:
        raise PatchError(f"El resultado no es un mission.sqm válido tras borrar la entidad: {e}") from e
    entities_root_after = data_after.get("Mission", data_after).get("Entities", {})
    entities_after = flatten_entities(entities_root_after)

    raw_before_by_id = _index_raw_entities_by_id(entities_root_before)
    raw_after_by_id = _index_raw_entities_by_id(entities_root_after)
    unrelated_changed: list[str] = []
    for eid, before_node in raw_before_by_id.items():
        if eid == entity_id:
            continue
        if raw_after_by_id.get(eid) != before_node:
            unrelated_changed.append(f"id={eid}")

    if any(e["id"] == entity_id for e in entities_after):
        raise PatchError(f"La entidad id={entity_id} sigue apareciendo tras el borrado — abortando sin tocar el archivo real.")

    backup_dir.mkdir(parents=True, exist_ok=True)
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    backup_path = backup_dir / f"mission.sqm.{timestamp}.bak"
    backup_path.write_bytes(raw)
    draft_output.write_text(patched_text, encoding="utf-8", newline="")

    return DeleteResult(
        ok=(len(unrelated_changed) == 0 and len(entities_after) == len(entities_before) - 1),
        backup_path=str(backup_path),
        draft_path=str(draft_output),
        deleted_entity_id=entity_id,
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


def _main_add_logics_to_layer(args) -> int:
    try:
        entries = json.loads(args.entries_json)
        result = apply_add_logic_entities_to_layer(
            args.mission_sqm, args.hemtt, args.layer_name, entries,
            args.draft_output, args.backup_dir,
        )
    except (json.JSONDecodeError, PatchError) as error:
        print(json.dumps({"ok": False, "error": str(error)}, ensure_ascii=False))
        return 1

    print(json.dumps(result.__dict__, ensure_ascii=False))
    return 0 if result.ok else 1


def _main_add_layer(args) -> int:
    try:
        result = apply_add_empty_layer(
            args.mission_sqm, args.hemtt, args.layer_name, args.atl_offset,
            args.draft_output, args.backup_dir,
        )
    except PatchError as error:
        print(json.dumps({"ok": False, "error": str(error)}, ensure_ascii=False))
        return 1
    print(json.dumps(result.__dict__, ensure_ascii=False))
    return 0 if result.ok else 1


def _main_name_logics_in_layer(args) -> int:
    try:
        entries = json.loads(args.entries_json)
        result = apply_name_logic_entities_in_layer(
            args.mission_sqm, args.hemtt, args.layer_name, entries,
            args.draft_output, args.backup_dir,
        )
    except (json.JSONDecodeError, PatchError) as error:
        print(json.dumps({"ok": False, "error": str(error)}, ensure_ascii=False))
        return 1

    print(json.dumps(result.__dict__, ensure_ascii=False))
    return 0 if result.ok else 1


def _main_delete_entity(args) -> int:
    try:
        result = apply_delete_entity(args.mission_sqm, args.hemtt, args.entity_id,
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

    add_logics_parser = subparsers.add_parser("add_logics_to_layer")
    add_logics_parser.add_argument("--layer-name", required=True)
    add_logics_parser.add_argument(
        "--entries-json", required=True,
        help='JSON: [{"name":"IF_...","position_sqm":[x,elevación,y]}]',
    )

    add_layer_parser = subparsers.add_parser("add_layer")
    add_layer_parser.add_argument("--layer-name", required=True)
    add_layer_parser.add_argument("--atl-offset", type=float, default=0.0)

    name_logics_parser = subparsers.add_parser("name_logics_in_layer")
    name_logics_parser.add_argument("--layer-name", required=True)
    name_logics_parser.add_argument(
        "--entries-json", required=True,
        help='JSON: [{"entity_id":7,"name":"IF_..."}]',
    )

    delete_parser = subparsers.add_parser("delete_entity")
    delete_parser.add_argument("--entity-id", required=True, type=int,
                                help="Debe ser la id de la ÚLTIMA entidad del bloque Entities raíz.")

    args = parser.parse_args()
    if args.op == "patch_field":
        return _main_patch_field(args)
    if args.op == "add_object":
        return _main_add_object(args)
    if args.op == "add_logics_to_layer":
        return _main_add_logics_to_layer(args)
    if args.op == "add_layer":
        return _main_add_layer(args)
    if args.op == "name_logics_in_layer":
        return _main_name_logics_in_layer(args)
    return _main_delete_entity(args)


if __name__ == "__main__":
    sys.exit(main())
