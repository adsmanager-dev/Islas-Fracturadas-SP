#!/usr/bin/env python3
"""Compara dos mission.sqm completos sin escribir junto a las fuentes."""
from __future__ import annotations

import argparse
import hashlib
import json
import tempfile
from pathlib import Path

from arma_class_io import derapify_if_needed


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


def classify(path: str) -> str:
    """Distingue metadatos editoriales de contenido funcional de la misión."""
    if path.startswith("root.EditorData.Camera"):
        return "CAMERA_METADATA"
    if path.startswith("root.EditorData"):
        return "EDITOR_METADATA"
    if ".Entities." in path or path.startswith("root.Mission.Entities"):
        return "ENTITY_FUNCTIONAL"
    return "MISSION_FUNCTIONAL"


def walk(left, right, path="root") -> list[dict]:
    """Devuelve diferencias escalares con una ruta estable y su clasificación."""
    result: list[dict] = []
    if isinstance(left, dict) and isinstance(right, dict):
        for key in sorted(set(left) | set(right)):
            child = f"{path}.{key}"
            if key not in left:
                result.append({"path": child, "repo": None, "workspace": right[key], "classification": classify(child)})
            elif key not in right:
                result.append({"path": child, "repo": left[key], "workspace": None, "classification": classify(child)})
            else:
                result.extend(walk(left[key], right[key], child))
        return result
    if isinstance(left, list) and isinstance(right, list):
        if len(left) != len(right):
            child = f"{path}.length"
            result.append({"path": child, "repo": len(left), "workspace": len(right), "classification": classify(child)})
        for index, (lvalue, rvalue) in enumerate(zip(left, right)):
            result.extend(walk(lvalue, rvalue, f"{path}[{index}]"))
        return result
    if left != right:
        result.append({"path": path, "repo": left, "workspace": right, "classification": classify(path)})
    return result


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", required=True, type=Path)
    parser.add_argument("--workspace", required=True, type=Path)
    parser.add_argument("--hemtt")
    parser.add_argument("--output-json", required=True, type=Path)
    args = parser.parse_args()

    repo_data = derapify_if_needed(args.repo, args.hemtt)
    workspace_data = derapify_if_needed(args.workspace, args.hemtt)
    differences = walk(repo_data, workspace_data)
    counts: dict[str, int] = {}
    for item in differences:
        category = item["classification"]
        counts[category] = counts.get(category, 0) + 1
    functional = counts.get("ENTITY_FUNCTIONAL", 0) + counts.get("MISSION_FUNCTIONAL", 0)
    report = {
        "repo_path": str(args.repo),
        "workspace_path": str(args.workspace),
        "repo_sha256": digest(args.repo),
        "workspace_sha256": digest(args.workspace),
        "byte_equal": digest(args.repo) == digest(args.workspace),
        "structural_equal": not differences,
        "functional_equal": functional == 0,
        "difference_count": len(differences),
        "counts_by_classification": dict(sorted(counts.items())),
        "differences": differences,
    }
    args.output_json.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(
        mode="w",
        encoding="utf-8",
        prefix=f".{args.output_json.name}.",
        suffix=".tmp",
        dir=args.output_json.parent,
        delete=False,
    ) as handle:
        json.dump(report, handle, indent=2, ensure_ascii=False)
        temporary_output = Path(handle.name)
    temporary_output.replace(args.output_json)
    print(json.dumps({key: report[key] for key in ("byte_equal", "structural_equal", "functional_equal", "difference_count", "counts_by_classification")}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())