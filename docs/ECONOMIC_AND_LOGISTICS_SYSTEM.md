# Sistema económico y logístico de campaña

> **Estado:** contrato rector previo a implementación.  
> **Motor:** Arma 3 2.18.  
> **Ámbito:** Altis, Stratis y rutas exteriores.  
> **Territorio:** [TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md](TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md).  
> **Fuerzas:** [MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md](MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md).  
> **Estado autoritativo:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).

## 1. Propósito

La economía y la logística determinan qué operaciones pueden ocurrir y cuánto pueden durar. No obligan al jugador a administrar cajas individuales.

> Cada ejército depende de recursos, trabajadores, depósitos, vehículos e infraestructura que pueden protegerse, perderse, capturarse o destruirse.

## 2. Decisión principal

No existe una moneda universal que sustituya combustible, munición, medicina, alimentos, repuestos, materiales o personal.

Toda necesidad responde:

1. ¿existe el recurso?;
2. ¿dónde está?;
3. ¿puede llegar?;
4. ¿existe capacidad para utilizarlo?

Los recursos pertenecen a una facción o actor, pero también a una ubicación, una ruta y, a veces, un propietario legal diferente.

## 3. Cuatro economías

| Economía | Contenido | Finalidad |
|---|---|---|
| Civil | alimentos, agua, energía, empleo, comercio, vivienda y servicios | sostener la sociedad |
| Militar | munición, combustible, repuestos, construcción, sanidad y reemplazos | sostener operaciones |
| Gubernamental | impuestos, contratos, salarios, deuda, ayuda y presupuestos | sostener autoridad |
| Clandestina | contrabando, mercado negro, cachés, FIA, PHAROS y Argos | resistencia, corrupción o extracción |

Una misma ruta puede servir a varias economías y generar conflicto entre ellas.

## 4. Recursos físicos

```text
FOOD WATER FUEL
SMALL_ARMS_AMMO HEAVY_AMMO
MISSILES_AT MISSILES_AA ARTILLERY_AMMO EXPLOSIVES
MEDICAL CONSTRUCTION SPARE_PARTS ELECTRONICS
AVIATION_SUPPLIES NAVAL_SUPPLIES
```

No hay conversión automática entre categorías.

## 5. Recursos humanos

```text
AVAILABLE_PERSONNEL TRAINED_INFANTRY VEHICLE_CREWS PILOTS
ENGINEERS MEDICS TECHNICIANS LOGISTICS_STAFF
ADMINISTRATORS LOCAL_WORKERS
```

Un trabajador portuario no se convierte inmediatamente en piloto, cirujano, técnico Helios o tripulante de carro.

## 6. Capacidades operacionales

```text
TRANSPORT_CAPACITY STORAGE_CAPACITY PORT_THROUGHPUT
AIRFIELD_THROUGHPUT ROAD_CAPACITY REPAIR_CAPACITY
MEDICAL_CAPACITY CONSTRUCTION_CAPACITY COMMAND_CAPACITY
```

Tener el recurso no implica poder moverlo, almacenarlo o utilizarlo.

## 7. Recursos políticos y sociales

```text
POLITICAL_CAPITAL MUNICIPAL_COOPERATION CIVILIAN_TRUST
LABOR_COOPERATION INTERNATIONAL_SUPPORT BLACK_MARKET_ACCESS
```

Modifican acceso, velocidad, legitimidad, sabotaje y coste político, pero no son materiales físicos.

## 8. Unidad estratégica

Las cantidades representan paquetes normalizados, no litros, balas o kilogramos exactos.

| Unidad | Aproximación conceptual |
|---|---|
| `FOOD 1` | consumo diario de unas diez personas |
| `WATER 1` | agua diaria de unas diez personas |
| `SMALL_ARMS_AMMO 1` | reabastecimiento moderado de una escuadra |
| `FUEL 1` | varios ligeros o fracción de uso pesado/aéreo |
| `MEDICAL 1` | varias bajas leves o menos graves |
| `CONSTRUCTION 1` | mejora defensiva pequeña |

La interfaz prioriza suficiente, reducido y crítico; el balance interno conserva cantidades.

## 9. Estado de existencias

```text
SURPLUS FULL ADEQUATE LOW CRITICAL EMPTY
```

`LOW` reduce consumo y actividad; `CRITICAL` reserva para funciones esenciales; `EMPTY` detiene la función dependiente.

## 10. Localización y propiedad

Una existencia puede estar en reserva exterior, puerto, aeródromo, depósito, sector, convoy, vehículo, caché, instalación, mercado o red clandestina.

```text
ownerFactionId physicalLocation legalOwner currentController
reservedAmount availableAmount contaminatedAmount capturedAmount
compatibilityProfile
```

Control militar no elimina propiedad civil ni consecuencias de requisición.

## 11. Producción regional

| Tipo | Salidas |
|---|---|
| Agrícola | alimentos, agua limitada, animales y apoyo |
| Industrial | construcción, piezas, reparación y herramientas |
| Energético | electricidad, combustible procesado y bombeo |
| Urbano | administración, sanidad, trabajadores, comercio e impuestos |
| Portuario | importación, comercio, combustible y reparación naval |
| Aeroportuario | transporte, mantenimiento, evacuación y logística aérea |
| Técnico | electrónica, comunicaciones, Helios e inteligencia |

## 12. Producción efectiva

```text
actualOutput =
    potential
  × infrastructure
  × power
  × workforce
  × security
  × connection
  × administration
```

```text
productionPotential currentProduction productionEfficiency
workforceAvailable infrastructureCondition powerAvailability
securityLevel inputResources outputResources
```

Controlar una instalación no equivale a operarla.

## 13. Cadenas productivas

| Función | Inputs obligatorios |
|---|---|
| Reparación | repuestos, combustible, técnicos y taller |
| Construcción | materiales, ingenieros, transporte y seguridad |
| Aviación | combustible, munición, piezas, pilotos, pista y mantenimiento |
| Hospital | medicina, energía, agua, personal y seguridad |
| Helios | electricidad, comunicaciones, técnicos, electrónica y acceso |

Las reservas de arranque y la canibalización evitan dependencias circulares imposibles.

## 14. Trabajo y movilización

```text
population workingPopulation availableWorkers displacedWorkers
militaryMobilization injuredPopulation unemployment laborCooperation
```

Desplazamiento, reclutamiento, miedo, detenciones, bajas, huelgas y bloqueo reducen trabajadores. Salarios, seguridad, legitimidad, compensación, servicios y municipios aumentan cooperación.

Movilizar reservistas aumenta fuerza y reduce agricultura, transporte, reparación y administración.

## 15. Red logística

Nodos: puertos, aeropuertos, depósitos, centros, sectores, bases y cachés.

Conexiones: carretera principal/secundaria, pista, ruta marítima, aérea o clandestina.

```text
effectiveCapacity =
    baseCapacity × condition × security × availability
  - congestion
```

Cada conexión conserva capacidad, estado, amenaza, clima, tráfico, uso civil y prioridad militar.

## 16. Carreteras y cuellos de botella

```text
OPEN DEGRADED RESTRICTED BLOCKED DESTROYED MINED
```

Daño reduce capacidad y velocidad, aumenta consumo, averías y desvíos. Puentes, cruces y estrechamientos pueden limitar una ruta completa y requieren ingeniería, materiales, tiempo y seguridad.

## 17. Puertos

```text
berthCapacity unloadingCapacity storageCapacity fuelHandling
vehicleHandling civilianTraffic damage workerAvailability security
```

Estados:

```text
CLOSED BLOCKADED CONTESTED LIMITED OPERATIONAL FULL_CAPACITY
```

Capturar un puerto no crea estibadores, operadores, conductores, mecánicos, administración ni seguridad. Coerción puede recuperar parte del trabajo a cambio de sabotaje, accidentes y agravios.

## 18. Perfiles portuarios

| Puerto | Perfil |
|---|---|
| Kavala | comercial, sindical, civil, potencial Azul y riesgo FIA |
| Pyrgos | gubernamental, institucional y político |
| Molos | menor capacidad, función militar y entrada Roja |
| Puertos menores | poco volumen, infiltración y apoyo local |

## 19. Aeropuertos

```text
runwayCondition airTrafficControl fuelAvailability
maintenanceCapacity airDefense hangarCapacity
pilotSupport cargoHandling
```

```text
DESTROYED UNUSABLE EMERGENCY_ONLY LIMITED OPERATIONAL FULL
```

`EMERGENCY_ONLY` admite helicópteros, ligeros y evacuación limitada. El aeropuerto internacional recibe personal y carga especializada; mar sigue siendo más eficiente para pesados y combustible masivo.

AAC funciona como dispersión y apoyo avanzado. Molos sostiene la cabeza Roja y operaciones regionales.

## 20. Cabeza de playa

| Nivel | Capacidad |
|---:|---|
| 0 | descarga directa, vulnerable |
| 1 | playa segura y distribución limitada |
| 2 | depósitos temporales, sanidad, reparación y convoyes |
| 3 | puerto provisional, pesados, combustible y mando |

Pierde valor relativo cuando un puerto o aeropuerto superior entra en servicio.

## 21. Centros logísticos

| Centro | Escala |
|---|---|
| Caché | oculto, pequeño y poco personal |
| Distribución | recibe y redistribuye |
| Depósito regional | sostiene un frente |
| Depósito estratégico | gran capacidad en retaguardia |
| Reserva exterior | fuera del mapa, con autorización y punto de entrada |

```text
totalCapacity capacityByResource usedCapacity
hazardousCapacity securedCapacity
```

Sobreocupación aumenta deterioro, accidente, sabotaje y pérdida.

## 22. Doctrina de almacenamiento

- Azul dispersa depósitos modulares.
- Rojo utiliza centros protegidos y escalonados.
- Verde aprovecha infraestructura e inventarios históricos.
- FIA distribuye cachés pequeños sin dependencia única.
- Meridian mantiene reservas ocultas y redundantes.

## 23. Convoy

```text
convoyId ownerFactionId origin destination cargo vehicles escort
route departureTime estimatedArrival priority status threat
```

Estados:

```text
PLANNED ASSEMBLING LOADING READY EN_ROUTE DELAYED DIVERTED
UNDER_ATTACK BROKEN ARRIVED ABANDONED CAPTURED DESTROYED
```

## 24. Tipos y construcción de convoy

| Tipo | Función |
|---|---|
| Táctico | pequeño, urgente y próximo al frente |
| Regional | depósito a sector |
| Estratégico | puerto a gran centro, pesado y escoltado |
| Médico | evacuación y heridos |
| Civil | alimentos, trabajadores o desplazados |
| Clandestino | carga pequeña, FIA o Argos |

El sistema calcula carga, capacidad, vehículos, escolta, ruta, riesgo, horario y prioridad. Combustible, personal, medicina y refugiados usan composiciones distintas.

## 25. Prioridad logística

```text
CRITICAL HIGH NORMAL LOW DEFERRED
```

`CRITICAL` incluye hospital sin medicina, sector cercado, batería vacía o cabeza sin combustible. `DEFERRED` significa que no existe ruta o capacidad.

Escoltar un convoy resta tropas a guarnición, reserva y ofensiva.

## 26. Interdicción

Las rutas recuerdan ataques, minas, pérdidas, observación y sabotaje. La respuesta puede aumentar escolta, variar horario, desviar, engañar, despejar, volar o cancelar.

FIA eleva el coste de una carretera sin ocuparla permanentemente.

## 27. Simulación de convoyes

Fuera de pantalla avanzan según ruta, velocidad, seguridad, amenazas y eventos. Se materializan cerca del jugador, bajo ataque, en misión o con personaje/activo crítico.

La pérdida afecta carga, vehículos, personal, confianza, programación y operaciones futuras.

## 28. Consumo militar

El consumo depende de personal, vehículos, actividad, combate, clima, distancia y doctrina.

| Estado | Consumo dominante |
|---|---|
| `IDLE` | comida, agua y mantenimiento |
| `PATROLLING` | combustible, desgaste y munición ocasional |
| `MOVING` | combustible alto, piezas y alimentos |
| `COMBAT` | munición, medicina, combustible y desgaste |
| `REORGANIZING` | piezas, medicina, reemplazos y munición |

## 29. Infantería, vehículos y munición

Infantería consume alimento, agua, munición ligera y medicina. Escasez reduce moral, preparación y patrullas, y aumenta enfermedad o deserción.

Vehículos consumen combustible, munición, piezas, tripulación y mantenimiento. Ligero < transporte < blindado < carro < aeronave especializada.

Munición:

```text
SMALL_ARMS_AMMO HEAVY_AMMO MISSILES_AT MISSILES_AA
ARTILLERY_AMMO EXPLOSIVES
```

Escasez restringe la capacidad correspondiente; nunca convierte una categoría en otra.

## 30. Conflicto del combustible

Combustible sostiene blindados, convoyes, aviación, generadores, hospitales, Helios y agua.

Requisar reservas civiles puede detener transporte, agricultura y mercados. Una crisis puede obligar a elegir entre hospital, QRF y nodo Helios.

## 31. Medicina y capacidad

Medicina se consume por bajas, civiles, enfermedades, hospitales y desplazados. Requiere médicos, camas, electricidad, agua y evacuación.

Existencias altas con capacidad médica baja no producen tratamiento eficaz.

## 32. Repuestos y mantenimiento

```text
LIGHT_PARTS HEAVY_PARTS AVIATION_PARTS ELECTRONIC_PARTS
```

| Nivel | Capacidad |
|---|---|
| M0 | tareas de tripulación |
| M1 | ruedas, armas y sistemas menores |
| M2 | motores, blindaje y sistemas complejos |
| M3 | reconstrucción, aviación y grandes reparaciones |

Un vehículo puede necesitar traslado a otro sector.

## 33. Desgaste y canibalización

Distancia, terreno, uso, polvo, sobrecarga, tripulación y mantenimiento modifican desgaste, averías y disponibilidad.

Canibalizar un activo produce piezas, munición, componentes o inteligencia, pero lo destruye definitivamente. FIA y Verde dependen más de esta opción.

## 34. Recuperación

Recuperar un vehículo exige acceso, seguridad, ingeniería, remolque/transporte, ruta y taller. Puede generar una misión expuesta a emboscada, artillería o contraataque.

## 35. Materiales, electrónica y energía

Construcción compite con reparación militar, fortificación, puentes, vivienda y hospitales.

Electrónica compite entre radios, drones, radares, Helios, mando, inteligencia y AA.

Energía:

```text
BLACKOUT CRITICAL RATIONED STABLE SURPLUS
```

Prioridad civil inicial: hospitales, agua, comunicaciones, Gobierno, industria, Helios y usos secundarios. Cada facción puede alterarla.

## 36. Agua y alimentos

Agua necesita fuente, bombeo, electricidad, tratamiento y transporte. Apagón, contaminación, daño o bloqueo pueden crear una crisis equivalente a la falta de munición.

Alimentos proceden de agricultura, pesca, almacenes, importación y ayuda. Guerra, falta de combustible, movilización y rutas cortadas elevan desplazamiento, mercado negro y radicalización.

## 37. Economía civil

La disponibilidad de trabajo, mercados, requisiciones, propiedad, compensación, desplazamiento y retorno modifica la economía según [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md). Este documento conserva la autoridad sobre recursos, producción y flujos físicos.

```text
economicActivity marketAvailability employment inflationPressure
foodAvailability fuelAvailability transportAvailability
```

Índice de precios:

| Rango | Estado |
|---:|---|
| 0–20 | estable |
| 21–40 | tensión |
| 41–60 | inflación |
| 61–80 | crisis |
| 81–100 | colapso |

No se simulan transacciones individuales.

## 38. Mercado negro y contrabando

El mercado negro ofrece combustible, armas, medicina, información, transporte y documentos a cambio de capital político, favores, corrupción y exposición.

Riesgos: infiltración, material defectuoso, delincuencia, Argos y pérdida de legitimidad.

Contrabandistas usan costa, caminos, documentos, depósitos y trabajadores. Una ruta puede mover armas, medicina o familias en momentos diferentes.

## 39. Requisición

Modalidades:

```text
COMPENSATED PARTIAL_COMPENSATION COERCIVE CLANDESTINE
```

Puede transferir alimentos, combustible, vehículos, edificios, trabajadores o medicina. Obtiene recursos y velocidad ahora; reduce producción y confianza y aumenta sabotaje, FIA y reclamaciones después.

> Requisar traslada recursos desde la economía civil; no los crea.

## 40. Compensación y ayuda

Compensación usa presupuesto, ayuda exterior, vales, contratos, protección o devolución futura. Su credibilidad depende de Gobierno, historial, estabilidad y autoridad.

Ayuda humanitaria necesita puerto/aeropuerto, ruta, protección, distribución y legitimidad. Militarizarla aumenta dependencia y riesgo de ataque.

## 41. Capital político

Permite solicitar refuerzos, fondos, contratos, ayuda y escalada. Se consume con ocupación, bajas, daño civil, incumplimiento y nuevas oleadas; se recupera con victorias, legitimidad, acuerdos, protección civil y resultados públicos.

## 42. Reconstrucción

```text
HOUSING ROADS POWER WATER MEDICAL PORT AIRFIELD
INDUSTRY GOVERNMENT HELIOS
```

Requiere materiales, trabajadores, seguridad, administración, tiempo y financiación. Compite con fortificación y reparación militar.

La población evalúa qué se repara, dónde, quién trabaja y quién se beneficia. Un puerto exclusivamente militar no genera el mismo apoyo que uno comercial.

## 43. Captura y compatibilidad

Al capturar se resuelven recursos intactos, evacuados, destruidos, ocultos y saboteados según tiempo, doctrina, trabajadores, inteligencia y velocidad.

| Compatibilidad | Recursos |
|---|---|
| Universal | alimentos, agua, construcción y combustible común |
| Parcial | munición ligera, vehículos y repuestos |
| Especializada | misiles, electrónica, aviación y Helios |
| Desconocida | trampas, seguimiento, sabotaje o archivos |

## 44. Sabotaje

Visible: explosión, incendio o destrucción.

Oculto: combustible contaminado, piezas defectuosas, inventarios falsos, retrasos y rutas filtradas.

Puede afectar depósitos, convoyes, puentes, energía, grúas, registros y talleres.

## 45. Helios y Argos

Helios mejora predicción, rutas, inventarios, tráfico, mantenimiento y distribución energética. Mayor integración aumenta el daño potencial de desconexión o datos falsos.

Argos puede alterar prioridad, ocultar inventario, retrasar o redirigir carga, falsear seguridad y demanda, y proteger flujos hacia Stratis.

Argos no crea combustible, vehículos, trabajadores ni carreteras.

Indicadores: diferencias físico/digitales, convoyes inexistentes, consumo imposible, rutas comprometidas, carga hacia S-26 y mantenimiento de personas muertas.

## 46. Perfiles logísticos

| Actor | Ventaja | Debilidad | Prioridad |
|---|---|---|---|
| Azul | mar, modularidad, electrónica y aire | exterior, pocos reemplazos, Katalaki/aeropuerto | abrir puerto o aeropuerto |
| Rojo | volumen, pesados, planificación y mecanización | consumo y corredor Molos–Sofia | depósitos escalonados |
| Verde | infraestructura, depósitos, rutas y civiles | división, corrupción e inventarios manipulados | coordinar y conservar |
| FIA | bajo consumo, apoyo, rutas y cachés | poca capacidad y reparación | distribución redundante |
| Meridian | reservas, precisión y acceso oculto | aislamiento y poca producción | energía, técnicos y evacuación |

## 47. Stratis

Stratis no sostiene HELIOS-CORE indefinidamente. Depende de combustible, repuestos, alimentos, medicina y electrónica.

Argos mantiene semanas de reservas para aislamiento, defensa, evacuación y destrucción de archivos. Un bloqueo prolongado provoca racionamiento, reducción de Helios, negociación o evacuación.

## 48. Distribución automática

| Prioridad | Contenido |
|---:|---|
| 1 — Supervivencia | agua, hospital, cercados y energía crítica |
| 2 — Defensa | munición, combustible, AT/AA y reparación |
| 3 — Operaciones | ofensiva, aviación y artillería |
| 4 — Recuperación | hospitales, reparación y reconstrucción |
| 5 — Reserva | acumulación y planes |

Cuando demandas incompatibles compiten, el comandante decide según doctrina, autoridad e información.

## 49. Intervención del jugador

El jugador prioriza frentes, protege rutas, solicita suministros, reasigna transporte, ordena recuperación, acepta requisición, recomienda evacuación e interviene en crisis.

Rango bajo solicita; rango alto modifica prioridades regionales. No administra cada convoy.

## 50. Misiones logísticas

La economía crea necesidades; no crea tareas arbitrarias. Su conversión en escolta, despeje, contraemboscada, recuperación, negociación, transporte alternativo o resolución externa se rige por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md).

```text
ESCORT RECOVERY ROUTE_CLEARANCE PORT_REOPENING HUB_EVACUATION
FUEL_SABOTAGE HOSPITAL_POWER REQUISITION_NEGOTIATION
CLANDESTINE_ROUTE PHAROS_CARGO
```

## 51. Centro logístico

```sqf
LOG_HUB_BLUE_NEOCHORI = createHashMapFromArray [
    ["id", "LOG_HUB_BLUE_NEOCHORI"],
    ["sectorId", "ALT_CW_NEOCHORI"],
    ["ownerFactionId", "FAC_BLUE"],
    ["hubType", "REGIONAL_DISTRIBUTION"],
    ["status", "OPERATIONAL"],
    ["storageCapacity", 180],
    ["throughput", 55],
    ["security", 65],
    ["staffing", 80],
    ["infrastructureCondition", 75],
    ["powerAvailability", 70],
    ["stocks", createHashMap],
    ["reservedStocks", createHashMap],
    ["incomingConvoys", []],
    ["outgoingConvoys", []],
    ["connectedRouteIds", []],
    ["evacuationThreshold", 35],
    ["capturePolicy", "EVACUATE_THEN_DESTROY"]
];
```

`frontDepth` es un valor calculado y no forma parte de la autoridad persistente del centro.

## 52. Producción

```sqf
PROD_ALT_CW_POLIAKKO = createHashMapFromArray [
    ["sectorId", "ALT_CW_POLIAKKO_THERISA"],
    ["productionType", "AGRICULTURAL"],
    ["baseOutput", createHashMapFromArray [["FOOD", 22]]],
    ["requiredInputs", createHashMapFromArray [
        ["FUEL", 3],
        ["WATER", 6]
    ]],
    ["workforceRequired", 160],
    ["workforceAvailable", 110],
    ["infrastructureCondition", 75],
    ["security", 55],
    ["connectionEfficiency", 60],
    ["currentEfficiency", 46]
];
```

## 53. Convoy persistente

```sqf
CONVOY_BLUE_014 = createHashMapFromArray [
    ["id", "CONVOY_BLUE_014"],
    ["ownerFactionId", "FAC_BLUE"],
    ["originHubId", "LOG_HUB_KATALAKI"],
    ["destinationHubId", "LOG_HUB_BLUE_NEOCHORI"],
    ["cargo", createHashMapFromArray [
        ["FUEL", 24],
        ["SMALL_ARMS_AMMO", 18],
        ["MEDICAL", 8]
    ]],
    ["vehicleIds", []],
    ["escortForceIds", []],
    ["routeIds", []],
    ["priority", "HIGH"],
    ["status", "EN_ROUTE"],
    ["departureTime", 820],
    ["estimatedArrival", 875],
    ["currentProgress", 0.42],
    ["threatLevel", 58],
    ["materialized", false]
];
```

## 54. Ritmos

| Intervalo | Proceso |
|---|---|
| 30–90 s | convoyes activos, combate y cercados |
| 5–15 min estratégicos | producción, demanda, rutas, mantenimiento y stocks |
| 1 h estratégica | civiles, trabajo, hospitales, energía y mercado |
| 1 día | cosecha, reemplazos, política, reconstrucción, inflación y desplazamiento |

## 55. Pipeline

1. calcular potencial;
2. validar inputs, infraestructura y trabajadores;
3. producir;
4. consumir localmente;
5. calcular excedentes y déficits;
6. crear y priorizar demandas;
7. generar movimientos;
8. resolver rutas;
9. transferir existencias;
10. crear eventos y misiones.

## 56. Transacción autoritativa

```text
RESERVE LOAD DEPART MOVE ARRIVE UNLOAD COMMIT
```

Errores:

```text
ROLLBACK PARTIAL_LOSS CAPTURE DESTROY
```

Toda transferencia posee ID idempotente y se ejecuta en el servidor. Materialización, guardado, reconexión o repetición de evento no pueden duplicar recursos.

## 57. Invariantes

1. un recurso no existe en dos ubicaciones;
2. un convoy no supera capacidad;
3. sobreocupación siempre penaliza;
4. destrucción no conserva toda la carga;
5. producción exige inputs;
6. aeropuerto exige pista;
7. puerto exige trabajadores;
8. hospital exige personal;
9. Helios exige energía;
10. ofensiva consume;
11. requisición tiene consecuencias;
12. reconstrucción no es instantánea;
13. captura no concede compatibilidad;
14. clientes no modifican existencias;
15. convoy físico y virtual nunca se duplican.

## 58. Vertical slice

Sectores: Katalaki, Neochori, Stavros–Whiskey, Lakka, AAC, Poliakko–Therisa, Xirolimni–Zaros, Airport West y Airport Terminal.

Recursos iniciales:

```text
FOOD FUEL SMALL_ARMS_AMMO HEAVY_AMMO
MEDICAL CONSTRUCTION SPARE_PARTS
```

Centros: cabeza Katalaki, distribución Neochori, depósito Verde Whiskey, agricultura Poliakko, reparación AAC y reserva del aeropuerto.

Rutas: Katalaki–Neochori, Neochori–Stavros, Stavros–Lakka, Lakka–Airport West, Poliakko–Neochori y AAC–Lakka.

## 59. Pruebas

1. agotar fuerzas sin convoyes;
2. transferir Katalaki–Neochori sin duplicación;
3. destruir parcialmente un convoy;
4. cortar combustible agrícola;
5. capturar Whiskey rápida y lentamente;
6. reparar o trasladar un Marshall;
7. mover P0 hacia Neochori;
8. guardar/cargar durante cada fase transaccional;
9. materializar/reintegrar un convoy atacado;
10. requisar y medir producción y confianza.

## 60. Orden de implementación

1. existencias, depósitos, transferencias y consumo;
2. convoyes, rutas, escoltas y pérdidas;
3. producción, trabajadores, inputs y outputs;
4. mantenimiento, reparación y recuperación;
5. economía civil y requisiciones;
6. puertos, aeropuertos, oleadas y bloqueo;
7. reconstrucción, prioridades y legitimidad;
8. optimización Helios, manipulación Argos y Stratis.

## 61. Funciones conceptuales

```text
IF_fnc_economyTick
IF_fnc_productionEvaluate IF_fnc_productionResolve
IF_fnc_resourceReserve IF_fnc_resourceTransfer IF_fnc_resourceConsume
IF_fnc_logisticsCalculateDemand IF_fnc_logisticsPrioritizeDemand
IF_fnc_logisticsCreateConvoy
IF_fnc_convoyPlanRoute IF_fnc_convoyResolveVirtual
IF_fnc_convoyMaterialize IF_fnc_convoyReintegrate
IF_fnc_hubEvaluate IF_fnc_portEvaluateThroughput
IF_fnc_airfieldEvaluateThroughput IF_fnc_maintenanceEvaluate
IF_fnc_vehicleRepair IF_fnc_vehicleRecover
IF_fnc_requisitionResolve IF_fnc_reconstructionEvaluate
IF_fnc_blackMarketResolve
```

## 62. Prohibiciones

No se permite moneda universal, recurso sin ubicación, convoy sin vehículos, suministro creado al capturar, puerto sin trabajadores, pista destruida operativa, combustible gratuito, consumo ignorado, reparación pesada en aldeas, construcción sin material, requisición sin civiles, producción plena bajo combate, duplicación al materializar, gran depósito P0, grandes convoyes FIA permanentes, Meridian infinito, Helios creador de recursos, importación instantánea ni movilización sin coste económico.

## 63. Principios vinculantes

1. recursos, depósitos y convoyes tienen ubicación;
2. rutas y centros tienen capacidad;
3. combustible y recursos civiles compiten;
4. mantenimiento y repuestos limitan disponibilidad;
5. puertos requieren trabajo; aeropuertos, pista y mantenimiento;
6. producción necesita energía, inputs y personal;
7. movilización reduce economía civil;
8. requisición mueve recursos y compensación modifica legitimidad;
9. FIA distribuye; Azul depende de accesos; Rojo del corredor; Verde de coordinación;
10. Meridian y Stratis poseen reservas finitas;
11. Helios optimiza y Argos manipula información, no materia;
12. reconstrucción compite con guerra;
13. pérdidas logísticas cancelan operaciones;
14. el jugador prioriza, no lleva contabilidad unidad por unidad;
15. el servidor gobierna toda transferencia.

## 64. Definición final

Una fuerza combate con las armas que posee y continúa combatiendo con los recursos que todavía puede transportar.

Capturar un puerto abre una posibilidad. Trabajadores, carreteras, depósitos y seguridad convierten esa posibilidad en poder.

> La economía decide qué puede reconstruirse. La logística decide qué puede llegar. El mando decide quién lo recibe primero.
