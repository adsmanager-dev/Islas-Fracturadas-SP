# Sistema estratégico general de campaña

> La implementación de este diseño debe utilizar el contrato autoritativo de [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).
> La evaluación de comandantes, planes y órdenes se concreta en [STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md](STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md).

> **Versión:** 1.0  
> **Estado:** canon de diseño propuesto  
> **Modalidad inicial:** campaña individual  
> **Modalidad futura:** cooperativo de un solo bando  
> **Bandos jugables:** Fuerza Azul o Fuerza Roja  
> **IA:** invasor contrario, Gobierno, Verde, FIA, guerrillas, insurgencia y civiles  
>
> Este documento integra los sistemas descritos en la [Biblia Narrativa](STORY_BIBLE.md), [Helios y Argos](HELIOS_ARGOS.md), las [fuerzas invasoras](INVADING_FORCES.md), el [sistema militar y orden de batalla](MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md), el [sistema territorial, de frentes y construcción](TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md), el [sistema económico y logístico](ECONOMIC_AND_LOGISTICS_SYSTEM.md), los [actores nativos](NATIVE_ACTORS_AND_SECTORS.md), la [unidad jugable](PLAYER_UNIT_AND_PROGRESSION.md) y las [comunidades civiles](CIVILIANS_MUNICIPALITIES_AND_SOCIAL_SYSTEMS.md).
>
> Su implementación narrativa y técnica se concreta en [NARRATIVE_ACTS_AND_MISSION_SYSTEM.md](NARRATIVE_ACTS_AND_MISSION_SYSTEM.md).

## 1. Propósito

El sistema representa una guerra que continúa independientemente de la posición del jugador.

Controla territorio, frentes, fuerzas, logística, información, infraestructura, política, población, actividad irregular, Helios, decisiones de mando, narrativa y condiciones de desenlace.

El jugador influye profundamente, pero no controla todos los actores.

> La campaña no consiste solamente en conquistar sectores.

Una fuerza necesita ocupar, abastecer, defender, gobernar, obtener información, conservar legitimidad y sobrevivir a la reacción de los demás.

## 2. Perspectiva

Cada partida utiliza una perspectiva jugable:

* En Azul, Rojo y todos los actores nativos son IA.
* En Rojo, Azul y todos los actores nativos son IA.
* No existen dos bandos humanos simultáneos.
* Los jugadores comparten unidad, recursos, decisiones, territorio, progresión y consecuencias.

## 3. Capas del control territorial

Un sector no se reduce a una bandera.

### Control militar

Quién domina bases, carreteras, alturas, accesos y defensas. Puede ser inexistente, débil, disputado, provisional, consolidado o fortificado.

### Control administrativo

Quién gestiona municipio, registros, policía, distribución, permisos y servicios.

### Control logístico

Quién utiliza regularmente carreteras, depósitos, combustible, talleres, puertos y rutas marítimas o aéreas.

### Control informativo

Quién conoce mejor fuerzas, rutas, población, clandestinidad, depósitos, amenazas y comunicaciones.

### Control político

Quién es reconocido como legítimo: Gobierno, municipio, reformistas, FIA, invasor, mando Verde o autoridad autónoma.

### Control clandestino

Influencia oculta de FIA, guerrillas, radicales, contrabando, inteligencia o Argos.

## 4. Estados territoriales

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

## 5. Tipos de sector

### Urbano

Población, administración, hospitales, comercio e infraestructura. El control civil y político es crítico.

### Rural

Agricultura, rutas secundarias, escondites y población dispersa. Favorece guerrillas.

### Industrial

Combustible, piezas, materiales, energía y transporte.

### Logístico

Depósitos, cruces, puertos, talleres y almacenes.

### Militar

Bases, posiciones, reservas y defensa aérea.

### Helios

Radares, repetidores, comunicaciones, terminales y análisis.

### Estratégico

Aeropuerto, capital, puerto principal, central o instalación de Stratis.

## 6. Conexiones y frentes

Los sectores se conectan mediante carreteras principales y secundarias, rutas marítimas y aéreas, electricidad, comunicaciones y enlaces Helios.

Controlar sectores desconectados no crea un territorio funcional.

Un frente existe cuando sectores hostiles conectados pueden atacarse, reforzarse, bloquearse u observarse. Los frentes cambian dinámicamente.

## 7. Recursos estratégicos

> Las categorías, localización, producción, transferencias y consumo se rigen por [ECONOMIC_AND_LOGISTICS_SYSTEM.md](ECONOMIC_AND_LOGISTICS_SYSTEM.md).

### Personal

Combatientes, tripulaciones, pilotos, ingenieros, sanitarios y logística. Las bajas eliminan capacidades, no solo números.

### Armamento y munición

Armas, explosivos, misiles, artillería y defensa aérea que deben transportarse desde fuentes reales.

### Combustible

Necesario para vehículos, generadores, aviación, transporte y emergencias.

### Vehículos

Persisten como operativos, dañados, en reparación, abandonados, capturados o destruidos.

### Suministros médicos

Afectan supervivencia, recuperación, hospitales, población y legitimidad.

### Materiales

Permiten reparar, construir, fortificar y recuperar infraestructura.

### Información

Reconocimiento, inteligencia humana, señales, archivos, mapas, credenciales y predicciones.

La evidencia investigativa conserva tipo, familia, estado, autenticidad, interpretación, poseedor y destino. No existe una barra única de «verdad»; se acumulan pruebas técnicas, humanas, políticas, operacionales y Argos.

### Legitimidad

Reduce el coste de gobernar y aumenta cooperación, información, reclutamiento y estabilidad.

## 8. Producción y acceso

Los recursos proceden de flotas, depósitos Verdes, industria, puertos, aeródromos, aliados, Gobierno, municipios, FIA, contrabando y capturas.

Capturarlos no implica poder utilizarlos: pueden requerir reparación, técnicos, códigos, transporte, seguridad y cooperación local.

Campos, mandras, cooperativas, pesca, puertos, energía y trabajadores forman la base económica nativa. Su distribución e identidad regional se definen en [ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md](ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md). Ocupar esa infraestructura sin cooperación puede reducir producción, crear desempleo o alimentar insurgencia.

## 9. Logística

Cada unidad necesita una cadena:

1. fuente;
2. depósito;
3. ruta;
4. distribución;
5. receptor.

Emboscadas, sabotaje, puentes destruidos, minas, pérdida de carreteras, clima, huelgas, bloqueos e información falsa pueden interrumpirla.

La falta de suministro reduce munición, movilidad, moral, reparación, agresividad y duración de combate.

## 10. Convoyes

Los convoyes militares, médicos, civiles, mixtos y clandestinos transportan recursos físicamente.

La IA decide ruta, escolta, horario, prioridad, carga y destino.

Helios puede recomendar rutas según amenaza, tráfico, inteligencia, clima y actividad enemiga. Una recomendación manipulada puede salvar, emboscar, desviar recursos o mantener viva a una facción debilitada.

## 11. Construcción y fortificación

> El contrato detallado y autoritativo de capacidades, profundidades, módulos, anclajes y memoria defensiva se encuentra en [TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md](TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md).

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

## 12. Evolución de bases

0. **Presencia temporal:** patrulla sin defensa fija.
1. **Puesto avanzado:** mando, comunicaciones, guarnición pequeña y suministros.
2. **Base de sector:** defensas, depósito, medicina, reparación y reserva.
3. **Base regional:** mando ampliado, fuego de apoyo, defensa aérea, logística y fuerza móvil.
4. **Centro operacional:** reservas, especialistas, coordinación regional y Helios avanzado.

Las bases evolucionan, se degradan, se abandonan, cambian de dueño y conservan daños.

## 13. Guarniciones

Todo sector consolidado necesita guarnición según valor, amenaza, población, clandestinidad y logística.

Defiende, patrulla, controla accesos, reacciona, protege infraestructura y mantiene orden.

Una guarnición excesiva debilita el frente. Una insuficiente favorece sabotaje, insurgencia, reconquista y colapso.

## 14. Información

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

## 15. Helios en la estrategia

Helios recopila, compara, estima, advierte, prioriza, recomienda, filtra y distribuye. No emite órdenes obligatorias.

La finalidad oculta busca conservar el escenario operativo suficiente tiempo para obtener datos, manteniendo varias fuerzas, infraestructura mínima, población, diversidad de decisiones y red parcial.

## 16. Dimensiones de control de Helios

1. **Control físico:** quién ocupa el nodo.
2. **Acceso digital:** quién se autentica o introduce datos.
3. **Integridad:** conexión y funcionamiento.
4. **Confianza:** cuánto cree cada mando en sus resultados.
5. **Infiltración:** accesos ocultos de Argos u otros.

## 17. Acciones sobre nodos

Una facción puede capturar, reparar, conectar, aislar, copiar, cambiar códigos, sabotear, destruir, utilizar parcialmente o transferir un nodo.

Destruirlo puede negar información y, a la vez, afectar hospitales, comunicaciones, observación y población.

## 18. Comandantes de IA

### Azul

Elena Ward, Marcus Hale, Thomas Rourke, Miriam Kessler, Sofia Laurent, Naomi Reyes y la infiltrada Evelyn Shaw.

### Rojo

Darius Navid, Soraya Vahid, Samir Khadem, Kamran Sadeq, Nadir Khoury, Laleh Arman y el infiltrado Rashid Volkov.

### Verde

Leon Varos, Nikos Sarris, Marios Daskal, Thalia Koronis, Elias Petrou y Damian Rallis.

### FIA

Eleni Markou, Petros Kallas, Mara Vellis, dirigentes regionales y células radicales manipuladas mediante la identidad Némesis.

## 19. Variables de mando

Cada comandante evalúa fuerza, suministros, amenazas, oportunidades, bajas, civiles, política, relaciones, información, Helios, jugador, personalidad y objetivos secretos.

Dos comandantes pueden recibir los mismos datos y decidir de forma diferente.

Las relaciones no se reducen a una reputación global. Cada personaje conserva confianza personal, respeto profesional, dependencia, afinidad ideológica, agravio, miedo, conocimiento comprometedor y lealtad afectiva. Los estados, conflictos persistentes y reglas de ruptura se definen en [CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md](CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md).

## 20. Ciclo de decisión

1. **Observar:** reunir información disponible.
2. **Interpretar:** evaluar amenazas, objetivos, riesgos y confianza.
3. **Priorizar:** defender, atacar, abastecer, negociar, retirarse o consolidar.
4. **Planificar:** asignar unidades, rutas, tiempos, reservas y apoyos.
5. **Ejecutar:** transmitir órdenes.
6. **Evaluar:** modificar experiencia, confianza, doctrina y relaciones.

## 21. Decisiones no deterministas

La IA considera personalidad, miedo, ambición, errores, presión, información incompleta, memoria y política; no siempre elige el óptimo matemático.

Hale puede atacar por temor a la consolidación Roja; Ward detenerse por civiles; Vahid comprometer blindados; Navid preservar logística.

Helios registra estas divergencias.

## 22. Jugador y comandantes

El jugador puede obedecer, modificar, retrasar, rechazar, interpretar, informar u ocultar.

Una acción puede aumentar la confianza de un mando y reducir la de otro. Salvar una ciudad puede agradar a Laurent y enfurecer a Hale; proteger Verdes desobedientes puede acercar a Navid y alejar a Vahid.

## 23. Relaciones entre facciones

Los estados posibles son alianza formal, cooperación operacional, tregua, neutralidad, tensión, hostilidad limitada, guerra, subordinación, dependencia e infiltración.

Cada relación registra confianza, interés común, conflicto político, dependencia, agravios y compatibilidad de mando.

Cambian por operaciones, bajas, promesas, recursos, negociaciones, territorios, prisioneros, información, civiles y liderazgo.

Una alianza táctica no elimina conflictos políticos.

## 24. Gobierno y legitimidad

El Gobierno puede conservar reconocimiento, funcionarios, documentos, presupuesto y códigos aunque pierda territorio.

Las fuerzas militares pueden necesitarlo para administrar, legitimar, negociar, activar servicios y usar Helios.

La dependencia puede convertirlo en aliado, títere, autoridad provisional o Gobierno en el exilio.

Autoridad formal, reconocida, efectiva, militar, municipal y clandestina; estados G0–G5; y dimensiones de legitimidad se rigen por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md).

## 25. Fuerza Verde

Registra cohesión, lealtad regional, confianza en Varos, relación gubernamental y Roja, oposición Azul e infiltración.

Se fragmenta gradualmente en Gobierno, soberanistas, reformistas, aliados Rojos, resistencia y unidades aisladas.

## 26. FIA, guerrillas y radicales

FIA registra por región apoyo, fuerza, influencia política, células, información, radicalización y relación con Markou y Kallas.

Puede controlar políticamente sin dominar militarmente.

Las guerrillas surgen por ocupación, derrota Verde, daños y resistencia. Pueden sobrevivir a su facción de origen.

La insurgencia radical crece con miedo, agravios, colapso, represión, armas y falta de alternativas. Argos puede utilizarla sin controlarla.

## 27. Sistema civil

Cada comunidad registra población, necesidades, seguridad, miedo, confianza, legitimidad, radicalización, cohesión, dependencia y memoria.

Puede cooperar, protestar, evacuar, informar, sabotear, formar milicias, apoyar FIA o aceptar ocupación.

El modelo rector separa confianza, apoyo, obediencia y dependencia, y añade servicios, autoridad, administración, agravio, desplazamiento y estabilidad según [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md).

## 28. Ocupación

Ocupar requiere fuerza, guarnición, suministros, administración, información y estabilidad.

* **Ligera:** pocas tropas y cooperación local.
* **Militar:** controles y restricciones.
* **Represiva:** detenciones, vigilancia y miedo.
* **Protectorado:** autoridad local formal con dependencia extranjera.

## 29. Moral y experiencia

La moral depende de bajas, suministros, liderazgo, victorias, derrotas, aislamiento, población, legitimidad e información.

Una moral baja produce lentitud, retirada, desobediencia, rendición o deserción.

Las unidades ganan experiencia en combate, defensa, reconocimiento, ciudad, insurgencia y logística. Una unidad veterana es un recurso persistente; destruirla es una pérdida permanente.

## 30. Prisioneros y heridos

Los prisioneros son información, recurso político, responsabilidad logística y elemento negociador. Pueden ser interrogados, tratados, intercambiados, entregados, liberados, reclutados o procesados.

Los heridos pueden recuperarse, quedar fuera de combate, requerir evacuación o morir por falta de atención.

El trato afecta legitimidad, relaciones, información, moral y conservación de veteranos.

## 31. Infraestructura

Carreteras, puentes, centrales, hospitales, puertos, aeródromos, comunicaciones y depósitos pueden estar operativos, dañados, degradados, destruidos o en reparación.

Una destrucción útil tácticamente puede crear un problema estratégico posterior.

## 32. Clima y tiempo

Afectan visibilidad, aviación, navegación, caminos, sensores, evacuaciones y comunicaciones.

Helios utiliza datos meteorológicos, que también pueden ser incompletos o manipulados.

## 33. Eventos dinámicos

Ofensivas, contraataques, convoyes, sabotajes, protestas, huelgas, evacuaciones, motines, deserciones, negociaciones, golpes, levantamientos, banderas falsas, fallos de Helios y crisis humanitarias.

Surgen del estado del mundo, no de aleatoriedad sin causa.

La conversión causal de estado → necesidad → misión/evento, su ritmo y su resolución externa se rigen por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md).

## 34. Sistema de misiones

Las misiones proceden de comandantes, territorio, comunidades, FIA, Gobierno, Helios o emergencias.

Pueden ser narrativas obligatorias, estratégicas, reactivas, locales, secretas u oportunidades temporales.

Ignorar o dejar expirar una misión también produce consecuencias.

Las investigaciones incorporan un objetivo militar y otro informativo. Perder una prueba crítica activa una ruta redundante con mayor coste, menor certeza o menos opciones finales; nunca bloquea por sí sola la campaña. La matriz completa está en [INVESTIGATION_REVELATION_MATRIX.md](INVESTIGATION_REVELATION_MATRIX.md).

Las familias, plantillas, prioridades, caducidad, transformación, anti-repetición y límites de ofertas se definen en [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md).

## 35. Eventos narrativos obligatorios

Desembarco, consolidación, descubrimiento de Helios, fragmentación Verde, revelación de Argos y operación sobre Stratis ocurren en todas las campañas.

Su ubicación, participantes, información, consecuencias y resultado dependen del estado estratégico.

El Día Cero parte de un estado rector: Azul abre Katalaki a las 05:40 y Rojo entra en Molos doce minutos después. Ward, Navid y Varos toman decisiones humanas basadas en la fragmentación informativa de PROTOCOLO UMBRAL. La simulación estratégica comienza a partir de H+06:00; no debe reescribir retroactivamente la [cronología de las últimas 72 horas](LAST_72_HOURS_CHRONOLOGY.md).

## 36. Guerra autónoma y niveles de simulación

Mientras el jugador actúa, otros sectores cambian, convoyes avanzan, comandantes deciden, civiles reaccionan, FIA opera y Helios recopila.

### Nivel táctico

Cerca del jugador: unidades físicas, combate completo, vehículos, civiles y daños.

### Nivel operacional

Sectores cercanos: grupos, rutas, objetivos y tiempos.

### Nivel estratégico

Regiones lejanas: fuerza abstracta, suministros, control y resultados calculados.

Al acercarse, el sistema materializa un estado coherente.

La guerra principal permanece dentro de un escenario persistente en Altis. Stratis es una misión separada que recibe un paquete reducido de estado cuando se desbloquea el desenlace.

## 37. Influencia de Helios

Puede recomendar ofensiva, advertir ataque, sugerir retirada, priorizar convoy, detectar riesgo civil o señalar vulnerabilidad.

Puede intentar conservar la viabilidad mediante filtraciones, advertencias selectivas, datos incompletos y prioridades.

No crea recursos, controla unidades, garantiza obediencia, conoce decisiones futuras ni evita todo colapso.

## 38. Detección de manipulación

El jugador compara fuentes, horarios, predicciones, resultados y campañas.

Indicadores:

* precisión sin fuente;
* datos anónimos;
* mensajes duplicados;
* rutas recomendadas a ambos;
* errores que preservan el equilibrio;
* órdenes autenticadas por usuarios inexistentes.

## 39. Progresión de campaña

1. **Fase I — Aproximación:** flotas en tránsito y territorio Verde.
2. **Fase II — Desembarco:** primera oleada, cabeza de playa y escasez.
3. **Fase III — Consolidación:** bases, expansión y contactos.
4. **Fase IV — Guerra territorial:** frentes Azul-Rojo y presión sobre Verde.
5. **Fase V — Fragmentación:** Gobierno dividido, Verde fracturada, FIA e insurgencia.
6. **Fase VI — Guerra por Helios:** nodos, códigos, técnicos y manipulación.
7. **Fase VII — Dominio o desgaste:** una fuerza se aproxima a la victoria y Helios intenta preservar el escenario.
8. **Fase VIII — Stratis:** operación final y decisiones sobre el núcleo.
9. **Fase IX — Transición:** ocupación, reconstrucción, insurgencia, nuevo Gobierno y revelación.

## 40. Condiciones de avance

No dependen solo de sectores. Pueden requerir territorio, logística, información, relaciones, nodos, fuerza, eventos y tiempo.

Stratis puede exigir puerto, superioridad naval, acceso parcial, técnicos, documentos y fuerza suficiente.

## 41. Victoria y derrota

### Victoria militar

Retirada o destrucción del rival, territorio suficiente, logística y neutralización convencional. No garantiza éxito político.

### Victoria política

Autoridad, legitimidad, servicios, cooperación, reducción insurgente y decisión sobre Helios.

### Victoria estratégica

Control o información sobre Helios, Stratis, rutas regionales y presencia extranjera. Puede alcanzarse parcialmente aunque se pierda Altis.

### Derrota

Pérdida de playa, colapso logístico, retirada política, destrucción, pérdida de apoyo, captura del mando o fracaso en Stratis.

Una derrota parcial puede continuar como evacuación, resistencia, retirada u operación limitada.

## 42. Finales combinados

El desenlace combina:

* dimensión militar;
* dimensión política;
* dimensión civil;
* destino de Helios;
* descubrimiento de Argos;
* presencia extranjera.

La combinación no genera un árbol independiente por permutación. Un resolvedor determinista selecciona resultado militar, orden político, condición civil, Helios, Argos, presencia extranjera, verdad pública y módulos priorizados. La autoridad canónica de esa resolución es [MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md](MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md).

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

## 43. Ambas campañas

Azul muestra FIA, contratistas occidentales, inteligencia e intervención convertida en ocupación.

Rojo muestra Asterión, contratos, Gobierno y alianza convertida en subordinación.

Completar ambas revela información paralela, recomendaciones semejantes, activaciones, comparación doctrinal y criterios de validación.

Después puede desbloquearse un epílogo con informes de comparación, divergencia humana, eficacia de recomendaciones y transición a fase madura.

> ¿Las decisiones del jugador destruyeron el experimento o completaron la información que Helios necesitaba?

## 44. Persistencia cooperativa

El servidor conserva autoridad sobre sectores, recursos, unidades, relaciones, eventos, personajes, Helios y progresión.

Los jugadores comparten unidad, decisiones, rango operacional y consecuencias.

Una desconexión no detiene guerra, convoyes, IA ni eventos.

## 45. Autoridad del jugador

Comienza con unidad y decisiones tácticas. Después obtiene subordinados, prioridades, solicitudes y mando regional.

Nunca controla completamente a Ward, Hale, Navid, Vahid, Varos, FIA o Gobierno.

> El jugador puede influir en la guerra, pero debe convivir con las decisiones de otros comandantes.

## 46. Memoria y registro

El mundo recuerda sectores, convoyes, muertes, promesas, armas, prisioneros, daños, alianzas, traiciones y uso de Helios.

El registro de campaña conserva cronología, territorio, bajas, decisiones, relaciones, documentos, descubrimientos, recomendaciones y contradicciones.

Cada cambio relacional registra causa, acto y testigos. Las muertes importantes activan sustitutos con doctrina y vínculos propios; nunca se reemplaza un personaje conservando exactamente su comportamiento.

También conserva evidencias recuperadas, autenticadas, interpretadas, publicadas, entregadas o destruidas; estado de testigos; umbrales de revelación y nivel de preparación S0–S4 para Stratis.

Una segunda campaña puede comparar su registro con la primera perspectiva.

## 47. Principios obligatorios

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

## 48. Frase central

> El territorio determina dónde puede combatir un ejército. La logística determina cuánto tiempo puede permanecer. La información determina qué cree que debe hacer. La población determina si su victoria puede sobrevivir.

> ¿Qué significa controlar una isla cuando sus carreteras, soldados, instituciones, comunicaciones y habitantes obedecen a fuerzas diferentes?

## 49. Aplicación territorial en Altis

La primera aplicación concreta de este sistema utiliza diez regiones operacionales, 38 sectores y nueve corredores lógicos. No emplea una cuadrícula uniforme ni convierte automáticamente cada localidad en un sector.

Las entradas principales son asimétricas:

* Azul entra por Katalaki Bay–Neochori y compite por el aeropuerto desde el oeste.
* Rojo entra por Molos Bay–Molos Airfield y depende del corredor de Sofia.
* Verde conserva inicialmente el centro, Pyrgos y las conexiones interiores.

El modelo completo de regiones, sectores, cuellos de botella, infraestructura y nodos se define en [ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md](ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md).
