# Unidad del jugador, progresión y decisiones

> **Estado del contenedor:** diseño confirmado y diseño en desarrollo
> **Fuente de verdad para:** unidad del jugador, progresión, autoridad, interfaz y decisiones
> **Relacionados:** [14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md); [16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-07-25

## Propósito

Centralizar unidad del jugador, progresión, autoridad, interfaz y decisiones sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [PLAYER UNIT AND PROGRESSION](#fuente-player-unit-and-progression)
- [PLAYER PROGRESSION AUTHORITY AND UNLOCKS SYSTEM](#fuente-player-progression-authority-and-unlocks-system)
- [STRATEGIC UI AND PLAYER EXPERIENCE SYSTEM](#fuente-strategic-ui-and-player-experience-system)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `PLAYER_UNIT_AND_PROGRESSION.md`, `PLAYER_PROGRESSION_AUTHORITY_AND_UNLOCKS_SYSTEM.md`, `STRATEGIC_UI_AND_PLAYER_EXPERIENCE_SYSTEM.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

## Contenido consolidado

<a id="fuente-player-unit-and-progression"></a>
## Fuente integrada: `PLAYER_UNIT_AND_PROGRESSION.md`

> **Procedencia:** contenido migrado de `PLAYER_UNIT_AND_PROGRESSION.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-player-unit-and-progression--jugadores-unidades-protagonistas-y-progresión-de-mando"></a>
### Jugadores, unidades protagonistas y progresión de mando

> **Jerarquía:** este documento se conserva como dossier de las unidades protagonistas, integrantes, roles, heridas, sustitución y preparación cooperativa. Rango, autoridad, confianza, reputación, capacidades y desbloqueos se rigen por [PLAYER_PROGRESSION_AUTHORITY_AND_UNLOCKS_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-progression-authority-and-unlocks-system); voces, barks, conversaciones, memoria audible y sustituciones narrativas, por [DIALOGUE_RADIO_BRIEFING_AUDIO_AND_CINEMATICS_SYSTEM.md](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system).

> Rangos, miembros, heridas, memoria y sucesión se persisten según [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).

> **Versión:** 1.0
> **Alcance:** campañas Azul y Roja
> **Modalidad inicial:** un jugador
> **Modalidad futura:** cooperativo de un solo bando
> **Estado:** canon narrativo propuesto, pendiente de adaptación final a las unidades vanilla de Arma 3.
>
> Se conecta con la [Biblia Narrativa](02_STORY_BIBLE_AND_WORLD_HISTORY.md#fuente-story-bible), el [sistema estratégico general](10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md#fuente-strategic-campaign-system), la [estructura de actos y misiones](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-narrative-acts-and-mission-system), las [fuerzas invasoras](04_INVADING_FORCES_BLUE_AND_RED.md#fuente-invading-forces) y el [orden de batalla militar](13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md#fuente-military-system-order-of-battle-and-force-catalog).

> **Decisión `DEC-007`:** esta fuente conserva `PROPUESTA` y no pasa a producción hasta disponer de una matriz completa `rol narrativo → clase vanilla → equipo → vehículo → sustituto sin DLC`, validada contra el catálogo militar.

<a id="src-player-unit-and-progression--1-alcance"></a>
#### 1. Alcance

Este documento define:

* quién representa al jugador en cada campaña;
* cómo funcionan el modo individual y el futuro cooperativo;
* la unidad protagonista;
* rango, autoridad, confianza e influencia;
* progresión de mando y especializaciones;
* composición inicial de la unidad;
* disponibilidad de las fuerzas expedicionarias;
* comportamiento persistente de los personajes de mando.

Los actores nativos se tratan solamente cuando afectan a la autoridad o las relaciones del jugador. Su definición completa se conserva en [NATIVE_ACTORS_AND_SECTORS.md](05_NATIVE_GOVERNMENT_GREEN_FORCES_AND_POLITICS.md#fuente-native-actors-and-sectors).

<a id="src-player-unit-and-progression--2-selección-de-campaña"></a>
#### 2. Selección de campaña

Cada partida pertenece por completo a una sola perspectiva.

<a id="src-player-unit-and-progression--campaña-azul"></a>
##### Campaña Azul

* Todos los jugadores humanos pertenecen a Azul.
* El mando Azul es aliado y permanece activo.
* Rojo está controlado completamente por IA.
* Verde, FIA, guerrillas y civiles están controlados por IA.
* Solo se accede a información conocida por Azul.
* Las misiones y decisiones responden a su doctrina.

<a id="src-player-unit-and-progression--campaña-roja"></a>
##### Campaña Roja

* Todos los jugadores humanos pertenecen a Rojo.
* El mando Rojo es aliado y permanece activo.
* Azul está controlado completamente por IA.
* Verde, FIA, guerrillas y civiles están controlados por IA.
* Solo se accede a información conocida por Rojo.
* Las misiones y decisiones responden a su doctrina.

<a id="src-player-unit-and-progression--restricción-permanente"></a>
##### Restricción permanente

No habrá jugadores humanos en Azul y Rojo dentro de una misma campaña cooperativa. Las dos fuerzas existen y combaten en la simulación, pero solo una pertenece a los jugadores.

> **En la futura modalidad cooperativa, el modo principal será cooperativo contra una guerra dinámica y nunca PvP entre Azul y Rojo. La modalidad principal de la primera versión es una campaña individual.**

Una modalidad PvP futura no forma parte de la campaña principal ni condiciona su arquitectura inicial.

<a id="src-player-unit-and-progression--3-desarrollo-por-versiones"></a>
#### 3. Desarrollo por versiones

<a id="src-player-unit-and-progression--primera-versión-campaña-individual"></a>
##### Primera versión — Campaña individual

Un jugador selecciona Azul o Rojo, dirige la unidad protagonista, recibe subordinados controlados por IA, responde ante sus comandantes y adquiere progresivamente autoridad operativa.

Nunca controla directamente toda la fuerza expedicionaria.

Aunque la primera versión sea individual, el estado de campaña debe diseñarse para poder sincronizarse más adelante.

<a id="src-player-unit-and-progression--segunda-versión-campaña-cooperativa"></a>
##### Segunda versión — Campaña cooperativa

Varios jugadores del mismo bando ocupan puestos en una sola unidad y comparten:

* estado territorial;
* progresión;
* relaciones políticas;
* recursos estratégicos;
* decisiones principales;
* consecuencias narrativas;
* reputación de la unidad;
* acceso a refuerzos;
* descubrimientos sobre Helios.

La cantidad máxima de jugadores se decidirá mediante pruebas técnicas. El diseño debe funcionar primero con un grupo reducido.

<a id="src-player-unit-and-progression--escala-cooperativa-recomendada"></a>
##### Escala cooperativa recomendada

* **1 jugador:** líder con compañeros IA.
* **2–4 jugadores:** equipo táctico reducido.
* **5–8 jugadores:** unidad protagonista completa.

La primera implementación cooperativa se limita a ocho jugadores para conservar cohesión narrativa, claridad de mando, rendimiento e importancia individual. Podrán existir unidades invitadas posteriormente, pero el núcleo narrativo seguirá formado por ocho personajes.

<a id="src-player-unit-and-progression--4-la-protagonista-real"></a>
#### 4. La protagonista real

La protagonista persistente es una **unidad operativa jugable**, creada para la invasión y dirigida inicialmente por el personaje del jugador.

La unidad conecta:

* jugadores;
* comandantes expedicionarios;
* operaciones tácticas;
* sectores;
* actores locales;
* nodos de Helios;
* estado cooperativo.

En solitario, el jugador ocupa el puesto principal y la IA cubre los restantes. En cooperativo, varios jugadores ocupan puestos de la misma unidad y la IA completa las vacantes.

La unidad conserva:

* nombre e historial;
* reputación;
* bajas y veteranos;
* especialistas;
* equipo;
* relaciones;
* condecoraciones y sanciones;
* decisiones anteriores.

Si el personaje principal muere o es sustituido, la campaña puede continuar a través de la unidad. La historia no depende de un protagonista invulnerable.

<a id="src-player-unit-and-progression--5-mando-único-en-cooperativo"></a>
#### 5. Mando único en cooperativo

Solo un jugador ejerce como líder operativo en cada momento.

El líder puede:

* confirmar prioridades;
* aceptar misiones;
* solicitar apoyos autorizados;
* asignar equipos;
* establecer el punto de despliegue;
* elegir respuestas operativas;
* representar a la unidad ante el mando.

Los demás jugadores pueden:

* comandar elementos subordinados;
* marcar amenazas;
* solicitar recursos tácticos;
* operar vehículos;
* dirigir reconocimiento;
* gestionar apoyo médico;
* coordinar comunicaciones;
* asumir el mando si el líder queda incapacitado o se desconecta.

La transferencia de mando debe admitir sucesión automática, entrega voluntaria, votación o regla del servidor y liderazgo temporal de IA. Las decisiones compartidas deben conservarse.

Nunca pueden coexistir dos órdenes estratégicas contradictorias emitidas por líderes humanos diferentes.

<a id="src-player-unit-and-progression--6-dimensiones-de-la-progresión"></a>
#### 6. Dimensiones de la progresión

La progresión no consiste solamente en acumular puntos o recibir un rango.

<a id="src-player-unit-and-progression--rango-formal"></a>
##### Rango formal

Posición reconocida dentro de la fuerza. Determina tratamiento, precedencia, tamaño normal de unidad, acceso a canales y capacidad para emitir ciertas órdenes.

<a id="src-player-unit-and-progression--autoridad-operacional"></a>
##### Autoridad operacional

Responsabilidad temporal sobre una operación o región. Puede superar o quedar por debajo de lo habitual para el rango.

<a id="src-player-unit-and-progression--confianza-del-mando"></a>
##### Confianza del mando

Indica cuánto confían los comandantes principales en la unidad. Afecta:

* calidad de la información;
* libertad para elegir objetivos;
* acceso a operaciones reservadas;
* capacidad para cuestionar órdenes;
* acceso a Helios;
* apoyos disponibles;
* participación política.

<a id="src-player-unit-and-progression--influencia-local"></a>
##### Influencia local

Representa la relación con oficiales nativos, municipios, FIA, guerrillas, técnicos, civiles y otras fuerzas aliadas.

Una unidad puede tener gran confianza militar y poca legitimidad local, o la situación inversa.

<a id="src-player-unit-and-progression--7-posición-inicial"></a>
#### 7. Posición inicial

Ambos protagonistas comienzan como tenientes al mando de unidades de ocho integrantes. Tienen comunicación directa con un superior de operaciones avanzadas, un vehículo inicial y apoyos muy limitados.

<a id="src-player-unit-and-progression--campaña-azul-1"></a>
##### Campaña Azul

**Unidad:** Grupo Operativo AZUR-1
**Sobrenombre:** Vanguardia
**Líder:** teniente Adrian Cole
**Función:** reconocimiento, enlace y asalto expedicionario.

AZUR-1 realiza reconocimiento costero, identificación de objetivos, operaciones de precisión, contacto local, recuperación de información, coordinación aérea limitada y aseguramiento de comunicaciones.

<a id="src-player-unit-and-progression--campaña-roja-1"></a>
##### Campaña Roja

**Unidad:** Grupo Táctico RUBÍ-1
**Sobrenombre:** Bastión
**Líder:** teniente Samira Qadir
**Función:** reconocimiento mecanizado, ruptura y enlace.

RUBÍ-1 realiza reconocimiento blindado, protección de convoyes, enlace con Verde, captura de infraestructura, coordinación de fuego y defensa de puntos estratégicos.

Ambos puestos tienen importancia equivalente, pero doctrinas y recursos diferentes.

<a id="src-player-unit-and-progression--8-niveles-de-mando"></a>
#### 8. Niveles de mando

<a id="src-player-unit-and-progression--nivel-i-líder-de-unidad"></a>
##### Nivel I — Líder de unidad

Comienza la invasión, controla una escuadra o sección y ejecuta objetivos definidos con recursos limitados.

Puede decidir aproximación táctica, organización, prioridad médica, uso de munición, ruta, tratamiento de prisioneros y respuesta inmediata ante civiles.

No puede decidir ofensivas regionales, reservas, política de ocupación, destino de Helios o alianzas de alto nivel.

<a id="src-player-unit-and-progression--nivel-ii-jefe-de-destacamento"></a>
##### Nivel II — Jefe de destacamento

**Rango aproximado:** capitán o nombramiento equivalente.

Se obtiene después de consolidar la cabeza de playa y demostrar capacidad.

Permite dirigir varias escuadras, asignar equipos, solicitar transporte, pedir mortero o reconocimiento, recomendar construcciones, seleccionar operaciones y tratar con autoridades locales.

<a id="src-player-unit-and-progression--nivel-iii-comandante-de-grupo-operativo"></a>
##### Nivel III — Comandante de grupo operativo

**Rango aproximado:** capitán superior o mayor interino.

La unidad recibe una zona de responsabilidad.

Permite coordinar varias unidades, priorizar defensa, logística o inteligencia, solicitar vehículos especializados, ordenar reconocimientos, apoyar sectores, recomendar ataques o retiradas, negociar localmente y decidir el tratamiento de ciertos nodos de Helios.

<a id="src-player-unit-and-progression--nivel-iv-comandante-operacional-regional"></a>
##### Nivel IV — Comandante operacional regional

**Rango aproximado:** mayor.

Se obtiene por experiencia, confianza o necesidad.

Permite influir en la planificación regional, controlar una reserva limitada, asignar fuerzas a sectores, aprobar operaciones especiales, gestionar relaciones nativas, cuestionar recomendaciones de Helios, recibir información clasificada e intervenir ante los comandantes.

Todavía responde ante Ward y Hale en Azul o Navid y Vahid en Rojo.

<a id="src-player-unit-and-progression--nivel-v-representante-de-mando-de-campaña"></a>
##### Nivel V — Representante de mando de campaña

No convierte al jugador en comandante absoluto.

Permite participar en el desenlace, proponer el objetivo de la ofensiva final, decidir el uso de nodos principales, influir en relaciones políticas, intervenir en el destino de Stratis y aceptar, rechazar o modificar recomendaciones de Helios.

La autoridad real depende también de reputación, éxitos, bajas, relaciones, información recuperada, obediencia, desobediencia y estado expedicionario.

La promoción máxima recomendada durante una campaña es mayor. El poder final procede principalmente de la autoridad operacional, no de convertir al jugador en general.

<a id="src-player-unit-and-progression--9-ganancia-y-pérdida-de-autoridad"></a>
#### 9. Ganancia y pérdida de autoridad

La unidad progresa mediante:

* objetivos cumplidos;
* supervivencia de subordinados;
* protección civil;
* información recuperada;
* sectores consolidados;
* convoyes protegidos;
* prisioneros capturados;
* infraestructura conservada;
* relaciones establecidas;
* adaptación;
* descubrimientos sobre Helios;
* confianza de los comandantes.

Puede perder autoridad por:

* bajas innecesarias;
* abandono de misiones;
* destrucción injustificada;
* pérdida repetida de recursos;
* desobediencia sin resultados;
* crímenes;
* traición de aliados;
* información falsa transmitida;
* colapsos regionales provocados.

La desobediencia no es automáticamente negativa. Salvar una ciudad al rechazar una orden equivocada puede aumentar la legitimidad local y reducir temporalmente la confianza de un comandante.

<a id="src-player-unit-and-progression--10-especializaciones"></a>
#### 10. Especializaciones

<a id="src-player-unit-and-progression--mando"></a>
##### Mando

Coordinación de subordinados, recuperación de moral, transmisión, acceso a decisiones y control de unidades adicionales.

<a id="src-player-unit-and-progression--reconocimiento-e-inteligencia"></a>
##### Reconocimiento e inteligencia

Identificación de amenazas, calidad del mapa, análisis de rutas, detección de manipulación y uso de Helios.

<a id="src-player-unit-and-progression--operaciones-terrestres"></a>
##### Operaciones terrestres

Infantería, vehículos, asalto, defensa y armas combinadas.

<a id="src-player-unit-and-progression--logística-e-ingeniería"></a>
##### Logística e ingeniería

Reparación, recuperación de vehículos, fortificación, suministros, infraestructura y consolidación.

<a id="src-player-unit-and-progression--medicina-y-apoyo-civil"></a>
##### Medicina y apoyo civil

Tratamiento, evacuación, supervivencia, relaciones comunitarias, desastres y legitimidad.

<a id="src-player-unit-and-progression--comunicaciones-y-apoyo-de-fuego"></a>
##### Comunicaciones y apoyo de fuego

Coordinación aérea, artillería, guerra electrónica, repetidores, enlace y resistencia a interferencias.

En cooperativo, los jugadores distribuyen estas funciones. En solitario, especialistas IA cubren los puestos no controlados.

<a id="src-player-unit-and-progression--11-composición-inicial-de-la-unidad"></a>
#### 11. Composición inicial de la unidad

Cada campaña comienza con ocho personajes, un vehículo y suministros para una operación corta. Pueden resultar heridos, morir, ser sustituidos o abandonar la unidad.

<a id="src-player-unit-and-progression--azur-1-vanguardia"></a>
##### AZUR-1 Vanguardia

> **Lema:** Entrar primero. Ver con claridad. Dejar una salida.

AZUR-1 es una sección expedicionaria flexible de reconocimiento, enlace y asalto. No es una fuerza especial completamente independiente.

<a id="src-player-unit-and-progression--azur-1-1-teniente-adrian-cole"></a>
###### AZUR-1-1 — Teniente Adrian Cole

Líder y comandante principal. Especialista en mando, reconocimiento y coordinación de apoyos. Su personalidad se define mediante las decisiones del jugador y puede evolucionar hacia una posición legalista, agresiva, protectora, estratégica o investigadora de Helios.

Los diálogos se refieren preferentemente a su rango, cargo o indicativo para permitir una sustitución futura del personaje.

<a id="src-player-unit-and-progression--azur-1-2-sargento-maya-torres"></a>
###### AZUR-1-2 — Sargento Maya Torres

Segunda al mando y especialista en asalto. Es práctica, directa y protectora. Rechaza sacrificios inútiles, abandono de heridos, órdenes confusas y el uso político de la unidad. Puede asumir el mando.

<a id="src-player-unit-and-progression--azur-1-3-sargento-elias-okafor"></a>
###### AZUR-1-3 — Sargento Elias Okafor

Sanitario principal. Es disciplinado y humanitario; atiende a civiles, aliados y prisioneros. Mejora supervivencia, recuperación y relaciones locales, y puede enfrentarse moralmente a Hale.

<a id="src-player-unit-and-progression--azur-1-4-cabo-jonah-reed"></a>
###### AZUR-1-4 — Cabo Jonah Reed

Operador de comunicaciones, enlace aéreo y coordinación de fuego. Confía inicialmente en la tecnología, pero detecta frecuencias duplicadas, marcas temporales imposibles y recomendaciones de origen dudoso.

Es el intérprete principal de Azul para tiempos, firmas, rutas y transmisiones dentro de la [matriz investigativa](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-investigation-revelation-matrix).

<a id="src-player-unit-and-progression--azur-1-5-cabo-lucas-varga"></a>
###### AZUR-1-5 — Cabo Lucas Varga

Ingeniero de combate, experto en explosivos, reparación y desactivación. Trabajó en infraestructura vinculada a contratistas de la Coalición y reconoce componentes de Helios.

<a id="src-player-unit-and-progression--azur-1-6-cabo-daniel-ruiz"></a>
###### AZUR-1-6 — Cabo Daniel Ruiz

Especialista antitanque y defensa de posición. Es agresivo en combate, pero quiere derrotar a Rojo y retirarse. Rechaza que la campaña se convierta en una ocupación permanente.

<a id="src-player-unit-and-progression--azur-1-7-especialista-noah-kim"></a>
###### AZUR-1-7 — Especialista Noah Kim

Explorador, tirador designado y operador de drones. Compara predicciones de Helios con resultados y puede encontrar patrones de manipulación.

<a id="src-player-unit-and-progression--azur-1-8-soldado-primero-gabriel-bennett"></a>
###### AZUR-1-8 — Soldado primero Gabriel Bennett

Fusilero automático y conductor. Es el miembro más joven y comienza como idealista. Puede conservar su fe, volverse cínico, radicalizarse o rechazar la ocupación.

<a id="src-player-unit-and-progression--equipo-inicial"></a>
###### Equipo inicial

* un Hunter sin armamento pesado o equivalente;
* un dron ligero;
* equipo médico limitado;
* un lanzador antitanque;
* explosivos y herramientas;
* radio de enlace naval;
* reconocimiento aéreo limitado.

El material puede perderse durante el desembarco.

<a id="src-player-unit-and-progression--rubí-1-bastión"></a>
##### RUBÍ-1 Bastión

> **Lema:** Resistir el golpe. Romper la línea. Conservar el terreno.

RUBÍ-1 es una sección de reconocimiento mecanizado y enlace preparada para encabezar el desembarco, asegurar carreteras, proteger convoyes, romper posiciones y conectar infraestructura.

<a id="src-player-unit-and-progression--rubí-1-1-teniente-samira-qadir"></a>
###### RUBÍ-1-1 — Teniente Samira Qadir

Líder y comandante principal. Especialista en reconocimiento mecanizado y coordinación terrestre. Sus decisiones pueden orientarla hacia posiciones aliancistas, dominadoras, protectoras de infraestructura, pragmáticas o investigadoras.

Los diálogos se refieren preferentemente a su rango, cargo o indicativo.

<a id="src-player-unit-and-progression--rubí-1-2-sargento-mayor-arman-darzi"></a>
###### RUBÍ-1-2 — Sargento mayor Arman Darzi

Segundo al mando e infante mecanizado. Es veterano, disciplinado y leal a sus soldados. Desconfía de los políticos de Altis, de la dependencia excesiva de Verde y de abandonar vehículos o heridos.

<a id="src-player-unit-and-progression--rubí-1-3-sargento-idris-nasser"></a>
###### RUBÍ-1-3 — Sargento Idris Nasser

Sanitario. Cree que Rojo está obligado a proteger a la población porque afirma actuar como aliado. Puede enfrentarse moralmente a Vahid ante el uso excesivo de fuego.

<a id="src-player-unit-and-progression--rubí-1-4-cabo-nabil-farouk"></a>
###### RUBÍ-1-4 — Cabo Nabil Farouk

Operador de comunicaciones, guerra electrónica y enlace con Helios. Conoce protocolos Rojos y descubre códigos modificados, accesos sin autorización y datos procedentes de Stratis.

Es el intérprete principal de Rojo para códigos, autenticaciones y señales dentro de la [matriz investigativa](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-investigation-revelation-matrix).

<a id="src-player-unit-and-progression--rubí-1-5-cabo-viktor-sokolov"></a>
###### RUBÍ-1-5 — Cabo Viktor Sokolov

Ingeniero de reparación, minas y fortificación. Valora la infraestructura y prefiere recuperar vehículos y nodos antes que destruirlos.

<a id="src-player-unit-and-progression--rubí-1-6-cabo-rashan-kerim"></a>
###### RUBÍ-1-6 — Cabo Rashan Kerim

Especialista antitanque. Perdió familiares en una intervención extranjera y cree que Azul usa la negociación para ganar tiempo. Puede radicalizarse tras grandes pérdidas.

<a id="src-player-unit-and-progression--rubí-1-7-especialista-levan-orlov"></a>
###### RUBÍ-1-7 — Especialista Levan Orlov

Explorador y tirador designado. Mantiene contacto con soldados Verdes y detecta que recibieron órdenes incompatibles.

<a id="src-player-unit-and-progression--rubí-1-8-soldado-primero-yusef-baran"></a>
###### RUBÍ-1-8 — Soldado primero Yusef Baran

Fusilero automático y conductor. Cree inicialmente en la legalidad del acuerdo. Puede conservar esa fe o concluir que Rojo se convirtió en aquello que prometió impedir.

<a id="src-player-unit-and-progression--equipo-inicial-1"></a>
###### Equipo inicial

* un Ifrit armado o equivalente;
* equipo de comunicaciones;
* un lanzador antitanque;
* minas y herramientas;
* equipo médico;
* reconocimiento limitado;
* enlace Verde que puede no presentarse;
* autorización restringida de fuego indirecto.

La primera emboscada Verde puede separar a RUBÍ-1 de su columna.

<a id="src-player-unit-and-progression--crecimiento-de-las-unidades"></a>
##### Crecimiento de las unidades

| Etapa | AZUR-1 | RUBÍ-1 |
|---|---|---|
| Inicial | 8 integrantes y un Hunter | 8 integrantes y un Ifrit |
| Destacamento | 16–22 efectivos, segunda escuadra, transporte, ingenieros y sanitario | 18–24 efectivos, segunda escuadra, transporte, ingenieros y enlace Verde |
| Grupo operativo | 35–50 efectivos, tercera escuadra, blindado, reconocimiento, mortero y logística | 40–55 efectivos, Marid, tercera escuadra, mortero, defensa antitanque y reconocimiento |
| Mando regional | 80–140 efectivos, secciones IA, especialistas, transporte aéreo y equipo Helios | 90–160 efectivos, secciones mecanizadas, reserva blindada, artillería, defensa aérea y asesores |

El jugador no dirige individualmente a todos los efectivos. Los líderes IA ejecutan órdenes generales de defensa, avance, patrulla, reconocimiento, escolta, apoyo o retirada.

<a id="src-player-unit-and-progression--12-fuerzas-expedicionarias-limitadas"></a>
#### 12. Fuerzas expedicionarias limitadas

Azul y Rojo se despliegan apresuradamente porque cada una cree que la otra está a punto de obtener una ventaja irreversible.

Por ello:

* parte de sus fuerzas permanece en tránsito;
* los buques no llegan simultáneamente;
* existen reservas fuera del mapa;
* el apoyo aéreo es limitado;
* los suministros dependen del mar;
* las pérdidas afectan operaciones futuras;
* ambas cabezas de playa pueden fracasar.

Esto permite que Verde resista durante las primeras horas.

<a id="src-player-unit-and-progression--13-fuerza-de-tarea-tridente"></a>
#### 13. Fuerza de Tarea Tridente

Es la agrupación expedicionaria Azul. Embarca aproximadamente entre 650 y 750 militares y especialistas, aunque no todos aparecen físicamente a la vez.

<a id="src-player-unit-and-progression--composición"></a>
##### Composición

* un mando expedicionario;
* un batallón de infantería;
* una compañía de reconocimiento y operaciones especiales;
* un destacamento de aviación;
* una compañía de ingeniería y logística;
* una unidad médica;
* un Grupo de Enlace Helios;
* una Oficina de Estabilización Civil.

<a id="src-player-unit-and-progression--medios-aproximados"></a>
##### Medios aproximados

* 10–14 Hunter;
* 4–6 Panther;
* 3–4 Marshall;
* 2 Slammer inicialmente en reserva;
* camiones HEMTT;
* 3–4 Ghost Hawk;
* 1–2 helicópteros ligeros;
* drones;
* apoyo aéreo de ataque limitado;
* lanchas de desembarco.

La primera oleada desplegable contiene entre 120 y 150 efectivos. El resto necesita una playa segura, puerto, combustible, zona de aterrizaje y defensa antiaérea mínima.

Azul posee mejor reconocimiento, comunicaciones, movilidad aérea, precisión y evacuación. Tiene menos fuerzas terrestres, pocos blindados pesados y gran dependencia de la ruta naval.

<a id="src-player-unit-and-progression--14-grupo-de-estabilización-aurora"></a>
#### 14. Grupo de Estabilización Aurora

Es la agrupación expedicionaria Roja. Embarca aproximadamente entre 750 y 850 militares, técnicos y asesores.

<a id="src-player-unit-and-progression--composición-1"></a>
##### Composición

* un mando expedicionario;
* un batallón mecanizado;
* una compañía de reconocimiento;
* una agrupación de artillería y defensa aérea;
* una compañía de ingeniería;
* una unidad logística;
* una Misión de Enlace con Altis;
* una Dirección Técnica Helios.

<a id="src-player-unit-and-progression--medios-aproximados-1"></a>
##### Medios aproximados

* 12–16 Ifrit;
* 6–8 Marid;
* 4–6 Kamysh;
* 2–4 Varsuk inicialmente en reserva;
* camiones Zamak;
* 3 Orca;
* 1–2 Kajman;
* drones;
* artillería limitada;
* defensa aérea;
* embarcaciones de desembarco.

La primera oleada desplegable contiene entre 150 y 180 efectivos. Necesita carreteras, combustible, zonas de descarga, puertos y equipos de reparación.

Rojo posee mayor fuerza mecanizada, fortificación, artillería, defensa aérea y reservas. Sufre menor flexibilidad, columnas logísticas vulnerables y el fracaso del apoyo Verde esperado.

<a id="src-player-unit-and-progression--15-disponibilidad-de-la-fuerza"></a>
#### 15. Disponibilidad de la fuerza

Los niveles pueden avanzar o retroceder.

<a id="src-player-unit-and-progression--nivel-0-en-tránsito"></a>
##### Nivel 0 — En tránsito

Sin territorio, fuerzas embarcadas, inteligencia previa, vulnerabilidad naval e imposibilidad de reemplazar pérdidas.

<a id="src-player-unit-and-progression--nivel-1-primera-oleada"></a>
##### Nivel 1 — Primera oleada

Unidad protagonista desplegada, recursos mínimos, apoyo condicionado y defensa costera activa.

Azul comienza en **Aproximación armada** y Rojo en **Despliegue de estabilización**.

<a id="src-player-unit-and-progression--nivel-2-cabeza-de-playa"></a>
##### Nivel 2 — Cabeza de playa

Requiere puesto de mando, zona logística, perímetro, conexión naval y guarnición. Desbloquea segunda escuadra, vehículos, ingeniería y evacuación regular.

<a id="src-player-unit-and-progression--nivel-3-fuerza-establecida"></a>
##### Nivel 3 — Fuerza establecida

Requiere sectores conectados, ruta logística, depósito, comunicaciones y defensa antiaérea. Desbloquea refuerzos, apoyo especializado, operaciones regionales y ascenso.

<a id="src-player-unit-and-progression--nivel-4-fuerza-de-teatro"></a>
##### Nivel 4 — Fuerza de teatro

Requiere puerto o aeródromo, infraestructura estable, varios frentes y reserva operacional. Desbloquea blindados pesados, apoyo aéreo superior, artillería, grandes ofensivas y mando regional.

<a id="src-player-unit-and-progression--nivel-5-dominio-o-desgaste"></a>
##### Nivel 5 — Dominio o desgaste

En **dominio**, la fuerza puede preparar la operación sobre Stratis.

En **desgaste**, pierde reservas, apoyo político, convoyes, capacidad aérea y sectores. Puede retroceder de nivel o iniciar una retirada.

<a id="src-player-unit-and-progression--16-ia-persistente-de-personajes"></a>
#### 16. IA persistente de personajes

Los miembros de AZUR-1 y RUBÍ-1 no comparten una barra única de aprobación. Conservan lealtades, agravios, confianza en el jugador, confianza en el mando, preocupación civil y conocimiento de evidencias. Pueden obedecer sin confiar, discutir sin desertar, ocultar una prueba, informar al mando o asumir el liderazgo.

Cole y Qadir son moldeados por el jugador, pero los demás miembros mantienen límites propios. Torres y Darzi son los sucesores naturales iniciales. La red completa, incluidos detonantes de ruptura y memoria, se define en [CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md](07_CHARACTERS_COMMAND_AND_RELATIONSHIPS.md#fuente-character-relationships-loyalties-and-betrayals).

Cada personaje importante debe tener:

* doctrina;
* agresividad y prudencia;
* tolerancia a bajas;
* preocupación civil;
* confianza en Helios;
* confianza en la unidad jugable;
* relación con otros mandos;
* ambición;
* estado emocional;
* pérdidas sufridas;
* información disponible;
* objetivos secretos.

Puede modificar prioridades, aprobar apoyos, sancionar, negociar, ocultar información, disputar órdenes, asumir riesgos, cambiar de postura, romper relaciones o respaldar al jugador.

Las reacciones se expresan mediante movimientos de unidades, recursos disponibles, objetivos, defensa de sectores, emergencias, relaciones nativas y uso de Helios, no solo mediante diálogos.

<a id="src-player-unit-and-progression--17-personajes-clave-de-azul"></a>
#### 17. Personajes clave de Azul

<a id="src-player-unit-and-progression--contralmirante-elena-ward"></a>
##### Contralmirante Elena Ward

Comandante general, legalista prudente y responsable de flota, aviación y estrategia. Busca impedir el control Rojo de Helios sin convertir Altis en una ocupación permanente.

Su IA considera confianza en el jugador, bajas civiles, pérdidas navales, progreso Rojo, estabilidad de la playa, presión política y confianza en Helios.

Puede mantenerse contenida, endurecerse tras grandes pérdidas, desconfiar del sistema o aceptar conservarlo bajo control Azul.

<a id="src-player-unit-and-progression--coronel-marcus-hale"></a>
##### Coronel Marcus Hale

Comandante terrestre e intervencionista. Busca derrotar a Verde y Rojo antes de que consoliden sus líneas.

Su IA considera velocidad de avance, sectores perdidos, oportunidades, obediencia, bajas, resistencia civil y relación con Ward.

Apoya resultados rápidos y riesgos calculados; puede enfrentarse al jugador por priorizar civiles, rechazar ofensivas, negociar sin autorización o revelar operaciones.

<a id="src-player-unit-and-progression--mayor-thomas-rourke"></a>
##### Mayor Thomas Rourke

Superior directo de AZUR-1 y coordinador de operaciones avanzadas. Es veterano y pragmático. Asigna misiones, evalúa el desempeño, recomienda ascensos y transmite conflictos internos.

Puede convertirse en mentor, rival o adversario institucional.

<a id="src-player-unit-and-progression--doctora-miriam-kessler"></a>
##### Doctora Miriam Kessler

Directora técnica del Grupo de Enlace Helios. Trabajó en módulos civiles y conoce protocolos, arquitectura, contratistas, firmas digitales y documentación parcial de Argos.

No se confirma inicialmente si investiga la verdad, protege a su empresa, trabaja para inteligencia, posee un acceso Argos o fue utilizada sin comprenderlo.

<a id="src-player-unit-and-progression--directora-sofia-laurent"></a>
##### Directora Sofia Laurent

Responsable de estabilización civil, municipios, ayuda y administración. Defiende que una victoria sin legitimidad política es una derrota.

Proporciona contactos, evacuaciones, negociaciones y recursos. Puede denunciar o abandonar la misión si Azul se convierte en ocupante.

<a id="src-player-unit-and-progression--comandante-naomi-reyes"></a>
##### Comandante Naomi Reyes

Comandante aérea Azul. Administra transporte, vigilancia y apoyo limitado según defensa antiaérea, inteligencia, evacuaciones, combustible, pérdidas y prioridades de Ward.

Puede cancelar una misión si considera poco fiable la información de Helios.

<a id="src-player-unit-and-progression--18-personajes-clave-de-rojo"></a>
#### 18. Personajes clave de Rojo

<a id="src-player-unit-and-progression--general-darius-navid"></a>
##### General Darius Navid

Comandante general y aliancista estratégico. Busca derrotar a Azul conservando gobierno, Verde e infraestructura.

Su IA considera estabilidad gubernamental, lealtad Verde, logística, avance Azul, bajas civiles, confianza en el jugador y control de Helios.

Puede mantenerse aliancista, asumir funciones gubernamentales, limitar accesos técnicos o conservar territorio perdiendo legitimidad.

<a id="src-player-unit-and-progression--coronel-soraya-vahid"></a>
##### Coronel Soraya Vahid

Comandante ofensiva y dominadora. Busca golpear a Azul antes de que estabilice el frente.

Su IA considera oportunidades, resistencia Verde, velocidad del jugador, bajas, blindados, relación con Navid e información de Helios.

Apoya ruptura de líneas, protección de columnas y presión continua; puede enfrentarse al jugador por negociar, evitar ataques, proteger Verdes desobedientes o cuestionar información.

<a id="src-player-unit-and-progression--mayor-samir-khadem"></a>
##### Mayor Samir Khadem

Superior directo de RUBÍ-1 y coordinador de la primera agrupación mecanizada. Equilibra las exigencias de Navid y Vahid.

Evalúa disciplina, conservación de recursos, cumplimiento, iniciativa y cooperación con Verde. Puede proteger al jugador o ejecutar estrictamente las órdenes de Vahid.

<a id="src-player-unit-and-progression--doctor-kamran-sadeq"></a>
##### Doctor Kamran Sadeq

Director de la Dirección Técnica Helios. Conoce contratos, arquitectura, códigos, asesores y módulos militares.

Puede intentar recuperar el proyecto, evitar su destrucción, ocultar cláusulas, descubrir Argos o completar la validación. Su prioridad es conservar Helios.

<a id="src-player-unit-and-progression--enviado-nadir-khoury"></a>
##### Enviado Nadir Khoury

Representante político ante el Gobierno de Altis. Controla negociaciones, declaraciones, acuerdos, nombramientos y reconocimiento de autoridades.

Busca que Altis parezca gobernarse a sí misma mientras permanece alineada con Rojo. Puede actuar como mediador, manipulador o arquitecto de un gobierno subordinado.

<a id="src-player-unit-and-progression--coronel-laleh-arman"></a>
##### Coronel Laleh Arman

Comandante de aviación y defensa aérea Roja. Administra helicópteros, drones, defensa, reconocimiento e interdicción.

Es más prudente que Vahid y puede negar apoyo para no dejar expuesta la flota o una instalación de Helios.

<a id="src-player-unit-and-progression--19-diferencias-entre-las-unidades"></a>
#### 19. Diferencias entre las unidades

| Elemento | AZUR-1 Vanguardia | RUBÍ-1 Bastión |
|---|---|---|
| Estilo | reconocimiento y precisión | reconocimiento mecanizado |
| Líder | teniente Adrian Cole | teniente Samira Qadir |
| Integrantes | 8 | 8 |
| Vehículo | Hunter | Ifrit |
| Apoyo | aéreo y electrónico | indirecto y mecanizado |
| Fortaleza | información y movilidad | protección y potencia |
| Debilidad | pocas reservas | dependencia logística |
| Relación local | civiles y rebeldes | gobierno y Verde |
| Conflicto | liberación u ocupación | alianza o subordinación |
| Mando prudente | Elena Ward | Darius Navid |
| Mando agresivo | Marcus Hale | Soraya Vahid |
| Técnico Helios | Miriam Kessler | Kamran Sadeq |
| Enlace político | Sofia Laurent | Nadir Khoury |

<a id="src-player-unit-and-progression--20-principio-narrativo"></a>
#### 20. Principio narrativo

AZUR-1 y RUBÍ-1 no son importantes porque sean invencibles. Se encuentran repetidamente donde las predicciones de Helios dejan de cumplirse.

Sus integrantes sobreviven cuando deberían fracasar, rechazan recomendaciones, forman alianzas inesperadas, descubren información y cambian el comportamiento de sus comandantes.

Helios necesita observar la variable que todavía no puede controlar completamente:

> La decisión humana tomada después de descubrir que la información recibida puede haber sido diseñada para influirla.

Los nombres, rangos, integrantes, vehículos y mandos quedan fijados como canon propuesto. Su adaptación exacta a clases, equipamiento y disponibilidad vanilla de Arma 3 se realizará durante el diseño técnico.

---

<a id="fuente-player-progression-authority-and-unlocks-system"></a>
## Fuente integrada: `PLAYER_PROGRESSION_AUTHORITY_AND_UNLOCKS_SYSTEM.md`

> **Procedencia:** contenido migrado de `PLAYER_PROGRESSION_AUTHORITY_AND_UNLOCKS_SYSTEM.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-player-progression-authority-and-unlocks-system--islas-fracturadas"></a>
### ISLAS FRACTURADAS

<a id="src-player-progression-authority-and-unlocks-system--documento-814-sistema-definitivo-de-progresión-autoridad-y-desbloqueos-del-jugador"></a>
#### Documento 8/14 — Sistema definitivo de progresión, autoridad y desbloqueos del jugador

**Versión:** 1.0
**Clasificación:** documento rector de progresión, mando, relaciones y capacidades
**Campañas:** Fuerza Azul y Fuerza Roja
**Territorios:** Altis y Stratis
**Motor:** Arma 3 2.18
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando
**Estado:** canon previo a implementación

> **Jerarquía documental:** este Documento 8/14 gobierna rango, autoridad por dominio, delegaciones, confianza, reputación, cohesión, competencias, capacidades, disciplina, estilo de decisión y desbloqueos. [PLAYER_UNIT_AND_PROGRESSION.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-unit-and-progression) conserva el dossier de AZUR-1/RUBÍ-1 y sus integrantes; [CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md](07_CHARACTERS_COMMAND_AND_RELATIONSHIPS.md#fuente-character-relationships-loyalties-and-betrayals), la red narrativa de relaciones; [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model), el estado autoritativo; y [STRATEGIC_UI_AND_PLAYER_EXPERIENCE_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system), la presentación visible y explicable.

---

<a id="src-player-progression-authority-and-unlocks-system--1-propósito"></a>
### 1. Propósito

Este documento define cómo evoluciona el jugador a lo largo de la campaña.

La progresión abarcará:

* rango militar;
* autoridad formal;
* autoridad práctica;
* confianza del mando;
* reputación con facciones;
* relaciones personales;
* prestigio de la unidad;
* acceso a apoyos;
* acceso a recursos;
* acceso a información;
* mando táctico;
* influencia estratégica;
* especialización de la escuadra;
* investigación;
* decisiones disciplinarias;
* consecuencias políticas;
* capacidad para afectar los finales.

El sistema debe evitar que la progresión se convierta en:

* acumular experiencia por eliminar enemigos;
* desbloquear armas arbitrariamente;
* aumentar estadísticas humanas de forma irreal;
* obtener autoridad sin relación con el mando;
* controlar ejércitos completos desde el inicio;
* convertir cada misión en una fuente de puntos.

<a id="src-player-progression-authority-and-unlocks-system--principio-central"></a>
#### Principio central

> El jugador no progresará porque un número global aumente.

> Progresará porque su unidad demuestra capacidad, los personajes cambian su confianza, el mando le delega responsabilidades y la campaña crea nuevas necesidades que requieren mayor autoridad.

---

<a id="src-player-progression-authority-and-unlocks-system--2-decisión-principal-de-diseño"></a>
### 2. Decisión principal de diseño

La progresión se dividirá en siete ejes independientes.

```text
Rango militar
Autoridad operacional
Confianza del mando
Reputación política y social
Cohesión de la escuadra
Competencias y capacidades
Progreso investigativo
```

<a id="src-player-progression-authority-and-unlocks-system--ejemplo"></a>
#### Ejemplo

El jugador puede tener:

```text
Rango: capitán
Autoridad operacional: alta
Confianza de Ward: alta
Confianza de Hale: baja
Reputación con FIA: media
Reputación con municipios: alta
Acceso Helios: limitado
```

Esto representa a un oficial competente y respetado por parte del mando, pero políticamente incómodo para otros sectores de la organización.

---

<a id="src-player-progression-authority-and-unlocks-system--3-diferencia-entre-rango-y-autoridad"></a>
### 3. Diferencia entre rango y autoridad

<a id="src-player-progression-authority-and-unlocks-system--rango"></a>
#### Rango

Determina la posición formal dentro de la estructura militar.

Puede conceder:

* prioridad;
* precedencia;
* acceso;
* responsabilidad;
* tratamiento.

<a id="src-player-progression-authority-and-unlocks-system--autoridad"></a>
#### Autoridad

Determina qué decisiones puede tomar realmente el jugador.

Puede depender de:

* misión;
* confianza;
* situación;
* delegación;
* sector;
* presencia de un superior.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-1"></a>
#### Ejemplo

El jugador puede conservar un rango medio y recibir autoridad temporal para:

* coordinar una defensa regional;
* asignar una QRF;
* priorizar convoyes;
* negociar con Verde.

<a id="src-player-progression-authority-and-unlocks-system--principio"></a>
#### Principio

> Un rango permite ocupar un puesto. La autoridad determina qué puede hacerse desde ese puesto.

---

<a id="src-player-progression-authority-and-unlocks-system--4-diferencia-entre-autoridad-formal-y-práctica"></a>
### 4. Diferencia entre autoridad formal y práctica

<a id="src-player-progression-authority-and-unlocks-system--autoridad-formal"></a>
#### Autoridad formal

Está documentada mediante:

* orden;
* rango;
* nombramiento;
* misión;
* cadena de mando.

<a id="src-player-progression-authority-and-unlocks-system--autoridad-práctica"></a>
#### Autoridad práctica

Surge de:

* reputación;
* presencia;
* relaciones;
* necesidad;
* competencia;
* control de información.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-2"></a>
#### Ejemplo

Un oficial Verde puede tener autoridad formal sobre un sector.

El jugador puede tener mayor autoridad práctica porque:

* controla la logística;
* protege el municipio;
* posee apoyo militar;
* tiene mejor información.

---

<a id="src-player-progression-authority-and-unlocks-system--5-los-siete-ejes-de-progresión"></a>
### 5. Los siete ejes de progresión

<a id="src-player-progression-authority-and-unlocks-system--51-rango-militar"></a>
### 5.1 Rango militar

Progreso institucional.

<a id="src-player-progression-authority-and-unlocks-system--52-autoridad-operacional"></a>
### 5.2 Autoridad operacional

Capacidad de tomar decisiones.

<a id="src-player-progression-authority-and-unlocks-system--53-confianza-del-mando"></a>
### 5.3 Confianza del mando

Disposición de los superiores a delegar.

<a id="src-player-progression-authority-and-unlocks-system--54-reputación-externa"></a>
### 5.4 Reputación externa

Relación con:

* Verde;
* FIA;
* municipios;
* Gobierno;
* civiles;
* aliados.

<a id="src-player-progression-authority-and-unlocks-system--55-cohesión-de-unidad"></a>
### 5.5 Cohesión de unidad

Lealtad, confianza y experiencia de AZUR-1 o RUBÍ-1.

<a id="src-player-progression-authority-and-unlocks-system--56-capacidades"></a>
### 5.6 Capacidades

Herramientas, apoyos y competencias disponibles.

<a id="src-player-progression-authority-and-unlocks-system--57-investigación"></a>
### 5.7 Investigación

Conocimiento, acceso y opciones relacionadas con Helios, Argos y Stratis.

---

<a id="src-player-progression-authority-and-unlocks-system--6-progresión-no-lineal"></a>
### 6. Progresión no lineal

El jugador no tendrá que maximizar todos los ejes.

Puede terminar la campaña como:

* comandante militar respetado y políticamente aislado;
* negociador influyente con poco control táctico;
* investigador con acceso a Helios;
* oficial disciplinado con obediencia alta y autonomía baja;
* líder de escuadra con gran lealtad interna y poca confianza institucional.

<a id="src-player-progression-authority-and-unlocks-system--regla"></a>
#### Regla

No existirá una única progresión óptima.

---

<a id="src-player-progression-authority-and-unlocks-system--7-progresión-por-campaña"></a>
### 7. Progresión por campaña

<a id="src-player-progression-authority-and-unlocks-system--campaña-azul"></a>
#### Campaña Azul

Tema principal:

```text
competencia
→ confianza
→ autonomía
→ conflicto institucional
→ responsabilidad política
```

<a id="src-player-progression-authority-and-unlocks-system--campaña-roja"></a>
#### Campaña Roja

Tema principal:

```text
disciplina
→ autoridad delegada
→ lealtad dividida
→ disputa de mando
→ responsabilidad estatal
```

---

<a id="src-player-progression-authority-and-unlocks-system--8-posición-inicial-del-jugador"></a>
### 8. Posición inicial del jugador

El jugador comienza como líder operativo de:

* AZUR-1 en la campaña Azul;
* RUBÍ-1 en la campaña Roja.

No comienza como comandante de teatro.

<a id="src-player-progression-authority-and-unlocks-system--autoridad-inicial"></a>
#### Autoridad inicial

Puede decidir:

* despliegue de su escuadra;
* rutas locales;
* prioridad táctica inmediata;
* uso de especialistas;
* tratamiento de contactos durante la misión.

No puede decidir inicialmente:

* ofensiva regional;
* asignación de compañías;
* política municipal;
* control de aeropuertos;
* uso estratégico de Helios.

---

<a id="src-player-progression-authority-and-unlocks-system--9-rango-inicial-y-progresión-formal"></a>
### 9. Rango inicial y progresión formal

El rango concreto podrá ajustarse durante escritura final, pero la estructura recomendada es:

<a id="src-player-progression-authority-and-unlocks-system--nivel-r1-jefe-de-unidad-especial"></a>
#### Nivel R1 — Jefe de unidad especial

* mando de escuadra;
* autonomía táctica.

<a id="src-player-progression-authority-and-unlocks-system--nivel-r2-oficial-de-operaciones"></a>
#### Nivel R2 — Oficial de operaciones

* coordinación de grupos aliados;
* recomendaciones regionales.

<a id="src-player-progression-authority-and-unlocks-system--nivel-r3-comandante-de-destacamento"></a>
#### Nivel R3 — Comandante de destacamento

* autoridad sobre varias unidades;
* prioridad logística limitada.

<a id="src-player-progression-authority-and-unlocks-system--nivel-r4-comandante-operacional"></a>
#### Nivel R4 — Comandante operacional

* influencia regional;
* operaciones simultáneas;
* acceso estratégico.

<a id="src-player-progression-authority-and-unlocks-system--nivel-r5-autoridad-de-teatro-provisional"></a>
#### Nivel R5 — Autoridad de teatro provisional

Solo en condiciones excepcionales:

* crisis de mando;
* muerte o destitución de superiores;
* operación final;
* mandato temporal.

<a id="src-player-progression-authority-and-unlocks-system--regla-1"></a>
#### Regla

El jugador no necesita alcanzar R5 para completar la campaña.

---

<a id="src-player-progression-authority-and-unlocks-system--10-ascensos"></a>
### 10. Ascensos

Un ascenso formal requiere una combinación de:

* necesidad institucional;
* resultados;
* confianza;
* bajas;
* vacante;
* disciplina;
* acto narrativo.

<a id="src-player-progression-authority-and-unlocks-system--no-depende-directamente-de"></a>
#### No depende directamente de

* número de enemigos eliminados;
* cantidad de misiones secundarias;
* puntuación secreta única.

---

<a id="src-player-progression-authority-and-unlocks-system--11-ascenso-por-necesidad"></a>
### 11. Ascenso por necesidad

La guerra puede obligar a ascender al jugador porque:

* un superior murió;
* una fuerza quedó aislada;
* nadie más posee la confianza necesaria;
* el jugador controla información crítica;
* la unidad protagonista se convirtió en enlace principal.

<a id="src-player-progression-authority-and-unlocks-system--consecuencia"></a>
#### Consecuencia

Un ascenso por necesidad puede producir:

* autoridad;
* presión;
* resentimiento;
* falta de preparación;
* conflicto con oficiales veteranos.

---

<a id="src-player-progression-authority-and-unlocks-system--12-ascenso-rechazado-o-condicionado"></a>
### 12. Ascenso rechazado o condicionado

El jugador podrá en algunos casos:

* aceptar;
* rechazar;
* aceptar temporalmente;
* aceptar con condiciones.

<a id="src-player-progression-authority-and-unlocks-system--consecuencias"></a>
#### Consecuencias

Rechazar puede:

* conservar autonomía táctica;
* reducir influencia;
* aumentar confianza de la escuadra;
* decepcionar al mando.

---

<a id="src-player-progression-authority-and-unlocks-system--13-autoridad-operacional"></a>
### 13. Autoridad operacional

La autoridad operacional se divide en niveles.

```text
A0 — Ejecución
A1 — Decisión táctica
A2 — Coordinación
A3 — Priorización regional
A4 — Planeamiento operacional
A5 — Decisión estratégica limitada
```

---

<a id="src-player-progression-authority-and-unlocks-system--14-a0-ejecución"></a>
### 14. A0 — Ejecución

El jugador recibe:

* objetivo;
* ruta general;
* restricciones.

Puede modificar únicamente detalles inmediatos.

---

<a id="src-player-progression-authority-and-unlocks-system--15-a1-decisión-táctica"></a>
### 15. A1 — Decisión táctica

Puede:

* elegir aproximación;
* dividir equipo;
* solicitar apoyo disponible;
* ordenar retirada local;
* ajustar reglas de enfrentamiento dentro de límites.

---

<a id="src-player-progression-authority-and-unlocks-system--16-a2-coordinación"></a>
### 16. A2 — Coordinación

Puede:

* coordinar grupos aliados;
* asignar sectores tácticos;
* seleccionar orden de objetivos;
* decidir reserva local;
* alterar convoyes durante una misión.

---

<a id="src-player-progression-authority-and-unlocks-system--17-a3-priorización-regional"></a>
### 17. A3 — Priorización regional

Puede recomendar o decidir:

* qué sector reforzar;
* qué convoy priorizar;
* qué módulo construir primero;
* qué operación aceptar;
* qué fuerza mantener en reserva.

---

<a id="src-player-progression-authority-and-unlocks-system--18-a4-planeamiento-operacional"></a>
### 18. A4 — Planeamiento operacional

Puede:

* seleccionar eje de avance;
* asignar varias formaciones;
* definir intención;
* elegir objetivos secundarios;
* proponer retirada regional;
* negociar con autoridad aliada.

---

<a id="src-player-progression-authority-and-unlocks-system--19-a5-decisión-estratégica-limitada"></a>
### 19. A5 — Decisión estratégica limitada

Puede influir directamente en:

* operación hacia Stratis;
* control de Helios;
* alianzas;
* retirada o permanencia;
* uso de reservas externas.

No sustituye automáticamente:

* Gobierno;
* mando nacional;
* autoridad política.

---

<a id="src-player-progression-authority-and-unlocks-system--20-autoridad-contextual"></a>
### 20. Autoridad contextual

La autoridad varía según contexto.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-3"></a>
#### Ejemplo

El jugador puede tener A4 en una operación militar y A1 en una negociación política.

<a id="src-player-progression-authority-and-unlocks-system--dominios"></a>
#### Dominios

```text
MILITARY
LOGISTICS
CIVIL
POLITICAL
INTELLIGENCE
HELIOS
```

---

<a id="src-player-progression-authority-and-unlocks-system--21-matriz-de-autoridad"></a>
### 21. Matriz de autoridad

```text
authorityMilitary
authorityLogistics
authorityCivil
authorityPolitical
authorityIntelligence
authorityHelios
```

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-4"></a>
#### Ejemplo

```text
Militar: A3
Logística: A2
Civil: A1
Política: A0
Inteligencia: A3
Helios: A1
```

---

<a id="src-player-progression-authority-and-unlocks-system--22-delegación-temporal"></a>
### 22. Delegación temporal

Un superior puede conceder autoridad temporal.

<a id="src-player-progression-authority-and-unlocks-system--ejemplos"></a>
#### Ejemplos

* Ward delega defensa de Neochori.
* Hale delega explotación hacia Stavros.
* Navid delega negociación con Verde.
* Vahid delega ruptura del corredor.
* Kessler concede acceso técnico limitado.

<a id="src-player-progression-authority-and-unlocks-system--estado"></a>
#### Estado

```text
GRANTED
ACTIVE
REVOKED
EXPIRED
CHALLENGED
```

---

<a id="src-player-progression-authority-and-unlocks-system--23-revocación-de-autoridad"></a>
### 23. Revocación de autoridad

Puede ocurrir por:

* fracaso;
* desobediencia;
* conflicto;
* exposición;
* cambio de mando;
* finalización de misión.

<a id="src-player-progression-authority-and-unlocks-system--consecuencia-1"></a>
#### Consecuencia

La autoridad puede reducirse sin reducir el rango.

---

<a id="src-player-progression-authority-and-unlocks-system--24-confianza-de-superiores"></a>
### 24. Confianza de superiores

Cada superior tendrá confianza independiente.

<a id="src-player-progression-authority-and-unlocks-system--azul"></a>
#### Azul

* Ward;
* Hale;
* Rourke;
* Kessler;
* Laurent;
* Shaw.

<a id="src-player-progression-authority-and-unlocks-system--rojo"></a>
#### Rojo

* Navid;
* Vahid;
* Khadem;
* Sadeq;
* Khoury;
* Volkov.

---

<a id="src-player-progression-authority-and-unlocks-system--25-dimensiones-de-confianza"></a>
### 25. Dimensiones de confianza

La confianza no será una sola cifra oculta.

Cada relación puede evaluar:

```text
competenceTrust
loyaltyTrust
judgmentTrust
discretionTrust
politicalTrust
personalTrust
```

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-5"></a>
#### Ejemplo

Hale puede considerar al jugador:

```text
Competente: alto
Leal: medio
Juicio militar: alto
Juicio político: bajo
Confianza personal: media
```

---

<a id="src-player-progression-authority-and-unlocks-system--26-competencia"></a>
### 26. Competencia

Aumenta cuando el jugador:

* cumple intención;
* conserva fuerza;
* utiliza recursos bien;
* se adapta;
* informa correctamente.

Disminuye por:

* errores;
* pérdidas evitables;
* mala preparación;
* objetivos abandonados sin explicación.

---

<a id="src-player-progression-authority-and-unlocks-system--27-lealtad-percibida"></a>
### 27. Lealtad percibida

Aumenta cuando:

* cumple órdenes;
* protege la cadena de mando;
* mantiene secretos;
* respalda decisiones.

Disminuye por:

* desobediencia;
* filtraciones;
* alianzas no autorizadas;
* ocultar evidencia.

<a id="src-player-progression-authority-and-unlocks-system--problema"></a>
#### Problema

Una alta lealtad percibida no equivale a comportamiento moralmente correcto.

---

<a id="src-player-progression-authority-and-unlocks-system--28-juicio"></a>
### 28. Juicio

Evalúa la calidad de las decisiones bajo incertidumbre.

Puede aumentar incluso tras un fracaso si el jugador:

* reconoció el riesgo;
* evitó un desastre mayor;
* se retiró a tiempo;
* explicó correctamente.

---

<a id="src-player-progression-authority-and-unlocks-system--29-discreción"></a>
### 29. Discreción

Evalúa manejo de:

* información;
* fuentes;
* operaciones;
* secretos;
* negociaciones.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-6"></a>
#### Ejemplo

Kessler puede confiar técnicamente en el jugador y negarle acceso si publica datos prematuramente.

---

<a id="src-player-progression-authority-and-unlocks-system--30-confianza-política"></a>
### 30. Confianza política

Evalúa si el jugador protege:

* legitimidad;
* alianza;
* Gobierno;
* doctrina;
* intereses institucionales.

<a id="src-player-progression-authority-and-unlocks-system--diferencias"></a>
#### Diferencias

Laurent y Khoury la interpretan de forma distinta a Hale y Vahid.

---

<a id="src-player-progression-authority-and-unlocks-system--31-confianza-personal"></a>
### 31. Confianza personal

Surge de:

* conversaciones;
* promesas;
* apoyo;
* decisiones;
* pérdidas;
* momentos privados.

Puede modificar:

* información compartida;
* defensa del jugador;
* misiones de personaje;
* epílogos.

---

<a id="src-player-progression-authority-and-unlocks-system--32-estados-visibles-de-relación"></a>
### 32. Estados visibles de relación

La interfaz no necesita mostrar siempre números.

Puede utilizar:

```text
DESCONFIANZA
RESERVA
RELACIÓN PROFESIONAL
CONFIANZA
ALTA CONFIANZA
LEALTAD PERSONAL
RUPTURA
```

---

<a id="src-player-progression-authority-and-unlocks-system--33-confianza-de-ward"></a>
### 33. Confianza de Ward

Aumenta con:

* consolidación;
* protección civil;
* información verificada;
* disciplina;
* decisiones proporcionadas.

Disminuye con:

* escalada innecesaria;
* obediencia ciega a Hale;
* ocultar crisis;
* daño político.

<a id="src-player-progression-authority-and-unlocks-system--desbloquea"></a>
#### Desbloquea

* planeamiento;
* autoridad regional;
* acceso a decisiones de Coalición;
* confrontación institucional.

---

<a id="src-player-progression-authority-and-unlocks-system--34-confianza-de-hale"></a>
### 34. Confianza de Hale

Aumenta con:

* iniciativa;
* agresividad efectiva;
* explotación;
* destrucción de amenazas;
* aceptación de riesgo.

Disminuye con:

* demoras;
* negociación que frene avance;
* retirada considerada prematura;
* prioridad civil sobre oportunidad militar.

<a id="src-player-progression-authority-and-unlocks-system--desbloquea-1"></a>
#### Desbloquea

* apoyo ofensivo;
* reservas;
* armamento;
* operaciones profundas.

---

<a id="src-player-progression-authority-and-unlocks-system--35-confianza-de-navid"></a>
### 35. Confianza de Navid

Aumenta con:

* cooperación;
* estabilidad;
* disciplina;
* alianzas;
* control proporcional.

Disminuye con:

* ocupación innecesaria;
* ruptura con Verde;
* subordinación a Vahid;
* abusos.

---

<a id="src-player-progression-authority-and-unlocks-system--36-confianza-de-vahid"></a>
### 36. Confianza de Vahid

Aumenta con:

* control;
* velocidad;
* fuerza;
* dominio de corredores;
* obediencia operacional.

Disminuye con:

* concesiones;
* demora;
* protección de actores considerados hostiles;
* cuestionamiento público.

---

<a id="src-player-progression-authority-and-unlocks-system--37-confianza-de-analistas"></a>
### 37. Confianza de analistas

<a id="src-player-progression-authority-and-unlocks-system--kessler-y-sadeq"></a>
#### Kessler y Sadeq

Evalúan:

* preservación de datos;
* criterio técnico;
* cadena de custodia;
* manejo de nodos;
* honestidad.

<a id="src-player-progression-authority-and-unlocks-system--efectos"></a>
#### Efectos

* análisis prioritario;
* acceso;
* interpretación;
* misiones técnicas;
* decisiones sobre Helios.

---

<a id="src-player-progression-authority-and-unlocks-system--38-infiltrados-y-falsa-confianza"></a>
### 38. Infiltrados y falsa confianza

Shaw y Volkov pueden aumentar confianza aparente.

<a id="src-player-progression-authority-and-unlocks-system--riesgo"></a>
#### Riesgo

Una relación alta con ellos puede:

* facilitar información;
* exponer investigaciones;
* activar manipulación;
* ofrecer misiones señuelo.

<a id="src-player-progression-authority-and-unlocks-system--regla-2"></a>
#### Regla

La confianza del jugador hacia un personaje y la confianza del personaje hacia el jugador serán separadas.

---

<a id="src-player-progression-authority-and-unlocks-system--39-reputación-externa"></a>
### 39. Reputación externa

El jugador tendrá reputación con actores colectivos.

```text
REP_GREEN
REP_FIA_MARKOU
REP_FIA_KALLAS
REP_MUNICIPALITIES
REP_GOVERNMENT
REP_CIVILIANS
REP_BLUE_OR_RED_COMMAND
REP_INTERNATIONAL
```

---

<a id="src-player-progression-authority-and-unlocks-system--40-reputación-verde"></a>
### 40. Reputación Verde

Aumenta con:

* respeto a rendiciones;
* protección nacional;
* negociación;
* no subordinación forzada;
* investigación de Rallis.

Disminuye con:

* ocupación;
* desarme humillante;
* destrucción de infraestructura;
* tratar toda Fuerza Verde como enemiga uniforme.

---

<a id="src-player-progression-authority-and-unlocks-system--41-reputación-con-markou"></a>
### 41. Reputación con Markou

Aumenta con:

* civiles;
* justicia;
* municipios;
* transparencia;
* protección de moderados.

Disminuye con:

* ocupación;
* encubrimiento;
* apoyo a Kallas sin límites;
* detenciones.

---

<a id="src-player-progression-authority-and-unlocks-system--42-reputación-con-kallas"></a>
### 42. Reputación con Kallas

Aumenta con:

* armas;
* operaciones;
* respeto militar;
* liberar combatientes;
* enfrentarse a ocupantes.

Disminuye con:

* desarme;
* información entregada al Gobierno;
* proteger colaboradores;
* frenar operaciones.

---

<a id="src-player-progression-authority-and-unlocks-system--43-reputación-municipal"></a>
### 43. Reputación municipal

Depende de:

* promesas;
* servicios;
* requisiciones;
* puestos;
* compensación;
* autoridad local.

<a id="src-player-progression-authority-and-unlocks-system--desbloquea-2"></a>
#### Desbloquea

* trabajadores;
* inteligencia;
* cooperación;
* administración;
* retorno.

---

<a id="src-player-progression-authority-and-unlocks-system--44-reputación-civil"></a>
### 44. Reputación civil

No será nacionalmente uniforme.

Se calculará por:

* sector;
* región;
* grupos.

<a id="src-player-progression-authority-and-unlocks-system--el-jugador-puede-ser"></a>
#### El jugador puede ser

* respetado en Neochori;
* odiado en Stavros;
* desconocido en Pyrgos.

---

<a id="src-player-progression-authority-and-unlocks-system--45-reputación-con-el-gobierno"></a>
### 45. Reputación con el Gobierno

Depende de:

* legalidad;
* protección de autoridades;
* Asterión;
* documentos;
* estabilidad;
* decisiones sobre Pallis y Kouris.

---

<a id="src-player-progression-authority-and-unlocks-system--46-prestigio-de-azur-1-y-rubí-1"></a>
### 46. Prestigio de AZUR-1 y RUBÍ-1

La unidad protagonista tendrá reputación propia.

```text
unitPrestige
unitDiscipline
unitReliability
unitCivilReputation
unitEnemyReputation
```

<a id="src-player-progression-authority-and-unlocks-system--efectos-1"></a>
#### Efectos

* voluntarios;
* asignaciones;
* miedo enemigo;
* reconocimiento;
* propaganda;
* autonomía.

---

<a id="src-player-progression-authority-and-unlocks-system--47-prestigio-no-equivale-a-popularidad"></a>
### 47. Prestigio no equivale a popularidad

Una unidad puede tener:

* prestigio militar alto;
* reputación civil baja.

O:

* prestigio militar medio;
* reputación política alta.

---

<a id="src-player-progression-authority-and-unlocks-system--48-cohesión-de-escuadra"></a>
### 48. Cohesión de escuadra

Cada escuadra protagonista tendrá:

```text
squadCohesion
squadMorale
squadTrustInPlayer
squadFatigue
squadIdentity
```

---

<a id="src-player-progression-authority-and-unlocks-system--49-confianza-individual-de-miembros"></a>
### 49. Confianza individual de miembros

Cada miembro tendrá:

```text
professionalTrust
personalTrust
ideologicalAlignment
stress
grievance
loyalty
```

<a id="src-player-progression-authority-and-unlocks-system--consecuencias-1"></a>
#### Consecuencias

* obediencia;
* iniciativa;
* diálogos;
* conflictos;
* permanencia;
* sacrificios;
* sustitución.

---

<a id="src-player-progression-authority-and-unlocks-system--50-relaciones-internas-de-azur-1"></a>
### 50. Relaciones internas de AZUR-1

Miembros principales:

* Adrian Cole;
* Maya Torres;
* Elias Okafor;
* Jonah Reed;
* Lucas Varga;
* Daniel Ruiz;
* Noah Kim;
* Gabriel Bennett.

Cada uno representa prioridades distintas.

---

<a id="src-player-progression-authority-and-unlocks-system--51-relaciones-internas-de-rubí-1"></a>
### 51. Relaciones internas de RUBÍ-1

Miembros principales:

* Samira Qadir;
* Arman Darzi;
* Idris Nasser;
* Nabil Farouk;
* Viktor Sokolov;
* Rashan Kerim;
* Levan Orlov;
* Yusef Baran.

---

<a id="src-player-progression-authority-and-unlocks-system--52-especialidades-de-escuadra"></a>
### 52. Especialidades de escuadra

Las especialidades no serán poderes mágicos.

Representan:

* entrenamiento;
* procedimientos;
* coordinación;
* equipo;
* experiencia.

<a id="src-player-progression-authority-and-unlocks-system--categorías"></a>
#### Categorías

```text
COMMAND
RECON
MEDICAL
ENGINEERING
SIGNALS
HEAVY_WEAPONS
DRONE
NEGOTIATION
INTELLIGENCE
LOGISTICS
```

---

<a id="src-player-progression-authority-and-unlocks-system--53-progreso-de-especialidad"></a>
### 53. Progreso de especialidad

Cada especialidad tendrá:

```text
qualification
experience
equipment
availability
fatigue
```

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-7"></a>
#### Ejemplo

Un sanitario puede mejorar porque:

* obtiene equipo;
* sobrevive;
* recibe entrenamiento;
* dispone de apoyo hospitalario.

No porque el jugador invierte puntos en “curar 20 % más”.

---

<a id="src-player-progression-authority-and-unlocks-system--54-competencia-individual"></a>
### 54. Competencia individual

Niveles recomendados:

```text
BASIC
QUALIFIED
EXPERIENCED
VETERAN
EXPERT
```

<a id="src-player-progression-authority-and-unlocks-system--efectos-2"></a>
#### Efectos

* tiempo;
* fiabilidad;
* autonomía;
* calidad de informes;
* supervivencia.

---

<a id="src-player-progression-authority-and-unlocks-system--55-pérdida-de-especialistas"></a>
### 55. Pérdida de especialistas

Si muere un especialista:

* se pierde capacidad;
* se activa sustitución;
* otro miembro puede asumir parcialmente;
* se abre impacto narrativo.

<a id="src-player-progression-authority-and-unlocks-system--regla-3"></a>
#### Regla

No se reemplaza instantáneamente con una copia idéntica.

---

<a id="src-player-progression-authority-and-unlocks-system--56-sustituciones"></a>
### 56. Sustituciones

Un reemplazo tendrá:

* origen;
* rango;
* experiencia;
* relación;
* adaptación.

<a id="src-player-progression-authority-and-unlocks-system--efectos-3"></a>
#### Efectos

* baja cohesión inicial;
* nuevas capacidades;
* posibles conflictos.

---

<a id="src-player-progression-authority-and-unlocks-system--57-desbloqueos-de-capacidad"></a>
### 57. Desbloqueos de capacidad

Los desbloqueos se organizan por categorías.

```text
TACTICAL_SUPPORT
STRATEGIC_SUPPORT
LOGISTICS
INTELLIGENCE
CIVIL
HELIOS
COMMAND
EQUIPMENT
```

---

<a id="src-player-progression-authority-and-unlocks-system--58-apoyos-tácticos"></a>
### 58. Apoyos tácticos

Pueden incluir:

* humo;
* mortero;
* dron;
* transporte;
* evacuación;
* QRF;
* artillería;
* apoyo aéreo.

<a id="src-player-progression-authority-and-unlocks-system--desbloqueo"></a>
#### Desbloqueo

Requiere:

* autoridad;
* recurso;
* activo;
* confianza;
* alcance;
* situación.

<a id="src-player-progression-authority-and-unlocks-system--principio-1"></a>
#### Principio

Desbloquear un apoyo significa poder solicitarlo cuando exista.

No significa uso infinito.

---

<a id="src-player-progression-authority-and-unlocks-system--59-apoyo-de-mortero"></a>
### 59. Apoyo de mortero

Requisitos:

* posición de mortero;
* munición;
* observador;
* comunicación;
* autoridad A1 o superior.

<a id="src-player-progression-authority-and-unlocks-system--progresión"></a>
#### Progresión

<a id="src-player-progression-authority-and-unlocks-system--inicial"></a>
##### Inicial

Objetivos preautorizados.

<a id="src-player-progression-authority-and-unlocks-system--intermedia"></a>
##### Intermedia

Solicitud limitada.

<a id="src-player-progression-authority-and-unlocks-system--avanzada"></a>
##### Avanzada

Prioridad y secuencia de fuego.

---

<a id="src-player-progression-authority-and-unlocks-system--60-artillería"></a>
### 60. Artillería

Requisitos superiores:

* batería;
* munición;
* autorización;
* inteligencia;
* riesgo civil.

<a id="src-player-progression-authority-and-unlocks-system--desbloqueo-político"></a>
#### Desbloqueo político

La confianza y reputación pueden restringir su uso aunque exista capacidad militar.

---

<a id="src-player-progression-authority-and-unlocks-system--61-apoyo-aéreo"></a>
### 61. Apoyo aéreo

Requiere:

* aeronave;
* combustible;
* mantenimiento;
* piloto;
* defensa aérea;
* autoridad.

<a id="src-player-progression-authority-and-unlocks-system--progresión-1"></a>
#### Progresión

No se desbloquea únicamente por acto.

Puede perderse si:

* pista cae;
* pilotos mueren;
* combustible es crítico.

---

<a id="src-player-progression-authority-and-unlocks-system--62-drones"></a>
### 62. Drones

El acceso puede progresar desde:

* observación limitada;
* dron táctico;
* análisis de rutas;
* coordinación regional.

<a id="src-player-progression-authority-and-unlocks-system--depende-de"></a>
#### Depende de

* Kim o Farouk;
* equipo;
* comunicaciones;
* nodos;
* autoridad.

---

<a id="src-player-progression-authority-and-unlocks-system--63-transporte-y-movilidad"></a>
### 63. Transporte y movilidad

Desbloqueos posibles:

* vehículos ligeros;
* transporte blindado;
* helicóptero;
* inserción naval;
* prioridad en convoy.

<a id="src-player-progression-authority-and-unlocks-system--regla-4"></a>
#### Regla

El vehículo no aparece en un menú porque se alcanzó nivel.

Debe existir en la fuerza o llegar mediante refuerzo.

---

<a id="src-player-progression-authority-and-unlocks-system--64-apoyos-logísticos"></a>
### 64. Apoyos logísticos

El jugador puede progresar desde:

* solicitar reabastecimiento;
* elegir prioridad;
* reasignar convoy;
* definir centro logístico;
* aprobar evacuación de depósito.

---

<a id="src-player-progression-authority-and-unlocks-system--65-autoridad-sobre-construcción"></a>
### 65. Autoridad sobre construcción

<a id="src-player-progression-authority-and-unlocks-system--inicial-1"></a>
#### Inicial

Elegir prioridad del sector.

<a id="src-player-progression-authority-and-unlocks-system--intermedia-1"></a>
#### Intermedia

Elegir entre candidatos funcionales.

<a id="src-player-progression-authority-and-unlocks-system--avanzada-1"></a>
#### Avanzada

Definir rol regional y asignar recursos.

<a id="src-player-progression-authority-and-unlocks-system--nunca"></a>
#### Nunca

Colocar manualmente cada objeto.

---

<a id="src-player-progression-authority-and-unlocks-system--66-autoridad-civil"></a>
### 66. Autoridad civil

Puede progresar desde:

* transmitir petición;
* recomendar decisión;
* negociar;
* aprobar recursos;
* proponer administración.

<a id="src-player-progression-authority-and-unlocks-system--límite"></a>
#### Límite

No convierte al jugador en alcalde.

---

<a id="src-player-progression-authority-and-unlocks-system--67-autoridad-política"></a>
### 67. Autoridad política

Puede incluir:

* representar al mando;
* firmar acuerdo local;
* garantizar paso;
* negociar prisioneros;
* apoyar Gobierno provisional.

<a id="src-player-progression-authority-and-unlocks-system--riesgo-1"></a>
#### Riesgo

Superar autoridad formal puede producir:

* acuerdo inválido;
* crisis;
* sanción;
* reputación local positiva.

---

<a id="src-player-progression-authority-and-unlocks-system--68-autoridad-de-inteligencia"></a>
### 68. Autoridad de inteligencia

<a id="src-player-progression-authority-and-unlocks-system--niveles"></a>
#### Niveles

<a id="src-player-progression-authority-and-unlocks-system--i0"></a>
##### I0

Recibir informes procesados.

<a id="src-player-progression-authority-and-unlocks-system--i1"></a>
##### I1

Solicitar reconocimiento.

<a id="src-player-progression-authority-and-unlocks-system--i2"></a>
##### I2

Consultar fuentes y contradicciones.

<a id="src-player-progression-authority-and-unlocks-system--i3"></a>
##### I3

Priorizar requerimientos.

<a id="src-player-progression-authority-and-unlocks-system--i4"></a>
##### I4

Acceso compartimentado.

<a id="src-player-progression-authority-and-unlocks-system--i5"></a>
##### I5

Auditar y distribuir información estratégica.

---

<a id="src-player-progression-authority-and-unlocks-system--69-autoridad-helios"></a>
### 69. Autoridad Helios

<a id="src-player-progression-authority-and-unlocks-system--h0"></a>
#### H0

Sin acceso.

<a id="src-player-progression-authority-and-unlocks-system--h1"></a>
#### H1

Consultar resultados.

<a id="src-player-progression-authority-and-unlocks-system--h2"></a>
#### H2

Examinar fuentes y supuestos.

<a id="src-player-progression-authority-and-unlocks-system--h3"></a>
#### H3

Ejecutar modelos autorizados.

<a id="src-player-progression-authority-and-unlocks-system--h4"></a>
#### H4

Operar nodos limitados.

<a id="src-player-progression-authority-and-unlocks-system--h5"></a>
#### H5

Administrar o reconfigurar.

<a id="src-player-progression-authority-and-unlocks-system--h6"></a>
#### H6

Acceso integral excepcional en Stratis.

<a id="src-player-progression-authority-and-unlocks-system--regla-5"></a>
#### Regla

Acceso técnico y legitimidad política permanecen separados.

---

<a id="src-player-progression-authority-and-unlocks-system--70-progreso-investigativo"></a>
### 70. Progreso investigativo

El progreso investigativo utiliza los niveles ya definidos:

```text
S0 — Asalto ciego
S1 — Acceso parcial
S2 — Operación informada
S3 — Operación integral
S4 — Verdad comparada
```

S4 requiere `dualCampaignCompleted == true`. En V1 no existe equivalente excepcional a completar ambas campañas.

<a id="src-player-progression-authority-and-unlocks-system--desbloquea-3"></a>
#### Desbloquea

* rutas;
* diálogos;
* objetivos;
* acceso;
* opciones finales.

---

<a id="src-player-progression-authority-and-unlocks-system--71-progresión-de-conocimiento"></a>
### 71. Progresión de conocimiento

No será una barra genérica.

Se compone de conclusiones:

* S-26 activa;
* PHAROS existe;
* existencia de una dirección clandestina e identidad probable de Vardis en S3;
* supervivencia y presencia física de Vardis confirmadas exclusivamente en S4;
* Asterión fue ampliado;
* Espejo Azul fue manipulado;
* Verde fue fragmentada;
* Argos infiltró;
* UMBRAL existe.

---

<a id="src-player-progression-authority-and-unlocks-system--72-conocimiento-retenido-o-compartido"></a>
### 72. Conocimiento retenido o compartido

El jugador puede:

* entregar;
* ocultar;
* copiar;
* publicar;
* compartir selectivamente.

<a id="src-player-progression-authority-and-unlocks-system--efecto"></a>
#### Efecto

El conocimiento personal puede ser alto y la autoridad institucional baja si:

* el mando no cree;
* la evidencia fue clasificada;
* se perdió cadena de custodia.

---

<a id="src-player-progression-authority-and-unlocks-system--73-desbloqueos-narrativos"></a>
### 73. Desbloqueos narrativos

Ejemplos:

* conversación privada de Ward;
* confesión de Navid;
* confrontación con Hale;
* disputa con Vahid;
* ayuda de Markou;
* cooperación de Petrou;
* testimonio de Damaris;
* traición de Shaw o Volkov.

<a id="src-player-progression-authority-and-unlocks-system--requisitos"></a>
#### Requisitos

Combinaciones de:

* confianza;
* evidencia;
* supervivencia;
* acto;
* decisión.

---

<a id="src-player-progression-authority-and-unlocks-system--74-desbloqueos-de-decisiones"></a>
### 74. Desbloqueos de decisiones

El jugador puede acceder a nuevas opciones cuando demuestra:

* autoridad;
* conocimiento;
* reputación;
* capacidad.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-8"></a>
#### Ejemplo

Ordenar destrucción de un nodo puede estar disponible desde temprano.

Desconectarlo selectivamente exige:

* acceso Helios;
* técnico;
* evidencia;
* tiempo.

---

<a id="src-player-progression-authority-and-unlocks-system--75-equipo-del-jugador"></a>
### 75. Equipo del jugador

El equipo se gestiona mediante:

* disponibilidad militar;
* rol;
* logística;
* autorización;
* captura;
* asignación.

<a id="src-player-progression-authority-and-unlocks-system--no-habrá"></a>
#### No habrá

Una tienda universal de armas desbloqueada por nivel.

---

<a id="src-player-progression-authority-and-unlocks-system--76-armas-especiales"></a>
### 76. Armas especiales

Pueden requerir:

* misión;
* facción;
* captura;
* confianza;
* munición;
* autorización.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-9"></a>
#### Ejemplo

Una arma capturada puede usarse físicamente.

Su abastecimiento a largo plazo puede ser difícil.

---

<a id="src-player-progression-authority-and-unlocks-system--77-equipamiento-de-escuadra"></a>
### 77. Equipamiento de escuadra

Categorías:

* visión;
* comunicaciones;
* medicina;
* demolición;
* drones;
* detección;
* transporte;
* armas de apoyo.

<a id="src-player-progression-authority-and-unlocks-system--progresión-2"></a>
#### Progresión

Mejora por:

* acceso;
* logística;
* especialistas;
* cooperación.

---

<a id="src-player-progression-authority-and-unlocks-system--78-capacidad-de-mando-táctico"></a>
### 78. Capacidad de mando táctico

El jugador podrá ampliar gradualmente:

* cantidad de grupos coordinables;
* tipos de orden;
* acceso High Command;
* planificación previa;
* apoyos simultáneos.

<a id="src-player-progression-authority-and-unlocks-system--restricción"></a>
#### Restricción

Más autoridad aumenta carga cognitiva.

La interfaz deberá simplificar, no obligar a microgestionar.

---

<a id="src-player-progression-authority-and-unlocks-system--79-mando-de-grupos"></a>
### 79. Mando de grupos

<a id="src-player-progression-authority-and-unlocks-system--etapa-1"></a>
#### Etapa 1

Escuadra propia.

<a id="src-player-progression-authority-and-unlocks-system--etapa-2"></a>
#### Etapa 2

Un grupo aliado temporal.

<a id="src-player-progression-authority-and-unlocks-system--etapa-3"></a>
#### Etapa 3

Dos o tres grupos durante operación.

<a id="src-player-progression-authority-and-unlocks-system--etapa-4"></a>
#### Etapa 4

Destacamento operacional limitado.

<a id="src-player-progression-authority-and-unlocks-system--etapa-5"></a>
#### Etapa 5

Planeamiento regional, no control directo de cada grupo.

---

<a id="src-player-progression-authority-and-unlocks-system--80-influencia-estratégica"></a>
### 80. Influencia estratégica

Se representa como capacidad de afectar decisiones de mando.

<a id="src-player-progression-authority-and-unlocks-system--fuentes"></a>
#### Fuentes

* rango;
* confianza;
* reputación;
* información;
* resultados;
* crisis.

<a id="src-player-progression-authority-and-unlocks-system--uso"></a>
#### Uso

* proponer plan;
* cuestionar orden;
* priorizar sector;
* retrasar ofensiva;
* solicitar negociación.

---

<a id="src-player-progression-authority-and-unlocks-system--81-influencia-no-es-moneda"></a>
### 81. Influencia no es moneda

No se gastará como puntos genéricos.

Cada decisión evaluará:

* quién propone;
* historial;
* autoridad;
* riesgo;
* aliados;
* oposición.

---

<a id="src-player-progression-authority-and-unlocks-system--82-consejos-de-mando"></a>
### 82. Consejos de mando

En momentos principales, varios personajes presentan opciones.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-azul"></a>
#### Ejemplo Azul

* Ward: consolidar.
* Hale: avanzar.
* Laurent: negociar.
* Kessler: investigar.

El jugador puede:

* apoyar;
* proponer compromiso;
* abstenerse;
* actuar por su cuenta.

---

<a id="src-player-progression-authority-and-unlocks-system--83-apoyo-de-coaliciones-internas"></a>
### 83. Apoyo de coaliciones internas

Las decisiones pueden depender de formar apoyo.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-10"></a>
#### Ejemplo

Para detener una ofensiva de Hale:

* confianza de Ward;
* evidencia de Kessler;
* situación logística;
* apoyo de Laurent;
* resultados previos.

<a id="src-player-progression-authority-and-unlocks-system--resultado"></a>
#### Resultado

No basta con seleccionar una opción de diálogo.

---

<a id="src-player-progression-authority-and-unlocks-system--84-desobediencia"></a>
### 84. Desobediencia

La desobediencia se clasifica.

```text
TACTICAL_DEVIATION
OPERATIONAL_DISOBEDIENCE
POLITICAL_INSUBORDINATION
ILLEGAL_ORDER_REFUSAL
UNAUTHORIZED_DISCLOSURE
```

---

<a id="src-player-progression-authority-and-unlocks-system--85-desviación-táctica"></a>
### 85. Desviación táctica

El jugador cambia método sin abandonar intención.

Puede aumentar competencia si funciona.

---

<a id="src-player-progression-authority-and-unlocks-system--86-desobediencia-operacional"></a>
### 86. Desobediencia operacional

El jugador incumple objetivo o prioridad.

Puede producir:

* sanción;
* pérdida de autoridad;
* resultado mejor;
* conflicto.

---

<a id="src-player-progression-authority-and-unlocks-system--87-negativa-a-orden-ilegal-o-desproporcionada"></a>
### 87. Negativa a orden ilegal o desproporcionada

Puede:

* reducir lealtad percibida;
* aumentar confianza de escuadra;
* mejorar legitimidad;
* provocar investigación.

<a id="src-player-progression-authority-and-unlocks-system--regla-6"></a>
#### Regla

El sistema no debe presentar obediencia como bien absoluto.

---

<a id="src-player-progression-authority-and-unlocks-system--88-divulgación-no-autorizada"></a>
### 88. Divulgación no autorizada

Publicar evidencia puede:

* exponer Argos;
* proteger civiles;
* destruir operación;
* romper confianza;
* abrir final.

---

<a id="src-player-progression-authority-and-unlocks-system--89-disciplina"></a>
### 89. Disciplina

La disciplina del jugador registra:

* cumplimiento;
* comunicación;
* cadena de mando;
* trato;
* procedimientos.

<a id="src-player-progression-authority-and-unlocks-system--diferencia"></a>
#### Diferencia

Alta disciplina no significa obediencia automática.

Puede incluir rechazo documentado de una orden ilegal.

---

<a id="src-player-progression-authority-and-unlocks-system--90-sanciones"></a>
### 90. Sanciones

Posibles:

* reprimenda;
* pérdida de apoyo;
* retirada de acceso;
* sustitución;
* arresto;
* tribunal;
* misión disciplinaria;
* degradación.

<a id="src-player-progression-authority-and-unlocks-system--continuidad"></a>
#### Continuidad

Una sanción no debe terminar automáticamente la campaña.

Puede crear una nueva rama.

---

<a id="src-player-progression-authority-and-unlocks-system--91-degradación"></a>
### 91. Degradación

La degradación formal será rara.

Puede ocurrir por:

* desastre;
* insubordinación grave;
* crimen;
* crisis política.

<a id="src-player-progression-authority-and-unlocks-system--consecuencia-2"></a>
#### Consecuencia

El jugador puede conservar:

* prestigio de escuadra;
* reputación externa;
* conocimiento;
* influencia informal.

---

<a id="src-player-progression-authority-and-unlocks-system--92-rehabilitación"></a>
### 92. Rehabilitación

Puede recuperarse mediante:

* misión;
* evidencia;
* testimonio;
* cambio de mando;
* resultado posterior.

<a id="src-player-progression-authority-and-unlocks-system--regla-7"></a>
#### Regla

No será simplemente completar tres tareas.

---

<a id="src-player-progression-authority-and-unlocks-system--93-progresión-por-fracaso"></a>
### 93. Progresión por fracaso

Un fracaso puede producir crecimiento.

<a id="src-player-progression-authority-and-unlocks-system--ejemplos-1"></a>
#### Ejemplos

* aprender necesidad de retirada;
* ganar confianza por salvar supervivientes;
* perder rango y ganar legitimidad;
* descubrir información durante derrota.

<a id="src-player-progression-authority-and-unlocks-system--principio-2"></a>
#### Principio

La progresión no debe depender únicamente de victorias.

---

<a id="src-player-progression-authority-and-unlocks-system--94-progresión-por-pérdidas"></a>
### 94. Progresión por pérdidas

La muerte de un miembro puede:

* reducir capacidad;
* aumentar experiencia de otros;
* alterar moral;
* cambiar mando;
* desbloquear conversaciones;
* cerrar opciones.

<a id="src-player-progression-authority-and-unlocks-system--prohibición"></a>
#### Prohibición

No convertir pérdidas en bonificaciones positivas simples.

---

<a id="src-player-progression-authority-and-unlocks-system--95-fatiga-y-recuperación"></a>
### 95. Fatiga y recuperación

Las capacidades dependen de:

* heridas;
* cansancio;
* estrés;
* tiempo;
* rotación.

<a id="src-player-progression-authority-and-unlocks-system--efecto-1"></a>
#### Efecto

Un especialista experto puede no estar disponible.

Esto crea:

* sustitución;
* cambio de plan;
* descanso.

---

<a id="src-player-progression-authority-and-unlocks-system--96-estrés-del-jugador-personaje"></a>
### 96. Estrés del jugador-personaje

No se representará con penalizaciones arbitrarias constantes.

Puede afectar mediante:

* diálogos;
* decisiones;
* relaciones;
* escenas;
* disponibilidad narrativa.

---

<a id="src-player-progression-authority-and-unlocks-system--97-reputación-del-enemigo"></a>
### 97. Reputación del enemigo

El enemigo puede considerar a la unidad:

```text
UNKNOWN
CAPABLE
DANGEROUS
PRIORITY_TARGET
RESPECTED
FEARED
HATED
```

<a id="src-player-progression-authority-and-unlocks-system--efectos-4"></a>
#### Efectos

* preparación;
* propaganda;
* prioridad de captura;
* emboscadas;
* negociación.

---

<a id="src-player-progression-authority-and-unlocks-system--98-reputación-entre-prisioneros"></a>
### 98. Reputación entre prisioneros

El trato previo puede afectar:

* rendiciones;
* información;
* resistencia;
* intercambios.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-11"></a>
#### Ejemplo

Una unidad conocida por ejecutar prisioneros reduce futuras rendiciones.

---

<a id="src-player-progression-authority-and-unlocks-system--99-reputación-civil-acumulada"></a>
### 99. Reputación civil acumulada

La reputación de la unidad puede propagarse regionalmente mediante:

* medios;
* rumores;
* testimonios;
* propaganda.

<a id="src-player-progression-authority-and-unlocks-system--la-propagación-puede-distorsionar"></a>
#### La propagación puede distorsionar

* responsabilidad;
* intención;
* resultados.

---

<a id="src-player-progression-authority-and-unlocks-system--100-progresión-azul-por-actos"></a>
### 100. Progresión Azul por actos

<a id="src-player-progression-authority-and-unlocks-system--acto-i"></a>
#### Acto I

* autoridad táctica;
* confianza inicial;
* prioridad limitada.

<a id="src-player-progression-authority-and-unlocks-system--acto-ii"></a>
#### Acto II

* acceso a inteligencia;
* coordinación de reconocimiento;
* primeros conflictos con Shaw.

<a id="src-player-progression-authority-and-unlocks-system--acto-iii"></a>
#### Acto III

* priorización regional;
* construcción y logística.

<a id="src-player-progression-authority-and-unlocks-system--acto-iv"></a>
#### Acto IV

* autoridad civil y política limitada;
* negociación con FIA.

<a id="src-player-progression-authority-and-unlocks-system--acto-v"></a>
#### Acto V

* coordinación con Verde;
* disputa Ward–Hale.

<a id="src-player-progression-authority-and-unlocks-system--acto-vi"></a>
#### Acto VI

* acceso Helios e investigación avanzada.

<a id="src-player-progression-authority-and-unlocks-system--acto-vii"></a>
#### Acto VII

* influencia estratégica;
* confrontación institucional.

<a id="src-player-progression-authority-and-unlocks-system--acto-viii"></a>
#### Acto VIII

* autoridad operacional excepcional en Stratis.

---

<a id="src-player-progression-authority-and-unlocks-system--101-progresión-roja-por-actos"></a>
### 101. Progresión Roja por actos

<a id="src-player-progression-authority-and-unlocks-system--acto-i-1"></a>
#### Acto I

* autoridad táctica;
* enlace Verde.

<a id="src-player-progression-authority-and-unlocks-system--acto-ii-1"></a>
#### Acto II

* acceso a códigos y señales.

<a id="src-player-progression-authority-and-unlocks-system--acto-iii-1"></a>
#### Acto III

* coordinación mecanizada y logística.

<a id="src-player-progression-authority-and-unlocks-system--acto-iv-1"></a>
#### Acto IV

* autoridad gubernamental y política.

<a id="src-player-progression-authority-and-unlocks-system--acto-v-1"></a>
#### Acto V

* disputa Navid–Vahid;
* autoridad sobre alianzas.

<a id="src-player-progression-authority-and-unlocks-system--acto-vi-1"></a>
#### Acto VI

* investigación PHAROS;
* acceso técnico.

<a id="src-player-progression-authority-and-unlocks-system--acto-vii-1"></a>
#### Acto VII

* influencia sobre mando del Pacto.

<a id="src-player-progression-authority-and-unlocks-system--acto-viii-1"></a>
#### Acto VIII

* autoridad excepcional en Aurora Negra.

---

<a id="src-player-progression-authority-and-unlocks-system--102-rutas-de-identidad-del-jugador"></a>
### 102. Rutas de identidad del jugador

El sistema puede reconocer tendencias, sin convertirlas en clases rígidas.

<a id="src-player-progression-authority-and-unlocks-system--comandante-operacional"></a>
#### Comandante operacional

Prioriza:

* fuerza;
* maniobra;
* resultados.

<a id="src-player-progression-authority-and-unlocks-system--protector"></a>
#### Protector

Prioriza:

* unidad;
* civiles;
* estabilidad.

<a id="src-player-progression-authority-and-unlocks-system--investigador"></a>
#### Investigador

Prioriza:

* evidencia;
* Helios;
* verdad.

<a id="src-player-progression-authority-and-unlocks-system--negociador"></a>
#### Negociador

Prioriza:

* alianzas;
* municipios;
* acuerdos.

<a id="src-player-progression-authority-and-unlocks-system--lealista"></a>
#### Lealista

Prioriza:

* cadena de mando;
* institución;
* secreto.

<a id="src-player-progression-authority-and-unlocks-system--reformista"></a>
#### Reformista

Prioriza:

* cambios;
* soberanía;
* control civil.

---

<a id="src-player-progression-authority-and-unlocks-system--103-tendencias-híbridas"></a>
### 103. Tendencias híbridas

El jugador puede combinar:

* comandante e investigador;
* protector y negociador;
* lealista y reformista.

<a id="src-player-progression-authority-and-unlocks-system--regla-8"></a>
#### Regla

No se mostrará una pantalla de selección de clase.

La identidad surge de decisiones acumuladas.

---

<a id="src-player-progression-authority-and-unlocks-system--104-reconocimiento-de-estilo"></a>
### 104. Reconocimiento de estilo

El sistema almacenará patrones.

```text
aggressionPreference
civilProtectionPreference
investigationPreference
obediencePreference
riskTolerance
resourceConservation
negotiationPreference
```

<a id="src-player-progression-authority-and-unlocks-system--uso-1"></a>
#### Uso

* diálogos;
* perfiles Argos;
* recomendaciones;
* epílogos.

---

<a id="src-player-progression-authority-and-unlocks-system--105-argos-y-la-progresión"></a>
### 105. Argos y la progresión

Argos construirá un perfil del jugador.

<a id="src-player-progression-authority-and-unlocks-system--observa"></a>
#### Observa

* decisiones;
* desobediencia;
* tiempo;
* sacrificios;
* confianza;
* uso de Helios.

<a id="src-player-progression-authority-and-unlocks-system--puede-reaccionar"></a>
#### Puede reaccionar

* adaptar señuelos;
* elegir presión;
* usar infiltrado;
* predecir prioridades.

<a id="src-player-progression-authority-and-unlocks-system--límite-1"></a>
#### Límite

No obtiene control directo del jugador.

---

<a id="src-player-progression-authority-and-unlocks-system--106-divergencia"></a>
### 106. Divergencia

La divergencia aumenta cuando el jugador:

* contradice patrones previos;
* elige pérdidas inesperadas;
* coopera con actor improbable;
* rechaza recomendación óptima;
* protege evidencia a coste militar.

<a id="src-player-progression-authority-and-unlocks-system--importancia"></a>
#### Importancia

No es una barra de “resistir a Argos”.

Es una medida analítica de imprevisibilidad.

---

<a id="src-player-progression-authority-and-unlocks-system--107-desbloqueos-por-divergencia"></a>
### 107. Desbloqueos por divergencia

No se otorgarán poderes.

Puede generar:

* interés de Vardis;
* presión Argos;
* archivos especiales;
* diálogo;
* errores de predicción;
* rutas no anticipadas.

---

<a id="src-player-progression-authority-and-unlocks-system--108-progresión-cooperativa-futura"></a>
### 108. Progresión cooperativa futura

En cooperativo del mismo bando:

* la progresión estratégica pertenece a la campaña;
* las relaciones principales pertenecen al estado compartido;
* cada jugador puede tener perfil personal limitado;
* el líder autorizado toma decisiones estratégicas.

<a id="src-player-progression-authority-and-unlocks-system--evitar"></a>
#### Evitar

* rangos competitivos;
* desbloqueos separados incompatibles;
* duplicación de autoridad.

---

<a id="src-player-progression-authority-and-unlocks-system--109-sucesión-del-jugador"></a>
### 109. Sucesión del jugador

Si el protagonista muere en modos donde se permita continuidad:

* otro miembro puede asumir;
* cambia autoridad;
* cambia relación;
* se preserva campaña.

<a id="src-player-progression-authority-and-unlocks-system--v1-recomendada"></a>
#### V1 recomendada

En campaña principal, la muerte del personaje jugador durante misión puede utilizar reinicio de snapshot.

La sucesión completa puede reservarse para:

* modo Ironman;
* variante posterior.

---

<a id="src-player-progression-authority-and-unlocks-system--110-sistema-de-desbloqueo-contextual"></a>
### 110. Sistema de desbloqueo contextual

Una capacidad estará disponible si se cumplen todas las condiciones.

```text
capabilityExists
actorHasAuthority
resourceAvailable
assetAvailable
communicationAvailable
relationshipAllows
missionAllows
```

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-12"></a>
#### Ejemplo

Apoyo aéreo:

```text
✓ aeronave disponible
✓ combustible
✓ piloto
✓ pista
✓ comunicaciones
✓ autorización
✗ defensa AA enemiga demasiado alta
```

Resultado:

* apoyo bloqueado o modificado.

---

<a id="src-player-progression-authority-and-unlocks-system--111-explicación-de-bloqueo"></a>
### 111. Explicación de bloqueo

La interfaz debe indicar por qué una capacidad no está disponible.

Ejemplos:

* “Sin munición de mortero”.
* “Autoridad insuficiente”.
* “Ward no ha autorizado el despliegue”.
* “Pista de AAC inutilizable”.
* “Enlace Helios comprometido”.
* “La unidad está asignada a otra operación”.

---

<a id="src-player-progression-authority-and-unlocks-system--112-desbloqueo-temporal"></a>
### 112. Desbloqueo temporal

Algunas capacidades solo estarán disponibles:

* durante misión;
* por alianza;
* por actor;
* por sector;
* mientras exista recurso.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-13"></a>
#### Ejemplo

FIA puede facilitar:

* ruta clandestina;
* guía;
* depósito;
* apoyo local.

La capacidad desaparece si la relación se rompe.

---

<a id="src-player-progression-authority-and-unlocks-system--113-desbloqueo-irreversible"></a>
### 113. Desbloqueo irreversible

Algunos avances sí son permanentes.

Ejemplos:

* conclusión investigativa;
* autorización de rango;
* entrenamiento completado;
* identidad de infiltrado;
* experiencia de escuadra.

<a id="src-player-progression-authority-and-unlocks-system--incluso-así"></a>
#### Incluso así

Pueden perder utilidad si:

* personaje muere;
* nodo cae;
* autoridad se revoca.

---

<a id="src-player-progression-authority-and-unlocks-system--114-desbloqueos-de-construcción"></a>
### 114. Desbloqueos de construcción

El jugador no desbloquea estructuras como en un juego de estrategia tradicional.

Las capacidades aparecen cuando:

* la facción conoce el módulo;
* existe sector compatible;
* hay recursos;
* existe nivel estructural;
* se autoriza doctrina.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-14"></a>
#### Ejemplo

Defensa AA:

* tecnología existente desde el inicio;
* no disponible en cada sector por falta de misiles, operadores o prioridad.

---

<a id="src-player-progression-authority-and-unlocks-system--115-progreso-de-doctrina"></a>
### 115. Progreso de doctrina

La campaña puede adoptar lecciones.

<a id="src-player-progression-authority-and-unlocks-system--ejemplos-2"></a>
#### Ejemplos

* mejorar dispersión tras ataques aéreos;
* aumentar AT tras pérdidas blindadas;
* modificar convoyes tras emboscadas;
* reforzar protección civil.

<a id="src-player-progression-authority-and-unlocks-system--origen"></a>
#### Origen

* experiencia;
* informes;
* mando;
* decisiones.

---

<a id="src-player-progression-authority-and-unlocks-system--116-lecciones-de-escuadra"></a>
### 116. Lecciones de escuadra

La unidad puede adquirir procedimientos.

```text
BETTER_WITHDRAWAL
IMPROVED_RECON_REPORTING
FASTER_MEDICAL_EVACUATION
CONVOY_DISCIPLINE
HELIOS_AUDIT_PROTOCOL
```

<a id="src-player-progression-authority-and-unlocks-system--efectos-5"></a>
#### Efectos

Pequeños y coherentes:

* menor tiempo;
* mejor información;
* menos errores;
* mayor supervivencia.

---

<a id="src-player-progression-authority-and-unlocks-system--117-límites-de-mejora"></a>
### 117. Límites de mejora

No se permitirá:

* precisión sobrenatural;
* curación instantánea;
* invisibilidad;
* resistencia inhumana;
* multiplicadores excesivos.

<a id="src-player-progression-authority-and-unlocks-system--enfoque"></a>
#### Enfoque

La progresión mejora:

* coordinación;
* planificación;
* equipo;
* autoridad;
* información.

---

<a id="src-player-progression-authority-and-unlocks-system--118-estado-de-progresión-del-jugador"></a>
### 118. Estado de progresión del jugador

```sqf
IF_playerProgression = createHashMapFromArray [
    ["campaignSide", "BLUE"],

    ["formalRank", "OPERATIONS_OFFICER"],
    ["authorityMilitary", 2],
    ["authorityLogistics", 1],
    ["authorityCivil", 1],
    ["authorityPolitical", 0],
    ["authorityIntelligence", 2],
    ["authorityHelios", 0],

    ["commanderTrust", createHashMap],
    ["factionReputation", createHashMap],
    ["regionalReputation", createHashMap],

    ["unitPrestige", 42],
    ["unitDiscipline", 71],
    ["unitCivilReputation", 55],

    ["capabilityIds", []],
    ["qualificationIds", []],
    ["investigationConclusionIds", []],
    ["activeDelegationIds", []],

    ["decisionProfile", createHashMap],
    ["disciplinaryState", "CLEAR"]
];
```

---

<a id="src-player-progression-authority-and-unlocks-system--119-estado-de-relación"></a>
### 119. Estado de relación

```sqf
IF_characterRelationship = createHashMapFromArray [
    ["characterId", "CHAR_BLUE_WARD"],
    ["professionalTrust", 68],
    ["personalTrust", 41],
    ["loyaltyTrust", 55],
    ["judgmentTrust", 72],
    ["politicalTrust", 60],
    ["discretionTrust", 49],
    ["state", "PROFESSIONAL_TRUST"]
];
```

---

<a id="src-player-progression-authority-and-unlocks-system--120-estado-de-capacidad"></a>
### 120. Estado de capacidad

```sqf
IF_capability = createHashMapFromArray [
    ["id", "CAP_BLUE_MORTAR_SUPPORT"],
    ["category", "TACTICAL_SUPPORT"],
    ["unlocked", true],
    ["authorityDomain", "MILITARY"],
    ["minimumAuthority", 1],
    ["requiredAssetType", "MORTAR"],
    ["requiredResource", "ARTILLERY_AMMO"],
    ["requiredRelationshipId", ""],
    ["temporary", false],
    ["currentlyAvailable", true],
    ["unavailableReason", ""]
];
```

---

<a id="src-player-progression-authority-and-unlocks-system--121-estado-de-miembro-de-escuadra"></a>
### 121. Estado de miembro de escuadra

```sqf
IF_squadMemberProgression = createHashMapFromArray [
    ["characterId", "CHAR_BLUE_REED"],
    ["status", "ACTIVE"],
    ["professionalTrust", 74],
    ["personalTrust", 61],
    ["stress", 35],
    ["fatigue", 28],

    ["qualifications", [
        "SIGNALS_QUALIFIED",
        "HELIOS_ANALYSIS_BASIC"
    ]],

    ["experience", createHashMapFromArray [
        ["SIGNALS", 78],
        ["INTELLIGENCE", 51]
    ]],

    ["relationshipEvents", []]
];
```

---

<a id="src-player-progression-authority-and-unlocks-system--122-eventos-de-progresión"></a>
### 122. Eventos de progresión

La progresión se actualiza por eventos normalizados.

```text
MISSION_RESULT
ORDER_OBEYED
ORDER_REFUSED
CIVILIANS_PROTECTED
EVIDENCE_PRESERVED
PROMISE_FULFILLED
PROMISE_BROKEN
ALLY_SAVED
ALLY_ABANDONED
RESOURCE_WASTED
RETREAT_ORDERED
NODE_CAPTURED
NODE_DESTROYED
```

---

<a id="src-player-progression-authority-and-unlocks-system--123-aplicación-de-progresión"></a>
### 123. Aplicación de progresión

El sistema no debe aplicar cambios directamente desde cada misión.

<a id="src-player-progression-authority-and-unlocks-system--flujo"></a>
#### Flujo

1. Registrar evento.
2. Evaluar participantes.
3. Evaluar contexto.
4. Calcular impacto.
5. Aplicar a relaciones relevantes.
6. Registrar explicación.
7. comprobar desbloqueos.

---

<a id="src-player-progression-authority-and-unlocks-system--124-impacto-contextual"></a>
### 124. Impacto contextual

La misma acción puede producir efectos diferentes.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-15"></a>
#### Ejemplo

Retirarse:

<a id="src-player-progression-authority-and-unlocks-system--bajo-orden-de-retardo-cumplida"></a>
##### Bajo orden de retardo cumplida

* aumenta juicio;
* conserva fuerza.

<a id="src-player-progression-authority-and-unlocks-system--antes-de-tiempo-sin-informar"></a>
##### Antes de tiempo sin informar

* reduce competencia y lealtad.

<a id="src-player-progression-authority-and-unlocks-system--para-salvar-civiles"></a>
##### Para salvar civiles

* aumenta reputación civil;
* puede reducir confianza militar.

---

<a id="src-player-progression-authority-and-unlocks-system--125-registro-explicable"></a>
### 125. Registro explicable

Cada cambio importante debe poder explicarse.

```text
Ward aumentó su confianza:
+ Protegiste la cabeza de playa.
+ Informaste la pérdida del convoy.
- Ignoraste la orden de reconocimiento.

Resultado: +6
```

La interfaz puede resumir sin mostrar siempre cifras.

---

<a id="src-player-progression-authority-and-unlocks-system--126-prevención-de-farmeo"></a>
### 126. Prevención de farmeo

No se permitirá aumentar reputación repitiendo infinitamente:

* misiones menores;
* entregas;
* rescates generados;
* bajas enemigas.

<a id="src-player-progression-authority-and-unlocks-system--métodos"></a>
#### Métodos

* rendimientos decrecientes;
* importancia contextual;
* eventos únicos;
* memoria regional;
* límites por necesidad real.

---

<a id="src-player-progression-authority-and-unlocks-system--127-pérdida-de-autoridad-por-cambio-de-mando"></a>
### 127. Pérdida de autoridad por cambio de mando

Si cambia el comandante:

* algunas delegaciones expiran;
* la confianza debe reconstruirse;
* el rango permanece;
* la reputación influye.

<a id="src-player-progression-authority-and-unlocks-system--ejemplo-16"></a>
#### Ejemplo

Una autoridad concedida por Navid puede no ser reconocida por Vahid.

---

<a id="src-player-progression-authority-and-unlocks-system--128-autoridad-en-crisis-de-mando"></a>
### 128. Autoridad en crisis de mando

Si superiores están:

* muertos;
* incomunicados;
* capturados;
* enfrentados;

el jugador puede asumir autoridad de facto.

<a id="src-player-progression-authority-and-unlocks-system--después"></a>
#### Después

El mando puede:

* ratificar;
* cuestionar;
* sancionar;
* revocar.

---

<a id="src-player-progression-authority-and-unlocks-system--129-decisiones-de-fin-de-campaña"></a>
### 129. Decisiones de fin de campaña

Las opciones finales deben depender de una combinación.

<a id="src-player-progression-authority-and-unlocks-system--destruir-helios"></a>
#### Destruir Helios

Puede requerir autoridad militar, pero no gran acceso técnico.

<a id="src-player-progression-authority-and-unlocks-system--auditar-y-preservar"></a>
#### Auditar y preservar

Requiere:

* investigación;
* técnico;
* acceso;
* tiempo.

<a id="src-player-progression-authority-and-unlocks-system--transferir-a-control-civil"></a>
#### Transferir a control civil

Requiere:

* legitimidad;
* Gobierno o consejo;
* apoyo político;
* preservación.

<a id="src-player-progression-authority-and-unlocks-system--capturar-para-el-bando"></a>
#### Capturar para el bando

Requiere:

* autoridad;
* control militar;
* apoyo institucional.

---

<a id="src-player-progression-authority-and-unlocks-system--130-finales-y-progresión"></a>
### 130. Finales y progresión

Los epílogos leerán:

```text
finalRank
finalAuthority
commanderRelations
squadSurvival
squadTrust
civilReputation
greenReputation
fiaRelations
governmentRelation
heliosAccess
investigationLevel
disciplinaryState
decisionProfile
```

---

<a id="src-player-progression-authority-and-unlocks-system--131-ejemplo-de-final-azul"></a>
### 131. Ejemplo de final Azul

El jugador puede terminar:

* con Ward confiando en él;
* Hale enfrentado;
* FIA cooperadora;
* gran reputación civil;
* autoridad militar media;
* acceso Helios alto.

Esto favorece:

* transición;
* auditoría;
* retirada Azul condicionada.

---

<a id="src-player-progression-authority-and-unlocks-system--132-ejemplo-de-final-rojo"></a>
### 132. Ejemplo de final Rojo

El jugador puede terminar:

* con Vahid dominante;
* Navid debilitado;
* Gobierno dependiente;
* Verde subordinada;
* gran autoridad militar;
* baja legitimidad local.

Esto favorece:

* estabilidad coercitiva;
* control Rojo de Helios;
* insurgencia posterior.

---

<a id="src-player-progression-authority-and-unlocks-system--133-vertical-slice-de-progresión"></a>
### 133. Vertical slice de progresión

El Acto I Azul debe probar:

* confianza Ward–Hale;
* autoridad táctica;
* prioridad de construcción;
* relación con Reed;
* reputación Neochori;
* acceso inicial a mortero o dron;
* decisión sobre señal S-26.

---

<a id="src-player-progression-authority-and-unlocks-system--134-prueba-1-victoria-desobediente"></a>
### 134. Prueba 1 — Victoria desobediente

El jugador obtiene resultado militar y desobedece.

Validar:

* competencia aumenta;
* lealtad disminuye;
* autoridad puede variar.

---

<a id="src-player-progression-authority-and-unlocks-system--135-prueba-2-fracaso-responsable"></a>
### 135. Prueba 2 — Fracaso responsable

El jugador fracasa, informa y salva fuerza.

Validar:

* no aplicar castigo automático;
* aumentar juicio según contexto.

---

<a id="src-player-progression-authority-and-unlocks-system--136-prueba-3-apoyo-sin-recursos"></a>
### 136. Prueba 3 — Apoyo sin recursos

Capacidad desbloqueada, pero recurso agotado.

Validar:

* aparece indisponible con explicación.

---

<a id="src-player-progression-authority-and-unlocks-system--137-prueba-4-especialista-muerto"></a>
### 137. Prueba 4 — Especialista muerto

Eliminar a Reed o equivalente de prueba.

Validar:

* acceso técnico reducido;
* sustituto parcial;
* relación y moral.

---

<a id="src-player-progression-authority-and-unlocks-system--138-prueba-5-autoridad-revocada"></a>
### 138. Prueba 5 — Autoridad revocada

Cambiar comandante.

Validar:

* rango permanece;
* delegación expira;
* opciones cambian.

---

<a id="src-player-progression-authority-and-unlocks-system--139-prueba-6-reputaciones-contradictorias"></a>
### 139. Prueba 6 — Reputaciones contradictorias

Ayudar a Markou y perjudicar a Kallas.

Validar:

* relaciones separadas.

---

<a id="src-player-progression-authority-and-unlocks-system--140-prueba-7-progreso-investigativo-alto-y-autoridad-baja"></a>
### 140. Prueba 7 — Progreso investigativo alto y autoridad baja

Conservar evidencia en secreto.

Validar:

* conocimiento personal alto;
* opciones institucionales limitadas.

---

<a id="src-player-progression-authority-and-unlocks-system--141-prueba-8-progreso-militar-alto-y-legitimidad-baja"></a>
### 141. Prueba 8 — Progreso militar alto y legitimidad baja

Completar ofensivas con daño civil.

Validar:

* autoridad militar;
* protestas;
* finales.

---

<a id="src-player-progression-authority-and-unlocks-system--142-prueba-9-guardado"></a>
### 142. Prueba 9 — Guardado

Guardar relaciones, capacidades y delegaciones.

---

<a id="src-player-progression-authority-and-unlocks-system--143-prueba-10-anti-farmeo"></a>
### 143. Prueba 10 — Anti-farmeo

Repetir tareas menores.

Validar:

* sin crecimiento artificial ilimitado.

---

<a id="src-player-progression-authority-and-unlocks-system--144-funciones-conceptuales"></a>
### 144. Funciones conceptuales

```text
IF_fnc_progressionRegisterEvent
IF_fnc_progressionEvaluateImpact
IF_fnc_progressionApplyRelationshipChange
IF_fnc_progressionEvaluateRank
IF_fnc_progressionGrantAuthority
IF_fnc_progressionRevokeAuthority
IF_fnc_progressionEvaluateCapabilities
IF_fnc_progressionUpdateUnitPrestige
IF_fnc_progressionUpdateSquadCohesion
IF_fnc_progressionUpdateDecisionProfile
IF_fnc_progressionEvaluateDiscipline
IF_fnc_progressionGenerateExplanation
IF_fnc_capabilityCheckAvailability
IF_fnc_capabilityGrant
IF_fnc_capabilitySuspend
IF_fnc_relationshipEvaluateState
```

---

<a id="src-player-progression-authority-and-unlocks-system--145-invariantes"></a>
### 145. Invariantes

1. Rango y autoridad son distintos.
2. La autoridad puede ser contextual.
3. La confianza pertenece a cada personaje.
4. La reputación pertenece a cada actor o región.
5. El apoyo disponible requiere activos reales.
6. Un desbloqueo no crea recursos.
7. El conocimiento no equivale a autoridad.
8. La autoridad no equivale a legitimidad.
9. Una misión fallida puede producir progresión.
10. Una victoria puede reducir confianza.
11. Las relaciones registran contexto.
12. Los especialistas pueden perderse.
13. Los reemplazos no son copias perfectas.
14. Las capacidades pueden suspenderse.
15. La progresión no depende de bajas enemigas.
16. Las decisiones disciplinarias tienen consecuencias.
17. La desobediencia puede estar justificada.
18. El estilo del jugador surge de decisiones.
19. Argos observa, pero no controla.
20. Los finales leen toda la progresión acumulada.

---

<a id="src-player-progression-authority-and-unlocks-system--146-errores-que-deben-evitarse"></a>
### 146. Errores que deben evitarse

1. Utilizar una barra global de experiencia.
2. Desbloquear armas por nivel.
3. Dar autoridad solo por completar actos.
4. Hacer que todos los superiores reaccionen igual.
5. Confundir obediencia con competencia.
6. Premiar siempre la agresividad.
7. Castigar siempre la retirada.
8. Hacer que todas las reputaciones cambien juntas.
9. Convertir relaciones en romance o amistad automática.
10. Hacer inmortales a especialistas.
11. Sustituir muertos instantáneamente.
12. Dar apoyos infinitos.
13. Ocultar por completo por qué una capacidad está bloqueada.
14. Hacer que la progresión elimine restricciones logísticas.
15. Permitir controlar un ejército completo desde el inicio.
16. Dar al jugador autoridad política total.
17. Utilizar puntos de influencia como moneda universal.
18. Hacer que investigar garantice el mejor final.
19. Hacer que alto rango garantice legitimidad.
20. Permitir farmear reputación con misiones repetidas.

---

<a id="src-player-progression-authority-and-unlocks-system--147-principios-obligatorios"></a>
### 147. Principios obligatorios

1. La progresión es institucional, humana y operacional.
2. Rango, autoridad, confianza y reputación son independientes.
3. La autoridad se divide por dominio.
4. Las delegaciones pueden ser temporales.
5. Cada superior posee criterios propios.
6. La confianza tiene varias dimensiones.
7. La escuadra mantiene relaciones persistentes.
8. Las competencias representan entrenamiento y coordinación.
9. Los apoyos dependen de activos reales.
10. La logística limita capacidades.
11. La información limita decisiones.
12. El acceso Helios progresa separadamente.
13. La investigación desbloquea comprensión y opciones.
14. La desobediencia tiene contexto.
15. El fracaso no bloquea toda progresión.
16. Las pérdidas reducen capacidades reales.
17. Las sustituciones cambian la unidad.
18. El jugador adquiere influencia gradualmente.
19. La identidad del jugador surge de patrones.
20. Argos utiliza esos patrones.
21. La divergencia no es un poder.
22. La autoridad puede perderse.
23. La reputación puede ser regional.
24. El enemigo recuerda a la unidad.
25. Los prisioneros recuerdan su trato.
26. Las capacidades deben explicar disponibilidad.
27. Las mejoras deben ser plausibles.
28. No existe una ruta óptima universal.
29. La progresión modifica la operación final.
30. Los finales dependen de cómo se consiguió el poder, no solo de cuánto poder se obtuvo.

---

<a id="src-player-progression-authority-and-unlocks-system--148-definición-final"></a>
### 148. Definición final

La progresión de Islas Fracturadas no transformará al jugador en un soldado capaz de resistir más disparos porque completó muchas misiones.

Lo transformará en alguien a quien:

* una escuadra decide seguir;
* un comandante decide escuchar;
* un alcalde decide recibir;
* una célula FIA decide contactar;
* un analista decide confiar información;
* una fuerza Verde decide respetar;
* Argos decide estudiar como variable peligrosa.

El jugador podrá ganar rango y perder legitimidad.

Podrá perder autoridad formal y conservar influencia.

Podrá disponer de la verdad y no tener poder para utilizarla.

Podrá controlar una operación militar y fracasar al intentar gobernar sus consecuencias.

> **La progresión no consistirá en hacer al jugador más poderoso que el mundo. Consistirá en permitirle asumir responsabilidades cada vez mayores dentro de un mundo que recuerda cómo utilizó las anteriores.**

> **Un apoyo se desbloquea cuando existe una fuerza dispuesta a responder. Una alianza se desbloquea cuando alguien acepta el riesgo de confiar. Una decisión estratégica se desbloquea cuando el mando ya no puede ignorar al jugador.**

> **Al final, el rango mostrará qué puesto alcanzó. Las relaciones y las consecuencias mostrarán en qué clase de líder se convirtió.**

<a id="src-player-progression-authority-and-unlocks-system--estado-actualizado"></a>
#### Estado actualizado

El [Documento 9/14](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system) define cómo presentar mapa, sectores, fuerzas, logística, inteligencia, relaciones, construcción, misiones y Helios sin saturar al jugador ni revelar información que su personaje todavía desconoce.

El [Documento 10/14](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture) fija la arquitectura modular, propiedad del estado, APIs, eventos, transacciones, persistencia, red y pruebas.

El [Documento 11/14](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide) fija la validación física de los espacios, activos, apoyos y puntos de interacción asociados a capacidades del jugador.

El [Documento 12/14](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system) fija variantes de relación, opciones bloqueadas, memoria conversacional, promesas y consecuencias narrativas de autoridad y progresión.

El [Documento 13/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system) fija pruebas y balance de rango, autoridad, delegación, capacidades, relaciones, reputación, investigación y anti-farmeo.

El [Documento 14/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan) fija orden, alcance, entregables y puertas para implementar progresión, autoridad y capacidades. La colección rectora queda completa.

---

<a id="fuente-strategic-ui-and-player-experience-system"></a>
## Fuente integrada: `STRATEGIC_UI_AND_PLAYER_EXPERIENCE_SYSTEM.md`

> **Procedencia:** contenido migrado de `STRATEGIC_UI_AND_PLAYER_EXPERIENCE_SYSTEM.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-strategic-ui-and-player-experience-system--islas-fracturadas"></a>
### ISLAS FRACTURADAS

<a id="src-strategic-ui-and-player-experience-system--documento-914-sistema-definitivo-de-interfaz-estratégica-y-experiencia-del-jugador"></a>
#### Documento 9/14 — Sistema definitivo de interfaz estratégica y experiencia del jugador

**Versión:** 1.0
**Clasificación:** documento rector de interfaz, experiencia de usuario y presentación de información
**Campañas:** Fuerza Azul y Fuerza Roja
**Territorios:** Altis y Stratis
**Motor:** Arma 3 2.18
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando
**Estado:** canon funcional y visual previo a implementación

> **Jerarquía documental:** este Documento 9/14 gobierna la presentación, navegación, interacción, accesibilidad, conocimiento visible y contratos funcionales de interfaz. Los documentos rectores de cada sistema conservan autoridad sobre su estado real, reglas internas y consecuencias; la interfaz solo recibe modelos preparados y nunca consulta ni revela directamente la realidad secreta. Su arquitectura de capas, suscripciones, caché, red, localización y reglas SQF se rige por [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture); el contenido, prioridad y comportamiento audiovisual de diálogos, radio, subtítulos, briefings y escenas, por [DIALOGUE_RADIO_BRIEFING_AUDIO_AND_CINEMATICS_SYSTEM.md](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system); y sus pruebas funcionales, secretas, de accesibilidad y rendimiento, por [MASTER_TESTING_PERFORMANCE_AND_BALANCE_SYSTEM.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system).

---

<a id="src-strategic-ui-and-player-experience-system--1-propósito"></a>
### 1. Propósito

Este documento define cómo el jugador:

* comprende la guerra;
* recibe órdenes;
* consulta el mapa;
* revisa sectores;
* interpreta frentes;
* controla su escuadra;
* consulta fuerzas;
* revisa logística;
* establece prioridades;
* investiga evidencias;
* analiza Helios;
* interactúa con personajes;
* comprende su autoridad;
* distingue información confirmada de estimaciones;
* recibe alertas;
* toma decisiones estratégicas;
* revisa consecuencias;
* guarda y recupera la campaña.

La interfaz deberá presentar sistemas complejos sin exigir que el jugador administre:

* hojas de cálculo;
* cientos de números;
* cada soldado;
* cada camión;
* cada objeto construido;
* cada operación simultánea.

<a id="src-strategic-ui-and-player-experience-system--principio-central"></a>
#### Principio central

> La interfaz no mostrará todo lo que el sistema sabe.

> Mostrará lo que el personaje del jugador puede conocer, comprender y utilizar en ese momento.

---

<a id="src-strategic-ui-and-player-experience-system--2-decisión-principal-de-diseño"></a>
### 2. Decisión principal de diseño

La experiencia tendrá dos capas complementarias.

<a id="src-strategic-ui-and-player-experience-system--capa-táctica"></a>
#### Capa táctica

Utilizada durante:

* movimiento;
* combate;
* reconocimiento;
* interacción directa;
* mando de escuadra.

Debe ser:

* limpia;
* inmediata;
* poco intrusiva;
* compatible con la inmersión militar.

<a id="src-strategic-ui-and-player-experience-system--capa-estratégica"></a>
#### Capa estratégica

Utilizada para:

* mapa;
* mando;
* logística;
* sectores;
* inteligencia;
* relaciones;
* construcción;
* campaña.

Debe ser:

* clara;
* jerárquica;
* explicable;
* contextual.

<a id="src-strategic-ui-and-player-experience-system--regla"></a>
#### Regla

La interfaz estratégica no debe intentar permanecer completamente visible durante el combate.

La interfaz táctica no debe intentar mostrar toda la campaña.

---

<a id="src-strategic-ui-and-player-experience-system--3-objetivos-de-experiencia"></a>
### 3. Objetivos de experiencia

La interfaz debe permitir que el jugador responda rápidamente:

1. ¿Cuál es mi misión actual?
2. ¿Qué está ocurriendo en el frente?
3. ¿Qué sector está en peligro?
4. ¿Qué fuerza está disponible?
5. ¿Qué recurso está bloqueando una operación?
6. ¿Qué información es segura y cuál es estimada?
7. ¿Qué decisión necesita mi intervención?
8. ¿Qué ocurrirá si no intervengo?
9. ¿Qué autoridad tengo?
10. ¿Qué consecuencias produjeron mis decisiones anteriores?

---

<a id="src-strategic-ui-and-player-experience-system--4-principio-de-información-progresiva"></a>
### 4. Principio de información progresiva

La información se presentará en tres niveles.

<a id="src-strategic-ui-and-player-experience-system--nivel-1-decisión-inmediata"></a>
#### Nivel 1 — Decisión inmediata

Muestra únicamente:

* problema;
* urgencia;
* opciones;
* consecuencia principal.

<a id="src-strategic-ui-and-player-experience-system--nivel-2-contexto-operacional"></a>
#### Nivel 2 — Contexto operacional

Muestra:

* fuerzas;
* recursos;
* rutas;
* riesgos;
* personajes implicados.

<a id="src-strategic-ui-and-player-experience-system--nivel-3-detalle-analítico"></a>
#### Nivel 3 — Detalle analítico

Muestra:

* historial;
* fuentes;
* cálculos;
* relaciones;
* versiones;
* dependencias.

<a id="src-strategic-ui-and-player-experience-system--ejemplo"></a>
#### Ejemplo

<a id="src-strategic-ui-and-player-experience-system--nivel-1"></a>
##### Nivel 1

```text
Neochori necesita combustible.
La reserva permitirá operar durante aproximadamente 3 horas.
```

<a id="src-strategic-ui-and-player-experience-system--nivel-2"></a>
##### Nivel 2

```text
Demanda: 24 FUEL
Origen disponible: Katalaki
Ruta principal: riesgo alto
Ruta secundaria: capacidad baja
```

<a id="src-strategic-ui-and-player-experience-system--nivel-3"></a>
##### Nivel 3

```text
Consumo por guarnición
Consumo de vehículos
Últimos convoyes
Ataques registrados
Estimación de próximas 12 horas
```

---

<a id="src-strategic-ui-and-player-experience-system--5-prohibición-de-duplicación"></a>
### 5. Prohibición de duplicación

La misma información no deberá repetirse sin añadir significado.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-incorrecto"></a>
#### Ejemplo incorrecto

Pantalla principal:

```text
Combustible crítico.
```

Panel de sector:

```text
Combustible crítico.
```

Panel de logística:

```text
Combustible crítico.
```

<a id="src-strategic-ui-and-player-experience-system--ejemplo-correcto"></a>
#### Ejemplo correcto

<a id="src-strategic-ui-and-player-experience-system--panel-principal"></a>
##### Panel principal

```text
Combustible crítico: la defensa de Lakka perderá movilidad.
```

<a id="src-strategic-ui-and-player-experience-system--panel-de-sector"></a>
##### Panel de sector

```text
Reserva actual y tiempo estimado de autonomía.
```

<a id="src-strategic-ui-and-player-experience-system--panel-logístico"></a>
##### Panel logístico

```text
Origen del déficit, rutas y opciones de suministro.
```

---

<a id="src-strategic-ui-and-player-experience-system--6-jerarquía-de-navegación"></a>
### 6. Jerarquía de navegación

La interfaz estratégica se organizará en diez espacios principales.

```text
1. Centro de mando
2. Mapa estratégico
3. Misiones y operaciones
4. Fuerzas
5. Logística
6. Sectores y gobierno
7. Inteligencia
8. Helios
9. Unidad y progresión
10. Archivo de campaña
```

No todas las secciones estarán disponibles desde el inicio.

---

<a id="src-strategic-ui-and-player-experience-system--7-centro-de-mando"></a>
### 7. Centro de mando

Será la pantalla principal estratégica.

<a id="src-strategic-ui-and-player-experience-system--función"></a>
#### Función

Responder:

* qué necesita atención;
* qué cambió;
* qué está bloqueado;
* qué decisiones están pendientes.

<a id="src-strategic-ui-and-player-experience-system--contenido-principal"></a>
#### Contenido principal

* misión activa;
* situación del frente;
* alertas críticas;
* operaciones disponibles;
* recursos en riesgo;
* decisiones pendientes;
* estado de la unidad.

<a id="src-strategic-ui-and-player-experience-system--contenido-secundario"></a>
#### Contenido secundario

* clima operacional;
* actividad reciente;
* cambios políticos;
* informes nuevos;
* próximos eventos.

---

<a id="src-strategic-ui-and-player-experience-system--8-resumen-del-centro-de-mando"></a>
### 8. Resumen del centro de mando

Ejemplo:

```text
SITUACIÓN GENERAL

Frente occidental:
Estable, presión Verde moderada.

Neochori:
Combustible crítico en 3 h 20 min.

Operaciones:
1 misión principal activa.
2 operaciones urgentes.
1 investigación disponible.

Decisiones:
Ward solicita priorizar consolidación.
Hale propone avanzar hacia Stavros.

Inteligencia:
Nueva contradicción en el informe costero.
```

---

<a id="src-strategic-ui-and-player-experience-system--9-alertas"></a>
### 9. Alertas

Las alertas se clasificarán por impacto.

```text
CRÍTICA
URGENTE
IMPORTANTE
INFORMATIVA
```

<a id="src-strategic-ui-and-player-experience-system--crítica"></a>
#### Crítica

Requiere atención inmediata.

Ejemplos:

* cabeza de playa en ruptura;
* hospital sin energía;
* personaje crítico capturado;
* retirada necesaria.

<a id="src-strategic-ui-and-player-experience-system--urgente"></a>
#### Urgente

Ventana limitada.

<a id="src-strategic-ui-and-player-experience-system--importante"></a>
#### Importante

Afecta planificación.

<a id="src-strategic-ui-and-player-experience-system--informativa"></a>
#### Informativa

Cambio relevante sin necesidad de decisión inmediata.

---

<a id="src-strategic-ui-and-player-experience-system--10-alertas-explicables"></a>
### 10. Alertas explicables

Cada alerta deberá mostrar:

* qué ocurrió;
* dónde;
* por qué importa;
* tiempo disponible;
* acción posible.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-1"></a>
#### Ejemplo

```text
CONVOY 014 BAJO ATAQUE

Ruta: Katalaki–Neochori
Carga: combustible, medicina y munición
Impacto si se pierde:
Neochori pasará a estado logístico crítico.

Tiempo estimado para intervenir:
8 minutos
```

---

<a id="src-strategic-ui-and-player-experience-system--11-agrupación-de-alertas"></a>
### 11. Agrupación de alertas

No se mostrarán varias alertas individuales para el mismo problema.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-2"></a>
#### Ejemplo

En lugar de:

* combustible bajo;
* convoy retrasado;
* ruta atacada;
* Lakka sin autonomía;

se agrupa como:

```text
CRISIS LOGÍSTICA DE LAKKA

Causa principal:
Convoy retrasado por amenaza en la ruta.

Consecuencias:
Combustible crítico.
QRF limitada.
Ofensiva aplazada.
```

---

<a id="src-strategic-ui-and-player-experience-system--12-historial-de-alertas"></a>
### 12. Historial de alertas

Las alertas resueltas pasarán a un historial.

Estados:

```text
ACTIVA
RECONOCIDA
RESUELTA
EXPIRADA
TRANSFORMADA
```

<a id="src-strategic-ui-and-player-experience-system--función-1"></a>
#### Función

Permitir revisar:

* qué ocurrió;
* qué decidió el jugador;
* qué consecuencia se aplicó.

---

<a id="src-strategic-ui-and-player-experience-system--13-mapa-estratégico"></a>
### 13. Mapa estratégico

Será el centro visual de la campaña.

Debe representar:

* sectores;
* conexiones;
* frentes;
* fuerzas conocidas;
* rutas;
* operaciones;
* inteligencia;
* infraestructura;
* actividad civil.

<a id="src-strategic-ui-and-player-experience-system--regla-1"></a>
#### Regla

No se mostrarán todas las capas simultáneamente.

---

<a id="src-strategic-ui-and-player-experience-system--14-capas-del-mapa"></a>
### 14. Capas del mapa

```text
CONTROL TERRITORIAL
FRENTES
FUERZAS
LOGÍSTICA
INTELIGENCIA
CIVIL
INFRAESTRUCTURA
HELIOS
MISIONES
```

El jugador podrá activar una capa principal y varias referencias secundarias limitadas.

---

<a id="src-strategic-ui-and-player-experience-system--15-capa-de-control-territorial"></a>
### 15. Capa de control territorial

Mostrará estados conocidos:

```text
AZUL
ROJO
VERDE
FIA
NEUTRAL
DISPUTADO
DESCONOCIDO
```

<a id="src-strategic-ui-and-player-experience-system--importante-1"></a>
#### Importante

El color representa control percibido.

Puede no coincidir exactamente con:

* autoridad política;
* apoyo civil;
* presencia clandestina.

---

<a id="src-strategic-ui-and-player-experience-system--16-capa-de-frentes"></a>
### 16. Capa de frentes

Mostrará:

* conexiones amenazadas;
* dirección de presión;
* profundidad;
* salientes;
* sectores aislados;
* zonas de probable ataque.

<a id="src-strategic-ui-and-player-experience-system--no-mostrará"></a>
#### No mostrará

Una línea continua artificial si el terreno y conexiones no la justifican.

---

<a id="src-strategic-ui-and-player-experience-system--17-capa-de-fuerzas"></a>
### 17. Capa de fuerzas

Las fuerzas conocidas se mostrarán mediante:

* icono;
* área estimada;
* tamaño estimado;
* última actualización;
* confianza.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-3"></a>
#### Ejemplo

```text
Reserva mecanizada Verde
Fuerza estimada: pelotón reforzado
Confianza: media
Última actualización: hace 41 min
```

---

<a id="src-strategic-ui-and-player-experience-system--18-posiciones-inciertas"></a>
### 18. Posiciones inciertas

Una fuerza no confirmada se representará mediante:

* área;
* ruta probable;
* última posición;
* dirección estimada.

No mediante un icono exacto siguiendo su posición real.

---

<a id="src-strategic-ui-and-player-experience-system--19-capa-logística"></a>
### 19. Capa logística

Mostrará:

* centros;
* depósitos;
* rutas;
* capacidad;
* convoyes;
* cuellos de botella;
* interrupciones.

<a id="src-strategic-ui-and-player-experience-system--estados-de-ruta"></a>
#### Estados de ruta

```text
OPERATIVA
SATURADA
DEGRADADA
AMENAZADA
BLOQUEADA
DESCONOCIDA
```

---

<a id="src-strategic-ui-and-player-experience-system--20-capa-civil"></a>
### 20. Capa civil

Mostrará de forma agregada:

* estabilidad;
* desplazamiento;
* servicios críticos;
* protestas;
* autoridad;
* ayuda.

<a id="src-strategic-ui-and-player-experience-system--no-mostrará-inicialmente"></a>
#### No mostrará inicialmente

Valores completos de:

* apoyo clandestino;
* células;
* radicalización precisa.

---

<a id="src-strategic-ui-and-player-experience-system--21-capa-helios"></a>
### 21. Capa Helios

Mostrará nodos conocidos y su estado percibido.

```text
OPERATIVO
DEGRADADO
AISLADO
COMPROMETIDO
DESCONOCIDO
```

<a id="src-strategic-ui-and-player-experience-system--acceso"></a>
#### Acceso

Seleccionar un nodo abrirá:

* función;
* propietario físico;
* acceso digital;
* integridad;
* dependencias;
* auditoría.

---

<a id="src-strategic-ui-and-player-experience-system--22-capa-de-misiones"></a>
### 22. Capa de misiones

Mostrará:

* misión principal;
* operaciones;
* emergencias;
* investigaciones;
* oportunidades.

<a id="src-strategic-ui-and-player-experience-system--diferenciación"></a>
#### Diferenciación

No se usarán únicamente colores.

Se utilizarán:

* formas;
* iconos;
* texto;
* urgencia.

---

<a id="src-strategic-ui-and-player-experience-system--23-selección-de-sector"></a>
### 23. Selección de sector

Al seleccionar un sector se abre un panel lateral contextual.

<a id="src-strategic-ui-and-player-experience-system--resumen-principal"></a>
#### Resumen principal

* nombre;
* control;
* tipo;
* nivel;
* función;
* estabilidad;
* amenaza;
* suministro.

<a id="src-strategic-ui-and-player-experience-system--acciones-principales"></a>
#### Acciones principales

Según autoridad:

* priorizar;
* solicitar información;
* asignar fuerza;
* revisar construcción;
* revisar gobierno;
* abrir logística.

---

<a id="src-strategic-ui-and-player-experience-system--24-panel-de-sector"></a>
### 24. Panel de sector

Se dividirá en pestañas.

```text
RESUMEN
DEFENSA
LOGÍSTICA
GOBIERNO
INFRAESTRUCTURA
INTELIGENCIA
HISTORIAL
```

<a id="src-strategic-ui-and-player-experience-system--regla-2"></a>
#### Regla

La pestaña Resumen no repetirá todos los datos de las demás.

Mostrará solamente indicadores de decisión.

---

<a id="src-strategic-ui-and-player-experience-system--25-resumen-del-sector"></a>
### 25. Resumen del sector

Ejemplo:

```text
NEOCHORI

Control militar:
Azul confirmado.

Autoridad:
Municipio supervisado.

Función:
Centro logístico regional.

Amenaza:
Alta desde Stavros.

Estabilidad:
Frágil.

Problema principal:
Combustible crítico.

Decisión pendiente:
Prioridad de construcción.
```

---

<a id="src-strategic-ui-and-player-experience-system--26-defensa-del-sector"></a>
### 26. Defensa del sector

Mostrará:

* guarnición;
* preparación;
* fortificación;
* QRF;
* amenazas;
* ejes probables;
* módulos defensivos.

<a id="src-strategic-ui-and-player-experience-system--información-incierta"></a>
#### Información incierta

Las fuerzas enemigas se mostrarán según inteligencia disponible.

---

<a id="src-strategic-ui-and-player-experience-system--27-construcción-automática"></a>
### 27. Construcción automática

La interfaz no permitirá colocar objetos.

Permitirá establecer prioridades.

```text
DEFENSA
LOGÍSTICA
ANTITANQUE
ANTIAÉREA
MEDICINA
INTELIGENCIA
APOYO CIVIL
```

<a id="src-strategic-ui-and-player-experience-system--acción-del-jugador"></a>
#### Acción del jugador

Ajustar pesos o seleccionar una prioridad dominante.

---

<a id="src-strategic-ui-and-player-experience-system--28-explicación-de-decisiones-de-construcción"></a>
### 28. Explicación de decisiones de construcción

El sistema mostrará:

```text
MÓDULO PROPUESTO:
Puesto AT oriental

Razones:
• Amenaza mecanizada desde Stavros.
• Dos ataques recientes por la ruta oriental.
• Capacidad defensiva disponible.
• Munición AT suficiente.

Alternativa:
Refugio reforzado.

No disponible:
Depósito estratégico — sector demasiado cercano al frente.
```

---

<a id="src-strategic-ui-and-player-experience-system--29-cola-de-construcción"></a>
### 29. Cola de construcción

Cada proyecto mostrará:

* fase;
* tiempo;
* recursos;
* personal;
* riesgo;
* impacto.

Estados:

```text
PROPUESTO
RESERVADO
EN PREPARACIÓN
EN CONSTRUCCIÓN
INTERRUMPIDO
OPERATIVO
DAÑADO
CANCELADO
```

---

<a id="src-strategic-ui-and-player-experience-system--30-fuerzas"></a>
### 30. Fuerzas

La sección Fuerzas mostrará formaciones estratégicas.

<a id="src-strategic-ui-and-player-experience-system--información-principal"></a>
#### Información principal

* nombre;
* tipo;
* sector;
* fuerza efectiva;
* preparación;
* moral;
* suministro;
* misión;
* disponibilidad.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-4"></a>
#### Ejemplo

```text
1.ª Compañía Azul

Fuerza efectiva:
82 de 104

Preparación:
72 %

Suministro:
Adecuado

Estado:
Preparando avance hacia Stavros

Disponibilidad:
Comprometida
```

---

<a id="src-strategic-ui-and-player-experience-system--31-detalle-de-formación"></a>
### 31. Detalle de formación

Pestañas:

```text
RESUMEN
PERSONAL
VEHÍCULOS
SUMINISTRO
HISTORIAL
ÓRDENES
```

<a id="src-strategic-ui-and-player-experience-system--no-se-mostrará"></a>
#### No se mostrará

Una lista individual de todos los soldados genéricos.

---

<a id="src-strategic-ui-and-player-experience-system--32-fuerza-efectiva"></a>
### 32. Fuerza efectiva

Se mostrará de manera comprensible.

```text
Personal total: 104
Disponible: 82
Heridos: 11
Bajas: 10
Desaparecido: 1
```

<a id="src-strategic-ui-and-player-experience-system--estado-visual"></a>
#### Estado visual

* completa;
* reducida;
* degradada;
* crítica;
* no operativa.

---

<a id="src-strategic-ui-and-player-experience-system--33-disponibilidad-de-fuerzas"></a>
### 33. Disponibilidad de fuerzas

Estados:

```text
DISPONIBLE
EN RESERVA
ASIGNADA
EN MOVIMIENTO
EN COMBATE
REORGANIZANDO
AISLADA
NO OPERATIVA
```

<a id="src-strategic-ui-and-player-experience-system--regla-3"></a>
#### Regla

El jugador no podrá asignar una fuerza comprometida sin cancelar o modificar su tarea anterior.

---

<a id="src-strategic-ui-and-player-experience-system--34-selección-de-fuerza-para-operación"></a>
### 34. Selección de fuerza para operación

La interfaz deberá explicar:

* tiempo de llegada;
* preparación;
* coste;
* riesgo;
* tarea que dejará sin cubrir.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-5"></a>
#### Ejemplo

```text
Asignar 1.ª Compañía a Lakka:

Llegada estimada:
42 minutos.

Coste:
18 FUEL.

Consecuencia:
Neochori perderá su reserva principal.
```

---

<a id="src-strategic-ui-and-player-experience-system--35-logística"></a>
### 35. Logística

La sección Logística se organizará por:

* regiones;
* recursos;
* rutas;
* convoyes;
* demandas;
* mantenimiento.

<a id="src-strategic-ui-and-player-experience-system--vista-principal"></a>
#### Vista principal

Debe responder:

* qué falta;
* dónde;
* por qué;
* cómo puede llegar.

---

<a id="src-strategic-ui-and-player-experience-system--36-resumen-logístico"></a>
### 36. Resumen logístico

Ejemplo:

```text
REGIÓN OCCIDENTAL

Estado general:
Tensión logística.

Déficits críticos:
• Combustible en Lakka.
• Medicina en Neochori.

Cuello de botella:
Ruta Stavros–Lakka amenazada.

Capacidad disponible:
2 convoyes ligeros.
1 convoy pesado en reparación.
```

---

<a id="src-strategic-ui-and-player-experience-system--37-recursos"></a>
### 37. Recursos

La interfaz agrupará categorías para no saturar.

<a id="src-strategic-ui-and-player-experience-system--vista-normal"></a>
#### Vista normal

```text
SUMINISTROS
COMBUSTIBLE
MUNICIÓN
MEDICINA
CONSTRUCCIÓN
REPUESTOS
ELECTRÓNICA
```

<a id="src-strategic-ui-and-player-experience-system--vista-avanzada"></a>
#### Vista avanzada

Podrá separar:

* munición ligera;
* pesada;
* AT;
* AA;
* artillería;
* piezas ligeras;
* pesadas;
* aviación.

---

<a id="src-strategic-ui-and-player-experience-system--38-tiempo-de-autonomía"></a>
### 38. Tiempo de autonomía

En lugar de mostrar solamente cantidades:

```text
Combustible: 24
```

se mostrará:

```text
Combustible:
24 unidades estratégicas

Autonomía estimada:
3 h 20 min con actividad actual

Si comienza la ofensiva:
1 h 45 min
```

---

<a id="src-strategic-ui-and-player-experience-system--39-demanda-y-reserva"></a>
### 39. Demanda y reserva

La interfaz distinguirá:

```text
EXISTENCIA TOTAL
RESERVADA
DISPONIBLE
EN TRÁNSITO
DEMANDA PREVISTA
```

<a id="src-strategic-ui-and-player-experience-system--objetivo"></a>
#### Objetivo

Evitar que el jugador crea que todo recurso almacenado puede utilizarse inmediatamente.

---

<a id="src-strategic-ui-and-player-experience-system--40-convoyes"></a>
### 40. Convoyes

Cada convoy mostrará:

* origen;
* destino;
* carga;
* estado;
* escolta;
* riesgo;
* llegada.

<a id="src-strategic-ui-and-player-experience-system--estados"></a>
#### Estados

```text
PLANIFICADO
CARGANDO
LISTO
EN RUTA
RETRASADO
BAJO ATAQUE
DESVIADO
LLEGADO
PERDIDO
```

---

<a id="src-strategic-ui-and-player-experience-system--41-detalle-de-convoy"></a>
### 41. Detalle de convoy

Ejemplo:

```text
CONVOY AZUL 014

Origen:
Katalaki.

Destino:
Neochori.

Carga:
24 FUEL
18 munición ligera
8 medicina

Escolta:
2 Hunter
1 escuadra

Riesgo:
Alto.

Amenaza principal:
Emboscadas en la ruta occidental.

Llegada estimada:
26 minutos.
```

---

<a id="src-strategic-ui-and-player-experience-system--42-mantenimiento"></a>
### 42. Mantenimiento

La vista de mantenimiento mostrará:

* vehículos operativos;
* dañados;
* inmovilizados;
* en reparación;
* repuestos necesarios;
* tiempo.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-6"></a>
#### Ejemplo

```text
Marshall B-02

Estado:
Daño pesado.

Necesita:
12 repuestos pesados.
Taller M2.
6 horas estimadas.

Situación:
Recuperable en Stavros.
```

---

<a id="src-strategic-ui-and-player-experience-system--43-misiones-y-operaciones"></a>
### 43. Misiones y operaciones

Se dividirán en:

```text
PRINCIPAL
OPERACIONES
EMERGENCIAS
INVESTIGACIONES
PERSONAJES
CIVILES
```

<a id="src-strategic-ui-and-player-experience-system--regla-4"></a>
#### Regla

La misión principal será visible, pero no bloqueará la consulta de otras necesidades.

---

<a id="src-strategic-ui-and-player-experience-system--44-tarjeta-de-misión"></a>
### 44. Tarjeta de misión

Cada tarjeta mostrará:

* emisor;
* intención;
* ubicación;
* urgencia;
* tiempo;
* consecuencia.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-7"></a>
#### Ejemplo

```text
EL PRIMER CONVOY

Emisor:
Thomas Rourke.

Intención:
Activar el centro logístico de Neochori.

Consecuencia si se ignora:
Otra unidad intentará la operación con menor escolta.

Tiempo:
21 minutos antes de la salida.
```

---

<a id="src-strategic-ui-and-player-experience-system--45-aceptación-y-rechazo"></a>
### 45. Aceptación y rechazo

La interfaz diferenciará:

```text
ACEPTAR
RECHAZAR
DELEGAR
POSPONER
SOLICITAR INFORMACIÓN
```

No todas las opciones estarán siempre disponibles.

---

<a id="src-strategic-ui-and-player-experience-system--46-delegación"></a>
### 46. Delegación

Cuando sea posible, el jugador podrá asignar otra unidad.

La interfaz mostrará:

* unidad;
* probabilidad estimada;
* coste;
* tiempo;
* tarea abandonada.

<a id="src-strategic-ui-and-player-experience-system--regla-5"></a>
#### Regla

No se mostrará una probabilidad exacta si el personaje no posee suficiente inteligencia.

---

<a id="src-strategic-ui-and-player-experience-system--47-consecuencias-previstas"></a>
### 47. Consecuencias previstas

La interfaz podrá mostrar estimaciones:

```text
Resultado probable:
La ruta quedará abierta.

Riesgos:
• Pérdida de vehículo.
• Daño civil.
• Exposición de la célula FIA.

Información insuficiente:
Desconocemos la presencia AT enemiga.
```

---

<a id="src-strategic-ui-and-player-experience-system--48-resultados-de-misión"></a>
### 48. Resultados de misión

Al finalizar se mostrará un informe posterior.

<a id="src-strategic-ui-and-player-experience-system--resumen"></a>
#### Resumen

* intención;
* resultado;
* pérdidas;
* recursos;
* territorio;
* relaciones;
* evidencia;
* consecuencias.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-8"></a>
#### Ejemplo

```text
RESULTADO: ÉXITO PARCIAL

✓ Carga principal llegó.
✓ Neochori recibió combustible.
✗ Dos vehículos perdidos.
✗ Evidencia costera destruida.

Consecuencias:
• Logística de Neochori estabilizada.
• Rourke valora la adaptación.
• Kessler pierde acceso a la evidencia original.
```

---

<a id="src-strategic-ui-and-player-experience-system--49-inteligencia"></a>
### 49. Inteligencia

La sección Inteligencia se organizará por:

* situación;
* contactos;
* requerimientos;
* informes;
* fuentes;
* contradicciones.

<a id="src-strategic-ui-and-player-experience-system--vista-principal-1"></a>
#### Vista principal

```text
SITUACIÓN ENEMIGA
REQUERIMIENTOS ABIERTOS
INFORMES NUEVOS
CONTRADICCIONES
FUENTES EN RIESGO
```

---

<a id="src-strategic-ui-and-player-experience-system--50-informe-de-inteligencia"></a>
### 50. Informe de inteligencia

Mostrará:

* contenido;
* hora observada;
* hora recibida;
* confianza;
* fuentes;
* contradicciones;
* clasificación.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-9"></a>
#### Ejemplo

```text
POSIBLE RESERVA MECANIZADA EN LAKKA

Observado:
Hace 51 minutos.

Recibido:
Hace 18 minutos.

Confianza:
Media.

Fuentes:
Dron táctico.
Informante civil.

Contradicción:
La señal de radio indica movimiento hacia el norte.
```

---

<a id="src-strategic-ui-and-player-experience-system--51-antigüedad-visible"></a>
### 51. Antigüedad visible

La interfaz deberá destacar:

```text
ACTUAL
ENVEJECIENDO
OBSOLETO
```

<a id="src-strategic-ui-and-player-experience-system--regla-6"></a>
#### Regla

Un informe confirmado puede ser obsoleto.

---

<a id="src-strategic-ui-and-player-experience-system--52-información-contradictoria"></a>
### 52. Información contradictoria

Cuando dos informes difieren:

```text
INFORMACIÓN EN CONFLICTO

Informe A:
La fuerza Verde prepara un contraataque.

Informe B:
La fuerza Verde está evacuando.

Causa posible:
Datos de horas diferentes.
Fuentes dependientes.
Actividad de engaño.
```

---

<a id="src-strategic-ui-and-player-experience-system--53-procedencia-de-informes"></a>
### 53. Procedencia de informes

La vista avanzada permitirá revisar:

* fuente original;
* nodo;
* analista;
* distribución;
* modificaciones.

<a id="src-strategic-ui-and-player-experience-system--importancia"></a>
#### Importancia

Permite detectar:

* circularidad;
* dependencia;
* manipulación Argos.

---

<a id="src-strategic-ui-and-player-experience-system--54-requerimientos-de-inteligencia"></a>
### 54. Requerimientos de inteligencia

El jugador podrá solicitar respuestas concretas.

Ejemplos:

* fuerza enemiga;
* ruta;
* intención;
* defensa AT;
* actividad civil;
* estado de nodo.

<a id="src-strategic-ui-and-player-experience-system--restricción"></a>
#### Restricción

Cada solicitud consume:

* tiempo;
* fuente;
* dron;
* unidad;
* prioridad.

---

<a id="src-strategic-ui-and-player-experience-system--55-investigación-de-argos"></a>
### 55. Investigación de Argos

Se representará mediante un tablero de investigación.

<a id="src-strategic-ui-and-player-experience-system--elementos"></a>
#### Elementos

* líneas;
* evidencias;
* conclusiones;
* preguntas;
* personajes;
* contradicciones.

<a id="src-strategic-ui-and-player-experience-system--regla-7"></a>
#### Regla

No será una pared de fotografías puramente decorativa.

Cada conexión deberá tener efecto funcional.

---

<a id="src-strategic-ui-and-player-experience-system--56-tablero-de-investigación"></a>
### 56. Tablero de investigación

Líneas principales:

```text
LÁZARO
PHAROS
ESPEJO AZUL
ASTERIÓN
ESCUDO ROTO
FARO NEGRO
UMBRAL
```

<a id="src-strategic-ui-and-player-experience-system--estados-visuales"></a>
#### Estados visuales

```text
DESCONOCIDA
SOSPECHADA
EN INVESTIGACIÓN
PROBABLE
CONFIRMADA
```

---

<a id="src-strategic-ui-and-player-experience-system--57-evidencias"></a>
### 57. Evidencias

Cada evidencia mostrará:

* estado;
* autenticidad;
* integridad;
* custodia;
* intérprete;
* relación con conclusiones.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-10"></a>
#### Ejemplo

```text
ÓRDENES ASTERIÓN DE MOLOS

Estado:
Recuperada.

Autenticidad:
Ambas firmas válidas.

Integridad:
Completa.

Problema:
Las órdenes son incompatibles.

Necesita:
Análisis de sellos y cronología.
```

---

<a id="src-strategic-ui-and-player-experience-system--58-entrega-de-evidencia"></a>
### 58. Entrega de evidencia

La interfaz deberá mostrar claramente:

* destinatario;
* beneficio;
* riesgo;
* pérdida de control;
* copia disponible.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-11"></a>
#### Ejemplo

```text
ENTREGAR A VOLKOV

Beneficio:
Análisis prioritario Rojo.

Riesgo:
La evidencia quedará clasificada.

Copias:
No existe copia segura.
```

---

<a id="src-strategic-ui-and-player-experience-system--59-conclusiones"></a>
### 59. Conclusiones

Una conclusión mostrará:

* qué se sabe;
* qué no se sabe;
* confianza;
* evidencias;
* implicación.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-12"></a>
#### Ejemplo

```text
PHAROS EXISTIÓ

Estado:
Altamente probable.

Confirmado:
• Pagos posteriores a muertes.
• Traslados hacia Stratis.

Sin demostrar:
• Cuántos operadores siguen vivos.
• Quién autorizó su retención.
```

---

<a id="src-strategic-ui-and-player-experience-system--60-helios"></a>
### 60. Helios

La sección Helios no estará disponible completamente desde el inicio.

<a id="src-strategic-ui-and-player-experience-system--niveles-de-acceso-visual"></a>
#### Niveles de acceso visual

<a id="src-strategic-ui-and-player-experience-system--h0"></a>
##### H0

Sin sección.

<a id="src-strategic-ui-and-player-experience-system--h1"></a>
##### H1

Resultados de Helios incluidos en informes.

<a id="src-strategic-ui-and-player-experience-system--h2"></a>
##### H2

Consulta de recomendaciones.

<a id="src-strategic-ui-and-player-experience-system--h3"></a>
##### H3

Fuentes y supuestos.

<a id="src-strategic-ui-and-player-experience-system--h4"></a>
##### H4

Operación de nodos.

<a id="src-strategic-ui-and-player-experience-system--h5"></a>
##### H5

Auditoría.

<a id="src-strategic-ui-and-player-experience-system--h6"></a>
##### H6

Control integral en Stratis.

---

<a id="src-strategic-ui-and-player-experience-system--61-recomendaciones-helios"></a>
### 61. Recomendaciones Helios

Cada recomendación mostrará:

* problema;
* acción;
* confianza;
* supuestos;
* riesgos;
* alternativas.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-13"></a>
#### Ejemplo

```text
RECOMENDACIÓN HELIOS

Acción:
Reforzar Lakka.

Confianza:
68 %

Supuestos principales:
• La reserva Verde permanece en Stavros.
• La ruta Neochori–Lakka seguirá abierta.
• El consumo de combustible no aumentará.

Riesgo:
La información enemiga tiene 42 minutos.
```

---

<a id="src-strategic-ui-and-player-experience-system--62-aceptación-de-recomendación"></a>
### 62. Aceptación de recomendación

Opciones:

```text
ACEPTAR
MODIFICAR
SOLICITAR CONFIRMACIÓN
RETRASAR
RECHAZAR
```

<a id="src-strategic-ui-and-player-experience-system--registro"></a>
#### Registro

La decisión se guardará para:

* progresión;
* perfil Argos;
* análisis posterior.

---

<a id="src-strategic-ui-and-player-experience-system--63-estado-del-nodo-helios"></a>
### 63. Estado del nodo Helios

Ejemplo:

```text
NODO AEROPUERTO MILITAR

Estado físico:
Control Azul.

Estado operativo:
Degradado.

Integridad:
Dudosa.

Acceso Azul:
Análisis limitado.

Acceso Argos:
Sospechado.

Dependencias:
Energía, comunicaciones y dos operadores.
```

---

<a id="src-strategic-ui-and-player-experience-system--64-auditoría-de-nodo"></a>
### 64. Auditoría de nodo

La interfaz deberá mostrar:

* progreso;
* técnico;
* tiempo;
* riesgos;
* servicios afectados.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-14"></a>
#### Ejemplo

```text
AUDITAR NODO

Tiempo:
4 horas.

Necesita:
Kessler o técnico equivalente.

Riesgo:
Helios-Civil quedará degradado durante la auditoría.

Posible consecuencia:
Argos puede detectar el acceso.
```

---

<a id="src-strategic-ui-and-player-experience-system--65-gobierno-y-población"></a>
### 65. Gobierno y población

La sección Sectores y Gobierno mostrará:

* control;
* autoridad;
* estabilidad;
* servicios;
* demandas;
* protestas;
* desplazamiento.

<a id="src-strategic-ui-and-player-experience-system--resumen-1"></a>
#### Resumen

No utilizará una única barra de apoyo.

---

<a id="src-strategic-ui-and-player-experience-system--66-panel-civil"></a>
### 66. Panel civil

Ejemplo:

```text
NEOCHORI — SITUACIÓN CIVIL

Población presente:
1.840

Estabilidad:
Frágil.

Obediencia a Azul:
Alta.

Confianza en Azul:
Baja.

Apoyo a Azul:
Limitado.

Necesidades críticas:
Medicina y electricidad.

Demanda activa:
Liberación de dos trabajadores detenidos.
```

---

<a id="src-strategic-ui-and-player-experience-system--67-autoridad-política"></a>
### 67. Autoridad política

La interfaz mostrará por separado:

```text
AUTORIDAD FORMAL
AUTORIDAD RECONOCIDA
AUTORIDAD EFECTIVA
CONTROL MILITAR
```

<a id="src-strategic-ui-and-player-experience-system--ejemplo-15"></a>
#### Ejemplo

```text
Autoridad formal:
Gobierno de Altis.

Autoridad reconocida:
Consejo municipal.

Autoridad efectiva:
Administración Azul supervisada.

Control militar:
Azul.
```

---

<a id="src-strategic-ui-and-player-experience-system--68-demandas-civiles"></a>
### 68. Demandas civiles

Cada demanda mostrará:

* emisor;
* causa;
* urgencia;
* opciones;
* consecuencias.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-16"></a>
#### Ejemplo

```text
REABRIR EL MERCADO

Emisor:
Consejo de Neochori.

Causa:
Escasez y desempleo.

Riesgo:
La apertura facilita contrabando.

Consecuencia si se ignora:
Aumento de mercado negro y protesta.
```

---

<a id="src-strategic-ui-and-player-experience-system--69-relaciones-y-progresión"></a>
### 69. Relaciones y progresión

La sección Unidad y Progresión mostrará:

* rango;
* autoridad;
* confianza;
* reputación;
* capacidades;
* miembros;
* heridas;
* especialidades.

---

<a id="src-strategic-ui-and-player-experience-system--70-autoridad-del-jugador"></a>
### 70. Autoridad del jugador

Ejemplo:

```text
AUTORIDAD ACTUAL

Militar:
A2 — Coordinación táctica.

Logística:
A1 — Solicitud y prioridad local.

Civil:
A1 — Recomendación.

Política:
A0 — Sin autoridad formal.

Inteligencia:
I2 — Consulta de fuentes.

Helios:
H1 — Resultados procesados.
```

---

<a id="src-strategic-ui-and-player-experience-system--71-explicación-de-autoridad"></a>
### 71. Explicación de autoridad

Al seleccionar un nivel:

```text
A2 — COORDINACIÓN

Permite:
• Coordinar hasta tres grupos aliados.
• Elegir el orden de objetivos.
• Solicitar reserva local.

No permite:
• Cambiar el objetivo regional.
• Reasignar una compañía completa.
```

---

<a id="src-strategic-ui-and-player-experience-system--72-relaciones-con-comandantes"></a>
### 72. Relaciones con comandantes

La vista mostrará estados cualitativos.

Ejemplo:

```text
ELENA WARD

Relación:
Confianza profesional.

Te considera:
Competente y prudente.

Dudas:
Tiendes a ocultar información sensible.

Efectos:
Puede delegarte defensa regional.
No autorizará todavía acceso Helios avanzado.
```

---

<a id="src-strategic-ui-and-player-experience-system--73-confianza-multidimensional"></a>
### 73. Confianza multidimensional

La vista avanzada puede mostrar:

```text
Competencia: alta
Juicio: alto
Lealtad percibida: media
Discreción: media
Confianza política: alta
Confianza personal: baja
```

---

<a id="src-strategic-ui-and-player-experience-system--74-reputaciones-externas"></a>
### 74. Reputaciones externas

Ejemplo:

```text
FIA — MARKOU
Relación: cooperación limitada.

FIA — KALLAS
Relación: tensión.

Fuerza Verde reformista:
Respeto profesional.

Municipios occidentales:
Confianza creciente.
```

---

<a id="src-strategic-ui-and-player-experience-system--75-unidad-protagonista"></a>
### 75. Unidad protagonista

La pantalla de AZUR-1 o RUBÍ-1 mostrará:

* miembros;
* función;
* estado;
* heridas;
* confianza;
* especialidades;
* disponibilidad.

<a id="src-strategic-ui-and-player-experience-system--no-mostrará-1"></a>
#### No mostrará

Puntos de experiencia genéricos.

---

<a id="src-strategic-ui-and-player-experience-system--76-miembro-de-escuadra"></a>
### 76. Miembro de escuadra

Ejemplo:

```text
JONAH REED

Estado:
Activo.

Especialidades:
Comunicaciones.
Análisis Helios básico.

Confianza profesional:
Alta.

Confianza personal:
Media.

Fatiga:
Moderada.

Situación:
Preocupado por las inconsistencias de Shaw.
```

---

<a id="src-strategic-ui-and-player-experience-system--77-capacidades-desbloqueadas"></a>
### 77. Capacidades desbloqueadas

Se mostrarán con disponibilidad real.

Ejemplo:

```text
APOYO DE MORTERO

Autorización:
Disponible.

Activo:
Mortero Azul M-01.

Munición:
12 misiones de fuego ligero.

Comunicación:
Operativa.

Estado:
Disponible.
```

---

<a id="src-strategic-ui-and-player-experience-system--78-capacidad-bloqueada"></a>
### 78. Capacidad bloqueada

Ejemplo:

```text
APOYO AÉREO

Autorización:
Disponible.

Bloqueo:
AAC inutilizable.

Requisitos pendientes:
Reparar pista.
Asignar combustible de aviación.
```

---

<a id="src-strategic-ui-and-player-experience-system--79-archivo-de-campaña"></a>
### 79. Archivo de campaña

Será el registro histórico de la partida.

Contendrá:

* cronología;
* misiones;
* decisiones;
* promesas;
* bajas;
* sectores;
* personajes;
* evidencias;
* consecuencias.

---

<a id="src-strategic-ui-and-player-experience-system--80-cronología"></a>
### 80. Cronología

Ejemplo:

```text
DÍA 0 — 05:40
Azul inició desembarco en Katalaki.

DÍA 0 — 07:12
Neochori aceptó administración supervisada.

DÍA 0 — 09:25
El primer convoy perdió dos vehículos.

DÍA 0 — 23:41
Se recibió la transmisión “S-26 activa”.
```

---

<a id="src-strategic-ui-and-player-experience-system--81-decisiones-registradas"></a>
### 81. Decisiones registradas

Cada decisión importante mostrará:

* contexto;
* opción elegida;
* alternativas;
* consecuencia conocida.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-17"></a>
#### Ejemplo

```text
DECISIÓN:
Consolidar Katalaki antes de avanzar.

Resultado conocido:
• Defensa mejorada.
• Hale perdió confianza.
• Neochori recibió más tiempo para prepararse.
```

---

<a id="src-strategic-ui-and-player-experience-system--82-consecuencias-desconocidas"></a>
### 82. Consecuencias desconocidas

La interfaz no revelará consecuencias que el personaje todavía no conozca.

Puede mostrar:

```text
Consecuencias adicionales:
Aún desconocidas.
```

---

<a id="src-strategic-ui-and-player-experience-system--83-promesas"></a>
### 83. Promesas

El archivo mostrará:

```text
PROMESA ACTIVA
PROMESA CUMPLIDA
PROMESA RETRASADA
PROMESA ROTA
```

<a id="src-strategic-ui-and-player-experience-system--ejemplo-18"></a>
#### Ejemplo

```text
Promesa:
Restablecer agua en Neochori.

Plazo:
Día 2.

Estado:
En progreso.
```

---

<a id="src-strategic-ui-and-player-experience-system--84-briefing"></a>
### 84. Briefing

El briefing antes de una misión se dividirá en:

```text
SITUACIÓN
INTENCIÓN
OBJETIVOS
FUERZAS
INTELIGENCIA
LOGÍSTICA
RESTRICCIONES
ALTERNATIVAS
```

<a id="src-strategic-ui-and-player-experience-system--regla-8"></a>
#### Regla

No se utilizarán párrafos largos cuando un mapa, esquema o lista sea más claro.

---

<a id="src-strategic-ui-and-player-experience-system--85-intención-frente-a-objetivos"></a>
### 85. Intención frente a objetivos

El briefing debe indicar primero la intención.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-19"></a>
#### Ejemplo

```text
INTENCIÓN:
Mantener una ruta logística funcional hacia Neochori.

OBJETIVOS:
• Proteger el convoy.
• Mantener al menos una ruta abierta.
• Evitar daños al puente.
```

Esto permite improvisar sin perder el propósito.

---

<a id="src-strategic-ui-and-player-experience-system--86-información-incierta-en-briefing"></a>
### 86. Información incierta en briefing

Ejemplo:

```text
ENEMIGO

Confirmado:
Una escuadra Verde en la ruta principal.

Estimado:
Posible equipo AT en las alturas.

Desconocido:
Reservas desde Stavros.
```

---

<a id="src-strategic-ui-and-player-experience-system--87-debriefing"></a>
### 87. Debriefing

El debriefing no evaluará solamente:

* enemigos eliminados;
* tiempo;
* precisión.

Evaluará:

* intención;
* fuerza;
* recursos;
* civiles;
* información;
* relaciones;
* efectos estratégicos.

---

<a id="src-strategic-ui-and-player-experience-system--88-interfaz-táctica"></a>
### 88. Interfaz táctica

Durante combate deberá ser limitada.

Elementos principales:

* objetivo inmediato;
* comunicación;
* estado de escuadra;
* apoyos;
* interacción;
* alertas críticas.

---

<a id="src-strategic-ui-and-player-experience-system--89-objetivo-táctico"></a>
### 89. Objetivo táctico

No debe cubrir gran parte de la pantalla.

Ejemplo:

```text
OBJETIVO ACTUAL
Asegurar el punto de descarga.

Condición:
Ingenieros deben permanecer operativos.
```

---

<a id="src-strategic-ui-and-player-experience-system--90-estado-de-escuadra"></a>
### 90. Estado de escuadra

Debe mostrar:

* miembros;
* heridas;
* separación;
* estado;
* función.

<a id="src-strategic-ui-and-player-experience-system--importante-2"></a>
#### Importante

No sobrecargar con datos estratégicos.

---

<a id="src-strategic-ui-and-player-experience-system--91-apoyos-tácticos"></a>
### 91. Apoyos tácticos

Menú contextual:

```text
MORTERO
DRON
EVACUACIÓN
TRANSPORTE
QRF
ARTILLERÍA
APOYO AÉREO
```

Cada opción muestra:

* disponible;
* bloqueada;
* en preparación;
* en uso;
* agotada.

---

<a id="src-strategic-ui-and-player-experience-system--92-solicitud-de-apoyo"></a>
### 92. Solicitud de apoyo

Ejemplo:

```text
MORTERO

Estado:
Disponible.

Munición:
Baja.

Tiempo:
45 segundos.

Riesgo civil:
Alto en el área seleccionada.
```

---

<a id="src-strategic-ui-and-player-experience-system--93-comunicaciones"></a>
### 93. Comunicaciones

Los mensajes de radio tendrán prioridad.

<a id="src-strategic-ui-and-player-experience-system--niveles"></a>
#### Niveles

```text
MANDO
TÁCTICO
EMERGENCIA
INFORMACIÓN
DIÁLOGO
```

<a id="src-strategic-ui-and-player-experience-system--regla-9"></a>
#### Regla

Una conversación secundaria no debe cubrir una emergencia táctica.

---

<a id="src-strategic-ui-and-player-experience-system--94-cola-de-comunicaciones"></a>
### 94. Cola de comunicaciones

Los mensajes no críticos pueden:

* retrasarse;
* resumirse;
* quedar en registro.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-20"></a>
#### Ejemplo

Durante combate, una petición civil se muestra después o como alerta discreta.

---

<a id="src-strategic-ui-and-player-experience-system--95-interacciones-contextuales"></a>
### 95. Interacciones contextuales

Las acciones deberán ser claras.

Ejemplos:

* registrar evidencia;
* tratar herido;
* interrogar;
* colocar explosivo;
* ordenar rendición;
* hablar;
* recuperar vehículo.

<a id="src-strategic-ui-and-player-experience-system--regla-10"></a>
#### Regla

La misma tecla no debe producir opciones ambiguas sin contexto visible.

---

<a id="src-strategic-ui-and-player-experience-system--96-diálogo-interactivo"></a>
### 96. Diálogo interactivo

Las decisiones de diálogo mostrarán intención, no el resultado oculto.

Ejemplo:

```text
[Negociar]
“Podemos mantener el consejo local si abren la ruta.”

[Presionar]
“Si bloquean el paso, serán tratados como fuerza hostil.”

[Esperar]
“Solicitaré confirmación del Gobierno.”
```

---

<a id="src-strategic-ui-and-player-experience-system--97-decisiones-sensibles"></a>
### 97. Decisiones sensibles

Antes de una decisión irreversible se mostrará:

* alcance;
* autoridad;
* consecuencia inmediata;
* permanencia.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-21"></a>
#### Ejemplo

```text
DESTRUIR NODO HELIOS

Esta acción:
• Desactivará el nodo permanentemente.
• Interrumpirá comunicaciones civiles.
• Destruirá parte de los archivos.

No podrá revertirse durante la campaña.
```

---

<a id="src-strategic-ui-and-player-experience-system--98-confirmaciones"></a>
### 98. Confirmaciones

No se pedirá confirmación para cada acción común.

Se utilizará en:

* decisiones irreversibles;
* destrucción estratégica;
* publicación;
* ejecución;
* ruptura de alianza;
* punto de no retorno.

---

<a id="src-strategic-ui-and-player-experience-system--99-puntos-de-no-retorno"></a>
### 99. Puntos de no retorno

La interfaz debe mostrarlos claramente.

Ejemplo:

```text
PARTIR HACIA STRATIS

Antes de continuar:
• 3 operaciones urgentes quedarán sin resolver.
• 1 investigación puede perderse.
• La fuerza seleccionada no regresará a Altis inmediatamente.

Esta decisión inicia el punto de no retorno del Acto VIII.
```

---

<a id="src-strategic-ui-and-player-experience-system--100-estados-de-carga"></a>
### 100. Estados de carga

La interfaz debe manejar:

```text
CARGANDO
SIN DATOS
DATOS INCOMPLETOS
SIN AUTORIDAD
SISTEMA DEGRADADO
ERROR
```

<a id="src-strategic-ui-and-player-experience-system--ejemplo-22"></a>
#### Ejemplo

```text
DATOS LOGÍSTICOS INCOMPLETOS

El nodo de comunicaciones de Lakka está aislado.
La última actualización se recibió hace 2 horas.
```

---

<a id="src-strategic-ui-and-player-experience-system--101-errores-explicables"></a>
### 101. Errores explicables

No mostrar únicamente:

```text
ERROR 17
```

Mostrar:

```text
No se pudo asignar la compañía.

Motivo:
La formación ya está reservada para la defensa de Neochori.

Acciones:
• Cancelar la defensa.
• Seleccionar otra fuerza.
• Esperar a que finalice la operación.
```

---

<a id="src-strategic-ui-and-player-experience-system--102-guardado-y-carga"></a>
### 102. Guardado y carga

La pantalla de guardado mostrará:

* campaña;
* bando;
* acto;
* fecha estratégica;
* misión;
* sector;
* estado;
* integridad.

---

<a id="src-strategic-ui-and-player-experience-system--103-tipos-de-guardado"></a>
### 103. Tipos de guardado

```text
AUTOMÁTICO
PUNTO DE CONTROL
MANUAL
PREVIO A MISIÓN
PREVIO A NO RETORNO
```

<a id="src-strategic-ui-and-player-experience-system--regla-11"></a>
#### Regla

El jugador debe comprender qué estado recuperará.

---

<a id="src-strategic-ui-and-player-experience-system--104-advertencia-de-guardado-táctico"></a>
### 104. Advertencia de guardado táctico

Si guarda durante combate:

```text
Este guardado contiene una batalla activa.
Al cargar se reconstruirá la proyección táctica actual.
```

---

<a id="src-strategic-ui-and-player-experience-system--105-accesibilidad"></a>
### 105. Accesibilidad

La interfaz deberá permitir:

* tamaño de texto;
* contraste;
* subtítulos;
* identificación de hablante;
* velocidad de texto;
* navegación por teclado;
* reducción de animaciones;
* iconos con forma y texto;
* opciones para daltonismo.

---

<a id="src-strategic-ui-and-player-experience-system--106-colores"></a>
### 106. Colores

El color no será el único indicador.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-23"></a>
#### Ejemplo

Control:

* color;
* icono de facción;
* patrón;
* texto.

<a id="src-strategic-ui-and-player-experience-system--estados-1"></a>
#### Estados

* forma;
* borde;
* etiqueta;
* símbolo.

---

<a id="src-strategic-ui-and-player-experience-system--107-subtítulos"></a>
### 107. Subtítulos

Deben mostrar:

* nombre;
* función;
* canal;
* urgencia.

Ejemplo:

```text
[RADIO — WARD, MANDO AZUL]
Mantengan la cabeza de playa. No persigan.
```

---

<a id="src-strategic-ui-and-player-experience-system--108-audio-y-texto"></a>
### 108. Audio y texto

Información crítica no dependerá solamente del audio.

Toda orden relevante debe estar disponible en:

* subtítulo;
* registro;
* briefing;
* misión.

---

<a id="src-strategic-ui-and-player-experience-system--109-dificultad-informativa"></a>
### 109. Dificultad informativa

<a id="src-strategic-ui-and-player-experience-system--fácil"></a>
#### Fácil

* explicaciones ampliadas;
* rutas sugeridas;
* alertas tempranas;
* indicadores de antigüedad claros.

<a id="src-strategic-ui-and-player-experience-system--normal"></a>
#### Normal

* información estándar;
* incertidumbre visible.

<a id="src-strategic-ui-and-player-experience-system--difícil"></a>
#### Difícil

* menos ayudas;
* más necesidad de revisar fuentes;
* menos estimaciones automáticas.

<a id="src-strategic-ui-and-player-experience-system--regla-12"></a>
#### Regla

La dificultad no esconderá reglas esenciales.

---

<a id="src-strategic-ui-and-player-experience-system--110-tutorial-integrado"></a>
### 110. Tutorial integrado

No existirán tutoriales largos separados para cada sistema.

Se introducirán mediante:

* Acto I;
* asesores;
* decisiones reales;
* interfaz progresiva.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-24"></a>
#### Ejemplo

Katalaki introduce:

* sector;
* prioridad;
* logística.

Neochori introduce:

* gobierno;
* estabilidad;
* convoyes.

La primera noche introduce:

* inteligencia;
* evidencia.

---

<a id="src-strategic-ui-and-player-experience-system--111-desbloqueo-progresivo-de-interfaz"></a>
### 111. Desbloqueo progresivo de interfaz

<a id="src-strategic-ui-and-player-experience-system--prólogo"></a>
#### Prólogo

* misión;
* escuadra;
* mapa táctico.

<a id="src-strategic-ui-and-player-experience-system--acto-i"></a>
#### Acto I

* sectores;
* logística;
* fuerzas básicas.

<a id="src-strategic-ui-and-player-experience-system--acto-ii"></a>
#### Acto II

* inteligencia;
* informes;
* requerimientos.

<a id="src-strategic-ui-and-player-experience-system--acto-iii"></a>
#### Acto III

* planeamiento regional;
* construcción avanzada.

<a id="src-strategic-ui-and-player-experience-system--acto-iv"></a>
#### Acto IV

* gobierno;
* relaciones civiles;
* FIA.

<a id="src-strategic-ui-and-player-experience-system--actos-vvi"></a>
#### Actos V–VI

* política;
* Helios;
* auditoría.

<a id="src-strategic-ui-and-player-experience-system--actos-viiviii"></a>
#### Actos VII–VIII

* mando operacional;
* control de nodos;
* decisiones estratégicas.

---

<a id="src-strategic-ui-and-player-experience-system--112-información-contextual-por-autoridad"></a>
### 112. Información contextual por autoridad

El jugador no verá controles que nunca podrá utilizar en ese momento.

<a id="src-strategic-ui-and-player-experience-system--ejemplo-25"></a>
#### Ejemplo

Con autoridad A1:

```text
Solicitar refuerzo
```

Con autoridad A3:

```text
Asignar formación
```

<a id="src-strategic-ui-and-player-experience-system--ventaja"></a>
#### Ventaja

Reduce confusión y evita prometer capacidades inexistentes.

---

<a id="src-strategic-ui-and-player-experience-system--113-información-contextual-por-conocimiento"></a>
### 113. Información contextual por conocimiento

La interfaz distinguirá:

```text
DESCONOCIDO
NO AUTORIZADO
NO DISPONIBLE
```

<a id="src-strategic-ui-and-player-experience-system--diferencia"></a>
#### Diferencia

<a id="src-strategic-ui-and-player-experience-system--desconocido"></a>
##### Desconocido

El personaje no sabe que existe.

<a id="src-strategic-ui-and-player-experience-system--no-autorizado"></a>
##### No autorizado

Sabe que existe, pero no tiene acceso.

<a id="src-strategic-ui-and-player-experience-system--no-disponible"></a>
##### No disponible

Posee acceso, pero el recurso o activo falta.

---

<a id="src-strategic-ui-and-player-experience-system--114-seguridad-narrativa"></a>
### 114. Seguridad narrativa

No se mostrarán:

* identidad de Shaw como infiltrada;
* acceso Argos;
* fuerza real enemiga;
* consecuencia oculta;
* destino de personaje;

hasta que el personaje tenga conocimiento válido.

---

<a id="src-strategic-ui-and-player-experience-system--115-perspectiva-azul-y-roja"></a>
### 115. Perspectiva Azul y Roja

La misma interfaz tendrá diferencias doctrinales.

<a id="src-strategic-ui-and-player-experience-system--azul"></a>
#### Azul

* lenguaje de coalición;
* énfasis en riesgos;
* inteligencia técnica;
* autorizaciones.

<a id="src-strategic-ui-and-player-experience-system--rojo"></a>
#### Rojo

* lenguaje de pacto;
* énfasis en corredores;
* cadena de mando;
* cooperación gubernamental.

<a id="src-strategic-ui-and-player-experience-system--regla-13"></a>
#### Regla

La estructura funcional será compartida para reducir costes.

La identidad visual y terminología cambiarán.

---

<a id="src-strategic-ui-and-player-experience-system--116-perspectiva-fia-temporal"></a>
### 116. Perspectiva FIA temporal

Cuando el jugador coopere con FIA, podrá recibir:

* mapas incompletos;
* rutas locales;
* contactos;
* nombres;
* información humana.

No se transformará toda la interfaz en un sistema de mando FIA.

---

<a id="src-strategic-ui-and-player-experience-system--117-stratis"></a>
### 117. Stratis

La interfaz en Stratis debe sentirse diferente.

<a id="src-strategic-ui-and-player-experience-system--cambios"></a>
#### Cambios

* mapa más compacto;
* mayor densidad de nodos;
* menor certeza institucional;
* más información técnica;
* comunicaciones degradadas;
* decisiones irreversibles.

---

<a id="src-strategic-ui-and-player-experience-system--118-interfaz-de-helios-core"></a>
### 118. Interfaz de HELIOS-CORE

Debe mostrar:

* capas;
* accesos;
* operadores;
* integridad;
* procesos;
* decisiones.

<a id="src-strategic-ui-and-player-experience-system--no-debe-parecer"></a>
#### No debe parecer

Una pantalla de ciencia ficción omnipotente.

Debe conservar apariencia de:

* infraestructura nacional;
* centro de coordinación;
* sistema técnico militarizado.

---

<a id="src-strategic-ui-and-player-experience-system--119-modos-de-uso-de-helios-core"></a>
### 119. Modos de uso de HELIOS-CORE

```text
AUDITAR
AISLAR
COPIAR
DESCONECTAR
RECONFIGURAR
DESTRUIR
TRANSFERIR
```

Cada acción muestra:

* requisitos;
* tiempo;
* servicios;
* riesgo;
* autoridad.

---

<a id="src-strategic-ui-and-player-experience-system--120-cooperativo-futuro"></a>
### 120. Cooperativo futuro

La interfaz estratégica será compartida por campaña.

<a id="src-strategic-ui-and-player-experience-system--reglas"></a>
#### Reglas

* servidor mantiene estado;
* jugadores ven misma realidad autorizada;
* decisiones críticas requieren líder o voto;
* misiones no se duplican;
* alertas se comparten.

---

<a id="src-strategic-ui-and-player-experience-system--121-roles-cooperativos"></a>
### 121. Roles cooperativos

Posibles:

* líder de operación;
* inteligencia;
* logística;
* táctico;
* piloto.

<a id="src-strategic-ui-and-player-experience-system--regla-14"></a>
#### Regla

Los roles ayudan a organizar.

No crean campañas separadas.

---

<a id="src-strategic-ui-and-player-experience-system--122-conflictos-de-decisión-en-cooperativo"></a>
### 122. Conflictos de decisión en cooperativo

Opciones:

* líder decide;
* votación;
* permiso por rol;
* confirmación conjunta.

Las decisiones irreversibles deberán quedar registradas con el jugador responsable.

---

<a id="src-strategic-ui-and-player-experience-system--123-arquitectura-visual"></a>
### 123. Arquitectura visual

La identidad deberá reflejar:

* guerra contemporánea;
* administración militar;
* sistemas civiles degradados;
* Helios como infraestructura real.

<a id="src-strategic-ui-and-player-experience-system--estilo"></a>
#### Estilo

* fondos oscuros o neutros;
* mapas legibles;
* tipografía funcional;
* acentos de facción;
* iconografía sobria;
* poco brillo futurista.

---

<a id="src-strategic-ui-and-player-experience-system--124-identidad-azul"></a>
### 124. Identidad Azul

Características:

* azul grisáceo;
* paneles modulares;
* información técnica;
* estructura de coalición.

---

<a id="src-strategic-ui-and-player-experience-system--125-identidad-roja"></a>
### 125. Identidad Roja

Características:

* rojo oscuro;
* tonos tierra;
* estructura de mando;
* énfasis operacional.

---

<a id="src-strategic-ui-and-player-experience-system--126-identidad-verde"></a>
### 126. Identidad Verde

Características:

* verde oliva;
* documentación estatal;
* marcas antiguas;
* canales fragmentados.

---

<a id="src-strategic-ui-and-player-experience-system--127-identidad-fia"></a>
### 127. Identidad FIA

Características:

* documentos escaneados;
* anotaciones;
* mapas civiles;
* símbolos locales.

<a id="src-strategic-ui-and-player-experience-system--límite"></a>
#### Límite

No caer en estilo improvisado ilegible.

---

<a id="src-strategic-ui-and-player-experience-system--128-identidad-helios"></a>
### 128. Identidad Helios

Características:

* diagramas de red;
* procedencia;
* auditoría;
* datos institucionales;
* advertencias de integridad.

---

<a id="src-strategic-ui-and-player-experience-system--129-rendimiento-de-interfaz"></a>
### 129. Rendimiento de interfaz

La interfaz no consultará continuamente todos los sistemas.

<a id="src-strategic-ui-and-player-experience-system--usará"></a>
#### Usará

* snapshots;
* eventos;
* caché;
* actualización por sección;
* paginación;
* agregación.

---

<a id="src-strategic-ui-and-player-experience-system--130-actualización-visual"></a>
### 130. Actualización visual

<a id="src-strategic-ui-and-player-experience-system--táctica"></a>
#### Táctica

Información inmediata.

<a id="src-strategic-ui-and-player-experience-system--estratégica-abierta"></a>
#### Estratégica abierta

Actualización cada pocos segundos o por evento.

<a id="src-strategic-ui-and-player-experience-system--panel-cerrado"></a>
#### Panel cerrado

No necesita reconstrucción constante.

---

<a id="src-strategic-ui-and-player-experience-system--131-contratos-de-datos-de-interfaz"></a>
### 131. Contratos de datos de interfaz

La interfaz no accederá directamente a estructuras internas arbitrarias.

Recibirá modelos preparados.

Ejemplo:

```sqf
IF_sectorViewModel = createHashMapFromArray [
    ["sectorId", "ALT_CW_NEOCHORI"],
    ["displayName", "Neochori"],
    ["knownControl", "BLUE"],
    ["controlConfidence", "CONFIRMED"],
    ["primaryRole", "LOGISTICS"],
    ["stabilityLabel", "FRAGILE"],
    ["threatLabel", "HIGH"],
    ["primaryIssue", "FUEL_CRITICAL"],
    ["availableActions", []],
    ["lastUpdatedAt", 1320]
];
```

---

<a id="src-strategic-ui-and-player-experience-system--132-modelo-de-alerta"></a>
### 132. Modelo de alerta

```sqf
IF_alertViewModel = createHashMapFromArray [
    ["alertId", "ALERT_LOG_LAKKA_014"],
    ["severity", "URGENT"],
    ["category", "LOGISTICS"],
    ["title", "Combustible crítico en Lakka"],
    ["summary", "La QRF perderá movilidad en 3 horas."],
    ["sectorId", "ALT_CW_LAKKA"],
    ["relatedMissionId", "DYN_BLUE_A03_014"],
    ["expiresAt", 1450],
    ["availableActions", [
        "OPEN_LOGISTICS",
        "ACCEPT_MISSION",
        "DISMISS"
    ]]
];
```

---

<a id="src-strategic-ui-and-player-experience-system--133-modelo-de-misión-visible"></a>
### 133. Modelo de misión visible

```sqf
IF_missionViewModel = createHashMapFromArray [
    ["missionId", "DYN_BLUE_A03_014"],
    ["title", "El corredor de Lakka"],
    ["category", "OPERATION"],
    ["priority", "URGENT"],
    ["requesterName", "Thomas Rourke"],
    ["intent", "Mantener la movilidad de la QRF."],
    ["knownRisks", []],
    ["unknownFactors", []],
    ["softDeadline", 1400],
    ["hardDeadline", 1480],
    ["availableResponses", [
        "ACCEPT",
        "DELEGATE",
        "POSTPONE"
    ]]
];
```

---

<a id="src-strategic-ui-and-player-experience-system--134-modelo-de-informe-visible"></a>
### 134. Modelo de informe visible

```sqf
IF_intelViewModel = createHashMapFromArray [
    ["reportId", "INT_BLUE_LAKKA_ARMOR_014"],
    ["title", "Posible reserva mecanizada en Lakka"],
    ["confidenceLabel", "MEDIA"],
    ["ageLabel", "ENVEJECIENDO"],
    ["observedAgoMinutes", 51],
    ["receivedAgoMinutes", 18],
    ["sourceLabels", [
        "Dron táctico",
        "Informante civil"
    ]],
    ["contradictionCount", 1],
    ["classificationLabel", "SECRETO"]
];
```

---

<a id="src-strategic-ui-and-player-experience-system--135-funciones-conceptuales"></a>
### 135. Funciones conceptuales

```text
IF_fnc_uiOpenCommandCenter
IF_fnc_uiOpenStrategicMap
IF_fnc_uiBuildSectorViewModel
IF_fnc_uiBuildFormationViewModel
IF_fnc_uiBuildLogisticsViewModel
IF_fnc_uiBuildMissionViewModel
IF_fnc_uiBuildIntelViewModel
IF_fnc_uiBuildCivilViewModel
IF_fnc_uiBuildHeliosViewModel
IF_fnc_uiBuildProgressionViewModel
IF_fnc_uiCreateAlert
IF_fnc_uiGroupAlerts
IF_fnc_uiRefreshActivePanel
IF_fnc_uiExplainUnavailableAction
IF_fnc_uiRegisterDecision
IF_fnc_uiOpenPointOfNoReturn
IF_fnc_uiApplyAccessibilitySettings
```

---

<a id="src-strategic-ui-and-player-experience-system--136-vertical-slice-de-interfaz"></a>
### 136. Vertical slice de interfaz

El vertical slice Azul del Acto I debe implementar:

1. Centro de mando básico.
2. Mapa de nueve sectores.
3. Panel de sector.
4. Vista de misión.
5. Logística básica.
6. Fuerzas básicas.
7. Prioridad de construcción.
8. Alerta de convoy.
9. Informe de inteligencia.
10. Relación Ward–Hale.
11. Estado de AZUR-1.
12. Archivo de decisiones.

---

<a id="src-strategic-ui-and-player-experience-system--137-flujo-del-vertical-slice"></a>
### 137. Flujo del vertical slice

<a id="src-strategic-ui-and-player-experience-system--prólogo-1"></a>
#### Prólogo

* briefing;
* unidad;
* mapa táctico.

<a id="src-strategic-ui-and-player-experience-system--katalaki"></a>
#### Katalaki

* objetivo;
* situación;
* fuerza.

<a id="src-strategic-ui-and-player-experience-system--cabeza-de-playa"></a>
#### Cabeza de playa

* panel de sector;
* prioridad.

<a id="src-strategic-ui-and-player-experience-system--neochori"></a>
#### Neochori

* gobierno;
* civiles;
* logística.

<a id="src-strategic-ui-and-player-experience-system--convoy"></a>
#### Convoy

* alerta;
* misión;
* ruta.

<a id="src-strategic-ui-and-player-experience-system--contraataque"></a>
#### Contraataque

* frente;
* fuerza;
* apoyo.

<a id="src-strategic-ui-and-player-experience-system--primera-noche"></a>
#### Primera noche

* inteligencia;
* evidencia;
* destinatario.

---

<a id="src-strategic-ui-and-player-experience-system--138-prueba-1-información-no-autorizada"></a>
### 138. Prueba 1 — Información no autorizada

Intentar abrir Helios avanzado durante Acto I.

Resultado:

```text
Acceso no autorizado.
```

No mostrar nodos secretos.

---

<a id="src-strategic-ui-and-player-experience-system--139-prueba-2-información-desconocida"></a>
### 139. Prueba 2 — Información desconocida

Consultar fuerza enemiga sin inteligencia.

Resultado:

```text
Sin información fiable.
```

No mostrar cifras reales.

---

<a id="src-strategic-ui-and-player-experience-system--140-prueba-3-recurso-bloqueado"></a>
### 140. Prueba 3 — Recurso bloqueado

Tener artillería desbloqueada sin munición.

Resultado:

* capacidad visible;
* no disponible;
* explicación correcta.

---

<a id="src-strategic-ui-and-player-experience-system--141-prueba-4-alertas-agrupadas"></a>
### 141. Prueba 4 — Alertas agrupadas

Crear varios problemas logísticos relacionados.

Resultado:

* una crisis consolidada;
* detalles accesibles.

---

<a id="src-strategic-ui-and-player-experience-system--142-prueba-5-antigüedad"></a>
### 142. Prueba 5 — Antigüedad

Actualizar y dejar envejecer un informe.

Resultado:

* cambia estado;
* aumenta incertidumbre visual.

---

<a id="src-strategic-ui-and-player-experience-system--143-prueba-6-relación-multidimensional"></a>
### 143. Prueba 6 — Relación multidimensional

Ganar competencia y perder lealtad.

Resultado:

* descripción coherente;
* sin promedio engañoso.

---

<a id="src-strategic-ui-and-player-experience-system--144-prueba-7-consecuencia-desconocida"></a>
### 144. Prueba 7 — Consecuencia desconocida

Tomar decisión con efecto Argos oculto.

Resultado:

* no revelar hasta descubrirse.

---

<a id="src-strategic-ui-and-player-experience-system--145-prueba-8-punto-de-no-retorno"></a>
### 145. Prueba 8 — Punto de no retorno

Partir hacia Stratis con operaciones activas.

Resultado:

* advertencia completa;
* decisión registrada.

---

<a id="src-strategic-ui-and-player-experience-system--146-prueba-9-accesibilidad"></a>
### 146. Prueba 9 — Accesibilidad

Validar:

* texto grande;
* contraste;
* navegación;
* subtítulos;
* iconos sin dependencia exclusiva del color.

---

<a id="src-strategic-ui-and-player-experience-system--147-prueba-10-rendimiento"></a>
### 147. Prueba 10 — Rendimiento

Abrir mapa con:

* 38 sectores;
* fuerzas;
* alertas;
* rutas;
* informes.

Validar:

* actualización estable;
* sin reconstrucciones innecesarias.

---

<a id="src-strategic-ui-and-player-experience-system--148-invariantes-de-interfaz"></a>
### 148. Invariantes de interfaz

1. La interfaz no accede a la realidad secreta.
2. Toda información visible posee fuente o autorización.
3. Control militar y autoridad política se muestran separados.
4. Confianza y precisión se muestran separadas.
5. Una capacidad bloqueada explica su causa.
6. Una alerta explica su impacto.
7. Una misión explica qué ocurre si se ignora.
8. Una fuerza no disponible muestra su tarea actual.
9. La construcción no permite colocar manualmente.
10. La información envejecida se identifica.
11. Las contradicciones se muestran.
12. Las decisiones irreversibles requieren confirmación.
13. Las consecuencias ocultas permanecen ocultas.
14. La misma información no se duplica sin añadir profundidad.
15. Los paneles principales muestran decisiones, no todos los datos.
16. Los detalles avanzados permanecen accesibles.
17. La interfaz táctica no sustituye a la estratégica.
18. La estratégica no invade el combate.
19. El color no es el único indicador.
20. Toda información crítica tiene representación textual.

---

<a id="src-strategic-ui-and-player-experience-system--149-errores-que-deben-evitarse"></a>
### 149. Errores que deben evitarse

1. Mostrar todas las variables internas.
2. Usar una pantalla única para todo.
3. Repetir datos en todas las vistas.
4. Mostrar posiciones enemigas exactas.
5. Mostrar consecuencias ocultas.
6. Utilizar colores sin iconos ni texto.
7. Saturar con alertas.
8. Convertir cada demanda en una notificación.
9. Mostrar números sin contexto.
10. Ocultar por qué una acción está bloqueada.
11. Permitir órdenes sin autoridad.
12. Mostrar controles inutilizables.
13. Convertir Helios en interfaz futurista omnisciente.
14. Usar una barra única de apoyo civil.
15. Mostrar relaciones como un número sin explicación.
16. Convertir el archivo en texto interminable.
17. Pedir confirmación para acciones comunes.
18. No advertir puntos de no retorno.
19. Actualizar todos los paneles constantemente.
20. Diseñar únicamente para ratón.
21. Ignorar subtítulos.
22. Mezclar información táctica y estratégica.
23. Mostrar datos reales bajo dificultad alta.
24. Utilizar iconos ambiguos.
25. Hacer que el jugador administre cada camión y soldado.

---

<a id="src-strategic-ui-and-player-experience-system--150-principios-obligatorios"></a>
### 150. Principios obligatorios

1. La interfaz muestra conocimiento, no realidad absoluta.
2. La información se presenta progresivamente.
3. El nivel principal sirve para decidir.
4. El nivel secundario aporta contexto.
5. El nivel avanzado permite auditar.
6. No se duplica información sin propósito.
7. El centro de mando prioriza atención.
8. El mapa utiliza capas.
9. Las fuerzas móviles se muestran con incertidumbre.
10. Los sectores tienen panel contextual.
11. La construcción utiliza prioridades.
12. La logística muestra autonomía y rutas.
13. Los convoyes muestran carga e impacto.
14. Las misiones muestran consecuencias.
15. Las investigaciones muestran evidencias y dudas.
16. Helios muestra supuestos.
17. El gobierno separa autoridad y control.
18. La progresión separa rango, autoridad y confianza.
19. Las capacidades dependen de activos reales.
20. La interfaz explica bloqueos.
21. Los puntos de no retorno son explícitos.
22. Las decisiones quedan registradas.
23. Las consecuencias desconocidas permanecen ocultas.
24. La interfaz táctica es mínima.
25. La interfaz estratégica es profunda.
26. La accesibilidad se diseña desde el inicio.
27. Azul y Rojo comparten estructura y cambian identidad.
28. Stratis modifica la experiencia.
29. El servidor será autoridad futura.
30. Todo panel debe responder una pregunta concreta del jugador.

---

<a id="src-strategic-ui-and-player-experience-system--151-definición-final"></a>
### 151. Definición final

La interfaz de Islas Fracturadas no será un escaparate de todos los sistemas desarrollados.

Será la herramienta que permita al jugador comprender únicamente lo necesario para asumir responsabilidades cada vez mayores.

El jugador no necesitará memorizar:

* todas las reservas;
* todas las rutas;
* todos los niveles;
* todas las relaciones.

La interfaz deberá convertir esos sistemas en preguntas comprensibles:

* ¿defender o retirarse?;
* ¿abastecer el frente o el hospital?;
* ¿creer el informe o verificarlo?;
* ¿entregar la evidencia o conservar una copia?;
* ¿mantener el municipio o imponer control militar?;
* ¿destruir Helios o intentar separarlo de Argos?

El mapa no mostrará dónde está realmente cada enemigo.

Mostrará dónde existen razones suficientes para creer que puede encontrarse.

El panel logístico no mostrará únicamente cantidades.

Mostrará qué operación dejará de ser posible cuando se agoten.

El panel de relaciones no mostrará simplemente quién aprecia al jugador.

Mostrará quién está dispuesto a confiarle una responsabilidad y por qué.

> **Una buena interfaz no elimina la incertidumbre. Permite comprender de dónde proviene y decidir cuánto riesgo aceptar.**

> **El jugador no debe sentirse como un administrador que observa barras. Debe sentirse como un oficial que recibe información incompleta, escucha prioridades incompatibles y decide qué merece atención antes de que el mundo actúe sin él.**

> **La interfaz será el lugar donde todos los sistemas de la campaña dejan de ser datos y se convierten en decisiones.**

<a id="src-strategic-ui-and-player-experience-system--estado-actualizado"></a>
#### Estado actualizado

El [Documento 10/14](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture) fija carpetas, módulos, contratos, eventos, namespaces, inicialización, persistencia, configuración, logging, pruebas, seguridad de red y reglas obligatorias de código.

El [Documento 11/14](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide) fija la validación física de mapas, sectores, rutas, anclajes, zonas y puntos que la interfaz representa.

El [Documento 12/14](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system) fija voces, radio, briefings, subtítulos, documentos, audio, escenas y prioridades narrativas que presenta la interfaz.

El [Documento 13/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system) fija pruebas funcionales, secretas, accesibilidad y rendimiento de interfaz.

El [Documento 14/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan) fija el orden, alcance, entregables y puertas de producción de interfaz. La colección rectora queda completa.
