# Instrucciones para agentes

## Estado del proyecto

- El repositorio contiene documentación consolidada y un esqueleto de carpetas.
- No existe todavía una misión jugable ni implementación SQF confirmada; no conviertas diseño previsto en estado implementado.

## Fuentes externas

| Necesidad | Archivo |
| --- | --- |
| Índice y jerarquía | `docs/00_INDEX_AND_DOCUMENTATION_MAP.md` |
| Visión y restricciones | `docs/01_PROJECT_VISION_AND_DESIGN_PILLARS.md` |
| Canon narrativo | `docs/02_STORY_BIBLE_AND_WORLD_HISTORY.md` |
| Canon secreto Helios | `docs/03_HELIOS_PHAROS_AND_ARGOS_DOSSIER.md` |
| Arquitectura técnica | `docs/18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md` |
| Estado y hoja de ruta | `docs/19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md` |

## Herramientas de agentes

- Prioriza Codebase Memory: `search_graph`, `trace_path`, `get_code_snippet`, `query_graph` y `get_architecture`; no edites `.codebase-memory/`.
- Usa Serena para navegación simbólica; para SQF, literales, configuración o resultados insuficientes usa búsqueda textual.
- Tras cambios de código ejecuta `semgrep scan --config .semgrep.yml --metrics off --no-git-ignore IslasFracturadas.Altis`.

## Flujo de trabajo

- Lee primero el índice y después la fuente de verdad del sistema afectado.
- Revisa `git status --short` antes de modificar archivos.
- Conserva cambios preexistentes y evita tocar áreas fuera del encargo.
- No implementes SQF, 3DEN o configuración jugable sin una petición explícita.
- Actualiza enlaces y trazabilidad cuando cambien nombres o responsabilidades.

## Canon y documentación

- Redacta la documentación en español y UTF-8.
- Mantén `docs/` en un máximo de 20 documentos; consolida antes de añadir una fuente.
- Respeta las etiquetas de canon, propuesta, pendiente y nivel de conocimiento.
- Registra versiones incompatibles en `Conflictos o decisiones pendientes`.
- No reveles conocimiento de autor en contenido destinado al jugador.

## Convenciones técnicas

- Usa `IslasFracturadas.Altis/` como raíz de la misión.
- Usa el prefijo `IF_` para identificadores propios del proyecto.
- Mantén autoridad estratégica compatible con servidor y clientes futuros.
- Separa comandos, consultas y eventos.
- No edites `mission.sqm` fuera del flujo controlado del Editor 3DEN.
- Conserva el diseño SP inicial y la preparación futura para cooperativo.

## Validación

| Comprobación | Comando |
| --- | --- |
| Estado | `git status --short` |
| Diferencias | `git diff --check` |
| Límite documental | `Get-ChildItem .\docs -Recurse -File \| Where-Object { $_.Extension -in ".md", ".txt", ".pdf" } \| Measure-Object` |

## Git

- No confirmes, publiques ni descartes cambios salvo petición explícita.
