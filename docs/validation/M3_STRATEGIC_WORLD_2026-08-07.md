# Evidencia M3 — Mundo estratégico mínimo

> **Estado:** implementación técnica `PROBADA`; gate `M3 NO APROBADO`
> **Pendiente principal:** validación humana de geografía, rutas, límites y anclajes en Editor 3DEN
> **Alcance:** grafo lógico SP de nueve sectores; no acredita campaña jugable, UI estratégica, materialización, navegación física ni rendimiento representativo

## Resultado técnico

La misión carga 5 regiones, 9 sectores y 9 conexiones en `IF_config`, los
materializa en las raíces persistentes de schema 1 y conserva un mundo M3 ya
cargado. El módulo `WORLD` aporta validación, consultas puras de sector,
vecinos, ruta y profundidad, un command autoritativo de propietario y el evento
persistente `IF_EVENT_SECTOR_MILITARY_OWNER_CHANGED`.

`ALT_W_AGIOS_DIONYSIOS` representa provisionalmente el “primer enlace del
corredor occidental”. Su sector usa `designStatus = PROPUESTA_M3`. Las
conexiones inferidas también conservan `PROPUESTA_M3`; ninguna posición, radio,
distancia o ancla se presenta como dato de 3DEN.

## Ejecución en Arma 3

- Arma 3 `2.20.152984` x64, Altis, un jugador, sin mods personalizados.
- RPT: `C:\Users\Admin\AppData\Local\Arma 3\arma3_x64_2026-08-07_18-15-14.rpt`.
- SHA-256: `8E631EE4FC2A797D0BEA3862BE66E053767B165C6E2004A6E2FE98C800421343`.
- Ventana de misión: líneas 699–776.
- La ejecución usó una copia temporal con nombre único dentro de `Arma 3\Missions`; el proceso fue cerrado y la copia enviada a la Papelera. No se editó `mission.sqm`.

Resultados conservados en RPT:

- smoke M0: 7/7 `PASS`;
- núcleo M1: 10/10 `PASS`;
- persistencia M2: 9/9 `PASS`;
- mundo M3: 12/12 `PASS`;
- bootstrap: `PHASE_90_RUNNING`, `m3Passed = true`;
- configuración: 5 regiones, 9 sectores y 9 conexiones;
- no aparecen errores de script, configuración ni proyecto en la ventana de misión.

| Prueba M3 | Contrato comprobado | Resultado |
| --- | --- | --- |
| `config.nineSectors` | conteos y referencias de configuración | `PASS` |
| `world.valid` | invariantes del estado territorial | `PASS` |
| `world.initializeIdempotent` | no sobrescribe mundo existente | `PASS` |
| `world.m2DefaultsUpgraded` | defaults M3 sobre raíces M2 vacías, schema 1 conservado | `PASS` |
| `graph.pathTraversable` | ruta lógica Neri–Agios–Lakka–Airport West–Terminal | `PASS` |
| `graph.depthCalculated` | nueve sectores alcanzables y Terminal P4 | `PASS` |
| `world.invalidReferenceRejected` | una conexión ausente invalida el grafo | `PASS` |
| `owner.commandPublishesEvent` | transacción, propietario y evento persistente | `PASS` |
| `owner.commandIdempotent` | propietario repetido no duplica evento | `PASS` |
| `persistence.ownerRoundTrip` | propietario sobrevive guardado/carga en memoria | `PASS` |
| `runtime.depthRebuiltAfterLoad` | profundidad derivada reconstruida | `PASS` |
| `anchors.pendingExplicit` | nueve anclajes pendientes explícitos | `PASS` |

## Validación estática

Pasaron:

- `Test-M0MissionSkeleton.ps1`;
- `Test-M1AuthoritativeCore.ps1`;
- `Test-M2Persistence.ps1`;
- `Test-M3StrategicWorld.ps1`;
- `Test-Sync-MissionWorkspace.ps1`;
- `git diff --check`;
- Semgrep, 3 reglas sobre 71 archivos, 0 hallazgos.

## Observación de rendimiento

El entorno de referencia dispone de 16 GiB de RAM, CPU de 4 hilos lógicos y
gráficos Intel UHD 620. La ejecución completa de M1–M3 tardó alrededor de 59 s
desde el inicio de las suites hasta `postInit`; la mayor latencia visible se
concentró en snapshots, checksum y cargas repetidas con el nuevo estado M3.
Esta cifra describe una suite destructiva de integración, no un arranque de
partida ni un benchmark representativo.

Como degradación segura, `IF_RunIntegrationTests` queda desactivado por defecto:
el arranque normal conserva el smoke test rápido y solo ejecuta M1–M3 cuando se
solicita explícitamente. Este ajuste posterior al RPT tiene comprobación
estática; su ahorro exacto debe medirse en una ejecución futura antes de fijar
un presupuesto.

## Paquete manual para el usuario en 3DEN

Codex no ejecutará ni automatizará Editor 3DEN. El trabajo humano se divide en
dos pasadas para evitar cambios geográficos masivos sin evidencia.

### Pasada 1 — resolver el primer enlace

1. Abrir Arma 3, entrar en Editor, seleccionar Altis y abrir
   `IslasFracturadas`.
2. Crear o comprobar estas capas, sin editar `mission.sqm` como texto:
   `IF_00_WORLD_REFERENCE`, `IF_01_SECTOR_ANCHORS`,
   `IF_02_SECTOR_BOUNDS`, `IF_03_CONNECTIONS` e `IF_90_TESTING`.
3. En `IF_01_SECTOR_ANCHORS`, colocar referencias lógicas vacías para:
   `ALT_W_NERI_PANOCHORI`, `ALT_W_AGIOS_DIONYSIOS` y `ALT_CW_LAKKA`.
4. Nombrarlas con la convención
   `IF_ANCHOR_{SECTOR_ID}_CENTER`; por ejemplo,
   `IF_ANCHOR_ALT_W_NERI_PANOCHORI_CENTER`.
5. Probar el recorrido desde la entrada logística de Panochori hacia Agios y
   Lakka con Hunter y HEMTT. Registrar por tramo `PASS`, `PARCIAL` o `FAIL`,
   desvíos, puentes, pendientes, bloqueos y tiempo aproximado.
6. Comparar también el acceso hacia Neochori. La evidencia debe permitir elegir
   entre conservar Agios como primer enlace M3 o volver a la ruta física V0 por
   Neochori.
7. Guardar el escenario en 3DEN y comunicar “ya guardé M3 pasada 1”. Entonces
   se debe ejecutar `Sync-MissionWorkspace.ps1 -Action Status` y `-Action Pull`
   antes de editar configuración.

### Pasada 2 — completar los nueve anclajes

Después de resolver el punto 2 del slice, colocar los centros restantes:

```text
IF_ANCHOR_ALT_CW_STAVROS_WHISKEY_CENTER
IF_ANCHOR_ALT_CW_LAKKA_CENTER
IF_ANCHOR_ALT_CW_AAC_CENTER
IF_ANCHOR_ALT_CW_POLIAKKO_THERISA_CENTER
IF_ANCHOR_ALT_CW_XIROLIMNI_ZAROS_CENTER
IF_ANCHOR_ALT_C_AIRPORT_WEST_CENTER
IF_ANCHOR_ALT_C_AIRPORT_TERMINAL_CENTER
```

Para cada anclaje se debe conservar: posición ATL, dirección, captura general,
captura de accesos, terreno, carretera más próxima, espacio útil, pendiente,
obstáculos y resultado. Después se validan límites preliminares, conexiones,
puntos logísticos, spawns, zonas civiles, exclusiones y nodos Helios conforme a
las secciones 65–73 del documento 11.

## Gate pendiente

M3 no puede aprobarse mientras falte cualquiera de estos puntos:

- decisión humana sobre Agios frente a Neochori como primer enlace;
- coordenadas y radios procedentes de 3DEN;
- nueve anclajes centrales con evidencia;
- rutas físicas transitables y límites preliminares;
- una UI diagnóstica que identifique el estado, no solo el RPT;
- revisión del RPT generado por la validación manual.
