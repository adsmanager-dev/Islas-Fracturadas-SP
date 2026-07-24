# Sectores, bases, fortificaciones y módulos

> **Estado:** diseño confirmado y diseño en desarrollo
> **Fuente de verdad para:** sectores, bases, fortificaciones, módulos y construcción automática
> **Relacionados:** [10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md](10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md); [12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-07-24

## Propósito

Centralizar sectores, bases, fortificaciones, módulos y construcción automática sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [TERRITORIAL SECTOR FRONT AND CONSTRUCTION SYSTEM](#fuente-territorial-sector-front-and-construction-system)
- [TECHNICAL 3DEN MODULE AND COMPOSITION CATALOG](#fuente-technical-3den-module-and-composition-catalog)
- [THREEDEN GEOGRAPHY AND PHYSICAL VALIDATION GUIDE](#fuente-threeden-geography-and-physical-validation-guide)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md`, `TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md`, `THREEDEN_GEOGRAPHY_AND_PHYSICAL_VALIDATION_GUIDE.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

## Contenido consolidado

<a id="fuente-territorial-sector-front-and-construction-system"></a>
## Fuente integrada: `TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md`

> **Procedencia:** contenido migrado de `TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-territorial-sector-front-and-construction-system--sistema-territorial-de-sectores-frentes-y-construcción-automática"></a>
### Sistema territorial de sectores, frentes y construcción automática

> **Estado:** documento rector de diseño territorial previo a implementación.
> **Motor:** Arma 3 2.18.
> **Terrenos:** Altis y Stratis.
> **Geografía e IDs:** [ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md](10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md#fuente-altis-geography-and-sector-map).
> **Fuerzas y guarniciones:** [MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md](13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md#fuente-military-system-order-of-battle-and-force-catalog).
> **Persistencia:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).
> **Catálogo físico:** [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-technical-3den-module-and-composition-catalog).
> **Producción y suministro:** [ECONOMIC_AND_LOGISTICS_SYSTEM.md](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md#fuente-economic-and-logistics-system).
> **Mapa, paneles y prioridades visibles:** [STRATEGIC_UI_AND_PLAYER_EXPERIENCE_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system).
> **Validación física 3DEN:** [THREEDEN_GEOGRAPHY_AND_PHYSICAL_VALIDATION_GUIDE.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide).

<a id="src-territorial-sector-front-and-construction-system--1-regla-esencial"></a>
#### 1. Regla esencial

> El nivel abre capacidad; el tipo define qué puede existir; la posición en el frente decide qué conviene construir; la experiencia de combate determina hacia dónde orientarlo.

El jugador establece prioridades estratégicas. La IA selecciona módulo, sector, composición, anclaje, orientación, coste, duración y respuesta ante captura o retirada.

<a id="src-territorial-sector-front-and-construction-system--2-configuración-y-dimensiones"></a>
#### 2. Configuración y dimensiones

```text
sectorConfiguration =
    physicalType + availableLevel + frontDepth
  + observedThreats + assignedRole + ownerDoctrine
  + resourcesAndConnections
```

Cuatro dimensiones permanecen independientes:

| Dimensión | Determina |
|---|---|
| Nivel estructural | capacidad, módulos, complejidad y soporte |
| Fortificación | resistencia, profundidad y protección |
| Profundidad del frente | permisos, prioridades, evacuación y función militar |
| Estabilidad | cooperación, trabajadores, sabotaje y funcionamiento |

No existe una única variable `sectorLevel`. Un sector puede ser estructural 4, fortificación 2, primera línea y estabilidad baja.

<a id="src-territorial-sector-front-and-construction-system--3-tipos-de-sector"></a>
#### 3. Tipos de sector

| Código | Tipo | Función | Máximo ordinario |
|---|---|---|---:|
| S1 | Playa/cabeza de playa | entrada, descarga y evacuación | 3 |
| S2 | Aldea rural | población, agricultura, información y reclutamiento | 2 |
| S3 | Pueblo/municipio | administración, mercado, servicios y rutas | 3 |
| S4 | Ciudad principal | Gobierno, economía, población y legitimidad | 4 |
| S5 | Cruce/corredor | movimiento, convoyes, defensa vial y emboscadas | 2–3 |
| S6 | Base militar | mando, reservas, armas y mantenimiento | 4 |
| S7 | Aeródromo/aeropuerto | refuerzo, mantenimiento y control aéreo | 4 |
| S8 | Puerto | transporte, descarga, comercio y combustible | 4 |
| S9 | Industrial/energético/técnico | energía, reparación, producción y Helios | 3–4 |
| S10 | Nodo Helios | comunicaciones, sensores, análisis y acceso | 4 |
| S11 | Montaña/radar | observación, comunicaciones y AA | 2–3 |
| S12 | Agrícola/productivo | alimentos, población y mano de obra | 2 |
| S13 | Gubernamental | autoridad, archivos y legitimidad | 4 |
| S14 | Enclave clandestino | FIA, Argos, contrabando y escondites | red propia |

Una playa solo alcanza nivel 4 si se transforma físicamente en puerto militar. Un enclave clandestino usa capacidad de red, ocultamiento, apoyo y seguridad.

Los códigos `S1–S14` son categorías de diseño, no IDs persistentes. Los sectores usan exclusivamente identificadores `ALT_*`; el esquema histórico `S01–S38` queda retirado.

<a id="src-territorial-sector-front-and-construction-system--4-niveles-estructurales"></a>
#### 4. Niveles estructurales

| Nivel | Significado | Funcionales | Defensivos | Guarnición orientativa |
|---:|---|---:|---:|---:|
| 0 | sin estructura operacional | 0 | 0–1 provisional | 0–6 |
| 1 | presencia organizada | 2 | 2 | 8–18 |
| 2 | sector consolidado | 4 | 3 | 20–40 |
| 3 | centro regional | 6 | 4 | 40–75 |
| 4 | centro estratégico | 8 | 6 | 80–150 |

Las cifras representan capacidad territorial. La fuerza real se limita por las reservas militares y no se materializa completa.

Nivel 4 exige tipo compatible, infraestructura, espacio validado, estabilidad, conexiones, valor estratégico e inversión.

<a id="src-territorial-sector-front-and-construction-system--5-modificadores-por-tipo"></a>
#### 5. Modificadores por tipo

| Tipo | Funcionales | Defensivos |
|---|---:|---:|
| Playa | −1 | +1 |
| Aldea | −1 | 0 |
| Pueblo | 0 | 0 |
| Ciudad | +1 | 0 |
| Cruce | −1 | +1 |
| Base militar | 0 | +2 |
| Aeródromo | +1 | +1 |
| Puerto | +1 | +1 |
| Industrial | +2 | −1 |
| Nodo Helios | +1 | 0 |
| Montaña/radar | −2 | +1 |
| Agrícola | −1 | 0 |
| Gobierno | +2 | 0 |

El resultado nunca supera el máximo técnico de las composiciones validadas.

<a id="src-territorial-sector-front-and-construction-system--6-peso-de-módulos"></a>
#### 6. Peso de módulos

| Peso | Coste | Ejemplos |
|---|---:|---|
| Ligero | 1 | control, observación, radio local, HMG |
| Medio | 2 | taller, hospital de campaña, AA, depósito |
| Pesado | 3 | centro logístico, mantenimiento aéreo, mando regional, Helios avanzado |

Seis espacios admiten seis ligeros, tres medios, dos pesados o una combinación.

<a id="src-territorial-sector-front-and-construction-system--7-módulos-funcionales"></a>
#### 7. Módulos funcionales

| ID | Módulo | Capacidad | Restricción |
|---|---|---|---|
| F1 | Mando | órdenes, guarniciones y alcance | escala según sector |
| F2 | Comunicaciones | enlace y menor retraso | energía/operador |
| F3 | Inteligencia | análisis, señales e interrogación | conocimiento imperfecto |
| F4 | Suministros | munición, alimentos y construcción | no estratégico en P0/P1 |
| F5 | Combustible | vehículos, aviación y energía | solo caché táctica en P0 |
| F6 | Reparación | recuperación y mantenimiento | pesado en retaguardia |
| F7 | Sanidad | estabilización u hospital | hospital grande en P2–P4 |
| F8 | Transporte | convoyes, descarga y distribución | necesita conexiones |
| F9 | Ingeniería | defensas, carreteras y minas | necesita personal/material |
| F10 | Administración civil | servicios, registro y legitimidad | falla con baja estabilidad |
| F11 | Apoyo civil | agua, alimento, refugio y confianza | distinto de sanidad militar |
| F12 | Entrenamiento | reservistas y reemplazos | interior estable |
| F13 | Operaciones aéreas | salida, rearmado y mantenimiento | aeródromo compatible |
| F14 | Operaciones navales | patrulla, descarga y reparación | puerto/costa compatible |
| F15 | Energía | red, generadores y Helios | infraestructura física |
| F16 | Procesamiento Helios | datos, conexión y acceso | solo nodos compatibles |
| F17 | Detención | registro, custodia e interrogación | coste político |
| F18 | Centro político | negociación, propaganda y autoridad | ciudad/Gobierno/FIA |

<a id="src-territorial-sector-front-and-construction-system--8-módulos-defensivos"></a>
#### 8. Módulos defensivos

| ID | Módulo | Función |
|---|---|---|
| D1 | Control | identificación, infiltración y retraso |
| D2 | Guarnición | alojamiento, patrulla y reacción |
| D3 | Observación | alerta y orientación de fuego |
| D4 | HMG/GMG | fuego protegido |
| D5 | Antitanque | Titan AT, portátiles, obstáculos y campos de tiro |
| D6 | Antiaérea | portátiles, Titan AA, vehículo o radar |
| D7 | Mortero | fuego, humo e iluminación |
| D8 | Refugio | supervivencia de personal y mando |
| D9 | Barreras | bloqueos, muros, alambre, zanjas y obstáculos |
| D10 | Minas controladas | negación registrada y autorizada |
| D11 | Reserva de reacción | fuerza, vehículos y ruta de salida |
| D12 | Contraataque | zona preparada detrás de la defensa |
| D13 | Defensa costera | playa, lanchas y desembarco |
| D14 | Seguridad interior | sabotaje, infraestructura e insurgencia |
| D15 | Retirada | salida, reorganización y demolición condicionada |

Las minas generan riesgo civil, dificultan retirada y dejan contaminación.

<a id="src-territorial-sector-front-and-construction-system--9-profundidad-del-frente"></a>
#### 9. Profundidad del frente

| Código | Posición | Función |
|---|---|---|
| P0 | contacto | resistir, observar, retrasar y retirarse |
| P1 | primera línea | sostener, reforzar y contraatacar |
| P2 | segunda línea | logística operacional, sanidad, artillería y reserva |
| P3 | retaguardia | entrenamiento, producción, reparación y administración |
| P4 | interior | Gobierno, reserva estratégica, gran logística, mando y Helios |

P0 admite mando ligero, comunicaciones, inteligencia de campo, estabilización, ingeniería y cachés. Prohíbe centro logístico, combustible masivo, entrenamiento, producción, hospital regional, mantenimiento pesado, administración central, centro político y archivo Helios principal.

P1 admite mando local, munición limitada, reparación ligera, sanidad de campaña, QRF y apoyo defensivo. Excluye normalmente producción pesada, gran depósito, entrenamiento y archivos esenciales.

P2 admite logística media, hospital de campaña, taller, artillería, QRF, mando regional y combustible protegido.

P3 admite depósitos grandes, reparación pesada, entrenamiento, movilización, administración, apoyo civil, hospital regional y procesamiento Helios.

P4 concentra Gobierno, producción nacional, reserva, mando de teatro y nodos críticos, pero conserva seguridad contra sabotaje e infiltración.

<a id="src-territorial-sector-front-and-construction-system--10-estados-operacionales-especiales"></a>
#### 10. Estados operacionales especiales

| Estado | Consecuencia |
|---|---|
| Aislado | sin construcción pesada; consume reservas y busca salida |
| Cercado | rutas terrestres hostiles; puede conservar aire, mar u ocultas |
| Saliente | protege flancos, reserva y retirada; evita inversión estratégica |
| Cabeza de puente | prioriza refuerzo, ingeniería, control y expansión |
| Zona insurgente | inteligencia, legitimidad y seguridad antes que muros |

<a id="src-territorial-sector-front-and-construction-system--11-infraestructura-expuesta"></a>
#### 11. Infraestructura expuesta

La IA no construye logística estratégica en P0 o P1. Puede crear caché, reabastecimiento temporal, depósito oculto, recogida de heridos o reparación de emergencia.

Si un centro existente alcanza el frente, debe evacuar, dispersar, ocultar, convertir, defender temporalmente o destruir. Queda evacuado, abandonado, capturado, dañado o destruido; nunca desaparece sin consecuencia.

<a id="src-territorial-sector-front-and-construction-system--12-roles-estratégicos"></a>
#### 12. Roles estratégicos

```text
HOLD DELAY FORTRESS STAGING LOGISTICS RESERVE PRODUCTION
GOVERNANCE CIVIL_SUPPORT INTELLIGENCE AIR_OPERATIONS
NAVAL_OPERATIONS HELIOS WITHDRAWAL
```

El rol puede cambiar sin alterar el tipo físico.

<a id="src-territorial-sector-front-and-construction-system--13-cálculo-de-profundidad"></a>
#### 13. Cálculo de profundidad

1. identificar sectores enemigos y disputados;
2. calcular distancia mínima por conexiones;
3. evaluar control y estado de carreteras;
4. incluir rutas marítimas y aéreas;
5. reconocer frentes activos;
6. clasificar profundidad;
7. aplicar excepciones.

```text
distance 0 -> P0
distance 1 -> P1
distance 2 -> P2
distance 3–4 -> P3
distance 5+ -> P4
```

Es distancia operacional, no kilómetros. Una carretera enemiga acerca el frente; una montaña, puente destruido o ruta bloqueada puede alejarlo.

<a id="src-territorial-sector-front-and-construction-system--14-memoria-de-combate"></a>
#### 14. Memoria de combate

```text
attacks attackDirections usedConnections enemyTypes observedVehicles
ownCasualties estimatedEnemyCasualties weapons airActivity artillery
sabotage infiltration nightAttacks lostConvoys breachedPositions
resistanceTime
```

No se usa aprendizaje automático. Las observaciones alimentan memoria estructurada, decaimiento temporal y reglas explicables.

<a id="src-territorial-sector-front-and-construction-system--15-perfil-y-vectores-de-amenaza"></a>
#### 15. Perfil y vectores de amenaza

```sqf
threatProfile = createHashMapFromArray [
    ["infantryThreat", 55],
    ["armoredThreat", 80],
    ["airThreat", 25],
    ["artilleryThreat", 40],
    ["insurgencyThreat", 15],
    ["primaryConnection", "CONN_NEOCHORI_STAVROS"],
    ["secondaryConnection", "CONN_NEOCHORI_POLIAKKO"],
    ["nightAttackFrequency", 20],
    ["recentAttackCount", 3],
    ["lastMajorAttack", 1240]
];
```

Cada conexión tiene peso: 80 identifica ruta principal, 45 un flanco plausible y 10 riesgo bajo.

<a id="src-territorial-sector-front-and-construction-system--16-orientación-defensiva"></a>
#### 16. Orientación defensiva

La selección considera enemigo, conexión, carretera, alturas, vegetación, línea de visión, edificios, costa y retirada.

| Destino | Capacidad inicial |
|---|---:|
| Frente principal | 45 % |
| Frente secundario | 25 % |
| Seguridad interior | 15 % |
| Reserva y retirada | 15 % |

Doctrina, terreno y experiencia modifican esos pesos.

<a id="src-territorial-sector-front-and-construction-system--17-respuesta-a-amenazas"></a>
#### 17. Respuesta a amenazas

| Amenaza | Respuesta |
|---|---|
| Blindados | AT, obstáculos, embudos, minas y reserva móvil |
| Infantería | HMG, iluminación, patrullas y fuego cruzado |
| Aire | AA, dispersión, camuflaje, refugios y señuelos |
| Artillería | dispersión, movilidad, refugios y alternativas |
| Insurgencia | inteligencia, cooperación, accesos y patrullas |
| Sabotaje | guardia técnica, redundancia, inspección y trabajadores |

<a id="src-territorial-sector-front-and-construction-system--18-doctrinas-de-construcción"></a>
#### 18. Doctrinas de construcción

- **Azul:** observación, inteligencia, modularidad, movilidad, QRF y AA.
- **Rojo:** profundidad, obstáculos, blindados, artillería y reservas.
- **Verde gubernamental:** carreteras, bases y defensa institucional.
- **Verde soberanista:** emboscada, demolición, altura y retirada.
- **Verde reformista:** protección civil, corredores y mando compartido.
- **FIA:** escondites, depósitos, observación, rutas, clínicas y talleres ocultos.
- **Meridian:** sensores, accesos restringidos, refugios y posiciones interiores.

FIA solo construye puestos convencionales al controlar abiertamente territorio. Meridian no crea líneas territoriales en Altis.

<a id="src-territorial-sector-front-and-construction-system--19-evolución-estructural"></a>
#### 19. Evolución estructural

| Transición | Requisitos |
|---|---|
| 0 → 1 | control, conexión, guarnición, recursos y tiempo |
| 1 → 2 | estabilidad, ingeniería, suministro, función y pausa de combate |
| 2 → 3 | importancia, conexiones, recursos, infraestructura, mando y seguridad |
| 3 → 4 | tipo, rol, inversión, conexión, control, espacio y estabilidad/coerción |

Un P0 no evoluciona normalmente a nivel 4, aunque puede contener una fortaleza ya existente.

<a id="src-territorial-sector-front-and-construction-system--20-fortificación-independiente"></a>
#### 20. Fortificación independiente

```text
FORT_0 UNPREPARED
FORT_1 LIGHT_POSITIONS
FORT_2 ORGANIZED_DEFENSE
FORT_3 DEFENSE_IN_DEPTH
FORT_4 FORTIFIED_COMPLEX
```

Una aldea estructural 1 puede alcanzar fortificación 3 sin obtener hospital, administración ni gran logística.

<a id="src-territorial-sector-front-and-construction-system--21-ciclo-de-construcción"></a>
#### 21. Ciclo de construcción

1. evaluar sector;
2. clasificar profundidad;
3. asignar rol;
4. leer amenaza;
5. calcular capacidad;
6. detectar déficits;
7. generar candidatos;
8. filtrar prohibidos;
9. puntuar;
10. reservar recursos;
11. elegir composición;
12. validar terreno;
13. construir por fases;
14. asignar guarnición;
15. registrar resultado.

<a id="src-territorial-sector-front-and-construction-system--22-puntuación"></a>
#### 22. Puntuación

```text
score =
    strategicNeed + roleCompatibility + threatCompatibility
  + doctrineCompatibility + resourceAvailability + regionalUtility
  - vulnerability - cost - time - frontIncompatibility - civilImpact
```

Un taller pesado en P0 queda rechazado. Una posición AT frente a ataques blindados repetidos gana prioridad.

<a id="src-territorial-sector-front-and-construction-system--23-prioridades-del-jugador"></a>
#### 23. Prioridades del jugador

```text
DEFENSE LOGISTICS ANTI_TANK ANTI_AIR MEDICAL
INTELLIGENCE CIVIL_SUPPORT
```

Son pesos, no órdenes de colocación. Si el jugador pide logística en P0, el sistema puede crear una caché y recomendar el centro en P2.

El mando puede aceptar, reducir o rechazar una prioridad incompatible según autoridad. Toda excepción conserva el riesgo registrado.

<a id="src-territorial-sector-front-and-construction-system--24-fases-visibles"></a>
#### 24. Fases visibles

| Fase | Actividad |
|---|---|
| Preparación | ingenieros, limpieza y materiales |
| Estructura | barreras, tiendas, cajas y generadores |
| Equipamiento | armas, comunicaciones y herramientas |
| Operación | personal, suministro y conexión |

Combate, captura, escasez o retirada pueden detener, dañar o abandonar el proceso.

<a id="src-territorial-sector-front-and-construction-system--25-infraestructura-composiciones-y-anclajes"></a>
#### 25. Infraestructura, composiciones y anclajes

La IA prioriza edificios, hangares, hospitales, estaciones, depósitos e instalaciones militares.

```text
COMP_AT_ROAD_FLAT_BLUE_01
COMP_AT_ROAD_HILL_BLUE_02
COMP_AT_URBAN_BLUE_01
COMP_AT_FOREST_BLUE_01
```

```text
FLAT SLOPE_LOW URBAN ROAD_EDGE FOREST COAST
HILL INDUSTRIAL AIRFIELD
```

```text
ANCHOR_COMMAND ANCHOR_LOGISTICS ANCHOR_MEDICAL
ANCHOR_DEFENSE_NORTH ANCHOR_DEFENSE_EAST
ANCHOR_RESERVE ANCHOR_ARTILLERY ANCHOR_CIVIL
```

Construcción automática no significa posición aleatoria. Cada sector usa zonas, orientaciones y composiciones verificadas en 3DEN.

<a id="src-territorial-sector-front-and-construction-system--26-validación-del-terreno"></a>
#### 26. Validación del terreno

Se comprueban pendiente, colisiones, edificios, carretera, agua, altura, línea de visión, distancia civil, espacio vehicular, navegación IA, vegetación y rendimiento.

Ante fallo se prueba otro anclaje, otra composición o menor tamaño; después se cancela y registra el diagnóstico.

<a id="src-territorial-sector-front-and-construction-system--27-captura-y-consolidación"></a>
#### 27. Captura y consolidación

| Estado | Definición |
|---|---|
| C0 — Contacto | entrada enemiga |
| C1 — Disputa | presencia capaz de desafiar |
| C2 — Ruptura | pérdida de puntos esenciales |
| C3 — Aseguramiento | centro, rutas y posiciones dominadas |
| C4 — Consolidación | guarnición, limpieza, conexión e inventario |
| C5 — Estabilización | actividad política, social y económica |

Captura militar no concede automáticamente producción, legitimidad, apoyo civil, acceso Helios ni uso de instalaciones.

<a id="src-territorial-sector-front-and-construction-system--28-puntos-esenciales"></a>
#### 28. Puntos esenciales

| Tipo | Puntos |
|---|---|
| Pueblo | municipio, acceso vial y guarnición |
| Puerto | muelles, almacenes y costa |
| Aeródromo | pista, torre, hangares y AA |
| Base | mando, depósitos, defensa y acceso |
| Helios | instalación, energía, comunicaciones y credenciales |

<a id="src-territorial-sector-front-and-construction-system--29-módulos-capturados"></a>
#### 29. Módulos capturados

```text
INTACT DAMAGED DISABLED SABOTAGED DESTROYED
CAPTURED EVACUATED
```

El nuevo propietario puede reparar, convertir, desmontar, saquear o destruir. La conversión requiere técnicos, limpieza, munición, comunicaciones y, cuando proceda, nueva composición visual.

<a id="src-territorial-sector-front-and-construction-system--30-producción"></a>
#### 30. Producción

| Sector | Producción o servicio |
|---|---|
| Agrícola | alimentos, trabajadores y apoyo |
| Industrial | construcción, piezas y reparación |
| Energético | electricidad, combustible y Helios |
| Puerto | suministros, comercio y embarcaciones |
| Aeropuerto | transporte, refuerzos y evacuación |
| Ciudad | administración, impuestos, servicios y mano de obra |
| Base | preparación, entrenamiento, mando y almacenamiento |
| Helios | inteligencia, coordinación y datos |

Controlar no equivale a operar. Producción exige energía, trabajadores, seguridad, conexión, materia prima y autoridad.

<a id="src-territorial-sector-front-and-construction-system--31-guarniciones-y-presión-de-personal"></a>
#### 31. Guarniciones y presión de personal

```text
requiredGarrison =
    sectorBaseValue + frontalThreat + infrastructureValue
  + insurgencyRisk - regionalSupport - personnelShortage
```

P0 concentra línea, observación, AT y control; P1 añade reserva, mortero y QRF; P2 protege apoyo, artillería y logística; P3/P4 enfatizan seguridad interior.

Un sector sin guarnición puede sufrir sabotaje, perder módulos o cambiar autoridad. Cada soldado en una carretera deja de estar disponible para una ofensiva.

<a id="src-territorial-sector-front-and-construction-system--32-líneas-defensivas"></a>
#### 32. Líneas defensivas

Una defensa coherente combina:

- línea principal: contacto y puntos fuertes;
- línea secundaria: reservas, artillería, sanidad y logística;
- retaguardia: depósitos, mando, entrenamiento y producción.

La IA identifica fortalezas, huecos, salientes, cuellos de botella y cercos.

<a id="src-territorial-sector-front-and-construction-system--33-corredores-principales"></a>
#### 33. Corredores principales

```text
Kavala <-> Aggelochori <-> Kore–Topolia
       <-> Agios Dionysios <-> Lakka <-> Telos
Katalaki <-> Neochori <-> Stavros–Whiskey
          <-> Lakka <-> Airport West
Xirolimni–Zaros <-> Poliakko–Therisa <-> Neochori
Athira <-> Gravia <-> Airport <-> Telos
Telos <-> Rodopoli <-> Kalochori–Paros <-> Sofia <-> Molos
Rodopoli <-> Charkia <-> Pyrgos
         <-> Dorida–Chalkeia <-> Feres–Selakano
```

<a id="src-territorial-sector-front-and-construction-system--34-matriz-de-los-38-sectores"></a>
#### 34. Matriz de los 38 sectores

| ID | Sector | Tipo | Máx. |
|---|---|---|---:|
| `ALT_W_KAVALA_PORT` | Puerto de Kavala | Puerto | 4 |
| `ALT_W_KAVALA_CITY` | Kavala | Ciudad | 4 |
| `ALT_W_AGGELOCHORI` | Aggelochori | Pueblo | 3 |
| `ALT_W_NERI_PANOCHORI` | Neri–Panochori | Rural | 2 |
| `ALT_W_AGIOS_DIONYSIOS` | Agios Dionysios | Cruce | 3 |
| `ALT_W_KORE_TOPOLIA` | Kore–Topolia | Rural | 2 |
| `ALT_NW_OREOKASTRO` | Oreokastro | Montaña/pueblo | 3 |
| `ALT_NW_ABDERA_GALATI` | Abdera–Galati | Rural | 2 |
| `ALT_NW_SYRTA` | Syrta | Base menor | 3 |
| `ALT_NW_THRONOS` | Thronos | Montaña | 2 |
| `ALT_NW_WIND` | Parque eólico NW | Energía | 3 |
| `ALT_CW_KATALAKI` | Katalaki Bay | Playa | 3 |
| `ALT_CW_NEOCHORI` | Neochori | Pueblo/puerto menor | 3 |
| `ALT_CW_STAVROS_WHISKEY` | Stavros–Whiskey | Base militar | 4 |
| `ALT_CW_LAKKA` | Lakka | Cruce | 3 |
| `ALT_CW_AAC` | AAC Airfield | Aeródromo | 4 |
| `ALT_CW_POLIAKKO_THERISA` | Poliakko–Therisa | Agrícola | 2 |
| `ALT_CW_XIROLIMNI_ZAROS` | Xirolimni–Zaros | Rural/industrial | 3 |
| `ALT_C_AIRPORT_WEST` | Airport West | Aeródromo/base | 4 |
| `ALT_C_AIRPORT_TERMINAL` | Airport Terminal | Aeropuerto | 4 |
| `ALT_C_AIRPORT_MIL` | Airport Military | Base/Helios | 4 |
| `ALT_C_TELOS` | Telos | Cruce/pueblo | 3 |
| `ALT_C_GRAVIA` | Gravia | Pueblo | 3 |
| `ALT_C_ATHIRA` | Athira | Ciudad | 4 |
| `ALT_NC_FRINI_AGIA_TRIADA` | Frini–Agia Triada | Rural/costa | 2 |
| `ALT_NC_KALITHEA` | Kalithea | Rural | 2 |
| `ALT_E_RODOPOLI` | Rodopoli | Pueblo/cruce | 3 |
| `ALT_E_KALOCHORI_PAROS` | Kalochori–Paros | Pueblo | 3 |
| `ALT_NE_IOANNINA_DELFINAKI` | Ioannina–Delfinaki | Rural/costa | 2 |
| `ALT_NE_SOFIA` | Sofia | Pueblo/cruce | 3 |
| `ALT_NE_PEFKAS` | Pefkas Bay | Playa/puerto menor | 2 |
| `ALT_NE_MOLOS` | Molos | Pueblo/puerto | 3 |
| `ALT_NE_MOLOS_AIRFIELD` | Molos Airfield | Aeródromo | 3 |
| `ALT_SE_CHARKIA` | Charkia | Pueblo/cruce | 3 |
| `ALT_SE_PYRGOS_HARBOUR` | Pyrgos Harbour | Puerto | 4 |
| `ALT_SE_PYRGOS_GOV` | Pyrgos Government | Gobierno/ciudad | 4 |
| `ALT_SE_DORIDA_CHALKEIA` | Dorida–Chalkeia | Pueblo | 3 |
| `ALT_SE_FERES_SELAKANO` | Feres–Selakano | Energía/rural | 3 |

El documento geográfico conserva autoridad sobre límites, nombres, regiones y conexiones. Esta matriz gobierna tipo y techo estructural.

<a id="src-territorial-sector-front-and-construction-system--35-ejemplos-del-corredor-azul"></a>
#### 35. Ejemplos del corredor Azul

<a id="src-territorial-sector-front-and-construction-system--katalaki"></a>
##### Katalaki

Comienza estructural 0, fortificación 0–1, P0 y `BEACHHEAD`. Tras el desembarco crea mando, comunicaciones, observación y perímetro. Solo alcanza nivel 2 si Neochori está seguro, existe descarga, las alturas no dominan y llegan ingenieros. Cuando el frente se aleja puede ser logística marítima.

<a id="src-territorial-sector-front-and-construction-system--neochori"></a>
##### Neochori

Como pueblo máximo 3 admite seis espacios funcionales y cuatro defensivos. En P0 usa mando, comunicaciones, ingeniería, estabilización, control vial, AT hacia Stavros, observación y retirada. En P2 añade depósito medio, reparación, hospital y distribución.

<a id="src-territorial-sector-front-and-construction-system--stavroswhiskey"></a>
##### Stavros–Whiskey

Base máxima 4 y +2 defensivos. Capturada en P0 se limpia, repara y orienta hacia Lakka; no se convierte de inmediato en centro logístico.

<a id="src-territorial-sector-front-and-construction-system--lakka"></a>
##### Lakka

Cruce máximo 3. En P0 prioriza control, AT, observación, guarnición y mortero. En P2 funciona como reserva, distribución, taller ligero y mando.

<a id="src-territorial-sector-front-and-construction-system--airport-west"></a>
##### Airport West

En primera línea dispersa hangares, evacua combustible, limita aeronaves y degrada mantenimiento. En P2/P3 activa operaciones aéreas, logística, hospital, mando, depósitos y Helios. Pista capturada no equivale a pista operativa.

<a id="src-territorial-sector-front-and-construction-system--36-ia-helios-y-argos"></a>
#### 36. IA, Helios y Argos

El estado territorial real permanece separado de lo que cada actor conoce. Propiedad probable, guarniciones, fortificaciones, recursos y actividad clandestina se revelan según [HELIOS_INTELLIGENCE_AND_FOG_OF_WAR_SYSTEM.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-helios-intelligence-and-fog-of-war-system), nunca por lectura directa del estado autoritativo.

- Ward separa entrada, distribución y mando.
- Hale favorece QRF y concentración avanzada.
- Navid convierte Sofia en profundidad de Molos.
- Vahid prioriza mecanizados, artillería y obstáculos.
- Varos construye líneas sucesivas.

Helios mejora detección, predicción, distribución, orientación y energía, pero no construye. Argos puede exagerar vectores, ocultar sabotaje o recomendar posiciones peligrosas. La divergencia entre ataques reales y defensas construidas puede ser evidencia.

<a id="src-territorial-sector-front-and-construction-system--37-movimiento-del-frente"></a>
#### 37. Movimiento del frente

De P3 a P1: revisar módulos, evacuar vulnerables, fortificar, reducir producción, desplazar civiles y reservas, elegir línea y actualizar composiciones.

De P0 a P2: desmontar posiciones innecesarias, conservar defensas útiles, activar reparación y logística, restablecer servicios, reducir guarnición frontal y crear reserva regional.

El frente mueve formaciones lógicas. Su representación como grupos, guarniciones, QRF, oleadas o combate abstracto se rige por [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system).

<a id="src-territorial-sector-front-and-construction-system--38-evacuación"></a>
#### 38. Evacuación

```text
ACTIVE PACKING EVACUATING RELOCATING ABANDONED
CAPTURED DESTROYED
```

Comunicaciones, hospitales de campaña, talleres ligeros, munición y personal son trasladables. Hangares, centrales, pistas, edificios, depósitos subterráneos y HELIOS-0 no lo son con facilidad.

<a id="src-territorial-sector-front-and-construction-system--39-consecuencias-civiles"></a>
#### 39. Consecuencias civiles

Captura, fortificación y profundidad del frente alimentan seguridad y daño; no conceden gobierno ni legitimidad. La transición de control militar a autoridad efectiva se rige por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-civil-municipal-political-stability-system).

Fortificar una ciudad modifica tráfico, comercio, vivienda, legitimidad y daño esperado. Autoridades nacionales, municipales y civiles pueden oponerse a módulos. Defender, evacuar, destruir, fortificar o declarar abierta una ciudad son decisiones militares y políticas.

<a id="src-territorial-sector-front-and-construction-system--40-estado-lógico-de-módulo"></a>
#### 40. Estado lógico de módulo

```sqf
moduleState = createHashMapFromArray [
    ["id", "MODULE_ALT_CW_NEOCHORI_AT_01"],
    ["sectorId", "ALT_CW_NEOCHORI"],
    ["moduleType", "DEFENSE_AT"],
    ["ownerFactionId", "FAC_BLUE"],
    ["tier", 2],
    ["capacityCost", 1],
    ["status", "ACTIVE"],
    ["compositionId", "COMP_BLUE_AT_ROAD_02"],
    ["anchorId", "ANCHOR_DEFENSE_EAST"],
    ["orientation", 82],
    ["condition", 90],
    ["staffing", 100],
    ["supply", 70],
    ["threatConnectionId", "CONN_NEOCHORI_STAVROS"],
    ["createdAt", 720],
    ["lastEvaluation", 920]
];
```

<a id="src-territorial-sector-front-and-construction-system--41-modelo-territorial-ampliado"></a>
#### 41. Modelo territorial ampliado

```sqf
sectorState = createHashMapFromArray [
    ["id", "ALT_CW_NEOCHORI"],
    ["sectorType", "TOWN_COASTAL"],
    ["structuralLevel", 2],
    ["fortificationLevel", 2],
    ["maxStructuralLevel", 3],
    ["functionalCapacityBase", 4],
    ["defensiveCapacityBase", 3],
    ["functionalCapacityModifier", 0],
    ["defensiveCapacityModifier", 0],
    ["functionalCapacityUsed", 3],
    ["defensiveCapacityUsed", 2],
    ["frontDepth", "P0_CONTACT"],
    ["strategicRole", "HOLD"],
    ["controlState", "CONSOLIDATING"],
    ["militaryOwner", "FAC_BLUE"],
    ["politicalAuthority", "FAC_GOVERNMENT"],
    ["militaryControl", 72],
    ["stability", 38],
    ["moduleIds", []],
    ["garrisonId", ""],
    ["connectionIds", []],
    ["threatProfile", createHashMap],
    ["attackVectors", createHashMap],
    ["combatMemory", []],
    ["constructionQueue", []],
    ["evacuationQueue", []]
];
```

<a id="src-territorial-sector-front-and-construction-system--42-funciones-conceptuales"></a>
#### 42. Funciones conceptuales

```text
IF_fnc_sectorEvaluate
IF_fnc_sectorClassifyFrontDepth
IF_fnc_sectorAssignRole
IF_fnc_sectorCalculateCapacity
IF_fnc_sectorEvaluateThreat
IF_fnc_sectorUpdateAttackVectors
IF_fnc_sectorGenerateModuleCandidates
IF_fnc_sectorFilterModules
IF_fnc_sectorScoreModule
IF_fnc_sectorQueueConstruction
IF_fnc_sectorQueueEvacuation
IF_fnc_sectorResolveCapture
IF_fnc_sectorConsolidate
IF_fnc_sectorUpdateProduction
IF_fnc_sectorUpdateGarrison
IF_fnc_sectorOrientDefenses
IF_fnc_sectorSelectComposition
IF_fnc_sectorValidateAnchor
```

<a id="src-territorial-sector-front-and-construction-system--43-rendimiento-y-materialización"></a>
#### 43. Rendimiento y materialización

| Zona | Evaluación |
|---|---|
| Frente activo | 30–90 s |
| Segunda línea | 2–4 min |
| Interior | 5–10 min |

Se fuerza evaluación ante cambio de propietario, ataque mayor, caída de conexión o nodo, oleada o ruptura de alianza.

No se revisan 38 sectores cada segundo ni se materializan todas las bases. Los módulos lejanos son datos y aparecen cerca del jugador, en misión, bajo ataque o en cinemática.

Una composición usa propietario, estado, condición, daño, personal y suministro. Un módulo al 45 % no renace intacto.

<a id="src-territorial-sector-front-and-construction-system--44-vertical-slice"></a>
#### 44. Vertical slice

| Sector | Estructura | Fortificación | Profundidad inicial |
|---|---:|---:|---|
| Katalaki | 0 | 1 | P0 |
| Neochori | 1 | 1 | P0 |
| Stavros–Whiskey | 3 | 3 | P1 Verde |
| Lakka | 2 | 2 | P2 Verde |
| AAC | 2 | 2 | P2 Verde |
| Poliakko–Therisa | 1 | 0 | P2 |
| Xirolimni–Zaros | 1 | 1 | P3 |
| Airport West | 3 | 3 | P3 |
| Airport Terminal | 4 | 2 | P4 |

Valida captura, movimiento del frente, prohibiciones, orientación, memoria, guarnición, evacuación y materialización.

<a id="src-territorial-sector-front-and-construction-system--45-pruebas-obligatorias"></a>
#### 45. Pruebas obligatorias

1. capturar Neochori y desplazar P0;
2. repetir tres ataques blindados por una conexión;
3. atacar por flanco sin anular el frente principal;
4. pedir logística pesada en P0;
5. aislar un sector;
6. romper desde P3 hasta P0;
7. capturar y convertir un taller;
8. fortificar una ciudad y medir daño civil;
9. guardar/cargar colas, módulos y memoria;
10. materializar y reintegrar sin duplicación.

<a id="src-territorial-sector-front-and-construction-system--46-prohibiciones"></a>
#### 46. Prohibiciones

No se permite logística pesada en P0/P1, orientación uniforme, bases idénticas, módulos teleportados, nivel 4 indiscriminado, construcción sin recursos, producción plena bajo ataque, guarniciones infinitas, respuesta puramente militar a insurgencia, olvido de combates, bloqueo de rutas IA, materialización lejana, reconstrucción inmediata ni control completo al capturar una bandera.

Helios tampoco decide ni actúa sin operadores.

<a id="src-territorial-sector-front-and-construction-system--47-principios-vinculantes"></a>
#### 47. Principios vinculantes

1. Tipo, estructura, fortificación, frente y estabilidad son diferentes.
2. Capacidad funcional y defensiva son independientes.
3. Nivel 3 estándar admite seis espacios funcionales y cuatro defensivos.
4. Tipo y peso modifican capacidad real.
5. P0/P1 no admiten logística estratégica ordinaria.
6. Construcción responde a amenaza, doctrina, terreno y conexiones.
7. La IA adapta pesos mediante memoria; no aprende mágicamente.
8. El jugador prioriza, pero no coloca.
9. Infraestructura, composición y anclaje se validan en 3DEN.
10. Construcción, evacuación, captura y conversión consumen tiempo y recursos.
11. Control militar no equivale a estabilidad ni producción.
12. Más territorio y guarnición pueden reducir fuerza ofensiva.
13. FIA construye redes; Argos, accesos y enclaves.
14. Toda decisión debe ser explicable y persistente.

<a id="src-territorial-sector-front-and-construction-system--48-definición-final"></a>
#### 48. Definición final

El territorio no es una colección de círculos que cambian de color. Cada sector posee identidad, capacidad, función, población, conexiones, memoria y posición dentro del frente.

Una línea defensiva no es una fila de armas: relaciona puestos, reservas, carreteras, hospitales, talleres, depósitos y rutas de retirada. Cuando el frente se mueve, la infraestructura debe adaptarse o convertirse en botín.

<a id="src-territorial-sector-front-and-construction-system--49-siguiente-contrato-técnico"></a>
#### 49. Siguiente contrato técnico

El catálogo técnico de módulos y composiciones 3DEN queda definido en [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-technical-3den-module-and-composition-catalog). El siguiente contrato es el sistema económico y logístico completo.

---

<a id="fuente-technical-3den-module-and-composition-catalog"></a>
## Fuente integrada: `TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md`

> **Procedencia:** contenido migrado de `TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-technical-3den-module-and-composition-catalog--catálogo-técnico-de-módulos-y-composiciones-3den"></a>
### Catálogo técnico de módulos y composiciones 3DEN

> **Jerarquía:** este documento conserva el catálogo físico de composiciones. Cuándo se materializan, cómo se dañan, desmaterializan y reintegran se rige por [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system); su registro, configuración, adaptadores, bootstrap y contratos SQF, por [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture); y su colocación, ajuste al terreno, pruebas de IA y aprobación, por [THREEDEN_GEOGRAPHY_AND_PHYSICAL_VALIDATION_GUIDE.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide).

> **Estado:** contrato rector de producción y balance previo a construir la biblioteca.
> **Motor:** Arma 3 2.18.
> **Dependencia obligatoria:** juego base.
> **Perfiles opcionales:** DLC oficiales y paquetes de mods.
> **Autoridad territorial:** [TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-territorial-sector-front-and-construction-system).
> **Persistencia:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).
> **Costes y recursos:** [ECONOMIC_AND_LOGISTICS_SYSTEM.md](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md#fuente-economic-and-logistics-system).

<a id="src-technical-3den-module-and-composition-catalog--1-propósito"></a>
#### 1. Propósito

Este catálogo transforma capacidades territoriales en composiciones producibles. Define función, coste, recursos, tiempo, personal, profundidades permitidas, sectores compatibles, objetos candidatos, variantes, anclajes, orientación, daño, materialización y validación.

El contrato sirve al diseño 3DEN, sistema territorial, IA estratégica, persistencia, logística, guarniciones y pruebas.

<a id="src-technical-3den-module-and-composition-catalog--2-principio"></a>
#### 2. Principio

Un módulo no es una lista aleatoria de objetos. Reúne:

1. capacidad estratégica;
2. representación visual;
3. personal;
4. recursos;
5. interacción;
6. entradas y salidas;
7. campo de tiro o zona de servicio;
8. estado persistente;
9. variantes de terreno;
10. construcción, captura y evacuación.

Una posición AT necesita vector defendido, tiro útil, operador, refugio, munición, acceso y retirada; no solo un lanzador estático.

<a id="src-technical-3den-module-and-composition-catalog--3-flujo-técnico"></a>
#### 3. Flujo técnico

1. construir manualmente en 3DEN;
2. validar colocación, movimiento, combate, daño y rendimiento;
3. exportar datos relativos con `BIS_fnc_objectsGrabber`;
4. revisar y registrar la plantilla;
5. recrear mediante `BIS_fnc_objectsMapper`;
6. vincular los objetos devueltos al ID persistente;
7. registrar daño e inventario al desmaterializar.

```sqf
private _objects = [
    _position,
    _azimuth,
    _objectsArray,
    _badChance
] call BIS_fnc_objectsMapper;
```

`badChance` solo controla omisión probabilística y nunca sustituye el modelo de daño semántico.

<a id="src-technical-3den-module-and-composition-catalog--4-orientación"></a>
#### 4. Orientación

No se aplican `setDir` y `setVectorDirAndUp` al mismo objeto dentro del mismo ajuste. Para pendientes se conserva la orientación exportada y se transforma una sola vez.

| Modo | Aplicación |
|---|---|
| `FACE_THREAT` | AT, HMG, observación, búnker y costa |
| `ALIGN_ROAD` | controles, barreras e inspección |
| `ALIGN_COAST` | costa, muelle y observación naval |
| `ALIGN_RUNWAY` | aire, reparación y estacionamiento |
| `ALIGN_BUILDING` | mando, administración, sanidad e inteligencia |
| `FIXED_SITE` | HELIOS-0, PHAROS, hangares y centros estratégicos |

<a id="src-technical-3den-module-and-composition-catalog--5-perfiles-visuales"></a>
#### 5. Perfiles visuales

<a id="src-technical-3den-module-and-composition-catalog--azul"></a>
##### Azul

```text
Land_Cargo_House_V1_F Land_Cargo_HQ_V1_F
Land_Cargo_Patrol_V1_F Land_Cargo_Tower_V1_F
Land_Medevac_house_V1_F Land_Medevac_HQ_V1_F
CamoNet_BLUFOR_F CamoNet_BLUFOR_open_F
Land_Cargo10_military_green_F Land_Cargo20_military_green_F
```

<a id="src-technical-3den-module-and-composition-catalog--rojo"></a>
##### Rojo

```text
Land_Cargo_House_V3_F Land_Cargo_HQ_V3_F
Land_Cargo_Patrol_V3_F Land_Cargo_Tower_V3_F
CamoNet_OPFOR_F CamoNet_OPFOR_open_F
Land_Cargo10_sand_F Land_Cargo20_sand_F
```

<a id="src-technical-3den-module-and-composition-catalog--verde"></a>
##### Verde

```text
Land_Cargo_House_V2_F Land_Cargo_HQ_V2_F
Land_Cargo_Patrol_V2_F Land_Cargo_Tower_V2_F
CamoNet_INDP_F CamoNet_INDP_open_F
Land_Cargo10_military_green_F Land_Cargo20_military_green_F
```

<a id="src-technical-3den-module-and-composition-catalog--fia"></a>
##### FIA

Reutiliza edificios, almacenes, sacos, redes y material Verde capturado. No posee una arquitectura uniforme.

<a id="src-technical-3den-module-and-composition-catalog--meridian"></a>
##### Meridian

Mezcla estructuras V1/V3 y redes BLUFOR/OPFOR para mostrar proveedores diferentes. No utiliza una paleta homogénea.

<a id="src-technical-3den-module-and-composition-catalog--6-familias-de-fortificación"></a>
#### 6. Familias de fortificación

```text
Land_BagFence_Short_F Land_BagFence_Long_F
Land_BagFence_Round_F Land_BagFence_Corner_F
Land_BagFence_End_F Land_BagBunker_Small_F
Land_BagBunker_Large_F Land_BagBunker_Tower_F

Land_HBarrier_1_F Land_HBarrier_3_F Land_HBarrier_5_F
Land_HBarrier_Big_F Land_HBarrierTower_F
Land_HBarrierWall4_F Land_HBarrierWall6_F
Land_HBarrierWall_corner_F Land_HBarrierWall_corridor_F

Land_Mil_WallBig_4m_F Land_Mil_WallBig_Corner_F
Land_Mil_WallBig_Gate_F Land_Mil_WiredFence_F Land_Razorwire_F

Land_CncBarrier_F Land_CncBarrier_stripes_F
Land_CncBarrierMedium_F Land_CncBarrierMedium4_F
Land_CncShelter_F Land_CncWall1_F Land_CncWall4_F
BlockConcrete_F Land_ConcreteHedgehog_01_F

Dirthump_1_F Dirthump_2_F Dirthump_3_F
```

Todas son clases candidatas hasta pasar validación automática en la build objetivo.

<a id="src-technical-3den-module-and-composition-catalog--7-objetos-técnicos-candidatos"></a>
#### 7. Objetos técnicos candidatos

| Función | Clases |
|---|---|
| Iluminación | `Land_PortableLight_single_F`, `Land_PortableLight_double_F` |
| Energía | `Land_PowerGenerator_F` |
| Comunicaciones | `Land_Communication_F`, `Land_Radar_Small_F`, `Land_Radar_F` |
| Reparación | `Land_CarService_F`, `Land_Workbench_01_F`, `Land_EngineCrane_01_F`, `Land_DieselGroundPowerUnit_01_F` |
| Almacenamiento | `Land_Cargo10_*`, `Land_Cargo20_*`, `Land_Cargo40_*` |

Una clase oficial no se presume automáticamente disponible en el perfil básico: `requiredAddons`, licencia y sustituto deben quedar registrados.

<a id="src-technical-3den-module-and-composition-catalog--8-cajas-por-facción"></a>
#### 8. Cajas por facción

| Perfil | Familias |
|---|---|
| Azul | `Box_NATO_Ammo_F`, `Wps`, `WpsLaunch`, `Support`, `AmmoVeh`, `AmmoOrd`, `Grenades` |
| Rojo | `Box_East_Ammo_F`, `Wps`, `WpsLaunch`, `Support`, `AmmoVeh`, `AmmoOrd`, `Grenades` |
| Verde | `Box_IND_Ammo_F`, `Wps`, `WpsLaunch`, `Support`, `AmmoVeh`, `AmmoOrd`, `Grenades` |
| FIA | `Box_Ammo_F`, `Box_Wps_F`, `Land_Box_AmmoOld_F` |

Los nombres abreviados de la tabla representan la clase completa con el prefijo de su facción.

<a id="src-technical-3den-module-and-composition-catalog--9-armas-estáticas"></a>
#### 9. Armas estáticas

| Perfil | HMG/GMG | Mortero | AT/AA |
|---|---|---|---|
| Azul | `B_HMG_01_*`, `B_GMG_01_*` | `B_Mortar_01_F` | `B_static_AT_F`, `B_static_AA_F` |
| Rojo | `O_HMG_01_*`, `O_GMG_01_*` | `O_Mortar_01_F` | `O_static_AT_F`, `O_static_AA_F` |
| Verde | `I_HMG_01_*`, `I_GMG_01_*` | `I_Mortar_01_F` | `I_static_AT_F`, `I_static_AA_F` |
| FIA | `B_G_HMG_02_*` o `I_G_HMG_02_*` | `B_G_Mortar_01_F` o `I_G_Mortar_01_F` | captura o equipo portátil |

La proyección técnica FIA depende del lado de la misión, no cambia su identidad persistente.

<a id="src-technical-3den-module-and-composition-catalog--10-recursos-de-construcción"></a>
#### 10. Recursos de construcción

```text
CONSTRUCTION ELECTRONICS AMMUNITION FUEL MEDICAL PERSONNEL
```

`PERSONNEL` representa dotación asignada, no consumo permanente. Piezas de repuesto pertenecen a los costes de reparación y mantenimiento aunque se presenten separadas en las fichas.

<a id="src-technical-3den-module-and-composition-catalog--11-escala-de-costes"></a>
#### 11. Escala de costes

| Clase | Capacidad | Construcción | Tiempo | Personal |
|---|---:|---:|---:|---:|
| Ligero | 1 | 10–25 | 2–8 h | 2–6 |
| Medio | 2 | 30–70 | 8–24 h | 6–16 |
| Pesado | 3 | 80–160 | 1–4 días | 15–40 |
| Estratégico | 4+ | 180–400 | 4–12 días | 30–100 |

Los estratégicos reutilizan normalmente infraestructura existente.

<a id="src-technical-3den-module-and-composition-catalog--12-modificadores-de-tiempo"></a>
#### 12. Modificadores de tiempo

| Factor | Multiplicador |
|---|---:|
| Ingenieros completos/parciales/insuficientes | ×1,00 / ×1,35 / ×2,00 |
| Sin ingenieros | bloqueado |
| P0/P1/P2/P3/P4 | ×1,80 / ×1,40 / ×1,10 / ×1,00 / ×0,90 |
| Ataque ocasional/hostigamiento/directo | ×1,25 / ×1,60 / suspendido |
| Edificio reutilizable/dañado/nuevo | ×0,55 / ×0,80 / ×1,00 |
| Estabilidad alta/media/baja/colapso | ×0,90 / ×1,00 / ×1,30 / ×1,80 o bloqueo |

<a id="src-technical-3den-module-and-composition-catalog--13-catálogo-funcional"></a>
#### 13. Catálogo funcional

Los costes son unidades estratégicas internas.

| ID | Módulo | Cap. | Construcción y recursos especiales | Personal | Tiempo | Profundidad |
|---|---|---:|---|---:|---|---|
| F1 | Mando táctico | 1 | C20, E10, F5 | 4–8 | 4–8 h | P0–P4 |
| F2 | CG regional | 3 | C120, E80, F30 | 25–45 | 2–4 d | P2–P4 |
| F3 | Comunicaciones | 1 | C25, E25, F5 | 4–8 | 6–12 h | P0–P4 |
| F4 | Inteligencia local | 1 | C20, E30 | 5–10 | 8–16 h | P0–P4 |
| F5 | Inteligencia regional | 3 | C100, E130, F20 | 20–40 | 2–5 d | P2–P4 |
| F6 | Caché táctico | 1 | C10, A variable | 2–4 | 2–4 h | P0–P4 |
| F7 | Depósito de suministros | 2 | C60, F10 | 10–18 | 16–30 h | P2–P4 |
| F8 | Depósito estratégico | 3 | C150, F30 | 25–40 | 3–6 d | P3–P4 |
| F9 | Combustible táctico | 1 | C15, combustible limitado | 2–4 | 3–6 h | P0–P3 |
| F10 | Depósito de combustible | 3 | C100, F150+ | 12–24 | 2–4 d | P2–P4 |
| F11 | Reparación ligera | 1 | C30, P20, F5 | 5–10 | 8–16 h | P1–P4 |
| F12 | Taller pesado | 3 | C140, P100, F40 | 20–40 | 3–7 d | P2–P4 |
| F13 | Médico avanzado | 1 | C20, M25 | 4–8 | 4–8 h | P0–P4 |
| F14 | Hospital de campaña | 2 | C70, M100, F15 | 15–35 | 1–3 d | P2–P4 |
| F15 | Hospital regional | 3 | C180, M200 | 50+ | 5–10 d | P3–P4 |
| F16 | Ingeniería | 1 | C30, F10 | 6–12 | 8–18 h | P0–P4 |
| F17 | Administración civil | 2 | C25, E15 | 12–30 | 1–3 d | P2–P4 |
| F18 | Ayuda civil | 2 | C40, M30 | 10–30 | 12–24 h | P1–P4 |
| F19 | Entrenamiento | 3 | C90, A30 | 15–30 instructores | 3–6 d | P3–P4 |
| F20 | Aire ligero | 2 | C70, E30, F60 | 15–30 | 1–3 d | P2–P4 |
| F21 | Aire completo | 4 | C250, E150, F250 | 60+ | 7–14 d | P3–P4 |
| F22 | Operaciones navales | 2 | C70, F50 | 15–30 | 2–4 d | P1–P4 |
| F23 | Energía local | 2 | C80, E40, F50 | 8–20 | 2–4 d | P2–P4 |
| F24 | Nodo Helios local | 2 | C70, E120, F20 | 10–20 | 2–5 d | P2–P4 |
| F25 | Helios regional | 4 | C250, E350 | 40–80 | 8–20 d | P3–P4 |
| F26 | Detención | 2 | C60 | 15–30 | 1–3 d | P2–P4 |
| F27 | Centro político | 2 | C30, E20 | 15–50 | 1–3 d | P2–P4 |

Leyenda: C construcción, E electrónica, A munición, F combustible, M medicina, P piezas.

<a id="src-technical-3den-module-and-composition-catalog--14-reglas-funcionales-específicas"></a>
#### 14. Reglas funcionales específicas

- F2 exige nivel 3, comunicaciones, suministro y conexión.
- F7 está prohibido en P0; en P1 solo sobrevive una versión reducida existente.
- F8 se divide en almacenamiento, carga, seguridad y administración.
- F10 se separa de población, hospital y mando, y necesita cisternas, dispersión y AA.
- F12 exige acceso y maniobra para pesados.
- F13 estabiliza; no ofrece recuperación avanzada.
- F15, F17 y F27 reutilizan edificios civiles adecuados.
- F18 no comparte espacio con munición, artillería, combustible u objetivo mayor.
- F21 requiere pista, torre, mantenimiento, AA y logística existentes.
- F22 requiere costa navegable, muelle, profundidad y acceso terrestre.
- F24 necesita red Helios preexistente, claves, técnico, energía y conexión.
- F25 solo existe en ubicaciones canónicas.
- F26 genera consecuencias de miedo, inteligencia, radicalización y política.

<a id="src-technical-3den-module-and-composition-catalog--15-activos-funcionales-característicos"></a>
#### 15. Activos funcionales característicos

| Módulos | Activos candidatos |
|---|---|
| F1–F5 | Cargo Patrol/House/HQ, `Land_Communication_F`, radar, generador |
| F6–F10 | cajas, Cargo10/20, redes, iluminación y barreras |
| F11–F12 | CarService, Workbench, EngineCrane, GPU y contenedores |
| F13–F15 | Medevac House/HQ o infraestructura sanitaria existente |
| F16 | Workbench, generador, palés, contenedores y barreras |
| F17–F18 | edificio existente, luz, radio, agua y refugio |
| F20–F22 | mando, luces, red, combustible y espacio operativo |
| F23 | generador, Cargo House y contenedores |
| F24–F25 | Research House/HQ, radar, comunicación y energía |
| F26 | Cargo House, cerca, alambre e iluminación |
| F27 | edificio civil o gubernamental |

<a id="src-technical-3den-module-and-composition-catalog--16-catálogo-defensivo"></a>
#### 16. Catálogo defensivo

| ID | Módulo | Cap. | Coste especial | Personal | Tiempo | Profundidad | Orientación |
|---|---|---:|---|---:|---|---|---|
| D1 | Control vial ligero | 1 | C15 | 4–8 | 2–5 h | P0–P4 | road |
| D2 | Control reforzado | 2 | C45, A10 | 8–16 | 8–16 h | P0–P3 | road |
| D3 | Guarnición | 1 | C25 | 8–14 | 6–12 h | P0–P4 | sitio |
| D4 | Observación | 1 | C15, E5 | 2–5 | 3–6 h | P0–P4 | threat |
| D5 | HMG | 1 | C20, A20 | 2–4 | 4–8 h | P0–P3 | threat |
| D6 | GMG | 1 | C25, A30 | 2–4 | 4–8 h | P0–P3 | threat |
| D7 | AT | 1 | C25, A40 | 3–6 | 5–10 h | P0–P2 | threat |
| D8 | AA ligera | 1 | C25, A50, E10 | 3–6 | 5–10 h | P0–P3 | sitio |
| D9 | Mortero | 2 | C35, A70 | 4–8 | 8–14 h | P1–P3 | sitio |
| D10 | Búnker ligero | 1 | C30 | 4–8 | 8–16 h | P0–P2 | threat |
| D11 | Punto fuerte | 2 | C80, A30 | 10–20 | 1–3 d | P0–P2 | threat |
| D12 | Obstáculo antivehículo | 1 | C25 | 3–6 | 5–12 h | P0–P2 | road/threat |
| D13 | Perímetro | 1 | C20 | 2–5 | 5–10 h | P0–P4 | sitio |
| D14 | Campo minado | 1 | C15, A40 | 4–8 ing. | 6–14 h | P0–P2 | polígono |
| D15 | Refugio endurecido | 2 | C90 | variable | 2–4 d | P0–P3 | sitio |
| D16 | QRF | 2 | C40, F30 | 12–40 | 12–24 h | P1–P3 | salida |
| D17 | Contraataque | 1 | C25 | variable | 8–16 h | P1–P2 | flanco |
| D18 | Defensa costera | 2 | C60, A40 | 8–18 | 1–2 d | costa P0–P2 | coast |
| D19 | Seguridad interior | 1 | C20, E10 | 6–14 | 6–12 h | P1–P4 | sitio |
| D20 | Retirada | 1 | C15, F10 | 2–6 | 4–8 h | P0–P2 | salida |

<a id="src-technical-3den-module-and-composition-catalog--17-reglas-defensivas-específicas"></a>
#### 17. Reglas defensivas específicas

- D1 conserva carril de emergencia, giro y zona de inspección.
- D2 añade HMG/GMG mediante slot independiente.
- D6 exige distancia civil y control de fuego.
- D7 usa tiro lateral u oblicuo; no bloquea la vía que debe batir.
- D8 incluye dispersión y posición alternativa.
- D9 se separa de mando, hospital y depósito principal.
- D14 persiste como polígono, densidad, pasillo, responsable y mapa; las minas no forman parte decorativa de la plantilla.
- D16 conserva salida libre y maniobra de vehículos.
- D19 depende también de legitimidad e inteligencia.
- D20 registra recogida, ruta despejada y demolición condicionada.

<a id="src-technical-3den-module-and-composition-catalog--18-dotación"></a>
#### 18. Dotación

| Staffing | Efecto |
|---:|---|
| 100 % | capacidad completa |
| 60–99 % | operación reducida |
| 25–59 % | función mínima |
| 1–24 % | presencia simbólica |
| 0 % | abandonado |

Una AA sin operador existe y puede capturarse, pero no aporta defensa.

<a id="src-technical-3den-module-and-composition-catalog--19-etiquetas-de-terreno"></a>
#### 19. Etiquetas de terreno

```text
FLAT_OPEN ROAD_EDGE URBAN_DENSE URBAN_OPEN
RURAL_COMPOUND FOREST_EDGE HILL_LOW HILL_HIGH
COAST INDUSTRIAL AIRFIELD EXISTING_BUILDING
```

Solo se producen variantes que tengan función y espacio plausibles.

<a id="src-technical-3den-module-and-composition-catalog--20-pendientes"></a>
#### 20. Pendientes

| Uso | Recomendada | Máxima |
|---|---:|---:|
| Vehículo pesado | 0–5° | 8° |
| Vehículo ligero | 0–8° | 12° |
| Infantería/búnker ligero | 0–12° | 18° validada |

Observación puede superar estos rangos con acceso peatonal y prueba de ocupación.

<a id="src-technical-3den-module-and-composition-catalog--21-anclajes"></a>
#### 21. Anclajes

```text
ANCHOR_COMMAND ANCHOR_COMMS ANCHOR_INTEL ANCHOR_LOGISTICS
ANCHOR_FUEL ANCHOR_REPAIR ANCHOR_MEDICAL ANCHOR_ENGINEERING
ANCHOR_CIVIL ANCHOR_HELIOS

ANCHOR_DEFENSE_PRIMARY ANCHOR_DEFENSE_SECONDARY
ANCHOR_DEFENSE_FLANK_LEFT ANCHOR_DEFENSE_FLANK_RIGHT
ANCHOR_DEFENSE_INTERIOR ANCHOR_RESERVE ANCHOR_WITHDRAWAL
ANCHOR_COAST

ANCHOR_AIRCRAFT ANCHOR_HELICOPTER ANCHOR_BOAT
ANCHOR_HEAVY_VEHICLE ANCHOR_ARTILLERY
```

<a id="src-technical-3den-module-and-composition-catalog--22-puntos-internos"></a>
#### 22. Puntos internos

```text
POINT_ENTRY POINT_EXIT POINT_GUARD_01 POINT_GUARD_02
POINT_WEAPON_01 POINT_WEAPON_02 POINT_AMMO POINT_INTERACTION
POINT_VEHICLE_01 POINT_COVER POINT_MEDICAL POINT_COMMAND
```

Pueden ser lógicas o posiciones relativas; no tienen que ser visibles.

<a id="src-technical-3den-module-and-composition-catalog--23-circulación"></a>
#### 23. Circulación

| Usuario | Mínimo | Recomendado |
|---|---:|---:|
| Infantería | 1,2 m | 1,8 m |
| Vehículo ligero | 3,5 m | 4,5 m |
| Camión/blindado | 5,5 m | 7 m |

Un pesado necesita giro o salida independiente. Ninguna composición depende de retroceder por un callejón estrecho.

<a id="src-technical-3den-module-and-composition-catalog--24-presupuesto-de-objetos"></a>
#### 24. Presupuesto de objetos

| Escala | Objetos | Ejemplos |
|---|---:|---|
| Micro | 6–15 | observación, caché, HMG |
| Pequeña | 16–35 | control, médico, AT |
| Media | 36–70 | guarnición, punto fuerte, taller |
| Grande | 71–120 | mando regional, hospital, depósito |
| Estratégica | 121–220 | aeropuerto, Helios y gran base |

Una estratégica se divide en subcomposiciones materializables.

<a id="src-technical-3den-module-and-composition-catalog--25-simulación-y-objetos-simples"></a>
#### 25. Simulación y objetos simples

Conservan simulación: armas, cajas usadas, puertas, luces, generadores interactivos, objetos destructibles, inventarios y vehículos.

Pueden ser simples: decoración, palés, cajas vacías, sacos sin función, mobiliario, señales y restos.

Nada se simplifica si debe dañarse, abrirse, moverse, animarse o guardar inventario.

<a id="src-technical-3den-module-and-composition-catalog--26-daño"></a>
#### 26. Daño

| Estado | Condición | Representación |
|---|---:|---|
| `INTACT` | 90–100 % | completo |
| `DAMAGED` | 40–89 % | secundarios omitidos, barreras y armas parciales |
| `CRITICAL` | 1–39 % | función mínima, restos y abandono probable |
| `DESTROYED` | 0 % | ruina, función anulada y salvamento |

`badChance` solo puede omitir decoración, palés, sacos secundarios, redes y mobiliario. Nunca elimina edificio, arma, acceso, ruta, generador o interacción esencial.

<a id="src-technical-3den-module-and-composition-catalog--27-esquema-de-composición"></a>
#### 27. Esquema de composición

```sqf
IF_COMP_D_AT_BLUE_T1_ROAD_A = createHashMapFromArray [
    ["id", "IF_COMP_D_AT_BLUE_T1_ROAD_A"],
    ["moduleType", "DEFENSE_AT"],
    ["factionProfile", "BLUE"],
    ["tier", 1],
    ["terrainTags", ["ROAD_EDGE", "FLAT_OPEN"]],
    ["frontDepthAllowed", ["P0", "P1", "P2"]],
    ["orientationMode", "FACE_THREAT"],
    ["capacityCost", 1],
    ["constructionCost", 25],
    ["electronicsCost", 0],
    ["ammoCost", 40],
    ["fuelCost", 0],
    ["medicalCost", 0],
    ["staffRequired", 4],
    ["buildHours", 8],
    ["minimumRadius", 14],
    ["maximumSlope", 8],
    ["roadClearance", 5],
    ["civilianClearance", 60],
    ["staticWeaponSlots", 1],
    ["vehicleSlots", 0],
    ["infantrySlots", 6],
    ["objectsData", []],
    ["essentialObjectIndexes", []],
    ["simpleObjectIndexes", []],
    ["interactionPoints", []],
    ["entryPoints", []],
    ["exitPoints", []],
    ["validationState", "DRAFT"],
    ["requiredAddons", []],
    ["optionalAddons", []],
    ["fallbackCompositionId", ""]
];
```

<a id="src-technical-3den-module-and-composition-catalog--28-nomenclatura-y-capas"></a>
#### 28. Nomenclatura y capas

```text
IF_COMP_{CATEGORY}_{MODULE}_{FACTION}_{TIER}_{TERRAIN}_{VARIANT}
```

Categorías: `F`, `D`, `S`, `C`, `H`.

```text
IF_COMP_ROOT
├── FUNCTIONAL
├── DEFENSIVE
├── CIVIL
├── HELIOS
├── BLUE
├── RED
├── GREEN
├── FIA
└── MERIDIAN
```

Cada composición ocupa su propia capa.

<a id="src-technical-3den-module-and-composition-catalog--29-estados-de-validación"></a>
#### 29. Estados de validación

```text
DRAFT PLACEMENT_OK PATHING_OK WEAPON_ARCS_OK COMBAT_OK
DAMAGE_OK MATERIALIZATION_OK PERSISTENCE_OK PERFORMANCE_OK RELEASED
```

Solo `RELEASED` puede seleccionarse en una campaña publicada.

<a id="src-technical-3den-module-and-composition-catalog--30-pruebas-de-ia-y-combate"></a>
#### 30. Pruebas de IA y combate

Infantería debe entrar, salir, ocupar, usar armas, responder y retirarse.

Vehículos deben entrar, estacionar, girar, salir y alcanzar la ruta. La QRF no queda atrapada ni atropella sistemáticamente a la guarnición.

Cada defensa se prueba contra infantería frontal, flanco, ligero, blindado, fuego indirecto, noche y retirada. No necesita ganar; necesita comportarse coherentemente.

<a id="src-technical-3den-module-and-composition-catalog--31-pruebas-urbanas-y-frente-móvil"></a>
#### 31. Pruebas urbanas y frente móvil

Se validan tráfico, puertas, ventanas, peatones, civiles, líneas de fuego, daño, medicina y evacuación. No se bloquea una ciudad por estética.

Una composición puede quedar detrás del frente, reducir guarnición, cambiar función, evacuarse, capturarse o destruirse. Un AT puede convertirse en observación, seguridad, caché o abandono.

<a id="src-technical-3den-module-and-composition-catalog--32-conversión-de-facción"></a>
#### 32. Conversión de facción

Una captura intacta conserva estructuras y barreras, pero cambia armas, cajas, señalización, personal y comunicaciones.

- conversión rápida: control, HMG, caché y puesto;
- lenta: mando, taller, inteligencia, Helios y aviación;
- con especialista: radar, cifrado, mantenimiento aéreo y nodo Helios.

<a id="src-technical-3den-module-and-composition-catalog--33-fia"></a>
#### 33. FIA

| Composición | Objetos | Regla |
|---|---:|---|
| Escondite rural | 8–18 | sin bandera, salida secundaria |
| Depósito clandestino | 6–15 | edificio y materiales civiles |
| Clínica clandestina | edificio existente | 2–6 sanitarios, sin defensa pesada |
| Puesto abierto | variable | solo con control territorial |

Una red FIA no parece una FOB NATO camuflada.

<a id="src-technical-3den-module-and-composition-catalog--34-meridian"></a>
#### 34. Meridian

- acceso externo con apariencia Verde o militar convencional;
- anillo de sensores, controles y barreras;
- PHAROS con detención, archivo, técnicos y comunicaciones;
- HELIOS-CORE sobre infraestructura canónica;
- evacuación Argos con helipuerto, vehículos, rutas y destrucción de archivos.

<a id="src-technical-3den-module-and-composition-catalog--35-biblioteca-mínima"></a>
#### 35. Biblioteca mínima

<a id="src-technical-3den-module-and-composition-catalog--azul-1"></a>
##### Azul

1. mando ligero;
2. control ligero;
3. control reforzado;
4. HMG;
5. AT;
6. observación;
7. médico;
8. caché;
9. reparación;
10. distribución de playa;
11. QRF;
12. guarnición de pueblo.

<a id="src-technical-3den-module-and-composition-catalog--verde-1"></a>
##### Verde

13. mando;
14. control;
15. HMG;
16. GMG;
17. AT;
18. mortero;
19. observación;
20. guarnición;
21. punto fuerte;
22. depósito;
23. mando FOB;
24. defensa de aeródromo.

La segunda biblioteca añade Rojo, FIA, ciudades, puertos, aeródromos completos, Helios, Stratis y fortificación 4.

<a id="src-technical-3den-module-and-composition-catalog--36-compatibilidad-y-clases"></a>
#### 36. Compatibilidad y clases

El perfil principal declara solo dependencias del juego base. Un perfil opcional:

- se detecta;
- posee sustituto;
- no invalida guardados;
- no cambia función estratégica.

Validación:

```sqf
isClass (configFile >> "CfgVehicles" >> _className)
```

Estados:

```text
CLASS_CONFIRMED CLASS_MISSING CLASS_DLC
CLASS_PROTECTED CLASS_REPLACED
```

Una clase ausente activa sustituto o cancela toda la composición; nunca deja una plantilla parcialmente funcional.

<a id="src-technical-3den-module-and-composition-catalog--37-funciones-conceptuales"></a>
#### 37. Funciones conceptuales

```text
IF_fnc_compositionRegister
IF_fnc_compositionValidateConfig
IF_fnc_compositionSelect
IF_fnc_compositionValidateTerrain
IF_fnc_compositionSpawn
IF_fnc_compositionRegisterObjects
IF_fnc_compositionApplyDamageState
IF_fnc_compositionAssignCrew
IF_fnc_compositionCapture
IF_fnc_compositionConvertFaction
IF_fnc_compositionDespawn
IF_fnc_compositionBuildSnapshot
IF_fnc_compositionRestoreSnapshot
```

<a id="src-technical-3den-module-and-composition-catalog--38-selección"></a>
#### 38. Selección

1. leer módulo, facción y tier;
2. leer terreno, profundidad y orientación;
3. filtrar dependencias y validación;
4. comprobar espacio;
5. puntuar variantes;
6. elegir;
7. materializar.

```text
score =
    terrainMatch + factionMatch + frontMatch + threatMatch
  + anchorMatch + performancePreference
  - collisionRisk - pathingRisk - civilianImpact
```

<a id="src-technical-3den-module-and-composition-catalog--39-explicabilidad"></a>
#### 39. Explicabilidad

El registro conserva composición elegida, razones positivas y alternativas rechazadas:

```text
selected: IF_COMP_D_AT_BLUE_T1_ROAD_A
+ armored threat high
+ east connection primary
+ flat road-edge terrain
+ P0 allows AT
+ capacity and Titan ammo available
- urban variant incompatible
- hill variant incompatible
- T2 variant lacks resources
```

<a id="src-technical-3den-module-and-composition-catalog--40-fuentes-técnicas-oficiales"></a>
#### 40. Fuentes técnicas oficiales

- [BIS_fnc_objectsMapper](https://community.bohemia.net/wiki/BIS_fnc_objectsMapper)
- [BIS_fnc_objectsGrabber](https://community.bohemia.net/wiki/BIS_fnc_objectsGrabber)
- [setVectorDirAndUp](https://community.bohemia.net/wiki/setVectorDirAndUp)
- [Eden Editor: Custom Composition](https://community.bohemia.net/wiki/Eden_Editor%3A_Custom_Composition)
- [CfgVehicles Structures](https://community.bohemia.net/wiki/Arma_3%3A_CfgVehicles_Structures)
- [CfgVehicles Equipment](https://community.bohemia.net/wiki/Arma_3_CfgVehicles_Equipment)

<a id="src-technical-3den-module-and-composition-catalog--41-principios-vinculantes"></a>
#### 41. Principios vinculantes

1. Cada módulo tiene función e ID estable.
2. Toda clase se valida en `CfgVehicles`.
3. El perfil principal no requiere DLC.
4. Toda composición nace y se prueba en 3DEN.
5. Orientación, carreteras, campos de tiro y salida son obligatorios.
6. Los módulos pesados se dividen.
7. Decoración puede simplificarse; interacción conserva simulación.
8. El daño no elimina elementos esenciales al azar.
9. Captura no concede operación automática.
10. FIA usa arquitectura clandestina y Meridian mezcla proveedores.
11. Helios solo aparece donde el canon lo permite.
12. Hospitales se separan de munición y combustible.
13. Construcción y operación requieren personal.
14. Desmaterializar elimina objetos, no el módulo.
15. La biblioteca solo crece después de validar la anterior.

<a id="src-technical-3den-module-and-composition-catalog--42-definición-final"></a>
#### 42. Definición final

La estrategia selecciona la necesidad. El sistema territorial decide si está permitida y financiada. El catálogo ofrece una solución visual validada. El terreno decide qué variante puede existir.

Una fortificación es buena cuando la guarnición puede ocuparla, disparar, recibir suministros, retirarse y recuperarla después de cargar la campaña.

<a id="src-technical-3den-module-and-composition-catalog--43-siguiente-contrato"></a>
#### 43. Siguiente contrato

El sistema económico y logístico rector queda definido en [ECONOMIC_AND_LOGISTICS_SYSTEM.md](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md#fuente-economic-and-logistics-system). El siguiente paso es la arquitectura de implementación y pruebas del vertical slice integrado.

---

<a id="fuente-threeden-geography-and-physical-validation-guide"></a>
## Fuente integrada: `THREEDEN_GEOGRAPHY_AND_PHYSICAL_VALIDATION_GUIDE.md`

> **Procedencia:** contenido migrado de `THREEDEN_GEOGRAPHY_AND_PHYSICAL_VALIDATION_GUIDE.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-threeden-geography-and-physical-validation-guide--islas-fracturadas"></a>
### ISLAS FRACTURADAS

<a id="src-threeden-geography-and-physical-validation-guide--documento-1114-guía-definitiva-de-3den-y-validación-geográfica"></a>
#### Documento 11/14 — Guía definitiva de 3DEN y validación geográfica

**Versión:** 1.0
**Clasificación:** documento rector de edición, geografía, anclajes y validación física
**Terrenos principales:** Altis y Stratis
**Editor:** Editor 3DEN
**Lenguaje de integración:** SQF
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando
**Estado:** canon de producción previo a implementación física

> **Jerarquía documental:** este Documento 11/14 gobierna el trabajo físico en 3DEN, capas, límites, rutas, anclajes, zonas, puntos de materialización, registro, pruebas geográficas y criterios de aprobación. [ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md](10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md#fuente-altis-geography-and-sector-map) conserva los IDs, regiones y funciones estratégicas; [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-technical-3den-module-and-composition-catalog), las composiciones y sus presupuestos; [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture), el bootstrap, los registros y contratos SQF; [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system), la semántica de materialización, reintegración y localidad; [MASTER_TESTING_PERFORMANCE_AND_BALANCE_SYSTEM.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system), las suites, métricas y puertas finales de calidad; y [MASTER_IMPLEMENTATION_AND_PRODUCTION_PLAN.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan), la secuencia y alcance del trabajo físico.

---

<a id="src-threeden-geography-and-physical-validation-guide--1-propósito"></a>
### 1. Propósito

Este documento define cómo convertir el diseño estratégico de Islas Fracturadas en una misión físicamente válida dentro de Altis y Stratis.

Establece:

* qué debe colocarse manualmente en 3DEN;
* qué debe generarse mediante SQF;
* cómo organizar capas;
* cómo identificar objetos;
* cómo delimitar sectores;
* cómo establecer anclajes;
* cómo validar rutas;
* cómo localizar posiciones de construcción;
* cómo crear puntos de materialización;
* cómo representar zonas civiles;
* cómo registrar nodos Helios;
* cómo preparar puertos, aeropuertos y cabezas de playa;
* cómo probar navegación de IA;
* cómo comprobar rendimiento;
* cómo documentar cada sector;
* cómo evitar duplicar lógica entre 3DEN y código.

<a id="src-threeden-geography-and-physical-validation-guide--principio-central"></a>
#### Principio central

> 3DEN define la realidad física estable del escenario.

> SQF interpreta esa realidad, genera sus estados variables y controla su evolución.

3DEN no deberá convertirse en una base de datos estratégica improvisada.

SQF no deberá intentar adivinar toda la geografía sin anclajes previamente validados.

---

<a id="src-threeden-geography-and-physical-validation-guide--2-estado-actual-de-la-geografía"></a>
### 2. Estado actual de la geografía

La campaña ya dispone de:

* regiones narrativas;
* 38 sectores estratégicos de Altis;
* sectores de vertical slice;
* tipos de sector;
* conexiones conceptuales;
* cabezas de playa Azul y Roja;
* funciones logísticas;
* nodos Helios;
* roles regionales;
* necesidades de construcción.

Todavía falta cerrar físicamente dentro del editor:

* coordenadas exactas;
* límites reales;
* radios;
* alturas;
* carreteras utilizables;
* accesos;
* espacios de construcción;
* posiciones defensivas;
* rutas de convoy;
* puntos de aparición;
* zonas de exclusión;
* ubicación exacta de nodos Helios;
* compatibilidad con IA.

<a id="src-threeden-geography-and-physical-validation-guide--regla"></a>
#### Regla

No se inventarán coordenadas definitivas sobre el papel.

Cada coordenada deberá:

1. seleccionarse en 3DEN;
2. inspeccionarse visualmente;
3. probarse con IA;
4. registrarse;
5. validarse en partida.

---

<a id="src-threeden-geography-and-physical-validation-guide--3-fuentes-de-verdad-geográfica"></a>
### 3. Fuentes de verdad geográfica

Se utilizarán tres fuentes coordinadas.

<a id="src-threeden-geography-and-physical-validation-guide--31-missionsqm"></a>
#### 3.1 `mission.sqm`

Fuente de verdad física para:

* objetos colocados;
* anclajes;
* entidades iniciales;
* capas;
* posiciones narrativas;
* marcadores de desarrollo.

<a id="src-threeden-geography-and-physical-validation-guide--32-configuración-sectorial"></a>
#### 3.2 Configuración sectorial

Fuente de verdad estratégica para:

* IDs;
* tipos;
* conexiones;
* capacidades;
* regiones;
* etiquetas;
* reglas.

<a id="src-threeden-geography-and-physical-validation-guide--33-estado-persistente"></a>
#### 3.3 Estado persistente

Fuente de verdad variable para:

* propietario;
* nivel;
* daño;
* módulos;
* estabilidad;
* fuerzas;
* recursos.

<a id="src-threeden-geography-and-physical-validation-guide--regla-1"></a>
#### Regla

Una coordenada estable puede originarse en 3DEN y copiarse a configuración durante la fase de cierre.

El propietario de un sector nunca deberá quedar fijado permanentemente mediante un trigger 3DEN.

---

<a id="src-threeden-geography-and-physical-validation-guide--4-qué-se-coloca-manualmente"></a>
### 4. Qué se coloca manualmente

Debe colocarse manualmente cuando:

* la posición necesita validación humana;
* el terreno condiciona fuertemente el resultado;
* el elemento es narrativo o único;
* un error de colocación rompería pathfinding;
* debe integrarse con edificios existentes;
* necesita composición visual precisa.

<a id="src-threeden-geography-and-physical-validation-guide--elementos-manuales"></a>
#### Elementos manuales

1. Anclaje central de cada sector.
2. Anclajes secundarios.
3. Centros municipales.
4. Puntos logísticos principales.
5. Anclajes de módulos especiales.
6. Posiciones de nodos Helios.
7. Puntos de desembarco.
8. Puntos de reunión.
9. Rutas de entrada y salida críticas.
10. Objetos narrativos.
11. Personajes iniciales.
12. Escenarios de prueba.
13. Edificios preexistentes ligados a módulos.
14. Puntos de cámara y cinemática cuando sean únicos.
15. Zonas que deban excluir construcción.

---

<a id="src-threeden-geography-and-physical-validation-guide--5-qué-genera-sqf"></a>
### 5. Qué genera SQF

Debe generarse dinámicamente cuando:

* cambia con la campaña;
* depende del propietario;
* depende del nivel;
* puede destruirse o reconstruirse;
* forma parte de una proyección táctica;
* necesita variantes;
* no debe permanecer siempre materializado.

<a id="src-threeden-geography-and-physical-validation-guide--elementos-generados"></a>
#### Elementos generados

1. Guarniciones.
2. Patrullas.
3. Convoyes.
4. QRF.
5. Refuerzos.
6. Fortificaciones automáticas.
7. Módulos funcionales.
8. Puestos defensivos.
9. Armas estáticas.
10. Civiles ambientales.
11. Vehículos temporales.
12. Eventos emergentes.
13. Elementos de misión.
14. Señales de daño.
15. Campamentos temporales.
16. Controles de carretera variables.

---

<a id="src-threeden-geography-and-physical-validation-guide--6-elementos-híbridos"></a>
### 6. Elementos híbridos

Algunos sistemas usarán anclajes manuales y contenido dinámico.

<a id="src-threeden-geography-and-physical-validation-guide--ejemplo-hospital"></a>
#### Ejemplo: hospital

Manual:

* edificio;
* entrada;
* punto de pacientes;
* generador;
* zona médica.

Dinámico:

* personal;
* heridos;
* suministros;
* seguridad;
* estado funcional;
* equipo de campaña.

<a id="src-threeden-geography-and-physical-validation-guide--ejemplo-nodo-helios"></a>
#### Ejemplo: nodo Helios

Manual:

* instalación;
* terminal;
* antena;
* entrada;
* sala técnica.

Dinámico:

* acceso;
* integridad;
* operadores;
* efectos;
* defensa;
* evidencia.

---

<a id="src-threeden-geography-and-physical-validation-guide--7-organización-general-de-capas-3den"></a>
### 7. Organización general de capas 3DEN

```text
IF_00_WORLD_REFERENCE
IF_01_SECTOR_ANCHORS
IF_02_SECTOR_BOUNDS
IF_03_CONNECTIONS
IF_04_ROADS_AND_ROUTES
IF_05_MODULE_ANCHORS
IF_06_CIVILIAN_ZONES
IF_07_LOGISTICS
IF_08_HELIOS
IF_09_NARRATIVE
IF_10_INITIAL_FORCES
IF_11_COMPOSITIONS
IF_12_SPAWN_POINTS
IF_13_CAMERAS
IF_90_TESTING
IF_99_DISABLED_ARCHIVE
```

---

<a id="src-threeden-geography-and-physical-validation-guide--8-capa-if00worldreference"></a>
### 8. Capa `IF_00_WORLD_REFERENCE`

Contiene elementos solo para orientación durante desarrollo:

* textos;
* marcadores regionales;
* flechas;
* notas;
* referencias visuales.

<a id="src-threeden-geography-and-physical-validation-guide--regla-2"></a>
#### Regla

No debe contener lógica esencial.

Puede desactivarse en versión final.

---

<a id="src-threeden-geography-and-physical-validation-guide--9-capa-if01sectoranchors"></a>
### 9. Capa `IF_01_SECTOR_ANCHORS`

Contiene el anclaje principal de cada sector.

<a id="src-threeden-geography-and-physical-validation-guide--convención"></a>
#### Convención

```text
IF_ANCHOR_{SECTOR_ID}_CENTER
```

Ejemplo:

```text
IF_ANCHOR_ALT_CW_NEOCHORI_CENTER
```

<a id="src-threeden-geography-and-physical-validation-guide--funciones"></a>
#### Funciones

* centro estratégico;
* referencia de materialización;
* cálculo de distancias;
* UI;
* punto inicial de búsqueda.

---

<a id="src-threeden-geography-and-physical-validation-guide--10-capa-if02sectorbounds"></a>
### 10. Capa `IF_02_SECTOR_BOUNDS`

Contiene referencias visuales de límites durante desarrollo.

Los límites definitivos podrán representarse mediante:

* marcadores;
* áreas elípticas;
* áreas rectangulares;
* polígonos configurados;
* combinaciones.

<a id="src-threeden-geography-and-physical-validation-guide--regla-3"></a>
#### Regla

Los límites deben seguir:

* relieve;
* carreteras;
* ríos secos;
* costa;
* núcleos urbanos;
* barreras naturales.

No deberán dividir arbitrariamente una misma localidad funcional.

---

<a id="src-threeden-geography-and-physical-validation-guide--11-sectores-con-límites-simples"></a>
### 11. Sectores con límites simples

Podrán usar un radio o elipse cuando:

* son pequeños;
* poseen núcleo claro;
* tienen terreno homogéneo.

Ejemplos posibles:

* una instalación militar;
* un aeródromo menor;
* un nodo de montaña;
* una aldea aislada.

---

<a id="src-threeden-geography-and-physical-validation-guide--12-sectores-con-límites-compuestos"></a>
### 12. Sectores con límites compuestos

Necesitarán polígonos o subzonas cuando:

* abarcan ciudad y puerto;
* siguen un corredor;
* contienen varios núcleos;
* poseen forma costera irregular;
* tienen áreas funcionales separadas.

Ejemplos:

* Kavala;
* Aeropuerto Internacional;
* Pyrgos;
* Xirolimni–Zaros;
* corredores viales.

---

<a id="src-threeden-geography-and-physical-validation-guide--13-capa-if03connections"></a>
### 13. Capa `IF_03_CONNECTIONS`

Representa las conexiones estratégicas propuestas.

<a id="src-threeden-geography-and-physical-validation-guide--convención-1"></a>
#### Convención

```text
IF_LINK_{SECTOR_A}_{SECTOR_B}
```

<a id="src-threeden-geography-and-physical-validation-guide--representación-en-desarrollo"></a>
#### Representación en desarrollo

Puede utilizar:

* líneas;
* flechas;
* marcadores;
* objetos simples no visibles.

<a id="src-threeden-geography-and-physical-validation-guide--configuración-final"></a>
#### Configuración final

Cada conexión tendrá:

```text
connectionId
fromSector
toSector
connectionType
distance
roadQuality
capacity
terrainRisk
chokepoints
bridgeDependency
```

---

<a id="src-threeden-geography-and-physical-validation-guide--14-tipos-de-conexión"></a>
### 14. Tipos de conexión

```text
PRIMARY_ROAD
SECONDARY_ROAD
RURAL_TRACK
URBAN_CORRIDOR
COASTAL_ROUTE
MOUNTAIN_ROUTE
AIR_CONNECTION
SEA_CONNECTION
CLANDESTINE_ROUTE
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-4"></a>
#### Regla

Una conexión estratégica no significa que solo exista una carretera física.

Representa una vía operacional viable entre sectores.

---

<a id="src-threeden-geography-and-physical-validation-guide--15-conexiones-bidireccionales-y-direccionales"></a>
### 15. Conexiones bidireccionales y direccionales

<a id="src-threeden-geography-and-physical-validation-guide--bidireccionales"></a>
#### Bidireccionales

La mayoría de carreteras y rutas terrestres.

<a id="src-threeden-geography-and-physical-validation-guide--direccionales-o-condicionadas"></a>
#### Direccionales o condicionadas

* desembarco;
* caída de pendiente;
* acceso aéreo;
* ruta clandestina;
* corredor controlado;
* salida naval.

---

<a id="src-threeden-geography-and-physical-validation-guide--16-capa-if04roadsandroutes"></a>
### 16. Capa `IF_04_ROADS_AND_ROUTES`

Contiene anclajes de rutas probadas.

<a id="src-threeden-geography-and-physical-validation-guide--tipos-de-anclaje"></a>
#### Tipos de anclaje

```text
ROUTE_ENTRY
ROUTE_EXIT
ROUTE_CHECKPOINT
ROUTE_AMBUSH
ROUTE_HOLDING
ROUTE_DIVERSION
ROUTE_CONVOY_STAGING
```

<a id="src-threeden-geography-and-physical-validation-guide--convención-2"></a>
#### Convención

```text
IF_ROUTE_{ROUTE_ID}_{TYPE}_{NUMBER}
```

---

<a id="src-threeden-geography-and-physical-validation-guide--17-validación-de-rutas"></a>
### 17. Validación de rutas

Cada ruta deberá probarse con:

* vehículo ligero;
* camión;
* blindado;
* convoy de varios vehículos;
* IA en ambos sentidos;
* tráfico civil limitado.

<a id="src-threeden-geography-and-physical-validation-guide--registrar"></a>
#### Registrar

* tiempo;
* bloqueos;
* puentes;
* giros;
* pendientes;
* zonas de atasco;
* riesgo de vuelco;
* capacidad de dispersión.

---

<a id="src-threeden-geography-and-physical-validation-guide--18-rutas-de-convoy"></a>
### 18. Rutas de convoy

Una ruta apta para patrulla no es necesariamente apta para convoy.

Debe permitir:

* separación;
* reagrupación;
* detención;
* giro;
* desvío;
* extracción.

<a id="src-threeden-geography-and-physical-validation-guide--puntos-obligatorios"></a>
#### Puntos obligatorios

* origen;
* zona de formación;
* salida;
* uno o más puntos de control;
* destino;
* zona de descarga.

---

<a id="src-threeden-geography-and-physical-validation-guide--19-cuellos-de-botella"></a>
### 19. Cuellos de botella

Cada cuello de botella deberá registrarse.

Ejemplos:

* puente;
* calle estrecha;
* curva;
* paso montañoso;
* entrada urbana;
* carretera costera.

<a id="src-threeden-geography-and-physical-validation-guide--datos"></a>
#### Datos

```text
chokepointId
routeId
position
width
vehicleLimit
bypassPossible
ambushRisk
destructionEffect
```

---

<a id="src-threeden-geography-and-physical-validation-guide--20-puentes"></a>
### 20. Puentes

Los puentes relevantes deberán:

1. identificarse;
2. probarse;
3. asociarse a conexiones;
4. tener ruta alternativa;
5. registrar efecto de destrucción.

<a id="src-threeden-geography-and-physical-validation-guide--regla-5"></a>
#### Regla

No se diseñará una conexión estratégica dependiente de un puente sin definir qué ocurre cuando queda inutilizable.

---

<a id="src-threeden-geography-and-physical-validation-guide--21-capa-if05moduleanchors"></a>
### 21. Capa `IF_05_MODULE_ANCHORS`

Contiene ubicaciones validadas para módulos.

<a id="src-threeden-geography-and-physical-validation-guide--categorías"></a>
#### Categorías

```text
COMMAND
LOGISTICS
MEDICAL
REPAIR
FUEL
AMMO
DEFENSE
ARTILLERY
AA
AT
INTELLIGENCE
CIVIL_SUPPORT
TRAINING
```

<a id="src-threeden-geography-and-physical-validation-guide--convención-3"></a>
#### Convención

```text
IF_MODANCHOR_{SECTOR_ID}_{CATEGORY}_{NUMBER}
```

---

<a id="src-threeden-geography-and-physical-validation-guide--22-anclajes-y-composiciones"></a>
### 22. Anclajes y composiciones

Un anclaje no contiene toda la composición.

Define:

* posición;
* orientación;
* terreno;
* capacidad;
* restricciones.

La composición se selecciona según:

* propietario;
* nivel;
* terreno;
* amenaza;
* variante.

---

<a id="src-threeden-geography-and-physical-validation-guide--23-datos-de-anclaje"></a>
### 23. Datos de anclaje

```text
anchorId
sectorId
positionASL
direction
terrainTags
allowedModuleTags
maxTier
clearanceRadius
roadAccess
slope
threatOrientationMode
exclusionTags
```

---

<a id="src-threeden-geography-and-physical-validation-guide--24-etiquetas-de-terreno"></a>
### 24. Etiquetas de terreno

```text
FLAT_OPEN
ROAD_EDGE
URBAN_DENSE
URBAN_OPEN
RURAL_COMPOUND
FOREST_EDGE
HILL_LOW
HILL_HIGH
COAST
INDUSTRIAL
AIRFIELD
EXISTING_BUILDING
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-6"></a>
#### Regla

Las etiquetas se asignan después de inspección y prueba.

---

<a id="src-threeden-geography-and-physical-validation-guide--25-orientación-de-módulos"></a>
### 25. Orientación de módulos

Modos:

```text
FACE_THREAT
ALIGN_ROAD
ALIGN_COAST
ALIGN_RUNWAY
ALIGN_BUILDING
FIXED_SITE
```

<a id="src-threeden-geography-and-physical-validation-guide--ejemplo"></a>
#### Ejemplo

Un puesto defensivo puede orientarse hacia el principal sector enemigo.

Un taller deberá alinearse con una ruta de vehículos.

---

<a id="src-threeden-geography-and-physical-validation-guide--26-zonas-de-exclusión"></a>
### 26. Zonas de exclusión

Evitan generar composiciones en:

* carreteras;
* entradas;
* pistas;
* zonas civiles críticas;
* edificios narrativos;
* posiciones de cámara;
* rutas de IA;
* áreas de aparición.

<a id="src-threeden-geography-and-physical-validation-guide--convención-4"></a>
#### Convención

```text
IF_EXCLUSION_{SECTOR_ID}_{TYPE}_{NUMBER}
```

---

<a id="src-threeden-geography-and-physical-validation-guide--27-validación-de-composición"></a>
### 27. Validación de composición

Cada anclaje deberá probar:

1. Superficie.
2. Pendiente.
3. Colisiones.
4. Entradas.
5. Camino de IA.
6. Orientación.
7. Línea de tiro.
8. Acceso logístico.
9. Compatibilidad con destrucción.
10. Presupuesto de objetos.

---

<a id="src-threeden-geography-and-physical-validation-guide--28-capa-if06civilianzones"></a>
### 28. Capa `IF_06_CIVILIAN_ZONES`

Contiene zonas civiles persistentes o generativas.

<a id="src-threeden-geography-and-physical-validation-guide--tipos"></a>
#### Tipos

```text
RESIDENTIAL
MARKET
HOSPITAL
SCHOOL
MUNICIPAL
RELIGIOUS
INDUSTRIAL_WORKERS
FARM
REFUGEE_SHELTER
PUBLIC_SQUARE
```

<a id="src-threeden-geography-and-physical-validation-guide--convención-5"></a>
#### Convención

```text
IF_CIVZONE_{SECTOR_ID}_{TYPE}_{NUMBER}
```

---

<a id="src-threeden-geography-and-physical-validation-guide--29-zonas-residenciales"></a>
### 29. Zonas residenciales

No requieren marcar cada casa.

Se definen áreas donde pueden generarse:

* residentes;
* conversaciones;
* refugio;
* desplazamiento;
* eventos.

---

<a id="src-threeden-geography-and-physical-validation-guide--30-zonas-sensibles"></a>
### 30. Zonas sensibles

Deben identificarse manualmente:

* hospitales;
* escuelas;
* iglesias;
* cementerios;
* plazas;
* edificios municipales.

<a id="src-threeden-geography-and-physical-validation-guide--función"></a>
#### Función

* cálculo de riesgo civil;
* objetivos;
* memoria;
* restricciones de artillería;
* protestas.

---

<a id="src-threeden-geography-and-physical-validation-guide--31-centros-municipales"></a>
### 31. Centros municipales

Cada municipio requiere:

```text
municipalAnchor
meetingPoint
administrativeBuilding
publicSquare
civilianAccess
securityAccess
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-7"></a>
#### Regla

El centro municipal debe ser físicamente defendible, accesible y creíble.

---

<a id="src-threeden-geography-and-physical-validation-guide--32-zonas-de-desplazados"></a>
### 32. Zonas de desplazados

Se validarán posibles ubicaciones:

* escuela;
* iglesia;
* almacén;
* explanada;
* campamento.

No estarán activas permanentemente.

Se materializan cuando existe desplazamiento.

---

<a id="src-threeden-geography-and-physical-validation-guide--33-capa-if07logistics"></a>
### 33. Capa `IF_07_LOGISTICS`

Contiene anclajes para:

* depósitos;
* carga;
* descarga;
* reparación;
* combustible;
* convoyes;
* puertos;
* aeropuertos.

<a id="src-threeden-geography-and-physical-validation-guide--convención-6"></a>
#### Convención

```text
IF_LOG_{SECTOR_ID}_{FUNCTION}_{NUMBER}
```

---

<a id="src-threeden-geography-and-physical-validation-guide--34-centros-logísticos"></a>
### 34. Centros logísticos

Cada centro debe tener:

* acceso de carretera;
* espacio de maniobra;
* entrada;
* salida;
* carga;
* seguridad;
* almacenamiento;
* zona de materialización.

---

<a id="src-threeden-geography-and-physical-validation-guide--35-zonas-de-carga-y-descarga"></a>
### 35. Zonas de carga y descarga

Deben permitir:

* varios vehículos;
* IA estacionando;
* salida sin bloqueo;
* interacción del jugador.

<a id="src-threeden-geography-and-physical-validation-guide--regla-8"></a>
#### Regla

No utilizar un único punto exacto donde todos los vehículos intenten detenerse.

---

<a id="src-threeden-geography-and-physical-validation-guide--36-depósitos"></a>
### 36. Depósitos

Pueden usar:

* edificio existente;
* patio;
* composición;
* instalación militar.

<a id="src-threeden-geography-and-physical-validation-guide--estados-físicos"></a>
#### Estados físicos

* intacto;
* dañado;
* saqueado;
* incendiado;
* capturado.

---

<a id="src-threeden-geography-and-physical-validation-guide--37-puertos"></a>
### 37. Puertos

Los puertos principales deberán tener anclajes para:

```text
SEA_ENTRY
SEA_EXIT
BERTH
UNLOAD
PORT_COMMAND
FUEL
STORAGE
SECURITY
WORKERS
```

<a id="src-threeden-geography-and-physical-validation-guide--puertos-prioritarios"></a>
#### Puertos prioritarios

* Kavala.
* Molos.
* Pyrgos.
* zonas costeras de desembarco.
* Stratis.

---

<a id="src-threeden-geography-and-physical-validation-guide--38-validación-portuaria"></a>
### 38. Validación portuaria

Probar:

* aproximación de embarcación;
* desembarco;
* profundidad;
* colisión;
* acceso terrestre;
* carga;
* salida;
* defensa;
* bloqueos.

---

<a id="src-threeden-geography-and-physical-validation-guide--39-aeropuertos-y-aeródromos"></a>
### 39. Aeropuertos y aeródromos

Anclajes:

```text
RUNWAY_ENTRY
RUNWAY_EXIT
PARKING
HELICOPTER_PAD
AIR_COMMAND
FUEL
MAINTENANCE
AA_DEFENSE
EMERGENCY_LANDING
```

<a id="src-threeden-geography-and-physical-validation-guide--instalaciones-prioritarias"></a>
#### Instalaciones prioritarias

* Aeropuerto Internacional de Altis.
* AAC.
* Aeródromo de Molos.
* Stratis.

---

<a id="src-threeden-geography-and-physical-validation-guide--40-validación-aérea"></a>
### 40. Validación aérea

Probar:

* aterrizaje;
* despegue;
* taxi;
* aparcamiento;
* helicópteros;
* aproximaciones;
* obstáculos;
* defensa AA;
* daños de pista.

---

<a id="src-threeden-geography-and-physical-validation-guide--41-capa-if08helios"></a>
### 41. Capa `IF_08_HELIOS`

Contiene:

* nodos;
* terminales;
* antenas;
* archivos;
* salas técnicas;
* enlaces físicos.

<a id="src-threeden-geography-and-physical-validation-guide--convención-7"></a>
#### Convención

```text
IF_HELIOS_{NODE_ID}_{FUNCTION}
```

Ejemplos:

```text
IF_HELIOS_AIRPORT_CORE_TERMINAL
IF_HELIOS_AAC_RELAY
IF_HELIOS_STRATIS_PHAROS_ENTRY
```

---

<a id="src-threeden-geography-and-physical-validation-guide--42-categorías-de-nodo-físico"></a>
### 42. Categorías de nodo físico

```text
COMMUNICATIONS
SENSOR
LOGISTICS
ENERGY
MEDICAL
GOVERNMENT
MILITARY
ANALYSIS
ARCHIVE
CORE
PHAROS
```

---

<a id="src-threeden-geography-and-physical-validation-guide--43-elementos-físicos-de-nodo"></a>
### 43. Elementos físicos de nodo

Un nodo puede tener:

* edificio;
* terminal principal;
* terminal secundaria;
* generador;
* antena;
* sala de servidores;
* acceso;
* punto de sabotaje;
* punto de auditoría.

<a id="src-threeden-geography-and-physical-validation-guide--regla-9"></a>
#### Regla

No todos los nodos necesitan un gran edificio tecnológico.

Algunos pueden ser:

* una sala municipal;
* un armario técnico;
* una antena;
* una estación de comunicación.

---

<a id="src-threeden-geography-and-physical-validation-guide--44-validación-de-nodos"></a>
### 44. Validación de nodos

Verificar:

* acceso del jugador;
* acceso de IA;
* defendibilidad;
* ruta de energía;
* espacio para interacción;
* posibilidad de daño;
* compatibilidad con escenas;
* rutas alternativas.

---

<a id="src-threeden-geography-and-physical-validation-guide--45-capa-if09narrative"></a>
### 45. Capa `IF_09_NARRATIVE`

Contiene:

* objetos únicos;
* habitaciones;
* evidencias físicas;
* lugares de diálogo;
* posiciones de personajes;
* instalaciones secretas.

<a id="src-threeden-geography-and-physical-validation-guide--regla-10"></a>
#### Regla

Los elementos narrativos deberán poseer ID estable y estado persistente cuando corresponda.

---

<a id="src-threeden-geography-and-physical-validation-guide--46-evidencias-físicas"></a>
### 46. Evidencias físicas

Cada evidencia colocada debe registrar:

```text
evidenceId
initialLocation
physicalObject
interactionPoint
alternateSpawn
destructionState
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-11"></a>
#### Regla

Las evidencias esenciales deben tener rutas alternativas si pueden destruirse.

---

<a id="src-threeden-geography-and-physical-validation-guide--47-espacios-de-diálogo"></a>
### 47. Espacios de diálogo

Validar:

* distancia entre personajes;
* iluminación;
* audio;
* seguridad;
* cámara;
* acceso.

No todos los diálogos necesitan una cinemática.

---

<a id="src-threeden-geography-and-physical-validation-guide--48-capa-if10initialforces"></a>
### 48. Capa `IF_10_INITIAL_FORCES`

Contiene solo fuerzas necesarias al inicio.

Ejemplos:

* unidades de desembarco;
* puestos Verdes;
* personajes;
* grupos del prólogo.

<a id="src-threeden-geography-and-physical-validation-guide--regla-12"></a>
#### Regla

Las fuerzas persistentes posteriores serán creadas por el sistema.

---

<a id="src-threeden-geography-and-physical-validation-guide--49-capa-if11compositions"></a>
### 49. Capa `IF_11_COMPOSITIONS`

Contiene composiciones maestras de desarrollo y prueba.

No todas deben permanecer instanciadas en la misión final.

<a id="src-threeden-geography-and-physical-validation-guide--función-1"></a>
#### Función

* editar;
* comparar;
* exportar;
* validar.

---

<a id="src-threeden-geography-and-physical-validation-guide--50-capa-if12spawnpoints"></a>
### 50. Capa `IF_12_SPAWN_POINTS`

Contiene anclajes de materialización.

<a id="src-threeden-geography-and-physical-validation-guide--tipos-1"></a>
#### Tipos

```text
INFANTRY
VEHICLE
CONVOY
AIRCRAFT
BOAT
QRF
CIVILIAN
RETREAT
EXTRACTION
```

<a id="src-threeden-geography-and-physical-validation-guide--convención-8"></a>
#### Convención

```text
IF_SPAWN_{SECTOR_ID}_{TYPE}_{NUMBER}
```

---

<a id="src-threeden-geography-and-physical-validation-guide--51-puntos-de-aparición-de-infantería"></a>
### 51. Puntos de aparición de infantería

Deben:

* estar fuera de visión directa;
* tener cobertura;
* disponer de ruta;
* evitar interiores inválidos;
* no quedar bloqueados.

---

<a id="src-threeden-geography-and-physical-validation-guide--52-puntos-de-aparición-de-vehículos"></a>
### 52. Puntos de aparición de vehículos

Deben:

* estar sobre superficie apta;
* orientar hacia ruta;
* permitir maniobra;
* evitar colisiones;
* tener salida.

---

<a id="src-threeden-geography-and-physical-validation-guide--53-puntos-de-refuerzo"></a>
### 53. Puntos de refuerzo

No deben aparecer directamente dentro del combate.

La fuerza deberá:

* entrar por carretera;
* descender de transporte;
* avanzar desde retaguardia;
* llegar por aire o mar.

---

<a id="src-threeden-geography-and-physical-validation-guide--54-puntos-de-retirada"></a>
### 54. Puntos de retirada

Cada sector debe tener posibles salidas hacia conexiones válidas.

<a id="src-threeden-geography-and-physical-validation-guide--datos-1"></a>
#### Datos

```text
retreatPoint
destinationSector
terrainType
vehicleCompatible
enemyExposure
```

---

<a id="src-threeden-geography-and-physical-validation-guide--55-puntos-de-extracción"></a>
### 55. Puntos de extracción

Pueden ser:

* carretera;
* helicóptero;
* costa;
* edificio seguro;
* zona montañosa.

Deben probarse en condiciones de combate.

---

<a id="src-threeden-geography-and-physical-validation-guide--56-capa-if13cameras"></a>
### 56. Capa `IF_13_CAMERAS`

Contiene:

* cámaras de prólogo;
* escenas;
* puntos de observación;
* tomas de transición.

<a id="src-threeden-geography-and-physical-validation-guide--regla-13"></a>
#### Regla

La campaña no dependerá de cámaras permanentes para lógica.

---

<a id="src-threeden-geography-and-physical-validation-guide--57-capa-if90testing"></a>
### 57. Capa `IF_90_TESTING`

Contiene:

* unidades de prueba;
* vehículos;
* triggers;
* cámaras;
* marcadores;
* herramientas.

<a id="src-threeden-geography-and-physical-validation-guide--regla-14"></a>
#### Regla

Debe poder desactivarse por completo.

No mezclar con capas de producción.

---

<a id="src-threeden-geography-and-physical-validation-guide--58-capa-if99disabledarchive"></a>
### 58. Capa `IF_99_DISABLED_ARCHIVE`

Puede conservar:

* versiones antiguas;
* anclajes descartados;
* composiciones reemplazadas.

<a id="src-threeden-geography-and-physical-validation-guide--regla-15"></a>
#### Regla

No debe cargarse en builds de prueba normales si afecta rendimiento.

---

<a id="src-threeden-geography-and-physical-validation-guide--59-ficha-maestra-de-sector"></a>
### 59. Ficha maestra de sector

Cada sector debe tener un documento o estructura con:

```text
sectorId
displayName
regionId
sectorType
strategicCenter
bounds
subzones
connections
roadAccess
seaAccess
airAccess
terrainTags
civilianZones
moduleAnchors
spawnPoints
retreatPoints
heliosNodes
logisticsAnchors
narrativeLocations
performanceBudget
validationState
```

---

<a id="src-threeden-geography-and-physical-validation-guide--60-estados-de-validación"></a>
### 60. Estados de validación

```text
NOT_STARTED
ROUGH
PHYSICALLY_MAPPED
ROUTES_TESTED
COMPOSITIONS_TESTED
AI_VALIDATED
PERFORMANCE_VALIDATED
FINAL
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-16"></a>
#### Regla

Un sector no se marca `FINAL` solo porque sus anclajes estén colocados.

---

<a id="src-threeden-geography-and-physical-validation-guide--61-validación-regional"></a>
### 61. Validación regional

Antes de validar cada sector individualmente, se debe comprobar:

* escala regional;
* distancias;
* conexiones;
* distribución de roles;
* corredores;
* retaguardia;
* frentes.

---

<a id="src-threeden-geography-and-physical-validation-guide--62-regiones-de-altis"></a>
### 62. Regiones de Altis

Agrupación operativa propuesta:

```text
REG_WEST_KAVALA
REG_NORTHWEST
REG_CENTRAL_WEST
REG_AIRPORT_CENTER
REG_NORTH_CENTRAL
REG_EAST
REG_NORTHEAST
REG_SOUTH_EAST
```

Las regiones pueden ajustarse durante validación sin cambiar los IDs de sectores.

---

<a id="src-threeden-geography-and-physical-validation-guide--63-catálogo-de-38-sectores"></a>
### 63. Catálogo de 38 sectores

<a id="src-threeden-geography-and-physical-validation-guide--oeste-de-kavala"></a>
#### Oeste de Kavala

1. `ALT_W_KAVALA_PORT`
2. `ALT_W_KAVALA_CITY`
3. `ALT_W_AGGELOCHORI`
4. `ALT_W_NERI_PANOCHORI`
5. `ALT_W_AGIOS_DIONYSIOS`
6. `ALT_W_KORE_TOPOLIA`

<a id="src-threeden-geography-and-physical-validation-guide--noroeste"></a>
#### Noroeste

7. `ALT_NW_OREOKASTRO`
8. `ALT_NW_ABDERA_GALATI`
9. `ALT_NW_SYRTA`
10. `ALT_NW_THRONOS`
11. `ALT_NW_WIND`

<a id="src-threeden-geography-and-physical-validation-guide--centro-oeste"></a>
#### Centro-oeste

12. `ALT_CW_KATALAKI`
13. `ALT_CW_NEOCHORI`
14. `ALT_CW_STAVROS_WHISKEY`
15. `ALT_CW_LAKKA`
16. `ALT_CW_AAC`
17. `ALT_CW_POLIAKKO_THERISA`
18. `ALT_CW_XIROLIMNI_ZAROS`

<a id="src-threeden-geography-and-physical-validation-guide--aeropuerto-y-centro"></a>
#### Aeropuerto y centro

19. `ALT_C_AIRPORT_WEST`
20. `ALT_C_AIRPORT_TERMINAL`
21. `ALT_C_AIRPORT_MIL`
22. `ALT_C_TELOS`
23. `ALT_C_GRAVIA`
24. `ALT_C_ATHIRA`

<a id="src-threeden-geography-and-physical-validation-guide--norte-central"></a>
#### Norte-central

25. `ALT_NC_FRINI_AGIA_TRIADA`
26. `ALT_NC_KALITHEA`

<a id="src-threeden-geography-and-physical-validation-guide--este"></a>
#### Este

27. `ALT_E_RODOPOLI`
28. `ALT_E_KALOCHORI_PAROS`

<a id="src-threeden-geography-and-physical-validation-guide--noreste"></a>
#### Noreste

29. `ALT_NE_IOANNINA_DELFINAKI`
30. `ALT_NE_SOFIA`
31. `ALT_NE_PEFKAS`
32. `ALT_NE_MOLOS`
33. `ALT_NE_MOLOS_AIRFIELD`

<a id="src-threeden-geography-and-physical-validation-guide--sureste"></a>
#### Sureste

34. `ALT_SE_CHARKIA`
35. `ALT_SE_PYRGOS_HARBOUR`
36. `ALT_SE_PYRGOS_GOV`
37. `ALT_SE_DORIDA_CHALKEIA`
38. `ALT_SE_FERES_SELAKANO`

---

<a id="src-threeden-geography-and-physical-validation-guide--64-prioridad-de-validación"></a>
### 64. Prioridad de validación

Los sectores no se validarán todos al mismo tiempo.

<a id="src-threeden-geography-and-physical-validation-guide--fase-v0-vertical-slice"></a>
#### Fase V0 — Vertical slice

1. Katalaki.
2. Neochori.
3. Stavros–Whiskey.
4. Lakka.
5. AAC.
6. Poliakko–Therisa.
7. Xirolimni–Zaros.
8. Airport West.
9. Airport Terminal.

<a id="src-threeden-geography-and-physical-validation-guide--fase-v1-continuación-azul"></a>
#### Fase V1 — Continuación Azul

* Aeropuerto Militar.
* Kavala.
* corredores occidentales.

<a id="src-threeden-geography-and-physical-validation-guide--fase-v2-inicio-rojo"></a>
#### Fase V2 — Inicio Rojo

* Molos.
* Molos Airfield.
* Sofia.
* Pefkas.
* corredor oriental.

<a id="src-threeden-geography-and-physical-validation-guide--fase-v3-gobierno-y-ciudades"></a>
#### Fase V3 — Gobierno y ciudades

* Pyrgos.
* Athira.
* centro y norte.

---

<a id="src-threeden-geography-and-physical-validation-guide--65-katalaki"></a>
### 65. Katalaki

<a id="src-threeden-geography-and-physical-validation-guide--función-2"></a>
#### Función

* cabeza de playa Azul;
* desembarco;
* logística provisional;
* defensa costera.

<a id="src-threeden-geography-and-physical-validation-guide--validar"></a>
#### Validar

* puntos de llegada naval;
* playas transitables;
* rampas;
* rutas de salida;
* espacio para descarga;
* cobertura;
* posiciones Verdes;
* zonas civiles;
* composición de cabeza de playa;
* orientación de defensa.

<a id="src-threeden-geography-and-physical-validation-guide--riesgo"></a>
#### Riesgo

Crear una zona de desembarco visualmente atractiva, pero imposible para vehículos o IA.

---

<a id="src-threeden-geography-and-physical-validation-guide--66-neochori"></a>
### 66. Neochori

<a id="src-threeden-geography-and-physical-validation-guide--función-3"></a>
#### Función

* primer centro urbano;
* municipio;
* logística;
* hospital o clínica;
* transición hacia guerra territorial.

<a id="src-threeden-geography-and-physical-validation-guide--validar-1"></a>
#### Validar

* accesos desde Katalaki;
* núcleo urbano;
* centro municipal;
* zona logística;
* rutas hacia Stavros y Poliakko;
* espacio para convoy;
* zonas civiles;
* puntos de protesta;
* posiciones defensivas.

---

<a id="src-threeden-geography-and-physical-validation-guide--67-stavroswhiskey"></a>
### 67. Stavros–Whiskey

<a id="src-threeden-geography-and-physical-validation-guide--función-4"></a>
#### Función

* primer punto militar Verde;
* corredor;
* contraataque;
* frente.

<a id="src-threeden-geography-and-physical-validation-guide--validar-2"></a>
#### Validar

* conexión carretera;
* posiciones militares;
* línea de tiro;
* fortificaciones;
* rutas de retirada;
* acceso hacia Lakka;
* emboscadas;
* separación entre población y posición militar.

---

<a id="src-threeden-geography-and-physical-validation-guide--68-lakka"></a>
### 68. Lakka

<a id="src-threeden-geography-and-physical-validation-guide--función-5"></a>
#### Función

* primera línea;
* QRF;
* defensa;
* presión mecanizada.

<a id="src-threeden-geography-and-physical-validation-guide--validar-3"></a>
#### Validar

* terreno defensivo;
* acceso mecanizado;
* rutas de convoy;
* puestos AT;
* reserva;
* visibilidad;
* rutas de flanqueo;
* impacto civil.

---

<a id="src-threeden-geography-and-physical-validation-guide--69-aac"></a>
### 69. AAC

<a id="src-threeden-geography-and-physical-validation-guide--función-6"></a>
#### Función

* aviación;
* comunicaciones;
* apoyo;
* transición al aeropuerto.

<a id="src-threeden-geography-and-physical-validation-guide--validar-4"></a>
#### Validar

* pista;
* hangares;
* accesos;
* posiciones AA;
* combustible;
* reparación;
* anclaje Helios;
* aproximaciones aéreas.

---

<a id="src-threeden-geography-and-physical-validation-guide--70-poliakkotherisa"></a>
### 70. Poliakko–Therisa

<a id="src-threeden-geography-and-physical-validation-guide--función-7"></a>
#### Función

* corredor rural;
* población;
* FIA;
* rutas secundarias;
* logística alternativa.

<a id="src-threeden-geography-and-physical-validation-guide--validar-5"></a>
#### Validar

* caminos rurales;
* escondites;
* granjas;
* zonas civiles;
* emboscadas;
* rutas clandestinas;
* accesos de camiones.

---

<a id="src-threeden-geography-and-physical-validation-guide--71-xirolimnizaros"></a>
### 71. Xirolimni–Zaros

<a id="src-threeden-geography-and-physical-validation-guide--función-8"></a>
#### Función

* conexión sur;
* logística;
* terreno mixto;
* aproximación al aeropuerto.

<a id="src-threeden-geography-and-physical-validation-guide--validar-6"></a>
#### Validar

* zonas abiertas;
* carreteras;
* cruces;
* posiciones de observación;
* composición de apoyo;
* rutas alternativas.

---

<a id="src-threeden-geography-and-physical-validation-guide--72-airport-west"></a>
### 72. Airport West

<a id="src-threeden-geography-and-physical-validation-guide--función-9"></a>
#### Función

* aproximación;
* defensa exterior;
* control de pistas;
* batalla de acceso.

<a id="src-threeden-geography-and-physical-validation-guide--validar-7"></a>
#### Validar

* líneas de aproximación;
* espacios abiertos;
* cobertura;
* QRF;
* puntos AT;
* posiciones de observación;
* zonas de transición.

---

<a id="src-threeden-geography-and-physical-validation-guide--73-airport-terminal"></a>
### 73. Airport Terminal

<a id="src-threeden-geography-and-physical-validation-guide--función-10"></a>
#### Función

* Helios-0;
* infraestructura;
* narrativa;
* nodo central;
* civiles técnicos.

<a id="src-threeden-geography-and-physical-validation-guide--validar-8"></a>
#### Validar

* terminales;
* salas;
* accesos;
* seguridad;
* Helios;
* evidencia;
* caminos interiores;
* rendimiento en entorno complejo.

---

<a id="src-threeden-geography-and-physical-validation-guide--74-aeropuerto-militar"></a>
### 74. Aeropuerto Militar

<a id="src-threeden-geography-and-physical-validation-guide--función-11"></a>
#### Función

* mando;
* defensa;
* apoyo aéreo;
* nodo militar Helios.

<a id="src-threeden-geography-and-physical-validation-guide--validar-9"></a>
#### Validar

* fortificación;
* entrada;
* blindados;
* hangares;
* AA;
* artillería;
* zonas de mando;
* rutas entre terminal y zona militar.

---

<a id="src-threeden-geography-and-physical-validation-guide--75-molos"></a>
### 75. Molos

<a id="src-threeden-geography-and-physical-validation-guide--función-12"></a>
#### Función

* cabeza de playa Roja;
* puerto;
* enlace gubernamental;
* logística oriental.

<a id="src-threeden-geography-and-physical-validation-guide--validar-10"></a>
#### Validar

* aproximación naval;
* muelle;
* descarga;
* centro urbano;
* trabajadores;
* rutas hacia aeródromo;
* posibles unidades Verdes;
* control dual.

---

<a id="src-threeden-geography-and-physical-validation-guide--76-molos-airfield"></a>
### 76. Molos Airfield

<a id="src-threeden-geography-and-physical-validation-guide--función-13"></a>
#### Función

* aeródromo Rojo;
* logística;
* expansión;
* salida hacia Sofia.

<a id="src-threeden-geography-and-physical-validation-guide--validar-11"></a>
#### Validar

* pista;
* aparcamiento;
* combustible;
* ruta;
* defensa;
* comunicación;
* capacidad de daño y reparación.

---

<a id="src-threeden-geography-and-physical-validation-guide--77-sofia"></a>
### 77. Sofia

<a id="src-threeden-geography-and-physical-validation-guide--función-14"></a>
#### Función

* puerta del corredor;
* negociación o ruptura;
* autoridad Verde.

<a id="src-threeden-geography-and-physical-validation-guide--validar-12"></a>
#### Validar

* cuellos de botella;
* centro de reunión;
* posiciones defensivas;
* rutas de flanqueo;
* áreas civiles;
* salida oeste;
* acceso norte y sur.

---

<a id="src-threeden-geography-and-physical-validation-guide--78-kavala"></a>
### 78. Kavala

Debe dividirse físicamente al menos en:

* puerto;
* ciudad;
* zonas administrativas;
* rutas;
* espacios FIA.

<a id="src-threeden-geography-and-physical-validation-guide--problemas-a-probar"></a>
#### Problemas a probar

* IA urbana;
* convoyes;
* rendimiento;
* protestas;
* densidad civil;
* combate;
* cámaras.

---

<a id="src-threeden-geography-and-physical-validation-guide--79-pyrgos"></a>
### 79. Pyrgos

Debe separar:

* puerto;
* Gobierno;
* zonas civiles;
* acceso militar.

<a id="src-threeden-geography-and-physical-validation-guide--validar-13"></a>
#### Validar

* edificios institucionales;
* plazas;
* rutas de evacuación;
* protestas;
* golpes;
* seguridad;
* Helios gubernamental.

---

<a id="src-threeden-geography-and-physical-validation-guide--80-aeropuerto-internacional"></a>
### 80. Aeropuerto Internacional

Aunque se divide en tres sectores, debe validarse como complejo continuo.

<a id="src-threeden-geography-and-physical-validation-guide--comprobar"></a>
#### Comprobar

* transiciones;
* límites;
* control parcial;
* movimiento de fuerzas;
* uso de pista;
* rutas logísticas;
* nodos Helios;
* daños que afecten a varios sectores.

---

<a id="src-threeden-geography-and-physical-validation-guide--81-stratis"></a>
### 81. Stratis

El mapa final necesitará una guía específica posterior, pero esta arquitectura se aplicará desde ahora.

<a id="src-threeden-geography-and-physical-validation-guide--categorías-mínimas"></a>
#### Categorías mínimas

* anillo exterior;
* guarnición Verde;
* puertos;
* rutas de infiltración;
* S-26;
* HELIOS-CORE;
* PHAROS;
* Meridian;
* rutas de escape;
* zonas civiles.

<a id="src-threeden-geography-and-physical-validation-guide--regla-17"></a>
#### Regla

Stratis no se diseñará completamente antes de validar Altis y los sistemas principales.

---

<a id="src-threeden-geography-and-physical-validation-guide--82-grafo-territorial"></a>
### 82. Grafo territorial

Cada sector debe tener:

* al menos una conexión;
* función;
* profundidad;
* ruta de abastecimiento posible.

<a id="src-threeden-geography-and-physical-validation-guide--verificaciones"></a>
#### Verificaciones

1. No crear sectores aislados sin razón.
2. No crear conexiones que atraviesen terreno imposible.
3. No permitir que un solo nodo controle toda Altis sin alternativas.
4. Crear rutas secundarias.
5. Definir consecuencias de bloqueo.

---

<a id="src-threeden-geography-and-physical-validation-guide--83-profundidad-del-frente"></a>
### 83. Profundidad del frente

Las posiciones P0–P4 no se fijan permanentemente.

Se calculan según:

* enemigo;
* conexiones;
* control;
* distancia.

<a id="src-threeden-geography-and-physical-validation-guide--validación-geográfica"></a>
#### Validación geográfica

Debe comprobarse que un sector clasificado como retaguardia pueda:

* recibir convoyes;
* alojar módulos;
* operar sin estar físicamente expuesto desde un frente cercano.

---

<a id="src-threeden-geography-and-physical-validation-guide--84-orientación-del-frente"></a>
### 84. Orientación del frente

Cada sector necesita varios vectores potenciales.

```text
threatVectorNorth
threatVectorEast
threatVectorSouth
threatVectorWest
```

No será necesario almacenar cuatro valores si pueden derivarse de conexiones, pero sí deben validarse posiciones defensivas para las direcciones probables.

---

<a id="src-threeden-geography-and-physical-validation-guide--85-posiciones-defensivas"></a>
### 85. Posiciones defensivas

Tipos:

```text
OBSERVATION
INFANTRY
MACHINE_GUN
ANTI_TANK
ANTI_AIR
MORTAR
RESERVE
FALLBACK
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-18"></a>
#### Regla

No todas estarán activas simultáneamente.

Son opciones validadas.

---

<a id="src-threeden-geography-and-physical-validation-guide--86-líneas-de-tiro"></a>
### 86. Líneas de tiro

Cada posición deberá probar:

* campo de visión;
* obstrucciones;
* seguridad;
* fuego amigo;
* exposición;
* ruta de acceso.

<a id="src-threeden-geography-and-physical-validation-guide--no-colocar"></a>
#### No colocar

Armas estáticas que:

* disparen contra paredes;
* no puedan rotar;
* bloqueen carreteras;
* sean inútiles por relieve.

---

<a id="src-threeden-geography-and-physical-validation-guide--87-rutas-de-patrulla"></a>
### 87. Rutas de patrulla

Las patrullas utilizarán redes de nodos.

<a id="src-threeden-geography-and-physical-validation-guide--tipos-2"></a>
#### Tipos

* urbana;
* rural;
* perímetro;
* costa;
* militar;
* clandestina.

<a id="src-threeden-geography-and-physical-validation-guide--datos-2"></a>
#### Datos

```text
patrolRouteId
sectorId
nodeIds
allowedUnitTypes
dangerLevel
civilianOverlap
```

---

<a id="src-threeden-geography-and-physical-validation-guide--88-pathfinding-de-ia"></a>
### 88. Pathfinding de IA

Cada sector se probará con:

* infantería;
* vehículos;
* grupos;
* convoyes;
* retirada.

<a id="src-threeden-geography-and-physical-validation-guide--pruebas"></a>
#### Pruebas

* entrada;
* salida;
* cruce urbano;
* giro;
* cobertura;
* desembarco;
* montaje y desmontaje.

---

<a id="src-threeden-geography-and-physical-validation-guide--89-navegación-de-convoyes"></a>
### 89. Navegación de convoyes

Prueba estándar:

```text
1 vehículo líder
3–5 transportes
1–2 escoltas
```

<a id="src-threeden-geography-and-physical-validation-guide--registrar-1"></a>
#### Registrar

* separación;
* colisiones;
* pérdida de ruta;
* detenciones;
* velocidad;
* tiempo.

---

<a id="src-threeden-geography-and-physical-validation-guide--90-navegación-de-blindados"></a>
### 90. Navegación de blindados

Validar:

* anchura;
* curvas;
* muros;
* pendientes;
* puentes;
* zonas de despliegue.

---

<a id="src-threeden-geography-and-physical-validation-guide--91-navegación-aérea"></a>
### 91. Navegación aérea

Validar:

* trayectorias;
* aproximaciones;
* alturas;
* zonas de aterrizaje;
* amenazas;
* extracción.

<a id="src-threeden-geography-and-physical-validation-guide--helicópteros"></a>
#### Helicópteros

Cada LZ debe tener:

* tamaño;
* pendiente;
* obstáculos;
* salida;
* alternativas.

---

<a id="src-threeden-geography-and-physical-validation-guide--92-navegación-naval"></a>
### 92. Navegación naval

Validar:

* profundidad;
* costa;
* muelles;
* obstáculos;
* desembarco;
* rutas de patrulla.

---

<a id="src-threeden-geography-and-physical-validation-guide--93-materialización-fuera-de-visión"></a>
### 93. Materialización fuera de visión

Cada sector debe tener puntos para:

* fuerzas entrantes;
* convoyes;
* QRF;
* civiles;
* FIA.

<a id="src-threeden-geography-and-physical-validation-guide--regla-19"></a>
#### Regla

Los puntos se seleccionan según dirección real de procedencia.

---

<a id="src-threeden-geography-and-physical-validation-guide--94-preload-y-transición"></a>
### 94. Preload y transición

Antes de que una fuerza aparezca:

* cargar composición;
* reservar activos;
* seleccionar punto;
* verificar que el jugador no mira;
* comprobar colisión.

---

<a id="src-threeden-geography-and-physical-validation-guide--95-zonas-de-cámara"></a>
### 95. Zonas de cámara

Las cámaras pueden ampliar la percepción del jugador.

Por eso las zonas de materialización deben considerar:

* cámaras de escena;
* drones;
* ópticas;
* alturas.

---

<a id="src-threeden-geography-and-physical-validation-guide--96-escala-física-frente-a-estratégica"></a>
### 96. Escala física frente a estratégica

Una guarnición estratégica de 80 personas no requiere espacio físico para 80 unidades simultáneas.

El sector debe poder representar:

* núcleo;
* puestos;
* reserva;
* oleadas;
* retirada.

---

<a id="src-threeden-geography-and-physical-validation-guide--97-presupuesto-de-objetos-por-sector"></a>
### 97. Presupuesto de objetos por sector

Cada sector tendrá un presupuesto.

<a id="src-threeden-geography-and-physical-validation-guide--categorías-orientativas"></a>
#### Categorías orientativas

<a id="src-threeden-geography-and-physical-validation-guide--sector-rural-menor"></a>
##### Sector rural menor

* presupuesto bajo.

<a id="src-threeden-geography-and-physical-validation-guide--ciudad"></a>
##### Ciudad

* presupuesto ambiental alto, militar moderado.

<a id="src-threeden-geography-and-physical-validation-guide--base"></a>
##### Base

* presupuesto militar alto.

<a id="src-threeden-geography-and-physical-validation-guide--aeropuerto"></a>
##### Aeropuerto

* presupuesto especial.

<a id="src-threeden-geography-and-physical-validation-guide--regla-20"></a>
#### Regla

El presupuesto final se fijará tras pruebas, no por intuición.

---

<a id="src-threeden-geography-and-physical-validation-guide--98-presupuesto-de-composiciones"></a>
### 98. Presupuesto de composiciones

Cada composición tendrá:

```text
objectCount
simulationObjectCount
staticWeaponCount
lightCount
effectsCount
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-21"></a>
#### Regla

No tratar todos los objetos como equivalentes.

---

<a id="src-threeden-geography-and-physical-validation-guide--99-objetos-decorativos"></a>
### 99. Objetos decorativos

Se limitarán cuando:

* no aportan cobertura;
* no comunican función;
* dañan rendimiento;
* bloquean IA.

---

<a id="src-threeden-geography-and-physical-validation-guide--100-iluminación"></a>
### 100. Iluminación

La iluminación nocturna debe:

* representar estado energético;
* apoyar navegación;
* no saturar;
* permitir apagones;
* diferenciar Helios.

---

<a id="src-threeden-geography-and-physical-validation-guide--101-clima-y-hora"></a>
### 101. Clima y hora

Cada sector crítico debe probarse en:

* día;
* noche;
* lluvia;
* niebla si se usa;
* amanecer;
* atardecer.

<a id="src-threeden-geography-and-physical-validation-guide--objetivo"></a>
#### Objetivo

Comprobar:

* visibilidad;
* cámaras;
* iluminación;
* orientación;
* rendimiento.

---

<a id="src-threeden-geography-and-physical-validation-guide--102-sonido-ambiental"></a>
### 102. Sonido ambiental

Validar:

* mar;
* ciudad;
* base;
* aeropuerto;
* Helios;
* civiles;
* combate distante.

El diseño de audio completo se rige por el [Documento 12/14](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system).

---

<a id="src-threeden-geography-and-physical-validation-guide--103-integración-civil"></a>
### 103. Integración civil

Las zonas civiles deben permitir que la población:

* se mueva;
* se reúna;
* evacúe;
* proteste;
* acceda a servicios.

<a id="src-threeden-geography-and-physical-validation-guide--evitar"></a>
#### Evitar

* civiles cruzando líneas de tiro de forma permanente;
* mercados dentro de zonas de spawn militar;
* hospitales bloqueados por fortificaciones.

---

<a id="src-threeden-geography-and-physical-validation-guide--104-integración-logística"></a>
### 104. Integración logística

Toda base o sector logístico debe responder:

1. ¿Dónde llegan los vehículos?
2. ¿Dónde esperan?
3. ¿Dónde descargan?
4. ¿Dónde salen?
5. ¿Qué ocurre bajo ataque?
6. ¿Existe ruta alternativa?

---

<a id="src-threeden-geography-and-physical-validation-guide--105-integración-de-construcción"></a>
### 105. Integración de construcción

Los anclajes deben representar crecimiento.

<a id="src-threeden-geography-and-physical-validation-guide--ejemplo-l1"></a>
#### Ejemplo L1

* mando;
* defensa básica;
* pequeño suministro.

<a id="src-threeden-geography-and-physical-validation-guide--ejemplo-l3"></a>
#### Ejemplo L3

* más módulos;
* más anclajes;
* acceso de vehículos;
* profundidad.

<a id="src-threeden-geography-and-physical-validation-guide--regla-22"></a>
#### Regla

Los módulos de niveles altos no deben bloquear físicamente los anteriores.

---

<a id="src-threeden-geography-and-physical-validation-guide--106-composiciones-destructibles"></a>
### 106. Composiciones destructibles

Probar:

* daño;
* escombros;
* acceso;
* reconstrucción;
* limpieza.

<a id="src-threeden-geography-and-physical-validation-guide--regla-23"></a>
#### Regla

Una composición destruida no debe dejar el sector inutilizable para siempre salvo que sea intención estratégica.

---

<a id="src-threeden-geography-and-physical-validation-guide--107-validación-de-captura"></a>
### 107. Validación de captura

Cada sector debe probar:

* entrada atacante;
* defensa;
* retirada;
* puntos esenciales;
* cambio visual;
* guarnición nueva;
* reorientación.

---

<a id="src-threeden-geography-and-physical-validation-guide--108-puntos-esenciales-de-captura"></a>
### 108. Puntos esenciales de captura

No todos los sectores usarán el mismo patrón.

Posibles:

```text
COMMAND
LOGISTICS
COMMUNICATIONS
MUNICIPAL
RUNWAY
PORT
HELIOS
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-24"></a>
#### Regla

Eliminar enemigos no basta.

Los puntos esenciales ayudan a determinar control.

---

<a id="src-threeden-geography-and-physical-validation-guide--109-validación-de-recuperación"></a>
### 109. Validación de recuperación

Después de una batalla:

* reparar rutas;
* retirar restos;
* reactivar servicios;
* construir;
* patrullar.

El sector debe seguir siendo utilizable.

---

<a id="src-threeden-geography-and-physical-validation-guide--110-documentación-fotográfica"></a>
### 110. Documentación fotográfica

Cada sector validado deberá conservar:

* vista aérea;
* centro;
* accesos;
* anclajes;
* posiciones;
* rutas;
* zonas civiles.

<a id="src-threeden-geography-and-physical-validation-guide--estructura"></a>
#### Estructura

```text
docs/geography/{sectorId}/
├── overview.png
├── access_north.png
├── access_south.png
├── modules.png
├── civilian.png
└── validation.md
```

---

<a id="src-threeden-geography-and-physical-validation-guide--111-ficha-de-validación"></a>
### 111. Ficha de validación

```text
Sector:
Fecha:
Responsable:
Versión:

[ ] Centro confirmado
[ ] Límites confirmados
[ ] Conexiones confirmadas
[ ] Ruta ligera
[ ] Ruta pesada
[ ] Convoy
[ ] Infantería
[ ] Retirada
[ ] Zonas civiles
[ ] Módulos
[ ] Spawn
[ ] Helios
[ ] Captura
[ ] Rendimiento
[ ] Día
[ ] Noche
```

---

<a id="src-threeden-geography-and-physical-validation-guide--112-convención-de-marcadores-de-desarrollo"></a>
### 112. Convención de marcadores de desarrollo

```text
DEV_SECTOR
DEV_ROUTE
DEV_SPAWN
DEV_MODULE
DEV_CIVIL
DEV_HELIOS
DEV_EXCLUSION
DEV_ERROR
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-25"></a>
#### Regla

Los marcadores de desarrollo deben poder ocultarse o eliminarse en build final.

---

<a id="src-threeden-geography-and-physical-validation-guide--113-colores-de-desarrollo"></a>
### 113. Colores de desarrollo

Pueden utilizarse consistentemente durante producción.

Ejemplo:

* sector: blanco;
* ruta: amarillo;
* spawn: azul;
* módulo: verde;
* civil: naranja;
* Helios: violeta;
* error: rojo.

Estos colores son solo de desarrollo, no parte de la interfaz final.

---

<a id="src-threeden-geography-and-physical-validation-guide--114-atributos-personalizados"></a>
### 114. Atributos personalizados

Los objetos relevantes podrán tener variables de editor o atributos procesados al iniciar.

Ejemplos:

```text
IF_id
IF_sectorId
IF_anchorType
IF_tags
IF_persistent
```

<a id="src-threeden-geography-and-physical-validation-guide--regla-26"></a>
#### Regla

No introducir decenas de atributos sin un registro documentado.

---

<a id="src-threeden-geography-and-physical-validation-guide--115-registro-de-anclajes"></a>
### 115. Registro de anclajes

Durante bootstrap:

1. buscar anclajes;
2. leer ID;
3. validar sector;
4. registrar posición;
5. registrar dirección;
6. comprobar duplicados;
7. generar diagnóstico.

---

<a id="src-threeden-geography-and-physical-validation-guide--116-ids-duplicados"></a>
### 116. IDs duplicados

Un ID duplicado será error crítico de configuración.

No se seleccionará silenciosamente uno.

---

<a id="src-threeden-geography-and-physical-validation-guide--117-anclaje-ausente"></a>
### 117. Anclaje ausente

Un módulo puede:

* utilizar fallback;
* quedar deshabilitado;
* detener vertical slice si es crítico.

<a id="src-threeden-geography-and-physical-validation-guide--ejemplo-1"></a>
#### Ejemplo

Falta anclaje de descarga de Katalaki:

* debe bloquear creación del convoy inicial;
* registrar error claro.

---

<a id="src-threeden-geography-and-physical-validation-guide--118-fallbacks-geográficos"></a>
### 118. Fallbacks geográficos

Solo se usarán cuando estén previamente definidos y validados.

No utilizar:

* posición aleatoria;
* centro del sector;
* posición segura genérica;

para activos narrativos o vehículos pesados sin prueba.

---

<a id="src-threeden-geography-and-physical-validation-guide--119-edición-del-missionsqm"></a>
### 119. Edición del `mission.sqm`

No se editará manualmente salvo necesidad controlada.

El flujo normal será:

* 3DEN;
* guardado;
* revisión;
* control de versiones.

---

<a id="src-threeden-geography-and-physical-validation-guide--120-control-de-versiones"></a>
### 120. Control de versiones

Antes de grandes cambios:

* commit;
* copia;
* descripción.

<a id="src-threeden-geography-and-physical-validation-guide--separar-commits"></a>
#### Separar commits

* anclajes;
* composiciones;
* narrativa;
* pruebas.

---

<a id="src-threeden-geography-and-physical-validation-guide--121-comparación-de-cambios"></a>
### 121. Comparación de cambios

Los cambios grandes de `mission.sqm` deberán acompañarse de:

* sector afectado;
* objetivo;
* capturas;
* pruebas realizadas.

---

<a id="src-threeden-geography-and-physical-validation-guide--122-nombres-de-entidades"></a>
### 122. Nombres de entidades

Todo elemento relevante debe tener nombre descriptivo.

Incorrecto:

```text
Object12
Marker34
```

Correcto:

```text
IF_ANCHOR_ALT_CW_NEOCHORI_LOGISTICS_01
```

---

<a id="src-threeden-geography-and-physical-validation-guide--123-elementos-no-nombrados"></a>
### 123. Elementos no nombrados

Pueden quedar sin ID individual:

* decoración;
* escombros visuales;
* objetos sin persistencia;
* elementos internos de composición.

---

<a id="src-threeden-geography-and-physical-validation-guide--124-escenarios-de-prueba-geográfica"></a>
### 124. Escenarios de prueba geográfica

Crear misiones o modos internos:

```text
TEST_SECTOR_VALIDATION
TEST_ROUTE_VALIDATION
TEST_CONVOY_VALIDATION
TEST_COMPOSITION_VALIDATION
TEST_CAPTURE_VALIDATION
TEST_HELIOS_VALIDATION
```

---

<a id="src-threeden-geography-and-physical-validation-guide--125-prueba-de-sector"></a>
### 125. Prueba de sector

Debe permitir:

* teletransporte;
* cambiar bando;
* activar guarnición;
* generar composición;
* atacar;
* capturar;
* reiniciar.

---

<a id="src-threeden-geography-and-physical-validation-guide--126-prueba-de-ruta"></a>
### 126. Prueba de ruta

Debe permitir:

* seleccionar vehículo;
* seleccionar convoy;
* ejecutar ida y vuelta;
* registrar tiempos;
* mostrar bloqueos.

---

<a id="src-threeden-geography-and-physical-validation-guide--127-prueba-de-composición"></a>
### 127. Prueba de composición

Debe permitir:

* seleccionar variante;
* facción;
* tier;
* terreno;
* daño.

---

<a id="src-threeden-geography-and-physical-validation-guide--128-prueba-de-materialización"></a>
### 128. Prueba de materialización

Debe permitir:

* generar fuerza fuera de visión;
* aproximarla;
* desmaterializar;
* volver a materializar;
* comprobar orientación y posición.

---

<a id="src-threeden-geography-and-physical-validation-guide--129-prueba-civil"></a>
### 129. Prueba civil

Debe permitir:

* generar población;
* protesta;
* evacuación;
* servicios;
* combate cercano.

---

<a id="src-threeden-geography-and-physical-validation-guide--130-prueba-helios"></a>
### 130. Prueba Helios

Debe permitir:

* interactuar;
* defender;
* auditar;
* sabotear;
* destruir;
* comprobar rutas.

---

<a id="src-threeden-geography-and-physical-validation-guide--131-rendimiento"></a>
### 131. Rendimiento

Cada sector se probará con:

* estado normal;
* combate;
* civiles;
* composición máxima prevista;
* convoy;
* UI estratégica cerrada y abierta.

---

<a id="src-threeden-geography-and-physical-validation-guide--132-registro-de-rendimiento"></a>
### 132. Registro de rendimiento

```text
sectorId
scenario
activeAI
groups
vehicles
objects
averageFPS
minimumFPS
scriptTime
issues
```

---

<a id="src-threeden-geography-and-physical-validation-guide--133-criterio-de-aprobación-de-sector"></a>
### 133. Criterio de aprobación de sector

Un sector se aprueba cuando:

1. Sus límites son comprensibles.
2. Sus conexiones son reales.
3. La IA puede entrar y salir.
4. Los convoyes funcionan.
5. Las composiciones caben.
6. Los civiles pueden operar.
7. La captura es legible.
8. Las retiradas son posibles.
9. Los spawns no son visibles.
10. El rendimiento es aceptable.
11. El sector conserva identidad.
12. La documentación está actualizada.

---

<a id="src-threeden-geography-and-physical-validation-guide--134-errores-de-diseño-geográfico-que-deben-evitarse"></a>
### 134. Errores de diseño geográfico que deben evitarse

1. Sectores demasiado grandes.
2. Sectores demasiado pequeños.
3. Límites que atraviesan edificios centrales.
4. Conexiones imposibles.
5. Rutas únicas sin alternativa.
6. Convoyes en calles inviables.
7. Fortificaciones bloqueando entradas.
8. Spawns visibles.
9. Guarniciones sin retirada.
10. Puertos sin descarga terrestre.
11. Aeropuertos sin taxi o aparcamiento.
12. Nodos Helios inaccesibles.
13. Zonas civiles dentro de fuego cruzado permanente.
14. Módulos sobre pendientes.
15. Demasiados objetos decorativos.
16. Sectores sin función.
17. Ciudades tratadas como un único círculo simple.
18. Coordenadas inventadas sin prueba.
19. Triggers duplicando lógica SQF.
20. Objetos de prueba en capas de producción.

---

<a id="src-threeden-geography-and-physical-validation-guide--135-principios-obligatorios"></a>
### 135. Principios obligatorios

1. La geografía se valida en 3DEN.
2. Los IDs estratégicos se conservan.
3. Las coordenadas definitivas se miden.
4. Los anclajes se nombran.
5. Los límites siguen terreno y función.
6. Las conexiones deben ser transitables.
7. Los convoyes se prueban físicamente.
8. Las retiradas deben existir.
9. Los módulos utilizan anclajes validados.
10. El jugador no coloca construcciones manualmente.
11. Los spawns permanecen fuera de visión.
12. Los sectores poseen zonas civiles.
13. Los servicios necesitan espacios físicos.
14. Los nodos Helios tienen presencia creíble.
15. Los puertos conectan mar y tierra.
16. Los aeropuertos conectan pista, mantenimiento y logística.
17. Las composiciones no bloquean IA.
18. Las capas separan responsabilidades.
19. Los objetos narrativos tienen ID estable.
20. Las fuerzas variables se generan por SQF.
21. Los triggers se mantienen mínimos.
22. Los sectores se validan por fases.
23. El vertical slice se valida primero.
24. Stratis se desarrolla después de estabilizar Altis.
25. Las pruebas incluyen día y noche.
26. El rendimiento se mide por sector.
27. Cada sector conserva documentación visual.
28. Ningún sector se marca final sin pruebas.
29. Los errores de geografía se corrigen antes de crear más contenido.
30. 3DEN y SQF deben complementarse sin duplicar autoridad.

---

<a id="src-threeden-geography-and-physical-validation-guide--136-orden-de-trabajo-obligatorio"></a>
### 136. Orden de trabajo obligatorio

<a id="src-threeden-geography-and-physical-validation-guide--paso-1-preparar-misión-base"></a>
#### Paso 1 — Preparar misión base

* crear capas;
* configurar nombres;
* limpiar objetos de prueba;
* establecer scripts de registro.

<a id="src-threeden-geography-and-physical-validation-guide--paso-2-crear-vertical-slice"></a>
#### Paso 2 — Crear vertical slice

* nueve sectores;
* conexiones;
* rutas;
* anclajes.

<a id="src-threeden-geography-and-physical-validation-guide--paso-3-probar-geografía"></a>
#### Paso 3 — Probar geografía

* infantería;
* vehículos;
* convoy;
* retirada;
* capturas.

<a id="src-threeden-geography-and-physical-validation-guide--paso-4-crear-composiciones"></a>
#### Paso 4 — Crear composiciones

Solo después de confirmar terreno.

<a id="src-threeden-geography-and-physical-validation-guide--paso-5-integrar-sistemas"></a>
#### Paso 5 — Integrar sistemas

* sectores;
* fuerzas;
* logística;
* construcción;
* civiles.

<a id="src-threeden-geography-and-physical-validation-guide--paso-6-validar-campaña-azul-acto-i"></a>
#### Paso 6 — Validar campaña Azul Acto I

<a id="src-threeden-geography-and-physical-validation-guide--paso-7-ampliar-centro-oeste"></a>
#### Paso 7 — Ampliar centro-oeste

<a id="src-threeden-geography-and-physical-validation-guide--paso-8-crear-corredor-rojo"></a>
#### Paso 8 — Crear corredor Rojo

<a id="src-threeden-geography-and-physical-validation-guide--paso-9-ampliar-resto-de-altis"></a>
#### Paso 9 — Ampliar resto de Altis

<a id="src-threeden-geography-and-physical-validation-guide--paso-10-diseñar-stratis"></a>
#### Paso 10 — Diseñar Stratis

---

<a id="src-threeden-geography-and-physical-validation-guide--137-salida-esperada-de-la-fase-3den"></a>
### 137. Salida esperada de la fase 3DEN

Al terminar esta fase deben existir:

* misión base organizada;
* nueve sectores completamente validados;
* 38 sectores registrados al menos en estado inicial;
* grafo territorial documentado;
* rutas principales;
* rutas secundarias;
* anclajes de módulos;
* zonas civiles;
* nodos Helios iniciales;
* puntos de spawn;
* herramientas de prueba;
* documentación visual;
* lista de problemas pendientes.

---

<a id="src-threeden-geography-and-physical-validation-guide--138-definición-final"></a>
### 138. Definición final

El mapa de Altis no será solamente el escenario donde se colocan misiones.

Será una parte activa del sistema estratégico.

Una carretera deberá importar porque:

* conecta dos sectores;
* permite convoyes;
* puede bloquearse;
* condiciona una retirada.

Una colina deberá importar porque:

* observa una ruta;
* protege un sector;
* permite defensa;
* condiciona artillería.

Una ciudad deberá importar porque:

* contiene población;
* servicios;
* autoridades;
* rutas;
* memoria.

Un puerto deberá importar porque conecta la guerra exterior con los recursos físicos que llegan a la isla.

Un nodo Helios deberá sentirse integrado en:

* administración;
* energía;
* comunicaciones;
* defensa;

no colocado como un ordenador aislado para activar una misión.

> **La documentación estratégica indica qué debe significar cada sector. 3DEN deberá demostrar que ese significado funciona físicamente.**

> **Ninguna coordenada será definitiva porque parezca correcta desde el mapa. Será definitiva cuando soldados, vehículos, civiles, convoyes, cámaras y sistemas puedan utilizarla sin romper la campaña.**

> **El mundo no debe adaptarse a una misión escrita. Las misiones deberán surgir de una geografía validada capaz de sostener muchas situaciones diferentes.**

<a id="src-threeden-geography-and-physical-validation-guide--estado-actualizado"></a>
#### Estado actualizado

El [Documento 12/14](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system) fija las voces de cada facción y personaje, las reglas de conversación, las comunicaciones tácticas, los subtítulos, las escenas, los informes y la forma de contar la historia sin detener constantemente la guerra.

El [Documento 13/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system) fija pruebas, métricas, rendimiento, defectos y criterios de aprobación para sectores, rutas, composiciones y escenarios 3DEN.

El [Documento 14/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan) fija el orden, alcance, entregables y puertas del trabajo geográfico y 3DEN. La colección rectora queda completa.
