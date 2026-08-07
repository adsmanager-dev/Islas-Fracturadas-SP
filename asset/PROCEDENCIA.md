# Procedencia y derechos del material de referencia

> **Estado del contenedor:** registro operativo, no canon
> **Última revisión:** 2026-08-07
> **Regla rectora:** `asset/` contiene **referencia**, nunca material que se publique con la misión.

## Regla de separación

| Carpeta | Contenido | ¿Se publica con la misión? | ¿Se versiona? |
| --- | --- | --- | --- |
| `asset/reference/` | Referencia con procedencia registrada y uso concreto en el proyecto | No | Sí (única excepción de `asset/`) |
| `asset/` (raíz) | Referencia sin procedencia clara o sin uso concreto | No | No — ignorado por `.gitignore` |
| `art/` | Fuentes vectoriales originales del proyecto (`.svg`) | No (son fuente) | Sí |
| `IslasFracturadas.Altis/ui/` | Texturas `.paa` generadas desde `art/` | Sí | Sí |

Ningún archivo de `asset/` puede entrar en `art/` ni en `ui/`, ni servir de base para trazar
encima. Todo emblema del proyecto se dibuja desde cero en `art/identity/*.svg`.

## Conservado y versionado — `asset/reference/maps/`

| Archivo | Origen | Titular | Uso concreto en el proyecto | Decisión |
| --- | --- | --- | --- | --- |
| `Arma_3_map_ENG.pdf` | Material oficial de Arma 3 | Bohemia Interactive a.s. | Cartografía con topónimos; base para el mapa de sectores de [docs/10](../docs/10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md) | **Conservar** |
| `altis_satellite.webp` (antes `thumbbig-619285.webp`) | Miniatura de agregador de fondos; procedencia original de imagen no verificable, pero el contenido es vista satelital estándar de Altis sin autoría artística distintiva | No verificable | Base geográfica para trazar sectores y frentes | **Conservar** — ver límite abajo |
| `stratis_satellite.webp` (antes `thumbbig-619286.webp`) | Igual que el anterior, para Stratis | No verificable | Igual que el anterior | **Conservar** — ver límite abajo |

**Límite sobre los dos `.webp`:** se conservan por su valor de uso inmediato (trazar sectores),
no porque su procedencia esté resuelta. Antes de cualquier publicación pública del proyecto,
sustituir ambos por una captura propia del mapa satelital tomada desde el editor 3DEN
(`Arma3.exe` en `D:\Games\Arma.3.v2.20.152984(Danjipai.com)`, según memoria de sesión) o desde
`Arma_3_map_ENG.pdf`, que sí tiene titularidad clara. Esa sustitución es sencilla: incluso
generarlos con un prompt de imagen ("vista satelital estilo mapa militar de una isla
mediterránea, sin texto") produciría un resultado equivalente y sin duda de procedencia.

## Retirado el 2026-08-07 (recuperable desde la Papelera de reciclaje)

32 archivos sin procedencia clara y sin uso concreto identificado en el proyecto. Ninguno se usó
como base de ningún emblema ni de ningún sistema.

| Grupo | Cantidad | Motivo de retirada |
| --- | --- | --- |
| `arma3_screenshot_*.jpg` | 16 | Capturas del press kit de Bohemia Interactive, con marca `IN-GAME` y logotipo `ARMA III` incrustados. Propiedad de terceros; ilustran facciones de Bohemia (NATO, CSAT, AAF, ION), no las de Islas Fracturadas. |
| `thumbbig-*.webp` (salvo los dos de `reference/maps/`) | 16 | Miniaturas (~600×375) de un agregador de fondos de pantalla. Procedencia no verificable; una de ellas (`thumbbig-493645.webp`) con firma visible de un autor ajeno. Sin uso concreto identificado — a diferencia de los mapas satelitales, no alimentan ningún sistema del proyecto. |

Motivos técnicos que se suman a los de derechos, aplicables a los 32:

- ninguno estaba en `.paa`, único formato de textura que carga el motor;
- ninguno tenía lados potencia de dos, requisito de la compresión DXT;
- ninguno contenía un logotipo, emblema o insignia propios del proyecto.

## Criterio para incorporaciones futuras

Antes de añadir un archivo a `asset/reference/`, registrar en la tabla de estado: origen exacto
(URL o soporte), titular, licencia y **uso concreto** en un sistema o documento del proyecto. Sin
esas cuatro columnas, el archivo se queda en la raíz de `asset/` (no versionada) o no entra.

Para material de referencia visual del propio juego, generarlo desde la instalación local
(capturas propias, exportación del mapa desde el editor) en lugar de descargarlo: la
procedencia queda limpia y la resolución es mejor.
