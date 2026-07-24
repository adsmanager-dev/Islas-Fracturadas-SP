# Jugadores, unidades protagonistas y progresión de mando

> Rangos, miembros, heridas, memoria y sucesión se persisten según [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).

> **Versión:** 1.0  
> **Alcance:** campañas Azul y Roja  
> **Modalidad inicial:** un jugador  
> **Modalidad futura:** cooperativo de un solo bando  
> **Estado:** canon narrativo propuesto, pendiente de adaptación final a las unidades vanilla de Arma 3.  
>
> Se conecta con la [Biblia Narrativa](STORY_BIBLE.md), el [sistema estratégico general](STRATEGIC_CAMPAIGN_SYSTEM.md), la [estructura de actos y misiones](NARRATIVE_ACTS_AND_MISSION_SYSTEM.md), las [fuerzas invasoras](INVADING_FORCES.md) y el [orden de batalla militar](MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md).

## 1. Alcance

Este documento define:

* quién representa al jugador en cada campaña;
* cómo funcionan el modo individual y el futuro cooperativo;
* la unidad protagonista;
* rango, autoridad, confianza e influencia;
* progresión de mando y especializaciones;
* composición inicial de la unidad;
* disponibilidad de las fuerzas expedicionarias;
* comportamiento persistente de los personajes de mando.

Los actores nativos se tratan solamente cuando afectan a la autoridad o las relaciones del jugador. Su definición completa se conserva en [NATIVE_ACTORS_AND_SECTORS.md](NATIVE_ACTORS_AND_SECTORS.md).

## 2. Selección de campaña

Cada partida pertenece por completo a una sola perspectiva.

### Campaña Azul

* Todos los jugadores humanos pertenecen a Azul.
* El mando Azul es aliado y permanece activo.
* Rojo está controlado completamente por IA.
* Verde, FIA, guerrillas y civiles están controlados por IA.
* Solo se accede a información conocida por Azul.
* Las misiones y decisiones responden a su doctrina.

### Campaña Roja

* Todos los jugadores humanos pertenecen a Rojo.
* El mando Rojo es aliado y permanece activo.
* Azul está controlado completamente por IA.
* Verde, FIA, guerrillas y civiles están controlados por IA.
* Solo se accede a información conocida por Rojo.
* Las misiones y decisiones responden a su doctrina.

### Restricción permanente

No habrá jugadores humanos en Azul y Rojo dentro de una misma campaña cooperativa. Las dos fuerzas existen y combaten en la simulación, pero solo una pertenece a los jugadores.

> El modo principal es cooperativo contra una guerra dinámica, no PvP entre Azul y Rojo.

Una modalidad PvP futura no forma parte de la campaña principal ni condiciona su arquitectura inicial.

## 3. Desarrollo por versiones

### Primera versión — Campaña individual

Un jugador selecciona Azul o Rojo, dirige la unidad protagonista, recibe subordinados controlados por IA, responde ante sus comandantes y adquiere progresivamente autoridad operativa.

Nunca controla directamente toda la fuerza expedicionaria.

Aunque la primera versión sea individual, el estado de campaña debe diseñarse para poder sincronizarse más adelante.

### Segunda versión — Campaña cooperativa

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

### Escala cooperativa recomendada

* **1 jugador:** líder con compañeros IA.
* **2–4 jugadores:** equipo táctico reducido.
* **5–8 jugadores:** unidad protagonista completa.

La primera implementación cooperativa se limita a ocho jugadores para conservar cohesión narrativa, claridad de mando, rendimiento e importancia individual. Podrán existir unidades invitadas posteriormente, pero el núcleo narrativo seguirá formado por ocho personajes.

## 4. La protagonista real

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

## 5. Mando único en cooperativo

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

## 6. Dimensiones de la progresión

La progresión no consiste solamente en acumular puntos o recibir un rango.

### Rango formal

Posición reconocida dentro de la fuerza. Determina tratamiento, precedencia, tamaño normal de unidad, acceso a canales y capacidad para emitir ciertas órdenes.

### Autoridad operacional

Responsabilidad temporal sobre una operación o región. Puede superar o quedar por debajo de lo habitual para el rango.

### Confianza del mando

Indica cuánto confían los comandantes principales en la unidad. Afecta:

* calidad de la información;
* libertad para elegir objetivos;
* acceso a operaciones reservadas;
* capacidad para cuestionar órdenes;
* acceso a Helios;
* apoyos disponibles;
* participación política.

### Influencia local

Representa la relación con oficiales nativos, municipios, FIA, guerrillas, técnicos, civiles y otras fuerzas aliadas.

Una unidad puede tener gran confianza militar y poca legitimidad local, o la situación inversa.

## 7. Posición inicial

Ambos protagonistas comienzan como tenientes al mando de unidades de ocho integrantes. Tienen comunicación directa con un superior de operaciones avanzadas, un vehículo inicial y apoyos muy limitados.

### Campaña Azul

**Unidad:** Grupo Operativo AZUR-1  
**Sobrenombre:** Vanguardia  
**Líder:** teniente Adrian Cole  
**Función:** reconocimiento, enlace y asalto expedicionario.

AZUR-1 realiza reconocimiento costero, identificación de objetivos, operaciones de precisión, contacto local, recuperación de información, coordinación aérea limitada y aseguramiento de comunicaciones.

### Campaña Roja

**Unidad:** Grupo Táctico RUBÍ-1  
**Sobrenombre:** Bastión  
**Líder:** teniente Samira Qadir  
**Función:** reconocimiento mecanizado, ruptura y enlace.

RUBÍ-1 realiza reconocimiento blindado, protección de convoyes, enlace con Verde, captura de infraestructura, coordinación de fuego y defensa de puntos estratégicos.

Ambos puestos tienen importancia equivalente, pero doctrinas y recursos diferentes.

## 8. Niveles de mando

### Nivel I — Líder de unidad

Comienza la invasión, controla una escuadra o sección y ejecuta objetivos definidos con recursos limitados.

Puede decidir aproximación táctica, organización, prioridad médica, uso de munición, ruta, tratamiento de prisioneros y respuesta inmediata ante civiles.

No puede decidir ofensivas regionales, reservas, política de ocupación, destino de Helios o alianzas de alto nivel.

### Nivel II — Jefe de destacamento

**Rango aproximado:** capitán o nombramiento equivalente.

Se obtiene después de consolidar la cabeza de playa y demostrar capacidad.

Permite dirigir varias escuadras, asignar equipos, solicitar transporte, pedir mortero o reconocimiento, recomendar construcciones, seleccionar operaciones y tratar con autoridades locales.

### Nivel III — Comandante de grupo operativo

**Rango aproximado:** capitán superior o mayor interino.

La unidad recibe una zona de responsabilidad.

Permite coordinar varias unidades, priorizar defensa, logística o inteligencia, solicitar vehículos especializados, ordenar reconocimientos, apoyar sectores, recomendar ataques o retiradas, negociar localmente y decidir el tratamiento de ciertos nodos de Helios.

### Nivel IV — Comandante operacional regional

**Rango aproximado:** mayor.

Se obtiene por experiencia, confianza o necesidad.

Permite influir en la planificación regional, controlar una reserva limitada, asignar fuerzas a sectores, aprobar operaciones especiales, gestionar relaciones nativas, cuestionar recomendaciones de Helios, recibir información clasificada e intervenir ante los comandantes.

Todavía responde ante Ward y Hale en Azul o Navid y Vahid en Rojo.

### Nivel V — Representante de mando de campaña

No convierte al jugador en comandante absoluto.

Permite participar en el desenlace, proponer el objetivo de la ofensiva final, decidir el uso de nodos principales, influir en relaciones políticas, intervenir en el destino de Stratis y aceptar, rechazar o modificar recomendaciones de Helios.

La autoridad real depende también de reputación, éxitos, bajas, relaciones, información recuperada, obediencia, desobediencia y estado expedicionario.

La promoción máxima recomendada durante una campaña es mayor. El poder final procede principalmente de la autoridad operacional, no de convertir al jugador en general.

## 9. Ganancia y pérdida de autoridad

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

## 10. Especializaciones

### Mando

Coordinación de subordinados, recuperación de moral, transmisión, acceso a decisiones y control de unidades adicionales.

### Reconocimiento e inteligencia

Identificación de amenazas, calidad del mapa, análisis de rutas, detección de manipulación y uso de Helios.

### Operaciones terrestres

Infantería, vehículos, asalto, defensa y armas combinadas.

### Logística e ingeniería

Reparación, recuperación de vehículos, fortificación, suministros, infraestructura y consolidación.

### Medicina y apoyo civil

Tratamiento, evacuación, supervivencia, relaciones comunitarias, desastres y legitimidad.

### Comunicaciones y apoyo de fuego

Coordinación aérea, artillería, guerra electrónica, repetidores, enlace y resistencia a interferencias.

En cooperativo, los jugadores distribuyen estas funciones. En solitario, especialistas IA cubren los puestos no controlados.

## 11. Composición inicial de la unidad

Cada campaña comienza con ocho personajes, un vehículo y suministros para una operación corta. Pueden resultar heridos, morir, ser sustituidos o abandonar la unidad.

### AZUR-1 Vanguardia

> **Lema:** Entrar primero. Ver con claridad. Dejar una salida.

AZUR-1 es una sección expedicionaria flexible de reconocimiento, enlace y asalto. No es una fuerza especial completamente independiente.

#### AZUR-1-1 — Teniente Adrian Cole

Líder y comandante principal. Especialista en mando, reconocimiento y coordinación de apoyos. Su personalidad se define mediante las decisiones del jugador y puede evolucionar hacia una posición legalista, agresiva, protectora, estratégica o investigadora de Helios.

Los diálogos se refieren preferentemente a su rango, cargo o indicativo para permitir una sustitución futura del personaje.

#### AZUR-1-2 — Sargento Maya Torres

Segunda al mando y especialista en asalto. Es práctica, directa y protectora. Rechaza sacrificios inútiles, abandono de heridos, órdenes confusas y el uso político de la unidad. Puede asumir el mando.

#### AZUR-1-3 — Sargento Elias Okafor

Sanitario principal. Es disciplinado y humanitario; atiende a civiles, aliados y prisioneros. Mejora supervivencia, recuperación y relaciones locales, y puede enfrentarse moralmente a Hale.

#### AZUR-1-4 — Cabo Jonah Reed

Operador de comunicaciones, enlace aéreo y coordinación de fuego. Confía inicialmente en la tecnología, pero detecta frecuencias duplicadas, marcas temporales imposibles y recomendaciones de origen dudoso.

Es el intérprete principal de Azul para tiempos, firmas, rutas y transmisiones dentro de la [matriz investigativa](INVESTIGATION_REVELATION_MATRIX.md).

#### AZUR-1-5 — Cabo Lucas Varga

Ingeniero de combate, experto en explosivos, reparación y desactivación. Trabajó en infraestructura vinculada a contratistas de la Coalición y reconoce componentes de Helios.

#### AZUR-1-6 — Cabo Daniel Ruiz

Especialista antitanque y defensa de posición. Es agresivo en combate, pero quiere derrotar a Rojo y retirarse. Rechaza que la campaña se convierta en una ocupación permanente.

#### AZUR-1-7 — Especialista Noah Kim

Explorador, tirador designado y operador de drones. Compara predicciones de Helios con resultados y puede encontrar patrones de manipulación.

#### AZUR-1-8 — Soldado primero Gabriel Bennett

Fusilero automático y conductor. Es el miembro más joven y comienza como idealista. Puede conservar su fe, volverse cínico, radicalizarse o rechazar la ocupación.

#### Equipo inicial

* un Hunter sin armamento pesado o equivalente;
* un dron ligero;
* equipo médico limitado;
* un lanzador antitanque;
* explosivos y herramientas;
* radio de enlace naval;
* reconocimiento aéreo limitado.

El material puede perderse durante el desembarco.

### RUBÍ-1 Bastión

> **Lema:** Resistir el golpe. Romper la línea. Conservar el terreno.

RUBÍ-1 es una sección de reconocimiento mecanizado y enlace preparada para encabezar el desembarco, asegurar carreteras, proteger convoyes, romper posiciones y conectar infraestructura.

#### RUBÍ-1-1 — Teniente Samira Qadir

Líder y comandante principal. Especialista en reconocimiento mecanizado y coordinación terrestre. Sus decisiones pueden orientarla hacia posiciones aliancistas, dominadoras, protectoras de infraestructura, pragmáticas o investigadoras.

Los diálogos se refieren preferentemente a su rango, cargo o indicativo.

#### RUBÍ-1-2 — Sargento mayor Arman Darzi

Segundo al mando e infante mecanizado. Es veterano, disciplinado y leal a sus soldados. Desconfía de los políticos de Altis, de la dependencia excesiva de Verde y de abandonar vehículos o heridos.

#### RUBÍ-1-3 — Sargento Idris Nasser

Sanitario. Cree que Rojo está obligado a proteger a la población porque afirma actuar como aliado. Puede enfrentarse moralmente a Vahid ante el uso excesivo de fuego.

#### RUBÍ-1-4 — Cabo Nabil Farouk

Operador de comunicaciones, guerra electrónica y enlace con Helios. Conoce protocolos Rojos y descubre códigos modificados, accesos sin autorización y datos procedentes de Stratis.

Es el intérprete principal de Rojo para códigos, autenticaciones y señales dentro de la [matriz investigativa](INVESTIGATION_REVELATION_MATRIX.md).

#### RUBÍ-1-5 — Cabo Viktor Sokolov

Ingeniero de reparación, minas y fortificación. Valora la infraestructura y prefiere recuperar vehículos y nodos antes que destruirlos.

#### RUBÍ-1-6 — Cabo Rashan Kerim

Especialista antitanque. Perdió familiares en una intervención extranjera y cree que Azul usa la negociación para ganar tiempo. Puede radicalizarse tras grandes pérdidas.

#### RUBÍ-1-7 — Especialista Levan Orlov

Explorador y tirador designado. Mantiene contacto con soldados Verdes y detecta que recibieron órdenes incompatibles.

#### RUBÍ-1-8 — Soldado primero Yusef Baran

Fusilero automático y conductor. Cree inicialmente en la legalidad del acuerdo. Puede conservar esa fe o concluir que Rojo se convirtió en aquello que prometió impedir.

#### Equipo inicial

* un Ifrit armado o equivalente;
* equipo de comunicaciones;
* un lanzador antitanque;
* minas y herramientas;
* equipo médico;
* reconocimiento limitado;
* enlace Verde que puede no presentarse;
* autorización restringida de fuego indirecto.

La primera emboscada Verde puede separar a RUBÍ-1 de su columna.

### Crecimiento de las unidades

| Etapa | AZUR-1 | RUBÍ-1 |
|---|---|---|
| Inicial | 8 integrantes y un Hunter | 8 integrantes y un Ifrit |
| Destacamento | 16–22 efectivos, segunda escuadra, transporte, ingenieros y sanitario | 18–24 efectivos, segunda escuadra, transporte, ingenieros y enlace Verde |
| Grupo operativo | 35–50 efectivos, tercera escuadra, blindado, reconocimiento, mortero y logística | 40–55 efectivos, Marid, tercera escuadra, mortero, defensa antitanque y reconocimiento |
| Mando regional | 80–140 efectivos, secciones IA, especialistas, transporte aéreo y equipo Helios | 90–160 efectivos, secciones mecanizadas, reserva blindada, artillería, defensa aérea y asesores |

El jugador no dirige individualmente a todos los efectivos. Los líderes IA ejecutan órdenes generales de defensa, avance, patrulla, reconocimiento, escolta, apoyo o retirada.

## 12. Fuerzas expedicionarias limitadas

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

## 13. Fuerza de Tarea Tridente

Es la agrupación expedicionaria Azul. Embarca aproximadamente entre 650 y 750 militares y especialistas, aunque no todos aparecen físicamente a la vez.

### Composición

* un mando expedicionario;
* un batallón de infantería;
* una compañía de reconocimiento y operaciones especiales;
* un destacamento de aviación;
* una compañía de ingeniería y logística;
* una unidad médica;
* un Grupo de Enlace Helios;
* una Oficina de Estabilización Civil.

### Medios aproximados

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

## 14. Grupo de Estabilización Aurora

Es la agrupación expedicionaria Roja. Embarca aproximadamente entre 750 y 850 militares, técnicos y asesores.

### Composición

* un mando expedicionario;
* un batallón mecanizado;
* una compañía de reconocimiento;
* una agrupación de artillería y defensa aérea;
* una compañía de ingeniería;
* una unidad logística;
* una Misión de Enlace con Altis;
* una Dirección Técnica Helios.

### Medios aproximados

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

## 15. Disponibilidad de la fuerza

Los niveles pueden avanzar o retroceder.

### Nivel 0 — En tránsito

Sin territorio, fuerzas embarcadas, inteligencia previa, vulnerabilidad naval e imposibilidad de reemplazar pérdidas.

### Nivel 1 — Primera oleada

Unidad protagonista desplegada, recursos mínimos, apoyo condicionado y defensa costera activa.

Azul comienza en **Aproximación armada** y Rojo en **Despliegue de estabilización**.

### Nivel 2 — Cabeza de playa

Requiere puesto de mando, zona logística, perímetro, conexión naval y guarnición. Desbloquea segunda escuadra, vehículos, ingeniería y evacuación regular.

### Nivel 3 — Fuerza establecida

Requiere sectores conectados, ruta logística, depósito, comunicaciones y defensa antiaérea. Desbloquea refuerzos, apoyo especializado, operaciones regionales y ascenso.

### Nivel 4 — Fuerza de teatro

Requiere puerto o aeródromo, infraestructura estable, varios frentes y reserva operacional. Desbloquea blindados pesados, apoyo aéreo superior, artillería, grandes ofensivas y mando regional.

### Nivel 5 — Dominio o desgaste

En **dominio**, la fuerza puede preparar la operación sobre Stratis.

En **desgaste**, pierde reservas, apoyo político, convoyes, capacidad aérea y sectores. Puede retroceder de nivel o iniciar una retirada.

## 16. IA persistente de personajes

Los miembros de AZUR-1 y RUBÍ-1 no comparten una barra única de aprobación. Conservan lealtades, agravios, confianza en el jugador, confianza en el mando, preocupación civil y conocimiento de evidencias. Pueden obedecer sin confiar, discutir sin desertar, ocultar una prueba, informar al mando o asumir el liderazgo.

Cole y Qadir son moldeados por el jugador, pero los demás miembros mantienen límites propios. Torres y Darzi son los sucesores naturales iniciales. La red completa, incluidos detonantes de ruptura y memoria, se define en [CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md](CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md).

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

## 17. Personajes clave de Azul

### Contralmirante Elena Ward

Comandante general, legalista prudente y responsable de flota, aviación y estrategia. Busca impedir el control Rojo de Helios sin convertir Altis en una ocupación permanente.

Su IA considera confianza en el jugador, bajas civiles, pérdidas navales, progreso Rojo, estabilidad de la playa, presión política y confianza en Helios.

Puede mantenerse contenida, endurecerse tras grandes pérdidas, desconfiar del sistema o aceptar conservarlo bajo control Azul.

### Coronel Marcus Hale

Comandante terrestre e intervencionista. Busca derrotar a Verde y Rojo antes de que consoliden sus líneas.

Su IA considera velocidad de avance, sectores perdidos, oportunidades, obediencia, bajas, resistencia civil y relación con Ward.

Apoya resultados rápidos y riesgos calculados; puede enfrentarse al jugador por priorizar civiles, rechazar ofensivas, negociar sin autorización o revelar operaciones.

### Mayor Thomas Rourke

Superior directo de AZUR-1 y coordinador de operaciones avanzadas. Es veterano y pragmático. Asigna misiones, evalúa el desempeño, recomienda ascensos y transmite conflictos internos.

Puede convertirse en mentor, rival o adversario institucional.

### Doctora Miriam Kessler

Directora técnica del Grupo de Enlace Helios. Trabajó en módulos civiles y conoce protocolos, arquitectura, contratistas, firmas digitales y documentación parcial de Argos.

No se confirma inicialmente si investiga la verdad, protege a su empresa, trabaja para inteligencia, posee un acceso Argos o fue utilizada sin comprenderlo.

### Directora Sofia Laurent

Responsable de estabilización civil, municipios, ayuda y administración. Defiende que una victoria sin legitimidad política es una derrota.

Proporciona contactos, evacuaciones, negociaciones y recursos. Puede denunciar o abandonar la misión si Azul se convierte en ocupante.

### Comandante Naomi Reyes

Comandante aérea Azul. Administra transporte, vigilancia y apoyo limitado según defensa antiaérea, inteligencia, evacuaciones, combustible, pérdidas y prioridades de Ward.

Puede cancelar una misión si considera poco fiable la información de Helios.

## 18. Personajes clave de Rojo

### General Darius Navid

Comandante general y aliancista estratégico. Busca derrotar a Azul conservando gobierno, Verde e infraestructura.

Su IA considera estabilidad gubernamental, lealtad Verde, logística, avance Azul, bajas civiles, confianza en el jugador y control de Helios.

Puede mantenerse aliancista, asumir funciones gubernamentales, limitar accesos técnicos o conservar territorio perdiendo legitimidad.

### Coronel Soraya Vahid

Comandante ofensiva y dominadora. Busca golpear a Azul antes de que estabilice el frente.

Su IA considera oportunidades, resistencia Verde, velocidad del jugador, bajas, blindados, relación con Navid e información de Helios.

Apoya ruptura de líneas, protección de columnas y presión continua; puede enfrentarse al jugador por negociar, evitar ataques, proteger Verdes desobedientes o cuestionar información.

### Mayor Samir Khadem

Superior directo de RUBÍ-1 y coordinador de la primera agrupación mecanizada. Equilibra las exigencias de Navid y Vahid.

Evalúa disciplina, conservación de recursos, cumplimiento, iniciativa y cooperación con Verde. Puede proteger al jugador o ejecutar estrictamente las órdenes de Vahid.

### Doctor Kamran Sadeq

Director de la Dirección Técnica Helios. Conoce contratos, arquitectura, códigos, asesores y módulos militares.

Puede intentar recuperar el proyecto, evitar su destrucción, ocultar cláusulas, descubrir Argos o completar la validación. Su prioridad es conservar Helios.

### Enviado Nadir Khoury

Representante político ante el Gobierno de Altis. Controla negociaciones, declaraciones, acuerdos, nombramientos y reconocimiento de autoridades.

Busca que Altis parezca gobernarse a sí misma mientras permanece alineada con Rojo. Puede actuar como mediador, manipulador o arquitecto de un gobierno subordinado.

### Coronel Laleh Arman

Comandante de aviación y defensa aérea Roja. Administra helicópteros, drones, defensa, reconocimiento e interdicción.

Es más prudente que Vahid y puede negar apoyo para no dejar expuesta la flota o una instalación de Helios.

## 19. Diferencias entre las unidades

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

## 20. Principio narrativo

AZUR-1 y RUBÍ-1 no son importantes porque sean invencibles. Se encuentran repetidamente donde las predicciones de Helios dejan de cumplirse.

Sus integrantes sobreviven cuando deberían fracasar, rechazan recomendaciones, forman alianzas inesperadas, descubren información y cambian el comportamiento de sus comandantes.

Helios necesita observar la variable que todavía no puede controlar completamente:

> La decisión humana tomada después de descubrir que la información recibida puede haber sido diseñada para influirla.

Los nombres, rangos, integrantes, vehículos y mandos quedan fijados como canon propuesto. Su adaptación exacta a clases, equipamiento y disponibilidad vanilla de Arma 3 se realizará durante el diseño técnico.
