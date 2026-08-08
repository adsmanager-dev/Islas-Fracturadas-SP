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
| [overfl0/Armaclass](https://github.com/overfl0/Armaclass) (Python, vía `.venv`) | `arma_graph_calls` y `arma_sqm_inspect`: parseo de `CfgFunctions`/`mission.sqm` en texto plano | Probado — ver detalle abajo |
| [d2lang/d2](https://github.com/d2lang/d2) | Copiado también a `tools/if-media-mcp/bin/` para uso futuro en diagramas de docs | Ya probado antes (ver sección de arriba) |

Los binarios viven en `tools/if-media-mcp/bin/` (gitignored), autodetectados sin PATH.

### Grafo de llamadas SQF y lectura de mission.sqm (2026-08-08)

Construidos a petición explícita, con el mismo rigor de verificación que el resto de este
documento — no solo "funciona en teoría":

- **`arma_graph_calls`**: tokenizador SQF propio (no regex ciego) + registro `CfgFunctions`.
  Verificado línea por línea contra el código real de Islas Fracturadas (246 aristas
  coincidiendo exactamente con lectura manual). La prueba de estrés contra
  `AI_REFERENCES/A3-Antistasi` encontró **2 bugs reales**: llamadas a variables (`call _y`) y
  a macros (`call FUNC(...)`) se ocultaban en vez de marcarse como dinámicas — corregido y
  cubierto con test antes de darlo por cerrado.
- **`arma_sqm_inspect`**: mismo patrón de derapificación (HEMTT si está binarizado, Armaclass
  si es texto plano). Verificado contra `mission.sqm` real (2 entidades) y contra Antistasi
  (1561 entidades reales: Object 985, Marker 426, Logic 53, Layer 95, Group 2 — conteo
  correcto, 0.5s de tiempo de ejecución).
- **Excepción de política registrada**: `AGENTS.md` prohibía editar `mission.sqm` fuera de
  3DEN sin excepción. A petición explícita del usuario (2026-08-08), se añadió una excepción
  acotada para las herramientas `arma_sqm_*` de este MCP — lectura siempre permitida; escritura
  solo si la herramienta implementa backup automático + validación por round-trip +
  confirmación explícita, y siempre verificada después en 3DEN.
- **Escritura implementada (`arma_sqm_patch`)**: parche quirúrgico de texto, no
  parseo-completo→regenerar-completo. Ese segundo enfoque se probó primero y se descartó: contra
  el `mission.sqm` real de Antistasi, regenerar todo el árbol vía `armaclass.generate()` infla
  el archivo 2.4× (610KB → 1.47MB) porque reformatea cada array en 4 líneas en vez de 1 —
  mismos datos, pero un diff de revisión mostraría el 100% del archivo como cambiado. El parche
  quirúrgico, en cambio, localiza el bloque exacto de la entidad por su `id` (verificado único:
  1561 IDs, 1561 entidades, sin colisiones) y solo reemplaza esa línea — verificado con `diff`
  real: 1 línea de 28643 cambia al mover una entidad. Encontró y corrigió además un bug real de
  saltos de línea (CRLF): escribir con `Path.write_text()` sin `newline=""` duplicaba cada
  `\r\n` a `\r\r\n` porque el texto ya traía los saltos de línea originales leídos en bytes.

### Resuelto por el usuario: Arma 3 Samples Pack

El "Arma 3 Samples" oficial de Bohemia (appid 390500, gratuito) solo se distribuye por Steam.
Se descargó `steamcmd.exe` (CDN oficial de Valve, verificado por tipo de contenido y tamaño) y
se intentó `+login anonymous +app_update 390500`. Falló con *"Steam needs to be online to
update"* — diagnosticado como bloqueo específico del protocolo de Steam, no de red general:
`store.steampowered.com` (HTTPS normal) respondía con 200, pero `cm0.steampowered.com`
(servidor de conexión de Steam) y el puerto TCP 27017 no respondían — diagnosticado como
restricción de firewall/puerto de este entorno, no resoluble desde la línea de comandos. El
usuario resolvió el firewall por su cuenta; el pack quedó instalado en
`D:\Programas\Steam\steamapps\common\Arma 3 Samples`. `AI_REFERENCES/A3-Antistasi` y
`KP-Liberation` se mantienen como referencia principal ya probada; el Samples Pack se suma
como fuente adicional oficial de Bohemia.

## Probado y recomendado — dominio distinto (documentación técnica, no assets de Arma)

| Herramienta | Hallazgo real | Recomendación |
| --- | --- | --- |
| [d2lang/d2](https://github.com/d2lang/d2) (repo movido desde `terrastruct/d2`, la URL vieja redirige) | Instalado en `tools/mcp-lab/bin/d2.exe` v0.7.1. Compilé un diagrama real sobre `docs/11` §27/§31 (captura militar → consolidación → NO concede legitimidad/apoyo civil/acceso Helios): **149ms**, SVG limpio. La exportación PNG/PDF *directa* del propio `d2.exe` falló: intenta descargar Playwright/Chromium de internet y no hay red hacia ese dominio en concreto. Solución real: `d2` → SVG (nativo, rápido) → `resvg` (ya integrado) → PNG. Con ese camino, la imagen final salió correcta (una advertencia cosmética de `@font-face` no soportado, sin impacto visual). | Útil para diagramas de `docs/18` (arquitectura técnica) usando el pipeline `d2 → resvg`, nunca la exportación PNG nativa de `d2`. Sin riesgo de originalidad (compilador determinista). Aún no integrado como tool en `if-media-mcp` — dominio distinto (documentación, no identidad visual/SQF); evaluar si vale la pena un tool `docs_render_diagram` cuando haya una tarea real de `docs/18` que lo necesite. |

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
| 1 | [SQFvm/language-server](https://github.com/SQFvm/language-server) | LSP para SQF: definiciones, referencias, variables sin usar | **Aviso de mantenimiento** (nuevo, 2026-08-07): en sus propios issues, el mantenedor dice que no añadirá binarios de Linux "por falta de tiempo" (#8), y hay un issue abierto de "Outdated syntax" (#10) sin resolver. Comparar en vivo contra [SkaceKamen/sqflint](https://github.com/SkaceKamen/sqflint) (Java, más antiguo, extensión propia [vscode-sqflint](https://github.com/SkaceKamen/vscode-sqflint)) antes de decidir cuál adoptar. |
| 2 | [grumpydevorg/inkscape-mcps](https://github.com/grumpydevorg/inkscape-mcps) | MCP Inkscape multiplataforma vía CLI puro (sin D-Bus), 53★ MIT | Latencia real por llamada (dado lo lento que fue `sandraschi/inkscape-mcp`); qué tools expone de verdad |
| 3 | [aravindev/inkscape_mcp](https://github.com/aravindev/inkscape_mcp) | Control de Inkscape vía D-Bus + CLI, 36★ MIT | Si D-Bus funciona en Windows para Inkscape o cae en el mismo problema que `Shriinivas/inkmcp` |
| 4 | [casey/just](https://github.com/casey/just) + [toolprint/just-mcp](https://github.com/toolprint/just-mcp) | Exponer `hemtt`/`sqfvm`/`resvg`/`vtracer` como comandos con nombre en vez de invocación directa | Si aporta algo sobre lo que ya hace `if-media-mcp` para este dominio, o si sirve para tareas fuera de él |
| 5 | [yamadashy/repomix](https://github.com/yamadashy/repomix) | Empaquetar el repo para contexto de IA | Si aporta algo que Codebase Memory/Serena no den ya |
| 6 | [watchexec/watchexec](https://github.com/watchexec/watchexec) | Re-ejecutar checks automáticamente al guardar | Utilidad marginal si ya se ejecuta check/test manualmente; bajo riesgo |
| 7 | [pre-commit/pre-commit](https://github.com/pre-commit/pre-commit) | Hooks de commit para bloquear errores antes de llegar al repo | Verificar primero si ya existe algún hook configurado en este repo antes de añadir el framework |
| 8 | [nektos/act](https://github.com/nektos/act) | Ejecutar GitHub Actions localmente | Solo aplica si el proyecto usa GitHub Actions — comprobar si existe `.github/workflows/` |
| 9 | [adamryczkowski/SVG-MCP](https://github.com/adamryczkowski/SVG-MCP), [botmonster/image2svg-mcp](https://github.com/botmonster/image2svg-mcp) | Validación/diff visual de SVG; raster→SVG alternativo a VTracer | Si aportan algo sobre `resvg` + `vtracer` ya integrados |
| 10 | [DavidAnson/markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2) | Estilo/estructura de `docs/00-19` (encabezados, listas, MD052 referencias) — **complementa** a `lychee` (que solo verifica que el destino del enlace exista, no el estilo Markdown) | Solo npm, sin binario suelto — instalar en una carpeta aislada y correr contra 1-2 archivos de `docs/` primero, no contra los 20 de golpe |
| 11 | [ajv-validator/ajv-cli](https://github.com/ajv-validator/ajv-cli) | Validar `production/media/manifests/*.json` contra un JSON Schema externo (hoy la validación es solo en tiempo de ejecución vía Zod dentro de `if-media-mcp`) | **Requiere escribir primero un JSON Schema** del `AssetManifest` — no es "instalar y listo"; sin eso no hay nada que validar |

`d2lang/d2` se movió arriba, a "Probado y recomendado" — ya no está pendiente.

### Búsquedas que no aportaron nada nuevo (2026-08-07)

- **Formateadores/linters de SQF alternativos a HEMTT**: `LordGolias/sqf` está archivado (2023, solo lectura); `LordGolias/linter-sqf` depende del editor Atom (descontinuado); `klmunday/Sqf-Linter` se declara a sí mismo "initial research/PoC"; `smitt14ua/sqf-formatter` es solo una extensión de VS Code, no un CLI. Nada de esto mejora lo ya listado (`SQFvm/language-server`, `SkaceKamen/sqflint`).
- **Extractores de PBO** (`landaire/pboextractor`, `KoffeinFlummi/armake`, `Dynulo/Gluon`, y las GUI `PboSpy`/`pboman3`/`PBO Viewer`): `armake` está marcado "(WIP)" por su propio autor y ya descartamos su sucesor `armake2` antes por el mismo motivo (HEMTT ya cubre este terreno mejor y mantenido). Los extractores CLI existen pero no hay ningún PBO de terceros en este proyecto que inspeccionar todavía — sin tarea concreta, no se persigue (mismo motivo por el que no se clonan CBA_A3/ACE3 por adelantado).

### Descargado, todavía sin probar (2026-08-07)

Descargados a `tools/mcp-lab/downloads/` (gitignored) para poder probarlos uno por uno más
adelante, sin instalar ni ejecutar nada todavía:

| Carpeta/archivo | Contenido |
| --- | --- |
| `watchexec/` | Binario extraído (`watchexec.exe`), release v2.5.1 |
| `act/` | Binario extraído (`act.exe`), release v0.2.89 |
| `just/` | Binario extraído (`just.exe`), release 1.58.0 |
| `just-mcp/` | Clon superficial (`--depth 1`) del código fuente — sin release de Windows, solo macOS |
| `language-server/` (SQFvm) | Clon superficial — sin releases en GitHub (se distribuye como extensión VS Code) |
| `repomix/` | Clon superficial — paquete npm, sin binario compilado (`npx repomix`) |
| `SVG-MCP/` | Clon superficial — sin releases |
| `image2svg-mcp/` | Clon superficial — sin binario de Windows en su release |
| `inkscape-mcps/` (grumpydevorg) | Clon superficial — sin releases, paquete Python |
| `inkscape_mcp/` (aravindev) | Clon superficial — release existe pero sin asset de Windows |
| `pre-commit/` | Clon superficial — paquete Python vía PyPI, sin binario |

Nada de esto se ha ejecutado ni instalado (`npm install`/`pip install`/`uv sync` pendientes).
Antes de probar cada uno, seguir el protocolo de la sección siguiente.

### Descargado y verificado en ejecución (2026-08-07) — de una lista de 19 candidatas nuevas

De 19 herramientas propuestas en una pasada de investigación externa, se seleccionaron 3 con
caso de uso real y verificable en este proyecto; las 16 restantes se descartaron con motivo
explícito (redundantes, sin pipeline que las necesite, o en conflicto directo con reglas ya
establecidas — ver detalle completo en el historial de la conversación que generó este
documento). Las 3 elegidas, descargadas a `tools/mcp-lab/downloads/` y **confirmadas
ejecutables** (no solo descargadas):

| Herramienta | Por qué (caso de uso real) | Verificación |
| --- | --- | --- |
| [lycheeverse/lychee](https://github.com/lycheeverse/lychee) v0.24.2 | Verificar enlaces rotos en `docs/00-19` (referencias cruzadas `docs/XX...md#anclaje`) | `lychee.exe --version` → `lychee 0.24.2` |
| [BtbN/FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds) (ffmpeg+ffprobe, build estático win64-gpl) | `docs/17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md` documenta audio/diálogo/cinemáticas — caso de uso real, no especulativo | `ffmpeg.exe -version` / `ffprobe.exe -version` → build `N-125990` |
| [biomejs/biome](https://github.com/biomejs/biome) 2.5.7 | Lint/format del propio código TS/JSON de `tools/if-media-mcp` (hoy solo tiene `tsc`) | `biome.exe --version` → `Version: 2.5.7` |

**Nota de depuración real**: la primera descarga de `biome-win32-x64.exe` quedó truncada a 47MB
de 83MB esperados (timeout de curl demasiado corto) — el archivo pasaba la detección de
cabecera PE (`file` lo reportaba como ejecutable Windows válido) pero Windows lo rechazaba
("no es una aplicación válida para esta plataforma"). Se detectó comparando el tamaño
descargado contra el tamaño exacto publicado en la API de GitHub, no asumiendo que "se ve
como un .exe" significa que funciona. Repetido con timeout mayor, tamaño exacto (83,462,656
bytes) y ejecución confirmada.

**16 descartadas de esa misma lista, con motivo concreto** (no solo "quizás más adelante"):
ImageMagick (redundante con Sharp + fallback `magick` ya existente en `findRasterizer()`),
GIMP MCP/Krita MCP (cifras de "56/80+ tools" sin verificar, mismo patrón de riesgo que
`sandraschi/inkscape-mcp`), **QGIS MCP (conflicto directo con `AGENTS.md`: "Geografía y
composiciones → Editor 3DEN, ninguna alternativa")**, ComfyUI MCP (mismo problema de
originalidad que OmniSVG/StarVector — la ejecución local no cambia que el modelo esté
entrenado con arte ajeno), DirectXTex/Compressonator/gltfpack/FreeCAD MCP (sin pipeline de
texturas DDS ni de assets 3D en el proyecto), ripgrep (ya instalado, `rg 14.1.1`), fd/jq/yq
(redundantes con Glob nativo y parseo de JSON en código), Pandoc (sin necesidad declarada,
la documentación se mantiene como `.md`), typos-cli (alto riesgo de ruido con vocabulario
SQF/Arma), Draw.io MCP (redundante con D2, ya adoptado).

### Lectura de archivos del juego y misiones existentes (reactivado 2026-08-07)

Antes descartado sin probar por "sin pregunta concreta que lo requiera hoy" — ya no aplica, el
usuario pidió explícitamente una herramienta para leer archivos del juego y misiones de Arma 3
ya implementadas (propias o de terceros) como información para construir Islas Fracturadas.

| Herramienta | Para qué | Nota |
| --- | --- | --- |
| [overfl0/Armaclass](https://github.com/overfl0/Armaclass) | Parser Python de `mission.sqm` y otras definiciones de clase — sigue siendo, según la propia búsqueda, "la solución Python más popular y mantenida" para esto | Uso de **solo lectura**: analizar, nunca escribir sobre `mission.sqm` (choca con el flujo de 3DEN de `AGENTS.md`) |
| [Knappster/arma-config2json](https://github.com/Knappster/arma-config2json) | Convierte `config.cpp`/config rapificado a JSON — útil para leer el config de un mod de referencia sin herramientas de Bohemia | Nuevo, no evaluado en profundidad |
| [Krzmbrzl/ArmaFiles](https://github.com/Krzmbrzl/ArmaFiles) (Java) | Lee tanto config texto plano como rapificado (`config.bin`) | Nuevo, no evaluado en profundidad |
| [official-antistasi-community/A3-Antistasi](https://github.com/official-antistasi-community/A3-Antistasi) | Misión completa y activa (campaña persistente, guarniciones, captura territorial, IA) — candidata principal para clonar como referencia de solo lectura | **Pendiente de tu confirmación**: es un repo de tamaño real, no un binario pequeño |
| Liberation (GreuhZbugs) | Misión CTI/Liberation de código abierto — arquitectura distinta a Antistasi para los mismos problemas (captura, persistencia), útil para comparar dos enfoques en vez de copiar uno solo | Nombre exacto de repo sin confirmar todavía |

**No clonado todavía** — antes de hacerlo, dos preguntas reales: ¿quieres que clone Antistasi,
Liberation, o ambos como referencia de solo lectura? Y, ya que `AGENTS.md` exige registrar
procedencia de material de terceros (mismo principio que `asset/PROCEDENCIA.md` aplicado aquí),
¿lo dejo fuera del control de versiones del proyecto (como los demás `downloads/`) o prefieres
una carpeta `AI_REFERENCES/` explícita y documentada?

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
