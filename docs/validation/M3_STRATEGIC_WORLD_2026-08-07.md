# Evidencia M3 — Mundo estratégico mínimo

> **Estado:** implementación técnica `PROBADA`; gate `M3 NO APROBADO`
> **Pendiente principal:** validar físicamente seis anclajes ya colocados y calibrar nueve radios, límites, convoy/IA y UI diagnóstica
> **Alcance:** grafo lógico SP de nueve sectores y pasada física inicial con Hunter/HEMTT Mover; no acredita campaña jugable, UI estratégica, materialización, convoy ni rendimiento representativo

## Resultado técnico

La misión carga 5 regiones, 9 sectores y 9 conexiones en `IF_config`, los
materializa en las raíces persistentes de schema 1 y conserva un mundo M3 ya
cargado. El módulo `WORLD` aporta validación, consultas puras de sector,
vecinos, ruta y profundidad, un command autoritativo de propietario y el evento
persistente `IF_EVENT_SECTOR_MILITARY_OWNER_CHANGED`.

`DEC-009` confirma `ALT_W_AGIOS_DIONYSIOS` como enlace interior principal M3 y
`CONN_M3_NERI_AGIOS` como su conexión desde Neri. Neochori conserva sus
funciones civiles/logísticas y una ruta alternativa. Los nueve centros guardados
en Eden están migrados a configuración: tres conservan `VALIDADO_3DEN` y seis
`VALIDACION_3DEN_EN_CURSO`. Los nueve radios siguen `POR_CALIBRAR`; límites,
convoy/IA, distancias y las cuatro conexiones no confirmadas restantes continúan
pendientes.

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
- Semgrep, 3 reglas sobre 72 archivos, 0 hallazgos.

## Reconciliación aditiva de saves M3 anteriores — 2026-08-09

El defecto de compatibilidad afectaba saves schema 1 cuyo grafo M3 ya estaba
completo: `worldInitialize` los consideraba inicializados y no podía incorporar
las seis posiciones añadidas posteriormente a configuración. Reconstruir los
sectores habría sobrescrito progreso dinámico de campaña.

`IF_fnc_worldReconcilePhysicalMetadata` resuelve ese caso sin cambiar schema ni
reemplazar `sectors`. Exige las tres raíces `regions`/`sectors`/`connections`
completas y coherentes, valida una copia del estado y el mundo, prepara todos los
cambios y solo entonces abre una transacción. Puede completar únicamente:

- `positionATL` cuando el valor persistido es `[]`;
- `flags.anchorPositionATL` cuando el valor persistido es `[]`;
- `flags.anchorStatus` y `flags.validationStatus` solo en la transición segura
  desde campo ausente o `POR_CALIBRAR` hacia
  `VALIDACION_3DEN_EN_CURSO` procedente de configuración.

Una posición persistida válida de longitud 3 prevalece y no se modifica. La
función no puede tocar `militaryOwner`, `militaryControl`, guarnición, fuerzas,
`readiness`, moral, recursos, suministro, producción, daño, niveles estructural
o de fortificación, relaciones, influencia, misiones, eventos, logística,
actividad ni estado político. Valida de nuevo tras aplicar; cualquier fallo usa
el rollback existente.

Cuando cambia algo, añade una única entrada
`PHYSICAL_METADATA_RECONCILIATION` a la convención existente
`meta.migrationHistory`, con tipo, sectores afectados, campos y cantidad. La
segunda ejecución devuelve `success = true`, `changed = false`, conserva el
estado byte a byte a nivel persistible y no registra otra entrada. Un estado
parcial se rechaza antes de abrir una transacción y permanece intacto.

| Caso de regresión | Fixture y aserción | Resultado |
| --- | --- | --- |
| Mundo nuevo | inicialización normal materializa las nueve posiciones y anclas configuradas | `PASS` |
| Save M3 anterior | seis sectores con ambas posiciones `[]` reciben 24 cambios: 12 coordenadas y 12 estados físicos seguros | `PASS` |
| Preservación dinámica | propietario/control, guarnición, fuerza, readiness, moral, suministro, producción, daño, niveles, logística, relaciones y misión comparados antes/después | `PASS` |
| Idempotencia | primera ejecución `changed = true`; segunda `changed = false`, sin nueva auditoría ni diferencia de estado | `PASS` |
| Posición persistida | coordenada válida distinta de configuración prevalece sin escrituras | `PASS` |
| Integración | `worldInitialize` devuelve `ALREADY_INITIALIZED_RECONCILED` y luego `ALREADY_INITIALIZED` | `PASS` |
| Estado parcial | falta `connections`; reconciliación e inicialización fallan con `PARTIAL_WORLD_STATE` sin mutación | `PASS` |

La validación estática posterior ejecutó realmente M0, M1, M2, M3 y Sync con
resultado `PASS`; `git diff --check` pasó y Semgrep analizó 72 archivos con 3
reglas y 0 hallazgos. El diagnóstico conserva la separación exacta:
`placedAnchorCount = 9`, `pendingPlacementCount = 0`,
`validatedAnchorCount = 3`, `pendingValidationCount = 6`.

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

Al guardar por primera vez, Eden eliminó los nombres porque el generador los había
serializado como `Attributes.name`; referencias reales de KP Liberation y las
muestras oficiales confirman que Logic usa el campo directo `name`. El defecto
se reprodujo, corrigió y cubrió con regresión. Se repararon únicamente los IDs
7–9 mediante staging: 12 entidades antes/después, `items` raíz 5, `items` de la
capa 3, mismos IDs/posiciones y cero entidades ajenas modificadas. La misión
reparada y sincronizada tenía SHA-256
`E0A40641FBF0EB6BCA93A699C74348C25AEFFCCF5B2EFEAA3410CAFD99A0E148`.

### Segunda persistencia de nombres y decisión territorial — 2026-08-09

El usuario reabrió la misión, verificó visualmente en Eden los tres nombres
directos y volvió a guardar antes de cerrar el editor. El `mission.sqm`
binarizado importado conserva 12 entidades, las lógicas IDs 7–9, sus posiciones
SQM y estos nombres directos:

- `IF_ANCHOR_ALT_W_NERI_PANOCHORI_CENTER`;
- `IF_ANCHOR_ALT_W_AGIOS_DIONYSIOS_CENTER`;
- `IF_ANCHOR_ALT_CW_LAKKA_CENTER`.

La inspección estructurada posterior confirma 1 grupo, 5 capas, 3 lógicas y 3
objetos, sin `init` y sin pérdida de nombres o coordenadas. Con esa regresión
cerrada, la decisión humana adopta Agios Dionysios como enlace interior principal
M3 y conserva Neochori como alternativa civil/logística. Esto registra
`DEC-009` como `DISEÑO_CONFIRMADO`; no altera el alcance rector de `DEC-008`.

### Pauta ejecutada de la pasada 1

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

#### Registro estructural de la pasada 2 — 2026-08-09

Esta pasada incorpora las seis lógicas restantes dentro de
`IF_01_SECTOR_ANCHORS`; no acredita todavía su posición física. Las semillas
horizontales se conservaron de la extracción de `map_altis.pbo` deraprificada
con HEMTT `1.20.1`. Para `ALT_CW_POLIAKKO_THERISA` se mantuvo Poliakko como
semilla inicial.

La sonda `IF_TerrainProbe.Altis` no produjo elevaciones utilizables. El RPT más
reciente,
`C:\Users\Admin\AppData\Local\Arma 3\arma3_x64_2026-08-09_15-59-18.rpt`,
registra el argumento de arranque, pero no contiene `Starting mission`,
`Mission world`, `Mission directory` ni salida `IF_TERRAIN_PROBE`. Conforme a
la degradación prevista, no se insistió en automatizar Arma 3 y se escribió
`0.0` como elevación provisional segura en los seis casos.

| ID | Lógica | Posición SQM escrita `[x, elevación, y]` | Procedencia de x/y | Estado |
| --- | --- | --- | --- | --- |
| 17 | `IF_ANCHOR_ALT_CW_STAVROS_WHISKEY_CENTER` | `[12950.06, 0.0, 15041.63]` | `map_altis.pbo`, localidad Stavros | `POR_CALIBRAR` / `PENDIENTE_VALIDACION_3DEN` |
| 18 | `IF_ANCHOR_ALT_CW_AAC_CENTER` | `[11461.19, 0.0, 11661.67]` | `map_altis.pbo`, localidad AAC Airfield | `POR_CALIBRAR` / `PENDIENTE_VALIDACION_3DEN` |
| 19 | `IF_ANCHOR_ALT_CW_POLIAKKO_THERISA_CENTER` | `[10966.47, 0.0, 13435.28]` | `map_altis.pbo`, Poliakko como semilla inicial | `POR_CALIBRAR` / `PENDIENTE_VALIDACION_3DEN` |
| 20 | `IF_ANCHOR_ALT_CW_XIROLIMNI_ZAROS_CENTER` | `[9115.22, 0.0, 13959.85]` | `map_altis.pbo`, localidad Xirolimni Dam | `POR_CALIBRAR` / `PENDIENTE_VALIDACION_3DEN` |
| 21 | `IF_ANCHOR_ALT_C_AIRPORT_WEST_CENTER` | `[14382.4, 0.0, 15924.6]` | `map_altis.pbo`, semilla de Airport West | `POR_CALIBRAR` / `PENDIENTE_VALIDACION_3DEN` |
| 22 | `IF_ANCHOR_ALT_C_AIRPORT_TERMINAL_CENTER` | `[15189.6, 0.0, 16769.4]` | `map_altis.pbo`, semilla de Airport Terminal | `POR_CALIBRAR` / `PENDIENTE_VALIDACION_3DEN` |

La operación estructurada creó un backup en
`production/media/drafts/mission_sqm_backups/mission.sqm.20260809T202114474733Z.8265CA972433.bak`.
El SHA-256 de `mission.sqm` pasó de
`8265CA9724339CFBF6C22E4AD4A2F2D4EB462C823BDB67671CD45BFFB1C2F1C0` a
`0E29DB55C9DC0E7187FCCB2091CE610AF0F67AC8E051132A7325482AA3362320`.

La inspección estructurada inmediata confirmó:

- 18 entidades aplanadas: 1 `Group`, 5 `Layer`, 9 `Logic` y 3 `Object`;
- 9 elementos dentro de `IF_01_SECTOR_ANCHORS` y 5 elementos raíz, sin alterar
  las 12 entidades anteriores;
- IDs nuevos 17–22, únicos, calculados por la herramienta, con
  `ItemIDProvider.nextID` actualizado;
- secuencia `ItemN`, contadores `items` y round-trip estructural válidos;
- cero entidades con propiedad `init`;
- nombres directos y posiciones de las lógicas anteriores intactos.

| Comprobación posterior | Resultado |
| --- | --- |
| `Test-M0MissionSkeleton.ps1` | `PASS` |
| `Test-M1AuthoritativeCore.ps1` | `PASS` |
| `Test-M2Persistence.ps1` | `PASS` |
| `Test-M3StrategicWorld.ps1` | `PASS` |
| `Test-Sync-MissionWorkspace.ps1` | `PASS` |
| `git diff --check` | `PASS`; solo aviso informativo LF→CRLF para `mission.sqm` |
| Semgrep | `PASS`: 3 reglas, 71 archivos, 0 hallazgos |
| `Push -AllowMissionSqm -WhatIf` | 4 copias planificadas, 0 protegidas, sin conflicto |
| `Push -AllowMissionSqm` | 4 copias realizadas, incluida `mission.sqm` |

Ninguno de estos seis anclajes queda `VALIDADO_3DEN`. M3 continúa no aprobado:
siguen pendientes la calibración física, radios sectoriales, límites
preliminares, rutas/convoy/IA y los demás gates físicos documentados.

#### Persistencia del guardado de 3DEN — 2026-08-09

El usuario abrió la pasada 2, desplazó manualmente las seis lógicas hasta las
posiciones que consideró adecuadas, mantuvo `Z = 0` ATL para apoyarlas sobre el
terreno y guardó el escenario. Por tanto, las diferencias horizontales frente
a las semillas de `map_altis.pbo` son ajustes humanos intencionales y las
coordenadas de la tabla siguiente son la referencia actual de la pasada 2.
`Sync-MissionWorkspace.ps1 -Action Status`
detectó `EditorMasNuevo` únicamente para `mission.sqm`; el `Pull` importó ese
solo archivo. La inspección estructurada del binario guardado demuestra que el
`0` mostrado por 3DEN era altura relativa al terreno, no cota del terreno en el
SQM: el componente central de cada posición quedó serializado con estas
elevaciones reales.

| ID | Lógica | Posición SQM guardada `[x, elevación, y]` | Elevación serializada | Estado |
| --- | --- | --- | --- | --- |
| 17 | `IF_ANCHOR_ALT_CW_STAVROS_WHISKEY_CENTER` | `[12948.381, 27.803102, 15032.742]` | `27.803102 m` | apoyado al terreno; `PENDIENTE_VALIDACION_3DEN` del centro |
| 18 | `IF_ANCHOR_ALT_CW_AAC_CENTER` | `[11479.819, 23.241089, 11632.228]` | `23.241089 m` | apoyado al terreno; `PENDIENTE_VALIDACION_3DEN` del centro |
| 19 | `IF_ANCHOR_ALT_CW_POLIAKKO_THERISA_CENTER` | `[10966.956, 28.47107, 13436.86]` | `28.47107 m` | apoyado al terreno; `PENDIENTE_VALIDACION_3DEN` del centro |
| 20 | `IF_ANCHOR_ALT_CW_XIROLIMNI_ZAROS_CENTER` | `[9138.721, 30.62191, 13938.911]` | `30.62191 m` | apoyado al terreno; `PENDIENTE_VALIDACION_3DEN` del centro |
| 21 | `IF_ANCHOR_ALT_C_AIRPORT_WEST_CENTER` | `[14383.358, 17.8, 15922.19]` | `17.8 m` | apoyado al terreno; `PENDIENTE_VALIDACION_3DEN` del centro |
| 22 | `IF_ANCHOR_ALT_C_AIRPORT_TERMINAL_CENTER` | `[15185.31, 17.91, 16774.15]` | `17.91 m` | apoyado al terreno; `PENDIENTE_VALIDACION_3DEN` del centro |

El SHA-256 del binario guardado e importado es
`51026FCEEC464A4A215F111D92BD86A8429DC85AC49F33A5B0BE17167CFFB2D8`.
Persisten 18 entidades, 9 `Logic`, los nueve nombres directos, IDs 7–9 y 17–22,
cero propiedades `init` y los conteos estructurales esperados. Esta evidencia
confirma las cotas serializadas y el apoyo ATL comunicado; no acredita por sí
sola accesos, espacio útil, pendiente operativa, rutas ni el resto de criterios
físicos, por lo que ninguno de los seis centros se eleva todavía a
`VALIDADO_3DEN`.

Para cada anclaje se debe conservar: posición ATL, dirección, captura general,
captura de accesos, terreno, carretera más próxima, espacio útil, pendiente,
obstáculos y resultado. Después se validan límites preliminares, conexiones,
puntos logísticos, spawns, zonas civiles, exclusiones y nodos Helios conforme a
las secciones 65–73 del documento 11.

## Gate pendiente

M3 no puede aprobarse mientras falte cualquiera de estos puntos:

- radios de los nueve sectores y validación física completa de seis centros ya apoyados al terreno;
- seis de nueve anclajes centrales siguen `VALIDACION_3DEN_EN_CURSO`, no `VALIDADO_3DEN`;
- convoy, IA bidireccional, tráfico limitado y límites preliminares;
- una UI diagnóstica que identifique el estado, no solo el RPT;
- ejecución en Arma 3 y revisión del RPT para el contrato declarativo ya migrado.
