# Validación funcional — Música de apertura «Voces Partidas»

> **Estado:** `PROBADO`
> **Fecha:** 2026-08-12
> **Escenario:** `IslasFracturadas.Altis`
> **Alcance:** carga de `CfgMusic`, solicitud local única desde `postInit` y reproducción de la pista de apertura
> **Fuente:** ejecución manual confirmada por el responsable del proyecto y triaje completo del RPT local.

## Entorno

| Campo | Valor |
| --- | --- |
| Motor | Arma 3 Stable 2.20.152984 |
| Arquitectura | x64 |
| Escenario | `IslasFracturadas.Altis` |
| Diagnóstico | `BASIC` |
| Pista | `IF_Voces_Partidas_La_Isla_Hablara` |
| Runtime | `assets/music/voces_partidas/runtime/IF_Voces_Partidas_La_Isla_Hablara.ogg` |
| SHA-256 del runtime | `d5ec78553aa915bde7c632a9dc03d2630190a9a0db67630046e5207a29752a08` |

## Procedimiento observado

1. Abrir y ejecutar `IslasFracturadas.Altis` con la integración de música sincronizada.
2. Esperar a que el bootstrap complete la carga de funciones y configuración.
3. Entrar en la interfaz de misión.
4. Comprobar que «Voces Partidas — La Isla Hablará» comienza como música de apertura.
5. Confirmar que la reproducción se comporta según lo planeado y cumple el objetivo de presentación.
6. Salir de la ejecución y revisar el RPT completo.

El responsable del proyecto confirmó después de la ejecución que la pista se reprodujo correctamente,
tal como estaba planeada, y que la función cumplió su objetivo.

## Evidencia RPT

| Campo | Valor |
| --- | --- |
| Archivo original externo | `C:\Users\Admin\AppData\Local\Arma 3\arma3_x64_2026-08-12_18-48-50.rpt` |
| Tamaño | 73.345 bytes |
| Última modificación | 2026-08-12 18:59:52 -04:00 |
| SHA-256 | `BAAE0517BD37ED825D94C914828551CE77FFD07865BECD82FEFBCDD47DB199DC` |
| Lectura para triaje | archivo completo, sin truncar |

La secuencia relevante es:

| Hora | Línea | Evidencia |
| --- | ---: | --- |
| 18:51:45 | 739 | `Smoke function.musicPlayIntro: PASS` |
| 18:51:45 | 743 | `Smoke config.introMusic: PASS` |
| 18:51:45 | 751 | `postInit completado` con `introMusicRequested=true` y `PHASE_90_RUNNING` |
| 18:51:48 | 753 | `[IF][PRESENTATION][INFO] Música de apertura iniciada` para la pista esperada |

Solo existe una traza de inicio de `IF_Voces_Partidas_La_Isla_Hablara` en la ejecución revisada. No
aparecen errores ni advertencias de `CfgMusic`, `playMusic`, `PRESENTATION`, la ruta del OGG o la
decodificación de la pista.

## Mensajes no relacionados

El RPT contiene tres warnings de animaciones vanilla durante la carga y dos errores de liberación de
entidades vanilla al cerrar:

- `hubbriefing_loop`, `hubbriefing_ext` y `hubspectator_stand`;
- `ProxyFlag_Auto` con `ref_count=2`;
- `FxCartridge_556` con `ref_count=1`.

Por ubicación temporal, nombres y ausencia de correlación con la pista o el código `IF_`, se
clasifican fuera del alcance de esta integración. No impidieron la reproducción confirmada.

## Resultado

| Criterio | Resultado |
| --- | --- |
| `IF_fnc_musicPlayIntro` registrada | `PASS` |
| clase `CfgMusic` cargada | `PASS` |
| solicitud aceptada desde `postInit` | `PASS` |
| pista correcta iniciada | `PASS` |
| una sola traza de inicio en la ejecución | `PASS` |
| reproducción observable conforme al objetivo | `PASS` |
| errores RPT atribuibles a la integración | `0` |

La integración de apertura se promueve de `IMPLEMENTADO_RUNTIME_NO_PROBADO_EN_ARMA` a `PROBADO` para
este caso de uso en un jugador. Esta evidencia no convierte la campaña en jugable ni acredita futuros
activadores musicales, multijugador/JIP, reinicios dentro de una misma sesión o variantes todavía no
implementadas.

## Estado posterior a la prueba

Después de conservar esta evidencia, la reproducción automática se retiró de `postInit` por decisión
del responsable del proyecto para que la canción no influya en los arranques repetidos de desarrollo.
El OGG runtime, `CfgMusic` y `IF_fnc_musicPlayIntro` permanecen disponibles y conservan la prueba
histórica de funcionamiento; la misión actual no invoca la función automáticamente.