# IA, mando, operaciones y dificultad

> **Estado del contenedor:** diseño confirmado y diseño en desarrollo
> **Fuente de verdad para:** IA estratégica/táctica, virtualización y dificultad
> **Relacionados:** [13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md](13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md); [15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-07-25

## Propósito

Centralizar IA estratégica/táctica, virtualización y dificultad sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [STRATEGIC AI AND CHAIN OF COMMAND](#fuente-strategic-ai-and-chain-of-command)
- [TACTICAL AND FORCE VIRTUALIZATION SYSTEM](#fuente-tactical-and-force-virtualization-system)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md`, `TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

## Contenido consolidado

<a id="fuente-strategic-ai-and-chain-of-command"></a>
## Fuente integrada: `STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md`

> **Procedencia:** contenido migrado de `STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-strategic-ai-and-chain-of-command--arquitectura-de-ia-estratégica-y-cadena-de-mando"></a>
### Arquitectura de IA estratégica y cadena de mando

> **Jerarquía:** este documento decide qué fuerza actúa, dónde y con qué intención. Su conversión a grupos físicos, waypoints, batalla abstracta y resultados persistentes se rige por [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system); su implementación modular, dependencias, scheduler, eventos y pruebas, por [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture).

> **Estado:** contrato rector de comportamiento previo a implementación.
> **Motor:** Arma 3 2.18.
> **Lenguaje:** SQF.
> **Autoridad de datos:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).
> **Disponibilidad militar:** [MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md](13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md#fuente-military-system-order-of-battle-and-force-catalog).
> **Decisiones territoriales:** [TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-territorial-sector-front-and-construction-system).
> **Restricciones económicas:** [ECONOMIC_AND_LOGISTICS_SYSTEM.md](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md#fuente-economic-and-logistics-system).

<a id="src-strategic-ai-and-chain-of-command--1-objetivo"></a>
#### 1. Objetivo

Los comandantes deben parecer inteligentes porque observan una parte del mundo, interpretan, priorizan, se equivocan, recuerdan y actúan bajo doctrina, personalidad, logística y política. No se intenta construir una inteligencia general.

<a id="src-strategic-ai-and-chain-of-command--2-dos-capas"></a>
#### 2. Dos capas

<a id="src-strategic-ai-and-chain-of-command--estrategia-propia"></a>
##### Estrategia propia

SQF decide objetivos, frentes, reservas, fuerzas, logística, riesgo, inteligencia y misiones.

<a id="src-strategic-ai-and-chain-of-command--táctica-nativa"></a>
##### Táctica nativa

Arma 3 ejecuta movimiento, formaciones, cobertura, conducción, fuego, combate próximo y waypoints.

La estrategia no coloca a cada soldado. La IA táctica no decide qué región invade una facción.

Las reservas, capacidades, costes, oleadas y tiempos de reposición proceden del catálogo militar; el comandante no puede inventarlos para satisfacer un plan.

<a id="src-strategic-ai-and-chain-of-command--3-límites-técnicos"></a>
#### 3. Límites técnicos

Los waypoints son órdenes sucesivas de grupo, no planes de teatro. El propietario local del grupo evalúa sus condiciones; sus efectos deben diseñarse respetando localidad.

High Command puede ofrecer control temporal de grupos al jugador avanzado, pero no sustituye política, logística ni estrategia. Dynamic Simulation conserva entidades físicas inactivas; no reemplaza fuerzas virtuales ni resolución abstracta.

<a id="src-strategic-ai-and-chain-of-command--4-seis-niveles-de-mando"></a>
#### 4. Seis niveles de mando

| Nivel | Función |
|---:|---|
| 1 | Dirección político-estratégica: fines, tratados, legitimidad y retirada |
| 2 | Teatro: frentes, regiones, reservas, escalada y objetivos principales |
| 3 | Componentes: tierra, aire, Helios, política y corrientes internas |
| 4 | Región: sectores, rutas, prioridades locales y reserva regional |
| 5 | Operación: compañías, columnas, guarniciones, células y convoyes |
| 6 | Unidad protagonista: ejecución, coordinación e influencia progresiva |

AZUR-1 o RUBÍ-1 nunca reemplaza automáticamente al comandante del teatro.

<a id="src-strategic-ai-and-chain-of-command--5-autoridad-y-control"></a>
#### 5. Autoridad y control

Una orden puede poseer autoridad política o militar sin control real. Este último depende de comunicación, obediencia, cohesión, logística, presencia, lealtad y capacidad de sanción.

> Una orden existe cuando se emite. Se convierte en poder cuando alguien puede hacer que sea obedecida.

Los niveles A0–A5, dominios, delegaciones, revocación, confianza y autoridad de facto del jugador se rigen por [PLAYER_PROGRESSION_AUTHORITY_AND_UNLOCKS_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-progression-authority-and-unlocks-system).

<a id="src-strategic-ai-and-chain-of-command--6-perfil-de-comandante"></a>
#### 6. Perfil de comandante

```text
commanderId factionId commandLevel commandScope
doctrine personality politicalConstraints strategicGoals
knownWorldState currentAssessment currentPlan
availableForces reservedForces committedForces
trustNetwork memory stress confidence authority reputation
```

Doctrina, 0–100:

```text
aggression riskTolerance initiative mobilityPreference
fortificationPreference reservePreference logisticsConcern
civilianRestraint politicalRestraint intelligenceReliance
heliosTrust subordinateTrust adaptability persistence
deceptionPreference centralization
```

Variables emocionales:

```text
stress fearOfDefeat fearOfPoliticalFailure anger grievance
confidence ambition warWeariness trustPlayer trustSuperior
trustHelios institutionalLoyalty personalLoyalty
```

Estrés, exceso de confianza y miedo político modifican verificación, reserva, agresividad, retirada y objetivos simbólicos.

<a id="src-strategic-ai-and-chain-of-command--7-conocimiento-y-creencias"></a>
#### 7. Conocimiento y creencias

Ningún comandante lee todo `IF_campaignState`. Decide mediante informes, observaciones, estimaciones, rumores, Helios y conocimiento confirmado.

Creencia:

```text
subjectId estimatedLocation estimatedStrength estimatedReadiness
estimatedIntent confidence source age contradictions
commanderInterpretation
```

La formación, procedencia, envejecimiento y manipulación de esos informes, junto con los estados percibidos por actor, se rigen por [HELIOS_INTELLIGENCE_AND_FOG_OF_WAR_SYSTEM.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-helios-intelligence-and-fog-of-war-system).

Fuentes:

```text
DIRECT_OBSERVATION RECON_TEAM DRONE AIRCRAFT RADAR SIGNALS
CIVILIAN PRISONER DESERTER ALLIED_COMMAND HELIOS
ARGOS_MANIPULATION RUMOR
```

Antigüedad, reputación, acceso, interferencia, confirmación, infiltración y sesgo determinan credibilidad.

<a id="src-strategic-ai-and-chain-of-command--8-ciclo-estratégico"></a>
#### 8. Ciclo estratégico

1. observar cambios;
2. actualizar creencias;
3. evaluar necesidades;
4. priorizar;
5. generar planes compatibles;
6. puntuar candidatos;
7. reservar recursos;
8. emitir órdenes;
9. supervisar y adaptar.

Necesidades:

```text
SURVIVAL DEFENSE LOGISTICS OFFENSIVE POLITICAL
CIVIL INTELLIGENCE HELIOS
```

Cada necesidad conserva tipo, urgencia, importancia, plazo, región, beneficio, riesgo y origen.

<a id="src-strategic-ai-and-chain-of-command--9-plan-operacional"></a>
#### 9. Plan operacional

```text
planId commanderId objective supportingObjectives area
startConditions terminationConditions assignedForces reserveForces
logisticsPlan intelligenceRequirements politicalConstraints
phases contingencies expectedDuration expectedLosses status
```

Fases:

1. preparación;
2. aislamiento;
3. acción principal;
4. explotación;
5. consolidación;
6. terminación.

Plantillas:

```text
SECTOR_DEFENSE MOBILE_DEFENSE FRONTAL_ATTACK ENVELOPMENT
RAID LOGISTICS_INTERDICTION POLITICAL_OPERATION
COUNTERINSURGENCY UPRISING EVACUATION
```

<a id="src-strategic-ai-and-chain-of-command--10-evaluación-de-planes"></a>
#### 10. Evaluación de planes

```text
valor =
beneficio militar + logístico + político + informativo
+ compatibilidad doctrinal + urgencia
- coste - riesgo - exposición - daño civil
- consumo de reservas - incertidumbre
```

Cada comandante pondera casos mejor, esperado y peor. Un prudente prioriza el peor; un agresivo, oportunidad y mejor caso; un político, legitimidad y aliados.

<a id="src-strategic-ai-and-chain-of-command--11-reservas-y-asignación"></a>
#### 11. Reservas y asignación

Reservas:

* táctica;
* regional;
* estratégica;
* política.

Estados de fuerza:

```text
AVAILABLE RESERVED MOVING COMMITTED REORGANIZING
ISOLATED RETREATING DESTROYED
```

Dos planes no asignan la misma formación. La operación valida ubicación, movilidad, suministro, preparación, objetivo y tiempo de llegada antes de reservarla.

<a id="src-strategic-ai-and-chain-of-command--12-logística-y-frentes"></a>
#### 12. Logística y frentes

Toda ofensiva comprueba combustible, munición, personal, vehículos, rutas, centros, capacidad médica y tiempo.

Frente:

```text
frontId region factions sectorIds frontState pressureByFaction
supplyByFaction terrainType commanderId priority
```

Estados:

```text
QUIET TENSION ACTIVE BREAKTHROUGH COLLAPSING ENCIRCLED FROZEN
```

La presión combina fuerza, proximidad, suministro, artillería, reservas, rutas, moral y fortificación.

<a id="src-strategic-ai-and-chain-of-command--13-ejecución-táctica"></a>
#### 13. Ejecución táctica

Al materializar:

1. seleccionar fuerzas;
2. crear grupos y composiciones;
3. aplicar experiencia, daño y estado;
4. asignar posiciones y waypoints;
5. añadir Event Handlers;
6. supervisar;
7. reintegrar el resultado.

Paquetes:

```text
ATTACK: ASSEMBLE MOVE_TO_LINE SUPPRESS ASSAULT CLEAR HOLD REORGANIZE
DEFENSE: OCCUPY ORIENT_FRONT PATROL HOLD_FIRE ENGAGE FALLBACK COUNTERATTACK
CONVOY: FORM MOVE CHECKPOINT BYPASS UNLOAD RETURN
RAID: INFILTRATE OBSERVE STRIKE RECOVER EXFILTRATE
```

La estrategia solo interviene ante cambio de objetivo, ruta imposible, retirada, contingencia o fin de fase.

<a id="src-strategic-ai-and-chain-of-command--14-resolución-abstracta"></a>
#### 14. Resolución abstracta

Lejos del jugador se consideran fuerza, suministro, terreno, fortificación, información, moral, apoyo, mando y sorpresa. Persiste bajas, consumo, daño, control, moral y experiencia.

Niveles:

| Nivel | Representación |
|---|---|
| Táctico | Unidades físicas e IA completa |
| Operacional | Formaciones virtuales, rutas y tiempos |
| Estratégico | Fuerza agregada, control y presión |

Una fuerza solo existe en un nivel. Al aproximarse el jugador se materializan supervivientes y restos coherentes.

<a id="src-strategic-ai-and-chain-of-command--15-planificador-central"></a>
#### 15. Planificador central

No existe un `spawn` permanente por comandante o sector.

```text
IF_fnc_strategyScheduler
```

Colas:

```text
commanderEvaluations frontUpdates logisticsUpdates
civilUpdates missionUpdates heliosUpdates
```

Ritmos:

* teatro: 3–5 minutos o evento crítico;
* región: 1–3 minutos;
* operación: 30–90 segundos;
* táctica: IA y eventos;
* emergencia: inmediata.

<a id="src-strategic-ai-and-chain-of-command--16-errores-y-aprendizaje"></a>
#### 16. Errores y aprendizaje

Errores explicables:

* informativo;
* doctrinal;
* político;
* logístico;
* emocional;
* temporal;
* subordinación;
* ejecución.

No existe un porcentaje universal de error. Surge de mala inteligencia, estrés, presión, doctrina rígida, comunicaciones, infiltración, fatiga y derrotas.

El aprendizaje es memoria y cambio de pesos predefinidos: rutas, escoltas, señuelos, reservas, fuentes y plantillas. No hay aprendizaje automático.

<a id="src-strategic-ai-and-chain-of-command--17-cadena-azul"></a>
#### 17. Cadena Azul

| Actor | Papel y preferencias |
|---|---|
| Elena Ward | Teatro; legalidad, reserva, movilidad, civiles, cooperación y salida política |
| Marcus Hale | Tierra; concentración, velocidad, mecanización y explotación |
| Thomas Rourke | Traduce órdenes; protege o presiona a AZUR-1 |
| Naomi Reyes | Aire; pistas, combustible, defensa y conservación de aeronaves |
| Sofia Laurent | Restricciones civiles, municipios, hospitales y negociación |
| Miriam Kessler | Nodos, técnicos, servidores e investigación Helios |

Ward puede endurecerse o buscar tregua. Hale puede sobreextenderse y convertir intervención en ocupación.

<a id="src-strategic-ai-and-chain-of-command--18-cadena-roja"></a>
#### 18. Cadena Roja

| Actor | Papel y preferencias |
|---|---|
| Darius Navid | Teatro; Asterión, reservas, corredores y cooperación Verde |
| Soraya Vahid | Tierra; mecanización, artillería, presión y ofensiva sostenida |
| Samir Khadem | Traduce y modera órdenes; protege o utiliza RUBÍ-1 |
| Laleh Arman | Aire y defensa; Molos, logística y conservación aérea |
| Kamran Sadeq | Helios; claves, integración y preservación |
| Nadir Khoury | Política; Gobierno, legitimidad, negociación y Asterión |

Navid corre riesgo de lentitud y dependencia. Vahid puede convertir alianza en ocupación.

<a id="src-strategic-ai-and-chain-of-command--19-cadenas-verdes"></a>
#### 19. Cadenas Verdes

Cadena formal:

```text
Gobierno → Laskaris → Varos → comandos regionales
```

Paralelas:

* gubernamental: Kouris, Vrettos, Laskaris, Sarris;
* soberanista: Daskal;
* reformista: Koronis y Neris;
* Argos: Rallis.

Varos busca soberanía, aeropuerto, Pyrgos, Stratis y unidad. Sarris protege continuidad y puede resistir a Vahid. Daskal favorece emboscada, retirada y negación. Koronis protege ciudades y negociación. Petrou defiende Stratis. Rallis altera información y prioridades sin controlar voluntades.

<a id="src-strategic-ai-and-chain-of-command--20-fia"></a>
#### 20. FIA

Markou dirige política y legitimidad; Kallas, brigadas y operaciones; células locales conservan autonomía; Frente Negro recibe manipulación.

Una orden nacional es una solicitud ponderada. Cada célula puede obedecer, modificar, retrasar, rechazar o actuar sola.

El pipeline celular, la resolución abstracta de operaciones, la relación Markou–Kallas y los modelos de contrainsurgencia se rigen por [FIA_INSURGENCY_AND_CLANDESTINE_WAR_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-fia-insurgency-and-clandestine-war-system).

<a id="src-strategic-ai-and-chain-of-command--21-argos"></a>
#### 21. Argos

Argos no posee frente convencional. Utiliza información, operadores, accesos, células, Meridian y Stratis.

Objetivos:

1. conservar facciones viables;
2. impedir conclusión demasiado temprana;
3. proteger Stratis y nodos;
4. observar decisiones;
5. evitar exposición;
6. completar validación.

Recurso:

```text
interventionCapacity
```

Se consume al alterar informes, proteger infiltrados, retrasar órdenes, financiar operaciones, extraer técnicos, activar Meridian o fabricar evidencia. La recuperación es mínima.

Intervenciones informativas, políticas, clandestinas y militares limitadas aumentan `argosExposure`. Argos no garantiza equilibrio y puede perder control.

<a id="src-strategic-ai-and-chain-of-command--22-jugador-y-órdenes"></a>
#### 22. Jugador y órdenes

El jugador recibe órdenes directas, alternativas, solicitudes políticas, filtraciones, emergencias y oportunidades.

Autoridad:

1. ejecución;
2. solicitud;
3. recomendación;
4. selección operacional;
5. coordinación;
6. influencia regional.

Los superiores pueden rechazar propuestas.

La desobediencia evalúa claridad, autoridad, motivo, resultado, pérdidas, política y relación. Puede causar sanción, bloqueo, reconocimiento, arresto o ruptura. Un éxito táctico no implica aprobación.

<a id="src-strategic-ai-and-chain-of-command--23-sucesión-y-continuidad"></a>
#### 23. Sucesión y continuidad

La muerte transfiere fuerzas, problemas y plan parcial, pero no personalidad ni confianza. Un plan pasa a `COMMAND_DISRUPTED`; subordinados pueden continuar mientras el sucesor lo mantiene, modifica o cancela.

<a id="src-strategic-ai-and-chain-of-command--24-helios-y-argos-revelado"></a>
#### 24. Helios y Argos revelado

Cada comandante distingue confianza instrumental, institucional, desconfianza, rechazo y dependencia.

Ward verifica; Hale prioriza victoria; Navid reevalúa legitimidad; Vahid trata Argos como arma; Varos ve violación soberana; Markou deslegitima; Kallas intenta capturar; Vardis interpreta las reacciones como datos.

<a id="src-strategic-ai-and-chain-of-command--25-comunicación"></a>
#### 25. Comunicación

Orden:

```text
issuer receiver creationTime deliveryTime priority
authentication clarity status
```

Estados:

```text
CREATED TRANSMITTED DELAYED RECEIVED ACKNOWLEDGED
MISINTERPRETED REJECTED SUPERSEDED COMPLETED
```

Una orden auténtica puede llegar tarde o ser ambigua. Sin comunicaciones, Azul favorece iniciativa táctica; Rojo, alternativas previstas; Verde, cadenas paralelas; FIA, autonomía local.

<a id="src-strategic-ai-and-chain-of-command--26-misiones-y-evaluación"></a>
#### 26. Misiones y evaluación

Toda orden al jugador contiene contexto, intención, objetivo, restricciones, apoyos, urgencia y terminación.

El comandante detecta y prioriza necesidades; el director descrito en [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-dynamic-missions-and-emergent-events) las convierte en candidatos compatibles, aplica límites de oferta y registra por qué se generó cada misión.

Resultado:

```text
EXCEPTIONAL SUCCESS PARTIAL FAILURE DISASTER
UNAUTHORIZED_SUCCESS JUSTIFIED_DISOBEDIENCE
UNJUSTIFIED_DISOBEDIENCE
```

Se evalúan intención, pérdidas, tiempo, civiles, pruebas, recursos y obediencia.

<a id="src-strategic-ai-and-chain-of-command--27-depuración"></a>
#### 27. Depuración

Cada decisión registra:

```text
commanderId assessmentTime needsDetected plansGenerated plansRejected
selectedPlan scoreBreakdown constraints informationUsed confidence
```

La UI avanzada muestra intención, fuerzas, reservas, frentes, necesidades y propuestas; oculta planes enemigos, puntuaciones, infiltrados, precisión real y Argos.

<a id="src-strategic-ai-and-chain-of-command--28-high-command-localidad-y-rendimiento"></a>
#### 28. High Command, localidad y rendimiento

High Command solo dirige grupos asignados temporalmente. El servidor conserva plan y estado; el propietario local ejecuta táctica; el resultado vuelve al servidor.

Un Headless Client futuro puede recibir grupos mediante `setGroupOwner`, nunca estado, decisiones, persistencia o secretos.

Dynamic Simulation solo administra entidades físicas habilitadas. No reemplaza virtualización ni economía.

<a id="src-strategic-ai-and-chain-of-command--29-funciones"></a>
#### 29. Funciones

```text
IF_fnc_commanderEvaluate IF_fnc_commanderUpdateBeliefs
IF_fnc_commanderDetectNeeds IF_fnc_commanderGeneratePlans
IF_fnc_commanderScorePlan IF_fnc_commanderSelectPlan
IF_fnc_planReserveForces IF_fnc_planIssueOrders
IF_fnc_planMonitor IF_fnc_planAbort IF_fnc_planResolve
IF_fnc_frontEvaluate IF_fnc_forceAssign
IF_fnc_forceMaterialize IF_fnc_forceVirtualize
IF_fnc_combatResolveAbstract IF_fnc_orderTransmit
IF_fnc_orderAcknowledge IF_fnc_playerMissionOffer
IF_fnc_playerMissionEvaluate IF_fnc_argosEvaluateIntervention
```

<a id="src-strategic-ai-and-chain-of-command--30-vertical-slice-y-fases"></a>
#### 30. Vertical slice y fases

Primera región: Katalaki–Neochori–Stavros–AAC–Airport West.

Actores: Ward, Hale, Varos, un mando Verde regional, Rourke, contacto civil y Argos básico.

Planes: defensa, ataque, convoy, contraataque, reconocimiento, civiles y nodo.

Fases:

1. percepción;
2. necesidades;
3. planes simples;
4. reservas y fuerzas;
5. personajes;
6. política y civiles;
7. Helios;
8. Argos;
9. cooperativo.

No se implementan lenguaje generado, aprendizaje automático, operaciones inventadas libremente, control individual completo, Estado Mayor total, cientos de operaciones, diplomacia libre ni modelos externos.

<a id="src-strategic-ai-and-chain-of-command--31-invariantes"></a>
#### 31. Invariantes

1. Una fuerza no pertenece a dos planes.
2. Un comandante no usa información desconocida.
3. La logística no se ignora sin riesgo registrado.
4. Un plan resuelto no sigue activo.
5. Un muerto no emite órdenes.
6. Una orden cancelada requiere retraso o autonomía para ejecutarse.
7. Un cliente no modifica estrategia.
8. Un infiltrado no controla una facción.
9. Argos paga toda intervención.
10. Una misión no detiene toda la guerra.
11. Una fuerza nunca existe en dos niveles.
12. La retirada es una decisión válida.

<a id="src-strategic-ai-and-chain-of-command--32-referencias-técnicas"></a>
#### 32. Referencias técnicas

* [Waypoints — Bohemia Interactive Community](https://community.bistudio.com/wiki/Waypoints)
* [High Command — Bohemia Interactive Community](https://community.bistudio.com/wiki/Arma_3%3A_High_Command)
* [Dynamic Simulation — Bohemia Interactive Community](https://community.bistudio.com/wiki/Arma_3%3A_Dynamic_Simulation)
* [Scheduler — Bohemia Interactive Community](https://community.bistudio.com/wiki/Scheduler)
* [setGroupOwner — Bohemia Interactive Community](https://community.bistudio.com/wiki/setGroupOwner)

> **La estrategia decide qué batalla debe existir. Arma 3 decide cómo sobreviven quienes entran en ella.**

---

<a id="fuente-tactical-and-force-virtualization-system"></a>
## Fuente integrada: `TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md`

> **Procedencia:** contenido migrado de `TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-tactical-and-force-virtualization-system--islas-fracturadas"></a>
### ISLAS FRACTURADAS

<a id="src-tactical-and-force-virtualization-system--documento-714-sistema-táctico-y-virtualización-definitiva-de-fuerzas"></a>
#### Documento 7/14 — Sistema táctico y virtualización definitiva de fuerzas

**Versión:** 1.0
**Clasificación:** documento rector de simulación, combate, persistencia y rendimiento
**Campañas:** Fuerza Azul y Fuerza Roja
**Territorios:** Altis y Stratis
**Motor:** Arma 3 2.18
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando y Headless Client opcional
**Estado:** canon técnico previo a implementación

> **Jerarquía documental:** este Documento 7/14 gobierna formaciones persistentes, reservas, proyecciones, materialización, reintegración, localidad, Dynamic Simulation, batallas virtuales, bajas, vehículos y rendimiento. [MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md](13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md#fuente-military-system-order-of-battle-and-force-catalog) conserva escalas y activos; [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-technical-3den-module-and-composition-catalog), composiciones; [STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-strategic-ai-and-chain-of-command), decisiones estratégicas; [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model), el estado autoritativo; y [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture), las capas, APIs, registros, schedulers, eventos y reglas de código.

---

<a id="src-tactical-and-force-virtualization-system--1-propósito"></a>
### 1. Propósito

Este documento define cómo las entidades estratégicas de Islas Fracturadas se convierten temporalmente en:

* soldados;
* escuadras;
* grupos;
* vehículos;
* armas estáticas;
* fortificaciones;
* patrullas;
* convoyes;
* aeronaves;
* cadáveres;
* prisioneros;
* restos recuperables.

También establece:

* cuándo materializar fuerzas;
* cuándo mantenerlas virtuales;
* cómo resolver batallas lejanas;
* cómo reintegrar supervivientes;
* cómo registrar bajas;
* cómo evitar duplicaciones;
* cómo manejar retiradas y rendiciones;
* cómo conservar vehículos persistentes;
* cómo usar Dynamic Simulation correctamente;
* cómo administrar grupos y localidad;
* cómo preparar el sistema para servidor dedicado;
* cómo mantener rendimiento estable;
* cómo depurar cada transición.

<a id="src-tactical-and-force-virtualization-system--principio-central"></a>
#### Principio central

> La formación estratégica es la verdad persistente.

> Los soldados y vehículos físicos son una representación temporal y parcial de esa formación cuando el jugador necesita verla, combatirla o interactuar con ella.

---

<a id="src-tactical-and-force-virtualization-system--2-diferencia-entre-virtualización-y-dynamic-simulation"></a>
### 2. Diferencia entre virtualización y Dynamic Simulation

La virtualización propia de Islas Fracturadas y el sistema Dynamic Simulation de Arma 3 cumplirán funciones diferentes.

<a id="src-tactical-and-force-virtualization-system--virtualización-estratégica"></a>
#### Virtualización estratégica

Una formación virtual:

* no necesita unidades físicas;
* conserva personal, vehículos, moral y suministros como datos;
* puede desplazarse entre sectores;
* puede combatir abstractamente;
* puede recibir órdenes;
* puede sufrir bajas;
* puede dividirse o retirarse.

<a id="src-tactical-and-force-virtualization-system--dynamic-simulation"></a>
#### Dynamic Simulation

Dynamic Simulation mantiene las entidades creadas, pero activa o desactiva su simulación según la proximidad relevante. En grupos de IA trabaja sobre el grupo completo, no sobre miembros individuales; además, las entidades desactivadas dejan de moverse, por lo que no sustituye el movimiento estratégico virtual. ([Bohemia Community][1])

<a id="src-tactical-and-force-virtualization-system--decisión"></a>
#### Decisión

Se utilizará:

```text
Virtualización
para fuerzas lejanas y movimiento estratégico.

Dynamic Simulation
para grupos físicos existentes que deben permanecer en el mundo, pero no necesitan simularse continuamente.
```

---

<a id="src-tactical-and-force-virtualization-system--3-jerarquía-de-existencia"></a>
### 3. Jerarquía de existencia

Cada activo podrá encontrarse en uno de cinco niveles.

<a id="src-tactical-and-force-virtualization-system--v0-existencia-estratégica"></a>
#### V0 — Existencia estratégica

Solo existe como datos.

Ejemplos:

* compañía en otro frente;
* reserva regional;
* convoy lejano;
* batería no desplegada físicamente.

<a id="src-tactical-and-force-virtualization-system--v1-representación-estratégica-localizada"></a>
#### V1 — Representación estratégica localizada

Posee:

* sector;
* ruta;
* área estimada;
* estado;
* hora de llegada.

No posee unidades físicas.

<a id="src-tactical-and-force-virtualization-system--v2-entidad-física-dormida"></a>
#### V2 — Entidad física dormida

Está creada en el motor, pero:

* alejada;
* sin misión táctica inmediata;
* gestionada mediante Dynamic Simulation;
* sin scripts tácticos costosos.

<a id="src-tactical-and-force-virtualization-system--v3-entidad-física-activa"></a>
#### V3 — Entidad física activa

Está:

* cerca del jugador;
* en combate;
* realizando una misión;
* participando en una escena relevante.

<a id="src-tactical-and-force-virtualization-system--v4-entidad-narrativa-protegida"></a>
#### V4 — Entidad narrativa protegida

Es una entidad activa con reglas especiales por:

* personaje;
* evidencia;
* misión;
* vehículo único;
* interacción.

<a id="src-tactical-and-force-virtualization-system--regla"></a>
#### Regla

Una entidad no será V4 para hacerla inmortal.

Será V4 para asegurar que su muerte, captura o desaparición sea procesada correctamente.

---

<a id="src-tactical-and-force-virtualization-system--4-la-formación-estratégica-como-fuente-de-verdad"></a>
### 4. La formación estratégica como fuente de verdad

Cada formación persistente tendrá:

```text
formationId
factionId
parentFormationId
echelon
templateId
manpower
effectiveStrength
casualties
readiness
morale
cohesion
experience
supply
vehicleAssets
specialCapabilities
currentSector
destinationSector
assignedPlan
status
materializationState
```

<a id="src-tactical-and-force-virtualization-system--ejemplo"></a>
#### Ejemplo

```sqf
IF_formation = createHashMapFromArray [
    ["id", "FORM_BLUE_A_COY_01"],
    ["factionId", "FAC_BLUE"],
    ["parentFormationId", "FORM_BLUE_LAND_COMPONENT"],
    ["echelon", "COMPANY"],
    ["templateId", "TPL_BLUE_RIFLE_COMPANY"],

    ["manpower", 104],
    ["effectiveStrength", 82],
    ["woundedLight", 7],
    ["woundedSerious", 4],
    ["missing", 1],
    ["captured", 0],
    ["killed", 10],

    ["readiness", 72],
    ["morale", 68],
    ["cohesion", 74],
    ["experience", 61],
    ["supply", 66],

    ["vehicleAssetIds", []],
    ["currentSectorId", "ALT_CW_NEOCHORI"],
    ["destinationSectorId", "ALT_CW_STAVROS_WHISKEY"],
    ["status", "AVAILABLE"],
    ["materializationState", "V1"]
];
```

---

<a id="src-tactical-and-force-virtualization-system--5-formación-frente-a-destacamento-táctico"></a>
### 5. Formación frente a destacamento táctico

Una formación estratégica puede proyectar uno o varios destacamentos físicos.

<a id="src-tactical-and-force-virtualization-system--formación"></a>
#### Formación

Representa:

* reserva de personal;
* identidad;
* mando;
* experiencia;
* recursos;
* continuidad.

<a id="src-tactical-and-force-virtualization-system--destacamento-táctico"></a>
#### Destacamento táctico

Representa la parte materializada.

Puede contener:

* una escuadra;
* un pelotón;
* vehículos;
* equipo de apoyo.

<a id="src-tactical-and-force-virtualization-system--ejemplo-1"></a>
#### Ejemplo

Una compañía estratégica de 104 efectivos puede materializar:

```text
Destacamento 1:
24 soldados y 2 vehículos cerca del jugador.

Destacamento 2:
16 soldados defendiendo otro objetivo físico.

Reserva virtual:
64 efectivos.
```

<a id="src-tactical-and-force-virtualization-system--regla-1"></a>
#### Regla

La suma de todos los destacamentos y reservas no puede superar la fuerza estratégica disponible.

---

<a id="src-tactical-and-force-virtualization-system--6-registro-de-compromisos"></a>
### 6. Registro de compromisos

Antes de materializar personal o vehículos, el sistema reservará su cantidad.

```text
AVAILABLE
RESERVED_FOR_MISSION
MATERIALIZING
MATERIALIZED
REINTEGRATING
```

<a id="src-tactical-and-force-virtualization-system--flujo"></a>
#### Flujo

```text
Formación disponible
→ reservar efectivos
→ crear proyección
→ materializar
→ combatir
→ registrar resultado
→ reintegrar
→ liberar reserva
```

<a id="src-tactical-and-force-virtualization-system--objetivo"></a>
#### Objetivo

Evitar que una compañía de 100 hombres aparezca simultáneamente como:

* 80 en una misión;
* 60 en otra;
* 100 en el mapa estratégico.

---

<a id="src-tactical-and-force-virtualization-system--7-reserva-transaccional"></a>
### 7. Reserva transaccional

La materialización utilizará una transacción.

```text
REQUEST
VALIDATE
RESERVE
SPAWN
REGISTER
COMMIT
```

<a id="src-tactical-and-force-virtualization-system--si-falla"></a>
#### Si falla

```text
ROLLBACK
CLEANUP
RELEASE_RESERVATION
```

<a id="src-tactical-and-force-virtualization-system--regla-2"></a>
#### Regla

Una materialización incompleta nunca deberá descontar permanentemente hombres sin crear la proyección ni crear la proyección sin descontarlos.

---

<a id="src-tactical-and-force-virtualization-system--8-identidad-de-las-proyecciones"></a>
### 8. Identidad de las proyecciones

Cada proyección tendrá:

```text
projectionId
formationId
missionId
reservedManpower
reservedVehicleIds
physicalGroupIds
physicalEntityIds
materializedAt
materializedSector
status
```

<a id="src-tactical-and-force-virtualization-system--ejemplo-2"></a>
#### Ejemplo

```text
PROJ_FORM_BLUE_A_COY_01_MISSION_014
```

---

<a id="src-tactical-and-force-virtualization-system--9-razones-válidas-para-materializar"></a>
### 9. Razones válidas para materializar

Una formación podrá materializarse cuando:

1. Entra en la burbuja táctica del jugador.
2. Participa en una misión activa.
3. Defiende una composición visible.
4. Ataca un sector cercano.
5. Transporta un activo crítico.
6. Contiene un personaje.
7. Su rendición o destrucción necesita representación.
8. Forma parte de una escena narrativa.
9. Debe permitir interacción directa.
10. Su presencia visual es necesaria para coherencia.

<a id="src-tactical-and-force-virtualization-system--razones-no-válidas"></a>
#### Razones no válidas

* existe en el estado estratégico;
* pertenece a un sector visible en el mapa;
* podría ser útil más tarde;
* se desea mostrar toda la guerra físicamente.

---

<a id="src-tactical-and-force-virtualization-system--10-burbuja-táctica"></a>
### 10. Burbuja táctica

La burbuja táctica no será solamente un radio fijo alrededor del jugador.

Considerará:

* distancia;
* visibilidad;
* carreteras;
* velocidad;
* aeronaves;
* misión;
* combate;
* cámaras;
* aliados;
* probabilidad de encuentro.

<a id="src-tactical-and-force-virtualization-system--zonas"></a>
#### Zonas

```text
CORE
TRANSITION
PRELOAD
STRATEGIC
```

---

<a id="src-tactical-and-force-virtualization-system--11-zona-core"></a>
### 11. Zona CORE

Área donde:

* todo combate relevante está activo;
* la IA debe simularse plenamente;
* los objetos principales están materializados;
* el jugador puede observar directamente.

<a id="src-tactical-and-force-virtualization-system--radio-inicial-recomendado"></a>
#### Radio inicial recomendado

```text
Infantería y entorno urbano:
1.200–1.800 m

Vehículos y campo abierto:
1.800–2.500 m

Aeronaves:
distancias especiales según misión
```

Los valores se ajustarán mediante pruebas.

---

<a id="src-tactical-and-force-virtualization-system--12-zona-transition"></a>
### 12. Zona TRANSITION

Área intermedia donde:

* grupos físicos pueden permanecer;
* Dynamic Simulation puede desactivarlos;
* se preparan entradas y salidas;
* no se debe mostrar una transición visible.

La documentación oficial advierte que Dynamic Simulation no comprueba línea de visión para ocultar transiciones, por lo que el diseño debe evitar que el jugador observe directamente entidades activándose o deteniéndose. ([Bohemia Community][1])

---

<a id="src-tactical-and-force-virtualization-system--13-zona-preload"></a>
### 13. Zona PRELOAD

Área donde el sistema prepara:

* grupos;
* composiciones;
* rutas;
* datos;
* reservas.

No necesariamente simula todo.

<a id="src-tactical-and-force-virtualization-system--objetivo-1"></a>
#### Objetivo

Evitar:

* apariciones delante del jugador;
* cargas bruscas;
* refuerzos instantáneos;
* vehículos sin ruta.

---

<a id="src-tactical-and-force-virtualization-system--14-zona-strategic"></a>
### 14. Zona STRATEGIC

Todo permanece virtual salvo:

* elementos permanentes ligeros;
* entidades narrativas explícitamente conservadas;
* restos seleccionados;
* infraestructura que el motor deba mantener.

---

<a id="src-tactical-and-force-virtualization-system--15-activadores-adicionales-de-materialización"></a>
### 15. Activadores adicionales de materialización

Además del jugador, pueden activar preparación:

* dron controlado por jugador;
* cámara de misión;
* equipo subordinado humano futuro;
* vehículo aéreo;
* misión de artillería;
* unidad protagonista separada.

<a id="src-tactical-and-force-virtualization-system--dynamic-simulation-1"></a>
#### Dynamic Simulation

El motor permite controlar qué unidades pueden activar entidades dinámicamente simuladas mediante su sistema de activación, pero la campaña mantendrá esta lógica centralizada y validada desde el servidor. ([Bohemia Community][2])

---

<a id="src-tactical-and-force-virtualization-system--16-desmaterialización"></a>
### 16. Desmaterialización

Una proyección puede desmaterializarse cuando:

* está fuera de la burbuja;
* no es visible;
* no combate;
* no tiene proyectiles o amenazas inmediatas;
* no contiene jugador;
* no transporta una interacción activa;
* su estado puede resumirse con seguridad.

<a id="src-tactical-and-force-virtualization-system--no-se-desmaterializa-mientras"></a>
#### No se desmaterializa mientras

* recibe fuego;
* dispara;
* persigue al jugador;
* transporta un personaje activo;
* está en una conversación;
* un vehículo está volcando o explotando;
* existe una interacción pendiente;
* hay jugadores humanos dentro.

---

<a id="src-tactical-and-force-virtualization-system--17-desmaterialización-segura"></a>
### 17. Desmaterialización segura

<a id="src-tactical-and-force-virtualization-system--fase-1-solicitud"></a>
#### Fase 1 — Solicitud

La entidad cumple criterios.

<a id="src-tactical-and-force-virtualization-system--fase-2-congelación-lógica"></a>
#### Fase 2 — Congelación lógica

Se bloquean nuevas órdenes estratégicas.

<a id="src-tactical-and-force-virtualization-system--fase-3-captura"></a>
#### Fase 3 — Captura

Se registra:

* posición;
* personal;
* daño;
* munición;
* combustible;
* moral;
* enemigos conocidos;
* prisioneros.

<a id="src-tactical-and-force-virtualization-system--fase-4-reintegración"></a>
#### Fase 4 — Reintegración

Se aplican resultados a la formación.

<a id="src-tactical-and-force-virtualization-system--fase-5-eliminación-física"></a>
#### Fase 5 — Eliminación física

Se eliminan unidades y grupos.

<a id="src-tactical-and-force-virtualization-system--fase-6-confirmación"></a>
#### Fase 6 — Confirmación

La proyección vuelve a V1 o V0.

---

<a id="src-tactical-and-force-virtualization-system--18-cancelación-de-desmaterialización"></a>
### 18. Cancelación de desmaterialización

Si durante el proceso:

* aparece el jugador;
* comienza combate;
* entra una cámara;
* se activa una misión;

la transición se cancela antes de eliminar entidades.

---

<a id="src-tactical-and-force-virtualization-system--19-proyección-parcial"></a>
### 19. Proyección parcial

No se materializará necesariamente toda la fuerza comprometida.

<a id="src-tactical-and-force-virtualization-system--factores"></a>
#### Factores

* presupuesto de rendimiento;
* distancia;
* misión;
* tamaño de formación;
* terreno;
* visibilidad.

<a id="src-tactical-and-force-virtualization-system--ejemplo-3"></a>
#### Ejemplo

Una fuerza estratégica atacante de 70 hombres puede representarse mediante:

* 32 atacantes físicos;
* 12 como refuerzo posterior;
* 26 abstractos que contribuyen a presión, cerco y reserva.

---

<a id="src-tactical-and-force-virtualization-system--20-representación-escalonada"></a>
### 20. Representación escalonada

Las fuerzas grandes entrarán por oleadas.

<a id="src-tactical-and-force-virtualization-system--ventajas"></a>
#### Ventajas

* coherencia;
* rendimiento;
* sensación de profundidad;
* posibilidad de retirada;
* reservas reales.

<a id="src-tactical-and-force-virtualization-system--regla-3"></a>
#### Regla

Las oleadas deben existir dentro de la formación.

No son enemigos generados infinitamente.

---

<a id="src-tactical-and-force-virtualization-system--21-paquetes-tácticos"></a>
### 21. Paquetes tácticos

Una formación estratégica se convierte en un paquete táctico según:

* misión;
* doctrina;
* terreno;
* amenaza;
* vehículos;
* suministros.

<a id="src-tactical-and-force-virtualization-system--ejemplos"></a>
#### Ejemplos

```text
INFANTRY_ASSAULT
MOTORIZED_PATROL
MECHANIZED_ATTACK
URBAN_DEFENSE
ANTI_ARMOR_AMBUSH
QRF
CONVOY_ESCORT
RECON_SCREEN
WITHDRAWAL_GUARD
```

---

<a id="src-tactical-and-force-virtualization-system--22-paquete-de-asalto-de-infantería"></a>
### 22. Paquete de asalto de infantería

Puede contener:

* mando;
* dos o tres escuadras;
* equipo AT;
* sanitario;
* humo;
* reserva.

<a id="src-tactical-and-force-virtualization-system--variantes"></a>
#### Variantes

* frontal;
* flanco;
* infiltración;
* nocturno;
* urbano.

---

<a id="src-tactical-and-force-virtualization-system--23-paquete-mecanizado"></a>
### 23. Paquete mecanizado

Puede contener:

* uno o dos vehículos de combate;
* infantería transportada;
* reconocimiento;
* apoyo;
* reserva virtual.

<a id="src-tactical-and-force-virtualization-system--requisitos"></a>
#### Requisitos

* combustible;
* tripulaciones;
* ruta;
* espacio;
* suministro.

---

<a id="src-tactical-and-force-virtualization-system--24-paquete-defensivo"></a>
### 24. Paquete defensivo

Puede contener:

* guarnición;
* armas estáticas;
* patrulla;
* reserva;
* ruta de retirada;
* observadores.

<a id="src-tactical-and-force-virtualization-system--relación-territorial"></a>
#### Relación territorial

El paquete utiliza los módulos y anclajes ya definidos para el sector.

---

<a id="src-tactical-and-force-virtualization-system--25-paquete-fia"></a>
### 25. Paquete FIA

Debe priorizar:

* pequeños grupos;
* rutas de escape;
* ocultamiento;
* tiempo limitado;
* baja permanencia.

No deberá materializar:

* toda la red local;
* todos los simpatizantes;
* todos los depósitos.

---

<a id="src-tactical-and-force-virtualization-system--26-grupos-físicos"></a>
### 26. Grupos físicos

La unidad táctica básica del motor será el grupo.

<a id="src-tactical-and-force-virtualization-system--reglas"></a>
#### Reglas

* mantener grupos coherentes;
* evitar grupos de uno salvo especialistas;
* no dividir escuadras innecesariamente;
* eliminar grupos vacíos;
* conservar líder y roles;
* registrar relación con la proyección.

Arma 3 permite crear grupos con la opción de marcarlos para eliminación cuando quedan vacíos; también dispone de `deleteGroupWhenEmpty`. La documentación señala que la eliminación efectiva puede no ser inmediata, por lo que la campaña mantendrá además su propio registro y limpieza. ([Bohemia Community][3])

---

<a id="src-tactical-and-force-virtualization-system--27-tamaños-tácticos-recomendados"></a>
### 27. Tamaños tácticos recomendados

<a id="src-tactical-and-force-virtualization-system--equipo"></a>
#### Equipo

```text
3–5 unidades
```

<a id="src-tactical-and-force-virtualization-system--escuadra"></a>
#### Escuadra

```text
6–10 unidades
```

<a id="src-tactical-and-force-virtualization-system--pelotón-físico"></a>
#### Pelotón físico

```text
18–32 unidades divididas en grupos
```

<a id="src-tactical-and-force-virtualization-system--compañía"></a>
#### Compañía

No se materializa como un único grupo.

Se representa mediante:

* varios grupos;
* reserva;
* mando;
* oleadas.

---

<a id="src-tactical-and-force-virtualization-system--28-registro-de-grupos"></a>
### 28. Registro de grupos

```sqf
IF_groupRegistry = createHashMapFromArray [
    ["groupNetId", ""],
    ["projectionId", "PROJ_BLUE_014"],
    ["formationId", "FORM_BLUE_A_COY_01"],
    ["role", "ASSAULT_SQUAD"],
    ["initialStrength", 8],
    ["currentStrength", 8],
    ["ownerMachineId", 2],
    ["dynamicSimulation", false],
    ["state", "ACTIVE"]
];
```

---

<a id="src-tactical-and-force-virtualization-system--29-localidad"></a>
### 29. Localidad

En multijugador, los grupos y unidades pertenecen a una máquina concreta. Los comandos y condiciones locales deben ejecutarse donde la entidad sea local; `groupOwner` permite consultar desde el servidor qué máquina posee un grupo. ([Bohemia Community][4])

<a id="src-tactical-and-force-virtualization-system--decisión-1"></a>
#### Decisión

El servidor conservará autoridad sobre:

* creación de proyecciones;
* reservas;
* estado estratégico;
* resultados;
* cambios de propietario.

La máquina propietaria del grupo ejecutará:

* movimiento;
* comportamiento táctico;
* órdenes locales;
* control de IA.

---

<a id="src-tactical-and-force-virtualization-system--30-transferencia-de-grupos"></a>
### 30. Transferencia de grupos

`setGroupOwner` permite que el servidor transfiera la propiedad de un grupo y sus unidades a otra máquina, siempre que el líder no sea un jugador; el comando debe ejecutarse desde el servidor. ([Bohemia Community][5])

<a id="src-tactical-and-force-virtualization-system--uso-futuro"></a>
#### Uso futuro

* servidor;
* Headless Client;
* redistribución de carga.

<a id="src-tactical-and-force-virtualization-system--regla-4"></a>
#### Regla

No se transferirán grupos durante:

* combate cercano;
* embarque;
* desembarque;
* cambio de líder;
* interacción narrativa,

salvo que se valide específicamente.

---

<a id="src-tactical-and-force-virtualization-system--31-headless-client-futuro"></a>
### 31. Headless Client futuro

La primera versión no dependerá de Headless Client.

La arquitectura permitirá posteriormente:

* detectar máquinas HC;
* asignar grupos de IA;
* repartir frentes;
* recuperar grupos si el HC se desconecta.

<a id="src-tactical-and-force-virtualization-system--principio"></a>
#### Principio

La campaña debe funcionar primero:

* en SP;
* como servidor local;
* sin infraestructura adicional.

---

<a id="src-tactical-and-force-virtualization-system--32-jugadores-dentro-de-grupos"></a>
### 32. Jugadores dentro de grupos

Los grupos que contienen jugadores requieren tratamiento especial.

Dynamic Simulation no puede habilitarse para grupos que contienen una unidad jugadora. ([Bohemia Community][6])

<a id="src-tactical-and-force-virtualization-system--regla-5"></a>
#### Regla

La unidad protagonista:

* permanecerá activa;
* no se virtualizará mientras contenga un jugador;
* puede separar temporalmente subordinados no jugadores solo mediante lógica explícita.

---

<a id="src-tactical-and-force-virtualization-system--33-waypoints"></a>
### 33. Waypoints

Los waypoints son destinos o tareas sucesivas del grupo. Sus condiciones se evalúan localmente en la máquina propietaria del grupo, mientras que el código de activación puede ejecutarse globalmente; por ello no se colocará lógica autoritativa de campaña directamente en activaciones sin protección. ([Bohemia Community][7])

<a id="src-tactical-and-force-virtualization-system--decisión-2"></a>
#### Decisión

Los waypoints controlarán:

* movimiento táctico;
* comportamiento;
* formación;
* velocidad;
* entrada local.

No decidirán directamente:

* captura estratégica;
* bajas persistentes;
* transferencias económicas;
* finalización autoritativa de misión.

---

<a id="src-tactical-and-force-virtualization-system--34-órdenes-tácticas"></a>
### 34. Órdenes tácticas

Cada paquete generará una secuencia sencilla.

```text
ASSEMBLE
MOVE
DEPLOY
ENGAGE
HOLD
WITHDRAW
REORGANIZE
```

<a id="src-tactical-and-force-virtualization-system--regla-6"></a>
#### Regla

No crear cadenas excesivamente largas de waypoints.

La IA estratégica entrega intención.

El controlador táctico crea únicamente los pasos necesarios para la situación física actual.

---

<a id="src-tactical-and-force-virtualization-system--35-reevaluación-de-waypoints"></a>
### 35. Reevaluación de waypoints

Se regeneran cuando:

* objetivo cambia;
* ruta se bloquea;
* líder muere;
* fuerza se retira;
* misión cambia;
* grupo queda inmovilizado.

<a id="src-tactical-and-force-virtualization-system--no-se-regeneran-continuamente"></a>
#### No se regeneran continuamente

Evitar:

* órdenes contradictorias;
* oscilación;
* carga innecesaria.

---

<a id="src-tactical-and-force-virtualization-system--36-eventos-del-motor"></a>
### 36. Eventos del motor

La campaña utilizará manejadores de eventos para reaccionar a:

* muerte;
* daño;
* abandono;
* entrada o salida;
* grupo vacío;
* waypoint completado.

Arma 3 proporciona Event Handlers para objetos, grupos y misión, incluyendo eventos de grupo como `Empty` y `WaypointComplete`. ([Bohemia Community][8])

<a id="src-tactical-and-force-virtualization-system--decisión-3"></a>
#### Decisión

Los Event Handlers:

* informan al sistema;
* no aplican por sí solos grandes cambios estratégicos;
* envían eventos normalizados al servidor.

---

<a id="src-tactical-and-force-virtualization-system--37-bus-táctico-de-eventos"></a>
### 37. Bus táctico de eventos

Ejemplos:

```text
TACTICAL_UNIT_KILLED
TACTICAL_UNIT_WOUNDED
TACTICAL_VEHICLE_DISABLED
TACTICAL_VEHICLE_DESTROYED
TACTICAL_GROUP_ROUTED
TACTICAL_GROUP_SURRENDERED
TACTICAL_OBJECTIVE_REACHED
TACTICAL_PROJECTION_CLEAR
```

---

<a id="src-tactical-and-force-virtualization-system--38-registro-de-bajas"></a>
### 38. Registro de bajas

Una muerte física no modificará directamente el número estratégico varias veces.

<a id="src-tactical-and-force-virtualization-system--flujo-1"></a>
#### Flujo

1. Unidad física muere.
2. Evento registra su ID.
3. Proyección marca la baja.
4. Se verifica que no fue registrada.
5. Al reintegrar se descuenta.
6. Se actualiza formación.

<a id="src-tactical-and-force-virtualization-system--id"></a>
#### ID

Cada unidad física materializada tendrá:

```text
projectionEntityId
```

---

<a id="src-tactical-and-force-virtualization-system--39-categorías-de-bajas"></a>
### 39. Categorías de bajas

```text
KILLED
WOUNDED_LIGHT
WOUNDED_SERIOUS
MISSING
CAPTURED
DESERTED
RETURNED_TO_DUTY
```

<a id="src-tactical-and-force-virtualization-system--woundedlight"></a>
#### WOUNDED_LIGHT

Puede reintegrarse pronto.

<a id="src-tactical-and-force-virtualization-system--woundedserious"></a>
#### WOUNDED_SERIOUS

Necesita capacidad médica.

<a id="src-tactical-and-force-virtualization-system--missing"></a>
#### MISSING

Resultado todavía desconocido.

<a id="src-tactical-and-force-virtualization-system--captured"></a>
#### CAPTURED

Pasa a sistema de prisioneros.

<a id="src-tactical-and-force-virtualization-system--deserted"></a>
#### DESERTED

No siempre se une al enemigo.

---

<a id="src-tactical-and-force-virtualization-system--40-heridos-físicos"></a>
### 40. Heridos físicos

No todos los daños tácticos deben convertirse en heridos estratégicos persistentes.

Se evaluará:

* daño;
* estado al finalizar;
* evacuación;
* tratamiento;
* misión.

<a id="src-tactical-and-force-virtualization-system--resultado"></a>
#### Resultado

Un soldado incapacitado puede terminar:

* recuperado;
* herido leve;
* herido grave;
* capturado;
* muerto.

---

<a id="src-tactical-and-force-virtualization-system--41-personajes-nombrados"></a>
### 41. Personajes nombrados

Los personajes importantes poseen:

* ID propio;
* salud;
* heridas;
* estado;
* relaciones;
* inventario narrativo.

<a id="src-tactical-and-force-virtualization-system--regla-7"></a>
#### Regla

No se sustituyen por un soldado agregado al reintegrar.

Pueden quedar:

```text
ACTIVE
WOUNDED
HOSPITALIZED
MISSING
CAPTURED
DEAD
```

---

<a id="src-tactical-and-force-virtualization-system--42-soldados-genéricos"></a>
### 42. Soldados genéricos

Los soldados genéricos representan miembros agregados de una formación.

Al materializarlos pueden recibir:

* identidad visual;
* nombre local;
* rol.

No necesitan persistir individualmente durante toda la campaña salvo que:

* sobrevivan eventos especiales;
* sean ascendidos;
* interactúen narrativamente;
* se conviertan en prisioneros o testigos.

---

<a id="src-tactical-and-force-virtualization-system--43-promoción-a-entidad-persistente"></a>
### 43. Promoción a entidad persistente

Un soldado genérico puede convertirse en personaje persistente si:

* salva a un miembro;
* lidera tras muerte del mando;
* es capturado;
* aparece repetidamente;
* participa en una escena.

<a id="src-tactical-and-force-virtualization-system--resultado-1"></a>
#### Resultado

Recibe:

```text
characterId
history
relationships
persistentState
```

---

<a id="src-tactical-and-force-virtualization-system--44-moral-táctica"></a>
### 44. Moral táctica

La moral física deriva de:

* moral estratégica;
* líder;
* bajas;
* fuego recibido;
* apoyo;
* aislamiento;
* suministro.

<a id="src-tactical-and-force-virtualization-system--estados"></a>
#### Estados

```text
CONFIDENT
STEADY
SHAKEN
BROKEN
ROUTING
SURRENDERING
```

---

<a id="src-tactical-and-force-virtualization-system--45-cohesión-táctica"></a>
### 45. Cohesión táctica

Representa la capacidad de actuar como grupo.

Disminuye por:

* líderes muertos;
* separación;
* fuego intenso;
* pérdidas;
* comunicaciones;
* órdenes contradictorias.

<a id="src-tactical-and-force-virtualization-system--efectos"></a>
#### Efectos

* retrasos;
* dispersión;
* retirada;
* menor coordinación.

---

<a id="src-tactical-and-force-virtualization-system--46-retirada"></a>
### 46. Retirada

La IA puede retirarse cuando:

* objetivo ya no es viable;
* moral cae;
* pérdidas superan umbral;
* ruta permanece abierta;
* comandante lo ordena;
* suministro es crítico.

<a id="src-tactical-and-force-virtualization-system--fases"></a>
#### Fases

```text
DISENGAGE
BREAK_CONTACT
MOVE_TO_EXIT
CROSS_TRANSITION
REINTEGRATE
```

---

<a id="src-tactical-and-force-virtualization-system--47-retirada-no-equivale-a-desaparición"></a>
### 47. Retirada no equivale a desaparición

La fuerza retirada:

* conserva supervivientes;
* pierde equipo abandonado;
* puede llegar a otro sector;
* necesita reorganización;
* puede ser perseguida.

<a id="src-tactical-and-force-virtualization-system--si-no-existe-ruta"></a>
#### Si no existe ruta

Puede:

* dispersarse;
* rendirse;
* intentar infiltración;
* quedar aislada.

---

<a id="src-tactical-and-force-virtualization-system--48-persecución"></a>
### 48. Persecución

El jugador o la IA puede perseguir.

<a id="src-tactical-and-force-virtualization-system--riesgos"></a>
#### Riesgos

* emboscada;
* sobreextensión;
* separación logística;
* entrada en otro sector.

<a id="src-tactical-and-force-virtualization-system--regla-8"></a>
#### Regla

Perseguir puede convertir una victoria defensiva en una derrota operacional.

---

<a id="src-tactical-and-force-virtualization-system--49-rendición"></a>
### 49. Rendición

Una unidad puede rendirse cuando:

* está cercada;
* moral está rota;
* carece de munición;
* mando desapareció;
* enemigo ofrece términos;
* civiles están en riesgo.

<a id="src-tactical-and-force-virtualization-system--no-se-rinde-automáticamente"></a>
#### No se rinde automáticamente

* toda facción;
* todo grupo con pocas unidades;
* todo enemigo incapacitado.

---

<a id="src-tactical-and-force-virtualization-system--50-proceso-de-rendición"></a>
### 50. Proceso de rendición

```text
SIGNAL
CEASE_FIRE
DISARM
ASSEMBLE
REGISTER
TRANSFER
```

<a id="src-tactical-and-force-virtualization-system--riesgo"></a>
#### Riesgo

La rendición puede fracasar por:

* disparos;
* confusión;
* radicales;
* orden contradictoria.

---

<a id="src-tactical-and-force-virtualization-system--51-prisioneros"></a>
### 51. Prisioneros

Los prisioneros físicos deberán registrarse individualmente o por lote.

<a id="src-tactical-and-force-virtualization-system--información"></a>
#### Información

```text
prisonerId
originFormation
rank
role
health
captor
location
registered
interrogated
transferStatus
```

<a id="src-tactical-and-force-virtualization-system--reintegración-estratégica"></a>
#### Reintegración estratégica

Se descuentan como:

```text
CAPTURED
```

de su formación de origen.

---

<a id="src-tactical-and-force-virtualization-system--52-deserción-y-dispersión"></a>
### 52. Deserción y dispersión

Una unidad dispersa no se considera destruida.

Sus miembros pueden:

* volver;
* ocultarse;
* unirse a FIA;
* convertirse en civiles;
* desertar a otra fuerza;
* ser capturados.

<a id="src-tactical-and-force-virtualization-system--verde"></a>
#### Verde

Este sistema es especialmente importante durante su fragmentación.

---

<a id="src-tactical-and-force-virtualization-system--53-vehículos-persistentes"></a>
### 53. Vehículos persistentes

Los vehículos importantes tendrán ID estable.

```text
vehicleId
classAlias
originalFaction
currentOwner
assignedFormation
condition
fuel
ammo
crew
location
status
```

---

<a id="src-tactical-and-force-virtualization-system--54-vehículos-únicos-y-agregados"></a>
### 54. Vehículos únicos y agregados

<a id="src-tactical-and-force-virtualization-system--persistentes-individualmente"></a>
#### Persistentes individualmente

* carros;
* IFV;
* aeronaves;
* artillería;
* vehículos protagonistas;
* vehículos narrativos;
* transportes especializados.

<a id="src-tactical-and-force-virtualization-system--agregados-por-cantidad"></a>
#### Agregados por cantidad

* ciertos camiones comunes;
* vehículos civiles;
* embarcaciones menores;
* transportes genéricos.

<a id="src-tactical-and-force-virtualization-system--regla-9"></a>
#### Regla

Un vehículo agregado puede convertirse en persistente cuando se materializa para una misión relevante.

---

<a id="src-tactical-and-force-virtualization-system--55-reserva-de-vehículos"></a>
### 55. Reserva de vehículos

Antes de materializar:

* comprobar existencia;
* estado;
* tripulación;
* combustible;
* misión;
* reserva.

<a id="src-tactical-and-force-virtualization-system--no-se-permite"></a>
#### No se permite

Que el mismo vehículo aparezca:

* en un convoy;
* en una guarnición;
* en reparación;
* en otra misión.

---

<a id="src-tactical-and-force-virtualization-system--56-daño-de-vehículos"></a>
### 56. Daño de vehículos

Estados:

```text
OPERATIONAL
DAMAGED_LIGHT
DAMAGED_HEAVY
IMMOBILIZED
ABANDONED
RECOVERABLE
CAPTURED
DESTROYED
SALVAGED
```

<a id="src-tactical-and-force-virtualization-system--reintegration"></a>
#### Reintegration

Se registra:

* daño;
* componentes;
* munición;
* combustible;
* tripulación;
* posición.

---

<a id="src-tactical-and-force-virtualization-system--57-abandono"></a>
### 57. Abandono

Un vehículo puede quedar físicamente en el mundo cuando:

* es recuperable;
* está cerca de una zona activa;
* puede capturarse;
* posee valor narrativo.

<a id="src-tactical-and-force-virtualization-system--virtualización-posterior"></a>
#### Virtualización posterior

Si queda lejos:

* se registra ubicación;
* se elimina el objeto físico;
* se conserva como activo recuperable virtual.

---

<a id="src-tactical-and-force-virtualization-system--58-captura-de-vehículo"></a>
### 58. Captura de vehículo

Requiere:

* control físico;
* tripulación;
* reparación;
* conocimiento;
* tiempo.

<a id="src-tactical-and-force-virtualization-system--estado"></a>
#### Estado

```text
originalOwner
capturingFaction
captureProgress
compatibility
```

---

<a id="src-tactical-and-force-virtualization-system--59-munición-física-y-estratégica"></a>
### 59. Munición física y estratégica

Durante la batalla:

* el objeto utiliza cargadores reales;
* dispara munición física.

Al reintegrar:

* se estima consumo;
* se descuenta del paquete táctico;
* se actualiza el recurso estratégico.

<a id="src-tactical-and-force-virtualization-system--regla-10"></a>
#### Regla

No registrar cada bala globalmente fuera de la batalla.

---

<a id="src-tactical-and-force-virtualization-system--60-combustible-físico-y-estratégico"></a>
### 60. Combustible físico y estratégico

Al materializar un vehículo:

* recibe combustible coherente con su estado.

Al reintegrar:

* se mide consumo;
* se descuenta.

<a id="src-tactical-and-force-virtualization-system--seguridad"></a>
#### Seguridad

No permitir llenar un vehículo físicamente y reintegrarlo sin descontar el recurso correspondiente.

---

<a id="src-tactical-and-force-virtualization-system--61-inventario-de-unidades"></a>
### 61. Inventario de unidades

El equipamiento individual se genera según:

* facción;
* rol;
* formación;
* disponibilidad;
* experiencia.

<a id="src-tactical-and-force-virtualization-system--persistencia-completa"></a>
#### Persistencia completa

Solo para:

* protagonistas;
* personajes;
* armas únicas;
* evidencia.

<a id="src-tactical-and-force-virtualization-system--persistencia-agregada"></a>
#### Persistencia agregada

Para soldados genéricos:

* tipo de arma;
* nivel de munición;
* equipo especial.

---

<a id="src-tactical-and-force-virtualization-system--62-batallas-virtuales"></a>
### 62. Batallas virtuales

Una batalla virtual ocurre cuando dos o más fuerzas interactúan fuera de la burbuja táctica.

<a id="src-tactical-and-force-virtualization-system--requisitos-1"></a>
#### Requisitos

* fuerzas válidas;
* ubicación o conexión compartida;
* plan;
* tiempo;
* suministro;
* contacto.

---

<a id="src-tactical-and-force-virtualization-system--63-estados-de-batalla-virtual"></a>
### 63. Estados de batalla virtual

```text
FORMING
SKIRMISH
ENGAGED
INTENSE
BREAKTHROUGH
WITHDRAWAL
PURSUIT
ENDED
```

---

<a id="src-tactical-and-force-virtualization-system--64-resolución-por-fases"></a>
### 64. Resolución por fases

La batalla no se resolverá con una tirada instantánea única.

<a id="src-tactical-and-force-virtualization-system--fase-1-contacto"></a>
#### Fase 1 — Contacto

* reconocimiento;
* sorpresa;
* posiciones.

<a id="src-tactical-and-force-virtualization-system--fase-2-fijación"></a>
#### Fase 2 — Fijación

* intercambio;
* evaluación;
* primeras bajas.

<a id="src-tactical-and-force-virtualization-system--fase-3-acción-principal"></a>
#### Fase 3 — Acción principal

* asalto;
* defensa;
* flanco;
* apoyo.

<a id="src-tactical-and-force-virtualization-system--fase-4-decisión"></a>
#### Fase 4 — Decisión

* sostener;
* reforzar;
* retirarse;
* rendirse.

<a id="src-tactical-and-force-virtualization-system--fase-5-explotación"></a>
#### Fase 5 — Explotación

* persecución;
* captura;
* consolidación.

---

<a id="src-tactical-and-force-virtualization-system--65-intervalos-de-resolución"></a>
### 65. Intervalos de resolución

Cada fase tendrá duración estratégica.

<a id="src-tactical-and-force-virtualization-system--ejemplo-4"></a>
#### Ejemplo

```text
Escaramuza:
5–15 minutos.

Combate de sector:
15–60 minutos por fase.

Batalla regional:
varias horas.
```

<a id="src-tactical-and-force-virtualization-system--ventaja"></a>
#### Ventaja

El jugador puede intervenir antes de la resolución final.

---

<a id="src-tactical-and-force-virtualization-system--66-factores-de-poder-de-combate"></a>
### 66. Factores de poder de combate

```text
manpower
weaponCapability
vehicleCapability
readiness
morale
cohesion
experience
supply
terrain
fortifications
intelligence
commander
support
surprise
```

<a id="src-tactical-and-force-virtualization-system--regla-11"></a>
#### Regla

No utilizar solamente cantidad de soldados.

---

<a id="src-tactical-and-force-virtualization-system--67-poder-efectivo-conceptual"></a>
### 67. Poder efectivo conceptual

```text
Poder efectivo =
fuerza disponible
× preparación
× moral
× cohesión
× suministro
× compatibilidad con terreno
× calidad de mando
+ apoyos
```

La fórmula exacta deberá balancearse y permanecer configurable.

---

<a id="src-tactical-and-force-virtualization-system--68-superioridad-local"></a>
### 68. Superioridad local

La fuerza total de una facción en Altis no importa directamente si:

* no puede llegar;
* está comprometida;
* carece de ruta;
* está desinformada.

La batalla utiliza únicamente:

* fuerzas presentes;
* reservas capaces de intervenir;
* apoyos disponibles.

---

<a id="src-tactical-and-force-virtualization-system--69-terreno-virtual"></a>
### 69. Terreno virtual

Cada sector y conexión aportará modificadores.

<a id="src-tactical-and-force-virtualization-system--urbano"></a>
#### Urbano

* favorece infantería;
* limita blindados;
* aumenta daño civil.

<a id="src-tactical-and-force-virtualization-system--colina"></a>
#### Colina

* observación;
* defensa;
* movimiento lento.

<a id="src-tactical-and-force-virtualization-system--llanura"></a>
#### Llanura

* maniobra;
* blindados;
* exposición.

<a id="src-tactical-and-force-virtualization-system--bosque"></a>
#### Bosque

* ocultamiento;
* emboscada;
* menor apoyo aéreo.

<a id="src-tactical-and-force-virtualization-system--costa"></a>
#### Costa

* desembarco;
* vulnerabilidad;
* rutas limitadas.

---

<a id="src-tactical-and-force-virtualization-system--70-fortificaciones-virtuales"></a>
### 70. Fortificaciones virtuales

Los módulos defensivos aportan:

* preparación;
* protección;
* observación;
* AT;
* AA;
* reserva.

<a id="src-tactical-and-force-virtualization-system--daño"></a>
#### Daño

Una batalla virtual puede:

* degradar módulos;
* destruirlos;
* capturarlos.

---

<a id="src-tactical-and-force-virtualization-system--71-inteligencia-en-resolución"></a>
### 71. Inteligencia en resolución

La batalla virtual utiliza el conocimiento percibido de cada comandante.

<a id="src-tactical-and-force-virtualization-system--consecuencia"></a>
#### Consecuencia

Una fuerza puede:

* atacar una posición más fuerte de lo esperado;
* reservar unidades ante una amenaza inexistente;
* caer en engaño.

<a id="src-tactical-and-force-virtualization-system--regla-12"></a>
#### Regla

El resolutor conoce la realidad para calcular el resultado, pero las decisiones previas de cada actor utilizan sus creencias.

---

<a id="src-tactical-and-force-virtualization-system--72-sorpresa"></a>
### 72. Sorpresa

La sorpresa depende de:

* detección;
* ocultamiento;
* inteligencia;
* movimiento;
* doctrina;
* comunicaciones.

<a id="src-tactical-and-force-virtualization-system--efectos-1"></a>
#### Efectos

* primeras bajas;
* posición;
* retirada tardía;
* pérdida de cohesión.

---

<a id="src-tactical-and-force-virtualization-system--73-apoyos-virtuales"></a>
### 73. Apoyos virtuales

Pueden incluir:

* artillería;
* aviación;
* morteros;
* drones;
* reservas;
* guerra electrónica.

<a id="src-tactical-and-force-virtualization-system--requisitos-2"></a>
#### Requisitos

* disponibilidad;
* alcance;
* munición;
* combustible;
* comunicación;
* autorización.

---

<a id="src-tactical-and-force-virtualization-system--74-intervención-del-jugador-en-batalla-virtual"></a>
### 74. Intervención del jugador en batalla virtual

Una batalla virtual puede convertirse en misión.

<a id="src-tactical-and-force-virtualization-system--momentos"></a>
#### Momentos

* antes del contacto;
* durante fijación;
* en crisis;
* durante retirada;
* para explotación.

<a id="src-tactical-and-force-virtualization-system--efecto"></a>
#### Efecto

La batalla se congela parcialmente mientras se reserva y materializa el fragmento relevante.

---

<a id="src-tactical-and-force-virtualization-system--75-conversión-virtual-a-física"></a>
### 75. Conversión virtual a física

<a id="src-tactical-and-force-virtualization-system--fase-1"></a>
#### Fase 1

Seleccionar fuerzas comprometidas.

<a id="src-tactical-and-force-virtualization-system--fase-2"></a>
#### Fase 2

Registrar estado previo.

<a id="src-tactical-and-force-virtualization-system--fase-3"></a>
#### Fase 3

Elegir representación física.

<a id="src-tactical-and-force-virtualization-system--fase-4"></a>
#### Fase 4

Crear terreno táctico usando el sector real.

<a id="src-tactical-and-force-virtualization-system--fase-5"></a>
#### Fase 5

Aplicar bajas ya ocurridas.

<a id="src-tactical-and-force-virtualization-system--fase-6"></a>
#### Fase 6

Posicionar grupos coherentemente.

<a id="src-tactical-and-force-virtualization-system--fase-7"></a>
#### Fase 7

Entregar control a IA táctica.

---

<a id="src-tactical-and-force-virtualization-system--76-batalla-parcialmente-resuelta"></a>
### 76. Batalla parcialmente resuelta

Si el jugador entra después de varias fases:

* posiciones pueden estar dañadas;
* unidades ya sufrieron bajas;
* vehículos pueden arder;
* munición puede estar baja;
* una retirada puede haber comenzado.

<a id="src-tactical-and-force-virtualization-system--principio-1"></a>
#### Principio

La batalla no espera intacta al jugador.

---

<a id="src-tactical-and-force-virtualization-system--77-conversión-física-a-virtual"></a>
### 77. Conversión física a virtual

Al terminar la participación:

1. Determinar resultado local.
2. Registrar supervivientes.
3. Registrar vehículos.
4. Registrar control de puntos.
5. Calcular fuerzas no materializadas.
6. Resolver fase restante.
7. Actualizar batalla estratégica.

---

<a id="src-tactical-and-force-virtualization-system--78-no-duplicación-entre-batalla-y-misión"></a>
### 78. No duplicación entre batalla y misión

Cuando una batalla se materializa:

```text
virtualResolutionPaused = true
```

para los activos reservados.

<a id="src-tactical-and-force-virtualization-system--puede-continuar"></a>
#### Puede continuar

* combate de fuerzas no materializadas;
* otros frentes;
* reservas lejanas.

<a id="src-tactical-and-force-virtualization-system--no-puede-continuar"></a>
#### No puede continuar

La misma escuadra combatiendo virtual y físicamente.

---

<a id="src-tactical-and-force-virtualization-system--79-resultado-virtual"></a>
### 79. Resultado virtual

```text
TACTICAL_VICTORY
TACTICAL_DEFEAT
OPERATIONAL_VICTORY
OPERATIONAL_DEFEAT
STALEMATE
ORDERLY_WITHDRAWAL
ROUT
SURRENDER
```

<a id="src-tactical-and-force-virtualization-system--diferencia"></a>
#### Diferencia

Una victoria táctica puede no producir control si:

* no existe guarnición;
* no hay suministro;
* la fuerza está agotada.

---

<a id="src-tactical-and-force-virtualization-system--80-pérdidas-virtuales"></a>
### 80. Pérdidas virtuales

Se distribuyen en:

* muertos;
* heridos;
* desaparecidos;
* capturados;
* vehículos;
* munición;
* moral.

<a id="src-tactical-and-force-virtualization-system--regla-13"></a>
#### Regla

Evitar resultados donde toda derrota destruya automáticamente a la formación.

---

<a id="src-tactical-and-force-virtualization-system--81-límites-de-pérdidas"></a>
### 81. Límites de pérdidas

Los resultados tendrán:

* mínimos;
* máximos;
* coherencia temporal;
* capacidad del enemigo.

<a id="src-tactical-and-force-virtualization-system--ejemplo-5"></a>
#### Ejemplo

Una escaramuza de diez minutos no debe eliminar una compañía completa sin:

* artillería;
* cerco;
* evento extraordinario.

---

<a id="src-tactical-and-force-virtualization-system--82-semilla-y-reproducibilidad"></a>
### 82. Semilla y reproducibilidad

Cada fase virtual tendrá:

```text
resolutionSeed
```

<a id="src-tactical-and-force-virtualization-system--función"></a>
#### Función

* reproducir errores;
* validar balance;
* impedir cambios arbitrarios tras cargar.

<a id="src-tactical-and-force-virtualization-system--persistencia"></a>
#### Persistencia

La semilla y fase actual se guardan.

---

<a id="src-tactical-and-force-virtualization-system--83-cadáveres"></a>
### 83. Cadáveres

No todos los cadáveres permanecerán indefinidamente.

<a id="src-tactical-and-force-virtualization-system--categorías"></a>
#### Categorías

<a id="src-tactical-and-force-virtualization-system--narrativo"></a>
##### Narrativo

Permanece hasta resolución.

<a id="src-tactical-and-force-virtualization-system--identificable"></a>
##### Identificable

Puede producir:

* cuerpo;
* investigación;
* funeral.

<a id="src-tactical-and-force-virtualization-system--ambiental-temporal"></a>
##### Ambiental temporal

Se limpia después de:

* tiempo;
* distancia;
* registro.

<a id="src-tactical-and-force-virtualization-system--regla-14"></a>
#### Regla

Limpiar un cadáver físico no elimina la baja estratégica.

---

<a id="src-tactical-and-force-virtualization-system--84-restos-de-vehículos"></a>
### 84. Restos de vehículos

Pueden permanecer cuando:

* son visibles;
* recuperables;
* narrativos;
* recientes.

<a id="src-tactical-and-force-virtualization-system--limpieza"></a>
#### Limpieza

Después:

* se crea estado de salvamento;
* se conserva memoria del incidente;
* se elimina el objeto físico.

---

<a id="src-tactical-and-force-virtualization-system--85-objetos-caídos"></a>
### 85. Objetos caídos

Armas, mochilas y contenedores pueden acumularse.

<a id="src-tactical-and-force-virtualization-system--política"></a>
#### Política

* registrar objetos importantes;
* limpiar equipo genérico;
* preservar evidencia;
* preservar recursos recuperables seleccionados.

---

<a id="src-tactical-and-force-virtualization-system--86-composiciones-y-daños-persistentes"></a>
### 86. Composiciones y daños persistentes

Las composiciones del sector se materializan según:

* estado;
* propietario;
* daño;
* módulo.

Al salir:

* condición se calcula;
* armas destruidas se registran;
* objetos secundarios no se guardan individualmente si pueden reconstruirse desde el porcentaje de daño.

---

<a id="src-tactical-and-force-virtualization-system--87-presupuesto-inicial-de-rendimiento"></a>
### 87. Presupuesto inicial de rendimiento

<a id="src-tactical-and-force-virtualization-system--ia-activa-ordinaria"></a>
#### IA activa ordinaria

```text
70–110
```

<a id="src-tactical-and-force-virtualization-system--batalla-grande"></a>
#### Batalla grande

```text
120–160
```

sujeto a pruebas.

<a id="src-tactical-and-force-virtualization-system--grupos-activos"></a>
#### Grupos activos

Objetivo inicial:

```text
12–24 grupos tácticos relevantes
```

<a id="src-tactical-and-force-virtualization-system--vehículos"></a>
#### Vehículos

```text
8–16 terrestres activos
0–3 aeronaves
```

---

<a id="src-tactical-and-force-virtualization-system--88-prioridad-de-rendimiento"></a>
### 88. Prioridad de rendimiento

Cuando se alcance el presupuesto:

1. Mantener amenazas visibles.
2. Mantener aliados cercanos.
3. Mantener personajes.
4. Retrasar refuerzos lejanos.
5. Reducir tamaño de proyección.
6. Resolver elementos secundarios virtualmente.
7. No degradar mediante desapariciones visibles.

---

<a id="src-tactical-and-force-virtualization-system--89-presupuesto-adaptativo"></a>
### 89. Presupuesto adaptativo

El sistema puede ajustar:

* cantidad de grupos;
* frecuencia de evaluación;
* tamaño de oleadas;
* distancia de activación;
* cantidad de civiles.

<a id="src-tactical-and-force-virtualization-system--no-debe-ajustar"></a>
#### No debe ajustar

* reservas estratégicas;
* resultado narrativo predeterminado;
* salud artificial de enemigos.

---

<a id="src-tactical-and-force-virtualization-system--90-dynamic-simulation"></a>
### 90. Dynamic Simulation

El sistema oficial puede aplicarse selectivamente a objetos y grupos para reducir simulación de entidades que no necesitan estar activas. Para grupos trabaja como una unidad completa y sus ajustes globales deben gestionarse preferentemente desde el servidor. ([Bohemia Community][1])

<a id="src-tactical-and-force-virtualization-system--uso-en-islas-fracturadas"></a>
#### Uso en Islas Fracturadas

Apropiado para:

* guarniciones físicas lejanas dentro de la región;
* vehículos estacionados;
* patrullas en espera;
* decoraciones funcionales.

No apropiado como sustituto de:

* convoyes virtuales en movimiento;
* fuerzas que atraviesan sectores;
* batallas estratégicas lejanas;
* economía;
* población agregada.

---

<a id="src-tactical-and-force-virtualization-system--91-objetos-que-no-deben-depender-de-dynamic-simulation"></a>
### 91. Objetos que no deben depender de Dynamic Simulation

* minas;
* lógica;
* estado persistente;
* temporizadores estratégicos;
* movimiento virtual;
* eventos políticos;
* producción.

El comando de Dynamic Simulation no afecta a minas, según la documentación oficial. ([Bohemia Community][6])

---

<a id="src-tactical-and-force-virtualization-system--92-programador-central"></a>
### 92. Programador central

No se crearán bucles permanentes por:

* unidad;
* formación;
* sector;
* vehículo.

<a id="src-tactical-and-force-virtualization-system--se-utilizarán"></a>
#### Se utilizarán

* scheduler central;
* colas;
* eventos;
* lotes;
* frecuencias por prioridad.

---

<a id="src-tactical-and-force-virtualization-system--93-frecuencias-tácticas"></a>
### 93. Frecuencias tácticas

<a id="src-tactical-and-force-virtualization-system--activo-cercano"></a>
#### Activo cercano

```text
0,5–2 segundos según función
```

<a id="src-tactical-and-force-virtualization-system--grupo-en-transición"></a>
#### Grupo en transición

```text
5–15 segundos
```

<a id="src-tactical-and-force-virtualization-system--proyección-dormida"></a>
#### Proyección dormida

```text
30–90 segundos
```

<a id="src-tactical-and-force-virtualization-system--formación-virtual"></a>
#### Formación virtual

Procesada por el ciclo estratégico.

---

<a id="src-tactical-and-force-virtualization-system--94-limpieza-de-grupos"></a>
### 94. Limpieza de grupos

Después de una proyección:

* eliminar waypoints;
* retirar manejadores;
* eliminar unidades;
* confirmar grupo vacío;
* eliminar referencia;
* liberar ID.

<a id="src-tactical-and-force-virtualization-system--regla-15"></a>
#### Regla

No confiar únicamente en que el motor elimine grupos vacíos automáticamente.

---

<a id="src-tactical-and-force-virtualization-system--95-registro-de-entidades-físicas"></a>
### 95. Registro de entidades físicas

```sqf
IF_entityRegistry = createHashMapFromArray [
    ["entityKey", "ENT_PROJ_014_UNIT_03"],
    ["object", objNull],
    ["projectionId", "PROJ_BLUE_014"],
    ["formationId", "FORM_BLUE_A_COY_01"],
    ["entityType", "INFANTRY"],
    ["persistentCharacterId", ""],
    ["persistentVehicleId", ""],
    ["state", "ACTIVE"],
    ["casualtyRegistered", false]
];
```

---

<a id="src-tactical-and-force-virtualization-system--96-recuperación-tras-errores"></a>
### 96. Recuperación tras errores

Si una entidad física desaparece inesperadamente:

* comprobar registro;
* comprobar muerte;
* comprobar vehículo;
* reconstruir estado;
* marcar incidente;
* no duplicarla automáticamente.

<a id="src-tactical-and-force-virtualization-system--estado-1"></a>
#### Estado

```text
ORPHANED
MISSING_ENTITY
RECOVERED
FORCED_REINTEGRATION
```

---

<a id="src-tactical-and-force-virtualization-system--97-guardado-durante-combate"></a>
### 97. Guardado durante combate

El guardado registrará:

* proyecciones;
* grupos;
* entidades persistentes;
* posiciones;
* daños;
* objetivos;
* reservas;
* batalla virtual pausada.

<a id="src-tactical-and-force-virtualization-system--al-cargar"></a>
#### Al cargar

Puede:

* reconstruir físicamente la escena;
* o convertirla a una fase segura equivalente,

según el tipo de guardado.

---

<a id="src-tactical-and-force-virtualization-system--98-puntos-de-guardado-seguro"></a>
### 98. Puntos de guardado seguro

Preferidos:

* antes de misión;
* después de misión;
* fuera de combate;
* durante transición controlada.

<a id="src-tactical-and-force-virtualization-system--guardado-manual-en-combate"></a>
#### Guardado manual en combate

Podrá permitirse, pero requiere:

* snapshot táctico completo;
* pruebas intensivas;
* protección contra duplicaciones.

---

<a id="src-tactical-and-force-virtualization-system--99-reinicio-de-misión-sin-reiniciar-campaña"></a>
### 99. Reinicio de misión sin reiniciar campaña

Si el jugador repite una misión tras morir:

* se restaura el snapshot previo;
* se revierten reservas;
* se revierten bajas de esa instancia;
* se conserva únicamente el estado anterior al inicio.

<a id="src-tactical-and-force-virtualization-system--no-se-permite-1"></a>
#### No se permite

Mezclar consecuencias de un intento fallido con el reinicio limpio, salvo modo de juego específico.

---

<a id="src-tactical-and-force-virtualization-system--100-unidad-protagonista"></a>
### 100. Unidad protagonista

AZUR-1 y RUBÍ-1 son formaciones persistentes especiales.

Su autoridad, cohesión, especialistas, capacidades, reemplazos y desbloqueos se rigen por [PLAYER_PROGRESSION_AUTHORITY_AND_UNLOCKS_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-progression-authority-and-unlocks-system).

<a id="src-tactical-and-force-virtualization-system--reglas-1"></a>
#### Reglas

* sus miembros poseen identidad;
* sus heridas persisten;
* sus muertes cambian composición;
* los reemplazos se registran;
* su equipo puede evolucionar;
* no se virtualizan mientras el jugador está presente.

---

<a id="src-tactical-and-force-virtualization-system--101-separación-de-la-escuadra"></a>
### 101. Separación de la escuadra

El jugador puede operar con:

* escuadra completa;
* equipo reducido;
* especialistas;
* refuerzos temporales.

<a id="src-tactical-and-force-virtualization-system--estado-2"></a>
#### Estado

Los miembros no desplegados permanecen:

* en base;
* recuperándose;
* asignados a otra tarea explícita.

No desaparecen narrativamente.

---

<a id="src-tactical-and-force-virtualization-system--102-aliados-temporales"></a>
### 102. Aliados temporales

Una misión puede añadir:

* escuadra;
* vehículo;
* guía;
* unidad Verde;
* equipo FIA.

<a id="src-tactical-and-force-virtualization-system--mando"></a>
#### Mando

No todos deben incorporarse al grupo del jugador.

Pueden conservar:

* su propio grupo;
* waypoints;
* objetivos;
* autonomía.

---

<a id="src-tactical-and-force-virtualization-system--103-high-command"></a>
### 103. High Command

High Command podrá utilizarse opcionalmente para permitir que el jugador controle un número limitado de grupos durante operaciones concretas.

<a id="src-tactical-and-force-virtualization-system--no-será"></a>
#### No será

* el motor estratégico;
* la interfaz principal de toda la guerra;
* un sistema para controlar cientos de unidades.

---

<a id="src-tactical-and-force-virtualization-system--104-mando-táctico-del-jugador"></a>
### 104. Mando táctico del jugador

Según autoridad, podrá:

* solicitar movimiento;
* definir punto;
* ordenar apoyo;
* asignar objetivo;
* ordenar retirada.

<a id="src-tactical-and-force-virtualization-system--limitación"></a>
#### Limitación

Los grupos pueden:

* retrasarse;
* rechazar por imposibilidad;
* perder comunicación;
* interpretar la orden.

---

<a id="src-tactical-and-force-virtualization-system--105-interacción-con-ia-estratégica"></a>
### 105. Interacción con IA estratégica

La IA estratégica decide:

```text
qué fuerza
para qué misión
en qué sector
con qué prioridad
```

El controlador táctico decide:

```text
qué grupos físicos
qué rutas locales
qué posiciones
qué waypoints
qué retirada
```

El motor Arma decide:

```text
movimiento inmediato
detección
puntería
cobertura
combate
```

---

<a id="src-tactical-and-force-virtualization-system--106-separación-de-responsabilidades"></a>
### 106. Separación de responsabilidades

<a id="src-tactical-and-force-virtualization-system--estrategia"></a>
#### Estrategia

No debe microgestionar:

* cada soldado;
* cada ventana;
* cada cobertura.

<a id="src-tactical-and-force-virtualization-system--táctica"></a>
#### Táctica

No debe decidir:

* guerra nacional;
* producción;
* alianzas;
* reemplazos.

<a id="src-tactical-and-force-virtualization-system--persistencia-1"></a>
#### Persistencia

No debe depender de que una unidad física continúe existiendo.

---

<a id="src-tactical-and-force-virtualization-system--107-resolución-de-objetivos-tácticos"></a>
### 107. Resolución de objetivos tácticos

Los objetivos físicos enviarán eventos.

Ejemplo:

```text
OBJECTIVE_COMMAND_POST_SECURED
```

El servidor verifica:

* control;
* fuerzas;
* estado;
* misión.

Después aplica:

* consecuencia táctica;
* posible consecuencia estratégica.

---

<a id="src-tactical-and-force-virtualization-system--108-captura-territorial"></a>
### 108. Captura territorial

Eliminar enemigos no basta.

Se evalúa:

* puntos esenciales;
* presencia;
* retirada enemiga;
* conexión;
* guarnición;
* consolidación.

<a id="src-tactical-and-force-virtualization-system--regla-16"></a>
#### Regla

El controlador táctico informa.

El sistema territorial decide el cambio definitivo.

---

<a id="src-tactical-and-force-virtualization-system--109-fuego-amigo"></a>
### 109. Fuego amigo

Se registrará:

* responsable;
* víctima;
* contexto;
* percepción;
* evidencia.

<a id="src-tactical-and-force-virtualization-system--consecuencias"></a>
#### Consecuencias

* moral;
* relaciones;
* disciplina;
* propaganda;
* investigación.

---

<a id="src-tactical-and-force-virtualization-system--110-daño-civil"></a>
### 110. Daño civil

Los eventos tácticos producen incidentes civiles.

<a id="src-tactical-and-force-virtualization-system--se-registra"></a>
#### Se registra

* arma;
* responsable real;
* responsable percibido;
* sector;
* testigos;
* misión.

<a id="src-tactical-and-force-virtualization-system--regla-17"></a>
#### Regla

No esperar al final de la misión para inventar una cifra de bajas civiles.

---

<a id="src-tactical-and-force-virtualization-system--111-artillería"></a>
### 111. Artillería

El fuego indirecto puede resolverse:

* físicamente cerca;
* abstractamente lejos.

<a id="src-tactical-and-force-virtualization-system--cerca"></a>
#### Cerca

Se materializan:

* proyectiles;
* daños;
* advertencias.

<a id="src-tactical-and-force-virtualization-system--lejos"></a>
#### Lejos

Se resuelve:

* consumo;
* daño estimado;
* supresión;
* infraestructura;
* bajas.

---

<a id="src-tactical-and-force-virtualization-system--112-aviación-virtual-y-física"></a>
### 112. Aviación virtual y física

Una aeronave se materializa cuando:

* entra en zona visible;
* transporta al jugador;
* ataca;
* puede ser interceptada;
* necesita aterrizar.

<a id="src-tactical-and-force-virtualization-system--fuera-de-la-zona"></a>
#### Fuera de la zona

Se calcula:

* ruta;
* combustible;
* amenaza;
* tiempo;
* misión.

---

<a id="src-tactical-and-force-virtualization-system--113-intercepción"></a>
### 113. Intercepción

Una misión aérea virtual puede transformarse en:

* alerta;
* defensa AA;
* apoyo;
* rescate;
* pérdida.

<a id="src-tactical-and-force-virtualization-system--regla-18"></a>
#### Regla

La aeronave no debe aparecer encima del objetivo sin recorrido ni riesgo.

---

<a id="src-tactical-and-force-virtualization-system--114-convoyes"></a>
### 114. Convoyes

Los convoyes lejanos permanecen virtuales.

Se materializan cuando:

* jugador se aproxima;
* comienza emboscada;
* cruzan una zona activa;
* transportan activo crítico.

<a id="src-tactical-and-force-virtualization-system--reintegration-1"></a>
#### Reintegration

Debe conservar:

* vehículos;
* carga;
* daños;
* retraso;
* supervivientes.

---

<a id="src-tactical-and-force-virtualization-system--115-materialización-de-guarniciones"></a>
### 115. Materialización de guarniciones

Una guarnición estratégica de 60 efectivos puede representar físicamente:

* 18–30 soldados;
* armas estáticas;
* patrulla;
* reserva posterior.

<a id="src-tactical-and-force-virtualization-system--factores-1"></a>
#### Factores

* amenaza;
* sector;
* misión;
* presupuesto.

---

<a id="src-tactical-and-force-virtualization-system--116-refuerzos-de-guarnición"></a>
### 116. Refuerzos de guarnición

Los refuerzos físicos proceden de:

* miembros no materializados;
* QRF;
* sector vecino;
* reserva.

<a id="src-tactical-and-force-virtualization-system--regla-19"></a>
#### Regla

Una guarnición no puede generar oleadas superiores a su fuerza estratégica.

---

<a id="src-tactical-and-force-virtualization-system--117-dificultad-táctica"></a>
### 117. Dificultad táctica

La dificultad modificará:

* coordinación;
* velocidad de reacción;
* calidad de posiciones;
* disciplina;
* uso de humo;
* retirada;
* inteligencia.

<a id="src-tactical-and-force-virtualization-system--no-modificará-principalmente"></a>
#### No modificará principalmente

* salud;
* cantidad infinita;
* detección mágica;
* precisión imposible.

---

<a id="src-tactical-and-force-virtualization-system--118-ia-competente"></a>
### 118. IA competente

Una IA competente debe:

* defender objetivos;
* utilizar reserva;
* retirarse;
* flanquear cuando sea viable;
* evitar avanzar sola;
* responder a blindados;
* proteger vehículos;
* abandonar posiciones perdidas.

<a id="src-tactical-and-force-virtualization-system--no-necesita"></a>
#### No necesita

Ser perfecta.

Puede cometer errores por:

* información;
* moral;
* doctrina;
* terreno;
* ejecución.

---

<a id="src-tactical-and-force-virtualization-system--119-diagnósticos"></a>
### 119. Diagnósticos

El sistema mostrará herramientas de depuración.

<a id="src-tactical-and-force-virtualization-system--capas"></a>
#### Capas

```text
FORMATIONS
PROJECTIONS
GROUPS
ENTITIES
DYNAMIC_SIMULATION
BATTLE_INSTANCES
RESERVATIONS
LOCALITY
```

<a id="src-tactical-and-force-virtualization-system--información-1"></a>
#### Información

* ID;
* estado;
* propietario;
* reserva;
* cantidad;
* misión;
* tiempo;
* causa.

---

<a id="src-tactical-and-force-virtualization-system--120-diagnóstico-de-dynamic-simulation"></a>
### 120. Diagnóstico de Dynamic Simulation

Arma 3 dispone de visualizaciones diagnósticas como `DynSimGroups` y `DynSimGrid` para inspeccionar áreas de activación y grupos gestionados por Dynamic Simulation. ([Bohemia Community][1])

<a id="src-tactical-and-force-virtualization-system--uso"></a>
#### Uso

Durante desarrollo:

* comprobar activación;
* detectar grupos siempre activos;
* ajustar distancias;
* revisar mezclas de bandos.

---

<a id="src-tactical-and-force-virtualization-system--121-registro-rpt"></a>
### 121. Registro RPT

Se registrará:

```text
MATERIALIZATION_REQUEST
MATERIALIZATION_SUCCESS
MATERIALIZATION_ROLLBACK
REINTEGRATION_SUCCESS
DUPLICATE_RESERVATION
MISSING_ENTITY
LOCALITY_TRANSFER
VIRTUAL_BATTLE_PHASE
```

---

<a id="src-tactical-and-force-virtualization-system--122-alertas-críticas"></a>
### 122. Alertas críticas

```text
Fuerza física sin formación
Formación materializada dos veces
Vehículo reservado dos veces
Grupo sin propietario válido
Baja registrada dos veces
Proyección eliminada sin reintegración
Batalla virtual activa sobre proyección física
```

---

<a id="src-tactical-and-force-virtualization-system--123-vertical-slice-táctico"></a>
### 123. Vertical slice táctico

<a id="src-tactical-and-force-virtualization-system--región"></a>
#### Región

Katalaki–Neochori–Stavros–Lakka–AAC.

<a id="src-tactical-and-force-virtualization-system--fuerzas"></a>
#### Fuerzas

* AZUR-1;
* pelotón Azul;
* guarniciones Verdes;
* QRF Verde;
* convoy Azul;
* célula FIA limitada.

<a id="src-tactical-and-force-virtualization-system--transiciones"></a>
#### Transiciones

1. Fuerza Verde virtual en Stavros.
2. Se prepara contraataque.
3. Se materializa al aproximarse.
4. Combate.
5. Parte se retira.
6. Supervivientes vuelven a formación.
7. Vehículo abandonado queda recuperable.
8. Sector actualiza guarnición.

---

<a id="src-tactical-and-force-virtualization-system--124-prueba-1-materialización-única"></a>
### 124. Prueba 1 — Materialización única

Intentar crear dos veces la misma proyección.

Resultado esperado:

* segundo intento rechazado.

---

<a id="src-tactical-and-force-virtualization-system--125-prueba-2-desmaterialización-durante-combate"></a>
### 125. Prueba 2 — Desmaterialización durante combate

Intentar retirar grupo bajo fuego.

Resultado:

* transición cancelada.

---

<a id="src-tactical-and-force-virtualization-system--126-prueba-3-baja-persistente"></a>
### 126. Prueba 3 — Baja persistente

Matar una unidad, guardar, cargar y reintegrar.

Resultado:

* una sola baja estratégica.

---

<a id="src-tactical-and-force-virtualization-system--127-prueba-4-vehículo-capturado"></a>
### 127. Prueba 4 — Vehículo capturado

Abandonar un Mora Verde y capturarlo con Azul.

Resultado:

* cambia control;
* conserva propietario original;
* necesita tripulación y reparación.

---

<a id="src-tactical-and-force-virtualization-system--128-prueba-5-retirada"></a>
### 128. Prueba 5 — Retirada

Forzar moral baja con ruta abierta.

Resultado:

* fuerza se retira;
* no desaparece;
* reaparece debilitada en otro sector.

---

<a id="src-tactical-and-force-virtualization-system--129-prueba-6-rendición"></a>
### 129. Prueba 6 — Rendición

Cercar una escuadra.

Resultado:

* armas entregadas;
* prisioneros registrados;
* formación descuenta capturados.

---

<a id="src-tactical-and-force-virtualization-system--130-prueba-7-batalla-virtual"></a>
### 130. Prueba 7 — Batalla virtual

Resolver Azul contra Verde sin jugador.

Verificar:

* fases;
* bajas;
* consumo;
* control;
* reproducibilidad.

---

<a id="src-tactical-and-force-virtualization-system--131-prueba-8-entrada-tardía"></a>
### 131. Prueba 8 — Entrada tardía

Materializar una batalla después de dos fases.

Verificar:

* bajas previas;
* posiciones;
* daño;
* munición.

---

<a id="src-tactical-and-force-virtualization-system--132-prueba-9-localidad"></a>
### 132. Prueba 9 — Localidad

Transferir grupo elegible a otra máquina de simulación futura.

Verificar:

* propietario;
* waypoints;
* eventos;
* reintegración.

---

<a id="src-tactical-and-force-virtualization-system--133-prueba-10-dynamic-simulation"></a>
### 133. Prueba 10 — Dynamic Simulation

Desactivar y activar guarnición lejana.

Verificar:

* grupo completo;
* no transición visible;
* estado conservado.

---

<a id="src-tactical-and-force-virtualization-system--134-funciones-conceptuales"></a>
### 134. Funciones conceptuales

```text
IF_fnc_formationReserveAssets
IF_fnc_formationReleaseAssets
IF_fnc_projectionCreate
IF_fnc_projectionValidate
IF_fnc_projectionMaterialize
IF_fnc_projectionRegisterEntity
IF_fnc_projectionRequestReintegration
IF_fnc_projectionCaptureState
IF_fnc_projectionReintegrate
IF_fnc_projectionRollback
IF_fnc_groupCreateTactical
IF_fnc_groupAssignPackage
IF_fnc_groupTransferLocality
IF_fnc_groupCleanup
IF_fnc_casualtyRegister
IF_fnc_vehicleRegisterDamage
IF_fnc_vehicleRegisterCapture
IF_fnc_battleCreateVirtual
IF_fnc_battleResolvePhase
IF_fnc_battlePauseForMaterialization
IF_fnc_battleResumeVirtual
IF_fnc_surrenderEvaluate
IF_fnc_retreatEvaluate
IF_fnc_performanceEvaluateBudget
```

---

<a id="src-tactical-and-force-virtualization-system--135-invariantes-tácticas"></a>
### 135. Invariantes tácticas

1. Una entidad física pertenece a una proyección.
2. Una proyección pertenece a una formación.
3. Ningún activo puede reservarse dos veces.
4. Ninguna baja puede registrarse dos veces.
5. Una batalla virtual se pausa para activos materializados.
6. Una formación no depende de sus objetos físicos.
7. Un vehículo persistente tiene un único estado.
8. Un grupo jugador no se virtualiza.
9. Un grupo en combate no se desmaterializa.
10. Una retirada conserva supervivientes.
11. Una rendición crea prisioneros.
12. Un grupo vacío debe limpiarse.
13. Los waypoints no aplican estado estratégico directamente.
14. La autoridad estratégica permanece en servidor.
15. La localidad táctica se consulta antes de ejecutar comandos locales.
16. Dynamic Simulation no sustituye virtualización.
17. Las fuerzas lejanas pueden moverse virtualmente.
18. Los refuerzos proceden de reservas reales.
19. Las guarniciones no producen unidades infinitas.
20. Los cadáveres físicos no son el registro de bajas.

---

<a id="src-tactical-and-force-virtualization-system--136-errores-que-deben-evitarse"></a>
### 136. Errores que deben evitarse

1. Mantener todo Altis materializado.
2. Usar Dynamic Simulation como campaña estratégica.
3. Materializar una compañía completa sin necesidad.
4. Crear refuerzos sin reserva.
5. Desmaterializar unidades visibles.
6. Registrar bajas al morir y al reintegrar nuevamente.
7. Duplicar vehículos.
8. Eliminar grupos sin limpiar referencias.
9. Ejecutar comandos locales desde la máquina equivocada.
10. Poner lógica autoritativa sin protección en waypoints.
11. Resolver una batalla instantáneamente.
12. Hacer que toda derrota destruya una formación.
13. Teletransportar retiradas.
14. Desaparecer prisioneros.
15. Limpiar vehículos antes de registrar recuperación.
16. Mantener cadáveres indefinidamente.
17. Hacer omnisciente a la IA enemiga.
18. Compensar rendimiento con enemigos de salud elevada.
19. Depender de Headless Client para funcionar.
20. Guardar solo objetos físicos.

---

<a id="src-tactical-and-force-virtualization-system--137-principios-obligatorios"></a>
### 137. Principios obligatorios

1. La formación estratégica es la fuente de verdad.
2. La proyección física es temporal.
3. La materialización reserva activos.
4. La reintegración cierra la transacción.
5. Virtualización y Dynamic Simulation son diferentes.
6. Las fuerzas lejanas no necesitan objetos.
7. Las fuerzas cercanas deben aparecer coherentemente.
8. Las transiciones no deben ser visibles.
9. Los grupos físicos deben ser funcionales.
10. Los paquetes tácticos dependen de misión y doctrina.
11. Los waypoints ejecutan intención táctica.
12. Los Event Handlers notifican, no gobiernan la campaña.
13. El servidor decide el estado estratégico.
14. La máquina propietaria ejecuta la IA local.
15. La arquitectura admite Headless Client posteriormente.
16. Las bajas poseen categorías.
17. Los personajes mantienen identidad.
18. Los soldados genéricos pueden ascender a persistentes.
19. La moral permite retirada y rendición.
20. Los vehículos importantes tienen ID.
21. El daño y combustible se reintegran.
22. Las batallas virtuales se resuelven por fases.
23. El jugador puede entrar en una batalla ya comenzada.
24. Las fuerzas no materializadas siguen influyendo.
25. El terreno modifica el resultado.
26. La inteligencia percibida modifica las decisiones.
27. El rendimiento tiene presupuesto.
28. El presupuesto no cambia las reservas reales.
29. Los sistemas deben registrar sus transiciones.
30. Ninguna fuerza puede existir simultáneamente dos veces.

---

<a id="src-tactical-and-force-virtualization-system--138-definición-final"></a>
### 138. Definición final

La guerra de Islas Fracturadas tendrá una escala mayor que la cantidad de unidades que Arma 3 puede simular de forma conveniente alrededor del jugador.

Esa escala no se conseguirá llenando Altis de miles de soldados inmóviles.

Se conseguirá haciendo que cada formación:

* exista estratégicamente;
* reciba órdenes;
* consuma suministros;
* viaje;
* combata;
* pierda personal;
* se retire;
* se reorganice;

aunque el jugador no la esté observando.

Cuando el jugador se aproxime, el sistema seleccionará la parte de esa formación que necesita convertirse en una batalla física.

Cuando se aleje, no borrará lo ocurrido.

Traducirá:

* muertos;
* heridos;
* vehículos;
* munición;
* moral;
* control;

de vuelta al estado persistente.

> **Una unidad no existe porque haya un soldado en el mapa. El soldado aparece porque una unidad que ya existía estratégicamente necesita estar representada.**

> **La virtualización permitirá que la guerra sea grande. La materialización hará que cada combate siga siendo concreto. La reintegración garantizará que ninguno de los dos mundos contradiga al otro.**

> **El jugador verá una parte del frente. El sistema deberá recordar el resto sin inventarlo dos veces.**

<a id="src-tactical-and-force-virtualization-system--estado-actualizado"></a>
#### Estado actualizado

El [Documento 8/14](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-progression-authority-and-unlocks-system) separa rango, confianza, reputación, apoyos, influencia, capacidades y progreso investigativo.

El [Documento 9/14](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system) fija cómo representar fuerzas, disponibilidad, incertidumbre, proyección táctica y estado de escuadra.

El [Documento 10/14](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture) fija capas, localidad, registros temporales, scheduler, eventos del motor, autoridad y pruebas de simulación.

El [Documento 11/14](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide) fija anclajes, rutas, spawns, retiradas, pruebas de pathfinding y criterios físicos para materializar fuerzas.

El [Documento 12/14](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system) fija radio táctica, prioridades, barks, reacciones a bajas, rendición y continuidad audiovisual durante la simulación.

El [Documento 13/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system) fija pruebas de reservas, virtualización, duplicación, reintegración, batallas, retiradas, vehículos y rendimiento táctico.

El [Documento 14/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan) fija orden, alcance, entregables y puertas para implementar fuerzas y virtualización. La colección rectora queda completa.

[1]: https://community.bohemia.net/wiki/Arma_3_Dynamic_Simulation?utm_source=chatgpt.com "Dynamic Simulation – Arma 3 - Bohemia Interactive Community"
[2]: https://community.bohemia.net/wiki/triggerDynamicSimulation?utm_source=chatgpt.com "triggerDynamicSimulation - Bohemia Interactive Community"
[3]: https://community.bohemia.net/wiki/isGroupDeletedWhenEmpty?utm_source=chatgpt.com "isGroupDeletedWhenEmpty - Bohemia Interactive Community"
[4]: https://community.bohemia.net/wiki/groupOwner?utm_source=chatgpt.com "groupOwner - Bohemia Interactive Community"
[5]: https://community.bohemia.net/wiki/setGroupOwner?useskin=vector&utm_source=chatgpt.com "setGroupOwner - Bohemia Interactive Community"
[6]: https://community.bohemia.net/wiki/enableDynamicSimulation?utm_source=chatgpt.com "enableDynamicSimulation - Bohemia Interactive Community"
[7]: https://community.bohemia.net/wiki/Waypoints?utm_source=chatgpt.com "Waypoints - Bohemia Interactive Community"
[8]: https://community.bohemia.net/wiki/Arma_3%3A_Event_Handlers?utm_source=chatgpt.com "Event Handlers – Arma 3 - Bohemia Interactive Community"
