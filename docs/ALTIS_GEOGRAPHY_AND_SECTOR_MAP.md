# Altis — Geografía operacional y mapa inicial de sectores

> Documento de diseño territorial. Traduce el terreno real de Altis a regiones, sectores, corredores, nodos y cabezas de playa para *Islas Fracturadas*.

La función cultural, económica y social de estas regiones se define en [ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md](ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md). Sus niveles, módulos, profundidad de frente y construcción se rigen por el [sistema territorial](TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md).

## 1. Estado del documento

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

## 2. Principio territorial

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

## 3. Base geográfica

Altis posee aproximadamente 268,65 km², 32 poblaciones según la clasificación oficial, tres lagos estacionales y una costa dominada fuera de sus bahías por rocas y acantilados. Thronos, con unos 350 metros, es su elevación principal.

Durante el verano, Limni, Ochrolimni y Almyra permanecen secos. Sus superficies abiertas pueden habilitar rutas o usos temporales, pero ofrecen poca cobertura.

El noroeste favorece infantería, exploradores, emboscadas y observación. Las llanuras orientales y meridionales favorecen carros, columnas mecanizadas, reconocimiento aéreo y fuego de largo alcance. Las playas y bahías viables son recursos estratégicos: no todo el litoral admite desembarcos ni logística pesada.

## 4. Regiones operacionales

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

## 5. Puntos de gravedad regionales

### Kavala y el oeste

Kavala es el principal centro social y opositor. Su valor procede de la población, los archivos, las redes civiles, FIA y el contrabando, no de funcionar como puerto militar pesado.

No será la cabeza de playa principal Azul. Es más apropiada para bloqueos, sabotajes, evacuaciones, contactos clandestinos, levantamientos y batallas tardías por distritos. Kavala debe subdividirse y activarse por áreas para proteger rendimiento y permitir resultados parciales.

Agios Dionysios, Kore, Topolia y Lakka controlan la salida de Kavala hacia el centro. Aislar este corredor puede neutralizar la ciudad sin ocupar cada barrio.

### Noroeste montañoso

Oreokastro, Abdera, Galati, Syrta y Thronos forman el espacio principal de guerra irregular rural. La región puede albergar comunidades soberanistas, antiguos soldados Verdes, puestos de observación, depósitos ocultos, repetidores y células de FIA.

Favorece minas, emboscadas, tiradores, helicópteros y control de alturas; penaliza columnas blindadas y convoyes largos.

### Katalaki, Neochori y Stavros

Katalaki Bay–Neochori será la entrada principal Azul. Su posición permite establecer una base antes de combatir en una gran ciudad, conectar con AAC Airfield y avanzar hacia el aeropuerto.

Neochori controla la supervivencia logística de la playa. Stavros y el antiguo FOB Whiskey constituyen la primera posición Verde importante y pueden cambiar de manos durante la campaña.

### Cuenca de Zaros y AAC

AAC Airfield será una instalación avanzada para helicópteros, drones, evacuación, logística y aeronaves ligeras; no una gran base de cazas. Xirolimni, Poliakko, Therisa y Zaros ofrecen agua, agricultura, rutas secundarias, sabotaje e insurgencia.

### Aeropuerto internacional

El aeropuerto proporciona acceso potencial a transporte pesado, ala fija, reconocimiento y refuerzos. Capturar la pista no lo vuelve operativo. Requiere:

1. control físico;
2. pista utilizable;
3. combustible y mantenimiento;
4. seguridad aérea;
5. comunicaciones;
6. accesos terrestres seguros.

Se divide en hangares y base occidental, pista y terminal, complejo militar oriental, accesos de Gravia y nudo de Telos.

### Athira y norte central

Athira funciona como mando regional, reserva Verde y enlace entre el aeropuerto, la costa norte y el oeste montañoso. Agia Triada y Kalithea permiten infiltración, contrabando y embarcaciones ligeras, no logística pesada.

### Llanura oriental

La arteria Telos–Rodopoli–Kalochori–Sofia favorece la doctrina mecanizada Roja, pero crea una línea de suministro visible y vulnerable. Almyra puede ofrecer rutas temporales o emplazamientos móviles a costa de cobertura.

Ghost Hotel se reserva como ubicación táctica singular para operaciones narrativas, clandestinas o de combate cercano; no será un sector económico genérico.

### Molos y Sofia

Molos Bay–Molos Airfield será la entrada principal Roja. Su aeródromo y playas facilitan el despliegue, mientras que la península obliga a proteger el corredor de Sofia.

Perder Sofia o el istmo puede aislar a Rojo. Pefkas Bay y Galana Nera proporcionan entradas secundarias limitadas, no una duplicación automática de la capacidad principal.

### Pyrgos y sudeste

Pyrgos conserva el Gobierno, los ministerios, los archivos públicos y la legitimidad institucional. Su captura cambia la política nacional, pero no entrega automáticamente Kavala, el aeropuerto, Molos, FIA, Verde ni Stratis.

El eje Pyrgos–Dorida–Feres es largo y vulnerable. Feres, Selakano y Mazi sostienen energía, reservas y operaciones desconectadas en el sur.

## 6. Arquitectura inicial de 38 sectores

Los sectores agrupan objetivos que comparten función estratégica. Las ubicaciones tácticas dentro de ellos se materializan únicamente cuando una misión o el nivel de simulación lo exige.

### Oeste y Kavala

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_W_KAVALA_PORT` | Kavala Port | puerto |
| `ALT_W_KAVALA_CITY` | Kavala City | urbano y político |
| `ALT_W_AGGELOCHORI` | Aggelochori | urbano y cruce |
| `ALT_W_NERI_PANOCHORI` | Neri–Panochori | rural y clandestino |
| `ALT_W_AGIOS_DIONYSIOS` | Agios Dionysios | paso y defensa |
| `ALT_W_KORE_TOPOLIA` | Kore–Topolia | corredor |

### Noroeste

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_NW_OREOKASTRO` | Oreokastro | población y acceso |
| `ALT_NW_ABDERA_GALATI` | Abdera–Galati | rural |
| `ALT_NW_SYRTA` | Syrta | puesto y logística ligera |
| `ALT_NW_THRONOS` | Thronos | altura y observación |
| `ALT_NW_WIND` | Parque eólico del noroeste | energía y comunicaciones |

### Centro occidental

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_CW_KATALAKI` | Katalaki Bay | playa y logística |
| `ALT_CW_NEOCHORI` | Neochori | población y puerto ligero |
| `ALT_CW_STAVROS_WHISKEY` | Stavros–FOB Whiskey | base y paso |
| `ALT_CW_LAKKA` | Lakka | cruce |
| `ALT_CW_AAC` | AAC Airfield | aeródromo ligero |
| `ALT_CW_POLIAKKO_THERISA` | Poliakko–Therisa | rural y logística |
| `ALT_CW_XIROLIMNI_ZAROS` | Xirolimni–Zaros | agua, energía y rural |

### Centro

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_C_AIRPORT_WEST` | Airport West | hangares y base |
| `ALT_C_AIRPORT_TERMINAL` | Airport Terminal | pista y terminal |
| `ALT_C_AIRPORT_MIL` | Airport Military Complex | militar y Helios |
| `ALT_C_TELOS` | Telos | nudo vial |
| `ALT_C_GRAVIA` | Gravia | acceso y reserva |
| `ALT_C_ATHIRA` | Athira | urbano y mando regional |

### Norte y centro oriental

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_NC_FRINI_AGIA_TRIADA` | Frini–Agia Triada | costa y comunicaciones |
| `ALT_NC_KALITHEA` | Kalithea | costa y ruta |
| `ALT_E_RODOPOLI` | Rodopoli | cruce mecanizado |
| `ALT_E_KALOCHORI_PAROS` | Kalochori–Paros | urbano y logístico |

### Nordeste

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_NE_IOANNINA_DELFINAKI` | Ioannina–Delfinaki | rural y acceso |
| `ALT_NE_SOFIA` | Sofia | cuello de botella |
| `ALT_NE_PEFKAS` | Pefkas Bay | playa secundaria |
| `ALT_NE_MOLOS` | Molos | ciudad y puerto |
| `ALT_NE_MOLOS_AIRFIELD` | Molos Airfield | aeródromo y base |

### Pyrgos y sudeste

| ID | Sector | Tipo dominante |
|---|---|---|
| `ALT_SE_CHARKIA` | Charkia | cruce hacia la capital |
| `ALT_SE_PYRGOS_HARBOUR` | Pyrgos Harbour | puerto |
| `ALT_SE_PYRGOS_GOV` | Pyrgos Government | urbano y político |
| `ALT_SE_DORIDA_CHALKEIA` | Dorida–Chalkeia | corredor |
| `ALT_SE_FERES_SELAKANO` | Feres–Selakano | energía, pista y reserva |

Almyra, Panagia, Feres Airfield y el extremo de Molos podrán separarse en una iteración futura si la simulación necesita más profundidad.

## 7. Corredores y conexiones

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

## 8. Despliegues iniciales

### Azul

La primera oleada en Katalaki incluye reconocimiento costero, infantería, ingenieros, vehículos ligeros y AZUR-1.

Objetivos iniciales:

1. asegurar la playa;
2. tomar o negociar el acceso a Neochori;
3. abrir la ruta a Stavros;
4. capturar o neutralizar FOB Whiskey;
5. asegurar AAC;
6. preparar el avance hacia el aeropuerto.

Puede ejecutar operaciones secundarias de comandos en Kavala Bay, contacto FIA en Panochori y sabotaje de comunicaciones en Magos.

### Rojo

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

## 9. Infraestructura funcional

### Aeródromos

| Instalación | Capacidad de diseño |
|---|---|
| Altis International Airport | ala fija, transporte pesado, helicópteros y gran logística |
| AAC Airfield | helicópteros, drones, evacuación y aeronaves ligeras |
| Molos Airfield | ala fija ligera, helicópteros y defensa oriental |
| Feres Airfield | reserva y logística limitada |
| Limni seco | uso temporal o clandestino, sujeto a validación |

Todo aeródromo separa control físico, estado de pista, combustible/mantenimiento y seguridad/comunicaciones.

### Puertos

Pyrgos Harbour y Kavala son puertos de alto valor, pero su capacidad militar exacta depende de composiciones y pruebas. Neochori, Kalithea, Agia Triada y las calas irregulares se limitan inicialmente a embarcaciones ligeras, infiltración, evacuación y contrabando.

### Energía y comunicaciones

La presa, plantas, parques eólicos, instalaciones solares, antenas, radares y depósitos permiten que energía, comunicaciones y Helios dependan de infraestructura física distribuida.

## 10. Red territorial de Helios

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

## 11. Vertical slice territorial

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

## 12. Reglas de implementación

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

## 13. Validación pendiente

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

## 14. Referencias verificadas

Fuentes oficiales utilizadas para la base física y los criterios de diseño:

* [Mapa oficial de Altis y Stratis](https://cdn.akamai.steamstatic.com/steam/apps/107410/manuals/Arma_3_map_ENG.pdf?t=1700498258)
* [Altis — Bohemia Interactive Community Wiki](https://community.bohemia.net/wiki/Altis)
* [Terrain — Arma 3](https://arma3.com/features/terrain)
* [Report In: Martin Pezlar — Environment](https://arma3.com/news/report-in-martin-pezlar-environment)
* [OPREP: Altis Updates](https://dev.arma3.com/post/oprep-altis-updates)

Las atribuciones de capacidad militar concreta, funciones narrativas, cabezas de playa, regiones, sectores, corredores y nodos Helios pertenecen al diseño de *Islas Fracturadas*. No deben confundirse con canon oficial de Arma 3.
