# Evidencia M2 — Campaña persistente mínima

> **Estado:** `PROBADO`; gate `M2 APROBADO` el 2026-08-07
> **Alcance:** persistencia mínima SP de `IF_campaignState`; no acredita campaña jugable, multijugador, simulación estratégica ni rendimiento
> **Implementación:** `5012cc9`, con corrección de regresión `ded248a`

## Entorno

- Arma 3 `2.20.152984` x64, Altis, escenario `IslasFracturadas`, un jugador.
- Diagnóstico `BASIC`, sin mods personalizados.
- Adaptador real sobre `missionProfileNamespace`; adaptador de memoria reservado para pruebas.
- Schema persistente `1`, grupo de misión `IF_MAIN_CAMPAIGN`.

## Reinicio completo del proceso

El estado modificado sobrevivió al cierre total de Arma 3 y a un proceso nuevo:

| Etapa | RPT y huella SHA-256 | Evidencia | Resultado |
| --- | --- | --- | --- |
| Guardar y cerrar | `arma3_x64_2026-08-07_08-54-38.rpt`; `FC2E81E45518C157EDB403B1CA2FAACB247A747447620B832D81394B769D5E2B` | líneas 785–829; guardado en `IF_MAIN_CAMPAIGN_AUTOSAVE_A`; `persistence.restart.auto.stage1` | `PASS` |
| Arranque en proceso nuevo | `arma3_x64_2026-08-07_11-01-52.rpt`; `94B116FA03BB129F89C481323EAF370C544A5159581689C32664A40BF98E7A81` | líneas 712–758; carga de `AUTOSAVE_A`; `persistence.restart.auto.stage2`; `persistenceLoaded == true` | `PASS` |

Antes del segundo arranque se verificó que no quedaba ningún proceso de Arma 3 activo. La fase reconstruida alcanzó `PHASE_90_RUNNING`.

## Regresión final

RPT: `arma3_x64_2026-08-07_12-17-43.rpt`
SHA-256: `5C793DFFE663DB8AE93255F4F1EAB4FABD068273222600633BF68DE73F5A812F`
Ventana de misión: líneas 725–770.

- smoke M0: 7/7 `PASS`;
- M1: 10/10 `PASS`;
- M2: 9/9 `PASS`;
- bootstrap final: `PHASE_90_RUNNING`, `smoke=true`, `m1=true`, `m2=true`, `persistenceLoaded=true`;
- sin errores del proyecto en la ventana examinada.

| Prueba M2 | Contrato comprobado | Resultado |
| --- | --- | --- |
| `save.abRotation` | dos autosaves alternan A/B y conservan el snapshot previo | `PASS` |
| `load.latest` | se carga el snapshot activo válido | `PASS` |
| `recovery.corruptAFallsBackB` | A corrupto recupera B y repara el marcador activo para no sobrescribir el respaldo | `PASS` |
| `event.noDuplicateAfterLoad` | un ID persistente ya consumido no vuelve a producir efectos tras guardar/cargar | `PASS` |
| `save.manual` | el guardado manual crea y valida su envelope | `PASS` |
| `save.openTransactionRejected` | una transacción abierta bloquea el guardado | `PASS` |
| `save.incompleteStateRejected` | un estado incompleto no sustituye snapshots válidos | `PASS` |
| `migration.v0ToV1Idempotent` | la migración inicial produce schema 1 y repetirla no altera el resultado | `PASS` |
| `migration.preservesOriginal` | el payload anterior queda respaldado antes de migrar | `PASS` |

## Puerta M2

| Criterio de salida | Evidencia | Resultado |
| --- | --- | --- |
| Un estado modificado sobrevive al reinicio | prueba en dos procesos y RPT independientes | `PASS` |
| No se duplican efectos | `event.noDuplicateAfterLoad` | `PASS` |
| El snapshot anterior se conserva | rotación A/B | `PASS` |
| Un save corrupto no sobrescribe uno válido | fallback A→B, reparación del marcador y siguiente rotación segura | `PASS` |
| El schema aparece en logs | carga y guardado registran `schemaVersion=1` | `PASS` |

También pasaron `Test-M0MissionSkeleton.ps1`, `Test-M1AuthoritativeCore.ps1`, `Test-M2Persistence.ps1`, `git diff --check` y Semgrep sobre 61 archivos con cero hallazgos. Los archivos de M2 quedaron iguales entre la misión del repositorio y la carpeta de 3DEN; la propuesta visual local no forma parte de este gate.

## Defectos y límites

Durante el desarrollo se detectó y corrigió una copia inválida de strings en el adaptador de memoria. La revisión final detectó además que recuperar B desde A corrupto debía reparar el marcador activo; `ded248a` implementa esa garantía y añade la regresión de idempotencia entre cargas.

El gate acredita persistencia funcional SP, no seguridad criptográfica: el checksum detecta corrupción accidental. Solo se acredita la migración de la fixture v0 a schema 1. No se probaron MP/JIP, extensiones de servidor, carga masiva ni presupuesto de rendimiento. Un aviso aislado del scheduler (`0.00219727 s` frente a `0.002 s`) apareció en una ejecución intermedia y no se repitió en los RPT de reinicio o regresión final; queda como observación no bloqueante.

## Decisión

Todos los criterios obligatorios de Fase 2 tienen artefacto funcional y evidencia repetible. Se aprueba `M2 — Campaña persistente mínima`; el siguiente hito es `M3 — Mundo estratégico mínimo`.
