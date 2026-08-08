# IF Media MCP

Servidor local compartido por Codex y Claude para generar, editar, registrar y preparar assets
visuales, y para probar SQF y leer RPT sin abrir Arma 3, sin escribir borradores dentro de la
misión.

## Estado actual

- MCP, validación de rutas, manifiestos y pruebas offline: implementados.
- Generación/edición remota del MCP: desactivadas con `IF_MEDIA_REMOTE_MODE=disabled`; no requieren ni solicitan una clave API.
- Codex usa su generador nativo cuando está disponible y registra después el resultado mediante `media_register_provenance`; Claude conserva las operaciones locales del MCP, pero no puede usar la suscripción ChatGPT Plus como credencial API.
- Rasterizado: Inkscape 1.4.4 está configurado mediante `IF_INKSCAPE`; Sharp local queda como fallback reproducible.
- PAA: se activa al detectar `ImageToPAA.exe` de Arma 3 Tools (Steam, appid 233800) **o** `hemtt.exe` (github.com/BrettMayson/HEMTT, `IF_HEMTT`) como alternativa sin Steam. Ninguno de los dos viene incluido; hay que instalar uno.
- Previsualización de legibilidad (`media_render_preview`): renderiza 32/64/128/256 px con `resvg` (github.com/linebender/resvg, `IF_RESVG`) para apoyar la verificación visual humana que sigue pendiente en `art/IDENTIDAD_VISUAL.md`; no la sustituye.
- Vectorizado de raster (`media_vectorize_raster`): usa `vtracer` (github.com/visioncortex/vtracer, `IF_VTRACER`). Exige confirmar `confirms_original_source: true` porque solo debe usarse sobre fuentes propias de Islas Fracturadas (dibujo, escaneo o textura procedural) — nunca sobre la salida de un generador de imágenes por IA.
- Prueba de SQF sin Arma 3 (`arma_test`): ejecuta un `.sqf` de `IslasFracturadas.Altis/` con `sqfvm` (github.com/SQFvm/runtime, `IF_SQFVM`). Solo lectura del script; nunca sustituye la prueba real en Arma 3/3DEN.
- Lectura de RPT (`arma_read_rpt`): lee el `.rpt` más reciente (carpeta de perfil de Arma 3 o `IF_ARMA3_RPT_DIR`) y extrae líneas con `error`/`warning`. Solo lectura; no modifica ni genera nada.
- `hemtt.exe`, `resvg.exe`, `vtracer.exe` y `sqfvm.exe` se detectan automáticamente si existen en `tools/if-media-mcp/bin/` (ignorado por Git) — cada agente/máquina los coloca ahí una vez, sin tocar PATH ni variables globales. `IF_HEMTT`/`IF_RESVG`/`IF_VTRACER`/`IF_SQFVM` siguen disponibles para apuntar a otra ruta.
- **`arma_lint` no está implementado todavía**: `hemtt check` exige un `.hemtt/project.toml` con `name`/`prefix` y una estructura de addon (`addons/<prefix>_<nombre>/`), que `IslasFracturadas.Altis/` no tiene por ser una carpeta de misión, no de addon. Añadirlo implicaría reestructurar la fuente de la misión, algo que `AGENTS.md` reserva a petición explícita — no se ha hecho a medias ni de forma silenciosa.
- Grafo de llamadas SQF (`arma_graph_calls`): construye `CfgFunctions` (vía `armaclass`; deraprifica primero con HEMTT si el archivo está binarizado) y tokeniza cada `.sqf` con un tokenizador propio (`scripts/sqf_graph.py`, distingue strings/comentarios de código real) para listar qué función llama a cuál. Devuelve solo datos (JSON en `production/media/drafts/`), sin renderizar nada visual. Las llamadas dinámicas (a variables o macros, no resolubles estáticamente) se listan aparte en `dynamic_calls`, nunca se ocultan ni se inventan como resueltas — verificado contra el código real del proyecto (246 aristas, coinciden línea por línea con lectura manual) y contra `AI_REFERENCES/A3-Antistasi` como prueba de estrés con estilo de código distinto. También acepta `--mission-sqm` para incluir llamadas hechas desde campos `init` reales de entidades (nunca `CustomAttributes/*/expression`, que es boilerplate del propio editor 3DEN). Requiere `tools/if-media-mcp/.venv` con `armaclass` instalado (`python -m venv .venv && .venv/Scripts/pip install armaclass`) o `IF_GRAPH_PYTHON` apuntando a un intérprete que ya lo tenga.
- Inspección de `mission.sqm` (`arma_sqm_inspect`): lee la misión (deraprifica con HEMTT si está binarizada) y devuelve un resumen — entidades por tipo/bando, entidades con nombre de variable (buscables por `name_filter`, p. ej. `IF_BLUE_FOB`) y con `init`. **Solo lectura**, verificado contra `mission.sqm` real de Islas Fracturadas y contra `AI_REFERENCES/A3-Antistasi` (1561 entidades reales, conteos correctos).
- Escritura de `mission.sqm` (`arma_sqm_patch`): **excepción registrada en `AGENTS.md` el 2026-08-08** a petición explícita del usuario. Cambia SOLO un campo de una entidad existente (localizada por su `id` nativo, único en todo el archivo) mediante un **parche quirúrgico de texto** (`scripts/sqm_patch.py`) — no un parseo-completo→regenerar-completo, que reformatearía el archivo entero (medido: 2.4× más grande, cada línea "cambiada" en un diff, aunque los datos fueran idénticos). Campos vectoriales (`values: [x,y,z]`): `position`, `angles`. Campos escalares (`value`): `name`/`text` (texto, con escapado de comillas dobles `""`) y `skill`/`fuel`/`healthLevel`/`damage` (número) — verificados contra ejemplos reales anidados en `class Attributes { skill=...; }` y directos en markers (`name=`/`text=`). No añade ni borra entidades, ni crea un campo que no exista ya en la entidad. Verificado con `diff` real contra `AI_REFERENCES/A3-Antistasi`: exactamente 1 línea cambia por operación, tanto para mover una entidad como para renombrarla o ajustar su `skill`. La validación por round-trip compara el **subárbol completo** de cada entidad (no solo name/init/position) para detectar cualquier cambio colateral en cualquier campo; encontró y corrigió un caso real donde patchear una entidad anidada dentro de un `Layer` marcaba falsamente a sus Layers contenedores como "cambiados" (el subárbol de un contenedor incluye a todos sus descendientes — se excluye `Entities` de la comparación de cada contenedor, ya que cada descendiente se verifica por separado). Antes de tocar el archivo real: backup automático con timestamp en `production/media/drafts/mission_sqm_backups/`, esa validación por round-trip y confirmación explícita (`confirmation: "PATCH_MISSION_SQM_APPROVED"`). Si el archivo original estaba binarizado, el resultado queda en texto plano (equivalente a activar "Binarize the Scenario File = OFF" en Eden) — **abre y comprueba la misión en 3DEN/Arma 3 después de cualquier escritura**; la herramienta no sustituye esa verificación.
- Añadir entidades a `mission.sqm` (`arma_sqm_add_object`): misma excepción de `AGENTS.md`. Añade SOLO `dataType="Object"` como último elemento del bloque `Entities` raíz (hijo directo de `Mission`) — nunca dentro de un Group/Layer existente, ni otros `dataType` (Marker/Logic/Layer/Group tienen su propia forma de serialización, no soportada aún). Investigación previa (2026-08-08) confirmó en 140 bloques `Entities` reales que los índices `ItemN` son siempre contiguos 0..N-1, por eso añadir al final es seguro; borrar cualquier entidad que no sea la última exigiría renumerar todas las posteriores, así que **borrar entidades sigue sin implementarse**. Asigna un `id` nuevo sin colisión (máximo existente + 1) y mantiene sincronizados los tres lugares que 3DEN mantiene coherentes entre sí: `items=N;` del bloque raíz, el nuevo `class ItemN` insertado, y `class EditorData { class ItemIDProvider { nextID=...; }; }` si existe (verificado: en los mapas reales probados, `nextID` es siempre `id máximo + 1`). Copia la indentación real del archivo (tabs o espacios, detectada de la última entidad hermana) para mantener el diff legible. Verificado con `diff` real contra una copia de `mission.sqm` de Islas Fracturadas y otra de `AI_REFERENCES/A3-Antistasi`: solo cambian `nextID`, `items=` y el bloque nuevo insertado, cero entidades existentes afectadas. Mismo flujo de seguridad que `arma_sqm_patch` (backup, round-trip, confirmación explícita, verificación obligatoria en 3DEN/Arma 3 después).

## Desarrollo

```powershell
Set-Location .\tools\if-media-mcp
npm install --ignore-scripts
npm run check
npm test
npm run build
```

Las configuraciones de proyecto están en `.codex/config.toml` y `.mcp.json`. Reinicia Codex/Claude o VS Code después de compilar o cambiar variables de entorno.

## Modo remoto y credenciales

El proyecto usa `IF_MEDIA_REMOTE_MODE=disabled`: `media_generate` y `media_edit` fallan de forma cerrada y no realizan llamadas externas. Si en el futuro se contrata API por separado, cambia el modo a `auto` y configura `OPENAI_API_KEY` en el entorno desde el que se inicia VS Code; nunca guardes la clave en el repositorio. Las demás herramientas son locales.

## Flujo de archivos

```text
production/media/drafts/       borradores ignorados por Git
production/media/manifests/    procedencia versionable
art/                           fuentes editables
art/export/                    PNG regenerable ignorado
IslasFracturadas.Altis/ui/     PAA final, solo tras aprobación y validación
```

Consulta `agent-skills-src/if-media-assets/SKILL.md` para el contrato completo de uso y aprobación.
