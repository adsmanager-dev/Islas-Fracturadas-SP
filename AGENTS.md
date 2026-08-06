# Instrucciones para agentes

## Jerarquía

1. Solicitud explícita del usuario.
2. `AGENTS.override.md` más próximo al archivo, si existe.
3. `AGENTS.md` más próximo y después los de niveles superiores.
4. Fuente temática indicada en `docs/00_INDEX_AND_DOCUMENTATION_MAP.md`.
5. Convenciones generales y ejemplos.

La instrucción específica prevalece sobre la general, pero no autoriza inventar implementación, alterar canon rector ni revelar conocimiento de autor.

## Estado real

- El repositorio contiene 20 fuentes consolidadas, anexos de evidencia 3DEN, `mission.sqm` y configuración provisional; todavía no existe misión jugable.
- No existe misión jugable ni implementación SQF confirmada.
- No conviertas diseño, pseudocódigo, `.gitkeep` o checklists en estado implementado.

## Fuentes principales

| Necesidad | Archivo |
| --- | --- |
| Índice y autoridad | `docs/00_INDEX_AND_DOCUMENTATION_MAP.md` |
| Visión y restricciones | `docs/01_PROJECT_VISION_AND_DESIGN_PILLARS.md` |
| Canon narrativo | `docs/02_STORY_BIBLE_AND_WORLD_HISTORY.md` |
| Canon secreto Helios | `docs/03_HELIOS_PHAROS_AND_ARGOS_DOSSIER.md` |
| Arquitectura técnica | `docs/18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md` |
| Estado, pruebas y hoja de ruta | `docs/19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md` |

## Clasificación de tareas

- `DOC_REVIEW`: revisar sin modificar.
- `DOC_CHANGE`: cambiar documentación sin alterar canon rector.
- `CANON_CHANGE`: registrar conflictos y requerir decisión humana.
- `DESIGN_CHANGE`: modificar un sistema previsto no implementado.
- `IMPLEMENTATION`: crear o modificar SQF, configuración o datos funcionales.
- `THREEDEN_WORK`: requerir acciones manuales dentro de 3DEN.
- `VALIDATION`: verificar una implementación existente.
- `RELEASE_GATE`: evaluar un hito completo.

No conviertas una tarea documental en implementación ni una propuesta en canon.

## Flujo obligatorio

1. Clasificar la tarea y leer el índice.
2. Identificar la fuente de verdad.
3. Revisar `git status --short` y el estado real. Para trabajo de misión, ejecutar `.\tools\Sync-MissionWorkspace.ps1 -Action Status`; si hay cambios guardados desde 3DEN, ejecutar `.\tools\Sync-MissionWorkspace.ps1 -Action Pull` antes de editar.
4. Localizar dependencias y consumidores.
5. Ejecutar solo el cambio solicitado.
6. Validar según el artefacto.
7. Tras modificar `IslasFracturadas.Altis/`, ejecutar `.\tools\Sync-MissionWorkspace.ps1 -Action Push -WhatIf` y después `.\tools\Sync-MissionWorkspace.ps1 -Action Push`; detenerse e informar si aparece un conflicto.
8. Revisar trazabilidad y documentación afectada.
9. Informar cambios, pruebas, riesgos y pendientes.

## Enrutamiento de herramientas

| Necesidad | Primaria | Alternativa |
| --- | --- | --- |
| Arquitectura y dependencias | Codebase Memory | índice / búsqueda textual |
| Símbolos estructurados | Serena | búsqueda textual |
| SQF, macros, literales y config | `rg` | Serena |
| Seguridad y `remoteExec` | Semgrep | revisión manual |
| Geografía y composiciones | Editor 3DEN | ninguna |
| Ejecución real | Arma 3 + RPT | pruebas disponibles |
| Canon | documentos 00–19 | nunca inferir desde código |

No edites `.codebase-memory/`. Tras cambios de código ejecuta `semgrep scan --config .semgrep.yml --metrics off --no-git-ignore IslasFracturadas.Altis`.

## Evidencia y terminado

- `DISEÑO_CONFIRMADO`: decisión presente en su fuente.
- `IMPLEMENTADO`: artefacto funcional y referencia exacta.
- `VALIDADO_3DEN`: evidencia registrada desde el editor.
- `PROBADO`: prueba repetible con resultado conservado.
- `APROBADO`: criterio y puerta formal superados.
- Documentación: fuente respetada, conflictos y enlaces revisados, sin duplicación ni estado exagerado.
- SQF: contratos, localidad, prefijo `IF_`, entradas, logging, Semgrep y prueba o limitación documentada.
- 3DEN: ejecutar dentro del editor; registrar coordenadas, navegación, composición y rendimiento.
- Revisión: ordenar hallazgos por gravedad con ubicación, impacto, corrección y prueba faltante.

## Convenciones y límites

- Redacta documentación en español y UTF-8; mantén 20 fuentes temáticas consolidadas en `docs/*.md`. Usa `docs/validation/` solo para evidencia manual solicitada e indexada.
- Conserva etiquetas de canon, propuesta, pendiente y nivel de conocimiento.
- Usa `IslasFracturadas.Altis/`, prefijo `IF_`, autoridad preparada para servidor y separación de comandos, consultas y eventos.
- No edites `mission.sqm` fuera del flujo controlado de 3DEN.
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
