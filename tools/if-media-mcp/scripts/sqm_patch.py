#!/usr/bin/env python3
"""
Parche quirúrgico de mission.sqm: cambia SOLO position[]/angles[] de una entidad
existente (localizada por su `id` nativo, único en todo el archivo — verificado
contra AI_REFERENCES/A3-Antistasi: 1561 entidades, 1561 IDs únicos). El resto del
archivo queda byte-por-byte idéntico — no es un parseo-completo→regenerar-completo
(eso reformatea el archivo entero, ver EVALUATION.md 2026-08-08).

Solo mover/rotar en v1. NO añade ni borra entidades — eso exige gestionar
contadores/IDs, más riesgo, queda para una versión posterior.

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
    old_values: Optional[list]
    new_values: list
    entities_before: int
    entities_after: int
    unrelated_entities_changed: list[str]


def apply_patch(mission_sqm: Path, hemtt_exe: Optional[str], entity_id: int, field: str, new_values: list[float],
                 draft_output: Path, backup_dir: Path) -> PatchResult:
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
    entities_before = flatten_entities(data_before.get("Mission", data_before).get("Entities", {}))
    target_before = next((e for e in entities_before if e["id"] == entity_id), None)
    if target_before is None:
        raise PatchError(f"No existe ninguna entidad con id={entity_id} en mission.sqm.")
    old_values = target_before.get("position") if field == "position" else None

    patched_text = patch_array_field(base_text, entity_id, field, new_values)

    data_after = armaclass.parse(patched_text)
    entities_after = flatten_entities(data_after.get("Mission", data_after).get("Entities", {}))

    unrelated_changed: list[str] = []
    before_by_id = {e["id"]: e for e in entities_before if e["id"] is not None}
    after_by_id = {e["id"]: e for e in entities_after if e["id"] is not None}
    for eid, before_entity in before_by_id.items():
        if eid == entity_id:
            continue
        after_entity = after_by_id.get(eid)
        if after_entity != before_entity:
            unrelated_changed.append(f"id={eid} ({before_entity.get('path')})")

    backup_dir.mkdir(parents=True, exist_ok=True)
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    backup_path = backup_dir / f"mission.sqm.{timestamp}.bak"
    backup_path.write_bytes(raw)

    # newline="" evita que Python traduzca los \r\n ya literales del texto original
    # (leído como bytes) al escribirlos de nuevo — si no, cada línea queda con \r\r\n.
    draft_output.write_text(patched_text, encoding="utf-8", newline="")

    target_after = next((e for e in entities_after if e["id"] == entity_id), None)

    return PatchResult(
        ok=len(unrelated_changed) == 0 and len(entities_before) == len(entities_after),
        backup_path=str(backup_path),
        draft_path=str(draft_output),
        entity_id=entity_id,
        field=field,
        old_values=old_values,
        new_values=target_after.get(field) if target_after and field == "position" else new_values,
        entities_before=len(entities_before),
        entities_after=len(entities_after),
        unrelated_entities_changed=unrelated_changed,
    )


def main() -> int:
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--mission-sqm", required=True, type=Path)
    parser.add_argument("--hemtt", default=None)
    parser.add_argument("--entity-id", required=True, type=int)
    parser.add_argument("--field", required=True, choices=sorted(ARRAY_FIELD_PATTERN))
    parser.add_argument("--values", required=True, help="Coma-separados, ej: 1234.5,6.0,789.1")
    parser.add_argument("--draft-output", required=True, type=Path)
    parser.add_argument("--backup-dir", required=True, type=Path)
    args = parser.parse_args()

    new_values = [float(v) for v in args.values.split(",")]
    try:
        result = apply_patch(args.mission_sqm, args.hemtt, args.entity_id, args.field, new_values,
                              args.draft_output, args.backup_dir)
    except PatchError as e:
        print(json.dumps({"ok": False, "error": str(e)}, ensure_ascii=False))
        return 1

    print(json.dumps(result.__dict__, ensure_ascii=False))
    return 0 if result.ok else 1


if __name__ == "__main__":
    sys.exit(main())
