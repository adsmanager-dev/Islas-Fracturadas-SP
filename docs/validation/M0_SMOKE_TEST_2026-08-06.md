# Validación funcional — M0 Esqueleto técnico ejecutable

> **Estado:** `PROBADO`; `M0 APROBADO`
> **Fecha:** 2026-08-06
> **Escenario:** `IslasFracturadas.Altis`
> **Implementación:** commit `4b0b1ba`, sobre baseline `4150383`
> **Fuente:** ejecución manual comunicada por el responsable del proyecto, capturas aportadas y triaje del RPT local.

## Entorno

| Campo | Valor |
| --- | --- |
| Motor | Arma 3 Stable 2.20.152984 |
| Arquitectura ejecutada | x86 / 32 bits |
| Memoria virtual registrada | 4 GiB |
| Fixture | un jugador `B_Soldier_F` vanilla en Altis |
| Diagnóstico | `BASIC` |

La ejecución x86 es suficiente para validar carga y comportamiento funcional de M0. No se usa como evidencia de rendimiento; los benchmarks posteriores se ejecutarán en x64.

## Procedimiento reproducido

1. Reabrir `IslasFracturadas` en Eden para recargar `description.ext`.
2. Ejecutar la vista previa con diagnóstico `BASIC`.
3. Esperar el bootstrap y confirmar que el jugador entra al mundo.
4. Salir a Eden y repetir el arranque.
5. Revisar la ventana de misión y las entradas `[IF]` del RPT.

## Evidencia visual

Las capturas aportadas muestran:

- pantalla de carga `ISLAS FRACTURADAS - M0` y texto `Esqueleto técnico ejecutable`;
- entrada correcta al mundo con el fusilero controlable;
- aviso del motor indicando ejecución de 32 bits.

Las imágenes se aportaron en la sesión de validación y no se copiaron al repositorio.

## Evidencia RPT

| Campo | Valor |
| --- | --- |
| Archivo original externo | `arma3_2026-08-06_10-22-59.rpt` |
| Tamaño del snapshot | 75 466 bytes |
| Última modificación del snapshot | 2026-08-06 16:46:04 |
| SHA-256 del snapshot | `3DCB642989752B38E35A02E0F2414C608BACBCAC5BBB6234A782AD9B2CE91570` |
| Entradas `[IF]` | 24 |
| Arranques observados | 2 |
| Candidatos de error en la ventana final | 0 |

El original permanece fuera del repositorio y no fue modificado. El primer arranque aparece a partir de la línea 857 y registra la secuencia `[IF]` en 860–871; el segundo empieza en 874 y registra la secuencia en 877–888.

## Matriz del smoke test

| Comprobación | Primera ejecución | Segunda ejecución |
| --- | --- | --- |
| `IF_fnc_log` registrada | `PASS` | `PASS` |
| `IF_fnc_validateIds` registrada | `PASS` | `PASS` |
| `preInit` completado | `PASS` | `PASS` |
| `postInit` completado | `PASS` | `PASS` |
| clase `ALT_W_NERI_PANOCHORI` cargada | `PASS` | `PASS` |
| colección válida aceptada | `PASS` | `PASS` |
| ID vacío y duplicado rechazados | `PASS` | `PASS` |
| informe diagnóstico BASIC | `PASS` | `PASS` |

## Diagnóstico SQF-VM

SQF-VM Language Server 0.2.21 emitió `SQFVM-40013` sobre `author` en la primera línea de `description.ext`. Se clasifica como falso positivo del analizador de configuración genérico porque:

- `author`, `onLoadName` y `onLoadMission` son propiedades raíz válidas de una misión;
- Arma mostró esos valores en la pantalla de carga;
- el motor cargó `CfgFunctions`, configuración y scripts sin error;
- las dos ejecuciones posteriores produjeron RPT limpio para el alcance.

La sintaxis raíz utilizada está documentada en la referencia oficial de Bohemia Interactive sobre [`Description.ext`](https://community.bohemia.net/wiki/Description.ext).

`description.ext` se excluye del analizador SQF-VM mediante `.vscode/sqfvm-lsp/ls-ignore.txt`. La cobertura se conserva con `tools/Test-M0MissionSkeleton.ps1`, Semgrep y la carga real en Arma 3. Después de cambiar la lista de exclusión es necesario recargar la ventana de VS Code.

## Límites

Esta evidencia no acredita:

- campaña jugable, persistencia, eventos o simulación estratégica;
- rendimiento o presupuesto de FPS;
- multijugador o autoridad distribuida;
- validación marítima, huellas de módulos, alturas o impacto civil de Panochori;
- promoción de coordenadas a `VALIDADO_3DEN` completo.
