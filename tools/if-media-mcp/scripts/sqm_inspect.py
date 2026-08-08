#!/usr/bin/env python3
"""
Inspecciona mission.sqm de solo lectura: cuenta entidades por tipo/bando, aplana
la lista de entidades (posición, classname, bando, nombre de variable si existe,
init si existe) y construye un índice de búsqueda por nombre de variable
("IF_BLUE_FOB" -> ruta de la entidad).

NUNCA escribe nada. Es la base para una futura herramienta de escritura
(arma_sqm_patch), que exigirá backup automático + validación por round-trip +
confirmación explícita antes de existir — ver AGENTS.md, excepción 2026-08-08.

Probado contra mission.sqm real de Islas Fracturadas (1 entidad, caso mínimo) y
contra AI_REFERENCES/A3-Antistasi (1561 entidades reales: Object, Marker, Layer,
Logic, Group) como prueba de volumen y variedad de dataType.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path
from typing import Optional

from arma_class_io import derapify_if_needed

# Boilerplate de UI del propio editor 3DEN: nunca se trata como lógica de misión.
IGNORED_ATTRIBUTE_KEYS = {"CustomAttributes"}


def flatten_entities(entities_node: dict) -> list[dict]:
    flat: list[dict] = []

    def walk(node, path: str, group_side: Optional[str]):
        if not isinstance(node, dict):
            return
        data_type = node.get("dataType")
        if data_type:
            attrs = node.get("Attributes", {}) if isinstance(node.get("Attributes"), dict) else {}
            position = None
            pos_info = node.get("PositionInfo")
            if isinstance(pos_info, dict) and isinstance(pos_info.get("position"), list):
                position = pos_info["position"]
            entry = {
                "path": path,
                "id": node.get("id"),
                "data_type": data_type,
                "type": node.get("type"),
                "side": node.get("side", group_side),
                "name": attrs.get("name"),
                "init": attrs.get("init") if isinstance(attrs.get("init"), str) and attrs.get("init").strip() else None,
                "position": position,
            }
            flat.append(entry)
        nested = node.get("Entities")
        effective_side = node.get("side", group_side)
        if isinstance(nested, dict):
            for key, value in nested.items():
                if key.startswith("Item"):
                    walk(value, f"{path}/Entities/{key}", effective_side)

    if isinstance(entities_node, dict):
        for key, value in entities_node.items():
            if key.startswith("Item"):
                walk(value, key, None)
    return flat


def build_summary(flat_entities: list[dict]) -> dict:
    by_type: dict[str, int] = {}
    by_side: dict[str, int] = {}
    named: dict[str, str] = {}
    with_init = 0
    for e in flat_entities:
        by_type[e["data_type"]] = by_type.get(e["data_type"], 0) + 1
        if e["side"]:
            by_side[e["side"]] = by_side.get(e["side"], 0) + 1
        if e["name"]:
            named[e["name"]] = e["path"]
        if e["init"]:
            with_init += 1
    return {
        "total_entities": len(flat_entities),
        "counts_by_data_type": dict(sorted(by_type.items())),
        "counts_by_side": dict(sorted(by_side.items())),
        "named_entities": dict(sorted(named.items())),
        "entities_with_init": with_init,
    }


def main() -> int:
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--mission-sqm", required=True, type=Path)
    parser.add_argument("--hemtt", default=None)
    parser.add_argument("--output-json", required=True, type=Path)
    parser.add_argument("--name-filter", default=None, help="Si se indica, solo incluye entidades cuyo nombre contenga este texto (case-insensitive).")
    args = parser.parse_args()

    data = derapify_if_needed(args.mission_sqm, args.hemtt)
    mission = data.get("Mission", data)
    flat_entities = flatten_entities(mission.get("Entities", {}))
    summary = build_summary(flat_entities)

    entities_out = flat_entities
    if args.name_filter:
        needle = args.name_filter.lower()
        entities_out = [e for e in flat_entities if e["name"] and needle in e["name"].lower()]

    result = {
        "version": data.get("version"),
        "summary": summary,
        "entities": entities_out,
    }
    args.output_json.write_text(json.dumps(result, indent=2, ensure_ascii=False), encoding="utf-8")
    print(f"total_entidades={summary['total_entities']} "
          f"con_nombre={len(summary['named_entities'])} "
          f"con_init={summary['entities_with_init']} "
          f"filtradas_devueltas={len(entities_out)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
