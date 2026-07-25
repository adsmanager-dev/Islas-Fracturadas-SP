# Misiones, eventos y contenido dinámico

> **Estado del contenedor:** diseño confirmado y diseño en desarrollo
> **Fuente de verdad para:** misiones, eventos y contenido dinámico
> **Relacionados:** [15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md); [17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-07-25

## Propósito

Centralizar misiones, eventos y contenido dinámico sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [NARRATIVE ACTS AND MISSION SYSTEM](#fuente-narrative-acts-and-mission-system)
- [DYNAMIC MISSIONS AND EMERGENT EVENTS](#fuente-dynamic-missions-and-emergent-events)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `NARRATIVE_ACTS_AND_MISSION_SYSTEM.md`, `DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

## Contenido consolidado

<a id="fuente-narrative-acts-and-mission-system"></a>
## Fuente integrada: `NARRATIVE_ACTS_AND_MISSION_SYSTEM.md`

> **Procedencia:** contenido migrado de `NARRATIVE_ACTS_AND_MISSION_SYSTEM.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-narrative-acts-and-mission-system--estructura-narrativa-actos-y-sistema-de-misiones"></a>
### Estructura narrativa, actos y sistema de misiones

> La persistencia entre Altis, Stratis y el epílogo se rige por [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).
>
> **Jerarquía actual:** este documento conserva el fundamento narrativo y técnico. La secuencia jugable, las puertas, los IDs y el Acto I detallado se rigen por [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md#fuente-blue-red-campaign-architecture); las voces, comunicaciones, briefings, documentos y escenas, por [DIALOGUE_RADIO_BRIEFING_AUDIO_AND_CINEMATICS_SYSTEM.md](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system).

> **Versión:** 1.0
> **Modalidad inicial:** individual
> **Modalidad futura:** cooperativo de un solo bando
> **Terrenos:** Altis y Stratis
> **Bandos jugables:** Azul o Rojo, nunca simultáneamente
> **Base inicial:** contenido vanilla de Arma 3
> **Objetivo:** conectar la guerra dinámica con misiones narrativas sostenibles dentro de las capacidades reales del motor
>
> Implementa la historia de [STORY_BIBLE.md](02_STORY_BIBLE_AND_WORLD_HISTORY.md#fuente-story-bible) dentro del [sistema estratégico general](10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md#fuente-strategic-campaign-system). La distribución de evidencias, techos de conocimiento y preparación de Stratis se define en [INVESTIGATION_REVELATION_MATRIX.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-investigation-revelation-matrix).

<a id="src-narrative-acts-and-mission-system--1-decisión-técnica-principal"></a>
#### 1. Decisión técnica principal

La guerra principal se ejecuta como un escenario persistente en Altis. Los actos avanzan dentro de ese escenario mediante tareas y operaciones dinámicas.

Stratis es una misión separada para el desenlace y recibe únicamente un paquete de estado.

La campaña no será una colección de misiones que reinician el mundo ni una simulación que mantiene físicamente toda Altis.

<a id="src-narrative-acts-and-mission-system--escenario-1-introducción"></a>
##### Escenario 1 — Introducción

Altis o secuencia naval simplificada. Presenta bando, mandos, versión oficial, unidad protagonista, aproximación y primera señal.

Puede integrarse en la Guerra de Altis.

<a id="src-narrative-acts-and-mission-system--escenario-2-guerra-de-altis"></a>
##### Escenario 2 — Guerra de Altis

Núcleo persistente con sectores, bases, recursos, relaciones, población, mandos, misiones, progresión, nodos y política.

<a id="src-narrative-acts-and-mission-system--escenario-3-operación-stratis"></a>
##### Escenario 3 — Operación Stratis

Misión independiente desbloqueada por condiciones estratégicas.

Recibe:

* bando;
* supervivientes;
* relaciones principales;
* información descubierta;
* recursos asignados;
* control de Helios;
* decisiones previas.

<a id="src-narrative-acts-and-mission-system--escenario-4-epílogo"></a>
##### Escenario 4 — Epílogo

Misión breve, informe interactivo o secuencia que muestra consecuencias militares, políticas, civiles y estratégicas.

<a id="src-narrative-acts-and-mission-system--empaquetado"></a>
##### Empaquetado

Un PBO de misión normal contiene una única misión. Para agrupar Altis, Stratis y epílogo en un PBO se requiere formato de addon y definición mediante `CfgMissions`. También pueden distribuirse como campaña o misiones separadas.

La estructura lógica no depende de decidir ahora el empaquetado final.

<a id="src-narrative-acts-and-mission-system--2-capacidades-y-límites-de-arma-3"></a>
#### 2. Capacidades y límites de Arma 3

<a id="src-narrative-acts-and-mission-system--el-motor-representa-bien"></a>
##### El motor representa bien

Infantería, escuadras, vehículos, armas combinadas, patrullas, emboscadas, convoyes, asaltos, defensa, reconocimiento, infiltración, evacuaciones, apoyos, tareas, 3DEN y eventos SQF.

<a id="src-narrative-acts-and-mission-system--se-representará-de-forma-abstracta"></a>
##### Se representará de forma abstracta

* miles de soldados;
* toda la población;
* muchas organizaciones físicamente independientes;
* política completamente emergente;
* economía nacional detallada;
* conversaciones generativas;
* mandos que comprendan el lore por sí solos.

Se usarán estados, valores sectoriales, decisiones ponderadas, operaciones prefabricadas, diálogos escritos, personajes con variables y materialización selectiva.

Helios, Argos y los comandantes son sistemas de reglas, estados, prioridades y eventos, no inteligencias conscientes.

<a id="src-narrative-acts-and-mission-system--3-lados-y-subfacciones"></a>
#### 3. Lados y subfacciones

Arma 3 trabaja principalmente con West, East, Independent y Civilian. `setFriend` establece relaciones entre lados completos y cambiarlo durante una misión puede causar conductas inesperadas en grupos que ya conocen al antiguo aliado.

<a id="src-narrative-acts-and-mission-system--campaña-azul"></a>
##### Campaña Azul

* **West:** Azul y aliados tácticos integrados.
* **East:** Rojo.
* **Independent:** Verde y nativos hostiles activos.
* **Civilian:** no combatientes.

<a id="src-narrative-acts-and-mission-system--campaña-roja"></a>
##### Campaña Roja

* **East:** Rojo y aliados tácticos integrados.
* **West:** Azul.
* **Independent:** Verde y nativos hostiles activos.
* **Civilian:** no combatientes.

<a id="src-narrative-acts-and-mission-system--identidades-virtuales"></a>
##### Identidades virtuales

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

<a id="src-narrative-acts-and-mission-system--4-simulación-por-niveles"></a>
#### 4. Simulación por niveles

<a id="src-narrative-acts-and-mission-system--táctico"></a>
##### Táctico

Alrededor del jugador: unidades físicas, vehículos, civiles relevantes, proyectiles, daños, IA completa y composiciones.

<a id="src-narrative-acts-and-mission-system--operacional"></a>
##### Operacional

Sectores vecinos: grupos abstractos, rutas, destinos, tiempos, combate y refuerzos potenciales.

<a id="src-narrative-acts-and-mission-system--estratégico"></a>
##### Estratégico

Sectores lejanos: fuerza, moral, suministros, propietario, amenaza, insurgencia y resolución calculada.

<a id="src-narrative-acts-and-mission-system--materialización"></a>
##### Materialización

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

<a id="src-narrative-acts-and-mission-system--5-presupuesto-de-combate"></a>
#### 5. Presupuesto de combate

No habrá cientos de unidades físicas alrededor del jugador.

Una ofensiva que representa centenares de combatientes concentra la experiencia jugable en un objetivo decisivo, ruptura, convoy, flanco, nodo o puesto de mando.

El resto continúa en simulación operacional.

<a id="src-narrative-acts-and-mission-system--6-tipos-de-misión"></a>
#### 6. Tipos de misión

<a id="src-narrative-acts-and-mission-system--narrativas-principales"></a>
##### Narrativas principales

Personajes, diálogos, lugares preparados, revelaciones, decisiones y consecuencias. Un fracaso puede transformar la campaña.

<a id="src-narrative-acts-and-mission-system--estratégicas"></a>
##### Estratégicas

Ataque de sector, refuerzo, carretera, puerto, artillería o suministros según el estado.

<a id="src-narrative-acts-and-mission-system--reactivas"></a>
##### Reactivas

Contraataque, emboscada, piloto derribado, mando aislado, levantamiento, sabotaje u hospital atacado. Expiran y producen consecuencias si se ignoran.

<a id="src-narrative-acts-and-mission-system--locales"></a>
##### Locales

Municipios, civiles, FIA, Verde o técnicos: evacuaciones, medicinas, desaparecidos, energía y prisioneros.

<a id="src-narrative-acts-and-mission-system--inteligencia"></a>
##### Inteligencia

Observación, infiltración, documentos, intercepción, seguimiento, identificación de Argos y comparación de transmisiones.

<a id="src-narrative-acts-and-mission-system--mando"></a>
##### Mando

Selección de fuerzas, ataques secundarios, reservas, rutas y prioridades mediante órdenes sencillas de mapa y líderes IA; no una interfaz RTS completa.

<a id="src-narrative-acts-and-mission-system--7-estados-de-resolución"></a>
#### 7. Estados de resolución

* **Éxito completo:** objetivo y condiciones complementarias.
* **Éxito parcial:** objetivo central con pérdidas.
* **Fracaso controlado:** campaña continúa.
* **Desastre:** pérdidas estratégicas importantes.
* **Ignorada:** expira sin intervención.
* **Resultado oculto:** éxito aparente con beneficio para Helios o Argos.

Las misiones investigativas separan el resultado militar del informativo. Es posible ganar el combate y perder, dañar o entregar la evidencia. Cada prueba conserva estado, autenticación, interpretación y destino.

<a id="src-narrative-acts-and-mission-system--8-personalización-contextual"></a>
#### 8. Personalización contextual

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

<a id="src-narrative-acts-and-mission-system--9-prólogo-la-señal"></a>
#### 9. Prólogo — La señal

<a id="src-narrative-acts-and-mission-system--objetivo"></a>
##### Objetivo

Presentar crisis, bando, unidad, comandantes, aproximación y Helios.

El jugador comienza dentro de su fuerza naval. No existe un civil jugable fuera de su bando.

Stratis se presenta mediante noticias, registros, imágenes, comunicaciones, briefing o cinemática.

<a id="src-narrative-acts-and-mission-system--evento"></a>
##### Evento

Una transmisión no autorizada aparentemente procedente de Stratis entrega ruta, frecuencia, advertencia e información costera.

El mando puede usarla, considerarla una trampa o verificarla. La elección modifica el desembarco, no bloquea la campaña.

La transmisión forma parte de las anomalías PHAROS-LÁZARO dejadas por Damaris durante PROTOCOLO UMBRAL. Azul puede recibir la firma antigua y «RUTA SEGURA: 147»; Rojo recibe códigos Verdes incompatibles. El jugador desconoce todavía ese origen.

<a id="src-narrative-acts-and-mission-system--10-acto-i-dos-mareas"></a>
#### 10. Acto I — Dos mareas

Verde controla Altis; Azul y Rojo desembarcan; Helios funciona parcialmente.

<a id="src-narrative-acts-and-mission-system--azul"></a>
##### Azul

* **A1 — Costa ciega:** AZUR-1 reconoce defensas y civiles; la señal puede ser correcta, incompleta o atravesar una comunidad.
* **A2 — Línea de arena:** neutralizar defensas, proteger ingenieros y abrir logística.
* **A3 — La primera noche:** priorizar cuartel, heridos, depósito, repetidor o evacuación.

<a id="src-narrative-acts-and-mission-system--rojo"></a>
##### Rojo

* **R1 — Asterión:** RUBÍ-1 busca el enlace Verde y encuentra códigos rechazados y órdenes incompatibles.
* **R2 — Bienvenida rota:** sobrevivir a fuego Verde, identificar atacantes y recuperar comunicaciones.
* **R3 — Bastión oriental:** asegurar carretera, descarga, perímetro y combustible.

<a id="src-narrative-acts-and-mission-system--decisión"></a>
##### Decisión

Perseguir a Verde, consolidar, rescatar, o capturar el primer nodo.

Desbloquea sector inicial, cuartel, economía, operaciones y rango.

<a id="src-narrative-acts-and-mission-system--11-acto-ii-los-ojos-de-la-isla"></a>
#### 11. Acto II — Los ojos de la isla

Introduce información, acceso digital, técnicos y relaciones.

<a id="src-narrative-acts-and-mission-system--azul-1"></a>
##### Azul

* **A4 — Señal blanca:** capturar un repetidor intacto sin poseer sus códigos.
* **A5 — La ventana de Kavala:** acceso local a cambio de civiles y detenidos.
* **A6 — El informe imposible:** Reed y Kessler detectan un origen común con conclusiones opuestas.

<a id="src-narrative-acts-and-mission-system--rojo-1"></a>
##### Rojo

* **R4 — Códigos muertos:** capturar técnicos vivos cuando fallan los protocolos.
* **R5 — Camino de Molos:** proteger un convoy técnico bajo disputa Verde.
* **R6 — El aliado desconocido:** una guarnición coopera y otra intenta detenerla.

<a id="src-narrative-acts-and-mission-system--decisión-1"></a>
##### Decisión

Conectar, aislar, copiar, transferir, desmilitarizar o preservar funciones civiles del primer nodo.

<a id="src-narrative-acts-and-mission-system--12-acto-iii-tierra-prestada"></a>
#### 12. Acto III — Tierra prestada

Azul y Rojo se aproximan, Verde pierde sectores, los convoyes limitan la expansión y surgen guerrillas.

<a id="src-narrative-acts-and-mission-system--azul-2"></a>
##### Azul

* **A7 — Viento cruzado:** emboscar, seguir o utilizar una columna Roja.
* **A8 — Cruce sin dueño:** combate de tres fuerzas por un cruce.
* **A9 — La distancia de Hale:** explotar una ruptura o contener la sobreextensión.

<a id="src-narrative-acts-and-mission-system--rojo-2"></a>
##### Rojo

* **R7 — Corredor de hierro:** proteger logística contra varios actores.
* **R8 — Ruta de ceniza:** recuperar vehículos y fuerzas aisladas.
* **R9 — La presión de Vahid:** atacar o conservar depósitos y reserva.

La elección altera nivel de flota, reservas, confianza y frente.

<a id="src-narrative-acts-and-mission-system--13-acto-iv-las-ciudades-recuerdan"></a>
#### 13. Acto IV — Las ciudades recuerdan

Introduce desplazados, hospitales, huelgas, insurgencia y legitimidad urbana.

<a id="src-narrative-acts-and-mission-system--azul-3"></a>
##### Azul

* **A10 — Corredor abierto:** evacuación contra necesidad ofensiva.
* **A11 — El precio de la alcaldesa:** cooperación de Drakos bajo límites.
* **A12 — Precisión:** objetivo urbano señalado por una fuente incierta.

<a id="src-narrative-acts-and-mission-system--rojo-3"></a>
##### Rojo

* **R10 — Orden en la oscuridad:** energía y seguridad bajo clandestinidad.
* **R11 — Poder para la ciudad:** energía compartida entre hospitales, radares y Helios.
* **R12 — Estabilidad:** sustitución, negociación o detenciones.

Asalto, fuego pesado, bloqueo, negociación, retirada o evacuación modifican apoyo, radicalización, producción e insurgencia.

<a id="src-narrative-acts-and-mission-system--14-acto-v-el-ejército-dividido"></a>
#### 14. Acto V — El ejército dividido

Verde se divide entre Gobierno, soberanistas, reformistas, aliados Rojos y aislados.

<a id="src-narrative-acts-and-mission-system--azul-4"></a>
##### Azul

* **A13 — El mapa del general:** reunión con Varos o Koronis.
* **A14 — Bandera rota:** desertores exigen armas y autonomía.
* **A15 — El enemigo de mi enemigo:** Daskal ofrece inteligencia contra Rojo.

<a id="src-narrative-acts-and-mission-system--rojo-4"></a>
##### Rojo

* **R13 — Prueba de alianza:** cooperación Verde con mando propio.
* **R14 — La sombra de Asterión:** nueva versión del protocolo.
* **R15 — El general desobediente:** desarme que puede causar rebelión.

Apoyar un bloque o ninguno determina auxiliares, enemigos, legitimidad, Gobierno y accesos.

<a id="src-narrative-acts-and-mission-system--15-acto-vi-la-voz-de-stratis"></a>
#### 15. Acto VI — La voz de Stratis

La investigación conecta accesos Argos, operadores oficialmente muertos, ayudas familiares, cargas destinadas a S-26 y recomendaciones paralelas.

<a id="src-narrative-acts-and-mission-system--operaciones-variables"></a>
##### Operaciones variables

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

La ubicación narrativa de cada evidencia se desarrollará desde la [cronología de las últimas 72 horas](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-last-72-hours-chronology).

Los identificadores, rutas redundantes, intérpretes y consecuencias se mantienen en [INVESTIGATION_REVELATION_MATRIX.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-investigation-revelation-matrix).

<a id="src-narrative-acts-and-mission-system--16-acto-vii-la-guerra-de-los-nodos"></a>
#### 16. Acto VII — La guerra de los nodos

Una fuerza se aproxima al dominio y Helios aumenta su intervención.

<a id="src-narrative-acts-and-mission-system--azul-operación-tridente"></a>
##### Azul — Operación Tridente

Aeropuerto, puerto, nodo, electricidad o corredor oriental. Ward prioriza control, Hale destrucción, Kessler datos y Laurent población.

<a id="src-narrative-acts-and-mission-system--rojo-operación-aurora"></a>
##### Rojo — Operación Aurora

Gobierno, corredores, expulsión Azul, nodos o acceso marítimo. Navid prioriza continuidad, Vahid ofensiva, Sadeq Helios y Khoury legalidad.

<a id="src-narrative-acts-and-mission-system--operaciones-dinámicas"></a>
##### Operaciones dinámicas

Defensa de nodos, convoy de claves, central, técnicos, comunicaciones, rebelión Verde, levantamiento FIA, ofensiva rival y alerta falsa.

Capturar, reparar, integrar, aislar, destruir o transferir nodos determina inteligencia, civiles, Stratis, rival y Helios.

<a id="src-narrative-acts-and-mission-system--17-acto-viii-regreso-a-stratis"></a>
#### 17. Acto VIII — Regreso a Stratis

<a id="src-narrative-acts-and-mission-system--requisitos"></a>
##### Requisitos

Acceso marítimo o aéreo, información, fuerza, técnico o códigos y progresión adecuada. No exige controlar toda Altis.

La preparación se clasifica de S0 —asalto ciego— a S4 —verdad comparada—. Un nivel mayor reduce resistencia evitable, conserva archivos, permite distinguir Meridian de Verde y amplía las opciones relacionadas con PHAROS, Argos y Vardis.

<a id="src-narrative-acts-and-mission-system--transferencia"></a>
##### Transferencia

Unidad, personajes, apoyo, relaciones, estado técnico, documentos, decisiones de nodos y conocimiento de Argos.

<a id="src-narrative-acts-and-mission-system--fases"></a>
##### Fases

1. Aproximación por desembarco, infiltración, aire o cooperación.
2. Guarnición exterior: negociación o combate con Verde, Meridian y fuerzas divididas.
3. Superficie: puerto, radar, aeródromo, defensas y generadores.
4. PHAROS: operadores fantasma, retenidos, familias, archivos y pruebas del traslado.
5. Núcleo Argos: contratos, protocolos, comparación de campañas y validación.
6. Vardis: identidad probable y presencia no confirmada en una campaña; encuentro físico integral exclusivamente al completar ambas y activar `dualCampaignCompleted == true`.

<a id="src-narrative-acts-and-mission-system--decisiones"></a>
##### Decisiones

Activar, destruir, eliminar accesos, entregar localmente, publicar, compartir, desconectar o permitir continuidad. Solo la variante de Verdad Comparada, desbloqueada por ambas campañas, añade capturar, juzgar, utilizar, exponer o permitir la fuga de Vardis.

Las opciones dependen de técnicos, evidencia, nodos, relaciones, integridad y decisiones anteriores.

<a id="src-narrative-acts-and-mission-system--18-acto-ix-lo-que-queda"></a>
#### 18. Acto IX — Lo que queda

Calcula:

* vencedor, retirada o resistencia;
* Gobierno, protectorado, alianza o fragmentación;
* servicios, desplazados, radicalización y reconstrucción;
* destino de Helios;
* exposición o supervivencia de Argos.

<a id="src-narrative-acts-and-mission-system--19-plantillas-de-misión"></a>
#### 19. Plantillas de misión

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

Este documento conserva el contrato narrativo. La generación causal, puntuación de candidatos, transformación, memoria de contenido y resolución fuera de pantalla se rigen por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-dynamic-missions-and-emergent-events).

<a id="src-narrative-acts-and-mission-system--familias"></a>
##### Familias

Las 16 familias canónicas se enumeran en el Documento 3/14; esta lista abreviada conserva únicamente las categorías necesarias para describir los actos.

<a id="src-narrative-acts-and-mission-system--20-composiciones-3den"></a>
#### 20. Composiciones 3DEN

Las bases y objetivos se construyen mediante bibliotecas validadas, no colocando objetos aleatoriamente.

Categorías: playa, carretera, urbano, industrial, montaña, puerto, aeródromo, radar, campamento, puesto y base regional.

Cada composición posee bando, orientación, nivel, daño, terreno y dirección del frente.

<a id="src-narrative-acts-and-mission-system--21-tareas"></a>
#### 21. Tareas

Se utilizará el Task Framework oficial con tarea principal, subtareas, objetivos opcionales, estados parciales y destino actualizado.

En multijugador, creación y actualización se inicializan desde un punto central, preferiblemente el servidor, para sincronizar estados.

<a id="src-narrative-acts-and-mission-system--22-persistencia"></a>
#### 22. Persistencia

<a id="src-narrative-acts-and-mission-system--individual"></a>
##### Individual

`profileNamespace` almacena variables del perfil y `saveProfileNamespace` fuerza su escritura.

Se guardan acto, sectores, recursos, personajes, relaciones, unidades y vehículos persistentes, decisiones, documentos, estados de evidencia, conclusiones, testigos, entregas, Helios y misiones activas.

No se guardan referencias vivas a objetos, proyectiles, cadáveres irrelevantes, grupos temporales, efectos o rutas tácticas. Se guardan identificadores y estados.

<a id="src-narrative-acts-and-mission-system--cooperativo"></a>
##### Cooperativo

El servidor es la autoridad del mundo. Los perfiles individuales no lo son.

<a id="src-narrative-acts-and-mission-system--23-preparación-multijugador"></a>
#### 23. Preparación multijugador

<a id="src-narrative-acts-and-mission-system--servidor"></a>
##### Servidor

Campaña, sectores, recursos, IA estratégica, generación, resultados y persistencia.

<a id="src-narrative-acts-and-mission-system--cliente"></a>
##### Cliente

Interfaz, cámara, sonido local, acciones, presentación de tareas y efectos.

La arquitectura debe considerar localidad, efectos locales/globales y Join in Progress desde el inicio.

Usará variables públicas controladas, funciones autorizadas, `remoteExec` y sincronización al entrar.

<a id="src-narrative-acts-and-mission-system--24-eventos-y-memoria"></a>
#### 24. Eventos y memoria

Los Event Handlers registran muertes, cambios de grupo, vehículos y waypoints sin sondear continuamente todo el mundo.

Los eventos importantes —personaje muerto, vehículo destruido, civil herido, rendición, captura, convoy, nodo, desobediencia o prisionero— actualizan reputación, relaciones, cronología, mandos, finales y misiones futuras.

<a id="src-narrative-acts-and-mission-system--25-arquitectura-recomendada"></a>
#### 25. Arquitectura recomendada

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

<a id="src-narrative-acts-and-mission-system--26-ia-de-comandantes"></a>
#### 26. IA de comandantes

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

<a id="src-narrative-acts-and-mission-system--27-helios-jugable"></a>
#### 27. Helios jugable

Helios aparece mediante informes, marcadores, probabilidades, advertencias, rutas, recomendaciones y confianza.

Ejemplo:

> **Amenaza:** media
> **Confiabilidad:** 62 %
> **Actualización:** hace 18 minutos
> **Fuente:** radar y comunicaciones locales

La información puede ser verdadera, incompleta, antigua, priorizada o diseñada para provocar respuesta.

El jugador la compara con reconocimiento, civiles, prisioneros, técnicos y observación.

<a id="src-narrative-acts-and-mission-system--28-exclusiones-iniciales"></a>
#### 28. Exclusiones iniciales

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

<a id="src-narrative-acts-and-mission-system--29-orden-de-implementación"></a>
#### 29. Orden de implementación

<a id="src-narrative-acts-and-mission-system--a-núcleo"></a>
##### A — Núcleo

Estado, sectores, persistencia, unidad, tareas y virtualización.

<a id="src-narrative-acts-and-mission-system--b-vertical-slice-azul"></a>
##### B — Vertical slice Azul

Aproximación, desembarco, playa, primer nodo, sector y contraataque.

<a id="src-narrative-acts-and-mission-system--c-dinámica-básica"></a>
##### C — Dinámica básica

Convoyes, guarniciones, recursos, comandantes y reactividad.

<a id="src-narrative-acts-and-mission-system--d-inicio-rojo"></a>
##### D — Inicio Rojo

Desembarco oriental, Asterión, Verde y playa.

<a id="src-narrative-acts-and-mission-system--e-actos-intermedios"></a>
##### E — Actos intermedios

Ciudades, Verde, FIA, civiles y nodos.

<a id="src-narrative-acts-and-mission-system--f-stratis"></a>
##### F — Stratis

Transferencia, operación y finales.

<a id="src-narrative-acts-and-mission-system--g-cooperativo"></a>
##### G — Cooperativo

Servidor autoritativo, JIP, roles, sincronización y recuperación.

<a id="src-narrative-acts-and-mission-system--30-vertical-slice"></a>
#### 30. Vertical slice

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

<a id="src-narrative-acts-and-mission-system--31-principios-de-implementación"></a>
#### 31. Principios de implementación

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

<a id="src-narrative-acts-and-mission-system--32-definición-final"></a>
#### 32. Definición final

Islas Fracturadas no es una colección lineal ni una simulación sin dirección.

Es una campaña persistente donde el mapa cambia, los mandos actúan, las misiones nacen de la guerra, los personajes recuerdan, Helios observa, Argos interviene y el jugador altera un conflicto que nunca controla por completo.

> Cada misión personalizada será una parte visible de una guerra más grande. El jugador combatirá dentro de ella, pero sus decisiones determinarán qué guerra encontrará cuando regrese.

<a id="src-narrative-acts-and-mission-system--33-referencias-técnicas-verificadas"></a>
#### 33. Referencias técnicas verificadas

* [Mission Export](https://community.bohemia.net/wiki/Mission_Export)
* [Arma 3: Task Framework](https://community.bohemia.net/wiki/Arma_3%3A_Task_Framework)
* [setFriend](https://community.bohemia.net/wiki/setFriend)
* [Eden Editor: Scenario Attributes](https://community.bohemia.net/wiki/Eden_Editor%3A_Scenario_Attributes)
* [profileNamespace](https://community.bohemia.net/wiki/profileNamespace)
* [Multiplayer Scripting](https://community.bohemia.net/wiki/Multiplayer_Scripting)
* [Arma 3: Event Handlers](https://community.bohemia.net/wiki/Arma_3%3A_Event_Handlers)

<a id="src-narrative-acts-and-mission-system--34-localización-del-vertical-slice"></a>
#### 34. Localización del vertical slice

La primera porción jugable queda fijada en el corredor Katalaki–Neochori–Stavros–AAC–Airport West. Comprende nueve objetivos territoriales y permite validar desembarco, población, logística, bases, aeródromos, Helios y guerra dinámica sin simular toda Altis al mismo nivel.

La delimitación y las funciones de esos sectores se mantienen en [ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md](10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md#fuente-altis-geography-and-sector-map).

---

<a id="fuente-dynamic-missions-and-emergent-events"></a>
## Fuente integrada: `DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md`

> **Procedencia:** contenido migrado de `DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-dynamic-missions-and-emergent-events--islas-fracturadas"></a>
### ISLAS FRACTURADAS

<a id="src-dynamic-missions-and-emergent-events--documento-314-sistema-definitivo-de-misiones-dinámicas-y-eventos-emergentes"></a>
#### Documento 3/14 — Sistema definitivo de misiones dinámicas y eventos emergentes

**Versión:** 1.0
**Clasificación:** documento rector de diseño de misiones, simulación y narrativa emergente
**Campañas:** Fuerza Azul y Fuerza Roja
**Terrenos:** Altis y Stratis
**Motor:** Arma 3 2.18
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando
**Estado:** canon previo a implementación

> **Jerarquía documental:** este Documento 3/14 gobierna necesidades, eventos, plantillas, generación, transformación, resolución externa, ritmo y anti-repetición. Las misiones narrativas y sus puertas se rigen por [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md#fuente-blue-red-campaign-architecture); las evidencias, por [INVESTIGATION_REVELATION_MATRIX.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-investigation-revelation-matrix); las causas civiles, por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-civil-municipal-political-stability-system); las reglas clandestinas FIA, por [FIA_INSURGENCY_AND_CLANDESTINE_WAR_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-fia-insurgency-and-clandestine-war-system); la disponibilidad informativa y niebla de guerra, por [HELIOS_INTELLIGENCE_AND_FOG_OF_WAR_SYSTEM.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-helios-intelligence-and-fog-of-war-system); y el estado autoritativo, por [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).
>
> **Espacios de identificadores:** `IF_*` identifica contenido narrativo o autoral estable; `TPL_*`, plantillas dinámicas; `NEED_*`, necesidades causales; y `DYN_*`, instancias generadas durante una campaña. Una instancia `DYN_*` nunca sustituye ni reutiliza el ID `IF_*` de una misión narrativa.

---

<a id="src-dynamic-missions-and-emergent-events--1-propósito"></a>
### 1. Propósito

Este documento define cómo el estado persistente de la campaña genera contenido jugable a partir de:

* necesidades de los comandantes;
* cambios territoriales;
* frentes;
* recursos;
* convoyes;
* guarniciones;
* población;
* infraestructura;
* relaciones;
* personajes;
* investigaciones;
* actividad de Helios;
* intervenciones de Argos;
* decisiones previas del jugador.

El sistema debe producir operaciones que parezcan consecuencias naturales de la guerra.

No debe producir una lista de tareas arbitrarias como:

* elimine una patrulla;
* capture una base sin contexto;
* transporte una caja;
* defienda durante diez minutos;
* repita exactamente la misma emboscada.

Cada misión dinámica deberá responder:

1. ¿Qué problema del mundo la originó?
2. ¿Quién desea resolverlo?
3. ¿Por qué necesita al jugador?
4. ¿Qué ocurre si se ignora?
5. ¿Qué cambia cuando termina?
6. ¿Por qué esta versión es diferente de la anterior?

---

<a id="src-dynamic-missions-and-emergent-events--2-decisión-de-diseño-principal"></a>
### 2. Decisión de diseño principal

Las misiones dinámicas no serán seleccionadas únicamente mediante azar.

Se generarán mediante una cadena causal:

```text
Estado del mundo
→ necesidad
→ actor interesado
→ familia de misión
→ plantilla compatible
→ parámetros concretos
→ oferta
→ ejecución o resolución externa
→ consecuencias persistentes
```

<a id="src-dynamic-missions-and-emergent-events--ejemplo"></a>
#### Ejemplo

Un convoy no aparece porque el generador decidió crear una misión de escolta.

Aparece porque:

* Neochori tiene combustible crítico;
* Katalaki posee existencias;
* la carretera está abierta;
* FIA ha atacado esa ruta anteriormente;
* Rourke no dispone de suficientes fuerzas;
* el jugador tiene autoridad y se encuentra cerca.

La misión puede ser:

* escoltar;
* despejar ruta;
* buscar convoy perdido;
* tender una contraemboscada;
* negociar paso;
* usar una ruta alternativa.

La necesidad logística es la misma.

La forma jugable depende del estado.

---

<a id="src-dynamic-missions-and-emergent-events--3-diferencia-entre-misión-y-evento"></a>
### 3. Diferencia entre misión y evento

<a id="src-dynamic-missions-and-emergent-events--misión"></a>
#### Misión

Requiere o permite una intervención organizada del jugador.

Posee:

* origen;
* objetivos;
* condiciones;
* resultado;
* consecuencias.

<a id="src-dynamic-missions-and-emergent-events--evento"></a>
#### Evento

Es un acontecimiento del mundo.

Puede ocurrir:

* con el jugador presente;
* fuera de pantalla;
* como resultado de otro sistema;
* sin convertirse en misión.

Ejemplos:

* protesta;
* ataque de artillería;
* huelga;
* deserción;
* apagón;
* caída de un sector;
* llegada de refugiados.

<a id="src-dynamic-missions-and-emergent-events--conversión"></a>
#### Conversión

Un evento puede generar una misión.

Ejemplo:

```text
Apagón en hospital
→ necesidad de energía
→ misión de combustible, reparación o protección
```

---

<a id="src-dynamic-missions-and-emergent-events--4-tipos-generales-de-contenido-dinámico"></a>
### 4. Tipos generales de contenido dinámico

<a id="src-dynamic-missions-and-emergent-events--41-operación-solicitada"></a>
#### 4.1 Operación solicitada

Un comandante o autoridad ofrece una misión.

Ejemplos:

* Rourke solicita reconocimiento;
* Vahid ordena romper un bloqueo;
* Markou pide proteger una evacuación.

---

<a id="src-dynamic-missions-and-emergent-events--42-emergencia"></a>
#### 4.2 Emergencia

La situación exige respuesta inmediata.

Ejemplos:

* sector atacado;
* convoy bajo fuego;
* helicóptero derribado;
* hospital sin energía.

---

<a id="src-dynamic-missions-and-emergent-events--43-oportunidad"></a>
#### 4.3 Oportunidad

El jugador puede explotar una situación.

Ejemplos:

* oficial enemigo aislado;
* depósito mal protegido;
* señal Helios;
* vehículo abandonado.

---

<a id="src-dynamic-missions-and-emergent-events--44-petición-civil"></a>
#### 4.4 Petición civil

Procede de:

* alcalde;
* médico;
* sindicato;
* comunidad;
* familia;
* trabajadores.

Puede contradecir una orden militar.

---

<a id="src-dynamic-missions-and-emergent-events--45-investigación"></a>
#### 4.5 Investigación

Se genera por:

* pista;
* evidencia;
* testimonio;
* contradicción;
* señal;
* anomalía logística.

---

<a id="src-dynamic-missions-and-emergent-events--46-operación-clandestina"></a>
#### 4.6 Operación clandestina

Procede de:

* FIA;
* Argos;
* inteligencia;
* infiltrado;
* contrabandista.

Puede ser:

* legítima;
* manipulada;
* trampa;
* parcialmente verdadera.

---

<a id="src-dynamic-missions-and-emergent-events--47-consecuencia-diferida"></a>
#### 4.7 Consecuencia diferida

Aparece por una decisión anterior.

Ejemplos:

* un prisionero liberado ofrece información;
* un alcalde rechazado apoya a FIA;
* un vehículo no recuperado reaparece en manos enemigas;
* una evidencia entregada a Shaw desaparece.

---

<a id="src-dynamic-missions-and-emergent-events--5-fuentes-de-necesidades"></a>
### 5. Fuentes de necesidades

El generador observará categorías concretas.

<a id="src-dynamic-missions-and-emergent-events--militar"></a>
#### Militar

* sector amenazado;
* reserva insuficiente;
* fuerza aislada;
* guarnición débil;
* oportunidad ofensiva;
* comandante muerto;
* artillería enemiga.

<a id="src-dynamic-missions-and-emergent-events--logística"></a>
#### Logística

* recurso crítico;
* convoy detenido;
* ruta bloqueada;
* depósito amenazado;
* vehículo abandonado;
* puerto degradado.

<a id="src-dynamic-missions-and-emergent-events--civil"></a>
#### Civil

* desplazados;
* hospital;
* agua;
* alimentos;
* protesta;
* huelga;
* saqueo;
* detenciones.

<a id="src-dynamic-missions-and-emergent-events--política"></a>
#### Política

* negociación;
* autoridad disputada;
* tratado;
* golpe;
* visita;
* propaganda;
* elección local.

<a id="src-dynamic-missions-and-emergent-events--inteligencia"></a>
#### Inteligencia

* informe contradictorio;
* transmisión;
* infiltrado;
* prisionero;
* dron perdido;
* nodo Helios.

<a id="src-dynamic-missions-and-emergent-events--personal"></a>
#### Personal

* miembro herido;
* conflicto interno;
* deuda;
* familiar;
* promesa;
* sospecha.

<a id="src-dynamic-missions-and-emergent-events--argos"></a>
#### Argos

* evidencia expuesta;
* infiltrado en riesgo;
* nodo amenazado;
* equilibrio roto;
* evacuación PHAROS.

---

<a id="src-dynamic-missions-and-emergent-events--6-niveles-de-prioridad"></a>
### 6. Niveles de prioridad

```text
CRITICAL
URGENT
HIGH
NORMAL
LOW
BACKGROUND
```

<a id="src-dynamic-missions-and-emergent-events--critical"></a>
#### CRITICAL

Amenaza inmediata de:

* derrota;
* muerte;
* colapso;
* pérdida irreversible.

Caduca rápidamente.

<a id="src-dynamic-missions-and-emergent-events--urgent"></a>
#### URGENT

Ventana corta con consecuencias graves.

<a id="src-dynamic-missions-and-emergent-events--high"></a>
#### HIGH

Importante para la estrategia actual.

<a id="src-dynamic-missions-and-emergent-events--normal"></a>
#### NORMAL

Operación útil sin emergencia.

<a id="src-dynamic-missions-and-emergent-events--low"></a>
#### LOW

Oportunidad secundaria.

<a id="src-dynamic-missions-and-emergent-events--background"></a>
#### BACKGROUND

Puede resolverse fuera de pantalla y normalmente no se ofrece directamente.

---

<a id="src-dynamic-missions-and-emergent-events--7-ventana-temporal"></a>
### 7. Ventana temporal

Cada misión tendrá:

```text
offerTime
earliestStart
softDeadline
hardDeadline
resolutionTime
```

<a id="src-dynamic-missions-and-emergent-events--soft-deadline"></a>
#### Soft deadline

Después de este punto:

* la situación empeora;
* cambian objetivos;
* desaparecen ventajas.

<a id="src-dynamic-missions-and-emergent-events--hard-deadline"></a>
#### Hard deadline

La misión:

* expira;
* se resuelve externamente;
* se transforma.

<a id="src-dynamic-missions-and-emergent-events--ejemplo-1"></a>
#### Ejemplo

Un convoy bajo amenaza:

<a id="src-dynamic-missions-and-emergent-events--antes-del-soft-deadline"></a>
##### Antes del soft deadline

Puede escoltarse desde el origen.

<a id="src-dynamic-missions-and-emergent-events--después"></a>
##### Después

Ya se encuentra en ruta.

<a id="src-dynamic-missions-and-emergent-events--cerca-del-hard-deadline"></a>
##### Cerca del hard deadline

Está bajo ataque.

<a id="src-dynamic-missions-and-emergent-events--después-1"></a>
##### Después

Se convierte en:

* recuperar supervivientes;
* recuperar carga;
* investigar la emboscada.

---

<a id="src-dynamic-missions-and-emergent-events--8-transformación-de-misiones"></a>
### 8. Transformación de misiones

Una misión no debe desaparecer siempre cuando expira.

Puede convertirse en otra.

<a id="src-dynamic-missions-and-emergent-events--cadena-de-ejemplo"></a>
#### Cadena de ejemplo

```text
Escoltar convoy
→ convoy ignorado
→ convoy atacado
→ rescatar supervivientes
→ carga capturada
→ atacar depósito enemigo
```

<a id="src-dynamic-missions-and-emergent-events--otro-ejemplo"></a>
#### Otro ejemplo

```text
Proteger reunión
→ reunión atacada
→ líder herido
→ evacuar
→ investigar infiltración
→ represalia o negociación
```

<a id="src-dynamic-missions-and-emergent-events--ventaja"></a>
#### Ventaja

El mundo recuerda el problema original.

---

<a id="src-dynamic-missions-and-emergent-events--9-familias-principales-de-misión"></a>
### 9. Familias principales de misión

1. Reconocimiento.
2. Ataque.
3. Defensa.
4. Convoy y logística.
5. Rescate y evacuación.
6. Recuperación.
7. Sabotaje.
8. Inteligencia e investigación.
9. Negociación y política.
10. Seguridad civil.
11. Contrainsurgencia.
12. Guerrilla e insurgencia.
13. Artillería y defensa aérea.
14. Operaciones aéreas y navales.
15. Helios y Argos.
16. Personajes y escuadra.

---

<a id="src-dynamic-missions-and-emergent-events--10-familia-reconocimiento"></a>
### 10. Familia RECONOCIMIENTO

<a id="src-dynamic-missions-and-emergent-events--propósito"></a>
#### Propósito

Reducir incertidumbre antes de otra decisión.

<a id="src-dynamic-missions-and-emergent-events--variantes"></a>
#### Variantes

<a id="src-dynamic-missions-and-emergent-events--observación-de-sector"></a>
##### Observación de sector

* identificar guarnición;
* registrar vehículos;
* encontrar rutas.

<a id="src-dynamic-missions-and-emergent-events--reconocimiento-de-ruta"></a>
##### Reconocimiento de ruta

* minas;
* bloqueos;
* emboscadas;
* civiles.

<a id="src-dynamic-missions-and-emergent-events--reconocimiento-técnico"></a>
##### Reconocimiento técnico

* radar;
* señal;
* nodo;
* energía.

<a id="src-dynamic-missions-and-emergent-events--reconocimiento-humano"></a>
##### Reconocimiento humano

* hablar con civiles;
* identificar mando;
* verificar lealtad.

<a id="src-dynamic-missions-and-emergent-events--reconocimiento-profundo"></a>
##### Reconocimiento profundo

* larga distancia;
* poca extracción;
* riesgo elevado.

---

<a id="src-dynamic-missions-and-emergent-events--11-parámetros-de-reconocimiento"></a>
### 11. Parámetros de reconocimiento

```text
targetSector
observationPoints
requiredInformation
allowedDetection
timeWindow
weather
enemyPatrolDensity
extractionRequired
```

<a id="src-dynamic-missions-and-emergent-events--resultados-posibles"></a>
#### Resultados posibles

<a id="src-dynamic-missions-and-emergent-events--éxito-discreto"></a>
##### Éxito discreto

* información de alta calidad;
* enemigo no alerta.

<a id="src-dynamic-missions-and-emergent-events--éxito-detectado"></a>
##### Éxito detectado

* información obtenida;
* enemigo cambia defensas.

<a id="src-dynamic-missions-and-emergent-events--parcial"></a>
##### Parcial

* fuerza o ruta estimada;
* detalles desconocidos.

<a id="src-dynamic-missions-and-emergent-events--fracaso"></a>
##### Fracaso

* información incorrecta;
* unidad perseguida;
* enemigo prepara trampa.

---

<a id="src-dynamic-missions-and-emergent-events--12-anti-repetición-de-reconocimiento"></a>
### 12. Anti-repetición de reconocimiento

No todas las misiones deben consistir en observar desde una colina.

Variaciones:

* infiltración urbana;
* dron;
* contacto civil;
* patrulla disfrazada;
* recuperación de fotografías;
* colocación de sensor;
* interrogatorio;
* seguir convoy;
* navegar por costa.

---

<a id="src-dynamic-missions-and-emergent-events--13-familia-ataque"></a>
### 13. Familia ATAQUE

<a id="src-dynamic-missions-and-emergent-events--propósito-1"></a>
#### Propósito

Cambiar:

* control;
* capacidad;
* recurso;
* iniciativa.

<a id="src-dynamic-missions-and-emergent-events--variantes-1"></a>
#### Variantes

<a id="src-dynamic-missions-and-emergent-events--asalto-de-sector"></a>
##### Asalto de sector

Objetivo territorial completo.

<a id="src-dynamic-missions-and-emergent-events--ataque-limitado"></a>
##### Ataque limitado

Destruir una capacidad específica.

<a id="src-dynamic-missions-and-emergent-events--incursión"></a>
##### Incursión

Entrar, atacar y retirarse.

<a id="src-dynamic-missions-and-emergent-events--ruptura"></a>
##### Ruptura

Abrir una línea o carretera.

<a id="src-dynamic-missions-and-emergent-events--ataque-de-flanco"></a>
##### Ataque de flanco

Apoyar una operación principal.

<a id="src-dynamic-missions-and-emergent-events--golpe-de-mando"></a>
##### Golpe de mando

Capturar o neutralizar liderazgo.

<a id="src-dynamic-missions-and-emergent-events--ataque-de-oportunidad"></a>
##### Ataque de oportunidad

Explotar enemigo debilitado.

---

<a id="src-dynamic-missions-and-emergent-events--14-parámetros-de-ataque"></a>
### 14. Parámetros de ataque

```text
objectiveType
enemyStrengthEstimate
friendlyMainForce
playerRole
supportAvailable
civilianPresence
desiredDamageLimit
timeConstraint
withdrawalCondition
```

<a id="src-dynamic-missions-and-emergent-events--roles-del-jugador"></a>
#### Roles del jugador

* fuerza principal;
* avanzada;
* flanco;
* reconocimiento armado;
* neutralización técnica;
* reserva;
* extracción.

---

<a id="src-dynamic-missions-and-emergent-events--15-resultados-de-ataque"></a>
### 15. Resultados de ataque

<a id="src-dynamic-missions-and-emergent-events--captura-completa"></a>
#### Captura completa

* propietario cambia;
* infraestructura evaluada;
* guarnición asignada.

<a id="src-dynamic-missions-and-emergent-events--objetivo-destruido"></a>
#### Objetivo destruido

* capacidad enemiga reducida;
* sector puede seguir enemigo.

<a id="src-dynamic-missions-and-emergent-events--retirada-enemiga"></a>
#### Retirada enemiga

* menos bajas;
* fuerza puede reaparecer.

<a id="src-dynamic-missions-and-emergent-events--éxito-costoso"></a>
#### Éxito costoso

* control obtenido;
* baja capacidad de consolidación.

<a id="src-dynamic-missions-and-emergent-events--fracaso-1"></a>
#### Fracaso

* recursos consumidos;
* enemigo preparado;
* moral reducida.

---

<a id="src-dynamic-missions-and-emergent-events--16-familia-defensa"></a>
### 16. Familia DEFENSA

<a id="src-dynamic-missions-and-emergent-events--variantes-2"></a>
#### Variantes

<a id="src-dynamic-missions-and-emergent-events--defensa-preparada"></a>
##### Defensa preparada

Tiempo para:

* orientar;
* fortificar;
* asignar reservas.

<a id="src-dynamic-missions-and-emergent-events--defensa-de-emergencia"></a>
##### Defensa de emergencia

Ataque ya comenzó.

<a id="src-dynamic-missions-and-emergent-events--retardo"></a>
##### Retardo

No se pretende conservar el sector indefinidamente.

<a id="src-dynamic-missions-and-emergent-events--protección-de-instalación"></a>
##### Protección de instalación

Hospital, puente, nodo o depósito.

<a id="src-dynamic-missions-and-emergent-events--defensa-móvil"></a>
##### Defensa móvil

Retiradas y contraataques.

<a id="src-dynamic-missions-and-emergent-events--defensa-de-evacuación"></a>
##### Defensa de evacuación

Proteger mientras salen civiles o recursos.

---

<a id="src-dynamic-missions-and-emergent-events--17-condiciones-de-defensa"></a>
### 17. Condiciones de defensa

La defensa no se resolverá únicamente mediante “elimine a todos”.

Puede terminar cuando:

* transcurre una ventana;
* llega refuerzo;
* termina evacuación;
* enemigo pierde capacidad;
* ruta queda abierta;
* se ordena retirada.

<a id="src-dynamic-missions-and-emergent-events--decisiones"></a>
#### Decisiones

* sostener;
* contraatacar;
* retirarse;
* evacuar módulo;
* destruir instalación;
* solicitar apoyo.

---

<a id="src-dynamic-missions-and-emergent-events--18-familia-convoy-y-logística"></a>
### 18. Familia CONVOY Y LOGÍSTICA

<a id="src-dynamic-missions-and-emergent-events--variantes-3"></a>
#### Variantes

<a id="src-dynamic-missions-and-emergent-events--escolta-completa"></a>
##### Escolta completa

Desde origen hasta destino.

<a id="src-dynamic-missions-and-emergent-events--seguridad-de-tramo"></a>
##### Seguridad de tramo

Proteger solo un segmento.

<a id="src-dynamic-missions-and-emergent-events--despeje-de-ruta"></a>
##### Despeje de ruta

Eliminar amenaza antes del convoy.

<a id="src-dynamic-missions-and-emergent-events--reacción-a-emboscada"></a>
##### Reacción a emboscada

Llegar cuando el ataque ya comenzó.

<a id="src-dynamic-missions-and-emergent-events--convoy-señuelo"></a>
##### Convoy señuelo

Atraer al enemigo.

<a id="src-dynamic-missions-and-emergent-events--convoy-civil"></a>
##### Convoy civil

Refugiados o ayuda.

<a id="src-dynamic-missions-and-emergent-events--convoy-clandestino"></a>
##### Convoy clandestino

Carga FIA, Argos o inteligencia.

<a id="src-dynamic-missions-and-emergent-events--convoy-pesado"></a>
##### Convoy pesado

Vehículos lentos y valiosos.

---

<a id="src-dynamic-missions-and-emergent-events--19-contenido-variable-de-convoy"></a>
### 19. Contenido variable de convoy

* combustible;
* munición;
* medicina;
* alimentos;
* personal;
* prisioneros;
* técnicos;
* vehículos;
* evidencia;
* material Helios.

El contenido cambia:

* comportamiento;
* prioridad;
* reglas de fuego;
* consecuencias.

---

<a id="src-dynamic-missions-and-emergent-events--20-familia-rescate-y-evacuación"></a>
### 20. Familia RESCATE Y EVACUACIÓN

<a id="src-dynamic-missions-and-emergent-events--variantes-4"></a>
#### Variantes

<a id="src-dynamic-missions-and-emergent-events--csar"></a>
##### CSAR

Rescate de piloto o tripulación.

<a id="src-dynamic-missions-and-emergent-events--unidad-cercada"></a>
##### Unidad cercada

Abrir corredor.

<a id="src-dynamic-missions-and-emergent-events--personal-civil"></a>
##### Personal civil

Evacuar población.

<a id="src-dynamic-missions-and-emergent-events--personaje"></a>
##### Personaje

Rescatar figura relevante.

<a id="src-dynamic-missions-and-emergent-events--médico"></a>
##### Médico

Extraer heridos.

<a id="src-dynamic-missions-and-emergent-events--prisionero"></a>
##### Prisionero

Liberación o intercambio fallido.

<a id="src-dynamic-missions-and-emergent-events--operador-pharos"></a>
##### Operador PHAROS

Extraer técnico o testigo.

---

<a id="src-dynamic-missions-and-emergent-events--21-decisiones-de-evacuación"></a>
### 21. Decisiones de evacuación

El transporte puede ser insuficiente.

El jugador puede priorizar:

* heridos;
* civiles;
* técnicos;
* evidencia;
* soldados;
* vehículos.

<a id="src-dynamic-missions-and-emergent-events--consecuencia"></a>
#### Consecuencia

Lo que queda atrás puede:

* morir;
* ser capturado;
* destruirse;
* aparecer más tarde.

---

<a id="src-dynamic-missions-and-emergent-events--22-familia-recuperación"></a>
### 22. Familia RECUPERACIÓN

<a id="src-dynamic-missions-and-emergent-events--objetivos"></a>
#### Objetivos

* vehículo;
* arma;
* dron;
* archivo;
* cadáver;
* caja;
* servidor;
* pieza de Helios.

<a id="src-dynamic-missions-and-emergent-events--variantes-5"></a>
#### Variantes

<a id="src-dynamic-missions-and-emergent-events--recuperación-limpia"></a>
##### Recuperación limpia

Zona abandonada.

<a id="src-dynamic-missions-and-emergent-events--carrera"></a>
##### Carrera

Enemigo también busca el objeto.

<a id="src-dynamic-missions-and-emergent-events--recuperación-bajo-fuego"></a>
##### Recuperación bajo fuego

El activo está en zona disputada.

<a id="src-dynamic-missions-and-emergent-events--recuperación-técnica"></a>
##### Recuperación técnica

Necesita ingeniero.

<a id="src-dynamic-missions-and-emergent-events--recuperación-moral"></a>
##### Recuperación moral

Recuperar cuerpos o identificación.

---

<a id="src-dynamic-missions-and-emergent-events--23-familia-sabotaje"></a>
### 23. Familia SABOTAJE

<a id="src-dynamic-missions-and-emergent-events--variantes-6"></a>
#### Variantes

* puente;
* radar;
* combustible;
* artillería;
* pista;
* comunicaciones;
* generador;
* depósito;
* convoy;
* nodo Helios.

<a id="src-dynamic-missions-and-emergent-events--métodos"></a>
#### Métodos

* explosivos;
* interferencia;
* contaminación;
* manipulación digital;
* robo;
* daño selectivo.

<a id="src-dynamic-missions-and-emergent-events--consecuencia-civil"></a>
#### Consecuencia civil

La destrucción puede afectar:

* agua;
* electricidad;
* hospitales;
* comercio.

---

<a id="src-dynamic-missions-and-emergent-events--24-sabotaje-reversible-e-irreversible"></a>
### 24. Sabotaje reversible e irreversible

<a id="src-dynamic-missions-and-emergent-events--reversible"></a>
#### Reversible

* cortar cables;
* robar componente;
* contaminar parcialmente;
* desactivar.

<a id="src-dynamic-missions-and-emergent-events--irreversible"></a>
#### Irreversible

* destruir puente;
* incendiar depósito;
* demoler nodo.

<a id="src-dynamic-missions-and-emergent-events--regla"></a>
#### Regla

Los comandantes pueden preferir una opción.

El jugador puede elegir otra y asumir consecuencias.

---

<a id="src-dynamic-missions-and-emergent-events--25-familia-inteligencia-e-investigación"></a>
### 25. Familia INTELIGENCIA E INVESTIGACIÓN

<a id="src-dynamic-missions-and-emergent-events--variantes-7"></a>
#### Variantes

* recuperar documento;
* seguir a un contacto;
* proteger testigo;
* interceptar transmisión;
* analizar instalación;
* registrar convoy;
* comparar archivos;
* capturar operador;
* verificar tumba;
* inspeccionar nómina.

<a id="src-dynamic-missions-and-emergent-events--diferencia"></a>
#### Diferencia

El objetivo no siempre es encontrar una prueba.

Puede ser demostrar que una prueba es falsa o incompleta.

---

<a id="src-dynamic-missions-and-emergent-events--26-fases-investigativas"></a>
### 26. Fases investigativas

1. Localizar.
2. Acceder.
3. Recuperar.
4. Preservar.
5. Extraer.
6. Entregar.
7. Interpretar.

El combate puede ocurrir en cualquier fase, pero no debe reemplazar la investigación.

---

<a id="src-dynamic-missions-and-emergent-events--27-familia-negociación-y-política"></a>
### 27. Familia NEGOCIACIÓN Y POLÍTICA

<a id="src-dynamic-missions-and-emergent-events--variantes-8"></a>
#### Variantes

* alto el fuego;
* paso por sector;
* entrega de guarnición;
* cooperación municipal;
* intercambio de prisioneros;
* protesta;
* tratado local;
* reunión Verde;
* disputa FIA;
* autoridad gubernamental.

<a id="src-dynamic-missions-and-emergent-events--mecánicas"></a>
#### Mecánicas

* preparación;
* seguridad;
* evidencia;
* reputación;
* demandas;
* concesiones.

---

<a id="src-dynamic-missions-and-emergent-events--28-negociaciones-dinámicas"></a>
### 28. Negociaciones dinámicas

Una negociación debe tener:

```text
participants
minimumDemands
possibleConcessions
redLines
trust
externalPressure
securityRisk
timeLimit
```

<a id="src-dynamic-missions-and-emergent-events--ejemplo-2"></a>
#### Ejemplo

Una unidad Verde puede aceptar:

* paso Rojo;
* conservar armas;
* mando local;
* no arrestar oficiales.

Vahid puede exigir:

* desarme;
* subordinación;
* control de carretera.

El jugador puede:

* mediar;
* presionar;
* preparar ataque;
* aceptar compromiso.

---

<a id="src-dynamic-missions-and-emergent-events--29-familia-seguridad-civil"></a>
### 29. Familia SEGURIDAD CIVIL

<a id="src-dynamic-missions-and-emergent-events--variantes-9"></a>
#### Variantes

* proteger hospital;
* distribuir alimentos;
* controlar saqueo;
* reparar agua;
* escoltar trabajadores;
* contener disturbios;
* registrar zona;
* proteger funeral;
* reabrir mercado.

<a id="src-dynamic-missions-and-emergent-events--riesgo"></a>
#### Riesgo

La respuesta militar puede resolver el evento inmediato y empeorar:

* legitimidad;
* radicalización;
* cooperación.

---

<a id="src-dynamic-missions-and-emergent-events--30-disturbios-y-protestas"></a>
### 30. Disturbios y protestas

No serán hordas genéricas.

Tendrán causas:

* alimentos;
* detenciones;
* daños;
* ocupación;
* apagones;
* salarios;
* rumores.

<a id="src-dynamic-missions-and-emergent-events--respuestas"></a>
#### Respuestas

* negociar;
* proteger;
* dispersar;
* arrestar;
* ignorar;
* resolver causa.

---

<a id="src-dynamic-missions-and-emergent-events--31-familia-contrainsurgencia"></a>
### 31. Familia CONTRAINSURGENCIA

<a id="src-dynamic-missions-and-emergent-events--variantes-10"></a>
#### Variantes

* patrulla;
* registro;
* red de informantes;
* operación selectiva;
* control de carretera;
* protección comunitaria;
* búsqueda de caché;
* captura de célula.

<a id="src-dynamic-missions-and-emergent-events--riesgo-1"></a>
#### Riesgo

Un éxito táctico puede aumentar la insurgencia si:

* existen abusos;
* daños;
* detenciones indiscriminadas;
* falsos positivos.

---

<a id="src-dynamic-missions-and-emergent-events--32-familia-guerrilla-e-insurgencia"></a>
### 32. Familia GUERRILLA E INSURGENCIA

Utilizada cuando el jugador coopera con FIA o cuando una fuerza nativa ofrece operación irregular.

<a id="src-dynamic-missions-and-emergent-events--variantes-11"></a>
#### Variantes

* emboscada;
* sabotaje;
* infiltración;
* propaganda;
* rescate;
* robo de armas;
* asesinato selectivo;
* liberación de prisioneros.

<a id="src-dynamic-missions-and-emergent-events--diferencia-fia"></a>
#### Diferencia FIA

La misión debe priorizar:

* sorpresa;
* retirada;
* información local;
* bajo consumo;
* evitar combate prolongado.

---

<a id="src-dynamic-missions-and-emergent-events--33-familia-artillería-y-defensa-aérea"></a>
### 33. Familia ARTILLERÍA Y DEFENSA AÉREA

<a id="src-dynamic-missions-and-emergent-events--variantes-12"></a>
#### Variantes

* localizar batería;
* observar fuego;
* destruir radar;
* proteger batería;
* reabastecer artillería;
* desplazar sistema AA;
* recuperar misil;
* neutralizar observador.

<a id="src-dynamic-missions-and-emergent-events--consecuencia-1"></a>
#### Consecuencia

Afecta otras misiones:

* apoyo disponible;
* riesgo aéreo;
* control de zona.

---

<a id="src-dynamic-missions-and-emergent-events--34-familia-aérea-y-naval"></a>
### 34. Familia AÉREA Y NAVAL

<a id="src-dynamic-missions-and-emergent-events--aérea"></a>
#### Aérea

* transporte;
* inserción;
* apoyo cercano;
* evacuación;
* reconocimiento;
* intercepción.

<a id="src-dynamic-missions-and-emergent-events--naval"></a>
#### Naval

* desembarco;
* patrulla;
* escolta;
* infiltración;
* rescate;
* sabotaje costero.

<a id="src-dynamic-missions-and-emergent-events--regla-1"></a>
#### Regla

No aparecerán operaciones aéreas si:

* no hay aeronaves;
* la pista está inutilizable;
* no existe combustible;
* la defensa enemiga lo impide.

---

<a id="src-dynamic-missions-and-emergent-events--35-familia-helios-y-argos"></a>
### 35. Familia HELIOS Y ARGOS

<a id="src-dynamic-missions-and-emergent-events--variantes-helios"></a>
#### Variantes Helios

* reparar nodo;
* desconectar nodo;
* recuperar claves;
* auditar registro;
* proteger técnico;
* comparar predicción;
* investigar tráfico.

<a id="src-dynamic-missions-and-emergent-events--variantes-argos"></a>
#### Variantes Argos

* contrainteligencia;
* infiltrado;
* extracción PHAROS;
* evidencia señuelo;
* convoy clandestino;
* falsa bandera;
* defensa de Stratis.

<a id="src-dynamic-missions-and-emergent-events--regla-2"></a>
#### Regla

Las misiones Argos no deben identificarse siempre como tales al comenzar.

---

<a id="src-dynamic-missions-and-emergent-events--36-familia-personajes-y-escuadra"></a>
### 36. Familia PERSONAJES Y ESCUADRA

<a id="src-dynamic-missions-and-emergent-events--variantes-13"></a>
#### Variantes

* miembro herido;
* conflicto;
* deuda personal;
* búsqueda de familiar;
* investigación privada;
* decisión disciplinaria;
* rescate;
* entierro;
* sustitución.

<a id="src-dynamic-missions-and-emergent-events--propósito-2"></a>
#### Propósito

Conectar los sistemas estratégicos con consecuencias humanas.

---

<a id="src-dynamic-missions-and-emergent-events--37-estructura-de-una-plantilla"></a>
### 37. Estructura de una plantilla

Cada plantilla define un problema genérico.

```text
templateId
family
supportedSides
requiredActRange
requiredSectorTypes
requiredWorldStates
forbiddenWorldStates
requiredActors
objectivePatterns
optionalObjectivePatterns
failurePatterns
parameterRules
materializationRules
rewardRules
consequenceRules
dialogueTags
cooldownTags
```

---

<a id="src-dynamic-missions-and-emergent-events--38-instancia-de-misión"></a>
### 38. Instancia de misión

La instancia concreta almacenará:

```text
missionId
templateId
originEventId
requesterId
campaignSide
act
priority
state
offeredAt
softDeadline
hardDeadline
sectorIds
actorIds
forceIds
convoyIds
evidenceIds
objectives
variants
generationSeed
resolution
consequencesApplied
```

---

<a id="src-dynamic-missions-and-emergent-events--39-generación-de-candidatos"></a>
### 39. Generación de candidatos

El generador realizará:

1. Recopilar necesidades.
2. Convertirlas en oportunidades de misión.
3. Buscar familias compatibles.
4. Filtrar plantillas.
5. Verificar recursos y actores.
6. Verificar distancia y carga actual.
7. Aplicar control de repetición.
8. Puntuar candidatos.
9. Seleccionar oferta.
10. Registrar origen causal.

---

<a id="src-dynamic-missions-and-emergent-events--40-puntuación-de-candidatos"></a>
### 40. Puntuación de candidatos

```text
score =
urgency
+ strategicImpact
+ narrativeRelevance
+ playerProximity
+ characterRelevance
+ varietyValue
+ actCompatibility
- repetitionPenalty
- travelBurden
- systemLoad
- conflictWithMainMission
```

<a id="src-dynamic-missions-and-emergent-events--regla-3"></a>
#### Regla

La prioridad del mundo no puede ser completamente reemplazada por la variedad.

Una cabeza de playa bajo ataque continuará siendo más importante que una misión secundaria novedosa.

---

<a id="src-dynamic-missions-and-emergent-events--41-cantidad-máxima-de-misiones-activas"></a>
### 41. Cantidad máxima de misiones activas

Para evitar saturación:

<a id="src-dynamic-missions-and-emergent-events--principales"></a>
#### Principales

```text
1 principal activa
```

<a id="src-dynamic-missions-and-emergent-events--operaciones-estratégicas"></a>
#### Operaciones estratégicas

```text
1–2 activas
```

<a id="src-dynamic-missions-and-emergent-events--emergencias"></a>
#### Emergencias

```text
0–2 activas
```

<a id="src-dynamic-missions-and-emergent-events--investigaciones"></a>
#### Investigaciones

```text
hasta 2 disponibles
```

<a id="src-dynamic-missions-and-emergent-events--personajes-y-civiles"></a>
#### Personajes y civiles

```text
1–3 disponibles
```

El sistema puede conservar necesidades en cola sin convertirlas todas en tareas visibles.

---

<a id="src-dynamic-missions-and-emergent-events--42-fatiga-de-ofertas"></a>
### 42. Fatiga de ofertas

Un personaje no llamará al jugador cada pocos minutos.

Cada emisor tendrá:

```text
lastOfferTime
offerCooldown
activeRequestCount
ignoredRequestCount
```

<a id="src-dynamic-missions-and-emergent-events--consecuencia-2"></a>
#### Consecuencia

Si el jugador ignora repetidamente a un actor:

* puede dejar de solicitar ayuda;
* buscar otra unidad;
* reducir confianza;
* resolver problemas por otros medios.

---

<a id="src-dynamic-missions-and-emergent-events--43-control-de-repetición"></a>
### 43. Control de repetición

Cada misión registrará etiquetas.

Ejemplo:

```text
ESCORT
ROAD
DAY
FIA_AMBUSH
FUEL
NEOCHORI
```

<a id="src-dynamic-missions-and-emergent-events--penalizaciones"></a>
#### Penalizaciones

<a id="src-dynamic-missions-and-emergent-events--mismo-tipo-reciente"></a>
##### Mismo tipo reciente

Penalización alta.

<a id="src-dynamic-missions-and-emergent-events--mismo-sector"></a>
##### Mismo sector

Penalización media.

<a id="src-dynamic-missions-and-emergent-events--mismo-enemigo"></a>
##### Mismo enemigo

Penalización media.

<a id="src-dynamic-missions-and-emergent-events--misma-estructura-de-objetivos"></a>
##### Misma estructura de objetivos

Penalización alta.

<a id="src-dynamic-missions-and-emergent-events--contexto-narrativo-diferente"></a>
##### Contexto narrativo diferente

Reduce penalización.

---

<a id="src-dynamic-missions-and-emergent-events--44-memoria-de-contenido"></a>
### 44. Memoria de contenido

El sistema registrará:

* últimas familias jugadas;
* últimos sectores;
* últimos emisores;
* últimos objetivos;
* métodos usados;
* resultados.

<a id="src-dynamic-missions-and-emergent-events--ejemplo-3"></a>
#### Ejemplo

Si las últimas dos operaciones fueron convoyes:

La siguiente necesidad logística puede convertirse en:

* despejar ruta;
* capturar depósito;
* reparar puente;
* realizar transporte aéreo.

---

<a id="src-dynamic-missions-and-emergent-events--45-variación-estructural"></a>
### 45. Variación estructural

Una plantilla podrá modificar:

* fase inicial;
* orden de objetivos;
* aliado;
* enemigo;
* clima;
* hora;
* ruta;
* método;
* extracción;
* complicación.

<a id="src-dynamic-missions-and-emergent-events--ejemplo-recuperar-dron"></a>
#### Ejemplo: recuperar dron

<a id="src-dynamic-missions-and-emergent-events--variante-a"></a>
##### Variante A

Dron intacto en territorio enemigo.

<a id="src-dynamic-missions-and-emergent-events--variante-b"></a>
##### Variante B

Civiles lo encontraron.

<a id="src-dynamic-missions-and-emergent-events--variante-c"></a>
##### Variante C

FIA lo vende.

<a id="src-dynamic-missions-and-emergent-events--variante-d"></a>
##### Variante D

Argos colocó datos señuelo.

<a id="src-dynamic-missions-and-emergent-events--variante-e"></a>
##### Variante E

El dron cayó cerca de una patrulla Roja.

---

<a id="src-dynamic-missions-and-emergent-events--46-complicaciones"></a>
### 46. Complicaciones

Una misión puede tener una complicación principal.

<a id="src-dynamic-missions-and-emergent-events--militares"></a>
#### Militares

* refuerzo;
* minas;
* artillería;
* comandante enemigo.

<a id="src-dynamic-missions-and-emergent-events--logísticas"></a>
#### Logísticas

* vehículo averiado;
* ruta cortada;
* carga incompatible.

<a id="src-dynamic-missions-and-emergent-events--civiles"></a>
#### Civiles

* desplazados;
* trabajadores;
* hospital;
* protesta.

<a id="src-dynamic-missions-and-emergent-events--investigativas"></a>
#### Investigativas

* evidencia falsa;
* infiltrado;
* testigo asustado.

<a id="src-dynamic-missions-and-emergent-events--personales"></a>
#### Personales

* miembro herido;
* desobediencia;
* rivalidad.

<a id="src-dynamic-missions-and-emergent-events--regla-4"></a>
#### Regla

No se añadirán complicaciones únicamente para alargar.

Deben cambiar la decisión.

---

<a id="src-dynamic-missions-and-emergent-events--47-complicaciones-dinámicas-durante-ejecución"></a>
### 47. Complicaciones dinámicas durante ejecución

Pueden activarse por:

* tiempo;
* detección;
* bajas;
* destrucción;
* abandono de ruta;
* intervención del jugador.

<a id="src-dynamic-missions-and-emergent-events--ejemplo-4"></a>
#### Ejemplo

Un reconocimiento discreto se convierte en persecución solamente si el jugador es detectado.

No ocurrirá siempre mediante un trigger fijo.

---

<a id="src-dynamic-missions-and-emergent-events--48-objetivos-opcionales"></a>
### 48. Objetivos opcionales

Deben modificar el mundo.

Ejemplos:

* proteger trabajadores;
* capturar oficial;
* recuperar evidencia;
* evitar destruir puente;
* evacuar heridos;
* conservar vehículo.

<a id="src-dynamic-missions-and-emergent-events--prohibición"></a>
#### Prohibición

No utilizar objetivos opcionales sin consecuencia real únicamente para otorgar una medalla.

---

<a id="src-dynamic-missions-and-emergent-events--49-recompensas"></a>
### 49. Recompensas

No existirán recompensas abstractas desconectadas.

<a id="src-dynamic-missions-and-emergent-events--recompensas-militares"></a>
#### Recompensas militares

* recursos;
* vehículo;
* apoyo;
* fuerza disponible;
* sector.

<a id="src-dynamic-missions-and-emergent-events--políticas"></a>
#### Políticas

* confianza;
* legitimidad;
* cooperación.

<a id="src-dynamic-missions-and-emergent-events--investigativas-1"></a>
#### Investigativas

* evidencia;
* conclusión;
* acceso.

<a id="src-dynamic-missions-and-emergent-events--personales-1"></a>
#### Personales

* lealtad;
* supervivencia;
* diálogo;
* sucesión.

<a id="src-dynamic-missions-and-emergent-events--autoridad"></a>
#### Autoridad

* permiso;
* rango;
* capacidad de mando.

---

<a id="src-dynamic-missions-and-emergent-events--50-costes"></a>
### 50. Costes

Una misión exitosa puede costar:

* munición;
* combustible;
* hombres;
* tiempo;
* legitimidad;
* relación.

<a id="src-dynamic-missions-and-emergent-events--principio"></a>
#### Principio

El éxito no debe devolver automáticamente más recursos de los consumidos.

Algunas operaciones son necesarias aunque sean costosas.

---

<a id="src-dynamic-missions-and-emergent-events--51-resolución-fuera-de-pantalla"></a>
### 51. Resolución fuera de pantalla

Cuando el jugador no participa, el sistema selecciona:

* fuerza sustituta;
* capacidad;
* información;
* tiempo;
* riesgo.

<a id="src-dynamic-missions-and-emergent-events--resultado"></a>
#### Resultado

```text
OFFSCREEN_SUCCESS
OFFSCREEN_PARTIAL
OFFSCREEN_FAILURE
OFFSCREEN_DISASTER
```

<a id="src-dynamic-missions-and-emergent-events--factores"></a>
#### Factores

* fuerza asignada;
* comandante;
* suministro;
* amenaza;
* dificultad;
* infiltración.

---

<a id="src-dynamic-missions-and-emergent-events--52-participación-indirecta-del-jugador"></a>
### 52. Participación indirecta del jugador

El jugador puede no ir personalmente y aun influir mediante:

* asignar unidad;
* enviar recursos;
* elegir ruta;
* autorizar apoyo;
* ordenar retirada.

<a id="src-dynamic-missions-and-emergent-events--resultado-1"></a>
#### Resultado

Permite ejercer mando sin convertir todas las operaciones en misiones tácticas.

---

<a id="src-dynamic-missions-and-emergent-events--53-ignorar-una-misión"></a>
### 53. Ignorar una misión

Ignorar no significa siempre desobedecer.

Puede significar:

* priorizar otra crisis;
* no disponer de tiempo;
* rechazar una solicitud opcional.

<a id="src-dynamic-missions-and-emergent-events--consecuencias"></a>
#### Consecuencias

Dependen de:

* autoridad del emisor;
* urgencia;
* relación;
* resultado externo.

---

<a id="src-dynamic-missions-and-emergent-events--54-rechazar-una-orden-directa"></a>
### 54. Rechazar una orden directa

Puede producir:

* sanción;
* sustitución;
* pérdida de confianza;
* conflicto;
* misión asignada a otra unidad.

<a id="src-dynamic-missions-and-emergent-events--diferencia-1"></a>
#### Diferencia

Rechazar una petición civil no equivale a desobedecer a un comandante.

---

<a id="src-dynamic-missions-and-emergent-events--55-cancelación"></a>
### 55. Cancelación

Una misión puede cancelarse por:

* objetivo destruido;
* actor muerto;
* sector cambiado;
* tratado;
* ruta imposible;
* acto avanzado.

<a id="src-dynamic-missions-and-emergent-events--resultado-2"></a>
#### Resultado

Debe registrar:

* causa;
* consecuencias;
* recursos comprometidos.

---

<a id="src-dynamic-missions-and-emergent-events--56-misiones-encadenadas"></a>
### 56. Misiones encadenadas

Una cadena tendrá máximo habitual de:

```text
2–4 misiones
```

<a id="src-dynamic-missions-and-emergent-events--ejemplo-logístico"></a>
#### Ejemplo logístico

1. Reconocer ruta.
2. Escoltar convoy.
3. Recuperar carga.
4. Atacar depósito captor.

<a id="src-dynamic-missions-and-emergent-events--regla-5"></a>
#### Regla

No toda cadena debe completarse.

Puede ramificarse según resultados.

---

<a id="src-dynamic-missions-and-emergent-events--57-arcos-emergentes"></a>
### 57. Arcos emergentes

Varias misiones pueden formar una historia no escrita previamente.

<a id="src-dynamic-missions-and-emergent-events--ejemplo-5"></a>
#### Ejemplo

1. El jugador salva a una médica.
2. La médica administra un hospital.
3. El hospital protege a soldados enemigos.
4. Un comandante exige arrestarla.
5. La población protesta.
6. FIA la ayuda a escapar.

Cada paso surge del estado y de relaciones persistentes.

---

<a id="src-dynamic-missions-and-emergent-events--58-eventos-emergentes-civiles"></a>
### 58. Eventos emergentes civiles

<a id="src-dynamic-missions-and-emergent-events--categorías"></a>
#### Categorías

* escasez;
* desplazamiento;
* epidemia;
* funeral;
* protesta;
* saqueo;
* huelga;
* colaboración;
* denuncia;
* mercado negro.

<a id="src-dynamic-missions-and-emergent-events--conversión-a-misión"></a>
#### Conversión a misión

Solo cuando:

* existe decisión;
* el jugador puede influir;
* el impacto es relevante.

---

<a id="src-dynamic-missions-and-emergent-events--59-eventos-emergentes-militares"></a>
### 59. Eventos emergentes militares

* contraataque;
* retirada;
* motín;
* rendición;
* deserción;
* fuego amigo;
* pérdida de comunicaciones;
* comandante muerto;
* munición agotada.

---

<a id="src-dynamic-missions-and-emergent-events--60-eventos-emergentes-logísticos"></a>
### 60. Eventos emergentes logísticos

* avería;
* contaminación;
* puente destruido;
* depósito incendiado;
* puerto bloqueado;
* pista dañada;
* huelga de trabajadores.

---

<a id="src-dynamic-missions-and-emergent-events--61-eventos-emergentes-políticos"></a>
### 61. Eventos emergentes políticos

* decreto;
* acusación;
* golpe;
* destitución;
* negociación;
* filtración;
* cambio de alianza;
* declaración municipal.

---

<a id="src-dynamic-missions-and-emergent-events--62-eventos-de-argos"></a>
### 62. Eventos de Argos

Argos evaluará:

* exposición;
* equilibrio;
* amenaza a Stratis;
* infiltrados;
* divergencia del jugador.

<a id="src-dynamic-missions-and-emergent-events--posibles-eventos"></a>
#### Posibles eventos

* archivo trasladado;
* testigo desaparecido;
* orden retrasada;
* convoy redirigido;
* falsa bandera;
* infiltrado activa protocolo;
* Meridian refuerza acceso.

---

<a id="src-dynamic-missions-and-emergent-events--63-presupuesto-de-intervención-argos"></a>
### 63. Presupuesto de intervención Argos

Los eventos Argos consumen:

```text
interventionCapacity
```

<a id="src-dynamic-missions-and-emergent-events--coste-bajo"></a>
#### Coste bajo

* retraso;
* clasificación;
* rumor.

<a id="src-dynamic-missions-and-emergent-events--coste-medio"></a>
#### Coste medio

* robo;
* sabotaje;
* extracción.

<a id="src-dynamic-missions-and-emergent-events--coste-alto"></a>
#### Coste alto

* asesinato;
* falsa bandera grande;
* despliegue Meridian.

<a id="src-dynamic-missions-and-emergent-events--consecuencia-3"></a>
#### Consecuencia

Argos no puede intervenir en todos los problemas.

---

<a id="src-dynamic-missions-and-emergent-events--64-eventos-programados-y-eventos-sistémicos"></a>
### 64. Eventos programados y eventos sistémicos

<a id="src-dynamic-missions-and-emergent-events--programados"></a>
#### Programados

Necesarios para el canon.

Ejemplos:

* señal de Petrou;
* fragmentación Verde;
* apertura de Stratis.

<a id="src-dynamic-missions-and-emergent-events--sistémicos"></a>
#### Sistémicos

Nacen del estado.

Ejemplos:

* convoy destruido;
* hospital sin energía;
* protesta.

<a id="src-dynamic-missions-and-emergent-events--híbridos"></a>
#### Híbridos

El evento canónico ocurre, pero su forma depende del estado.

Ejemplo:

La fragmentación Verde siempre ocurre.

La región, el detonante y los supervivientes pueden variar.

---

<a id="src-dynamic-missions-and-emergent-events--65-ritmo-narrativo"></a>
### 65. Ritmo narrativo

El generador respetará fases de ritmo.

<a id="src-dynamic-missions-and-emergent-events--intensidad-alta"></a>
#### Intensidad alta

* combate;
* emergencia;
* persecución.

<a id="src-dynamic-missions-and-emergent-events--intensidad-media"></a>
#### Intensidad media

* preparación;
* patrulla;
* logística.

<a id="src-dynamic-missions-and-emergent-events--intensidad-baja"></a>
#### Intensidad baja

* investigación;
* diálogo;
* administración;
* recuperación.

<a id="src-dynamic-missions-and-emergent-events--regla-6"></a>
#### Regla

No ofrecer tres grandes ataques consecutivos salvo colapso real.

---

<a id="src-dynamic-missions-and-emergent-events--66-periodos-de-recuperación"></a>
### 66. Periodos de recuperación

Después de una misión principal grande:

* reducir emergencias no críticas;
* permitir reabastecimiento;
* activar conversaciones;
* ofrecer investigación;
* mostrar consecuencias.

<a id="src-dynamic-missions-and-emergent-events--excepción"></a>
#### Excepción

Una derrota puede impedir descanso.

---

<a id="src-dynamic-missions-and-emergent-events--67-distancia-y-desplazamiento"></a>
### 67. Distancia y desplazamiento

El generador penalizará misiones que exijan atravesar Altis repetidamente sin razón.

<a id="src-dynamic-missions-and-emergent-events--soluciones"></a>
#### Soluciones

* asignar otra unidad;
* resolución externa;
* transporte;
* agrupar operaciones regionales;
* ofrecer misiones cerca del frente del jugador.

---

<a id="src-dynamic-missions-and-emergent-events--68-regiones-operativas"></a>
### 68. Regiones operativas

El jugador normalmente tendrá una región primaria activa.

<a id="src-dynamic-missions-and-emergent-events--contenido-visible"></a>
#### Contenido visible

* frente principal;
* 1–2 problemas secundarios;
* información nacional resumida.

<a id="src-dynamic-missions-and-emergent-events--ventaja-1"></a>
#### Ventaja

Mantiene coherencia y rendimiento.

---

<a id="src-dynamic-missions-and-emergent-events--69-materialización"></a>
### 69. Materialización

Una misión dinámica no colocará toda la guerra físicamente.

Toda materialización reserva activos reales y crea una proyección vinculada a su formación según [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system). El director solicita contenido; no crea soldados o vehículos directamente.

<a id="src-dynamic-missions-and-emergent-events--antes-de-comenzar"></a>
#### Antes de comenzar

Se materializan:

* fuerzas implicadas;
* objetivos;
* composiciones;
* civiles relevantes;
* vehículos.

<a id="src-dynamic-missions-and-emergent-events--durante"></a>
#### Durante

Se pueden añadir:

* refuerzos;
* QRF;
* eventos.

<a id="src-dynamic-missions-and-emergent-events--después-2"></a>
#### Después

Se reintegran:

* bajas;
* recursos;
* daños;
* vehículos;
* control.

---

<a id="src-dynamic-missions-and-emergent-events--70-persistencia-durante-misión"></a>
### 70. Persistencia durante misión

Debe guardarse:

* estado de objetivos;
* fuerzas;
* vehículos importantes;
* evidencia;
* consecuencias parciales.

<a id="src-dynamic-missions-and-emergent-events--no-es-necesario-guardar"></a>
#### No es necesario guardar

* cada proyectil;
* cada posición exacta de enemigo genérico;
* cada waypoint temporal.

---

<a id="src-dynamic-missions-and-emergent-events--71-misión-interrumpida-por-guardado"></a>
### 71. Misión interrumpida por guardado

Al cargar:

* reconstruir fase;
* restaurar activos;
* evitar duplicar recompensas;
* conservar bajas registradas;
* restaurar objetivos.

---

<a id="src-dynamic-missions-and-emergent-events--72-semillas-de-generación"></a>
### 72. Semillas de generación

Cada misión tendrá:

```text
generationSeed
```

Permite:

* reproducir problemas;
* depurar;
* reconstruir variante.

<a id="src-dynamic-missions-and-emergent-events--no-implica"></a>
#### No implica

Que toda IA táctica actúe exactamente igual.

---

<a id="src-dynamic-missions-and-emergent-events--73-misiones-en-cooperativo-futuro"></a>
### 73. Misiones en cooperativo futuro

El servidor:

* genera;
* valida;
* asigna;
* persiste;
* resuelve.

Los jugadores pueden votar:

* aceptación;
* prioridad;
* método;
* asignación.

<a id="src-dynamic-missions-and-emergent-events--regla-7"></a>
#### Regla

Una misión no se duplicará para cada cliente.

---

<a id="src-dynamic-missions-and-emergent-events--74-plantilla-de-ejemplo-convoy-crítico"></a>
### 74. Plantilla de ejemplo — Convoy crítico

```text
Template:
TPL_LOGISTICS_CRITICAL_CONVOY

Origen:
Déficit crítico en un sector

Variantes:
- escolta
- despeje
- contraemboscada
- ruta alternativa

Requisitos:
- origen con recurso
- destino conectado
- vehículos disponibles
- amenaza superior a mínimo

Resultados:
- carga completa
- carga parcial
- pérdida
- captura
```

---

<a id="src-dynamic-missions-and-emergent-events--75-ejemplo-azul-combustible-para-lakka"></a>
### 75. Ejemplo Azul — Combustible para Lakka

<a id="src-dynamic-missions-and-emergent-events--estado"></a>
#### Estado

* Lakka P1;
* combustible crítico;
* Katalaki posee reserva;
* Neochori estable;
* ataques FIA en ruta secundaria.

<a id="src-dynamic-missions-and-emergent-events--opciones-generadas"></a>
#### Opciones generadas

1. Convoy pesado por carretera principal.
2. Dos convoyes ligeros.
3. Capturar depósito Verde.
4. Transporte aéreo limitado.
5. Racionar y cancelar ofensiva.

<a id="src-dynamic-missions-and-emergent-events--misión-ofrecida"></a>
#### Misión ofrecida

Rourke propone despejar la ruta principal.

Laurent advierte que atraviesa una zona de desplazados.

La misión combina:

* logística;
* civil;
* riesgo de emboscada.

---

<a id="src-dynamic-missions-and-emergent-events--76-ejemplo-rojo-apertura-de-sofia"></a>
### 76. Ejemplo Rojo — Apertura de Sofia

<a id="src-dynamic-missions-and-emergent-events--estado-1"></a>
#### Estado

* convoyes acumulados en Molos;
* Sofia neutral;
* Vahid exige paso;
* unidad Verde local dividida.

<a id="src-dynamic-missions-and-emergent-events--misión-1"></a>
#### Misión

Negociar o preparar ruptura.

<a id="src-dynamic-missions-and-emergent-events--variantes-14"></a>
#### Variantes

* reunión;
* infiltración;
* ultimátum;
* asalto.

<a id="src-dynamic-missions-and-emergent-events--consecuencias-1"></a>
#### Consecuencias

La misma necesidad logística puede resolverse de formas políticas o militares.

---

<a id="src-dynamic-missions-and-emergent-events--77-ejemplo-verde-retirada-de-aeropuerto"></a>
### 77. Ejemplo Verde — Retirada de aeropuerto

<a id="src-dynamic-missions-and-emergent-events--estado-2"></a>
#### Estado

* Airport West amenazado;
* combustible y técnicos presentes;
* Varos ordena conservar personal;
* Sarris ordena defender.

<a id="src-dynamic-missions-and-emergent-events--oferta-al-jugador"></a>
#### Oferta al jugador

Según campaña:

<a id="src-dynamic-missions-and-emergent-events--azul"></a>
##### Azul

Interceptar evacuación.

<a id="src-dynamic-missions-and-emergent-events--rojo"></a>
##### Rojo

Proteger o capturar técnicos.

<a id="src-dynamic-missions-and-emergent-events--aliado-verde"></a>
##### Aliado Verde

Abrir corredor.

---

<a id="src-dynamic-missions-and-emergent-events--78-ejemplo-fia-el-almacén-de-armas"></a>
### 78. Ejemplo FIA — El almacén de armas

<a id="src-dynamic-missions-and-emergent-events--estado-3"></a>
#### Estado

* guarnición Verde abandona pueblo;
* depósito parcialmente intacto;
* Kallas quiere capturarlo;
* Markou teme militarización.

<a id="src-dynamic-missions-and-emergent-events--opciones"></a>
#### Opciones

* entregar armas a FIA;
* destruir;
* registrar con municipio;
* ocultar;
* permitir que Verde las recupere.

---

<a id="src-dynamic-missions-and-emergent-events--79-plantillas-mínimas-del-vertical-slice"></a>
### 79. Plantillas mínimas del vertical slice

La primera biblioteca dinámica tendrá:

1. Reconocimiento de ruta.
2. Reconocimiento de sector.
3. Defensa de puesto.
4. Contraataque.
5. Escolta de convoy.
6. Reacción a emboscada.
7. Recuperación de vehículo.
8. Evacuación de heridos.
9. Protección civil.
10. Captura de prisionero.
11. Investigación de transmisión.
12. Sabotaje de comunicaciones.

---

<a id="src-dynamic-missions-and-emergent-events--80-variantes-mínimas-por-plantilla"></a>
### 80. Variantes mínimas por plantilla

Cada plantilla del vertical slice deberá tener:

* 2 localizaciones;
* 2 composiciones enemigas;
* 2 complicaciones;
* 2 resultados parciales;
* 1 transformación por expiración.

No significa combinar todo aleatoriamente.

Significa disponer de suficiente variación validada.

---

<a id="src-dynamic-missions-and-emergent-events--81-estado-del-generador"></a>
### 81. Estado del generador

```sqf
IF_missionDirector = createHashMapFromArray [
    ["activeMainMissionId", ""],
    ["activeOperationIds", []],
    ["activeEmergencyIds", []],
    ["availableInvestigationIds", []],
    ["queuedNeeds", []],
    ["recentMissionTags", []],
    ["emitterCooldowns", createHashMap],
    ["regionActivity", createHashMap],
    ["globalPacingState", "MEDIUM"]
];
```

---

<a id="src-dynamic-missions-and-emergent-events--82-modelo-de-necesidad"></a>
### 82. Modelo de necesidad

```sqf
IF_need = createHashMapFromArray [
    ["id", "NEED_BLUE_LAKKA_FUEL"],
    ["type", "LOGISTICS_DEFICIT"],
    ["originSystem", "ECONOMY"],
    ["requesterId", "CHAR_BLUE_ROURKE"],
    ["sectorId", "ALT_CW_LAKKA"],
    ["priority", "URGENT"],
    ["createdAt", 1040],
    ["softDeadline", 1160],
    ["hardDeadline", 1280],
    ["requiredResource", "FUEL"],
    ["requiredAmount", 24],
    ["ignoredOutcome", "OFFENSIVE_DELAYED"],
    ["resolved", false]
];
```

---

<a id="src-dynamic-missions-and-emergent-events--83-modelo-de-misión-dinámica"></a>
### 83. Modelo de misión dinámica

```sqf
IF_dynamicMission = createHashMapFromArray [
    ["id", "DYN_BLUE_A03_014"],
    ["templateId", "TPL_LOGISTICS_CONVOY_ESCORT"],
    ["originNeedId", "NEED_BLUE_LAKKA_FUEL"],
    ["campaignSide", "BLUE"],
    ["actId", "ACT_III"],

    ["requesterId", "CHAR_BLUE_ROURKE"],
    ["priority", "URGENT"],
    ["state", "OFFERED"],

    ["sectorIds", [
        "ALT_CW_NEOCHORI",
        "ALT_CW_STAVROS_WHISKEY",
        "ALT_CW_LAKKA"
    ]],

    ["objectiveStates", createHashMap],
    ["optionalObjectiveStates", createHashMap],
    ["variantTags", [
        "ROAD",
        "FUEL",
        "FIA_THREAT"
    ]],

    ["softDeadline", 1160],
    ["hardDeadline", 1280],
    ["generationSeed", 482114],
    ["consequencesApplied", false]
];
```

---

<a id="src-dynamic-missions-and-emergent-events--84-funciones-conceptuales"></a>
### 84. Funciones conceptuales

```text
IF_fnc_needCreate
IF_fnc_needUpdate
IF_fnc_needResolve
IF_fnc_missionDirectorTick
IF_fnc_missionGenerateCandidates
IF_fnc_missionFilterTemplates
IF_fnc_missionScoreCandidate
IF_fnc_missionInstantiate
IF_fnc_missionOffer
IF_fnc_missionTransform
IF_fnc_missionExpire
IF_fnc_missionResolve
IF_fnc_missionResolveOffscreen
IF_fnc_missionApplyConsequences
IF_fnc_eventCreateEmergent
IF_fnc_eventEvaluateMissionConversion
IF_fnc_pacingEvaluate
IF_fnc_repetitionCalculatePenalty
```

---

<a id="src-dynamic-missions-and-emergent-events--85-validaciones-antes-de-ofrecer"></a>
### 85. Validaciones antes de ofrecer

La misión no se ofrece si:

* el actor está muerto;
* el sector ya cambió;
* el objetivo no existe;
* no hay ruta;
* otra misión usa el mismo activo;
* el jugador no posee autoridad;
* la plantilla no está validada;
* el acto la prohíbe;
* no puede generar consecuencias coherentes.

La comprobación de autoridad, reputación, capacidad y disponibilidad del jugador utiliza [PLAYER_PROGRESSION_AUTHORITY_AND_UNLOCKS_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-progression-authority-and-unlocks-system); una misión nunca concede por sí sola recursos o autoridad no existentes.

---

<a id="src-dynamic-missions-and-emergent-events--86-validación-durante-ejecución"></a>
### 86. Validación durante ejecución

El sistema debe detectar:

* objetivo destruido por otra fuerza;
* sector capturado externamente;
* actor muerto;
* tratado firmado;
* convoy desviado;
* jugador abandona zona.

<a id="src-dynamic-missions-and-emergent-events--respuesta"></a>
#### Respuesta

* adaptar;
* completar parcialmente;
* cancelar;
* transformar.

---

<a id="src-dynamic-missions-and-emergent-events--87-validación-posterior"></a>
### 87. Validación posterior

Antes de aplicar consecuencias:

* verificar objetivos;
* contar supervivientes;
* registrar carga;
* resolver propiedad;
* actualizar relaciones;
* comprobar que no se aplicó antes.

---

<a id="src-dynamic-missions-and-emergent-events--88-pruebas-obligatorias"></a>
### 88. Pruebas obligatorias

<a id="src-dynamic-missions-and-emergent-events--prueba-1-causalidad"></a>
#### Prueba 1 — Causalidad

Verificar que cada misión tenga una necesidad real.

<a id="src-dynamic-missions-and-emergent-events--prueba-2-repetición"></a>
#### Prueba 2 — Repetición

Generar veinte misiones y revisar patrones.

<a id="src-dynamic-missions-and-emergent-events--prueba-3-expiración"></a>
#### Prueba 3 — Expiración

Ignorar misión y comprobar transformación.

<a id="src-dynamic-missions-and-emergent-events--prueba-4-resolución-externa"></a>
#### Prueba 4 — Resolución externa

Asignar otra unidad.

<a id="src-dynamic-missions-and-emergent-events--prueba-5-cambio-de-sector"></a>
#### Prueba 5 — Cambio de sector

Capturar objetivo antes de aceptar.

<a id="src-dynamic-missions-and-emergent-events--prueba-6-actor-muerto"></a>
#### Prueba 6 — Actor muerto

Eliminar emisor.

<a id="src-dynamic-missions-and-emergent-events--prueba-7-guardado"></a>
#### Prueba 7 — Guardado

Guardar durante misión dinámica.

<a id="src-dynamic-missions-and-emergent-events--prueba-8-materialización"></a>
#### Prueba 8 — Materialización

Comprobar que no duplica fuerzas.

<a id="src-dynamic-missions-and-emergent-events--prueba-9-recompensas"></a>
#### Prueba 9 — Recompensas

Evitar duplicación.

<a id="src-dynamic-missions-and-emergent-events--prueba-10-pacing"></a>
#### Prueba 10 — Pacing

Verificar alternancia de intensidad.

---

<a id="src-dynamic-missions-and-emergent-events--89-criterios-de-calidad"></a>
### 89. Criterios de calidad

Una misión dinámica será aceptable si:

1. Tiene origen claro.
2. Cambia el estado.
3. Puede fallar parcialmente.
4. Puede ser ignorada.
5. Posee consecuencias.
6. Utiliza recursos existentes.
7. No repite exactamente una misión reciente.
8. Es compatible con el acto.
9. Respeta la geografía.
10. Respeta las relaciones.
11. Puede resolverse fuera de pantalla.
12. No depende de enemigos infinitos.
13. No necesita una recompensa artificial.
14. Puede explicar por qué el jugador fue seleccionado.
15. Su variante está validada.

---

<a id="src-dynamic-missions-and-emergent-events--90-errores-que-deben-evitarse"></a>
### 90. Errores que deben evitarse

1. Misiones aleatorias sin causa.
2. Enemigos creados sin reserva estratégica.
3. Convoyes sin recurso real.
4. Sectores capturados sin consecuencias.
5. Ofertas ilimitadas.
6. Emergencias permanentes.
7. Misma emboscada repetida.
8. Misiones que caducan sin efecto.
9. Civiles usados solo como decoración.
10. Investigación reducida a recoger objetos.
11. Actores muertos ofreciendo misiones.
12. Misiones incompatibles con tratados.
13. Recompensas duplicadas.
14. Guardados que reinician objetivos.
15. Cambiar objetivos arbitrariamente.
16. Complicaciones sin causa.
17. Tiempos artificiales injustificados.
18. Viajes largos sin contenido.
19. Resolver todo mediante combate.
20. Argos interviniendo en cada misión.

---

<a id="src-dynamic-missions-and-emergent-events--91-principios-obligatorios"></a>
### 91. Principios obligatorios

1. Cada misión nace de una necesidad.
2. Cada necesidad pertenece a un sistema.
3. Cada misión tiene un emisor o causa.
4. Cada misión cambia el estado.
5. Ignorarla produce consecuencias.
6. Expirar puede transformarla.
7. Las misiones pueden resolverse externamente.
8. El jugador no realiza todo personalmente.
9. El mundo continúa.
10. La variedad procede de contexto y estructura.
11. El azar no sustituye causalidad.
12. Los recursos utilizados existen.
13. Las fuerzas utilizadas existen.
14. Los actores utilizados están vivos.
15. La geografía limita.
16. La política limita.
17. La logística limita.
18. Las relaciones modifican ofertas.
19. Las investigaciones modifican variantes.
20. Argos tiene capacidad limitada.
21. Los objetivos opcionales importan.
22. El fracaso parcial es válido.
23. Las misiones principales tienen prioridad.
24. El ritmo debe alternar.
25. La interfaz no debe saturar.
26. Las misiones dinámicas no sustituyen actos.
27. Los actos no ignoran la guerra dinámica.
28. Las cadenas emergentes deben conservar memoria.
29. El servidor será autoridad futura.
30. El generador debe registrar por qué creó cada misión.

---

<a id="src-dynamic-missions-and-emergent-events--92-definición-final"></a>
### 92. Definición final

Las misiones dinámicas de Islas Fracturadas no existirán para mantener ocupado al jugador entre capítulos.

Existirán porque:

* una carretera fue cortada;
* un comandante perdió una reserva;
* una ciudad se quedó sin agua;
* una guarnición recibió una orden contradictoria;
* un técnico intentó escapar;
* un convoy transportaba suministros para alguien oficialmente muerto;
* una decisión anterior dejó un problema sin resolver.

El sistema no preguntará primero:

> ¿Qué tipo de misión toca ahora?

Preguntará:

> ¿Qué necesita el mundo, quién puede pedirlo y qué precio tendrá no resolverlo?

> **Una misión dinámica no es contenido aleatorio. Es una consecuencia que todavía permite intervención.**

> **Cuando el jugador no acuda, el problema no desaparecerá. Otra persona lo resolverá, fracasará o convertirá ese problema en uno nuevo.**

> **La variedad no surgirá de cambiar enemigos y coordenadas. Surgirá de cambiar causas, restricciones, personas, riesgos y consecuencias.**

<a id="src-dynamic-missions-and-emergent-events--estado-actualizado"></a>
#### Estado actualizado

El [Documento 4/14](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-civil-municipal-political-stability-system) define cómo una fuerza pasa de ocupar un sector a gobernarlo y cómo reaccionan las comunidades.

El [Documento 5/14](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-fia-insurgency-and-clandestine-war-system) fija el sistema de FIA, insurgencia y guerra clandestina.

El [Documento 6/14](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-helios-intelligence-and-fog-of-war-system) fija Helios, inteligencia y niebla de guerra.

El [Documento 7/14](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system) fija táctica y virtualización de fuerzas.

El [Documento 8/14](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-progression-authority-and-unlocks-system) fija progresión, autoridad y desbloqueos.

El [Documento 9/14](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system) fija la presentación de misiones, operaciones, emergencias, alertas, consecuencias y resultados.

El [Documento 10/14](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture) fija la API modular, condiciones y efectos declarativos, eventos idempotentes, persistencia y pruebas de las misiones.

El [Documento 11/14](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide) fija rutas, zonas, anclajes, puntos de materialización y escenarios físicos donde pueden surgir misiones y emergencias.

El [Documento 12/14](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system) fija briefings, debriefings, variantes, comunicaciones, interrupciones y memoria narrativa de las misiones dinámicas.

El [Documento 13/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system) fija causalidad, generación, delegación, expiración, transformación, repetición y balance de misiones.

El [Documento 14/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan) fija orden, alcance, entregables y puertas para implementar misiones y eventos. La colección rectora queda completa.
