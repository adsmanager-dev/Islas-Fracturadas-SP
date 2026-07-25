# Campaña estratégica y sistema territorial

> **Estado del contenedor:** diseño confirmado y diseño en desarrollo
> **Fuente de verdad para:** geografía operacional y sistema estratégico territorial
> **Relacionados:** [09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md); [11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-07-25

## Propósito

Centralizar geografía operacional y sistema estratégico territorial sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [ALTIS GEOGRAPHY AND SECTOR MAP](#fuente-altis-geography-and-sector-map)
- [STRATEGIC CAMPAIGN SYSTEM](#fuente-strategic-campaign-system)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md`, `STRATEGIC_CAMPAIGN_SYSTEM.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

## Contenido consolidado

<a id="fuente-altis-geography-and-sector-map"></a>
## Fuente integrada: `ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md`

> **Procedencia:** contenido migrado de `ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.
> **Clasificación de fuente integrada:** `DISEÑO_CONFIRMADO` para regiones, funciones y arquitectura de 38 sectores; coordenadas, límites, rutas y anclajes permanecen `POR_CALIBRAR` hasta recibir `VALIDADO_3DEN` conforme a `DEC-006`.

<a id="src-altis-geography-and-sector-map--altis-geografía-operacional-y-mapa-inicial-de-sectores"></a>
### Altis — Geografía operacional y mapa inicial de sectores

> Documento de diseño territorial. Traduce el terreno real de Altis a regiones, sectores, corredores, nodos y cabezas de playa para *Islas Fracturadas*.

La función cultural, económica y social de estas regiones se define en [ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md](02_STORY_BIBLE_AND_WORLD_HISTORY.md#fuente-altis-stratis-history-culture-and-economy). Sus niveles, módulos, profundidad de frente y construcción se rigen por el [sistema territorial](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-territorial-sector-front-and-construction-system). La selección de coordenadas, límites, rutas, anclajes y criterios de aprobación física se rige por [THREEDEN_GEOGRAPHY_AND_PHYSICAL_VALIDATION_GUIDE.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide).

<a id="src-altis-geography-and-sector-map--1-estado-del-documento"></a>
#### 1. Estado del documento

Este documento fija la primera arquitectura territorial completa de la campaña.

Se consideran decisiones de diseño adoptadas:

* la guerra principal ocurre en Altis durante el verano;
* el terreno no se divide mediante una cuadrícula uniforme;
* Azul desembarca principalmente en Katalaki Bay–Neochori;
* Rojo desembarca principalmente en Molos Bay–Molos Airfield;
* Verde comienza dominando el centro, Pyrgos y las conexiones interiores;
* el aeropuerto internacional es el corazón operacional;
* Pyrgos es la bisagra política;
* Kavala es la bisagra social e insurgente;
* HELIOS-0 nació junto al aeropuerto y Stratis oculta después la continuidad avanzada;
* la campaña completa parte de 38 sectores estratégicos;
* el primer vertical slice utiliza el corredor Katalaki–Neochori–AAC–Airport West.

Las posiciones exactas, límites de sector, capacidad de muelles, circulación de IA, emplazamientos de composiciones e identificadores de objetos siguen pendientes de validación en 3DEN y mediante `CfgWorlds`.

> **Decisión `DEC-006`:** los 38 sectores son `DISEÑO_CONFIRMADO`, no `VALIDADO_3DEN`. Ninguna coordenada, frontera, ruta o anclaje pasa a configuración definitiva sin evidencia física de editor y motor.

<a id="src-altis-geography-and-sector-map--2-principio-territorial"></a>
#### 2. Principio territorial

Altis ya contiene una estructura estratégica natural:

| Área | Terreno dominante | Función de campaña |
|---|---|---|
| Oeste | ciudades densas, montañas y accesos estrechos | política local, población, FIA e insurgencia |
| Noroeste | colinas, bosques, valles y carreteras escasas | guerrilla, observación, energía y refugios |
| Centro | aeropuerto, cruces y llanuras | movilidad, logística y convergencia militar |
| Este | espacios abiertos y rutas largas | maniobra mecanizada y logística Roja |
| Nordeste | península y corredor terrestre vulnerable | cabeza de playa y base aérea Roja |
| Sur y sudeste | capital, puertos, energía y grandes distancias | Gobierno, reservas y frente meridional |

El centro de gravedad territorial no es una sola ciudad. Lo forma el sistema **Altis International Airport–Telos–Gravia–Rodopoli–Lakka**, que articula el tránsito oeste-este y norte-sur.

<a id="src-altis-geography-and-sector-map--3-base-geográfica"></a>
#### 3. Base geográfica

Altis posee aproximadamente 268,65 km², 32 poblaciones según la clasificación oficial, tres lagos estacionales y una costa dominada fuera de sus bahías por rocas y acantilados. Thronos, con unos 350 metros, es su elevación principal.

Durante el verano, Limni, Ochrolimni y Almyra permanecen secos. Sus superficies abiertas pueden habilitar rutas o usos temporales, pero ofrecen poca cobertura.

El noroeste favorece infantería, exploradores, emboscadas y observación. Las llanuras orientales y meridionales favorecen carros, columnas mecanizadas, reconocimiento aéreo y fuego de largo alcance. Las playas y bahías viables son recursos estratégicos: no todo el litoral admite desembarcos ni logística pesada.

<a id="src-altis-geography-and-sector-map--4-regiones-operacionales"></a>
#### 4. Regiones operacionales

La división regional es una interpretación de diseño, no una división administrativa de Arma 3.

| Código | Región | Lugares principales | Función |
|---|---|---|---|
| R1 | Kavala occidental | Kavala, Kastro, Aggelochori, Neri, Panochori | oposición política, población, puerto y guerra urbana |
| R2 | Montañas del noroeste | Oreokastro, Abdera, Galati, Syrta, Thronos | guerrilla, observación, energía y refugios |
| R3 | Corredor de Agios Dionysios | Kore, Topolia, Agios Dionysios, Lakka | paso decisivo entre oeste y centro |
| R4 | Katalaki–Neochori | Katalaki Bay, Neochori, Stavros, FOB Whiskey | cabeza de playa Azul y puerta al aeropuerto |
| R5 | Cuenca suroccidental | Poliakko, Therisa, Zaros, AAC, Xirolimni | logística ligera, agua, agricultura y flanqueo |
| R6 | Centro aeroportuario | Airport, Gravia, Telos, Anthrakia | corazón operacional de Altis |
| R7 | Norte central | Athira, Frini, Agia Triada, Kalithea | reservas, comunicaciones y flanco norte |
| R8 | Llanura oriental | Rodopoli, Kalochori, Paros, Ioannina, Delfinaki, Sofia | maniobra y línea logística Roja |
| R9 | Península de Molos | Molos, aeródromo, Galana Nera y bahías | entrada Roja y corredor vulnerable |
| R10 | Pyrgos y sudeste | Pyrgos, Charkia, Dorida, Chalkeia, Feres, Selakano | Gobierno, reservas, puertos y energía |

<a id="src-altis-geography-and-sector-map--5-puntos-de-gravedad-regionales"></a>
#### 5. Puntos de gravedad regionales

<a id="src-altis-geography-and-sector-map--kavala-y-el-oeste"></a>
##### Kavala y el oeste

Kavala es el principal centro social y opositor. Su valor procede de la población, los archivos, las redes civiles, FIA y el contrabando, no de funcionar como puerto militar pesado.

No será la cabeza de playa principal Azul. Es más apropiada para bloqueos, sabotajes, evacuaciones, contactos clandestinos, levantamientos y batallas tardías por distritos. Kavala debe subdividirse y activarse por áreas para proteger rendimiento y permitir resultados parciales.

Agios Dionysios, Kore, Topolia y Lakka controlan la salida de Kavala hacia el centro. Aislar este corredor puede neutralizar la ciudad sin ocupar cada barrio.

<a id="src-altis-geography-and-sector-map--noroeste-montañoso"></a>
##### Noroeste montañoso

Oreokastro, Abdera, Galati, Syrta y Thronos forman el espacio principal de guerra irregular rural. La región puede albergar comunidades soberanistas, antiguos soldados Verdes, puestos de observación, depósitos ocultos, repetidores y células de FIA.

Favorece minas, emboscadas, tiradores, helicópteros y control de alturas; penaliza columnas blindadas y convoyes largos.

<a id="src-altis-geography-and-sector-map--katalaki-neochori-y-stavros"></a>
##### Katalaki, Neochori y Stavros

Katalaki Bay–Neochori será la entrada principal Azul. Su posición permite establecer una base antes de combatir en una gran ciudad, conectar con AAC Airfield y avanzar hacia el aeropuerto.

Neochori controla la supervivencia logística de la playa. Stavros y el antiguo FOB Whiskey constituyen la primera posición Verde importante y pueden cambiar de manos durante la campaña.

<a id="src-altis-geography-and-sector-map--cuenca-de-zaros-y-aac"></a>
##### Cuenca de Zaros y AAC

AAC Airfield será una instalación avanzada para helicópteros, drones, evacuación, logística y aeronaves ligeras; no una gran base de cazas. Xirolimni, Poliakko, Therisa y Zaros ofrecen agua, agricultura, rutas secundarias, sabotaje e insurgencia.

<a id="src-altis-geography-and-sector-map--aeropuerto-internacional"></a>
##### Aeropuerto internacional

El aeropuerto proporciona acceso potencial a transporte pesado, ala fija, reconocimiento y refuerzos. Capturar la pista no lo vuelve operativo. Requiere:

1. control físico;
2. pista utilizable;
3. combustible y mantenimiento;
4. seguridad aérea;
5. comunicaciones;
6. accesos terrestres seguros.

Se divide en hangares y base occidental, pista y terminal, complejo militar oriental, accesos de Gravia y nudo de Telos.

<a id="src-altis-geography-and-sector-map--athira-y-norte-central"></a>
##### Athira y norte central

Athira funciona como mando regional, reserva Verde y enlace entre el aeropuerto, la costa norte y el oeste montañoso. Agia Triada y Kalithea permiten infiltración, contrabando y embarcaciones ligeras, no logística pesada.

<a id="src-altis-geography-and-sector-map--llanura-oriental"></a>
##### Llanura oriental

La arteria Telos–Rodopoli–Kalochori–Sofia favorece la doctrina mecanizada Roja, pero crea una línea de suministro visible y vulnerable. Almyra puede ofrecer rutas temporales o emplazamientos móviles a costa de cobertura.

Ghost Hotel se reserva como ubicación táctica singular para operaciones narrativas, clandestinas o de combate cercano; no será un sector económico genérico.

<a id="src-altis-geography-and-sector-map--molos-y-sofia"></a>
##### Molos y Sofia

Molos Bay–Molos Airfield será la entrada principal Roja. Su aeródromo y playas facilitan el despliegue, mientras que la península obliga a proteger el corredor de Sofia.

Perder Sofia o el istmo puede aislar a Rojo. Pefkas Bay y Galana Nera proporcionan entradas secundarias limitadas, no una duplicación automática de la capacidad principal.

<a id="src-altis-geography-and-sector-map--pyrgos-y-sudeste"></a>
##### Pyrgos y sudeste

Pyrgos conserva el Gobierno, los ministerios, los archivos públicos y la legitimidad institucional. Su captura cambia la política nacional, pero no entrega automáticamente Kavala, el aeropuerto, Molos, FIA, Verde ni Stratis.

El eje Pyrgos–Dorida–Feres es largo y vulnerable. Feres, Selakano y Mazi sostienen energía, reservas y operaciones desconectadas en el sur.

<a id="src-altis-geography-and-sector-map--6-arquitectura-inicial-de-38-sectores"></a>
#### 6. Arquitectura inicial de 38 sectores

Los sectores agrupan objetivos que comparten función estratégica. Las ubicaciones tácticas dentro de ellos se materializan únicamente cuando una misión o el nivel de simulación lo exige.

<a id="src-altis-geography-and-sector-map--oeste-y-kavala"></a>
##### Oeste y Kavala

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_W_KAVALA_PORT` | Kavala Port | puerto |
| `ALT_W_KAVALA_CITY` | Kavala City | urbano y político |
| `ALT_W_AGGELOCHORI` | Aggelochori | urbano y cruce |
| `ALT_W_NERI_PANOCHORI` | Neri–Panochori | rural y clandestino |
| `ALT_W_AGIOS_DIONYSIOS` | Agios Dionysios | paso y defensa |
| `ALT_W_KORE_TOPOLIA` | Kore–Topolia | corredor |

<a id="src-altis-geography-and-sector-map--noroeste"></a>
##### Noroeste

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_NW_OREOKASTRO` | Oreokastro | población y acceso |
| `ALT_NW_ABDERA_GALATI` | Abdera–Galati | rural |
| `ALT_NW_SYRTA` | Syrta | puesto y logística ligera |
| `ALT_NW_THRONOS` | Thronos | altura y observación |
| `ALT_NW_WIND` | Parque eólico del noroeste | energía y comunicaciones |

<a id="src-altis-geography-and-sector-map--centro-occidental"></a>
##### Centro occidental

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_CW_KATALAKI` | Katalaki Bay | playa y logística |
| `ALT_CW_NEOCHORI` | Neochori | población y puerto ligero |
| `ALT_CW_STAVROS_WHISKEY` | Stavros–FOB Whiskey | base y paso |
| `ALT_CW_LAKKA` | Lakka | cruce |
| `ALT_CW_AAC` | AAC Airfield | aeródromo ligero |
| `ALT_CW_POLIAKKO_THERISA` | Poliakko–Therisa | rural y logística |
| `ALT_CW_XIROLIMNI_ZAROS` | Xirolimni–Zaros | agua, energía y rural |

<a id="src-altis-geography-and-sector-map--centro"></a>
##### Centro

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_C_AIRPORT_WEST` | Airport West | hangares y base |
| `ALT_C_AIRPORT_TERMINAL` | Airport Terminal | pista y terminal |
| `ALT_C_AIRPORT_MIL` | Airport Military Complex | militar y Helios |
| `ALT_C_TELOS` | Telos | nudo vial |
| `ALT_C_GRAVIA` | Gravia | acceso y reserva |
| `ALT_C_ATHIRA` | Athira | urbano y mando regional |

<a id="src-altis-geography-and-sector-map--norte-y-centro-oriental"></a>
##### Norte y centro oriental

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_NC_FRINI_AGIA_TRIADA` | Frini–Agia Triada | costa y comunicaciones |
| `ALT_NC_KALITHEA` | Kalithea | costa y ruta |
| `ALT_E_RODOPOLI` | Rodopoli | cruce mecanizado |
| `ALT_E_KALOCHORI_PAROS` | Kalochori–Paros | urbano y logístico |

<a id="src-altis-geography-and-sector-map--nordeste"></a>
##### Nordeste

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_NE_IOANNINA_DELFINAKI` | Ioannina–Delfinaki | rural y acceso |
| `ALT_NE_SOFIA` | Sofia | cuello de botella |
| `ALT_NE_PEFKAS` | Pefkas Bay | playa secundaria |
| `ALT_NE_MOLOS` | Molos | ciudad y puerto |
| `ALT_NE_MOLOS_AIRFIELD` | Molos Airfield | aeródromo y base |

<a id="src-altis-geography-and-sector-map--pyrgos-y-sudeste-1"></a>
##### Pyrgos y sudeste

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_SE_CHARKIA` | Charkia | cruce hacia la capital |
| `ALT_SE_PYRGOS_HARBOUR` | Pyrgos Harbour | puerto |
| `ALT_SE_PYRGOS_GOV` | Pyrgos Government | urbano y político |
| `ALT_SE_DORIDA_CHALKEIA` | Dorida–Chalkeia | corredor |
| `ALT_SE_FERES_SELAKANO` | Feres–Selakano | energía, pista y reserva |

Almyra, Panagia, Feres Airfield y el extremo de Molos podrán separarse en una iteración futura si la simulación necesita más profundidad.

<a id="src-altis-geography-and-sector-map--7-corredores-y-conexiones"></a>
#### 7. Corredores y conexiones

| Código | Corredor | Función |
|---|---|---|
| C1 | Kavala–Agios Dionysios–Lakka–Telos | eje occidental |
| C2 | Katalaki–Neochori–Stavros–Airport | avance y abastecimiento Azul |
| C3 | Zaros–Poliakko–Neochori | flanqueo suroccidental |
| C4 | Athira–Gravia–Airport | reservas del norte |
| C5 | Telos–Rodopoli–Kalochori–Sofia | frente y logística oriental |
| C6 | Sofia–Molos | supervivencia logística Roja |
| C7 | Rodopoli–Charkia–Pyrgos | enlace frente-capital |
| C8 | Pyrgos–Dorida–Feres | eje sudoriental |
| C9 | Pyrgos Gulf y costa central | conexión marítima condicionada |

Las conexiones se guardan como relaciones lógicas `principal`, `secundaria`, `marítima`, `aérea` o `Helios`. No se simula cada metro de carretera. Los convoyes se materializan cerca del jugador o durante una intercepción.

Los estrangulamientos prioritarios para la IA estratégica son Agios Dionysios, Lakka–Stavros, Neochori, Telos, Rodopoli, Sofia, Charkia, Dorida, el acceso occidental a Pyrgos y el istmo de Molos.

<a id="src-altis-geography-and-sector-map--8-despliegues-iniciales"></a>
#### 8. Despliegues iniciales

<a id="src-altis-geography-and-sector-map--azul"></a>
##### Azul

La primera oleada en Katalaki incluye reconocimiento costero, infantería, ingenieros, vehículos ligeros y AZUR-1.

Objetivos iniciales:

1. asegurar la playa;
2. tomar o negociar el acceso a Neochori;
3. abrir la ruta a Stavros;
4. capturar o neutralizar FOB Whiskey;
5. asegurar AAC;
6. preparar el avance hacia el aeropuerto.

Puede ejecutar operaciones secundarias de comandos en Kavala Bay, contacto FIA en Panochori y sabotaje de comunicaciones en Magos.

<a id="src-altis-geography-and-sector-map--rojo"></a>
##### Rojo

La primera oleada en Molos incluye RUBÍ-1, infantería mecanizada ligera, técnicos, enlace gubernamental y defensa aérea inicial.

Objetivos iniciales:

1. asegurar las playas;
2. controlar Molos;
3. tomar el aeródromo;
4. verificar el Protocolo Asterión;
5. abrir la carretera a Sofia;
6. crear un acceso secundario limitado.

Puede reconocer Delfinaki, contactar con Verde en Sofia y recuperar nodos orientales.

La asimetría es intencional: Azul comienza cerca de población, FIA y el aeropuerto; Rojo dispone de mejor punto aéreo y fuerza mecanizada, pero depende de un corredor estrecho.

<a id="src-altis-geography-and-sector-map--9-infraestructura-funcional"></a>
#### 9. Infraestructura funcional

<a id="src-altis-geography-and-sector-map--aeródromos"></a>
##### Aeródromos

| Instalación | Capacidad de diseño |
|---|---|
| Altis International Airport | ala fija, transporte pesado, helicópteros y gran logística |
| AAC Airfield | helicópteros, drones, evacuación y aeronaves ligeras |
| Molos Airfield | ala fija ligera, helicópteros y defensa oriental |
| Feres Airfield | reserva y logística limitada |
| Limni seco | uso temporal o clandestino, sujeto a validación |

Todo aeródromo separa control físico, estado de pista, combustible/mantenimiento y seguridad/comunicaciones.

<a id="src-altis-geography-and-sector-map--puertos"></a>
##### Puertos

Pyrgos Harbour y Kavala son puertos de alto valor, pero su capacidad militar exacta depende de composiciones y pruebas. Neochori, Kalithea, Agia Triada y las calas irregulares se limitan inicialmente a embarcaciones ligeras, infiltración, evacuación y contrabando.

<a id="src-altis-geography-and-sector-map--energía-y-comunicaciones"></a>
##### Energía y comunicaciones

La presa, plantas, parques eólicos, instalaciones solares, antenas, radares y depósitos permiten que energía, comunicaciones y Helios dependan de infraestructura física distribuida.

<a id="src-altis-geography-and-sector-map--10-red-territorial-de-helios"></a>
#### 10. Red territorial de Helios

| Nodo | Zona | Capacidad principal |
|---|---|---|
| H-WEST | Kavala–Magos | comunicaciones y señales occidentales |
| H-AAC | AAC–Neochori | aviación de emergencia y logística |
| H-DAM | Xirolimni | agua e infraestructura crítica |
| H-CENTRAL | aeropuerto internacional / HELIOS-0 | red visible, fusión operacional y movilidad |
| H-NORTH | Athira–Frini | repetición y seguimiento terrestre |
| H-EAST | Sofia–Molos | radar y navegación oriental |
| H-ALMYRA | Almyra–Delfinaki | sensores y rutas mecanizadas |
| H-GOV | Pyrgos | administración y continuidad |
| H-SOUTH | Feres–Selakano–Mazi | energía y resiliencia desconectada |
| H-CORE | S-26, Stratis | HELIOS-CORE, PHAROS, archivos y validación Argos |

Cada nodo entrega capacidades parciales. HELIOS-CORE necesita la red visible de Altis y ningún nodo proporciona por sí solo control total de Helios.

<a id="src-altis-geography-and-sector-map--11-vertical-slice-territorial"></a>
#### 11. Vertical slice territorial

La primera porción jugable se limita a:

1. Katalaki Bay;
2. Neochori;
3. Stavros;
4. FOB Whiskey;
5. Lakka;
6. AAC Airfield;
7. Poliakko;
8. Airport West;
9. Telos.

Esta zona permite probar desembarco, costa, población, carreteras, aeródromos, bases, alturas, agricultura, Helios, logística, contraataques y transición hacia un objetivo de escala mayor.

El slice no necesita simular Kavala, Pyrgos, Molos y el resto de Altis con el mismo detalle. Sus estados pueden mantenerse en el nivel estratégico.

<a id="src-altis-geography-and-sector-map--12-reglas-de-implementación"></a>
#### 12. Reglas de implementación

1. Un sector no equivale a una localidad del mapa.
2. Una ciudad grande puede contener varios objetivos tácticos sin multiplicar su simulación permanente.
3. Controlar un aeródromo o puerto no implica que funcione.
4. Las rutas se representan como conexiones, capacidad y riesgo.
5. La logística marítima depende de muelle, calado simulado, seguridad y composición validada.
6. Las composiciones se revisan manualmente en 3DEN.
7. Los lugares especiales se reservan para misiones con propósito narrativo.
8. Los objetos del terreno se referencian mediante identificadores lógicos propios y una capa de validación.
9. El territorio lejano opera de forma abstracta.
10. Las fronteras de los 38 sectores son provisionales hasta probar navegación, visibilidad, densidad de objetos y rendimiento.

<a id="src-altis-geography-and-sector-map--13-validación-pendiente"></a>
#### 13. Validación pendiente

Antes de convertir este documento en configuración:

* obtener nombres y posiciones desde `CfgWorlds`;
* marcar polígonos y puntos de entrada en 3DEN;
* comprobar playas con infantería, lanchas y vehículos previstos;
* probar rutas de IA para cada corredor;
* medir capacidad real de muelles y pistas;
* verificar edificios utilizables y objetos destruibles;
* probar rendimiento en Kavala, Pyrgos y el aeropuerto;
* definir conexiones alternativas cuando un puente o carretera quede inutilizado;
* validar cada composición con clima, hora y densidad civil representativos.

<a id="src-altis-geography-and-sector-map--14-referencias-verificadas"></a>
#### 14. Referencias verificadas

Fuentes oficiales utilizadas para la base física y los criterios de diseño:

* [Mapa oficial de Altis y Stratis](https://cdn.akamai.steamstatic.com/steam/apps/107410/manuals/Arma_3_map_ENG.pdf?t=1700498258)
* [Altis — Bohemia Interactive Community Wiki](https://community.bohemia.net/wiki/Altis)
* [Terrain — Arma 3](https://arma3.com/features/terrain)
* [Report In: Martin Pezlar — Environment](https://arma3.com/news/report-in-martin-pezlar-environment)
* [OPREP: Altis Updates](https://dev.arma3.com/post/oprep-altis-updates)

Las atribuciones de capacidad militar concreta, funciones narrativas, cabezas de playa, regiones, sectores, corredores y nodos Helios pertenecen al diseño de *Islas Fracturadas*. No deben confundirse con canon oficial de Arma 3.

---

<a id="fuente-strategic-campaign-system"></a>
## Fuente integrada: `STRATEGIC_CAMPAIGN_SYSTEM.md`

> **Procedencia:** contenido migrado de `STRATEGIC_CAMPAIGN_SYSTEM.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-strategic-campaign-system--sistema-estratégico-general-de-campaña"></a>
### Sistema estratégico general de campaña

> La implementación de este diseño debe utilizar el contrato autoritativo de [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).
> La evaluación de comandantes, planes y órdenes se concreta en [STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-strategic-ai-and-chain-of-command).
> La presentación del conocimiento autorizado y la interacción del jugador se rigen por [STRATEGIC_UI_AND_PLAYER_EXPERIENCE_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system).
> La arquitectura modular y las reglas obligatorias de código se rigen por [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture).
> El orden de implementación, alcance, hitos y puertas de producción se rige por [MASTER_IMPLEMENTATION_AND_PRODUCTION_PLAN.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan).

> **Versión:** 1.0
> **Estado:** canon de diseño propuesto
> **Modalidad inicial:** campaña individual
> **Modalidad futura:** cooperativo de un solo bando
> **Bandos jugables:** Fuerza Azul o Fuerza Roja
> **IA:** invasor contrario, Gobierno, Verde, FIA, guerrillas, insurgencia y civiles
>
> Este documento integra los sistemas descritos en la [Biblia Narrativa](02_STORY_BIBLE_AND_WORLD_HISTORY.md#fuente-story-bible), [Helios y Argos](03_HELIOS_PHAROS_AND_ARGOS_DOSSIER.md#fuente-helios-argos), las [fuerzas invasoras](04_INVADING_FORCES_BLUE_AND_RED.md#fuente-invading-forces), el [sistema militar y orden de batalla](13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md#fuente-military-system-order-of-battle-and-force-catalog), el [sistema territorial, de frentes y construcción](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-territorial-sector-front-and-construction-system), el [sistema económico y logístico](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md#fuente-economic-and-logistics-system), los [actores nativos](05_NATIVE_GOVERNMENT_GREEN_FORCES_AND_POLITICS.md#fuente-native-actors-and-sectors), la [unidad jugable](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-unit-and-progression) y las [comunidades civiles](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-civilians-municipalities-and-social-systems).
>
> Su implementación narrativa y técnica se concreta en [NARRATIVE_ACTS_AND_MISSION_SYSTEM.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-narrative-acts-and-mission-system).

<a id="src-strategic-campaign-system--1-propósito"></a>
#### 1. Propósito

El sistema representa una guerra que continúa independientemente de la posición del jugador.

Controla territorio, frentes, fuerzas, logística, información, infraestructura, política, población, actividad irregular, Helios, decisiones de mando, narrativa y condiciones de desenlace.

El jugador influye profundamente, pero no controla todos los actores.

> La campaña no consiste solamente en conquistar sectores.

Una fuerza necesita ocupar, abastecer, defender, gobernar, obtener información, conservar legitimidad y sobrevivir a la reacción de los demás.

<a id="src-strategic-campaign-system--2-perspectiva"></a>
#### 2. Perspectiva

Cada partida utiliza una perspectiva jugable:

* En Azul, Rojo y todos los actores nativos son IA.
* En Rojo, Azul y todos los actores nativos son IA.
* No existen dos bandos humanos simultáneos.
* Los jugadores comparten unidad, recursos, decisiones, territorio, progresión y consecuencias.

<a id="src-strategic-campaign-system--3-capas-del-control-territorial"></a>
#### 3. Capas del control territorial

Un sector no se reduce a una bandera.

<a id="src-strategic-campaign-system--control-militar"></a>
##### Control militar

Quién domina bases, carreteras, alturas, accesos y defensas. Puede ser inexistente, débil, disputado, provisional, consolidado o fortificado.

<a id="src-strategic-campaign-system--control-administrativo"></a>
##### Control administrativo

Quién gestiona municipio, registros, policía, distribución, permisos y servicios.

<a id="src-strategic-campaign-system--control-logístico"></a>
##### Control logístico

Quién utiliza regularmente carreteras, depósitos, combustible, talleres, puertos y rutas marítimas o aéreas.

<a id="src-strategic-campaign-system--control-informativo"></a>
##### Control informativo

Quién conoce mejor fuerzas, rutas, población, clandestinidad, depósitos, amenazas y comunicaciones.

<a id="src-strategic-campaign-system--control-político"></a>
##### Control político

Quién es reconocido como legítimo: Gobierno, municipio, reformistas, FIA, invasor, mando Verde o autoridad autónoma.

<a id="src-strategic-campaign-system--control-clandestino"></a>
##### Control clandestino

Influencia oculta de FIA, guerrillas, radicales, contrabando, inteligencia o Argos.

<a id="src-strategic-campaign-system--4-estados-territoriales"></a>
#### 4. Estados territoriales

* **No controlado:** sin presencia suficiente.
* **Control nominal:** reclamado sin control efectivo.
* **Capturado provisionalmente:** puntos principales ocupados, sin consolidación.
* **Disputado:** varias fuerzas operan activamente.
* **En consolidación:** ocupante principal con resistencia, sabotaje o falta de suministros.
* **Consolidado:** guarnición, logística, mando y defensa funcionales.
* **Fortificado:** defensas, reservas y posiciones preparadas.
* **Aislado:** control físico sin conexiones.
* **Insurgente:** ocupación militar con fuerte clandestinidad.
* **Colapsado:** sin autoridad, servicios ni seguridad.

<a id="src-strategic-campaign-system--5-tipos-de-sector"></a>
#### 5. Tipos de sector

<a id="src-strategic-campaign-system--urbano"></a>
##### Urbano

Población, administración, hospitales, comercio e infraestructura. El control civil y político es crítico.

<a id="src-strategic-campaign-system--rural"></a>
##### Rural

Agricultura, rutas secundarias, escondites y población dispersa. Favorece guerrillas.

<a id="src-strategic-campaign-system--industrial"></a>
##### Industrial

Combustible, piezas, materiales, energía y transporte.

<a id="src-strategic-campaign-system--logístico"></a>
##### Logístico

Depósitos, cruces, puertos, talleres y almacenes.

<a id="src-strategic-campaign-system--militar"></a>
##### Militar

Bases, posiciones, reservas y defensa aérea.

<a id="src-strategic-campaign-system--helios"></a>
##### Helios

Radares, repetidores, comunicaciones, terminales y análisis.

<a id="src-strategic-campaign-system--estratégico"></a>
##### Estratégico

Aeropuerto, capital, puerto principal, central o instalación de Stratis.

<a id="src-strategic-campaign-system--6-conexiones-y-frentes"></a>
#### 6. Conexiones y frentes

Los sectores se conectan mediante carreteras principales y secundarias, rutas marítimas y aéreas, electricidad, comunicaciones y enlaces Helios.

Controlar sectores desconectados no crea un territorio funcional.

Un frente existe cuando sectores hostiles conectados pueden atacarse, reforzarse, bloquearse u observarse. Los frentes cambian dinámicamente.

<a id="src-strategic-campaign-system--7-recursos-estratégicos"></a>
#### 7. Recursos estratégicos

> Las categorías, localización, producción, transferencias y consumo se rigen por [ECONOMIC_AND_LOGISTICS_SYSTEM.md](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md#fuente-economic-and-logistics-system).

<a id="src-strategic-campaign-system--personal"></a>
##### Personal

Combatientes, tripulaciones, pilotos, ingenieros, sanitarios y logística. Las bajas eliminan capacidades, no solo números.

<a id="src-strategic-campaign-system--armamento-y-munición"></a>
##### Armamento y munición

Armas, explosivos, misiles, artillería y defensa aérea que deben transportarse desde fuentes reales.

<a id="src-strategic-campaign-system--combustible"></a>
##### Combustible

Necesario para vehículos, generadores, aviación, transporte y emergencias.

<a id="src-strategic-campaign-system--vehículos"></a>
##### Vehículos

Persisten como operativos, dañados, en reparación, abandonados, capturados o destruidos.

<a id="src-strategic-campaign-system--suministros-médicos"></a>
##### Suministros médicos

Afectan supervivencia, recuperación, hospitales, población y legitimidad.

<a id="src-strategic-campaign-system--materiales"></a>
##### Materiales

Permiten reparar, construir, fortificar y recuperar infraestructura.

<a id="src-strategic-campaign-system--información"></a>
##### Información

Reconocimiento, inteligencia humana, señales, archivos, mapas, credenciales y predicciones.

La evidencia investigativa conserva tipo, familia, estado, autenticidad, interpretación, poseedor y destino. No existe una barra única de «verdad»; se acumulan pruebas técnicas, humanas, políticas, operacionales y Argos.

<a id="src-strategic-campaign-system--legitimidad"></a>
##### Legitimidad

Reduce el coste de gobernar y aumenta cooperación, información, reclutamiento y estabilidad.

<a id="src-strategic-campaign-system--8-producción-y-acceso"></a>
#### 8. Producción y acceso

Los recursos proceden de flotas, depósitos Verdes, industria, puertos, aeródromos, aliados, Gobierno, municipios, FIA, contrabando y capturas.

Capturarlos no implica poder utilizarlos: pueden requerir reparación, técnicos, códigos, transporte, seguridad y cooperación local.

Campos, mandras, cooperativas, pesca, puertos, energía y trabajadores forman la base económica nativa. Su distribución e identidad regional se definen en [ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md](02_STORY_BIBLE_AND_WORLD_HISTORY.md#fuente-altis-stratis-history-culture-and-economy). Ocupar esa infraestructura sin cooperación puede reducir producción, crear desempleo o alimentar insurgencia.

<a id="src-strategic-campaign-system--9-logística"></a>
#### 9. Logística

Cada unidad necesita una cadena:

1. fuente;
2. depósito;
3. ruta;
4. distribución;
5. receptor.

Emboscadas, sabotaje, puentes destruidos, minas, pérdida de carreteras, clima, huelgas, bloqueos e información falsa pueden interrumpirla.

La falta de suministro reduce munición, movilidad, moral, reparación, agresividad y duración de combate.

<a id="src-strategic-campaign-system--10-convoyes"></a>
#### 10. Convoyes

Los convoyes militares, médicos, civiles, mixtos y clandestinos transportan recursos físicamente.

La IA decide ruta, escolta, horario, prioridad, carga y destino.

Helios puede recomendar rutas según amenaza, tráfico, inteligencia, clima y actividad enemiga. Una recomendación manipulada puede salvar, emboscar, desviar recursos o mantener viva a una facción debilitada.

<a id="src-strategic-campaign-system--11-construcción-y-fortificación"></a>
#### 11. Construcción y fortificación

> El contrato detallado y autoritativo de capacidades, profundidades, módulos, anclajes y memoria defensiva se encuentra en [TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-territorial-sector-front-and-construction-system).

La construcción es automática; el jugador establece prioridades:

* defensa;
* logística;
* antitanque;
* antiaérea;
* observación;
* reparación;
* medicina;
* comunicaciones;
* protección civil.

El sistema decide composición, orientación, terreno, ubicación, nivel y cantidad según sector, bando, amenaza, frente, recursos, tiempo, población e infraestructura.

<a id="src-strategic-campaign-system--12-evolución-de-bases"></a>
#### 12. Evolución de bases

0. **Presencia temporal:** patrulla sin defensa fija.
1. **Puesto avanzado:** mando, comunicaciones, guarnición pequeña y suministros.
2. **Base de sector:** defensas, depósito, medicina, reparación y reserva.
3. **Base regional:** mando ampliado, fuego de apoyo, defensa aérea, logística y fuerza móvil.
4. **Centro operacional:** reservas, especialistas, coordinación regional y Helios avanzado.

Las bases evolucionan, se degradan, se abandonan, cambian de dueño y conservan daños.

<a id="src-strategic-campaign-system--13-guarniciones"></a>
#### 13. Guarniciones

Todo sector consolidado necesita guarnición según valor, amenaza, población, clandestinidad y logística.

Defiende, patrulla, controla accesos, reacciona, protege infraestructura y mantiene orden.

Una guarnición excesiva debilita el frente. Una insuficiente favorece sabotaje, insurgencia, reconquista y colapso.

<a id="src-strategic-campaign-system--14-información"></a>
#### 14. Información

La información posee procedencia y calidad:

* confirmada;
* probable;
* estimada;
* antigua;
* contradictoria;
* manipulada;
* desconocida.

Procede de reconocimiento, civiles, radares, comunicaciones, prisioneros, FIA, Helios, inteligencia, comandantes y observadores.

Puede fallar por retraso, engaño, interferencia, interpretación, desobediencia o Argos.

<a id="src-strategic-campaign-system--15-helios-en-la-estrategia"></a>
#### 15. Helios en la estrategia

Helios recopila, compara, estima, advierte, prioriza, recomienda, filtra y distribuye. No emite órdenes obligatorias.

La finalidad oculta busca conservar el escenario operativo suficiente tiempo para obtener datos, manteniendo varias fuerzas, infraestructura mínima, población, diversidad de decisiones y red parcial.

<a id="src-strategic-campaign-system--16-dimensiones-de-control-de-helios"></a>
#### 16. Dimensiones de control de Helios

1. **Control físico:** quién ocupa el nodo.
2. **Acceso digital:** quién se autentica o introduce datos.
3. **Integridad:** conexión y funcionamiento.
4. **Confianza:** cuánto cree cada mando en sus resultados.
5. **Infiltración:** accesos ocultos de Argos u otros.

<a id="src-strategic-campaign-system--17-acciones-sobre-nodos"></a>
#### 17. Acciones sobre nodos

Una facción puede capturar, reparar, conectar, aislar, copiar, cambiar códigos, sabotear, destruir, utilizar parcialmente o transferir un nodo.

Destruirlo puede negar información y, a la vez, afectar hospitales, comunicaciones, observación y población.

<a id="src-strategic-campaign-system--18-comandantes-de-ia"></a>
#### 18. Comandantes de IA

<a id="src-strategic-campaign-system--azul"></a>
##### Azul

Elena Ward, Marcus Hale, Thomas Rourke, Miriam Kessler, Sofia Laurent, Naomi Reyes y la infiltrada Evelyn Shaw.

<a id="src-strategic-campaign-system--rojo"></a>
##### Rojo

Darius Navid, Soraya Vahid, Samir Khadem, Kamran Sadeq, Nadir Khoury, Laleh Arman y el infiltrado Rashid Volkov.

<a id="src-strategic-campaign-system--verde"></a>
##### Verde

Leon Varos, Nikos Sarris, Marios Daskal, Thalia Koronis, Elias Petrou y Damian Rallis.

<a id="src-strategic-campaign-system--fia"></a>
##### FIA

Eleni Markou, Petros Kallas, Mara Vellis, dirigentes regionales y células radicales manipuladas mediante la identidad Némesis.

<a id="src-strategic-campaign-system--19-variables-de-mando"></a>
#### 19. Variables de mando

Cada comandante evalúa fuerza, suministros, amenazas, oportunidades, bajas, civiles, política, relaciones, información, Helios, jugador, personalidad y objetivos secretos.

Dos comandantes pueden recibir los mismos datos y decidir de forma diferente.

Las relaciones no se reducen a una reputación global. Cada personaje conserva confianza personal, respeto profesional, dependencia, afinidad ideológica, agravio, miedo, conocimiento comprometedor y lealtad afectiva. Los estados, conflictos persistentes y reglas de ruptura se definen en [CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md](07_CHARACTERS_COMMAND_AND_RELATIONSHIPS.md#fuente-character-relationships-loyalties-and-betrayals).

<a id="src-strategic-campaign-system--20-ciclo-de-decisión"></a>
#### 20. Ciclo de decisión

1. **Observar:** reunir información disponible.
2. **Interpretar:** evaluar amenazas, objetivos, riesgos y confianza.
3. **Priorizar:** defender, atacar, abastecer, negociar, retirarse o consolidar.
4. **Planificar:** asignar unidades, rutas, tiempos, reservas y apoyos.
5. **Ejecutar:** transmitir órdenes.
6. **Evaluar:** modificar experiencia, confianza, doctrina y relaciones.

<a id="src-strategic-campaign-system--21-decisiones-no-deterministas"></a>
#### 21. Decisiones no deterministas

La IA considera personalidad, miedo, ambición, errores, presión, información incompleta, memoria y política; no siempre elige el óptimo matemático.

Hale puede atacar por temor a la consolidación Roja; Ward detenerse por civiles; Vahid comprometer blindados; Navid preservar logística.

Helios registra estas divergencias.

<a id="src-strategic-campaign-system--22-jugador-y-comandantes"></a>
#### 22. Jugador y comandantes

El jugador puede obedecer, modificar, retrasar, rechazar, interpretar, informar u ocultar.

Una acción puede aumentar la confianza de un mando y reducir la de otro. Salvar una ciudad puede agradar a Laurent y enfurecer a Hale; proteger Verdes desobedientes puede acercar a Navid y alejar a Vahid.

<a id="src-strategic-campaign-system--23-relaciones-entre-facciones"></a>
#### 23. Relaciones entre facciones

Los estados posibles son alianza formal, cooperación operacional, tregua, neutralidad, tensión, hostilidad limitada, guerra, subordinación, dependencia e infiltración.

Cada relación registra confianza, interés común, conflicto político, dependencia, agravios y compatibilidad de mando.

Cambian por operaciones, bajas, promesas, recursos, negociaciones, territorios, prisioneros, información, civiles y liderazgo.

Una alianza táctica no elimina conflictos políticos.

<a id="src-strategic-campaign-system--24-gobierno-y-legitimidad"></a>
#### 24. Gobierno y legitimidad

El Gobierno puede conservar reconocimiento, funcionarios, documentos, presupuesto y códigos aunque pierda territorio.

Las fuerzas militares pueden necesitarlo para administrar, legitimar, negociar, activar servicios y usar Helios.

La dependencia puede convertirlo en aliado, títere, autoridad provisional o Gobierno en el exilio.

Autoridad formal, reconocida, efectiva, militar, municipal y clandestina; estados G0–G5; y dimensiones de legitimidad se rigen por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-civil-municipal-political-stability-system).

<a id="src-strategic-campaign-system--25-fuerza-verde"></a>
#### 25. Fuerza Verde

Registra cohesión, lealtad regional, confianza en Varos, relación gubernamental y Roja, oposición Azul e infiltración.

Se fragmenta gradualmente en Gobierno, soberanistas, reformistas, aliados Rojos, resistencia y unidades aisladas.

<a id="src-strategic-campaign-system--26-fia-guerrillas-y-radicales"></a>
#### 26. FIA, guerrillas y radicales

FIA registra por región apoyo, fuerza, influencia política, células, información, radicalización y relación con Markou y Kallas.

Puede controlar políticamente sin dominar militarmente.

Las guerrillas surgen por ocupación, derrota Verde, daños y resistencia. Pueden sobrevivir a su facción de origen.

La insurgencia radical crece con miedo, agravios, colapso, represión, armas y falta de alternativas. Argos puede utilizarla sin controlarla.

El modelo rector separa legitimidad política, fuerza armada, apoyo público/privado, clandestinidad, exposición, células, depósitos, Frente Negro y presión contrainsurgente según [FIA_INSURGENCY_AND_CLANDESTINE_WAR_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-fia-insurgency-and-clandestine-war-system).

<a id="src-strategic-campaign-system--27-sistema-civil"></a>
#### 27. Sistema civil

Cada comunidad registra población, necesidades, seguridad, miedo, confianza, legitimidad, radicalización, cohesión, dependencia y memoria.

Puede cooperar, protestar, evacuar, informar, sabotear, formar milicias, apoyar FIA o aceptar ocupación.

El modelo rector separa confianza, apoyo, obediencia y dependencia, y añade servicios, autoridad, administración, agravio, desplazamiento y estabilidad según [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-civil-municipal-political-stability-system).

<a id="src-strategic-campaign-system--28-ocupación"></a>
#### 28. Ocupación

Ocupar requiere fuerza, guarnición, suministros, administración, información y estabilidad.

* **Ligera:** pocas tropas y cooperación local.
* **Militar:** controles y restricciones.
* **Represiva:** detenciones, vigilancia y miedo.
* **Protectorado:** autoridad local formal con dependencia extranjera.

<a id="src-strategic-campaign-system--29-moral-y-experiencia"></a>
#### 29. Moral y experiencia

La moral depende de bajas, suministros, liderazgo, victorias, derrotas, aislamiento, población, legitimidad e información.

Una moral baja produce lentitud, retirada, desobediencia, rendición o deserción.

Las unidades ganan experiencia en combate, defensa, reconocimiento, ciudad, insurgencia y logística. Una unidad veterana es un recurso persistente; destruirla es una pérdida permanente.

<a id="src-strategic-campaign-system--30-prisioneros-y-heridos"></a>
#### 30. Prisioneros y heridos

Los prisioneros son información, recurso político, responsabilidad logística y elemento negociador. Pueden ser interrogados, tratados, intercambiados, entregados, liberados, reclutados o procesados.

Los heridos pueden recuperarse, quedar fuera de combate, requerir evacuación o morir por falta de atención.

El trato afecta legitimidad, relaciones, información, moral y conservación de veteranos.

<a id="src-strategic-campaign-system--31-infraestructura"></a>
#### 31. Infraestructura

Carreteras, puentes, centrales, hospitales, puertos, aeródromos, comunicaciones y depósitos pueden estar operativos, dañados, degradados, destruidos o en reparación.

Una destrucción útil tácticamente puede crear un problema estratégico posterior.

<a id="src-strategic-campaign-system--32-clima-y-tiempo"></a>
#### 32. Clima y tiempo

Afectan visibilidad, aviación, navegación, caminos, sensores, evacuaciones y comunicaciones.

Helios utiliza datos meteorológicos, que también pueden ser incompletos o manipulados.

<a id="src-strategic-campaign-system--33-eventos-dinámicos"></a>
#### 33. Eventos dinámicos

Ofensivas, contraataques, convoyes, sabotajes, protestas, huelgas, evacuaciones, motines, deserciones, negociaciones, golpes, levantamientos, banderas falsas, fallos de Helios y crisis humanitarias.

Surgen del estado del mundo, no de aleatoriedad sin causa.

La conversión causal de estado → necesidad → misión/evento, su ritmo y su resolución externa se rigen por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-dynamic-missions-and-emergent-events).

<a id="src-strategic-campaign-system--34-sistema-de-misiones"></a>
#### 34. Sistema de misiones

Las misiones proceden de comandantes, territorio, comunidades, FIA, Gobierno, Helios o emergencias.

Pueden ser narrativas obligatorias, estratégicas, reactivas, locales, secretas u oportunidades temporales.

Ignorar o dejar expirar una misión también produce consecuencias.

Las investigaciones incorporan un objetivo militar y otro informativo. Perder una prueba crítica activa una ruta redundante con mayor coste, menor certeza o menos opciones finales; nunca bloquea por sí sola la campaña. La matriz completa está en [INVESTIGATION_REVELATION_MATRIX.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-investigation-revelation-matrix).

Las familias, plantillas, prioridades, caducidad, transformación, anti-repetición y límites de ofertas se definen en [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-dynamic-missions-and-emergent-events).

<a id="src-strategic-campaign-system--35-eventos-narrativos-obligatorios"></a>
#### 35. Eventos narrativos obligatorios

Desembarco, consolidación, descubrimiento de Helios, fragmentación Verde, revelación de Argos y operación sobre Stratis ocurren en todas las campañas.

Su ubicación, participantes, información, consecuencias y resultado dependen del estado estratégico.

El Día Cero parte de un estado rector: Azul abre Katalaki a las 05:40 y Rojo entra en Molos doce minutos después. Ward, Navid y Varos toman decisiones humanas basadas en la fragmentación informativa de PROTOCOLO UMBRAL. La simulación estratégica comienza a partir de H+06:00; no debe reescribir retroactivamente la [cronología de las últimas 72 horas](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-last-72-hours-chronology).

<a id="src-strategic-campaign-system--36-guerra-autónoma-y-niveles-de-simulación"></a>
#### 36. Guerra autónoma y niveles de simulación

Mientras el jugador actúa, otros sectores cambian, convoyes avanzan, comandantes deciden, civiles reaccionan, FIA opera y Helios recopila.

<a id="src-strategic-campaign-system--nivel-táctico"></a>
##### Nivel táctico

Cerca del jugador: unidades físicas, combate completo, vehículos, civiles y daños.

<a id="src-strategic-campaign-system--nivel-operacional"></a>
##### Nivel operacional

Sectores cercanos: grupos, rutas, objetivos y tiempos.

<a id="src-strategic-campaign-system--nivel-estratégico"></a>
##### Nivel estratégico

Regiones lejanas: fuerza abstracta, suministros, control y resultados calculados.

Al acercarse, el sistema materializa un estado coherente.

La guerra principal permanece dentro de un escenario persistente en Altis. Stratis es una misión separada que recibe un paquete reducido de estado cuando se desbloquea el desenlace.

<a id="src-strategic-campaign-system--37-influencia-de-helios"></a>
#### 37. Influencia de Helios

Puede recomendar ofensiva, advertir ataque, sugerir retirada, priorizar convoy, detectar riesgo civil o señalar vulnerabilidad.

Puede intentar conservar la viabilidad mediante filtraciones, advertencias selectivas, datos incompletos y prioridades.

No crea recursos, controla unidades, garantiza obediencia, conoce decisiones futuras ni evita todo colapso.

Los supuestos, fuentes, alternativas, riesgos, adopción y retroalimentación de cada recomendación se rigen por [HELIOS_INTELLIGENCE_AND_FOG_OF_WAR_SYSTEM.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-helios-intelligence-and-fog-of-war-system).

<a id="src-strategic-campaign-system--38-detección-de-manipulación"></a>
#### 38. Detección de manipulación

El jugador compara fuentes, horarios, predicciones, resultados y campañas.

Indicadores:

* precisión sin fuente;
* datos anónimos;
* mensajes duplicados;
* rutas recomendadas a ambos;
* errores que preservan el equilibrio;
* órdenes autenticadas por usuarios inexistentes.

La procedencia, independencia de fuentes, auditoría, integridad, presupuesto Argos y estados de compromiso se definen en [HELIOS_INTELLIGENCE_AND_FOG_OF_WAR_SYSTEM.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-helios-intelligence-and-fog-of-war-system).

<a id="src-strategic-campaign-system--39-progresión-de-campaña"></a>
#### 39. Progresión de campaña

1. **Fase I — Aproximación:** flotas en tránsito y territorio Verde.
2. **Fase II — Desembarco:** primera oleada, cabeza de playa y escasez.
3. **Fase III — Consolidación:** bases, expansión y contactos.
4. **Fase IV — Guerra territorial:** frentes Azul-Rojo y presión sobre Verde.
5. **Fase V — Fragmentación:** Gobierno dividido, Verde fracturada, FIA e insurgencia.
6. **Fase VI — Guerra por Helios:** nodos, códigos, técnicos y manipulación.
7. **Fase VII — Dominio o desgaste:** una fuerza se aproxima a la victoria y Helios intenta preservar el escenario.
8. **Fase VIII — Stratis:** operación final y decisiones sobre el núcleo.
9. **Fase IX — Transición:** ocupación, reconstrucción, insurgencia, nuevo Gobierno y revelación.

<a id="src-strategic-campaign-system--40-condiciones-de-avance"></a>
#### 40. Condiciones de avance

No dependen solo de sectores. Pueden requerir territorio, logística, información, relaciones, nodos, fuerza, eventos y tiempo.

Stratis puede exigir puerto, superioridad naval, acceso parcial, técnicos, documentos y fuerza suficiente.

<a id="src-strategic-campaign-system--41-victoria-y-derrota"></a>
#### 41. Victoria y derrota

<a id="src-strategic-campaign-system--victoria-militar"></a>
##### Victoria militar

Retirada o destrucción del rival, territorio suficiente, logística y neutralización convencional. No garantiza éxito político.

<a id="src-strategic-campaign-system--victoria-política"></a>
##### Victoria política

Autoridad, legitimidad, servicios, cooperación, reducción insurgente y decisión sobre Helios.

<a id="src-strategic-campaign-system--victoria-estratégica"></a>
##### Victoria estratégica

Control o información sobre Helios, Stratis, rutas regionales y presencia extranjera. Puede alcanzarse parcialmente aunque se pierda Altis.

<a id="src-strategic-campaign-system--derrota"></a>
##### Derrota

Pérdida de playa, colapso logístico, retirada política, destrucción, pérdida de apoyo, captura del mando o fracaso en Stratis.

Una derrota parcial puede continuar como evacuación, resistencia, retirada u operación limitada.

<a id="src-strategic-campaign-system--42-finales-combinados"></a>
#### 42. Finales combinados

El desenlace combina:

* dimensión militar;
* dimensión política;
* dimensión civil;
* destino de Helios;
* descubrimiento de Argos;
* presencia extranjera.

La combinación no genera un árbol independiente por permutación. Un resolvedor determinista selecciona resultado militar, orden político, condición civil, Helios, Argos, presencia extranjera, verdad pública y módulos priorizados. La autoridad canónica de esa resolución es [MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md](08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md#fuente-modular-endings-and-epilogues-matrix).

Ejemplos:

* Victoria Azul con Gobierno de unidad.
* Protectorado Azul.
* Alianza Roja.
* Orden Rojo.
* Victoria Verde.
* Victoria FIA.
* Guerra congelada.
* Helios oscuro.
* Helios liberado.
* Islas destruidas.

<a id="src-strategic-campaign-system--43-ambas-campañas"></a>
#### 43. Ambas campañas

Azul muestra FIA, contratistas occidentales, inteligencia e intervención convertida en ocupación.

Rojo muestra Asterión, contratos, Gobierno y alianza convertida en subordinación.

Completar ambas revela información paralela, recomendaciones semejantes, activaciones, comparación doctrinal y criterios de validación.

Después puede desbloquearse un epílogo con informes de comparación, divergencia humana, eficacia de recomendaciones y transición a fase madura.

> ¿Las decisiones del jugador destruyeron el experimento o completaron la información que Helios necesitaba?

<a id="src-strategic-campaign-system--44-persistencia-cooperativa"></a>
#### 44. Persistencia cooperativa

El servidor conserva autoridad sobre sectores, recursos, unidades, relaciones, eventos, personajes, Helios y progresión.

Los jugadores comparten unidad, decisiones, rango operacional y consecuencias.

Una desconexión no detiene guerra, convoyes, IA ni eventos.

<a id="src-strategic-campaign-system--45-autoridad-del-jugador"></a>
#### 45. Autoridad del jugador

Comienza con unidad y decisiones tácticas. Después obtiene subordinados, prioridades, solicitudes y mando regional.

Nunca controla completamente a Ward, Hale, Navid, Vahid, Varos, FIA o Gobierno.

> El jugador puede influir en la guerra, pero debe convivir con las decisiones de otros comandantes.

<a id="src-strategic-campaign-system--46-memoria-y-registro"></a>
#### 46. Memoria y registro

El mundo recuerda sectores, convoyes, muertes, promesas, armas, prisioneros, daños, alianzas, traiciones y uso de Helios.

El registro de campaña conserva cronología, territorio, bajas, decisiones, relaciones, documentos, descubrimientos, recomendaciones y contradicciones.

Cada cambio relacional registra causa, acto y testigos. Las muertes importantes activan sustitutos con doctrina y vínculos propios; nunca se reemplaza un personaje conservando exactamente su comportamiento.

También conserva evidencias recuperadas, autenticadas, interpretadas, publicadas, entregadas o destruidas; estado de testigos; umbrales de revelación y nivel de preparación S0–S4 para Stratis.

Una segunda campaña puede comparar su registro con la primera perspectiva.

<a id="src-strategic-campaign-system--47-principios-obligatorios"></a>
#### 47. Principios obligatorios

1. La guerra continúa sin el jugador.
2. Solo un invasor es jugable por campaña.
3. Control militar no equivale a control político.
4. Capturar un sector no garantiza su funcionamiento.
5. La logística limita las ofensivas.
6. Unidades y vehículos importantes persisten.
7. Los comandantes poseen voluntad propia.
8. Helios sugiere, pero no ordena.
9. Argos influye, pero no controla todo.
10. La población conserva memoria.
11. FIA y guerrillas pueden controlar información sin territorio.
12. Verde se fragmenta gradualmente.
13. Las relaciones cambian mediante acciones.
14. Las victorias producen consecuencias.
15. La construcción es automática y priorizada.
16. La información puede ser falsa o manipulada.
17. La legitimidad es un recurso.
18. Las bajas civiles cambian la campaña.
19. Jugar ambos bandos revela una verdad mayor.
20. La victoria militar no garantiza un buen final.

<a id="src-strategic-campaign-system--48-frase-central"></a>
#### 48. Frase central

> El territorio determina dónde puede combatir un ejército. La logística determina cuánto tiempo puede permanecer. La información determina qué cree que debe hacer. La población determina si su victoria puede sobrevivir.

> ¿Qué significa controlar una isla cuando sus carreteras, soldados, instituciones, comunicaciones y habitantes obedecen a fuerzas diferentes?

<a id="src-strategic-campaign-system--49-aplicación-territorial-en-altis"></a>
#### 49. Aplicación territorial en Altis

La primera aplicación concreta de este sistema utiliza diez regiones operacionales, 38 sectores y nueve corredores lógicos. No emplea una cuadrícula uniforme ni convierte automáticamente cada localidad en un sector.

Las entradas principales son asimétricas:

* Azul entra por Katalaki Bay–Neochori y compite por el aeropuerto desde el oeste.
* Rojo entra por Molos Bay–Molos Airfield y depende del corredor de Sofia.
* Verde conserva inicialmente el centro, Pyrgos y las conexiones interiores.

El modelo completo de regiones, sectores, cuellos de botella, infraestructura y nodos se define en [ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md](10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md#fuente-altis-geography-and-sector-map).
