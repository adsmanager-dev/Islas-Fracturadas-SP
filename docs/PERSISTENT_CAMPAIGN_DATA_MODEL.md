# Modelo de datos persistente y autoritativo de campaña

> **Estado:** contrato rector previo a implementación.  
> **Motor objetivo:** Arma 3 2.18.  
> **Lenguaje:** SQF.  
> **Modalidad inicial:** un jugador, preparada para cooperativo de un solo bando.  
> **Escenarios:** Altis, Stratis y epílogo.

## 1. Propósito

Este documento fija la representación implementable de sectores, fuerzas, logística, personajes, relaciones, civiles, Helios, inteligencia, misiones, eventos, progresión y finales. Define persistencia, autoridad, red, migraciones, recuperación y transferencia entre escenarios. Las cantidades, capacidades y reglas de reposición se definen en el [sistema militar y orden de batalla](MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md).

Cualquier módulo nuevo debe respetar este contrato o aumentar `schemaVersion` y proporcionar una migración.

## 2. Fuente oficial de verdad

```sqf
IF_campaignState
```

Durante la ejecución reside en `missionNamespace`. En un jugador la máquina local es autoridad; en cooperativo, solo el servidor hospedado o dedicado modifica el estado canónico. Los clientes solicitan acciones y reciben proyecciones autorizadas.

## 3. Separación de estados

| Estado | Contenido | Persistencia |
|---|---|---|
| Canónico | Sectores, recursos, fuerzas, personajes, relaciones, evidencia, Helios, progreso | Sí |
| Operativo | Grupos, objetos, waypoints, proyectiles, patrullas y tareas locales | No; se resume |
| Derivado | Amenaza, frentes, rutas, prioridades, finales provisionales | Se recalcula |
| Presentación | UI, filtros, zoom, avisos y configuración visual | Perfil separado |

Una entidad estratégica nunca depende únicamente de que su grupo físico continúe existiendo.

## 4. Persistencia

| Uso | Namespace |
|---|---|
| Ejecución | `missionNamespace` |
| Campaña individual | `missionProfileNamespace` |
| Preferencias transversales | `profileNamespace` |
| Sesión, no persistencia duradera | `serverNamespace` |

Altis, Stratis y epílogo comparten:

```cpp
missionGroup = "IF_MAIN_CAMPAIGN";
```

El almacenamiento se oculta tras:

```text
IF_fnc_storageLoad
IF_fnc_storageSave
IF_fnc_storageDelete
IF_fnc_storageBackup
```

Así podrá sustituirse el perfil del servidor por una base de datos o servicio sin cambiar la simulación.

## 5. Tipos y referencias

Se utilizan `HashMap` para entidades y colecciones por ID, arrays para orden, strings para IDs y enumeraciones, números para cantidades y booleanos para estados.

No se persisten objetos, grupos, código, controles, localizaciones dinámicas ni claves basadas en objetos. Toda entidad física relevante posee un identificador lógico.

## 6. Estructura raíz

```sqf
IF_campaignState = createHashMapFromArray [
    ["meta", createHashMap],
    ["campaign", createHashMap],
    ["clock", createHashMap],
    ["world", createHashMap],
    ["regions", createHashMap],
    ["sectors", createHashMap],
    ["connections", createHashMap],
    ["factions", createHashMap],
    ["forces", createHashMap],
    ["vehicles", createHashMap],
    ["logistics", createHashMap],
    ["characters", createHashMap],
    ["roles", createHashMap],
    ["relations", createHashMap],
    ["civilians", createHashMap],
    ["government", createHashMap],
    ["helios", createHashMap],
    ["intelligence", createHashMap],
    ["evidence", createHashMap],
    ["knowledge", createHashMap],
    ["missions", createHashMap],
    ["events", createHashMap],
    ["progression", createHashMap],
    ["endings", createHashMap]
];
```

## 7. Identificadores

```text
SEC_WEST_KATALAKI
REG_NORTHWEST
CONN_KATALAKI_NEOCHORI
FAC_BLUE
FOR_BLUE_001
VEH_BLUE_APC_001
CHAR_BLUE_WARD
HEL_NODE_AIRPORT
E-B-ES-002A
KNW_STRATIS_ACTIVE
IF_B_A01_M01
EVT_CIV_KAVALA_STRIKE_001
```

Los IDs no se traducen, no dependen de índices, no contienen espacios, no cambian tras publicarse y nunca se reutilizan.

## 8. Metadatos, campaña y reloj

`meta` conserva:

```text
schemaVersion campaignVersion saveFormat saveSlot createdAt updatedAt
playTimeSeconds buildId stateRevision checksum migrationHistory
isValid lastValidationErrors
```

`campaign` conserva:

```text
campaignId campaignSide campaignMode currentWorld currentAct currentPhase
narrativeDay campaignStarted campaignCompleted stratisUnlocked
stratisCompleted epilogueUnlocked dualCampaignCompleted
difficultyProfile ironman
```

`campaignSide` solo admite `BLUE` o `RED`.

Fases:

```text
APPROACH LANDING BEACHHEAD EXPANSION TERRITORIAL_WAR
FRAGMENTATION HELIOS_DISCOVERY WAR_OF_NODES
STRATIS_OPERATION TRANSITION COMPLETE
```

El reloj propio guarda `campaignMinutes`, día, hora, minuto, escala y próximos ciclos. No se usa `time` como única referencia. La fecha histórica continúa siendo el 24 de junio de 2042.

## 9. Rangos comunes

La mayoría de valores estratégicos y psicológicos usa 0–100.

| Rango | Control o capacidad |
|---:|---|
| 0 | Inexistente |
| 1–24 | Crítico o simbólico |
| 25–49 | Débil o degradado |
| 50–74 | Funcional o provisional |
| 75–94 | Operativo o consolidado |
| 95–100 | Pleno o fortificado |

Para necesidades civiles, `0` significa colapso y `100`, necesidad completamente cubierta. Inteligencia utiliza 0.00–1.00 para `confidence` y `accuracy`.

## 10. Regiones y sectores

Una región conserva:

```text
id displayName sectorIds regionalIdentity economicProfile
historicalGrievance governmentSupport greenTradition fiaInfluence
blueDependency redDependency heliosDependency
regionalStability regionalMemory
```

Un sector conserva el núcleo siguiente; su extensión autoritativa para estructura, profundidad, módulos y memoria se define en el [sistema territorial](TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md):

```text
id regionId displayName sectorType positionATL radius connectionIds
militaryOwner militaryControl politicalAuthority politicalLegitimacy
clandestineInfluence heliosAccess contestState captureProgress
structuralLevel maxStructuralLevel fortificationLevel strategicRole
functionalCapacityBase defensiveCapacityBase
functionalCapacityModifier defensiveCapacityModifier
functionalCapacityUsed defensiveCapacityUsed
garrisonId readiness supplyLevel morale
population civilState infrastructure production demands damage
moduleIds combatMemory constructionQueue evacuationQueue
intelByFaction eventMemory activeMissionIds flags
```

Control militar, legitimidad, autoridad, influencia clandestina y acceso Helios son dimensiones diferentes. El propietario no cambia por tocar un marcador: debe superar un umbral y eliminar la capacidad enemiga de disputa.

## 11. Conexiones e infraestructura

Conexión:

```text
id from to connectionType distance capacity condition ownerControl
threat blocked mined bridgeRequired heliosLinked
```

Tipos:

```text
ROAD_MAIN ROAD_SECONDARY TRACK SEA_ROUTE AIR_ROUTE
POWER_LINE COMMUNICATION_LINK HELIOS_LINK
```

Infraestructura:

```text
power water communications medical roads port airfield
industry fuelStorage heliosNode
```

Daño:

```text
structural civilianHousing economic environmental military services
```

Una instalación intacta puede estar inactiva por falta de energía, técnicos, combustible, comunicaciones o seguridad.

## 12. Facciones y recursos

Facción:

```text
id displayName side active militaryPower manpowerPool availableManpower
commandCapacity politicalCapital legitimacyGlobal cohesion morale
warWeariness resources doctrine strategicGoals controlledSectorIds
alliedFactionIds hostileFactionIds commanderIds activeFrontIds flags
```

Recursos físicos autoritativos, definidos por el [sistema económico y logístico](ECONOMIC_AND_LOGISTICS_SYSTEM.md):

```text
FOOD WATER FUEL SMALL_ARMS_AMMO HEAVY_AMMO
MISSILES_AT MISSILES_AA ARTILLERY_AMMO EXPLOSIVES
MEDICAL CONSTRUCTION SPARE_PARTS ELECTRONICS
AVIATION_SUPPLIES NAVAL_SUPPLIES
```

Personal especializado, capacidades operacionales y recursos políticos se conservan separados; no se convierten libremente ni forman una moneda universal.

Doctrina:

```text
aggression riskTolerance civilianRestraint fortificationPreference
mobilityPreference intelReliance heliosTrust politicalRestraint
reservePreference
```

No existe una moneda universal. La doctrina aporta pesos y cada comandante los modifica.

## 13. Fuerzas y vehículos

Formación:

```text
id factionId formationType homeSectorId currentSectorId targetSectorId
strength manpower experience morale readiness supply mobility combatPower
status virtual persistentUnitIds vehicleIds assignedMissionId casualties
```

Tipos:

```text
FIRETEAM SQUAD PLATOON COMPANY_ELEMENT ARMORED_SECTION
MECHANIZED_GROUP ARTILLERY_BATTERY AIR_FLIGHT NAVAL_ELEMENT
LOGISTICS_CONVOY GARRISON MILITIA_CELL GUERRILLA_CELL
```

Al desmaterializar una fuerza se reintegran supervivientes, bajas, munición, vehículos, posición, moral y experiencia.

Vehículo persistente:

```text
id factionId className displayName status condition fuel ammo crewStatus
currentSectorId assignedForceId capturedFrom veterancy unique destroyed
```

Solo se individualizan vehículos importantes.

## 14. Logística

Existen reservas exteriores y de teatro, centros logísticos, existencias sectoriales, convoyes y cachés. Toda mutación sigue el [contrato económico y logístico](ECONOMIC_AND_LOGISTICS_SYSTEM.md).

Centro:

```text
id factionId sectorId hubType status storageCapacity throughput
security staffing infrastructureCondition powerAvailability
stocks reservedStocks connectedRouteIds incomingConvoyIds
outgoingConvoyIds evacuationThreshold capturePolicy
```

Convoy:

```text
id factionId originHubId destinationHubId routeConnectionIds cargo
vehicleIds escortForceIds priority status departureTime arrivalEstimate
currentProgress threat materialized missionId transactionId
```

Estados:

```text
PLANNED ASSEMBLING LOADING READY EN_ROUTE DELAYED DIVERTED
UNDER_ATTACK BROKEN ARRIVED ABANDONED CAPTURED DESTROYED
```

Producción:

```text
sectorId productionType baseOutput requiredInputs
workforceRequired workforceAvailable infrastructureCondition
security connectionEfficiency currentEfficiency
```

Transacción logística:

```text
id idempotencyKey resourceType amount sourceLocation destinationLocation
phase status reservedAmount committedAmount lossAmount createdAt updatedAt
```

Fases:

```text
RESERVE LOAD DEPART MOVE ARRIVE UNLOAD COMMIT
ROLLBACK PARTIAL_LOSS CAPTURE DESTROY
```

## 15. Personajes y relaciones

Personaje:

```text
id displayName factionId role status alive locationSectorId
trustPlayer trustHelios trustFaction politicalLoyalty personalLoyalty
civilianConcern aggression riskTolerance ambition fear grievance
relationshipStates knowledgeFlags secretFlags memoryEvents
finalAlignment replacementId protectedNarratively
```

Las memorias de muerte, traición, promesa, masacre, rescate, Argos y desobediencia grave son permanentes. Errores y discusiones menores pueden degradarse.

Relación direccional:

```text
from to trust professionalRespect ideologicalAffinity dependency
grievance fear personalLoyalty compromisingKnowledge state
```

Relación entre facciones:

```text
from to officialStatus militaryHostility politicalTrust
operationalCooperation dependency grievance secretChannels
treatyId ceasefireUntil
```

`setFriend` no representa por sí solo diplomacia.

## 16. Civiles

```text
sectorId populationTotal populationPresent populationDisplacedOut
populationDisplacedIn workingPopulation essentialWorkers
mobilizedPopulation civilianCasualties missingPersons detainedPersons
returnedPopulation civilianTrust civilianSupport civilianObedience
civilianDependency fear grievance communityCohesion radicalization
stability serviceState activeDemandIds activeProtestId municipalityId
governmentMode civilMemory
```

Confianza, apoyo, obediencia y dependencia permanecen separadas. Una ciudad puede obedecer y depender de una ocupación sin apoyarla.

Necesidades:

```text
food water shelter power medicalCare security transport employment
communications education sanitation legalProtection
```

Municipio:

```text
id displayName sectorIds mayorCharacterId councilState
administrativeCapacity publicTrust recognizedAuthority
supervisingFactionId essentialWorkerNetworks activeDemandIds
politicalAlignment
```

Demanda civil:

```text
id sectorId issuerId type priority createdAt softDeadline hardDeadline
requestedAction possibleCompromises ignoredOutcome resolved
```

La semántica completa de gobierno, servicios, detenciones, desplazamiento, promesas, rumores y memoria se rige por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md).

## 17. Helios

Estado global:

```text
globalState networkIntegrity civilFunctions militaryFunctions
validationActive argosBackdoorAccess vardisControl publicPerception
knownByPlayer nodeIds protocolIds operatorIds activeManipulations auditLog
```

Nodo:

```text
id displayName sectorId nodeType physicalOwner physicalCondition
networkIntegrity powerAvailability digitalAccess argosAccess
civilCapabilities militaryCapabilities dataCategories
isolated destroyed discoveredByFaction
```

Control físico, acceso digital e integridad son obligatoriamente distintos. Capturar no concede credenciales.

Capacidades:

```text
POWER_MANAGEMENT HOSPITAL_COORDINATION PORT_LOGISTICS AIR_TRAFFIC
RADAR_FUSION MILITARY_LOGISTICS CIVIL_REGISTRY WEATHER_ANALYSIS
COMMUNICATION_RELAY VALIDATION_DATA MASTER_KEYS ARGOS_ARCHIVE
```

Stratis concentra claves y dirección; Altis, sensores, datos e infraestructura.

## 18. Inteligencia, evidencia y conocimiento

Informe:

```text
id ownerFactionId subjectType subjectId reportedSectorId
createdAt receivedAt confidence accuracy sourceType sourceId
status manipulated manipulationType visibleToPlayer confirmed
```

`confidence` es creencia del receptor; `accuracy`, verdad real normalmente oculta.

Evidencia:

```text
id lineId campaignSide actId evidenceType state authenticity integrity
interpretationConfidence locationId holderFactionId holderCharacterId
recoveredById recoveredAt recoveredLocation chainOfCustody copies
requiredInterpreterTags relatedEvidenceIds conclusionIds
classified published destroyed argosAwareness
```

Estados:

```text
UNKNOWN RUMORED LOCATED RECOVERED DAMAGED
AUTHENTICATED INTERPRETED CORRELATED DELIVERED CLASSIFIED
PUBLISHED DESTROYED LOST
```

Autenticidad, integridad y confianza se almacenan por separado:

```text
AUTHENTIC PARTIALLY_AUTHENTIC ALTERED FORGED UNKNOWN
COMPLETE PARTIAL DAMAGED FRAGMENTARY
UNSUPPORTED POSSIBLE PROBABLE HIGH_CONFIDENCE PROVEN
```

Conclusión:

```text
id displayName state technicalConfidence politicalConfidence
humanConfidence operationalConfidence supportingEvidenceIds
contradictingEvidenceIds knownByFaction knownByCharacters public
unlockedMissionIds unlockedDialogueIds unlockedEndingOptions
```

Conocimiento:

```text
UNKNOWN SUSPECTED PROBABLE PROVEN PUBLIC
```

Perder una prueba no borra una conclusión demostrada y compartida.

La semántica completa de evidencias, custodia, intérpretes, redundancia y publicación se rige por [INVESTIGATION_REVELATION_MATRIX.md](INVESTIGATION_REVELATION_MATRIX.md).

## 19. Misiones

Necesidad causal:

```text
id type originSystem requesterId sectorId priority createdAt
softDeadline hardDeadline requiredResource requiredAmount
ignoredOutcome resolved
```

Director:

```text
activeMainMissionId activeOperationIds activeEmergencyIds
availableInvestigationIds queuedNeeds recentMissionTags
emitterCooldowns regionActivity globalPacingState
```

Plantilla:

```text
templateId family supportedSides requiredActRange requiredSectorTypes
requiredWorldStates forbiddenWorldStates requiredActors
objectivePatterns optionalObjectivePatterns failurePatterns
parameterRules materializationRules rewardRules consequenceRules
dialogueTags cooldownTags
```

```text
id templateId campaignSide act family state title originatorId sectorIds
narrativePurpose strategicPurpose triggerConditions expirationConditions
requiredSystems objectiveStates optionalObjectiveStates variants
evidenceIds characterIds expirationTime result ignoredState
relationshipEffects territorialEffects economicEffects followUpMissionIds
consequencesApplied generationSeed
```

Estados:

```text
LOCKED AVAILABLE OFFERED ACCEPTED ACTIVE SUCCEEDED PARTIAL
FAILED EXPIRED ABORTED RESOLVED_OFFSCREEN
```

Las misiones dinámicas guardan plantilla, parámetros, ubicación, actores, variante y semilla; no cada waypoint.

La arquitectura, convención de IDs, puertas y estados se rige por [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](BLUE_RED_CAMPAIGN_ARCHITECTURE.md).

La causalidad, espacios `TPL_*`/`NEED_*`/`DYN_*`, ventanas temporales, transformación, resolución externa y anti-repetición se rigen por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md).

Estado comparado tras completar ambas campañas:

```text
sharedEvidence differences decisions survivors endings comparableFiles
comparisonUnlocked secretSceneUnlocked vardisFullContext
```

## 20. Eventos y mutaciones

Evento:

```text
id eventType time act sectorId actorIds targetIds magnitude tags
sourceMissionId consequences persistent publicKnowledge
```

El pipeline obligatorio:

1. recibir acción;
2. validar autoridad;
3. validar estado;
4. crear evento;
5. aplicar mutación;
6. resolver consecuencias;
7. comprobar invariantes;
8. registrar;
9. publicar delta visible;
10. programar guardado.

```text
IF_fnc_eventCreate
IF_fnc_eventValidate
IF_fnc_eventApply
IF_fnc_eventResolveConsequences
IF_fnc_stateValidate
IF_fnc_stateCommit
IF_fnc_statePublishDelta
```

Cada `commit` incrementa `stateRevision`.

## 21. Invariantes

Son inválidos:

```text
militaryOwner = FAC_BLUE y militaryControl = 0
alive = false y status = ACTIVE
destroyed = true y condition = 90
nodo destruido y physicalCondition = 100
misión SUCCEEDED sin consecuencias resueltas
Gobierno de unidad sin autoridad ni participantes vivos
```

El sistema corrige solo cuando existe una regla segura; en otro caso rechaza la transacción.

## 22. Persistido frente a calculado

Persistir: propiedad, recursos, fuerzas, relaciones, muertos, decisiones, evidencia, daño, legitimidad, eventos, progreso, módulos territoriales, memoria de combate y colas de construcción o evacuación.

Calcular: profundidad del frente, perfiles y vectores de amenaza, rutas, frentes, puntuación ofensiva, candidatos de misión, final provisional, objetivos e interfaz.

`frontDepth` y `threatProfile` pueden conservarse como caché de ejecución, pero se invalidan al cargar o cuando cambian propietario, conexión, alianza o frente. Su fuente de verdad es el grafo territorial más la memoria persistente.

Persistir derivados indiscriminadamente genera contradicciones.

## 23. Guardado y recuperación

Slots:

```text
AUTOSAVE_A AUTOSAVE_B CHECKPOINT MANUAL_1 CAMPAIGN_COMPLETE
```

Procedimiento:

1. validar;
2. clonar datos persistentes;
3. eliminar temporales;
4. añadir metadatos;
5. escribir en slot alternativo;
6. comprobar lectura;
7. marcar como válido.

Se guarda en misiones principales, cambios de acto, decisiones críticas, transición a Stratis, regreso, menú seguro y guardado manual. Nunca por fotograma o cambio menor.

El guardado nativo reanuda la misión táctica; el snapshot propio conecta escenarios.

## 24. Migraciones e integridad

```text
IF_fnc_migrateV1ToV2
IF_fnc_migrateV2ToV3
```

La migración trabaja sobre copia, se ejecuta en orden, valida, escribe nuevo slot, conserva el original y registra historial.

Se validan raíz, schema, campaña, IDs, referencias, tipos, rangos e invariantes. `checksum` detecta corrupción accidental, no manipulación deliberada.

Errores importantes usan `diag_log`:

```text
[IF][STATE][ERROR] Missing sector SEC_WEST_NEOCHORI
[IF][SAVE][INFO] AUTOSAVE_B completed
[IF][MIGRATION][WARN] Legacy owner converted
```

## 25. Autoridad, localidad y seguridad

Las funciones estratégicas siguen:

```sqf
if (!isServer) exitWith {};
```

El servidor controla estado, mutaciones, IA, guardado, misiones, muertes y finales. El cliente controla interfaz, cámara, audio, interacción y presentación.

Cada solicitud valida emisor, rol, bando, campaña, recursos, frecuencia y objetivo. La entidad estratégica no cambia cuando un grupo físico cambia de localidad.

## 26. Proyección de cliente

```sqf
IF_clientState = createHashMapFromArray [
    ["campaign", createHashMap],
    ["visibleSectors", createHashMap],
    ["knownForces", createHashMap],
    ["visibleCharacters", createHashMap],
    ["knownEvidence", createHashMap],
    ["activeMissions", createHashMap],
    ["playerAuthority", createHashMap]
];
```

Secretos Argos, precisión real, planes enemigos, infiltrados y finales potenciales no se publican.

`publicVariable` queda para datos pequeños. Las funciones remotas se autorizan expresamente mediante `CfgRemoteExec`; nunca se envían `call` o `spawn` directos.

## 27. Paquetes y JIP

```sqf
createHashMapFromArray [
    ["packetType", "STATE_SNAPSHOT"],
    ["schemaVersion", 1],
    ["revision", 1045],
    ["payload", createHashMap]
]
```

Tipos:

```text
STATE_SNAPSHOT STATE_DELTA MISSION_UPDATE
EVENT_NOTIFICATION REQUEST_RESULT UI_NOTIFICATION
```

JIP:

1. inicializar cliente;
2. solicitar snapshot;
3. validar bando y rol;
4. construir proyección;
5. enviar snapshot numerado;
6. confirmar revisión;
7. activar UI y tareas;
8. recibir deltas.

No se reconstruye el estado mediante campos `init` ni múltiples mensajes persistentes dependientes de orden.

## 28. Progresión, unidad y sucesión

```text
rank operationalRole authorityLevel commanderTrust unitReputation
civilReputationByRegion missionsCompleted specializations
commendations disciplinaryActions unitMemberIds unitLosses
```

Autoridad:

| Nivel | Capacidad |
|---:|---|
| 0 | Soldado |
| 1 | Liderar unidad |
| 2 | Solicitar apoyo |
| 3 | Priorizar sector |
| 4 | Coordinar destacamentos |
| 5 | Mando regional |
| 6 | Influencia operacional |

Estados médicos:

```text
FIT WOUNDED_LIGHT WOUNDED_SERIOUS RECOVERING
UNFIT MISSING CAPTURED DEAD
```

Los roles son independientes de los personajes:

```sqf
createHashMapFromArray [
    ["currentCharacterId", "CHAR_BLUE_COLE"],
    ["successorPriority", ["CHAR_BLUE_TORRES", "CHAR_BLUE_OKAFOR"]],
    ["vacant", false]
]
```

## 29. Gobierno, FIA y Verde

Gobierno:

```text
legitimacy cohesion administrativeCapacity constitutionalAuthority
securityControl blueDependency redDependency greenDependency
heliosControl capitalSectorId headOfStateId headOfGovernmentId
governmentState recognizedBy activeDecrees successionRules
```

FIA:

```text
politicalInfluence armedStrength territorialPresence clandestineNetwork
civilSupport radicalization argosInfiltration civicWingPower
militaryWingPower blackFrontPower unity weaponStock
```

Verde:

```text
cohesion governmentLoyalty sovereignistInfluence reformistInfluence
redCooperation blueCooperation argosInfiltration commandAuthority
fragmentationStage
```

```text
NATIONAL_DEFENSE OVERLOAD PARALLEL_COMMANDS FRAGMENTATION TRANSFORMATION
```

## 30. Comandantes y ciclos

```text
currentGoal currentPlanId lastEvaluation nextEvaluation knownThreatIds
reservedForceIds committedForceIds preferredObjectives
forbiddenActions politicalConstraints
```

Ritmos iniciales:

* 5–15 s: misiones y táctica necesaria;
* 30–90 s: sectores próximos, amenazas y convoyes;
* 2–5 min: comandantes, frentes, producción y relaciones;
* inmediato: muerte, captura, sabotaje y ruptura.

La arquitectura concreta de decisión pertenece al documento posterior de IA.

Esa arquitectura se define en [STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md](STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md).

## 31. Combate, misiones y construcción

El combate virtual considera fuerza, preparación, suministro, terreno, fortificación, inteligencia, apoyo, moral, comandante y variación con semilla registrable.

Las misiones nacen de necesidades, acontecimientos, personajes, actos, evidencia, civiles y Helios. Se validan sectores, recursos y personajes antes de puntuarse.

El jugador prioriza:

```text
DEFENSE LOGISTICS ANTI_AIR ANTI_TANK
MEDICAL INTELLIGENCE CIVIL_SUPPORT
```

La IA elige composición, ubicación, orientación, cantidad y orden. El guardado conserva ID, posición, orientación, daño y nivel, no todos los objetos.

Módulo territorial:

```text
id sectorId moduleType ownerFactionId tier capacityCost status
compositionId anchorId orientation condition staffing supply
threatConnectionId createdAt lastEvaluation
```

Estados de construcción y evacuación, identidad de composición y anclaje sobreviven a la desmaterialización. Los objetos físicos se reconstruyen desde esa entidad lógica.

La definición, validación y selección de `compositionId` se rige por [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md).

## 32. Transferencia Altis–Stratis

```sqf
IF_stratisTransfer = createHashMapFromArray [
    ["campaignSide", "BLUE"],
    ["campaignDay", 54],
    ["unitCharacterIds", []],
    ["supportForceIds", []],
    ["alliedFactionIds", []],
    ["evidenceIds", []],
    ["knowledgeStates", []],
    ["stratisAccessLevel", 3],
    ["heliosStateSummary", createHashMap],
    ["argosExposure", 70],
    ["petrouState", "ALLY"],
    ["damarisState", "ALIVE"],
    ["vardisConfirmed", false],
    ["availableFinalOptions", []]
];
```

No se transfieren todos los sectores, convoyes, fuerzas o eventos. Tras Stratis se integran Helios, Argos, Vardis, personajes, daños, verdad y decisión en el estado completo de Altis.

## 33. Estado final

```sqf
IF_endingState = createHashMapFromArray [
    ["militaryOutcome", ""],
    ["politicalOrder", ""],
    ["civilCondition", ""],
    ["heliosOutcome", ""],
    ["argosOutcome", ""],
    ["foreignPresence", ""],
    ["publicTruth", ""],
    ["stability", ""],
    ["family", ""],
    ["modules", []],
    ["continuityCode", ""]
];
```

El resolvedor conserva reglas superadas, razones y `fallbackUsed` para pruebas. La semántica procede de [MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md](MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md).

## 34. Transacción conceptual

```text
BEGIN → VALIDATE → APPLY → CHECK → COMMIT → PUBLISH
```

Ante fallo:

```text
ROLLBACK → LOG ERROR
```

SQF la simula clonando solo las secciones afectadas antes de sustituir el estado oficial.

## 35. Rendimiento

1. No recorrer todo cada frame.
2. No copiar ni publicar el estado completo constantemente.
3. No guardar objetos.
4. No materializar fuerzas lejanas.
5. Compactar eventos triviales.
6. Usar índices por ID.
7. Cachear con invalidación.
8. Perfilar en el motor.

Índices reconstruibles:

```text
sectorsByOwner forcesByFaction missionsByState
charactersByFaction evidenceByLine
```

## 36. Flags y configuración

Flags documentados:

```text
FLAG_BLUE_BEACHHEAD_ESTABLISHED
FLAG_RED_MOLOS_SECURED
FLAG_GREEN_FRAGMENTATION_STARTED
FLAG_FIA_MARKOU_KALLAS_RUPTURE
FLAG_PHAROS_CONFIRMED
FLAG_STRATIS_LOCATED
FLAG_VARDIS_ALIVE_CONFIRMED
FLAG_ARGOS_EXPOSED
```

Solo representan hechos irreversibles o desbloqueos no cubiertos por otro campo.

Configuración inmutable vive en `.hpp`, funciones, archivos de datos o `description.ext`. Estado mutable vive en `IF_campaignState`.

## 37. Estructura de archivos

```text
functions/
├── state/
├── persistence/
├── events/
├── networking/
├── sectors/
├── factions/
├── forces/
├── logistics/
├── characters/
├── civilians/
├── helios/
├── intelligence/
├── missions/
└── endings/
```

Funciones mínimas:

```text
fn_stateCreate.sqf fn_stateValidate.sqf fn_stateClonePersistent.sqf
fn_stateGet.sqf fn_stateCommit.sqf
fn_saveCampaign.sqf fn_loadCampaign.sqf fn_validateSave.sqf
fn_migrateSave.sqf fn_createBackup.sqf
fn_eventCreate.sqf fn_eventApply.sqf fn_eventResolve.sqf
fn_requestActionServer.sqf fn_buildClientSnapshot.sqf
fn_sendClientSnapshot.sqf fn_publishDelta.sqf fn_requestResync.sqf
```

## 38. Inicialización y recuperación

`preInit`: funciones, definiciones, constantes y configuración.

`initServer.sqf`: crear/cargar, validar, reconstruir índices, iniciar simulación y red.

`initPlayerLocal.sqf`: interfaz, jugador, snapshot y eventos locales.

Un JIP nunca crea campaña ni repite consecuencias.

Recuperación intenta autosave actual, alternativo, checkpoint y migración. El modo `RECOVERY` detiene simulación, muestra diagnóstico y permite restaurar sin sobrescribir respaldos.

## 39. Pruebas

Pruebas unitarias conceptuales:

* captura, aislamiento e infraestructura;
* muerte, sucesión, confianza y traición;
* rutas, convoyes, escasez y depósitos;
* control Helios sin acceso, aislamiento y destrucción;
* guardar, cargar, migrar, respaldar y corromper;
* JIP, delta perdido, solicitud inválida y paquete antiguo.

Perfiles integrales incluyen campañas nuevas, actos intermedios, protagonista muerto, Verde fragmentada, Gobierno colapsado, Stratis, Helios destruido/nacional, migración, JIP, 40 sectores, mil eventos y campaña dual.

## 40. Fases de implementación

1. Estado mínimo, nueve sectores del vertical slice y guardado.
2. Eventos, capturas, bajas, recursos y memoria.
3. Logística, convoyes, suministro y construcción.
4. Civiles, relaciones, legitimidad y personajes.
5. Helios, inteligencia, manipulación y evidencia.
6. IA estratégica, frentes y fuerzas virtuales.
7. Stratis, paquete, resolución y retorno.
8. Cooperativo, snapshots, deltas, JIP y permisos.

La primera versión excluye bases de datos externas, múltiples servidores, economía individual, proyectiles lejanos, miles de relaciones, sincronización completa, PvP, IA generativa y simulación nacional continua.

## 41. Principios obligatorios

1. Existe una verdad estratégica autoritativa.
2. Los clientes no la modifican.
3. No se guardan referencias físicas.
4. Los IDs son estables.
5. Control y legitimidad son distintos.
6. Confianza, apoyo, obediencia y dependencia son distintos.
7. Helios separa control físico, digital e integridad.
8. Las mutaciones críticas pasan por eventos.
9. El estado se valida antes de guardarse.
10. Los autosaves alternan.
11. Las migraciones conservan el original.
12. Los derivados se recalculan.
13. Los secretos no se publican.
14. JIP recibe un snapshot coherente.
15. Las llamadas remotas se validan.
16. La red no depende del orden de mensajes JIP.
17. Un jugador mantiene arquitectura de servidor.
18. Los tres escenarios comparten `missionGroup`.
19. El final usa el estado completo.
20. Una misión fallida no corrompe la campaña.
21. Un muerto no permanece activo.
22. Fuerza virtual y física son una entidad.
23. La logística usa recursos y conexiones.
24. Cambiar el contrato exige migración.

## 42. Referencias técnicas

* [HashMap — Bohemia Interactive Community](https://community.bistudio.com/wiki/HashMap)
* [Namespace — Bohemia Interactive Community](https://community.bistudio.com/wiki/Namespace)
* [saveMissionProfileNamespace — Bohemia Interactive Community](https://community.bistudio.com/wiki/saveMissionProfileNamespace)
* [Multiplayer Scripting — Bohemia Interactive Community](https://community.bistudio.com/wiki/Multiplayer_Scripting)
* [remoteExec — Bohemia Interactive Community](https://community.bistudio.com/wiki/remoteExec)
* [CfgRemoteExec — Bohemia Interactive Community](https://community.bistudio.com/wiki/Arma_3%3A_CfgRemoteExec)

> **Una campaña persistente no consiste en guardar objetos. Consiste en guardar consecuencias.**
