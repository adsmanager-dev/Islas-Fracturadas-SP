---
name: if-media-assets
description: Genera, edita, registra y prepara imágenes de Islas Fracturadas con procedencia, estados de aprobación y salidas seguras. Usar cuando se pidan emblemas, texturas, concept art, referencias visuales, edición de imágenes, rasterizado SVG o conversión de identidad visual a PAA.
---

# Assets visuales de Islas Fracturadas

## Overview

Usa el servidor MCP `if-media` para mantener una cadena reproducible entre borradores, fuentes aprobadas y texturas finales. La generación técnica nunca convierte una `PROPUESTA` en canon, implementación o aprobación.

## Flujo obligatorio

1. Lee `art/IDENTIDAD_VISUAL.md`, `asset/PROCEDENCIA.md` y la sección pertinente de `docs/00_INDEX_AND_DOCUMENTATION_MAP.md`.
2. Ejecuta `media_status` antes de diseñar una operación. Respeta `IF_MEDIA_REMOTE_MODE`: en `disabled` no pidas una clave ni intentes generación remota.
3. Determina el destino:
   - borrador generado o editado: `production/media/drafts/`;
   - fuente editable original aprobada: `art/`;
   - referencia de terceros con procedencia: `asset/reference/`;
   - salida de motor: solo mediante `media_build_identity`/`tools/Build-Assets.ps1`.
4. Para generar o editar:
   - en Codex, usa primero la capacidad nativa `imagegen` cuando esté disponible y registra después el archivo resultante con `media_register_provenance`;
   - en Claude, con el modo remoto desactivado, limita el MCP a registro, rasterizado y compilación local; una suscripción ChatGPT no funciona como credencial API.
   Conserva siempre el manifiesto de procedencia.
5. Para incorporar un archivo existente, usa `media_register_provenance`. Describe origen, titular/licencia y finalidad; no inventes esos datos.
6. Inspecciona visualmente el resultado y compáralo con la fuente temática. Mantén el estado `PROPUESTA` hasta una aprobación humana explícita.
7. Solo tras aprobación explícita mueve o reconstruye la fuente en `art/identity/`. No copies imágenes rasterizadas de terceros como fuente propia.
8. Antes de producir PAA, vuelve a ejecutar `media_status`. Usa `media_build_identity` únicamente si Inkscape y ImageToPAA están disponibles y la aprobación se refiere a los SVG exactos.
9. Tras crear PAA, aplica el flujo de sincronización de misión, revisa RPT/3DEN y solo entonces considera incluir `CfgUnitInsignia.hpp`.

## Límites

- No escribas imágenes generadas directamente en `IslasFracturadas.Altis/`.
- No edites `mission.sqm`.
- No declares `IMPLEMENTADO`, `VALIDADO_3DEN`, `PROBADO` o `APROBADO` sin la evidencia exigida por el repositorio.
- No ejecutes generación remota sin que el usuario haya solicitado la imagen: puede producir coste y enviar el prompt/entradas al proveedor.
- No expongas herramientas de shell, URL arbitraria, ruta absoluta ni salida fuera de las raíces permitidas.
- Si el modo remoto está desactivado o falta un ejecutable, informa la capacidad no disponible y continúa con tareas locales que no dependan de ella.

## Criterios de entrega

- El archivo abre correctamente y su hash coincide con el manifiesto.
- El manifiesto conserva proveedor/modelo, prompt o descripción de origen, condiciones de uso, fecha UTC y estado real.
- La fuente editable vive en `art/`; los intermediarios regenerables no se versionan.
- Toda textura PAA cumple potencia de dos, usa el sufijo aplicable y tiene prueba en Arma 3/3DEN pendiente o registrada explícitamente.

Consulta [references/media-contract.md](references/media-contract.md) antes de registrar o promover un asset.
