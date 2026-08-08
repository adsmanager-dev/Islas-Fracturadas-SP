# Instrucciones para agentes

## Jerarquía

1. Solicitud explícita del usuario.
2. `AGENTS.override.md` más próximo al archivo, si existe.
3. `AGENTS.md` más próximo y después los de niveles superiores.
4. Fuente temática indicada en `docs/00_INDEX_AND_DOCUMENTATION_MAP.md`.
5. Convenciones generales y ejemplos.

La instrucción específica prevalece sobre la general, pero no autoriza inventar implementación, alterar canon rector ni revelar conocimiento de autor.

## Estado real

- El repositorio contiene 20 fuentes consolidadas, anexos de evidencia, una misión principal separada y el núcleo técnico M0–M1 probado en Arma 3.
- Existe implementación SQF confirmada para M0–M1; todavía no existe campaña jugable, persistencia entre sesiones ni simulación estratégica.
- No conviertas diseño, pseudocódigo, `.gitkeep` o checklists en estado implementado.
- `art/identity/*.svg` contiene emblemas originales por facción como `PROPUESTA` (ver `art/IDENTIDAD_VISUAL.md`), derivados de `docs/15` §123–127. No existen `.paa`: la máquina de desarrollo no tiene Arma 3 Tools/ImageToPAA instalado. `IslasFracturadas.Altis/ui/cfg/CfgUnitInsignia.hpp` existe pero no está incluido desde `description.ext`; no lo incluyas hasta que existan las texturas, o el motor registrará rutas inválidas en el RPT.

## Fuentes principales

| Necesidad | Archivo |
| --- | --- |
| Índice y autoridad | `docs/00_INDEX_AND_DOCUMENTATION_MAP.md` |
| Visión y restricciones | `docs/01_PROJECT_VISION_AND_DESIGN_PILLARS.md` |
| Canon narrativo | `docs/02_STORY_BIBLE_AND_WORLD_HISTORY.md` |
| Canon secreto Helios | `docs/03_HELIOS_PHAROS_AND_ARGOS_DOSSIER.md` |
| Arquitectura técnica | `docs/18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md` |
| Estado, pruebas y hoja de ruta | `docs/19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md` |
| Identidad visual (propuesta) y procedencia de referencia | `art/IDENTIDAD_VISUAL.md`, `asset/PROCEDENCIA.md` |
| Referencias técnicas de IA | `AI_REFERENCES/README.md` (`A3-Antistasi/`, `KP-Liberation/`) |
| Muestras oficiales locales de Arma 3 | `D:\Programas\Steam\steamapps\common\Arma 3 Samples` |

Las referencias locales son de solo lectura y no son canon ni fuente de verdad. Extrae patrones, no copies código, narrativa, `mission.sqm` ni assets; comprueba procedencia, licencia aplicable y atribución antes de reutilizar material.

## Clasificación de tareas

- `DOC_REVIEW`: revisar sin modificar; `DOC_CHANGE`: cambiar documentación sin alterar canon rector.
- `CANON_CHANGE`: registrar conflictos y requerir decisión humana; `DESIGN_CHANGE`: modificar un sistema previsto no implementado.
- `IMPLEMENTATION`: crear o modificar SQF, configuración o datos funcionales; `THREEDEN_WORK`: requerir acciones manuales dentro de 3DEN.
- `VALIDATION`: verificar una implementación existente; `RELEASE_GATE`: evaluar un hito completo.

No conviertas una tarea documental en implementación ni una propuesta en canon.

## Flujo obligatorio

1. Clasificar la tarea y leer el índice.
2. Identificar la fuente de verdad.
3. Revisar `git status --short` y el estado real. Para trabajo de misión, ejecutar `.\tools\Sync-MissionWorkspace.ps1 -Action Status`; si 3DEN es más nuevo, guardar y cerrar el escenario antes de ejecutar `Pull` y editar.
4. Localizar dependencias y consumidores; ejecutar solo el cambio solicitado.
5. Validar según el artefacto.
6. Tras modificar `IslasFracturadas.Altis/`, ejecutar `.\tools\Sync-MissionWorkspace.ps1 -Action Push -WhatIf` y después `.\tools\Sync-MissionWorkspace.ps1 -Action Push`; si el cambio validado incluye `mission.sqm`, añadir `-AllowMissionSqm` a ambas órdenes. Detenerse e informar si aparece un conflicto.
7. Revisar trazabilidad y documentación afectada; informar cambios, pruebas, riesgos y pendientes.

## Enrutamiento de herramientas

| Necesidad | Primaria | Alternativa |
| --- | --- | --- |
| Arquitectura y dependencias | Codebase Memory | índice / búsqueda textual |
| Símbolos estructurados | Serena | búsqueda textual |
| SQF, macros, literales y config | `rg` | Serena |
| Seguridad y `remoteExec` | Semgrep | revisión manual |
| Geografía y composiciones | Editor 3DEN | `arma_sqm_*` o scripts estructurados, bajo las garantías de «Convenciones y límites» |
| Ejecución real | Arma 3 + RPT | pruebas disponibles |
| Canon | documentos 00–19 | nunca inferir desde código |

No edites `.codebase-memory/`. Tras cambios de código ejecuta `semgrep scan --config .semgrep.yml --metrics off --no-git-ignore IslasFracturadas.Altis`. Desde 2026-08-08 esto (y `git diff --check`, y `npm run check` de `tools/if-media-mcp` cuando aplica) se ejecuta también automáticamente en cada commit vía `.pre-commit-config.yaml` (`pre-commit install` ya activado en este repo) — la comprobación manual sigue siendo válida y necesaria si el hook se omite (`--no-verify`) o corre en una máquina sin `pre-commit` instalado.

Para assets visuales: fuente editable en `art/identity/*.svg`, nunca en `asset/` (solo referencia de terceros, no versionable sin procedencia registrada en `asset/PROCEDENCIA.md`). `.\tools\Build-Assets.ps1` convierte `art/identity/*.svg` en `IslasFracturadas.Altis/ui/insignia/*.paa`; requiere un rasterizador SVG (Inkscape/ImageMagick/rsvg-convert) e ImageToPAA (Arma 3 Tools, Steam) instalados localmente — el script detecta su ausencia y falla con instrucciones en vez de generar salidas parciales.

## Evidencia y terminado

- Estados: `DISEÑO_CONFIRMADO` = decisión presente en su fuente; `IMPLEMENTADO` = artefacto funcional y referencia exacta; `VALIDADO_3DEN` = evidencia registrada desde el editor; `PROBADO` = prueba repetible conservada; `APROBADO` = criterio y puerta formal superados.
- Documentación: fuente respetada, conflictos y enlaces revisados, sin duplicación ni estado exagerado.
- SQF: contratos, localidad, prefijo `IF_`, entradas, logging, Semgrep y prueba o limitación documentada.
- 3DEN: ejecutar dentro del editor; registrar coordenadas, navegación, composición y rendimiento.
- Revisión: ordenar hallazgos por gravedad con ubicación, impacto, corrección y prueba faltante.

## Convenciones y límites

- Redacta documentación en español y UTF-8; mantén 20 fuentes temáticas consolidadas en `docs/*.md`. Usa `docs/validation/` solo para evidencia manual solicitada e indexada.
- Conserva etiquetas de canon, propuesta, pendiente y nivel de conocimiento.
- Usa `IslasFracturadas.Altis/`, prefijo `IF_`, autoridad preparada para servidor y separación de comandos, consultas y eventos.
- `mission.sqm`: ante una petición explícita de trabajo de misión queda autorizada su modificación estructural completa —crear, editar, mover o borrar capas, lógicas, marcadores, grupos, objetos y metadatos— sin pedir confirmación literal por cada operación. Usa `arma_sqm_*` o scripts estructurados y verificables; nunca edición textual ciega ni escritura directa sobre la copia abierta por 3DEN.
- Antes de escribir: comprobar sincronización, guardar/cerrar 3DEN si es más nuevo, ejecutar `Pull`, crear backup fechado con hash y trabajar sobre staging. Validar parseo → cambio → serialización → reparseo, conteos `items`, secuencia `ItemN`, IDs únicos, `ItemIDProvider.nextID`, invariantes y diff; solo entonces promover al repositorio y ejecutar `Push -AllowMissionSqm -WhatIf` seguido de `Push -AllowMissionSqm`. Los borrados masivos requieren objetivos exactos y reversibilidad.
- Después de escribir, abrir y comprobar en 3DEN/Arma 3, guardar y revisar el RPT cuando aplique. Ninguna validación automática sustituye la prueba humana ni autoriza declarar `VALIDADO_3DEN` sin evidencia.
- Conserva SP inicial y preparación futura para cooperativo.
- No implementes SQF, 3DEN o configuración jugable sin petición explícita.
- No confirmes, publiques ni descartes cambios salvo petición explícita.

## Validación e informe

| Comprobación | Comando |
| --- | --- |
| Diferencias | `git diff --check` |
| Fuentes consolidadas | `Get-ChildItem .\docs -File \| Where-Object { $_.Extension -in ".md", ".txt", ".pdf" } \| Measure-Object` |
| Evidencias | `Get-ChildItem .\docs\validation -Recurse -File \| Measure-Object` |

Al finalizar informa alcance, archivos, decisiones, validaciones, resultados, riesgos, pendientes manuales y documentación actualizada.
