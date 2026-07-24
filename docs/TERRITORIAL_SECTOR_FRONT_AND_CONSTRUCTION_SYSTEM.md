# Sistema territorial de sectores, frentes y construcción automática

> **Estado:** documento rector de diseño territorial previo a implementación.  
> **Motor:** Arma 3 2.18.  
> **Terrenos:** Altis y Stratis.  
> **Geografía e IDs:** [ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md](ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md).  
> **Fuerzas y guarniciones:** [MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md](MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md).  
> **Persistencia:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).  
> **Catálogo físico:** [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md).  
> **Producción y suministro:** [ECONOMIC_AND_LOGISTICS_SYSTEM.md](ECONOMIC_AND_LOGISTICS_SYSTEM.md).

## 1. Regla esencial

> El nivel abre capacidad; el tipo define qué puede existir; la posición en el frente decide qué conviene construir; la experiencia de combate determina hacia dónde orientarlo.

El jugador establece prioridades estratégicas. La IA selecciona módulo, sector, composición, anclaje, orientación, coste, duración y respuesta ante captura o retirada.

## 2. Configuración y dimensiones

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

## 3. Tipos de sector

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

## 4. Niveles estructurales

| Nivel | Significado | Funcionales | Defensivos | Guarnición orientativa |
|---:|---|---:|---:|---:|
| 0 | sin estructura operacional | 0 | 0–1 provisional | 0–6 |
| 1 | presencia organizada | 2 | 2 | 8–18 |
| 2 | sector consolidado | 4 | 3 | 20–40 |
| 3 | centro regional | 6 | 4 | 40–75 |
| 4 | centro estratégico | 8 | 6 | 80–150 |

Las cifras representan capacidad territorial. La fuerza real se limita por las reservas militares y no se materializa completa.

Nivel 4 exige tipo compatible, infraestructura, espacio validado, estabilidad, conexiones, valor estratégico e inversión.

## 5. Modificadores por tipo

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

## 6. Peso de módulos

| Peso | Coste | Ejemplos |
|---|---:|---|
| Ligero | 1 | control, observación, radio local, HMG |
| Medio | 2 | taller, hospital de campaña, AA, depósito |
| Pesado | 3 | centro logístico, mantenimiento aéreo, mando regional, Helios avanzado |

Seis espacios admiten seis ligeros, tres medios, dos pesados o una combinación.

## 7. Módulos funcionales

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

## 8. Módulos defensivos

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

## 9. Profundidad del frente

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

## 10. Estados operacionales especiales

| Estado | Consecuencia |
|---|---|
| Aislado | sin construcción pesada; consume reservas y busca salida |
| Cercado | rutas terrestres hostiles; puede conservar aire, mar u ocultas |
| Saliente | protege flancos, reserva y retirada; evita inversión estratégica |
| Cabeza de puente | prioriza refuerzo, ingeniería, control y expansión |
| Zona insurgente | inteligencia, legitimidad y seguridad antes que muros |

## 11. Infraestructura expuesta

La IA no construye logística estratégica en P0 o P1. Puede crear caché, reabastecimiento temporal, depósito oculto, recogida de heridos o reparación de emergencia.

Si un centro existente alcanza el frente, debe evacuar, dispersar, ocultar, convertir, defender temporalmente o destruir. Queda evacuado, abandonado, capturado, dañado o destruido; nunca desaparece sin consecuencia.

## 12. Roles estratégicos

```text
HOLD DELAY FORTRESS STAGING LOGISTICS RESERVE PRODUCTION
GOVERNANCE CIVIL_SUPPORT INTELLIGENCE AIR_OPERATIONS
NAVAL_OPERATIONS HELIOS WITHDRAWAL
```

El rol puede cambiar sin alterar el tipo físico.

## 13. Cálculo de profundidad

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

## 14. Memoria de combate

```text
attacks attackDirections usedConnections enemyTypes observedVehicles
ownCasualties estimatedEnemyCasualties weapons airActivity artillery
sabotage infiltration nightAttacks lostConvoys breachedPositions
resistanceTime
```

No se usa aprendizaje automático. Las observaciones alimentan memoria estructurada, decaimiento temporal y reglas explicables.

## 15. Perfil y vectores de amenaza

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

## 16. Orientación defensiva

La selección considera enemigo, conexión, carretera, alturas, vegetación, línea de visión, edificios, costa y retirada.

| Destino | Capacidad inicial |
|---|---:|
| Frente principal | 45 % |
| Frente secundario | 25 % |
| Seguridad interior | 15 % |
| Reserva y retirada | 15 % |

Doctrina, terreno y experiencia modifican esos pesos.

## 17. Respuesta a amenazas

| Amenaza | Respuesta |
|---|---|
| Blindados | AT, obstáculos, embudos, minas y reserva móvil |
| Infantería | HMG, iluminación, patrullas y fuego cruzado |
| Aire | AA, dispersión, camuflaje, refugios y señuelos |
| Artillería | dispersión, movilidad, refugios y alternativas |
| Insurgencia | inteligencia, cooperación, accesos y patrullas |
| Sabotaje | guardia técnica, redundancia, inspección y trabajadores |

## 18. Doctrinas de construcción

- **Azul:** observación, inteligencia, modularidad, movilidad, QRF y AA.
- **Rojo:** profundidad, obstáculos, blindados, artillería y reservas.
- **Verde gubernamental:** carreteras, bases y defensa institucional.
- **Verde soberanista:** emboscada, demolición, altura y retirada.
- **Verde reformista:** protección civil, corredores y mando compartido.
- **FIA:** escondites, depósitos, observación, rutas, clínicas y talleres ocultos.
- **Meridian:** sensores, accesos restringidos, refugios y posiciones interiores.

FIA solo construye puestos convencionales al controlar abiertamente territorio. Meridian no crea líneas territoriales en Altis.

## 19. Evolución estructural

| Transición | Requisitos |
|---|---|
| 0 → 1 | control, conexión, guarnición, recursos y tiempo |
| 1 → 2 | estabilidad, ingeniería, suministro, función y pausa de combate |
| 2 → 3 | importancia, conexiones, recursos, infraestructura, mando y seguridad |
| 3 → 4 | tipo, rol, inversión, conexión, control, espacio y estabilidad/coerción |

Un P0 no evoluciona normalmente a nivel 4, aunque puede contener una fortaleza ya existente.

## 20. Fortificación independiente

```text
FORT_0 UNPREPARED
FORT_1 LIGHT_POSITIONS
FORT_2 ORGANIZED_DEFENSE
FORT_3 DEFENSE_IN_DEPTH
FORT_4 FORTIFIED_COMPLEX
```

Una aldea estructural 1 puede alcanzar fortificación 3 sin obtener hospital, administración ni gran logística.

## 21. Ciclo de construcción

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

## 22. Puntuación

```text
score =
    strategicNeed + roleCompatibility + threatCompatibility
  + doctrineCompatibility + resourceAvailability + regionalUtility
  - vulnerability - cost - time - frontIncompatibility - civilImpact
```

Un taller pesado en P0 queda rechazado. Una posición AT frente a ataques blindados repetidos gana prioridad.

## 23. Prioridades del jugador

```text
DEFENSE LOGISTICS ANTI_TANK ANTI_AIR MEDICAL
INTELLIGENCE CIVIL_SUPPORT
```

Son pesos, no órdenes de colocación. Si el jugador pide logística en P0, el sistema puede crear una caché y recomendar el centro en P2.

El mando puede aceptar, reducir o rechazar una prioridad incompatible según autoridad. Toda excepción conserva el riesgo registrado.

## 24. Fases visibles

| Fase | Actividad |
|---|---|
| Preparación | ingenieros, limpieza y materiales |
| Estructura | barreras, tiendas, cajas y generadores |
| Equipamiento | armas, comunicaciones y herramientas |
| Operación | personal, suministro y conexión |

Combate, captura, escasez o retirada pueden detener, dañar o abandonar el proceso.

## 25. Infraestructura, composiciones y anclajes

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

## 26. Validación del terreno

Se comprueban pendiente, colisiones, edificios, carretera, agua, altura, línea de visión, distancia civil, espacio vehicular, navegación IA, vegetación y rendimiento.

Ante fallo se prueba otro anclaje, otra composición o menor tamaño; después se cancela y registra el diagnóstico.

## 27. Captura y consolidación

| Estado | Definición |
|---|---|
| C0 — Contacto | entrada enemiga |
| C1 — Disputa | presencia capaz de desafiar |
| C2 — Ruptura | pérdida de puntos esenciales |
| C3 — Aseguramiento | centro, rutas y posiciones dominadas |
| C4 — Consolidación | guarnición, limpieza, conexión e inventario |
| C5 — Estabilización | actividad política, social y económica |

Captura militar no concede automáticamente producción, legitimidad, apoyo civil, acceso Helios ni uso de instalaciones.

## 28. Puntos esenciales

| Tipo | Puntos |
|---|---|
| Pueblo | municipio, acceso vial y guarnición |
| Puerto | muelles, almacenes y costa |
| Aeródromo | pista, torre, hangares y AA |
| Base | mando, depósitos, defensa y acceso |
| Helios | instalación, energía, comunicaciones y credenciales |

## 29. Módulos capturados

```text
INTACT DAMAGED DISABLED SABOTAGED DESTROYED
CAPTURED EVACUATED
```

El nuevo propietario puede reparar, convertir, desmontar, saquear o destruir. La conversión requiere técnicos, limpieza, munición, comunicaciones y, cuando proceda, nueva composición visual.

## 30. Producción

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

## 31. Guarniciones y presión de personal

```text
requiredGarrison =
    sectorBaseValue + frontalThreat + infrastructureValue
  + insurgencyRisk - regionalSupport - personnelShortage
```

P0 concentra línea, observación, AT y control; P1 añade reserva, mortero y QRF; P2 protege apoyo, artillería y logística; P3/P4 enfatizan seguridad interior.

Un sector sin guarnición puede sufrir sabotaje, perder módulos o cambiar autoridad. Cada soldado en una carretera deja de estar disponible para una ofensiva.

## 32. Líneas defensivas

Una defensa coherente combina:

- línea principal: contacto y puntos fuertes;
- línea secundaria: reservas, artillería, sanidad y logística;
- retaguardia: depósitos, mando, entrenamiento y producción.

La IA identifica fortalezas, huecos, salientes, cuellos de botella y cercos.

## 33. Corredores principales

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

## 34. Matriz de los 38 sectores

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

## 35. Ejemplos del corredor Azul

### Katalaki

Comienza estructural 0, fortificación 0–1, P0 y `BEACHHEAD`. Tras el desembarco crea mando, comunicaciones, observación y perímetro. Solo alcanza nivel 2 si Neochori está seguro, existe descarga, las alturas no dominan y llegan ingenieros. Cuando el frente se aleja puede ser logística marítima.

### Neochori

Como pueblo máximo 3 admite seis espacios funcionales y cuatro defensivos. En P0 usa mando, comunicaciones, ingeniería, estabilización, control vial, AT hacia Stavros, observación y retirada. En P2 añade depósito medio, reparación, hospital y distribución.

### Stavros–Whiskey

Base máxima 4 y +2 defensivos. Capturada en P0 se limpia, repara y orienta hacia Lakka; no se convierte de inmediato en centro logístico.

### Lakka

Cruce máximo 3. En P0 prioriza control, AT, observación, guarnición y mortero. En P2 funciona como reserva, distribución, taller ligero y mando.

### Airport West

En primera línea dispersa hangares, evacua combustible, limita aeronaves y degrada mantenimiento. En P2/P3 activa operaciones aéreas, logística, hospital, mando, depósitos y Helios. Pista capturada no equivale a pista operativa.

## 36. IA, Helios y Argos

- Ward separa entrada, distribución y mando.
- Hale favorece QRF y concentración avanzada.
- Navid convierte Sofia en profundidad de Molos.
- Vahid prioriza mecanizados, artillería y obstáculos.
- Varos construye líneas sucesivas.

Helios mejora detección, predicción, distribución, orientación y energía, pero no construye. Argos puede exagerar vectores, ocultar sabotaje o recomendar posiciones peligrosas. La divergencia entre ataques reales y defensas construidas puede ser evidencia.

## 37. Movimiento del frente

De P3 a P1: revisar módulos, evacuar vulnerables, fortificar, reducir producción, desplazar civiles y reservas, elegir línea y actualizar composiciones.

De P0 a P2: desmontar posiciones innecesarias, conservar defensas útiles, activar reparación y logística, restablecer servicios, reducir guarnición frontal y crear reserva regional.

## 38. Evacuación

```text
ACTIVE PACKING EVACUATING RELOCATING ABANDONED
CAPTURED DESTROYED
```

Comunicaciones, hospitales de campaña, talleres ligeros, munición y personal son trasladables. Hangares, centrales, pistas, edificios, depósitos subterráneos y HELIOS-0 no lo son con facilidad.

## 39. Consecuencias civiles

Captura, fortificación y profundidad del frente alimentan seguridad y daño; no conceden gobierno ni legitimidad. La transición de control militar a autoridad efectiva se rige por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md).

Fortificar una ciudad modifica tráfico, comercio, vivienda, legitimidad y daño esperado. Autoridades nacionales, municipales y civiles pueden oponerse a módulos. Defender, evacuar, destruir, fortificar o declarar abierta una ciudad son decisiones militares y políticas.

## 40. Estado lógico de módulo

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

## 41. Modelo territorial ampliado

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

## 42. Funciones conceptuales

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

## 43. Rendimiento y materialización

| Zona | Evaluación |
|---|---|
| Frente activo | 30–90 s |
| Segunda línea | 2–4 min |
| Interior | 5–10 min |

Se fuerza evaluación ante cambio de propietario, ataque mayor, caída de conexión o nodo, oleada o ruptura de alianza.

No se revisan 38 sectores cada segundo ni se materializan todas las bases. Los módulos lejanos son datos y aparecen cerca del jugador, en misión, bajo ataque o en cinemática.

Una composición usa propietario, estado, condición, daño, personal y suministro. Un módulo al 45 % no renace intacto.

## 44. Vertical slice

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

## 45. Pruebas obligatorias

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

## 46. Prohibiciones

No se permite logística pesada en P0/P1, orientación uniforme, bases idénticas, módulos teleportados, nivel 4 indiscriminado, construcción sin recursos, producción plena bajo ataque, guarniciones infinitas, respuesta puramente militar a insurgencia, olvido de combates, bloqueo de rutas IA, materialización lejana, reconstrucción inmediata ni control completo al capturar una bandera.

Helios tampoco decide ni actúa sin operadores.

## 47. Principios vinculantes

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

## 48. Definición final

El territorio no es una colección de círculos que cambian de color. Cada sector posee identidad, capacidad, función, población, conexiones, memoria y posición dentro del frente.

Una línea defensiva no es una fila de armas: relaciona puestos, reservas, carreteras, hospitales, talleres, depósitos y rutas de retirada. Cuando el frente se mueve, la infraestructura debe adaptarse o convertirse en botín.

## 49. Siguiente contrato técnico

El catálogo técnico de módulos y composiciones 3DEN queda definido en [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md). El siguiente contrato es el sistema económico y logístico completo.
