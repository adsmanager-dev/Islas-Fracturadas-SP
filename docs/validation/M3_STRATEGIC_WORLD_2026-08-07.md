# Evidencia M3 — Mundo estratégico mínimo

> **Estado:** implementación técnica `PROBADA`; gate `M3 NO APROBADO`
> **Pendiente principal:** completar seis anclajes, límites, convoy/IA, UI diagnóstica y decisión Agios–Neochori
> **Alcance:** grafo lógico SP de nueve sectores y pasada física inicial con Hunter/HEMTT Mover; no acredita campaña jugable, UI estratégica, materialización, convoy ni rendimiento representativo

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

La preparación estructurada del 2026-08-08 volvió a ejecutar el conjunto
afectado con este resultado:

| Comprobación | Entorno/fixture | Esperado | Resultado |
| --- | --- | --- | --- |
| `Test-M0MissionSkeleton.ps1` a `Test-M3StrategicWorld.ps1` | repositorio y misión sincronizada | contratos estáticos M0–M3 intactos | `PASS` |
| `Test-Sync-MissionWorkspace.ps1` | carpetas temporales aisladas | Push protege `mission.sqm`; `-AllowMissionSqm` lo habilita; Pull/conflictos/Force se conservan | `PASS` |
| pruebas de `sqm_inspect.py` y `sqm_patch.py` | 54 casos, incluidos nombre directo de Logic, Layer vacía/existente, reparación y staging | round-trip e invariantes sin cambios colaterales | `PASS` |
| `npm run check` y `npm test` de `if-media-mcp` | TypeScript y servidor MCP por memoria/stdio | contrato y 16 herramientas válidos | `PASS` (10 pruebas; 1 omitida por symlink en Windows) |
| Semgrep | 3 reglas, 71 archivos | cero hallazgos | `PASS` |
| Apertura, terreno y rutas en 3DEN/Arma 3 | misión sincronizada con tres lógicas; Hunter y HEMTT Mover | carga limpia y pauta manual de tres tramos | `PASS` limitado; ver «Resultado de la pasada 1» |

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

### Preparación estructurada del 2026-08-08

Tras guardar y cerrar 3DEN, se sincronizó la misión del editor y se conservó el
original binarizado con SHA-256
`A37648D69CD4ABC97A735817C0F97403773ACCC7D9277F432E17FD1941FDCA68`.
Sobre un borrador separado se añadieron tres entidades `Logic` dentro de
`IF_01_SECTOR_ANCHORS`; el round-trip pasó de 7 a 10 entidades, conservó los 6
elementos raíz, asignó IDs 7–9, dejó `ItemN` contiguos y no detectó cambios en
ninguna entidad anterior. La copia promovida al repositorio y a la carpeta de
Eden tiene SHA-256
`976F07C6C525FB17755B075E50799B1541DCFB6803EB53A5499C007A14EE1C1B`.

| Lógica preparada | Posición SQM `[x, elevación, y]` | Procedencia | Estado |
| --- | --- | --- | --- |
| `IF_ANCHOR_ALT_W_NERI_PANOCHORI_CENTER` | `[5063.221, 53.143517, 11300.441]` | semilla de marcador Panochori de KP Liberation; comprobación visual y de acceso en 3DEN | `VALIDADO_3DEN` para centro de pasada 1 |
| `IF_ANCHOR_ALT_W_AGIOS_DIONYSIOS_CENTER` | `[9366.566, 119.53284, 15884.586]` | semilla del ejemplo oficial `Example_CombatPatrol`; comprobación visual y de acceso en 3DEN | `VALIDADO_3DEN` para centro de pasada 1 |
| `IF_ANCHOR_ALT_CW_LAKKA_CENTER` | `[12360.689, 25.069893, 15630.738]` | semilla del ejemplo oficial `Example_CombatPatrol`; comprobación visual y de acceso en 3DEN | `VALIDADO_3DEN` para centro de pasada 1 |

Las coordenadas de la tabla reflejan el guardado binarizado producido por Eden
en la pasada 1. El estado se limita al centro y acceso observados; no valida
radio sectorial, límites, composiciones, navegación IA ni impacto civil.

### Resultado de la pasada 1 — 2026-08-08

- Entorno: Arma 3 `2.20.152984` x64, rama pública estable, Altis, un jugador.
- Escenario: `IslasFracturadas`; misión iniciada a las `17:44:36`.
- Evidencia visual: cuatro capturas comunicadas en la sesión muestran los tres
  centros y el corredor general; no se copiaron como archivos versionados.
- RPT: `C:\Users\Admin\AppData\Local\Arma 3\arma3_x64_2026-08-08_17-14-24.rpt`.
- SHA-256 del RPT:
  `F7A3F3236BD64381A6879BCCC77CC1219E4FDB6C23C0730D2F5E329BCB831ACA`.
- Ventana de misión: líneas 742–763; smoke y bootstrap `PASS`, sin errores ni
  warnings del proyecto. Dos errores `ProxyFlag_Auto`/`FxCartridge_556` aparecen
  al cerrar el motor, fuera de la ventana y sin referencia a Islas Fracturadas.

El usuario confirmó `PASS` para ambos vehículos después de ejecutar la pauta
completa solicitada. El guardado contiene `B_MRAP_01_F` (Hunter) y
`B_Truck_01_mover_F` (HEMTT Mover) en `IF_90_TESTING`, junto al fusilero de
prueba. No se comunicaron tiempos, desvíos ni incidencias, por lo que no se
inventan valores.

| Tramo | Hunter | HEMTT Mover | Alcance acreditado |
| --- | --- | --- | --- |
| Panochori–Agios Dionysios | `PASS` comunicado | `PASS` comunicado | vehículo individual conducido por jugador |
| Agios Dionysios–Lakka | `PASS` comunicado | `PASS` comunicado | vehículo individual conducido por jugador |
| Panochori–Neochori, comparación | `PASS` comunicado | `PASS` comunicado | alternativa físicamente transitable; no decide por sí sola el diseño |

Al guardar, Eden eliminó los primeros nombres porque el generador los había
serializado como `Attributes.name`; referencias reales de KP Liberation y las
muestras oficiales confirman que Logic usa el campo directo `name`. El defecto
se reprodujo, corrigió y cubrió con regresión. Se repararon únicamente los IDs
7–9 mediante staging: 12 entidades antes/después, `items` raíz 5, `items` de la
capa 3, mismos IDs/posiciones y cero entidades ajenas modificadas. La misión
reparada y sincronizada tiene SHA-256
`E0A40641FBF0EB6BCA93A699C74348C25AEFFCCF5B2EFEAA3410CAFD99A0E148`;
queda pendiente una reapertura/guardado breve en Eden para confirmar la
persistencia del nombre directo dentro del propio editor.

### Pasada 1 — resolver el primer enlace

1. Abrir Arma 3, entrar en Editor, seleccionar Altis y abrir
   `IslasFracturadas`.
2. Comprobar que aparecen estas capas:
   `IF_00_WORLD_REFERENCE`, `IF_01_SECTOR_ANCHORS`,
   `IF_02_SECTOR_BOUNDS`, `IF_03_CONNECTIONS` e `IF_90_TESTING`.
3. Expandir `IF_01_SECTOR_ANCHORS` y comprobar que contiene las tres lógicas
   preparadas en la tabla anterior, sin avisos de carga ni entidades fuera de
   la capa.
4. Seleccionar cada lógica, comprobar terreno, elevación y accesos; moverla
   dentro de 3DEN si la semilla no representa un centro operativo adecuado y
   registrar la posición ATL final.
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
- radios y migración de coordenadas procedentes de 3DEN a configuración;
- seis de nueve anclajes centrales con evidencia;
- convoy, IA bidireccional, tráfico limitado y límites preliminares;
- una UI diagnóstica que identifique el estado, no solo el RPT;
- revisión del RPT generado por la validación manual.
