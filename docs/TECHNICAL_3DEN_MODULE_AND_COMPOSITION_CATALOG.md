# Catálogo técnico de módulos y composiciones 3DEN

> **Estado:** contrato rector de producción y balance previo a construir la biblioteca.  
> **Motor:** Arma 3 2.18.  
> **Dependencia obligatoria:** juego base.  
> **Perfiles opcionales:** DLC oficiales y paquetes de mods.  
> **Autoridad territorial:** [TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md](TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md).  
> **Persistencia:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).  
> **Costes y recursos:** [ECONOMIC_AND_LOGISTICS_SYSTEM.md](ECONOMIC_AND_LOGISTICS_SYSTEM.md).

## 1. Propósito

Este catálogo transforma capacidades territoriales en composiciones producibles. Define función, coste, recursos, tiempo, personal, profundidades permitidas, sectores compatibles, objetos candidatos, variantes, anclajes, orientación, daño, materialización y validación.

El contrato sirve al diseño 3DEN, sistema territorial, IA estratégica, persistencia, logística, guarniciones y pruebas.

## 2. Principio

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

## 3. Flujo técnico

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

## 4. Orientación

No se aplican `setDir` y `setVectorDirAndUp` al mismo objeto dentro del mismo ajuste. Para pendientes se conserva la orientación exportada y se transforma una sola vez.

| Modo | Aplicación |
|---|---|
| `FACE_THREAT` | AT, HMG, observación, búnker y costa |
| `ALIGN_ROAD` | controles, barreras e inspección |
| `ALIGN_COAST` | costa, muelle y observación naval |
| `ALIGN_RUNWAY` | aire, reparación y estacionamiento |
| `ALIGN_BUILDING` | mando, administración, sanidad e inteligencia |
| `FIXED_SITE` | HELIOS-0, PHAROS, hangares y centros estratégicos |

## 5. Perfiles visuales

### Azul

```text
Land_Cargo_House_V1_F Land_Cargo_HQ_V1_F
Land_Cargo_Patrol_V1_F Land_Cargo_Tower_V1_F
Land_Medevac_house_V1_F Land_Medevac_HQ_V1_F
CamoNet_BLUFOR_F CamoNet_BLUFOR_open_F
Land_Cargo10_military_green_F Land_Cargo20_military_green_F
```

### Rojo

```text
Land_Cargo_House_V3_F Land_Cargo_HQ_V3_F
Land_Cargo_Patrol_V3_F Land_Cargo_Tower_V3_F
CamoNet_OPFOR_F CamoNet_OPFOR_open_F
Land_Cargo10_sand_F Land_Cargo20_sand_F
```

### Verde

```text
Land_Cargo_House_V2_F Land_Cargo_HQ_V2_F
Land_Cargo_Patrol_V2_F Land_Cargo_Tower_V2_F
CamoNet_INDP_F CamoNet_INDP_open_F
Land_Cargo10_military_green_F Land_Cargo20_military_green_F
```

### FIA

Reutiliza edificios, almacenes, sacos, redes y material Verde capturado. No posee una arquitectura uniforme.

### Meridian

Mezcla estructuras V1/V3 y redes BLUFOR/OPFOR para mostrar proveedores diferentes. No utiliza una paleta homogénea.

## 6. Familias de fortificación

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

## 7. Objetos técnicos candidatos

| Función | Clases |
|---|---|
| Iluminación | `Land_PortableLight_single_F`, `Land_PortableLight_double_F` |
| Energía | `Land_PowerGenerator_F` |
| Comunicaciones | `Land_Communication_F`, `Land_Radar_Small_F`, `Land_Radar_F` |
| Reparación | `Land_CarService_F`, `Land_Workbench_01_F`, `Land_EngineCrane_01_F`, `Land_DieselGroundPowerUnit_01_F` |
| Almacenamiento | `Land_Cargo10_*`, `Land_Cargo20_*`, `Land_Cargo40_*` |

Una clase oficial no se presume automáticamente disponible en el perfil básico: `requiredAddons`, licencia y sustituto deben quedar registrados.

## 8. Cajas por facción

| Perfil | Familias |
|---|---|
| Azul | `Box_NATO_Ammo_F`, `Wps`, `WpsLaunch`, `Support`, `AmmoVeh`, `AmmoOrd`, `Grenades` |
| Rojo | `Box_East_Ammo_F`, `Wps`, `WpsLaunch`, `Support`, `AmmoVeh`, `AmmoOrd`, `Grenades` |
| Verde | `Box_IND_Ammo_F`, `Wps`, `WpsLaunch`, `Support`, `AmmoVeh`, `AmmoOrd`, `Grenades` |
| FIA | `Box_Ammo_F`, `Box_Wps_F`, `Land_Box_AmmoOld_F` |

Los nombres abreviados de la tabla representan la clase completa con el prefijo de su facción.

## 9. Armas estáticas

| Perfil | HMG/GMG | Mortero | AT/AA |
|---|---|---|---|
| Azul | `B_HMG_01_*`, `B_GMG_01_*` | `B_Mortar_01_F` | `B_static_AT_F`, `B_static_AA_F` |
| Rojo | `O_HMG_01_*`, `O_GMG_01_*` | `O_Mortar_01_F` | `O_static_AT_F`, `O_static_AA_F` |
| Verde | `I_HMG_01_*`, `I_GMG_01_*` | `I_Mortar_01_F` | `I_static_AT_F`, `I_static_AA_F` |
| FIA | `B_G_HMG_02_*` o `I_G_HMG_02_*` | `B_G_Mortar_01_F` o `I_G_Mortar_01_F` | captura o equipo portátil |

La proyección técnica FIA depende del lado de la misión, no cambia su identidad persistente.

## 10. Recursos de construcción

```text
CONSTRUCTION ELECTRONICS AMMUNITION FUEL MEDICAL PERSONNEL
```

`PERSONNEL` representa dotación asignada, no consumo permanente. Piezas de repuesto pertenecen a los costes de reparación y mantenimiento aunque se presenten separadas en las fichas.

## 11. Escala de costes

| Clase | Capacidad | Construcción | Tiempo | Personal |
|---|---:|---:|---:|---:|
| Ligero | 1 | 10–25 | 2–8 h | 2–6 |
| Medio | 2 | 30–70 | 8–24 h | 6–16 |
| Pesado | 3 | 80–160 | 1–4 días | 15–40 |
| Estratégico | 4+ | 180–400 | 4–12 días | 30–100 |

Los estratégicos reutilizan normalmente infraestructura existente.

## 12. Modificadores de tiempo

| Factor | Multiplicador |
|---|---:|
| Ingenieros completos/parciales/insuficientes | ×1,00 / ×1,35 / ×2,00 |
| Sin ingenieros | bloqueado |
| P0/P1/P2/P3/P4 | ×1,80 / ×1,40 / ×1,10 / ×1,00 / ×0,90 |
| Ataque ocasional/hostigamiento/directo | ×1,25 / ×1,60 / suspendido |
| Edificio reutilizable/dañado/nuevo | ×0,55 / ×0,80 / ×1,00 |
| Estabilidad alta/media/baja/colapso | ×0,90 / ×1,00 / ×1,30 / ×1,80 o bloqueo |

## 13. Catálogo funcional

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

## 14. Reglas funcionales específicas

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

## 15. Activos funcionales característicos

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

## 16. Catálogo defensivo

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

## 17. Reglas defensivas específicas

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

## 18. Dotación

| Staffing | Efecto |
|---:|---|
| 100 % | capacidad completa |
| 60–99 % | operación reducida |
| 25–59 % | función mínima |
| 1–24 % | presencia simbólica |
| 0 % | abandonado |

Una AA sin operador existe y puede capturarse, pero no aporta defensa.

## 19. Etiquetas de terreno

```text
FLAT_OPEN ROAD_EDGE URBAN_DENSE URBAN_OPEN
RURAL_COMPOUND FOREST_EDGE HILL_LOW HILL_HIGH
COAST INDUSTRIAL AIRFIELD EXISTING_BUILDING
```

Solo se producen variantes que tengan función y espacio plausibles.

## 20. Pendientes

| Uso | Recomendada | Máxima |
|---|---:|---:|
| Vehículo pesado | 0–5° | 8° |
| Vehículo ligero | 0–8° | 12° |
| Infantería/búnker ligero | 0–12° | 18° validada |

Observación puede superar estos rangos con acceso peatonal y prueba de ocupación.

## 21. Anclajes

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

## 22. Puntos internos

```text
POINT_ENTRY POINT_EXIT POINT_GUARD_01 POINT_GUARD_02
POINT_WEAPON_01 POINT_WEAPON_02 POINT_AMMO POINT_INTERACTION
POINT_VEHICLE_01 POINT_COVER POINT_MEDICAL POINT_COMMAND
```

Pueden ser lógicas o posiciones relativas; no tienen que ser visibles.

## 23. Circulación

| Usuario | Mínimo | Recomendado |
|---|---:|---:|
| Infantería | 1,2 m | 1,8 m |
| Vehículo ligero | 3,5 m | 4,5 m |
| Camión/blindado | 5,5 m | 7 m |

Un pesado necesita giro o salida independiente. Ninguna composición depende de retroceder por un callejón estrecho.

## 24. Presupuesto de objetos

| Escala | Objetos | Ejemplos |
|---|---:|---|
| Micro | 6–15 | observación, caché, HMG |
| Pequeña | 16–35 | control, médico, AT |
| Media | 36–70 | guarnición, punto fuerte, taller |
| Grande | 71–120 | mando regional, hospital, depósito |
| Estratégica | 121–220 | aeropuerto, Helios y gran base |

Una estratégica se divide en subcomposiciones materializables.

## 25. Simulación y objetos simples

Conservan simulación: armas, cajas usadas, puertas, luces, generadores interactivos, objetos destructibles, inventarios y vehículos.

Pueden ser simples: decoración, palés, cajas vacías, sacos sin función, mobiliario, señales y restos.

Nada se simplifica si debe dañarse, abrirse, moverse, animarse o guardar inventario.

## 26. Daño

| Estado | Condición | Representación |
|---|---:|---|
| `INTACT` | 90–100 % | completo |
| `DAMAGED` | 40–89 % | secundarios omitidos, barreras y armas parciales |
| `CRITICAL` | 1–39 % | función mínima, restos y abandono probable |
| `DESTROYED` | 0 % | ruina, función anulada y salvamento |

`badChance` solo puede omitir decoración, palés, sacos secundarios, redes y mobiliario. Nunca elimina edificio, arma, acceso, ruta, generador o interacción esencial.

## 27. Esquema de composición

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

## 28. Nomenclatura y capas

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

## 29. Estados de validación

```text
DRAFT PLACEMENT_OK PATHING_OK WEAPON_ARCS_OK COMBAT_OK
DAMAGE_OK MATERIALIZATION_OK PERSISTENCE_OK PERFORMANCE_OK RELEASED
```

Solo `RELEASED` puede seleccionarse en una campaña publicada.

## 30. Pruebas de IA y combate

Infantería debe entrar, salir, ocupar, usar armas, responder y retirarse.

Vehículos deben entrar, estacionar, girar, salir y alcanzar la ruta. La QRF no queda atrapada ni atropella sistemáticamente a la guarnición.

Cada defensa se prueba contra infantería frontal, flanco, ligero, blindado, fuego indirecto, noche y retirada. No necesita ganar; necesita comportarse coherentemente.

## 31. Pruebas urbanas y frente móvil

Se validan tráfico, puertas, ventanas, peatones, civiles, líneas de fuego, daño, medicina y evacuación. No se bloquea una ciudad por estética.

Una composición puede quedar detrás del frente, reducir guarnición, cambiar función, evacuarse, capturarse o destruirse. Un AT puede convertirse en observación, seguridad, caché o abandono.

## 32. Conversión de facción

Una captura intacta conserva estructuras y barreras, pero cambia armas, cajas, señalización, personal y comunicaciones.

- conversión rápida: control, HMG, caché y puesto;
- lenta: mando, taller, inteligencia, Helios y aviación;
- con especialista: radar, cifrado, mantenimiento aéreo y nodo Helios.

## 33. FIA

| Composición | Objetos | Regla |
|---|---:|---|
| Escondite rural | 8–18 | sin bandera, salida secundaria |
| Depósito clandestino | 6–15 | edificio y materiales civiles |
| Clínica clandestina | edificio existente | 2–6 sanitarios, sin defensa pesada |
| Puesto abierto | variable | solo con control territorial |

Una red FIA no parece una FOB NATO camuflada.

## 34. Meridian

- acceso externo con apariencia Verde o militar convencional;
- anillo de sensores, controles y barreras;
- PHAROS con detención, archivo, técnicos y comunicaciones;
- HELIOS-CORE sobre infraestructura canónica;
- evacuación Argos con helipuerto, vehículos, rutas y destrucción de archivos.

## 35. Biblioteca mínima

### Azul

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

### Verde

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

## 36. Compatibilidad y clases

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

## 37. Funciones conceptuales

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

## 38. Selección

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

## 39. Explicabilidad

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

## 40. Fuentes técnicas oficiales

- [BIS_fnc_objectsMapper](https://community.bohemia.net/wiki/BIS_fnc_objectsMapper)
- [BIS_fnc_objectsGrabber](https://community.bohemia.net/wiki/BIS_fnc_objectsGrabber)
- [setVectorDirAndUp](https://community.bohemia.net/wiki/setVectorDirAndUp)
- [Eden Editor: Custom Composition](https://community.bohemia.net/wiki/Eden_Editor%3A_Custom_Composition)
- [CfgVehicles Structures](https://community.bohemia.net/wiki/Arma_3%3A_CfgVehicles_Structures)
- [CfgVehicles Equipment](https://community.bohemia.net/wiki/Arma_3_CfgVehicles_Equipment)

## 41. Principios vinculantes

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

## 42. Definición final

La estrategia selecciona la necesidad. El sistema territorial decide si está permitida y financiada. El catálogo ofrece una solución visual validada. El terreno decide qué variante puede existir.

Una fortificación es buena cuando la guarnición puede ocuparla, disparar, recibir suministros, retirarse y recuperarla después de cargar la campaña.

## 43. Siguiente contrato

El sistema económico y logístico rector queda definido en [ECONOMIC_AND_LOGISTICS_SYSTEM.md](ECONOMIC_AND_LOGISTICS_SYSTEM.md). El siguiente paso es la arquitectura de implementación y pruebas del vertical slice integrado.
