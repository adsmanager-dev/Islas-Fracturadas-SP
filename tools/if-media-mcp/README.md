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
