"""
Lectura compartida de archivos de clases Arma (CfgFunctions, description.ext,
mission.sqm): texto plano vía armaclass, o binario/rapificado ("\\0raP") vía
`hemtt utils config derapify --format json-pretty`. Usado por sqf_graph.py y
sqm_inspect.py — una sola implementación, no duplicada entre los dos scripts.
"""
from __future__ import annotations

import json
import subprocess
from pathlib import Path
from typing import Optional

try:
    import armaclass
except ImportError:  # pragma: no cover - se valida en tiempo de ejecución real
    armaclass = None

RAPIFIED_MAGIC = b"\0raP"


def derapify_if_needed(path: Path, hemtt_exe: Optional[str]) -> dict:
    """Lee un archivo de clases Arma (texto plano o rapificado) como dict."""
    raw = path.read_bytes()
    if raw[:4] == RAPIFIED_MAGIC:
        if not hemtt_exe:
            raise RuntimeError(
                f"{path} está rapificado (binario) y no se proporcionó hemtt.exe para derapificar."
            )
        out_path = path.with_suffix(path.suffix + ".derapified.json")
        result = subprocess.run(
            [hemtt_exe, "utils", "config", "derapify", str(path), str(out_path), "--format", "json-pretty"],
            capture_output=True, text=True, timeout=60
        )
        if result.returncode != 0:
            raise RuntimeError(f"hemtt derapify falló para {path}: {result.stderr or result.stdout}")
        try:
            return json.loads(out_path.read_text(encoding="utf-8"))
        finally:
            out_path.unlink(missing_ok=True)
    if armaclass is None:
        raise RuntimeError("El paquete 'armaclass' no está instalado en el entorno Python usado.")
    text = raw.decode("utf-8-sig", errors="replace")
    return armaclass.parse(text)
