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
| [pre-commit/pre-commit](https://github.com/pre-commit/pre-commit) | Automatiza en un git hook lo que `AGENTS.md` ya exigía hacer a mano tras cambios funcionales | **Instalado (2026-08-08)** vía `uv tool install pre-commit` (aislado, sin tocar pip global) y `pre-commit install` — ver detalle abajo |

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
- **Extensión a campos escalares (`name`/`text`/`skill`/`fuel`/`healthLevel`/`damage`)**: mismo
  patrón de parche quirúrgico, generalizado a un registro `SCALAR_FIELD_PATTERN` (string con
  escapado de comillas dobles `""`, o número con notación científica). Verificado con `diff`
  real contra `AI_REFERENCES/A3-Antistasi`: renombrar un marcador (`name="airp_mortar_1"` →
  con comillas embebidas) y subir el `skill` de un objeto anidado dentro de dos `class
  Attributes`/`Layer` cambiaron exactamente 1 línea cada uno. **Encontró un bug real** al
  endurecer la validación de round-trip: comparar el subárbol crudo completo de cada entidad
  (en vez de la proyección reducida de `sqm_inspect`, que ni siquiera conocía `skill`) hizo que
  los dos `Layer` contenedores de la entidad parcheada aparecieran como "cambiados" — porque el
  subárbol de un `Layer`/`Group` incluye literalmente a todos sus descendientes, así que
  cualquier cambio en un hijo se refleja también en el padre. No era corrupción real: se
  corrigió excluyendo la clave `Entities` de lo que se compara por contenedor (cada descendiente
  ya se verifica por separado en su propia entrada del índice) — cubierto con un test de
  regresión (`test_ancestor_layer_not_flagged_when_nested_child_is_patched`).
- **Investigación de contigüidad de `ItemN`** (prerrequisito para añadir/borrar entidades):
  se revisaron los 140 bloques `class Entities { items=N; ... }` anidados en 3 archivos reales
  (proyecto propio + 2 mapas de Antistasi) — en los 140, los índices son siempre `0..N-1` sin
  huecos y coinciden con `items=N`. Conclusión: **añadir** al final es seguro (basta incrementar
  `items=`); **borrar** cualquier entidad que no sea la última exigiría renumerar todas las
  posteriores del mismo bloque — se deja sin implementar por ahora.
- **Añadir entidades (`arma_sqm_add_object`)**: implementado SOLO para `dataType="Object"`
  anexado al final del bloque `Entities` raíz (hijo directo de `Mission`), reutilizando el mismo
  patrón de parche quirúrgico. Descubrimiento real durante el diseño: `class EditorData { class
  ItemIDProvider { nextID=...; }; }` es el contador de IDs propio de 3DEN — verificado en los 3
  archivos reales que `nextID` es siempre exactamente `id máximo existente + 1` (2026-08-08: nuestro
  proyecto tenía `nextID=2` con ids 0/1; Antistasi_Enoch tenía `nextID=3493` con id máximo 3492;
  Antistasi_vt7 igual). Si no se actualiza `nextID` al añadir una entidad, un humano usando 3DEN
  después podría recibir el mismo id que se acaba de asignar por herramienta — por eso el patch
  sincroniza los tres lugares (`nextID`, `items=`, el bloque nuevo) en una sola operación.
  **Encontró un bug real de inserción** en la primera prueba de estrés: `find_entity_block_span`
  devuelve el final del bloque justo tras el `}` de cierre, SIN el `;` que Arma exige después
  (`class ItemN { ... };`) — insertar ahí partía en dos la declaración de la entidad hermana
  anterior (`}` quedaba separado de su propio `;`), produciendo un `mission.sqm` que ni siquiera
  volvía a parsear. Corregido saltando ese `;` antes de insertar, con test de regresión
  (`test_new_block_is_parseable_and_has_expected_shape`, que reparsea el resultado completo).
  También se detectó que un fallo de re-parseo tras insertar lanzaba una excepción sin capturar
  (`armaclass.parser.ParseError`) en vez de un `PatchError` limpio — corregido; en ambos casos
  no se escribe nada en disco antes de que la validación pase. Verificado con `diff` real contra
  copias de `mission.sqm` de Islas Fracturadas (indentación de 4 espacios) y de Antistasi_Enoch
  (indentación de tabs): la herramienta detectó y replicó el estilo de indentación de cada
  archivo correctamente; en ambos casos solo cambiaron `nextID`, `items=` y el bloque insertado,
  cero entidades existentes afectadas. Probado también en vivo por el protocolo MCP real (stdio,
  no solo el script directo) contra una copia desechable dentro de `IslasFracturadas.Altis/`.
- **Borrar entidades (`arma_sqm_delete_entity`)**: simétrico de `arma_sqm_add_object` — solo
  borra la ÚLTIMA entidad del bloque `Entities` raíz (misma razón que justifica solo-añadir-al-
  final: renumerar `ItemN` intermedios queda fuera de alcance). Rechaza también borrar la única
  entidad restante (dejaría el bloque vacío, el mismo caso límite sin hermana de referencia que
  `add_object_entity` tampoco soporta al revés). Deliberadamente NO decrementa `nextID` (sin
  evidencia de que 3DEN reutilice IDs liberados, dejarlo intacto es el lado seguro).
  **Encontró un segundo bug real** en la prueba de ida-y-vuelta (añadir una entidad a una copia
  real de Antistasi y borrar esa misma entidad después): el primer test unitario de simetría
  (`test_add_then_delete_is_symmetric`) solo comparaba `armaclass.parse(resultado) ==
  armaclass.parse(original)` — una comparación **estructural**, no de bytes — y pasaba a pesar
  del bug porque `armaclass.parse()` ignora diferencias de espacios en blanco. El bug real: el
  borrado anclaba la eliminación en el inicio de línea de la propia entidad a borrar, dejando
  huérfano el salto de línea que separaba esa entidad de la anterior (el mismo salto de línea que
  `add_object_entity` insertó al añadirla) — resultado: una línea en blanco sobrante. Solo se
  detectó al hacer la prueba de ida-y-vuelta contra el archivo real de ~470 KB de Antistasi y
  comparar con `diff` línea por línea. Corregido anclando el borrado en el final de la entidad
  ANTERIOR (mismo punto donde `add_object_entity` insertó), no en el inicio de la propia línea
  borrada; el test unitario se reforzó a `self.assertEqual(restored, SAMPLE)` (bytes, no
  estructura) para que un caso así no pueda volver a pasar inadvertido. Tras la corrección,
  verificado que un ciclo añadir+borrar contra la copia real de Antistasi produce un archivo
  **byte-idéntico al original salvo `nextID`** (que se queda deliberadamente adelantado en uno).

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

## Candidatos probados en vivo (2026-08-08)

Los 9 primeros candidatos de la lista anterior ya se probaron de verdad (instalados/ejecutados,
no solo leídos). Solo quedan pendientes los ítems 10-11 (ver tabla al final de esta sección).

### 1. LSP para SQF: SQFvm/language-server vs SkaceKamen/sqflint — ambos descartados

- **[SQFvm/language-server](https://github.com/SQFvm/language-server)**: **cero releases en GitHub**
  (`gh api repos/SQFvm/language-server/releases` → `[]`). C++, último commit 2024-09-05 (~2 años),
  29 issues abiertos. Sin binario ni instrucciones de build verificadas — habría que compilarlo
  desde cero. Descartado por costo/beneficio sin llegar a compilarlo.
- **[SkaceKamen/sqflint](https://github.com/SkaceKamen/sqflint)**: sí tiene releases reales de
  Windows (`sqflint-070.zip`, verificado tamaño exacto 332027 bytes vs lo reportado por la API).
  Requería un JRE que esta máquina no tenía — **se instaló un Temurin 21 portable** (zip, no
  instalador, vendorizado en `tools/mcp-lab/bin/`, sin tocar el sistema) solo para poder probarlo
  de verdad, a petición explícita del usuario. Con Java funcionando: el self-test del propio
  paquete (`sqflinttest.bat`) pasó, pero al probarlo contra `IslasFracturadas.Altis/core/bootstrap/
  fn_bootstrapPostInit.sqf` (código real, en uso) produjo **más de una docena de falsos positivos
  de sintaxis** ("Encountered ';'... was expecting one of [lista larga sin muchos tokens válidos
  de SQF moderno]"), incluyendo una cascada de errores repetidos al final del archivo. Se
  confirmó con un segundo archivo real (`fn_clockAdvance.sqf`) — mismo patrón. **Contraprueba
  decisiva**: `sqfvm` (ya adoptado) analiza el mismo `fn_clockAdvance.sqf` sin ningún error de
  sintaxis — solo reporta `[NOT IMPLEMENTED] isserver`, el tipo de aviso esperado de un intérprete
  headless sin todo el motor de Arma, no un fallo de parseo. Conclusión: la gramática de `sqflint`
  está desactualizada para SQF real y actual de este proyecto — **descartado por incompatibilidad
  funcional demostrada, no solo por antigüedad declarada**.

### 2-3. MCP para Inkscape: ambos funcionan de verdad (a diferencia de candidatos previos)

- **[grumpydevorg/inkscape-mcps](https://github.com/grumpydevorg/inkscape-mcps)**: metadatos de
  plantilla sin rellenar (`authors = "Your Name" <your.email@example.com>`, URL de git
  `yourusername/inkscape-mcp` en el propio README) — señal de alarma similar a candidatos ya
  descartados. Pero el código **funciona de verdad**: instalado en un venv aislado (`uv venv` +
  `uv pip install -e .`), probado por protocolo MCP real (no solo `--help`): `dom_validate` y
  `dom_set` (cambiar `fill` de un `<circle>` por selector CSS) funcionaron correctamente,
  verificado leyendo el SVG de salida. `action_run` (exportar a PNG vía Inkscape real) también
  funcionó, PNG real de 1318 bytes generado. **Bug real encontrado**: `action_list` falla con
  `'utf-8' codec can't decode byte 0xf3` — la salida de Inkscape en este Windows en español
  (con tildes) no se decodifica con el códec correcto. No es D-Bus (usa CLI puro, por eso
  funciona en Windows a diferencia de `Shriinivas/inkmcp`).
- **[aravindev/inkscape_mcp](https://github.com/aravindev/inkscape_mcp)**: paquete real publicado
  en PyPI (`inkscape-mcp`), con CI, probado explícitamente por sus autores con Inkscape 1.4.4 —
  la misma versión que ya usa este proyecto (`IF_INKSCAPE`). Instalado desde PyPI real (no el
  clon), probado por protocolo MCP: expone exactamente los 8 tools que documenta (`inkscape_file`,
  `inkscape_vector`, `inkscape_analysis`, `inkscape_system`, `inkscape_gradient`,
  `inkscape_metadata`, `inkscape_live`, `inkscape_extension`). `inkscape_system(operation=
  "diagnostics")` detectó el Inkscape instalado correctamente (`all_passed: true`).
  `inkscape_analysis(operation="dimensions")` funcionó pero tardó **7.6 segundos** para una sola
  consulta (arrancar Inkscape completo tiene coste, igual que ya se había visto con
  `sandraschi/inkscape-mcp`) y devolvió el bounding box del dibujo (60×60) en vez del `width`/
  `height` declarado del `<svg>` (100×100) — un detalle de semántica de Inkscape a tener en
  cuenta, no un bug. El puente `inkscape_live` (D-Bus) necesita `dbus-daemon` vía MSYS2 en
  Windows, tal como sospechaba la entrada anterior de esta tabla — no probado, no hace falta para
  este proyecto (no se necesita control de una ventana de Inkscape abierta).
- **Veredicto para ambos**: funcionan genuinamente, sin necesidad concreta declarada hoy que los
  requiera (if-media-mcp ya cubre rasterizar/vectorizar/previsualizar). Quedan como candidatos
  viables si en el futuro hace falta edición de SVG por selector CSS o el resto de la superficie
  de Inkscape — no se integran sin esa necesidad, mismo criterio que con `d2lang/d2`.

### 4. just + just-mcp — CLI real, MCP bloqueado en Windows

`just.exe` (ya descargado) funciona correctamente: se escribió un `justfile` real exponiendo
`hemtt --version`/`resvg --version` como comandos con nombre, `just --list` y la ejecución
funcionaron. (Se descubrió de paso que `hemtt.exe --version` sale con código 1 incluso en éxito —
comportamiento propio de HEMTT, no de `just`; confirmado que `findHemtt()` en `executables.ts`
solo comprueba que el archivo exista, no su código de salida, así que esto no afecta nada ya
integrado.) Pero `just-mcp` — la capa MCP que haría esto invocable por un agente — **no tiene
release de Windows** (solo macOS, confirmado en el clon superficial). Sin la capa MCP no hay
forma de exponerlo como herramienta del agente en esta máquina; descartado para este uso hasta
que exista un build de Windows.

### 5. repomix — funciona, valor bajo dado que Claude Code ya tiene acceso directo a archivos

Probado con `npx --yes repomix` (sin instalar nada de forma persistente) contra un subconjunto
real (`tools/if-media-mcp/src/**/*.ts`): empaquetó 5 archivos, conteo de tokens correcto, escáner
de secretos incorporado (no encontró nada, correcto). Funciona genuinamente. Pero su caso de uso
real — "dale a un modelo sin acceso a archivos el código completo como un solo bloque" — no
aplica aquí: Claude Code ya lee/busca archivos directamente, así que empaquetar todo en un blob
no aporta sobre lo que ya hace Read/Glob/Grep de forma dirigida.

### 6. watchexec — funciona, sin necesidad concreta hoy

Probado el binario ya descargado (`watchexec.exe` 2.5.1) vigilando un archivo real y modificándolo
en marcha: el log del propio watchexec mostró `[Running: touch log.txt]` dos veces (arranque +
tras el cambio detectado), confirmando que la detección de cambios y re-ejecución funciona. El
archivo `log.txt` no se creó porque `touch` no se resuelve igual cuando `watchexec` lanza el
proceso directamente en Windows (detalle de cómo se invoca el comando hijo, no un fallo de
watchexec en sí). Utilidad marginal mientras `npm run check`/`npm test` se sigan ejecutando a
mano; no se integra sin una necesidad concreta.

### 7. pre-commit — ADOPTADO (2026-08-08)

Probado primero en un venv aislado (`pip install pre-commit`), `pre-commit --version` → `4.6.1`.
Verificado explícitamente lo que pedía la fila original de esta tabla: este repo **no tenía
ningún hook activo** (`.git/hooks/` solo tenía los `.sample` que trae Git por defecto, sin
`.pre-commit-config.yaml`, sin `core.hooksPath` configurado) — así que adoptarlo no chocaba con
nada existente.

A petición explícita del usuario ("integra lo que funcione"), se integró de verdad:

- `pre-commit` instalado como herramienta aislada vía `uv tool install pre-commit` (no toca pip
  global, reversible con `uv tool uninstall pre-commit`).
- `.pre-commit-config.yaml` (raíz del repo) con 3 hooks locales (`language: system`, sin
  descargar nada de red): `git diff --check --cached` (conflictos/espacios en blanco), `npm
  --prefix tools/if-media-mcp run check` (solo si cambian `.ts` de if-media-mcp) y `semgrep scan
  --config .semgrep.yml --metrics off --no-git-ignore IslasFracturadas.Altis` (solo si cambian
  `.sqf`) — **exactamente los comandos que `AGENTS.md` ya exigía correr a mano**, ahora
  automatizados, nada nuevo inventado.
- Hook activado con `pre-commit install` → `.git/hooks/pre-commit`.
- **Verificado en ambas direcciones, no solo que "no falle"**: `pre-commit run --all-files` pasó
  los 3 hooks contra el estado real del repo; una prueba negativa deliberada (un `.ts` con un
  error de tipos real) hizo que el hook `if-media-mcp-check` fallara correctamente con el error
  real de `tsc` y código de salida distinto de cero — confirma que el hook realmente bloquea, no
  solo que siempre reporta éxito.

### 8. act — no aplica

Confirmado: este repo no tiene `.github/workflows/` (no usa GitHub Actions). `act` no tiene nada
que ejecutar aquí. No es un descarte por defecto de la herramienta, es que la condición de uso
("solo aplica si el proyecto usa GitHub Actions") no se cumple.

### 9. SVG-MCP funciona y aporta capacidad nueva; image2svg-mcp confirmado redundante

- **[botmonster/image2svg-mcp](https://github.com/botmonster/image2svg-mcp)**: su propio
  `pyproject.toml` declara `vtracer>=0.6.15` como dependencia — el **mismo motor** que ya usa
  `media_vectorize_raster`. Redundancia confirmada por evidencia directa (la propia dependencia),
  sin necesidad de instalarlo para comprobarlo.
- **[adamryczkowski/SVG-MCP](https://github.com/adamryczkowski/SVG-MCP)**: pila técnica distinta
  (`cairosvg`, `pixelmatch`, `scour` — no `resvg`/`vtracer`). Instalado en venv aislado, probado
  contra un emblema real del proyecto (`art/identity/if_helios.svg`):
  - `svg-mcp validate` → `✓ SVG is valid`, 35 elementos, viewBox `0 0 128 128` (coincide con lo
    ya sabido de estos assets).
  - `svg-mcp lint` → `✓ SVG passed linting`, con un aviso real y accionable: "Path data could be
    optimized for smaller file size" sugiriendo `svg_optimize`. Esto es una capacidad que
    if-media-mcp **no tiene hoy** (ni linter de compatibilidad Inkscape/librsvg ni optimizador).
  - `svg-mcp render` funcionó pero tardó **2.6s** para un PNG de 256×256 — mucho más lento que
    `resvg` (ya adoptado, ~100ms por tamaño); para renderizar, `resvg` sigue siendo claramente
    mejor. El valor real de SVG-MCP está en `lint`/`optimize`/`diff`, no en `render`.
  - **Integración abandonada (2026-08-08) al intentarla de verdad**: todo lo anterior se probó
    contra el clon local (versión `0.2.0` de su `pyproject.toml`, sin publicar). Al instalar el
    paquete REAL de PyPI para integrarlo en `if-media-mcp` (`svg-mcp==0.4.4`, la única versión
    publicada), resultó ser un proyecto **completamente distinto**: el propio resumen de PyPI dice
    "structured, hierarchical SVG authoring with a render-and-see feedback loop" — sin
    subcomandos `validate`/`lint`/`optimize`, solo un servidor MCP (`svg-mcp [--transport ...]`)
    con un modelo de documento para *crear* SVG, no para *auditar* uno existente. Se inspeccionó
    el código fuente instalado (`svg_mcp/query/`, `svg_mcp/ops/`, `svg_mcp/model/`) y no existe
    ningún concepto de "lint" o "compatibilidad Inkscape/librsvg" en la versión publicada. El
    autor giró el proyecto entre `0.2.0` (el CLI simple que se probó) y `0.4.4` (autoría
    estructurada de documentos) — son, en la práctica, dos herramientas distintas bajo el mismo
    nombre. No se ancló a la versión vieja (`0.2.0`) para forzar la integración: sería depender de
    una versión no publicada/no mantenida solo para conseguir un comportamiento que el proyecto
    real ya abandonó. **Veredicto final: no integrado.** Si en el futuro hace falta lint/optimize
    de SVG, la vía más simple y estable sería envolver `scour` directamente (el optimizador que
    `SVG-MCP 0.2.0` usaba por debajo) en vez de depender de este paquete.

### Nota sobre limpieza de artefactos de prueba

Para probar `sqflint` se instaló un JDK Temurin 21 portable (~525 MB, nunca tocó el sistema/PATH)
y para los candidatos Python se crearon varios entornos virtuales de prueba (`*/.venv-test/`,
~150 MB cada uno, más `tools/if-media-mcp/.venv-svg/` del intento de integración de SVG-MCP,
~167 MB) — todo ignorado por Git (se añadió `.venv-svg/` al `.gitignore` explícitamente como red
de seguridad). El borrado inicial fue bloqueado por el sistema de permisos de la sesión (denegado
tanto por `rm -rf` como por `Remove-Item -Recurse -Force`); el usuario lo borró manualmente
(2026-08-08) con el comando que se le indicó — **confirmado: las 5 rutas ya no existen**.

**Reorganización final (2026-08-08)**: con todo ya probado, `tools/mcp-lab/downloads/` se
reordenó en `futuros/` (candidatos que funcionan, sin necesidad concreta hoy) y `descartados/`
(no funcionan, están bloqueados, o quedaron superados por la integración real) — ver tabla en
"Organización de `tools/mcp-lab/` tras probar todo" más abajo. De paso: mover `inkscape-mcps/` e
`inkscape_mcp/` con `mv` falló de forma intermitente (`Permission denied` en carpetas con
ejecutables recién tocados, probablemente antivirus escaneándolos) incluso tras liberar espacio en
disco — se resolvió con `robocopy /E /MOVE /R:3 /W:5`, que reintenta automáticamente en vez de
fallar a la primera. Nota aparte, no relacionada con esta limpieza: durante el proceso se descubrió
que el disco `D:` tenía solo ~48 MB libres (mal leídos inicialmente como ~4.7 GB por un error de
interpretación de la salida de `wmic`, con dígitos separados por espacios) — el usuario liberó
espacio manualmente antes de que la reorganización pudiera completarse del todo.

**Incidente real durante la prueba de `watchexec`**: el proceso de vigilancia lanzado en segundo
plano no terminó con el `kill` emitido tras la prueba (el PID capturado no correspondía al proceso
real, un problema conocido al mezclar `nohup`/`&` de Git Bash con binarios nativos de Windows) y
quedó corriendo varios minutos, además de crear un archivo (`watched.txt`) dentro de
`tools/if-media-mcp/` en vez de en el directorio temporal esperado — se detectó por `git status`
mostrando un archivo inesperado, se confirmó el proceso huérfano con `tasklist`, se terminó con
`Stop-Process -Name watchexec -Force` (PowerShell, no `kill` de bash) y se borró el archivo. Lección
para pruebas futuras con herramientas que lanzan procesos de larga duración en Windows vía Git
Bash: verificar el PID real y el directorio de trabajo efectivo, no asumirlos.

## Pendiente de probar, uno por uno

| # | Herramienta | Para qué serviría | Qué comprobar al probarlo |
| --- | --- | --- | --- |
| 10 | [DavidAnson/markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2) | Estilo/estructura de `docs/00-19` (encabezados, listas, MD052 referencias) — **complementa** a `lychee` (que solo verifica que el destino del enlace exista, no el estilo Markdown) | Solo npm, sin binario suelto — instalar en una carpeta aislada y correr contra 1-2 archivos de `docs/` primero, no contra los 20 de golpe |
| 11 | [ajv-validator/ajv-cli](https://github.com/ajv-validator/ajv-cli) | Validar `production/media/manifests/*.json` contra un JSON Schema externo (hoy la validación es solo en tiempo de ejecución vía Zod dentro de `if-media-mcp`) | **Requiere escribir primero un JSON Schema** del `AssetManifest` — no es "instalar y listo"; sin eso no hay nada que validar |

`d2lang/d2` se movió arriba, a "Probado y recomendado" — ya no está pendiente.

### Búsquedas que no aportaron nada nuevo (2026-08-07)

- **Formateadores/linters de SQF alternativos a HEMTT**: `LordGolias/sqf` está archivado (2023, solo lectura); `LordGolias/linter-sqf` depende del editor Atom (descontinuado); `klmunday/Sqf-Linter` se declara a sí mismo "initial research/PoC"; `smitt14ua/sqf-formatter` es solo una extensión de VS Code, no un CLI. Nada de esto mejora lo ya listado (`SQFvm/language-server`, `SkaceKamen/sqflint`).
- **Extractores de PBO** (`landaire/pboextractor`, `KoffeinFlummi/armake`, `Dynulo/Gluon`, y las GUI `PboSpy`/`pboman3`/`PBO Viewer`): `armake` está marcado "(WIP)" por su propio autor y ya descartamos su sucesor `armake2` antes por el mismo motivo (HEMTT ya cubre este terreno mejor y mantenido). Los extractores CLI existen pero no hay ningún PBO de terceros en este proyecto que inspeccionar todavía — sin tarea concreta, no se persigue (mismo motivo por el que no se clonan CBA_A3/ACE3 por adelantado).

### Organización de `tools/mcp-lab/` tras probar todo (2026-08-08)

Todo lo de esta sección ya se probó de verdad (ver "Candidatos probados en vivo" más arriba).
`tools/mcp-lab/downloads/` quedó reorganizado en dos carpetas, para separar "puede servir más
adelante" de "descartado, no reabrir sin una razón nueva":

| Carpeta | Contenido | Por qué está ahí |
| --- | --- | --- |
| `downloads/futuros/act/` | Binario `act.exe` v0.2.89 | Funciona; solo falta que el proyecto use GitHub Actions |
| `downloads/futuros/just/` | Binario `just.exe` 1.58.0 | Funciona como CLI; `just-mcp` (la capa agente) no |
| `downloads/futuros/watchexec/` | Binario `watchexec.exe` 2.5.1 | Funciona (detecta cambios y re-ejecuta); sin necesidad concreta hoy |
| `downloads/futuros/inkscape-mcps/` | Clon con historial git completo | Funciona de verdad (DOM de SVG por selector CSS); 1 bug real conocido (`action_list`) |
| `downloads/futuros/inkscape_mcp/` | Clon con historial git completo | Funciona de verdad (8 tools), lento (~7.6s/llamada) |
| `downloads/descartados/sqflint/` | Release extraído (`SQFLint.jar`, `sqflint.exe`) | Gramática desactualizada, falsos positivos en SQF real |
| `downloads/descartados/language-server/` | Clon superficial (SQFvm) | Sin releases en GitHub — **pero sí se distribuye vía extensión de VS Code** (confirmado 2026-08-08: el usuario tiene `sqfvm_language_server.exe` corriendo en su propio VS Code, lanzado por una extensión SQF instalada — la extensión empaqueta su propio binario compilado por una vía distinta a GitHub Releases). No cambia el veredicto de fondo (`arma_graph_calls` ya cubre el grafo de llamadas, `sqfvm` ya cubre la ejecución), pero corrige la afirmación de que "no hay ningún binario en ningún sitio". |
| `downloads/descartados/image2svg-mcp/` | Clon superficial | Redundante — depende literalmente de `vtracer`, ya adoptado |
| `downloads/descartados/SVG-MCP/` | Clon superficial (versión `0.2.0`, no publicada) | La versión real de PyPI (`0.4.4`) es un proyecto distinto sin `lint`/`validate` |
| `downloads/descartados/just-mcp/` | Clon superficial | Sin release de Windows |
| `downloads/descartados/repomix/` | Clon superficial | Uso real es vía `npx repomix` (descarga al vuelo); el clon no aporta nada persistente |
| `downloads/descartados/pre-commit/` | Clon superficial | El `pre-commit` real adoptado se instaló vía `uv tool install`, no desde este clon |

`tools/mcp-lab/bin/` quedó solo con binarios standalone realmente adoptados para uso manual
(`biome.exe`, `ffmpeg/`, `lychee/`) — el `d2.exe` que había ahí era un duplicado del ya vendorizado
en `tools/if-media-mcp/bin/d2.exe` (el que usa el servidor de verdad), se eliminó la copia
redundante.

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
