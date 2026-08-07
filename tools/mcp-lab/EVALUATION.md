# Laboratorio de herramientas/MCP candidatas — Islas Fracturadas

> Registro de qué se probó, qué se descartó (con motivo verificado) y qué queda por probar,
> uno por uno. Nada aquí es canon ni decisión de arquitectura por sí solo — es una bitácora de
> investigación. Los cambios reales ya integrados viven en `tools/if-media-mcp/README.md`.

## Cómo leer esta tabla

- **Probado**: se instaló y se ejecutó de verdad (no solo se leyó el README).
- **Verificado (no probado)**: se confirmó que el repo/proyecto existe y qué dice de sí mismo,
  pero no se instaló ni se ejecutó todavía.
- Todo veredicto de descarte lleva una razón concreta y comprobable, no una opinión genérica.

## Adoptado — integrado en `tools/if-media-mcp/`

| Herramienta | Para qué | Estado |
| --- | --- | --- |
| [BrettMayson/HEMTT](https://github.com/BrettMayson/HEMTT) | Conversión PAA sin Steam (`hemtt utils paa convert`) | Probado con conversión real de `if_helios.png` |
| [linebender/resvg](https://github.com/linebender/resvg) | `media_render_preview`, legibilidad 32/64/128px | Probado, 310ms para 3 tamaños |
| [visioncortex/vtracer](https://github.com/visioncortex/vtracer) | `media_vectorize_raster` | Probado, exige `confirms_original_source: true` |
| [SQFvm/runtime](https://github.com/SQFvm/runtime) | `arma_test`, ejecuta `.sqf` sin abrir Arma 3 | Probado con script válido y con error de sintaxis |

Los cuatro binarios viven en `tools/if-media-mcp/bin/` (gitignored), autodetectados sin PATH.

## Probado y descartado

| Herramienta | Motivo verificado |
| --- | --- |
| [sandraschi/inkscape-mcp](https://github.com/sandraschi/inkscape-mcp) | Instalado y probado en vivo (stdio, apuntando al Inkscape ya instalado). `generate_heraldry` resultó ser un stub: solo un preset fijo ("trumponia"); `custom` está sin implementar. Una llamada de solo lectura (`inkscape_analysis:statistics`) tardó **12.4s** frente a **310ms** de `resvg` para el equivalente. Desinstalado tras la prueba. |
| [Shriinivas/inkmcp](https://github.com/Shriinivas/inkmcp) | El propio README dice "Currently Linux Only" — depende de D-Bus, que no existe en Windows. Descartado sin necesidad de instalar. |
| [Waffle1434/ArmA-Map-Image-Converter](https://github.com/Waffle1434/ArmA-Map-Image-Converter) | Dominio equivocado: stitching de tiles satelitales y heightmaps para terreno personalizado; Islas Fracturadas usa Altis (stock). Su carpeta `ImageToPAA` es una redistribución del binario propietario de Bohemia, no una reimplementación. |
| [AlwarrenSidh/ArmAToolbox](https://github.com/AlwarrenSidh/ArmAToolbox) | Addon de Blender para modelos `.p3d`; no toca PAA/texturas. |
| [arma-actions/mikero-tools](https://github.com/arma-actions/mikero-tools) | Las herramientas de Mikero ahora requieren licencia de pago (Bytex Marketplace); su único tool de PAA (`DePac`) solo analiza archivos existentes, no crea nuevos. |
| OmniSVG / StarVector | Modelos generativos (8-26GB VRAM); riesgo estructural de originalidad (entrenados con arte ajeno) incompatible con la "regla de derivación" de `art/IDENTIDAD_VISUAL.md` (cada trazo debe citar su origen en canon, no en un dataset). |
| [DeusData/codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp) para `.sqf` | Verificado en este proyecto: `get_architecture(aspects=["languages"])` devuelve solo YAML (37 archivos), cero SQF. Confirmado también en su README: SQF no aparece ni en los lenguajes con benchmark ni en "also supported". Sigue siendo la herramienta principal para todo lo que no sea SQF; para `.sqf` la autoridad sigue siendo `rg`/Serena (y ahora SQF-VM para ejecución). |
| `modelcontextprotocol/servers` (filesystem) | Redundante: Read/Write/Edit/Glob nativos ya cubren esto sin una segunda capa de permisos. |
| `MladenSU/cli-mcp-server` | Redundante y con más superficie de riesgo que el patrón ya usado en `executables.ts` (`spawn(exe, args[], shell:false)`, sin intérprete de shell de por medio). |

## Pendiente de probar, uno por uno

Verificados como reales (existen, descripción confirmada), **no instalados todavía**. Orden por
relevancia declarada; cada fila incluye qué habría que comprobar antes de adoptarlo.

| # | Herramienta | Para qué serviría | Qué comprobar al probarlo |
| --- | --- | --- | --- |
| 1 | [SQFvm/language-server](https://github.com/SQFvm/language-server) | LSP para SQF: definiciones, referencias, variables sin usar | ¿Corre limpio en Windows? ¿Lo consume el editor como un LSP normal? |
| 2 | [grumpydevorg/inkscape-mcps](https://github.com/grumpydevorg/inkscape-mcps) | MCP Inkscape multiplataforma vía CLI puro (sin D-Bus), 53★ MIT | Latencia real por llamada (dado lo lento que fue `sandraschi/inkscape-mcp`); qué tools expone de verdad |
| 3 | [aravindev/inkscape_mcp](https://github.com/aravindev/inkscape_mcp) | Control de Inkscape vía D-Bus + CLI, 36★ MIT | Si D-Bus funciona en Windows para Inkscape o cae en el mismo problema que `Shriinivas/inkmcp` |
| 4 | [casey/just](https://github.com/casey/just) + [toolprint/just-mcp](https://github.com/toolprint/just-mcp) | Exponer `hemtt`/`sqfvm`/`resvg`/`vtracer` como comandos con nombre en vez de invocación directa | Si aporta algo sobre lo que ya hace `if-media-mcp` para este dominio, o si sirve para tareas fuera de él |
| 5 | [yamadashy/repomix](https://github.com/yamadashy/repomix) | Empaquetar el repo para contexto de IA | Si aporta algo que Codebase Memory/Serena no den ya |
| 6 | [terrastruct/d2](https://github.com/terrastruct/d2) | Diagramas texto→SVG/PNG/PDF para `docs/18` (arquitectura técnica) | Sin riesgo de originalidad (compilador determinista, no generativo de arte) — el más seguro de probar |
| 7 | [watchexec/watchexec](https://github.com/watchexec/watchexec) | Re-ejecutar checks automáticamente al guardar | Utilidad marginal si ya se ejecuta check/test manualmente; bajo riesgo |
| 8 | [pre-commit/pre-commit](https://github.com/pre-commit/pre-commit) | Hooks de commit para bloquear errores antes de llegar al repo | Verificar primero si ya existe algún hook configurado en este repo antes de añadir el framework |
| 9 | [nektos/act](https://github.com/nektos/act) | Ejecutar GitHub Actions localmente | Solo aplica si el proyecto usa GitHub Actions — comprobar si existe `.github/workflows/` |
| 10 | [adamryczkowski/SVG-MCP](https://github.com/adamryczkowski/SVG-MCP), [botmonster/image2svg-mcp](https://github.com/botmonster/image2svg-mcp) | Validación/diff visual de SVG; raster→SVG alternativo a VTracer | Si aportan algo sobre `resvg` + `vtracer` ya integrados |

## Descartado sin probar (fuera de alcance declarado)

| Herramienta | Motivo |
| --- | --- |
| GenWaveLLC/svgmaker-mcp, awkoy/replicate-flux-mcp | Generación de SVG/imagen por IA (Flux, SVGMaker) — mismo problema de originalidad que OmniSVG/StarVector. |
| djeada/blender-mcp-server, ahujasid/blender-mcp | Sin caso de uso hoy: no hay ningún activo 3D en el repo. Revisar solo si el proyecto adopta assets 3D. |
| overfl0/Armaclass | Parser de `mission.sqm`; sin tarea concreta que lo requiera hoy, y cualquier escritura automática sobre `mission.sqm` choca con `AGENTS.md`. |
| Clonar CBA_A3 / ACE3 / A3-Antistasi como referencia de solo lectura | Plausible y de bajo riesgo (mods públicos, licencia abierta), pero es una decisión de flujo de trabajo, no una herramienta — evaluar cuando surja una pregunta concreta de "cómo resuelve X esto" en vez de clonar por adelantado. |

## Cómo se prueba cada candidato (protocolo, no solo lectura de README)

1. Confirmar que el repo existe y qué dice de sí mismo (ya hecho para todo lo de la tabla "pendiente").
2. Instalarlo de verdad — no asumir desde el README.
3. Ejecutar al menos una llamada real (no solo `--help`) contra un archivo/caso real del proyecto.
4. Si hay una alternativa ya integrada, comparar con un número concreto (latencia, líneas de salida, exactitud) — no solo impresión general.
5. Si no sirve, desinstalar y anotar aquí el motivo verificado antes de pasar al siguiente.
