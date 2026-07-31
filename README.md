# Islas Fracturadas

Campaña persistente para Arma 3 ambientada en Altis y Stratis. El proyecto combina guerra territorial, dos campañas independientes, actores nativos, insurgencia, población civil, logística, inteligencia y una conspiración articulada alrededor de Helios, PHAROS y el Comité Argos.

## Dedicatoria

**Islas Fracturadas es un proyecto creado como homenaje a Bohemia Interactive y a los equipos que construyeron la saga Arma. Su libertad de edición, sus herramientas y su confianza en la comunidad permitieron que jugadores, modders y creadores imaginaran experiencias que iban mucho más allá de una campaña cerrada. Este proyecto nace de esa libertad: no pretende reemplazar ni competir con la obra original, sino agradecerla creando dentro del espacio que ella hizo posible.**

> **Islas Fracturadas no es una lucha por superar a sus creadores; es una carta de agradecimiento convertida en una campaña jugable.**

Este es un proyecto comunitario no oficial, sin afiliación ni respaldo de Bohemia Interactive.

> **Estado actual:** `DOC-GATE-02` aprobado; la dirección narrativa jugable y su trazabilidad documental están consolidadas, con esqueleto de directorios. La misión jugable, la configuración 3DEN y los sistemas SQF todavía no están implementados. La [instantánea autoritativa](docs/19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#instantanea-autoritativa-del-estado-real) mantiene el estado verificable.

## Estado real del repositorio

| Elemento | Estado | Evidencia |
| --- | --- | --- |
| Biblioteca documental | consolidada | `docs/00–19` |
| Decisiones rectoras | registradas | `DEC-001`–`DEC-007` |
| Estructura de carpetas | creada | archivos `.gitkeep` |
| `mission.sqm` | ausente | pendiente `F0-002` |
| `description.ext` | ausente | pendiente `F0-003` |
| Bootstrap y logger SQF | ausentes | pendientes `F0-006`–`F0-007` |
| Pruebas dentro de Arma 3 | no ejecutadas | pendiente M0 |
| Validación 3DEN | no iniciada | pendiente |

## Requisitos de desarrollo

- Arma 3 y Editor 3DEN para la validación física y funcional.
- Visual Studio Code, PowerShell y Git.
- Semgrep para reglas deterministas.
- Codebase Memory, Serena y Semgrep configurados como servidores MCP.
- Claude Code, Codex o GitHub Copilot en VS Code como agente compatible.

No se fijan versiones hasta verificarlas en el entorno real.

## Experiencia prevista

- Campañas separadas para la Fuerza Azul y la Fuerza Roja.
- Primera versión para un jugador, preparada arquitectónicamente para cooperativo futuro.
- Territorio persistente con sectores, frentes, suministro, economía y reconstrucción.
- Fuerza Verde, FIA, gobiernos locales y civiles con intereses propios.
- Inteligencia incompleta, investigación y revelaciones diferentes por campaña.
- Contenido vanilla como base y posibles extensiones mediante mods.
- Construcción sectorial mediante composiciones predefinidas; el jugador no coloca edificios manualmente.

## Documentación

La entrada principal es [`docs/00_INDEX_AND_DOCUMENTATION_MAP.md`](docs/00_INDEX_AND_DOCUMENTATION_MAP.md).

| Necesidad | Fuente |
| --- | --- |
| Visión y pilares | [`docs/01_PROJECT_VISION_AND_DESIGN_PILLARS.md`](docs/01_PROJECT_VISION_AND_DESIGN_PILLARS.md) |
| Biblia narrativa | [`docs/02_STORY_BIBLE_AND_WORLD_HISTORY.md`](docs/02_STORY_BIBLE_AND_WORLD_HISTORY.md) |
| Canon secreto de Helios | [`docs/03_HELIOS_PHAROS_AND_ARGOS_DOSSIER.md`](docs/03_HELIOS_PHAROS_AND_ARGOS_DOSSIER.md) |
| Campañas Azul y Roja | [`docs/08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md`](docs/08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md) |
| Sistemas estratégicos | [`docs/10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md`](docs/10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md) |
| Arquitectura técnica | [`docs/18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md`](docs/18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md) |
| Estado, pruebas y hoja de ruta | [`docs/19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md`](docs/19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md) |

La carpeta `docs/` contiene exactamente 20 fuentes consolidadas. No deben añadirse documentos nuevos sin integrar o sustituir otro documento dentro de ese límite.

Las decisiones `DEC-001`–`DEC-007`, incluido el cierre de Vardis y la Verdad Comparada, se mantienen en el [registro autoritativo](docs/19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#registro-autoritativo-de-decisiones).

## Estructura del repositorio

```text
.
├── README.md
├── AGENTS.md
├── CLAUDE.md                    # Adaptador de Claude que importa AGENTS.md
├── agent-skills-src/            # Fuente única de las skills IF
├── .claude/skills/              # Copia generada para Claude Code
├── .agents/skills/              # Copia generada para Codex
├── tools/Sync-AgentSkills.ps1   # Sincroniza y verifica ambas copias
├── docs/                         # Biblioteca canónica de 20 documentos
├── IslasFracturadas.Altis/       # Raíz futura de la misión
│   ├── cfg/                      # CfgFunctions, RemoteExec, sonidos y UI
│   ├── core/                     # Estado, eventos, red, validación y utilidades
│   ├── modules/                  # Dominios de campaña y reglas jugables
│   ├── simulation/               # Simulación estratégica y virtualización
│   ├── ui/                       # Interfaz estratégica y presentación
│   ├── campaign/                 # Flujo de campaña, actos y persistencia
│   ├── compositions/             # Bases, sectores y fortificaciones 3DEN
│   ├── data/                     # Catálogos y configuración inmutable
│   ├── tests/                    # Pruebas SQF e integración
│   ├── diagnostics/              # Logging, métricas y herramientas de depuración
│   └── assets/                   # Recursos audiovisuales de la misión
└── .vscode/                      # Recomendaciones y configuración local del editor
```

Las carpetas vacías contienen `.gitkeep`. Su presencia no significa que el sistema correspondiente esté implementado.

## Inicio de una sesión de agente

1. Abrir la raíz del repositorio.
2. Revisar `git status --short`.
3. Leer `AGENTS.md` y `docs/00_INDEX_AND_DOCUMENTATION_MAP.md`.
4. Identificar la fuente de verdad del encargo.
5. Seleccionar la skill `if-*` correspondiente.
6. Clasificar la tarea como documental, técnica, 3DEN, validación o gate.
7. Ejecutar, validar y registrar evidencia sin exagerar el estado.

## Inicio del desarrollo

El siguiente hito es **M0 — Esqueleto técnico ejecutable**:

1. Crear una misión vacía de Altis mediante el Editor 3DEN.
2. Incorporar `mission.sqm`, `description.ext` y los archivos de inicialización.
3. Registrar `CfgFunctions`.
4. Implementar un logger mínimo y una función de prueba.
5. Abrir la misión y confirmar un inicio limpio en el RPT.

No debe editarse `mission.sqm` como texto generado libremente; es propiedad del Editor 3DEN.

## Convenciones esenciales

- Documentación y texto de diseño en español.
- Prefijo técnico del proyecto: `IF_`.
- Estado estratégico autoritativo y preparado para separación servidor/cliente.
- Funciones organizadas por comandos, consultas y eventos.
- Diseño previsto e implementación real deben permanecer claramente diferenciados.
- Las contradicciones de canon se registran y requieren decisión humana; no se corrigen silenciosamente.

## Herramientas para agentes

| Herramienta | Configuración | Uso principal |
| --- | --- | --- |
| Codebase Memory | `.mcp.json` y `.codebase-memory/` | Grafo, arquitectura, búsqueda y trazado de dependencias. |
| Serena | `.mcp.json` y `.serena/project.yml` | Navegación simbólica de YAML/JSON y operaciones estructuradas sobre archivos. |
| Semgrep | `.mcp.json`, `.semgrep.yml` y `.semgrepignore` | Revisión de secretos, ejecución dinámica SQF y fronteras de `remoteExec`. |

Claude dispone además de registros locales aprobados para este proyecto. Codex tiene los tres servidores habilitados en su configuración MCP; una sesión que estuviera abierta antes de configurarlos debe reiniciarse para cargar las herramientas nuevas.

## Personalización de agentes

| Elemento | Ubicación | Función |
| --- | --- | --- |
| Reglas comunes | `AGENTS.md` | restricciones permanentes |
| Adaptador Claude | `CLAUDE.md` | comportamiento específico |
| Fuente de skills | `agent-skills-src/` | autoría de las 18 skills `if-*` |
| Skills Claude | `.claude/skills/` | copia generada |
| Skills Codex | `.agents/skills/` | copia generada |
| Sincronización | `tools/Sync-AgentSkills.ps1` | copia, hashes y protección contra ediciones manuales |
| MCP | `.mcp.json` | capacidades externas |
| Semgrep | `.semgrep.yml` | reglas deterministas |

No edites las copias generadas. Modifica `agent-skills-src/` y ejecuta:

```powershell
.\tools\Sync-AgentSkills.ps1
.\tools\Sync-AgentSkills.ps1 -Check
```

Las 18 skills cubren recepción, canon, dirección narrativa, facciones, consecuencias, sincronización documental, módulos y revisión SQF, eventos, persistencia, configuración, rendimiento, 3DEN, RPT, smoke tests, regresión, gates e informes de defectos. Las skills técnicas describen procedimientos futuros y no prueban que esos sistemas estén implementados.

## Límites actuales

- No añadir dependencias de mods antes de aprobar la matriz vanilla/mod.
- No publicar una versión jugable inexistente.
- No modificar `mission.sqm` manualmente.
- No incorporar assets sin licencia o procedencia comprobada.
- No añadir documentos a `docs/` sin respetar el límite de 20.
- No convertir una propuesta narrativa en canon rector silenciosamente.

## Comprobación documental

```powershell
Get-ChildItem .\docs -Recurse -File |
Where-Object { $_.Extension -in ".md", ".txt", ".pdf" } |
Measure-Object
```

El resultado debe ser igual o inferior a 20.

## Licencia

No se ha definido una licencia pública. Todo el contenido se considera reservado hasta que el propietario del proyecto establezca una.
