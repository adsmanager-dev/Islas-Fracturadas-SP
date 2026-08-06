# Validación funcional — M1 Núcleo autoritativo estable

> **Estado:** `PROBADO`; `M1 APROBADO`
> **Fecha:** 2026-08-06
> **Escenario:** `IslasFracturadas.Altis`
> **Implementación:** commit `0dc846f`
> **Fuente:** ejecución manual comunicada por el responsable del proyecto y triaje del RPT local original.

## Entorno

| Campo | Valor |
| --- | --- |
| Motor | Arma 3 Stable 2.20.152984 |
| Arquitectura ejecutada | x86 / 32 bits |
| Modo | un jugador; autoridad local `isServer == true` |
| Mundo | Altis |
| Diagnóstico | `BASIC` |
| Mods personalizados | ninguno registrado (`customMods = false`) |

La ejecución x86 acredita comportamiento funcional, no rendimiento. Los presupuestos y benchmarks posteriores requieren x64.

## Procedimiento reproducido

1. Sincronizar el proyecto con la misión principal mediante `Sync-MissionWorkspace.ps1 -Action Push`.
2. Reabrir `IslasFracturadas` en Eden para recargar `description.ext` y `CfgFunctions`.
3. Ejecutar la vista previa con diagnóstico `BASIC`.
4. Esperar el bootstrap M1, entrar al mundo y volver al editor.
5. Revisar desde el último `Mission file: IslasFracturadas` hasta el final del RPT.

## Evidencia RPT

| Campo | Valor |
| --- | --- |
| Archivo original externo | `arma3_2026-08-06_16-58-39.rpt` |
| Tamaño | 65 983 bytes |
| Última modificación | 2026-08-06 17:33:26 -04:00 |
| SHA-256 | `A90937026AF03C6683EF9D1A174BD0BAA192320C52FD85C23D7E50503EE3037B` |
| Ventana de misión | líneas 728–757 |
| Entradas `[IF]` | 24, líneas 731–754 |
| Comprobaciones `PASS` | 17: siete smoke M0 y diez M1 |
| Candidatos de error de misión | 0 |

El original permanece fuera del repositorio y no fue modificado. Los avisos del motor anteriores a la línea 728 pertenecen a la carga general o a la escena de introducción, no a la ventana de la misión probada.

## Matriz de pruebas M1

| Comprobación | Resultado | Evidencia RPT |
| --- | --- | --- |
| configuración cargada y válida | `PASS` | `M1 config.valid` |
| estado nuevo cumple el esquema | `PASS` | `M1 state.new` |
| ID duplicado es rechazado | `PASS` | `M1 ids.duplicateRejected` |
| command modifica y query lee una copia | `PASS` | `M1 state.commandAndQuery` |
| rollback restaura el valor anterior | `PASS` | `M1 transaction.rollback` |
| evento persistente entra una vez al historial | `PASS` | `M1 event.persistent` |
| repetición no ejecuta dos veces al consumidor | `PASS` | `M1 event.repeatedOnce` |
| tarea de una sola ejecución respeta el scheduler | `PASS` | `M1 scheduler.once` |
| reloj avanza 90 minutos y puede revertirse | `PASS` | `M1 clock.advance` |
| error crítico conserva clasificación estructurada | `PASS` | `M1 error.critical` |

El diagnóstico final registra `PHASE_90_RUNNING`, `smokePassed == true`, `m1Passed == true`, `configReady == true` y `hasCanonicalState == true`.

## Validaciones complementarias

- `tools/Test-M0MissionSkeleton.ps1`: `PASS`.
- `tools/Test-M1AuthoritativeCore.ps1`: `PASS`.
- Semgrep: 45 objetivos, tres reglas, cero hallazgos.
- SQF-VM Language Server 0.2.21: 31 archivos SQF aislados sin errores ni warnings de parseo.
- `git diff --check`: `PASS`.
- sincronización proyecto–3DEN: todos los archivos iguales; `mission.sqm` protegido e idéntico.

## Gate M1

| Criterio de salida | Resultado |
| --- | --- |
| servicios inician en orden | `PASS` |
| estado canónico se crea | `PASS` |
| un command modifica estado | `PASS` |
| una query consulta sin exponer referencias mutables | `PASS` |
| un evento se procesa una sola vez | `PASS` |
| una transacción revierte | `PASS` |
| suite M1 completa pasa | `PASS` |
| no existe dependencia de UI | `PASS` por revisión estática y ejecución SP |

**Decisión:** `M1 APROBADO`.

## Límites

Esta evidencia no acredita:

- guardado, carga, snapshots, checksum o migraciones de M2;
- funcionamiento cooperativo, JIP, proyecciones de cliente o `CfgRemoteExec`;
- rendimiento en x64 o carga estratégica prolongada;
- campaña jugable, sectores simulados, misiones, IA estratégica o interfaz;
- validación 3DEN completa de Panochori.

Los IDs generados por `IF_fnc_idGenerateRuntime` son efímeros por contrato. La estabilidad entre sesiones y la idempotencia después de cargar pertenecen a M2.
