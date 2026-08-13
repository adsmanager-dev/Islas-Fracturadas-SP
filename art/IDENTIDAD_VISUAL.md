# Identidad visual — emblemas e insignias

> **Clasificación:** `PROPUESTA`
> **Fuente de verdad rectora:** [docs/15 §123–128](../docs/15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md) (arquitectura visual e identidad por facción)
> **Fuentes de apoyo:** [docs/04 §2 y §8](../docs/04_INVADING_FORCES_BLUE_AND_RED.md) (nombres, operaciones y unidades), [docs/06](../docs/06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md) (FIA, Frente Negro, «Némesis»)
> **Versión:** v2 — 2026-08-07

## Por qué este archivo no está en `docs/`

`AGENTS.md` exige mantener **20 fuentes temáticas consolidadas** en `docs/*.md` (00–19). Añadir un
archivo 20 rompería esa regla. Y estas decisiones son `PROPUESTA`: no son canon hasta que se
aprueben. Vive aquí hasta entonces.

**Destino propuesto si se aprueba:** integrar como sección nueva en
[docs/15](../docs/15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md), a continuación de §128, que ya es
el propietario de la identidad visual. **Requiere decisión humana.**

## Principio rector

> Azul conecta. Rojo concentra. Verde conserva. FIA marca. Frente Negro falsifica. Helios correlaciona.

Cada emblema debe poder resumirse en un verbo. Si una revisión futura no puede decir en una
palabra qué hace ese emblema frente a los demás, ha perdido su función de sistema y se ha vuelto
decoración intercambiable.

Regla de alcance para el símbolo maestro: **no debe contener todo el lore**. Tiene que
reconocerse en medio segundo. La profundidad narrativa se añade en variantes, numeraciones,
sellos, patrones y desgaste — no en el isotipo base. Ver «Fuera de alcance» más abajo.

## Regla de derivación

Ningún emblema se inventa. Cada uno traduce atributos ya escritos en canon. Si una decisión
gráfica no puede citar su origen, no entra.

| Facción | Verbo | Canon literal | Traducción gráfica (v2) | Archivo |
| --- | --- | --- | --- | --- |
| Azul | conecta | «azul grisáceo, paneles modulares, información técnica, estructura de coalición» (§124) + «Fuerza de Tarea Tridente» (04 §2) | Tres puntas **independientes**, de altura y ancho distintos, que no se tocan en el vértice y convergen en un travesaño fino y un núcleo romboidal. Marco técnico con **dos esquinas deliberadamente abiertas** en vez de un hexágono cerrado. | `identity/if_azur1.svg` |
| Rojo | concentra | «rojo oscuro, tonos tierra, estructura de mando, énfasis operacional» (§125) + «Operación Escudo de la Aurora» (04 §8) | Escudo macizo y cerrado. Disco **parcialmente oculto** tras la línea de tierra (no un sol pleno con rayos grandes). Una única forma de mando en V, con dos líneas de frente detrás, en vez de tres galones que leían como insignia de rango. | `identity/if_rubi1.svg` |
| Verde | conserva | «verde oliva, documentación estatal, marcas antiguas, **canales fragmentados**» (§126) | Sello circular con el anillo exterior interrumpido y el interior íntegro. Símbolo central: **columna/faro** como hito territorial y administrativo, no ancla — el ancla leía «marina/guardia costera» y Verde es Gobierno, ejército, policía e instituciones completas. | `identity/if_verde.svg` |
| FIA | marca | «documentos escaneados, anotaciones, mapas civiles, símbolos locales» (§127) + «no será una facción uniforme con una base, una bandera y una cadena de mando simple» (06) | Sin marco ni sello. Plantilla de espray con una A abierta cuyo travesaño es una **línea topográfica ondulada** (costa o carretera de montaña), no una barra recta: ancla el símbolo al territorio, no a un alfabeto genérico. | `identity/if_fia.svg` |
| Frente Negro | falsifica | «para FIA es una identidad desconocida y un símbolo»; verdad de autor: identidad operativa de Argos (06 §Némesis) | **Mismo esqueleto geométrico que FIA** (idénticos vértices y proporciones), rotado 3° y recortado en una esquina, ejecutado con líneas técnicas perfectas y travesaño industrial continuo — la relación con FIA se descubre mirando dos veces, no de un vistazo. Barra de invalidación horizontal disciplinada en vez de tachado diagonal a mano. | `identity/if_frente_negro.svg` |
| Helios | correlaciona | «diagramas de red; procedencia; auditoría; datos institucionales; advertencias de integridad» (§128) | Nodo central con **ocho conexiones a nodos terminales cuadrados** — diagrama de red, no mira. Ninguna línea cruza todo el círculo. Placa de identificación inferior para procedencia. Marca maestra perfectamente simétrica; la corrupción de Argos es material de variantes futuras, no del símbolo base. | `identity/if_helios.svg` |

## Registro de cambios v1 → v2

v1 fijaba el concepto de cada símbolo correctamente, pero varios se leían como el objeto
equivocado a primera vista. Cambios aplicados tras revisión de dirección de arte:

| Facción | Problema en v1 | Corrección en v2 |
| --- | --- | --- |
| Azul | Las dos líneas horizontales del hexágono leían como interferencia gráfica, no como parte deliberada del emblema; el tridente fusionado en la base se sentía genérico. | Marco con esquinas abiertas y marcas de cota; puntas verdaderamente independientes con espacio negativo real entre ellas. |
| Rojo | El sol con rayos grandes era demasiado literal; los tres galones leían como insignia de rango militar genérica, no como símbolo de una potencia. | Disco recortado por la línea de tierra; una sola forma de mando (V) con líneas de frente detrás. |
| Verde | El ancla dominaba la lectura y el símbolo se confundía con marina o guardia costera, un subconjunto de lo que Verde representa. | Columna/faro como hito territorial y administrativo — mantiene resonancia marítima apropiada para un archipiélago sin reducir Verde a una rama naval. |
| FIA | El travesaño recto podía leerse como una A genérica o un símbolo anarquista estándar, sin nada que lo anclara a Altis específicamente. | Travesaño convertido en línea topográfica: lee como costa o camino de montaña. |
| Frente Negro | La relación con FIA era evidente de inmediato (misma forma, solo en rojo perfecto), lo que revelaba la conexión narrativa demasiado pronto. | Mismo esqueleto pero rotado, recortado y ejecutado con precisión industrial: el parecido se descubre, no se anuncia. |
| Helios | El círculo con marcas radiales y aspa central leía como mira telescópica o radar de objetivo — el mensaje equivocado para una infraestructura, no un arma. | Reconstruido como diagrama de red: nodo central, ocho nodos terminales, sin ninguna línea que cruce todo el círculo. |

## Restricciones de estilo aplicadas

De §123, cumplidas en los seis archivos:

- fondos oscuros o neutros — todos usan base entre `#0C0C0D` y `#191411`;
- iconografía sobria — sin degradados, sin brillos, sin efectos;
- poco brillo futurista — ninguna forma sugiere ciencia ficción;
- acentos de facción — cada emblema usa exclusivamente su paleta;
- **límite «no caer en estilo improvisado ilegible»** — incluso FIA y Frente Negro, que son
  deliberadamente informales, mantienen una silueta cerrada legible a 128 px.
- **oposición de silueta Azul/Rojo** — abierto y segmentado frente a cerrado y macizo. Es la
  columna vertebral del sistema; cualquier revisión futura de cualquiera de los dos debe
  conservarla o el contraste entre campañas se pierde.

## Paletas

| Facción | Base | Medio | Acento |
| --- | --- | --- | --- |
| Azul | `#161C22` | `#8FA5B8` | `#EDF3F7` |
| Rojo | `#191411` | `#6E1F1C` | `#D9A05B` |
| Verde | `#15180F` | `#6B7A3A` | `#C5CE9E` |
| FIA | `#17150F` | `#9C7B3F` | `#D8CBA6` |
| Frente Negro | `#0C0C0D` | `#1F1F22` | `#8E1116` |
| Helios | `#101214` | `#5C6B72` | `#C8B26A` |

## Restricciones técnicas que gobiernan el dibujo

- **128×128** para insignia de unidad; lienzo cuadrado potencia de dos.
- Trazo mínimo **3 px** sobre lienzo de 128: por debajo desaparece al comprimir a DXT.
- Sin texto: ilegible a tamaño de parche de hombro.
- Silueta reconocible en monocromo, porque la insignia se ve sobre uniformes de cualquier color.
- Prueba de legibilidad progresiva antes de dar un emblema por cerrado: reconocible a 32 px,
  claro a 64 px, legible con todo su detalle a 128 px. Los seis archivos actuales ya fueron
  rasterizados con Inkscape a 128 px, pero la comprobación visual humana a 32/64/128 px y la
  conversión PAA siguen pendientes. **Pendiente de verificación visual**, no asumir legible
  en los tres tamaños hasta comprobarlo.

## Entorno de producción visual

> **Estado operativo (2026-08-07):** el servidor local `if-media` y su skill están
> `IMPLEMENTADO` y `PROBADO` mediante pruebas offline; esto no cambia la clasificación
> `PROPUESTA` de los emblemas ni acredita generación remota, conversión PAA o validación 3DEN.

Codex y Claude comparten `tools/if-media-mcp/`, que restringe los borradores a
`production/media/drafts/`, conserva manifiestos SHA-256 en `production/media/manifests/` y
detecta automáticamente rasterizador e ImageToPAA. Como ChatGPT Plus no aporta crédito API,
la generación y edición remotas del MCP están desactivadas de forma explícita y no solicitan
`OPENAI_API_KEY`. Inkscape 1.4.4 está instalado en `D:\Programas\Inkscape` y validado como
rasterizador principal; Sharp 0.35.3 permanece como fallback reproducible del proyecto.
`ImageToPAA` sigue pendiente porque Arma 3 Tools/Steam no está instalado en esta máquina; el
MCP y `tools/Build-Assets.ps1` aceptan además `HEMTT` (`hemtt utils paa convert`, `IF_HEMTT`)
como conversor PAA alternativo que no requiere cuenta de Steam — sigue pendiente instalarlo y
validar el resultado en Arma 3/3DEN antes de confiar en él.
Codex puede emplear además su generador nativo y registrar la salida en el mismo contrato de
procedencia; esa disponibilidad no aprueba ninguna imagen ni sustituye la revisión humana.

Dos herramientas locales adicionales, ninguna instalada todavía en esta máquina:
`media_render_preview` (motor `resvg`, `IF_RESVG`) genera los PNG de 32/64/128 px que la
sección anterior marca como pendientes de verificación visual — sigue siendo una persona quien
juzga la legibilidad, la herramienta solo produce las imágenes. `media_vectorize_raster`
(motor `vtracer`, `IF_VTRACER`) convierte raster a SVG solo para fuentes propias del proyecto
(dibujo, escaneo, textura procedural); exige confirmar `confirms_original_source: true` y
nunca debe usarse sobre la salida de un generador de imágenes por IA, para no reintroducir por
otra vía el riesgo de originalidad que el resto de este documento evita deliberadamente.

No incluir `ui/cfg/CfgUnitInsignia.hpp` desde `description.ext` mientras no existan `.paa`
válidos y se hayan revisado en Arma 3/3DEN junto con el RPT.

## Fuera de alcance de esta pasada — hoja de ruta

Un emblema maestro no sostiene por sí solo parches, vehículos, documentos, pantallas,
propaganda y cinemáticas. Lo que sigue está identificado pero **no construido**:

| Familia | Uso previsto | Estado |
| --- | --- | --- |
| `mark_primary` | símbolo puro | **Hecho** — los seis `.svg` actuales |
| `mark_monochrome` | HUD / mapa | No iniciado |
| `mark_inverse` | fondos claros | No iniciado |
| `patch_field` / `patch_command` | parche de uniforme, tropa y oficiales | No iniciado |
| `vehicle_decal` | vehículos | No iniciado |
| `stencil_large` | cajas / base | No iniciado |
| `document_seal` | documentos, briefings | No iniciado |
| `map_marker` | UI estratégica | No iniciado |
| `weathered_01–04` | desgaste en mundo | No iniciado |
| `propaganda_variant` | carteles | No iniciado |
| `captured_variant` | material capturado | No iniciado |
| Variantes de aplicación FIA (plantilla limpia, espray rápido, rotulador, sello clandestino, pintado sobre vehículo, deteriorado, por célula) | reforzar que FIA no es uniforme | No iniciado — es la extensión con más rendimiento narrativo por esfuerzo si se prioriza algo primero |
| Variante de integridad rota de Helios (nodo ausente, ruta invertida, checksum incorrecto) | material de Argos/manipulación | No iniciado — deliberadamente fuera de la marca maestra |

No convertir esta tabla en trabajo hecho. Cada fila pasa a «Hecho» solo cuando exista el archivo
correspondiente en el repositorio.

## Decisiones abiertas

1. **Aprobación de canon.** ¿Se integran estos seis en docs/15 a continuación de §128, o se
   mantienen como propuesta?
2. **Frente Negro seleccionable.** Está declarado en `CfgUnitInsignia`, lo que lo hace visible en
   el Arsenal Virtual. Narrativamente su fuerza depende de que **no** sea una identidad que el
   jugador elige. Propuesta: retirarlo del config y aplicarlo solo por script en escenas
   concretas.
3. **Azul y Rojo son coaliciones, no naciones.** Ninguno lleva bandera nacional, por decisión
   derivada de docs/04 §1. Conviene confirmarlo antes de producir más material.
4. **Migración a addon.** `CfgUnitInsignia` en `description.ext` es fiable en SP; en cooperativo
   hay que moverlo a un addon. Decidir cuándo, en coherencia con docs/18.
5. **Orden sugerido si se prioriza extender la familia de assets:** Helios (define el misterio
   del proyecto) → Azul y Rojo (las dos identidades que el jugador lleva más tiempo) → Verde
   (crecer de «ejército» a «Estado» en aplicaciones) → FIA (sistema de variantes clandestinas,
   alto rendimiento narrativo) → Frente Negro (depende de tener ya la geometría final de FIA).
