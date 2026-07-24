# Arquitectura de IA estratégica y cadena de mando

> **Estado:** contrato rector de comportamiento previo a implementación.  
> **Motor:** Arma 3 2.18.  
> **Lenguaje:** SQF.  
> **Autoridad de datos:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).  
> **Disponibilidad militar:** [MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md](MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md).  
> **Decisiones territoriales:** [TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md](TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md).  
> **Restricciones económicas:** [ECONOMIC_AND_LOGISTICS_SYSTEM.md](ECONOMIC_AND_LOGISTICS_SYSTEM.md).

## 1. Objetivo

Los comandantes deben parecer inteligentes porque observan una parte del mundo, interpretan, priorizan, se equivocan, recuerdan y actúan bajo doctrina, personalidad, logística y política. No se intenta construir una inteligencia general.

## 2. Dos capas

### Estrategia propia

SQF decide objetivos, frentes, reservas, fuerzas, logística, riesgo, inteligencia y misiones.

### Táctica nativa

Arma 3 ejecuta movimiento, formaciones, cobertura, conducción, fuego, combate próximo y waypoints.

La estrategia no coloca a cada soldado. La IA táctica no decide qué región invade una facción.

Las reservas, capacidades, costes, oleadas y tiempos de reposición proceden del catálogo militar; el comandante no puede inventarlos para satisfacer un plan.

## 3. Límites técnicos

Los waypoints son órdenes sucesivas de grupo, no planes de teatro. El propietario local del grupo evalúa sus condiciones; sus efectos deben diseñarse respetando localidad.

High Command puede ofrecer control temporal de grupos al jugador avanzado, pero no sustituye política, logística ni estrategia. Dynamic Simulation conserva entidades físicas inactivas; no reemplaza fuerzas virtuales ni resolución abstracta.

## 4. Seis niveles de mando

| Nivel | Función |
|---:|---|
| 1 | Dirección político-estratégica: fines, tratados, legitimidad y retirada |
| 2 | Teatro: frentes, regiones, reservas, escalada y objetivos principales |
| 3 | Componentes: tierra, aire, Helios, política y corrientes internas |
| 4 | Región: sectores, rutas, prioridades locales y reserva regional |
| 5 | Operación: compañías, columnas, guarniciones, células y convoyes |
| 6 | Unidad protagonista: ejecución, coordinación e influencia progresiva |

AZUR-1 o RUBÍ-1 nunca reemplaza automáticamente al comandante del teatro.

## 5. Autoridad y control

Una orden puede poseer autoridad política o militar sin control real. Este último depende de comunicación, obediencia, cohesión, logística, presencia, lealtad y capacidad de sanción.

> Una orden existe cuando se emite. Se convierte en poder cuando alguien puede hacer que sea obedecida.

## 6. Perfil de comandante

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

## 7. Conocimiento y creencias

Ningún comandante lee todo `IF_campaignState`. Decide mediante informes, observaciones, estimaciones, rumores, Helios y conocimiento confirmado.

Creencia:

```text
subjectId estimatedLocation estimatedStrength estimatedReadiness
estimatedIntent confidence source age contradictions
commanderInterpretation
```

Fuentes:

```text
DIRECT_OBSERVATION RECON_TEAM DRONE AIRCRAFT RADAR SIGNALS
CIVILIAN PRISONER DESERTER ALLIED_COMMAND HELIOS
ARGOS_MANIPULATION RUMOR
```

Antigüedad, reputación, acceso, interferencia, confirmación, infiltración y sesgo determinan credibilidad.

## 8. Ciclo estratégico

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

## 9. Plan operacional

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

## 10. Evaluación de planes

```text
valor =
beneficio militar + logístico + político + informativo
+ compatibilidad doctrinal + urgencia
- coste - riesgo - exposición - daño civil
- consumo de reservas - incertidumbre
```

Cada comandante pondera casos mejor, esperado y peor. Un prudente prioriza el peor; un agresivo, oportunidad y mejor caso; un político, legitimidad y aliados.

## 11. Reservas y asignación

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

## 12. Logística y frentes

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

## 13. Ejecución táctica

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

## 14. Resolución abstracta

Lejos del jugador se consideran fuerza, suministro, terreno, fortificación, información, moral, apoyo, mando y sorpresa. Persiste bajas, consumo, daño, control, moral y experiencia.

Niveles:

| Nivel | Representación |
|---|---|
| Táctico | Unidades físicas e IA completa |
| Operacional | Formaciones virtuales, rutas y tiempos |
| Estratégico | Fuerza agregada, control y presión |

Una fuerza solo existe en un nivel. Al aproximarse el jugador se materializan supervivientes y restos coherentes.

## 15. Planificador central

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

## 16. Errores y aprendizaje

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

## 17. Cadena Azul

| Actor | Papel y preferencias |
|---|---|
| Elena Ward | Teatro; legalidad, reserva, movilidad, civiles, cooperación y salida política |
| Marcus Hale | Tierra; concentración, velocidad, mecanización y explotación |
| Thomas Rourke | Traduce órdenes; protege o presiona a AZUR-1 |
| Naomi Reyes | Aire; pistas, combustible, defensa y conservación de aeronaves |
| Sofia Laurent | Restricciones civiles, municipios, hospitales y negociación |
| Miriam Kessler | Nodos, técnicos, servidores e investigación Helios |

Ward puede endurecerse o buscar tregua. Hale puede sobreextenderse y convertir intervención en ocupación.

## 18. Cadena Roja

| Actor | Papel y preferencias |
|---|---|
| Darius Navid | Teatro; Asterión, reservas, corredores y cooperación Verde |
| Soraya Vahid | Tierra; mecanización, artillería, presión y ofensiva sostenida |
| Samir Khadem | Traduce y modera órdenes; protege o utiliza RUBÍ-1 |
| Laleh Arman | Aire y defensa; Molos, logística y conservación aérea |
| Kamran Sadeq | Helios; claves, integración y preservación |
| Nadir Khoury | Política; Gobierno, legitimidad, negociación y Asterión |

Navid corre riesgo de lentitud y dependencia. Vahid puede convertir alianza en ocupación.

## 19. Cadenas Verdes

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

## 20. FIA

Markou dirige política y legitimidad; Kallas, brigadas y operaciones; células locales conservan autonomía; Frente Negro recibe manipulación.

Una orden nacional es una solicitud ponderada. Cada célula puede obedecer, modificar, retrasar, rechazar o actuar sola.

## 21. Argos

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

## 22. Jugador y órdenes

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

## 23. Sucesión y continuidad

La muerte transfiere fuerzas, problemas y plan parcial, pero no personalidad ni confianza. Un plan pasa a `COMMAND_DISRUPTED`; subordinados pueden continuar mientras el sucesor lo mantiene, modifica o cancela.

## 24. Helios y Argos revelado

Cada comandante distingue confianza instrumental, institucional, desconfianza, rechazo y dependencia.

Ward verifica; Hale prioriza victoria; Navid reevalúa legitimidad; Vahid trata Argos como arma; Varos ve violación soberana; Markou deslegitima; Kallas intenta capturar; Vardis interpreta las reacciones como datos.

## 25. Comunicación

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

## 26. Misiones y evaluación

Toda orden al jugador contiene contexto, intención, objetivo, restricciones, apoyos, urgencia y terminación.

El comandante detecta y prioriza necesidades; el director descrito en [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md) las convierte en candidatos compatibles, aplica límites de oferta y registra por qué se generó cada misión.

Resultado:

```text
EXCEPTIONAL SUCCESS PARTIAL FAILURE DISASTER
UNAUTHORIZED_SUCCESS JUSTIFIED_DISOBEDIENCE
UNJUSTIFIED_DISOBEDIENCE
```

Se evalúan intención, pérdidas, tiempo, civiles, pruebas, recursos y obediencia.

## 27. Depuración

Cada decisión registra:

```text
commanderId assessmentTime needsDetected plansGenerated plansRejected
selectedPlan scoreBreakdown constraints informationUsed confidence
```

La UI avanzada muestra intención, fuerzas, reservas, frentes, necesidades y propuestas; oculta planes enemigos, puntuaciones, infiltrados, precisión real y Argos.

## 28. High Command, localidad y rendimiento

High Command solo dirige grupos asignados temporalmente. El servidor conserva plan y estado; el propietario local ejecuta táctica; el resultado vuelve al servidor.

Un Headless Client futuro puede recibir grupos mediante `setGroupOwner`, nunca estado, decisiones, persistencia o secretos.

Dynamic Simulation solo administra entidades físicas habilitadas. No reemplaza virtualización ni economía.

## 29. Funciones

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

## 30. Vertical slice y fases

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

## 31. Invariantes

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

## 32. Referencias técnicas

* [Waypoints — Bohemia Interactive Community](https://community.bistudio.com/wiki/Waypoints)
* [High Command — Bohemia Interactive Community](https://community.bistudio.com/wiki/Arma_3%3A_High_Command)
* [Dynamic Simulation — Bohemia Interactive Community](https://community.bistudio.com/wiki/Arma_3%3A_Dynamic_Simulation)
* [Scheduler — Bohemia Interactive Community](https://community.bistudio.com/wiki/Scheduler)
* [setGroupOwner — Bohemia Interactive Community](https://community.bistudio.com/wiki/setGroupOwner)

> **La estrategia decide qué batalla debe existir. Arma 3 decide cómo sobreviven quienes entran en ella.**
