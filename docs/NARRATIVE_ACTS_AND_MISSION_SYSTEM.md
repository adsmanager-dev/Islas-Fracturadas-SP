# Estructura narrativa, actos y sistema de misiones

> La persistencia entre Altis, Stratis y el epílogo se rige por [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).
>
> **Jerarquía actual:** este documento conserva el fundamento narrativo y técnico. La secuencia jugable, las puertas, los IDs y el Acto I detallado se rigen por [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](BLUE_RED_CAMPAIGN_ARCHITECTURE.md).

> **Versión:** 1.0  
> **Modalidad inicial:** individual  
> **Modalidad futura:** cooperativo de un solo bando  
> **Terrenos:** Altis y Stratis  
> **Bandos jugables:** Azul o Rojo, nunca simultáneamente  
> **Base inicial:** contenido vanilla de Arma 3  
> **Objetivo:** conectar la guerra dinámica con misiones narrativas sostenibles dentro de las capacidades reales del motor  
>
> Implementa la historia de [STORY_BIBLE.md](STORY_BIBLE.md) dentro del [sistema estratégico general](STRATEGIC_CAMPAIGN_SYSTEM.md). La distribución de evidencias, techos de conocimiento y preparación de Stratis se define en [INVESTIGATION_REVELATION_MATRIX.md](INVESTIGATION_REVELATION_MATRIX.md).

## 1. Decisión técnica principal

La guerra principal se ejecuta como un escenario persistente en Altis. Los actos avanzan dentro de ese escenario mediante tareas y operaciones dinámicas.

Stratis es una misión separada para el desenlace y recibe únicamente un paquete de estado.

La campaña no será una colección de misiones que reinician el mundo ni una simulación que mantiene físicamente toda Altis.

### Escenario 1 — Introducción

Altis o secuencia naval simplificada. Presenta bando, mandos, versión oficial, unidad protagonista, aproximación y primera señal.

Puede integrarse en la Guerra de Altis.

### Escenario 2 — Guerra de Altis

Núcleo persistente con sectores, bases, recursos, relaciones, población, mandos, misiones, progresión, nodos y política.

### Escenario 3 — Operación Stratis

Misión independiente desbloqueada por condiciones estratégicas.

Recibe:

* bando;
* supervivientes;
* relaciones principales;
* información descubierta;
* recursos asignados;
* control de Helios;
* decisiones previas.

### Escenario 4 — Epílogo

Misión breve, informe interactivo o secuencia que muestra consecuencias militares, políticas, civiles y estratégicas.

### Empaquetado

Un PBO de misión normal contiene una única misión. Para agrupar Altis, Stratis y epílogo en un PBO se requiere formato de addon y definición mediante `CfgMissions`. También pueden distribuirse como campaña o misiones separadas.

La estructura lógica no depende de decidir ahora el empaquetado final.

## 2. Capacidades y límites de Arma 3

### El motor representa bien

Infantería, escuadras, vehículos, armas combinadas, patrullas, emboscadas, convoyes, asaltos, defensa, reconocimiento, infiltración, evacuaciones, apoyos, tareas, 3DEN y eventos SQF.

### Se representará de forma abstracta

* miles de soldados;
* toda la población;
* muchas organizaciones físicamente independientes;
* política completamente emergente;
* economía nacional detallada;
* conversaciones generativas;
* mandos que comprendan el lore por sí solos.

Se usarán estados, valores sectoriales, decisiones ponderadas, operaciones prefabricadas, diálogos escritos, personajes con variables y materialización selectiva.

Helios, Argos y los comandantes son sistemas de reglas, estados, prioridades y eventos, no inteligencias conscientes.

## 3. Lados y subfacciones

Arma 3 trabaja principalmente con West, East, Independent y Civilian. `setFriend` establece relaciones entre lados completos y cambiarlo durante una misión puede causar conductas inesperadas en grupos que ya conocen al antiguo aliado.

### Campaña Azul

* **West:** Azul y aliados tácticos integrados.
* **East:** Rojo.
* **Independent:** Verde y nativos hostiles activos.
* **Civilian:** no combatientes.

### Campaña Roja

* **East:** Rojo y aliados tácticos integrados.
* **West:** Azul.
* **Independent:** Verde y nativos hostiles activos.
* **Civilian:** no combatientes.

### Identidades virtuales

* `verde_gobierno`;
* `verde_soberanista`;
* `verde_reformista`;
* `fia_brigadas`;
* `fia_civica`;
* `guerrilla_local`;
* `frente_negro`;
* `milicia_municipal`.

Controlan objetivos, relaciones, diálogos, refuerzos, estrategia y reacciones sin exigir un lado propio.

Un aliado nativo puede integrarse temporalmente al lado del jugador, conservar identidad política y retirarse o virtualizarse antes de volver como hostil.

No se cambiarán relaciones globales de lado durante combates activos.

Una zona táctica contendrá normalmente:

* bando del jugador;
* enemigo principal;
* civiles;
* un actor nativo adicional.

Las demás guerras políticas continúan estratégicamente.

## 4. Simulación por niveles

### Táctico

Alrededor del jugador: unidades físicas, vehículos, civiles relevantes, proyectiles, daños, IA completa y composiciones.

### Operacional

Sectores vecinos: grupos abstractos, rutas, destinos, tiempos, combate y refuerzos potenciales.

### Estratégico

Sectores lejanos: fuerza, moral, suministros, propietario, amenaza, insurgencia y resolución calculada.

### Materialización

Al acercarse:

1. consultar sector;
2. seleccionar composiciones;
3. crear unidades y vehículos;
4. aplicar daños, experiencia y recursos;
5. activar objetivos.

Al alejarse:

1. guardar estado;
2. eliminar entidades no persistentes;
3. conservar resolución abstracta;
4. volver al nivel operacional.

La simulación dinámica oficial solo afecta entidades y grupos configurados para usarla. Complementa, pero no sustituye, la virtualización propia.

## 5. Presupuesto de combate

No habrá cientos de unidades físicas alrededor del jugador.

Una ofensiva que representa centenares de combatientes concentra la experiencia jugable en un objetivo decisivo, ruptura, convoy, flanco, nodo o puesto de mando.

El resto continúa en simulación operacional.

## 6. Tipos de misión

### Narrativas principales

Personajes, diálogos, lugares preparados, revelaciones, decisiones y consecuencias. Un fracaso puede transformar la campaña.

### Estratégicas

Ataque de sector, refuerzo, carretera, puerto, artillería o suministros según el estado.

### Reactivas

Contraataque, emboscada, piloto derribado, mando aislado, levantamiento, sabotaje u hospital atacado. Expiran y producen consecuencias si se ignoran.

### Locales

Municipios, civiles, FIA, Verde o técnicos: evacuaciones, medicinas, desaparecidos, energía y prisioneros.

### Inteligencia

Observación, infiltración, documentos, intercepción, seguimiento, identificación de Argos y comparación de transmisiones.

### Mando

Selección de fuerzas, ataques secundarios, reservas, rutas y prioridades mediante órdenes sencillas de mapa y líderes IA; no una interfaz RTS completa.

## 7. Estados de resolución

* **Éxito completo:** objetivo y condiciones complementarias.
* **Éxito parcial:** objetivo central con pérdidas.
* **Fracaso controlado:** campaña continúa.
* **Desastre:** pérdidas estratégicas importantes.
* **Ignorada:** expira sin intervención.
* **Resultado oculto:** éxito aparente con beneficio para Helios o Argos.

Las misiones investigativas separan el resultado militar del informativo. Es posible ganar el combate y perder, dañar o entregar la evidencia. Cada prueba conserva estado, autenticación, interpretación y destino.

## 8. Personalización contextual

Las misiones se seleccionan mediante:

* bando y acto;
* rango;
* especialistas vivos;
* vehículos;
* relaciones;
* sectores;
* estado civil;
* fuerza enemiga;
* inteligencia;
* confianza en Helios;
* personajes;
* decisiones previas.

La muerte de un ingeniero obliga a buscar técnicos; alta confianza civil abre rutas; baja confianza produce datos falsos; destruir nodos reduce precisión y disponibilidad de misiones.

## 9. Prólogo — La señal

### Objetivo

Presentar crisis, bando, unidad, comandantes, aproximación y Helios.

El jugador comienza dentro de su fuerza naval. No existe un civil jugable fuera de su bando.

Stratis se presenta mediante noticias, registros, imágenes, comunicaciones, briefing o cinemática.

### Evento

Una transmisión no autorizada aparentemente procedente de Stratis entrega ruta, frecuencia, advertencia e información costera.

El mando puede usarla, considerarla una trampa o verificarla. La elección modifica el desembarco, no bloquea la campaña.

La transmisión forma parte de las anomalías PHAROS-LÁZARO dejadas por Damaris durante PROTOCOLO UMBRAL. Azul puede recibir la firma antigua y «RUTA SEGURA: 147»; Rojo recibe códigos Verdes incompatibles. El jugador desconoce todavía ese origen.

## 10. Acto I — Dos mareas

Verde controla Altis; Azul y Rojo desembarcan; Helios funciona parcialmente.

### Azul

* **A1 — Costa ciega:** AZUR-1 reconoce defensas y civiles; la señal puede ser correcta, incompleta o atravesar una comunidad.
* **A2 — Línea de arena:** neutralizar defensas, proteger ingenieros y abrir logística.
* **A3 — La primera noche:** priorizar cuartel, heridos, depósito, repetidor o evacuación.

### Rojo

* **R1 — Asterión:** RUBÍ-1 busca el enlace Verde y encuentra códigos rechazados y órdenes incompatibles.
* **R2 — Bienvenida rota:** sobrevivir a fuego Verde, identificar atacantes y recuperar comunicaciones.
* **R3 — Bastión oriental:** asegurar carretera, descarga, perímetro y combustible.

### Decisión

Perseguir a Verde, consolidar, rescatar, o capturar el primer nodo.

Desbloquea sector inicial, cuartel, economía, operaciones y rango.

## 11. Acto II — Los ojos de la isla

Introduce información, acceso digital, técnicos y relaciones.

### Azul

* **A4 — Señal blanca:** capturar un repetidor intacto sin poseer sus códigos.
* **A5 — La ventana de Kavala:** acceso local a cambio de civiles y detenidos.
* **A6 — El informe imposible:** Reed y Kessler detectan un origen común con conclusiones opuestas.

### Rojo

* **R4 — Códigos muertos:** capturar técnicos vivos cuando fallan los protocolos.
* **R5 — Camino de Molos:** proteger un convoy técnico bajo disputa Verde.
* **R6 — El aliado desconocido:** una guarnición coopera y otra intenta detenerla.

### Decisión

Conectar, aislar, copiar, transferir, desmilitarizar o preservar funciones civiles del primer nodo.

## 12. Acto III — Tierra prestada

Azul y Rojo se aproximan, Verde pierde sectores, los convoyes limitan la expansión y surgen guerrillas.

### Azul

* **A7 — Viento cruzado:** emboscar, seguir o utilizar una columna Roja.
* **A8 — Cruce sin dueño:** combate de tres fuerzas por un cruce.
* **A9 — La distancia de Hale:** explotar una ruptura o contener la sobreextensión.

### Rojo

* **R7 — Corredor de hierro:** proteger logística contra varios actores.
* **R8 — Ruta de ceniza:** recuperar vehículos y fuerzas aisladas.
* **R9 — La presión de Vahid:** atacar o conservar depósitos y reserva.

La elección altera nivel de flota, reservas, confianza y frente.

## 13. Acto IV — Las ciudades recuerdan

Introduce desplazados, hospitales, huelgas, insurgencia y legitimidad urbana.

### Azul

* **A10 — Corredor abierto:** evacuación contra necesidad ofensiva.
* **A11 — El precio de la alcaldesa:** cooperación de Drakos bajo límites.
* **A12 — Precisión:** objetivo urbano señalado por una fuente incierta.

### Rojo

* **R10 — Orden en la oscuridad:** energía y seguridad bajo clandestinidad.
* **R11 — Poder para la ciudad:** energía compartida entre hospitales, radares y Helios.
* **R12 — Estabilidad:** sustitución, negociación o detenciones.

Asalto, fuego pesado, bloqueo, negociación, retirada o evacuación modifican apoyo, radicalización, producción e insurgencia.

## 14. Acto V — El ejército dividido

Verde se divide entre Gobierno, soberanistas, reformistas, aliados Rojos y aislados.

### Azul

* **A13 — El mapa del general:** reunión con Varos o Koronis.
* **A14 — Bandera rota:** desertores exigen armas y autonomía.
* **A15 — El enemigo de mi enemigo:** Daskal ofrece inteligencia contra Rojo.

### Rojo

* **R13 — Prueba de alianza:** cooperación Verde con mando propio.
* **R14 — La sombra de Asterión:** nueva versión del protocolo.
* **R15 — El general desobediente:** desarme que puede causar rebelión.

Apoyar un bloque o ninguno determina auxiliares, enemigos, legitimidad, Gobierno y accesos.

## 15. Acto VI — La voz de Stratis

La investigación conecta accesos Argos, operadores oficialmente muertos, ayudas familiares, cargas destinadas a S-26 y recomendaciones paralelas.

### Operaciones variables

* **El técnico escondido:** buscar a Lidia Serafim o a un operador registrado como fallecido.
* **Firmas muertas:** verificar actualizaciones firmadas por Vardis o Arendt después del Atentado de Helios-0.
* **Los salarios:** investigar pagos, medicamentos y mensajes destinados a familias de desaparecidos.
* **Carga meteorológica:** seguir un manifiesto o convoy con refrigeración para servidores destinado a S-26.
* **Eco falso:** obedecer, verificar, ignorar o usar una recomendación demasiado favorable.
* **Los horarios:** comparar transmisiones Azul, Roja y Verde con reenvíos que apuntan a Stratis.
* **Archivo fragmentado:** obtener evidencia distribuida entre nodo, funcionario, contratista, convoy y servidor.
* **La advertencia que nunca llegó:** recuperar el mensaje diplomático original de Ward.
* **La cláusula ausente:** recuperar la versión limitada de Asterión.
* **Noventa segundos:** reconstruir la transmisión de Petrou anterior a Hora H.

Entregar, ocultar, compartir, publicar o reservar pruebas afecta mando, testigos, Argos y finales.

La ubicación narrativa de cada evidencia se desarrollará desde la [cronología de las últimas 72 horas](LAST_72_HOURS_CHRONOLOGY.md).

Los identificadores, rutas redundantes, intérpretes y consecuencias se mantienen en [INVESTIGATION_REVELATION_MATRIX.md](INVESTIGATION_REVELATION_MATRIX.md).

## 16. Acto VII — La guerra de los nodos

Una fuerza se aproxima al dominio y Helios aumenta su intervención.

### Azul — Operación Tridente

Aeropuerto, puerto, nodo, electricidad o corredor oriental. Ward prioriza control, Hale destrucción, Kessler datos y Laurent población.

### Rojo — Operación Aurora

Gobierno, corredores, expulsión Azul, nodos o acceso marítimo. Navid prioriza continuidad, Vahid ofensiva, Sadeq Helios y Khoury legalidad.

### Operaciones dinámicas

Defensa de nodos, convoy de claves, central, técnicos, comunicaciones, rebelión Verde, levantamiento FIA, ofensiva rival y alerta falsa.

Capturar, reparar, integrar, aislar, destruir o transferir nodos determina inteligencia, civiles, Stratis, rival y Helios.

## 17. Acto VIII — Regreso a Stratis

### Requisitos

Acceso marítimo o aéreo, información, fuerza, técnico o códigos y progresión adecuada. No exige controlar toda Altis.

La preparación se clasifica de S0 —asalto ciego— a S4 —verdad comparada—. Un nivel mayor reduce resistencia evitable, conserva archivos, permite distinguir Meridian de Verde y amplía las opciones relacionadas con PHAROS, Argos y Vardis.

### Transferencia

Unidad, personajes, apoyo, relaciones, estado técnico, documentos, decisiones de nodos y conocimiento de Argos.

### Fases

1. Aproximación por desembarco, infiltración, aire o cooperación.
2. Guarnición exterior: negociación o combate con Verde, Meridian y fuerzas divididas.
3. Superficie: puerto, radar, aeródromo, defensas y generadores.
4. PHAROS: operadores fantasma, retenidos, familias, archivos y pruebas del traslado.
5. Núcleo Argos: contratos, protocolos, comparación de campañas y validación.
6. Vardis: presencia no confirmada en una campaña y encuentro integral al completar ambas.

### Decisiones

Activar, destruir, eliminar accesos, entregar localmente, publicar, compartir, desconectar o permitir continuidad. La variante integral añade capturar, juzgar, utilizar, exponer o permitir la fuga de Vardis.

Las opciones dependen de técnicos, evidencia, nodos, relaciones, integridad y decisiones anteriores.

## 18. Acto IX — Lo que queda

Calcula:

* vencedor, retirada o resistencia;
* Gobierno, protectorado, alianza o fragmentación;
* servicios, desplazados, radicalización y reconstrucción;
* destino de Helios;
* exposición o supervivencia de Argos.

## 19. Plantillas de misión

Cada plantilla define:

* identificador;
* acto y familia;
* región y bando;
* personajes;
* condiciones;
* objetivos y variantes;
* caducidad;
* consecuencias;
* opciones de Helios;
* sustituciones.

Una plantilla de convoy define carga, origen, destino, amenazas, escolta, importancia y consecuencias; el sistema elige ubicaciones válidas.

Este documento conserva el contrato narrativo. La generación causal, puntuación de candidatos, transformación, memoria de contenido y resolución fuera de pantalla se rigen por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md).

### Familias

Las 16 familias canónicas se enumeran en el Documento 3/14; esta lista abreviada conserva únicamente las categorías necesarias para describir los actos.

## 20. Composiciones 3DEN

Las bases y objetivos se construyen mediante bibliotecas validadas, no colocando objetos aleatoriamente.

Categorías: playa, carretera, urbano, industrial, montaña, puerto, aeródromo, radar, campamento, puesto y base regional.

Cada composición posee bando, orientación, nivel, daño, terreno y dirección del frente.

## 21. Tareas

Se utilizará el Task Framework oficial con tarea principal, subtareas, objetivos opcionales, estados parciales y destino actualizado.

En multijugador, creación y actualización se inicializan desde un punto central, preferiblemente el servidor, para sincronizar estados.

## 22. Persistencia

### Individual

`profileNamespace` almacena variables del perfil y `saveProfileNamespace` fuerza su escritura.

Se guardan acto, sectores, recursos, personajes, relaciones, unidades y vehículos persistentes, decisiones, documentos, estados de evidencia, conclusiones, testigos, entregas, Helios y misiones activas.

No se guardan referencias vivas a objetos, proyectiles, cadáveres irrelevantes, grupos temporales, efectos o rutas tácticas. Se guardan identificadores y estados.

### Cooperativo

El servidor es la autoridad del mundo. Los perfiles individuales no lo son.

## 23. Preparación multijugador

### Servidor

Campaña, sectores, recursos, IA estratégica, generación, resultados y persistencia.

### Cliente

Interfaz, cámara, sonido local, acciones, presentación de tareas y efectos.

La arquitectura debe considerar localidad, efectos locales/globales y Join in Progress desde el inicio.

Usará variables públicas controladas, funciones autorizadas, `remoteExec` y sincronización al entrar.

## 24. Eventos y memoria

Los Event Handlers registran muertes, cambios de grupo, vehículos y waypoints sin sondear continuamente todo el mundo.

Los eventos importantes —personaje muerto, vehículo destruido, civil herido, rendición, captura, convoy, nodo, desobediencia o prisionero— actualizan reputación, relaciones, cronología, mandos, finales y misiones futuras.

## 25. Arquitectura recomendada

```text
IslasFracturadas.Altis/
│
├── description.ext
├── init.sqf
├── initServer.sqf
├── initPlayerLocal.sqf
├── mission.sqm
│
├── config/
│   ├── campaign.hpp
│   ├── factions.hpp
│   ├── characters.hpp
│   ├── sectors.hpp
│   ├── missionTemplates.hpp
│   └── compositions.hpp
│
├── functions/
│   ├── core/
│   ├── campaign/
│   ├── strategy/
│   ├── sectors/
│   ├── logistics/
│   ├── missions/
│   ├── aiCommand/
│   ├── helios/
│   ├── diplomacy/
│   ├── civilians/
│   ├── persistence/
│   ├── networking/
│   └── ui/
│
├── data/
│   ├── sectors/
│   ├── characters/
│   ├── dialogue/
│   ├── missions/
│   └── endings/
│
├── compositions/
├── scripts/
├── sounds/
├── music/
└── ui/
```

Stratis utilizará una misión hermana con un contrato de transferencia de estado compartido.

## 26. IA de comandantes

Cada mando tiene objetivos, doctrinas, pesos, restricciones, memorias y operaciones permitidas.

Su ciclo:

1. evaluar;
2. seleccionar necesidad;
3. generar candidatos;
4. aplicar personalidad;
5. comprobar recursos;
6. elegir;
7. ejecutar;
8. recordar.

Evalúa periódicamente y tras eventos o cambios de frente, no cada fotograma.

## 27. Helios jugable

Helios aparece mediante informes, marcadores, probabilidades, advertencias, rutas, recomendaciones y confianza.

Ejemplo:

> **Amenaza:** media  
> **Confiabilidad:** 62 %  
> **Actualización:** hace 18 minutos  
> **Fuente:** radar y comunicaciones locales

La información puede ser verdadera, incompleta, antigua, priorizada o diseñada para provocar respuesta.

El jugador la compara con reconocimiento, civiles, prisioneros, técnicos y observación.

## 28. Exclusiones iniciales

* PvP Azul contra Rojo;
* construcción manual;
* cientos de sectores;
* economía monetaria detallada;
* conversaciones libres;
* población físicamente completa;
* Zeus obligatorio;
* mods requeridos;
* mapas simultáneos;
* IA generativa externa;
* sistema naval complejo.

## 29. Orden de implementación

### A — Núcleo

Estado, sectores, persistencia, unidad, tareas y virtualización.

### B — Vertical slice Azul

Aproximación, desembarco, playa, primer nodo, sector y contraataque.

### C — Dinámica básica

Convoyes, guarniciones, recursos, comandantes y reactividad.

### D — Inicio Rojo

Desembarco oriental, Asterión, Verde y playa.

### E — Actos intermedios

Ciudades, Verde, FIA, civiles y nodos.

### F — Stratis

Transferencia, operación y finales.

### G — Cooperativo

Servidor autoritativo, JIP, roles, sincronización y recuperación.

## 30. Vertical slice

La primera versión jugable incluye:

* selección Azul;
* AZUR-1;
* Ward, Hale y Rourke;
* aproximación;
* reconocimiento;
* desembarco;
* defensa de playa;
* cuartel automático;
* convoy;
* nodo Helios;
* municipio;
* contacto FIA;
* contraataque Verde;
* guardado/carga;
* frente dinámico pequeño.

Valida combate, narrativa, sectores, recursos, IA, Helios, persistencia y rendimiento antes de adaptar Rojo.

## 31. Principios de implementación

1. La historia se integra al sandbox.
2. Las misiones surgen del estado.
3. Un fracaso no siempre reinicia.
4. Solo un invasor es jugable.
5. Los comandantes conservan voluntad.
6. Helios recomienda.
7. Los sectores lejanos se abstraen.
8. Las composiciones se validan en 3DEN.
9. El servidor es autoridad cooperativa.
10. La política no depende solo de lados.
11. No todas las facciones permanecen físicas.
12. Bajas y personajes importantes persisten.
13. El motor táctico representa momentos decisivos.
14. Stratis es una misión separada conectada por estado.
15. La primera versión es vanilla y modular.
16. Cada sistema se prueba antes del siguiente.
17. El diseño individual permite migración cooperativa.
18. El rendimiento precede a la cantidad visible.
19. Las decisiones producen consecuencias observables.
20. La campaña continúa tras perder operaciones.

## 32. Definición final

Islas Fracturadas no es una colección lineal ni una simulación sin dirección.

Es una campaña persistente donde el mapa cambia, los mandos actúan, las misiones nacen de la guerra, los personajes recuerdan, Helios observa, Argos interviene y el jugador altera un conflicto que nunca controla por completo.

> Cada misión personalizada será una parte visible de una guerra más grande. El jugador combatirá dentro de ella, pero sus decisiones determinarán qué guerra encontrará cuando regrese.

## 33. Referencias técnicas verificadas

* [Mission Export](https://community.bohemia.net/wiki/Mission_Export)
* [Arma 3: Task Framework](https://community.bohemia.net/wiki/Arma_3%3A_Task_Framework)
* [setFriend](https://community.bohemia.net/wiki/setFriend)
* [Eden Editor: Scenario Attributes](https://community.bohemia.net/wiki/Eden_Editor%3A_Scenario_Attributes)
* [profileNamespace](https://community.bohemia.net/wiki/profileNamespace)
* [Multiplayer Scripting](https://community.bohemia.net/wiki/Multiplayer_Scripting)
* [Arma 3: Event Handlers](https://community.bohemia.net/wiki/Arma_3%3A_Event_Handlers)

## 34. Localización del vertical slice

La primera porción jugable queda fijada en el corredor Katalaki–Neochori–Stavros–AAC–Airport West. Comprende nueve objetivos territoriales y permite validar desembarco, población, logística, bases, aeródromos, Helios y guerra dinámica sin simular toda Altis al mismo nivel.

La delimitación y las funciones de esos sectores se mantienen en [ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md](ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md).
