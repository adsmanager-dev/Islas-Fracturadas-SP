# Arquitectura técnica, 3DEN, SQF y multijugador

> **Estado:** diseño confirmado e implementación parcial
> **Fuente de verdad para:** arquitectura técnica, persistencia, 3DEN, SQF, SP y MP futuro
> **Relacionados:** [17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md); [19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-07-24

## Propósito

Centralizar arquitectura técnica, persistencia, 3DEN, SQF, SP y MP futuro sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [PERSISTENT CAMPAIGN DATA MODEL](#fuente-persistent-campaign-data-model)
- [SQF MASTER TECHNICAL ARCHITECTURE](#fuente-sqf-master-technical-architecture)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `PERSISTENT_CAMPAIGN_DATA_MODEL.md`, `SQF_MASTER_TECHNICAL_ARCHITECTURE.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

## Contenido consolidado

<a id="fuente-persistent-campaign-data-model"></a>
## Fuente integrada: `PERSISTENT_CAMPAIGN_DATA_MODEL.md`

> **Procedencia:** contenido migrado de `PERSISTENT_CAMPAIGN_DATA_MODEL.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-persistent-campaign-data-model--modelo-de-datos-persistente-y-autoritativo-de-campaña"></a>
### Modelo de datos persistente y autoritativo de campaña

> **Estado:** contrato rector previo a implementación.
> **Motor objetivo:** Arma 3 2.18.
> **Lenguaje:** SQF.
> **Modalidad inicial:** un jugador, preparada para cooperativo de un solo bando.
> **Escenarios:** Altis, Stratis y epílogo.
> **Presentación:** los modelos visibles, permisos de conocimiento, navegación y accesibilidad se rigen por [STRATEGIC_UI_AND_PLAYER_EXPERIENCE_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system); este documento conserva la autoridad sobre el estado canónico.
> **Arquitectura SQF:** propiedad modular, commands, queries, eventos, transacciones, bootstrap, red y pruebas se rigen por [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture).
> **Origen físico estable:** posiciones, anclajes, límites y rutas registrados desde 3DEN se validan según [THREEDEN_GEOGRAPHY_AND_PHYSICAL_VALIDATION_GUIDE.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide).
> **Calidad:** fixtures, invariantes transversales, guardado prolongado, migraciones, regresión y puertas de aprobación se rigen por [MASTER_TESTING_PERFORMANCE_AND_BALANCE_SYSTEM.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system).
> **Producción:** el orden de implementación, dependencias, entregables e hitos se rige por [MASTER_IMPLEMENTATION_AND_PRODUCTION_PLAN.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan).

<a id="src-persistent-campaign-data-model--1-propósito"></a>
#### 1. Propósito

Este documento fija la representación implementable de sectores, fuerzas, logística, personajes, relaciones, civiles, Helios, inteligencia, misiones, eventos, progresión y finales. Define persistencia, autoridad, red, migraciones, recuperación y transferencia entre escenarios. Las cantidades, capacidades y reglas de reposición se definen en el [sistema militar y orden de batalla](13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md#fuente-military-system-order-of-battle-and-force-catalog).

Cualquier módulo nuevo debe respetar este contrato o aumentar `schemaVersion` y proporcionar una migración.

<a id="src-persistent-campaign-data-model--2-fuente-oficial-de-verdad"></a>
#### 2. Fuente oficial de verdad

```sqf
IF_campaignState
```

Durante la ejecución reside en `missionNamespace`. En un jugador la máquina local es autoridad; en cooperativo, solo el servidor hospedado o dedicado modifica el estado canónico. Los clientes solicitan acciones y reciben proyecciones autorizadas.

<a id="src-persistent-campaign-data-model--3-separación-de-estados"></a>
#### 3. Separación de estados

| Estado | Contenido | Persistencia |
|---|---|---|
| Canónico | Sectores, recursos, fuerzas, personajes, relaciones, evidencia, Helios, progreso | Sí |
| Operativo | Grupos, objetos, waypoints, proyectiles, patrullas y tareas locales | No; se resume |
| Derivado | Amenaza, frentes, rutas, prioridades, finales provisionales | Se recalcula |
| Presentación | UI, filtros, zoom, avisos y configuración visual; nunca es fuente de verdad | Perfil separado |

Una entidad estratégica nunca depende únicamente de que su grupo físico continúe existiendo.

<a id="src-persistent-campaign-data-model--4-persistencia"></a>
#### 4. Persistencia

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

<a id="src-persistent-campaign-data-model--5-tipos-y-referencias"></a>
#### 5. Tipos y referencias

Se utilizan `HashMap` para entidades y colecciones por ID, arrays para orden, strings para IDs y enumeraciones, números para cantidades y booleanos para estados.

No se persisten objetos, grupos, código, controles, localizaciones dinámicas ni claves basadas en objetos. Toda entidad física relevante posee un identificador lógico.

<a id="src-persistent-campaign-data-model--6-estructura-raíz"></a>
#### 6. Estructura raíz

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

<a id="src-persistent-campaign-data-model--7-identificadores"></a>
#### 7. Identificadores

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

<a id="src-persistent-campaign-data-model--8-metadatos-campaña-y-reloj"></a>
#### 8. Metadatos, campaña y reloj

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

<a id="src-persistent-campaign-data-model--9-rangos-comunes"></a>
#### 9. Rangos comunes

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

<a id="src-persistent-campaign-data-model--10-regiones-y-sectores"></a>
#### 10. Regiones y sectores

Una región conserva:

```text
id displayName sectorIds regionalIdentity economicProfile
historicalGrievance governmentSupport greenTradition fiaInfluence
blueDependency redDependency heliosDependency
regionalStability regionalMemory
```

Un sector conserva el núcleo siguiente; su extensión autoritativa para estructura, profundidad, módulos y memoria se define en el [sistema territorial](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-territorial-sector-front-and-construction-system):

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

<a id="src-persistent-campaign-data-model--11-conexiones-e-infraestructura"></a>
#### 11. Conexiones e infraestructura

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

<a id="src-persistent-campaign-data-model--12-facciones-y-recursos"></a>
#### 12. Facciones y recursos

Facción:

```text
id displayName side active militaryPower manpowerPool availableManpower
commandCapacity politicalCapital legitimacyGlobal cohesion morale
warWeariness resources doctrine strategicGoals controlledSectorIds
alliedFactionIds hostileFactionIds commanderIds activeFrontIds flags
```

Recursos físicos autoritativos, definidos por el [sistema económico y logístico](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md#fuente-economic-and-logistics-system):

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

<a id="src-persistent-campaign-data-model--13-fuerzas-y-vehículos"></a>
#### 13. Fuerzas y vehículos

Formación:

```text
id factionId parentFormationId echelon templateId manpower
effectiveStrength woundedLight woundedSerious missing captured killed
readiness morale cohesion experience supply vehicleAssetIds
specialCapabilities currentSectorId destinationSectorId assignedPlanId
status materializationState
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
id classAlias originalFaction currentOwner assignedFormation condition
fuel ammo crew location status captureProgress compatibility
```

Solo se individualizan vehículos importantes.

Proyección:

```text
id formationId missionId reservedManpower reservedVehicleIds
physicalGroupIds physicalEntityIds materializedAt materializedSector
status virtualResolutionPaused
```

Registro de grupo:

```text
groupNetId projectionId formationId role initialStrength currentStrength
ownerMachineId dynamicSimulation state
```

Registro de entidad:

```text
entityKey projectionId formationId entityType persistentCharacterId
persistentVehicleId state casualtyRegistered
```

Batalla virtual:

```text
id participantFormationIds sectorId connectionId phase phaseStartedAt
resolutionSeed pausedProjectionIds result casualtyLedger vehicleLedger
resourceConsumption state
```

Estados de existencia:

```text
V0 V1 V2 V3 V4
```

La reserva transaccional, materialización, localidad, bajas, batalla virtual, reintegración y presupuesto se rigen por [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system).

<a id="src-persistent-campaign-data-model--14-logística"></a>
#### 14. Logística

Existen reservas exteriores y de teatro, centros logísticos, existencias sectoriales, convoyes y cachés. Toda mutación sigue el [contrato económico y logístico](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md#fuente-economic-and-logistics-system).

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

<a id="src-persistent-campaign-data-model--15-personajes-y-relaciones"></a>
#### 15. Personajes y relaciones

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
from to competenceTrust professionalTrust personalTrust loyaltyTrust
judgmentTrust discretionTrust politicalTrust ideologicalAffinity
dependency grievance fear personalLoyalty compromisingKnowledge state
```

<a id="src-persistent-campaign-data-model--151-progresión-autoridad-y-capacidades"></a>
#### 15.1 Progresión, autoridad y capacidades

Progresión del jugador:

```text
campaignSide formalRank authorityMilitary authorityLogistics
authorityCivil authorityPolitical authorityIntelligence authorityHelios
commanderTrust factionReputation regionalReputation unitPrestige
unitDiscipline unitCivilReputation capabilityIds qualificationIds
investigationConclusionIds activeDelegationIds decisionProfile
disciplinaryState
```

Delegación:

```text
id grantorId recipientId authorityDomain authorityLevel scopeIds
grantedAt expiresAt state revocationReason
```

Capacidad:

```text
id category unlocked authorityDomain minimumAuthority requiredAssetType
requiredResource requiredRelationshipId temporary currentlyAvailable
unavailableReason
```

Progresión de miembro:

```text
characterId status professionalTrust personalTrust stress fatigue
qualifications experience relationshipEvents
```

Rango, autoridad contextual, confianza multidimensional, reputación, disciplina, anti-farmeo y disponibilidad explicable se rigen por [PLAYER_PROGRESSION_AUTHORITY_AND_UNLOCKS_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-progression-authority-and-unlocks-system).

Relación entre facciones:

```text
from to officialStatus militaryHostility politicalTrust
operationalCooperation dependency grievance secretChannels
treatyId ceasefireUntil
```

`setFriend` no representa por sí solo diplomacia.

<a id="src-persistent-campaign-data-model--16-civiles"></a>
#### 16. Civiles

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

La semántica completa de gobierno, servicios, detenciones, desplazamiento, promesas, rumores y memoria se rige por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-civil-municipal-political-stability-system).

<a id="src-persistent-campaign-data-model--17-helios"></a>
#### 17. Helios

Estado global:

```text
globalState networkIntegrity civilFunctions militaryFunctions
validationActive argosBackdoorAccess vardisControl publicPerception
knownByPlayer nodeIds protocolIds operatorIds activeManipulations auditLog
```

Nodo:

```text
id sectorId nodeType physicalOwner physicalController operationalState
powerAvailability networkConnectivity dataIntegrity softwareIntegrity
credentialIntegrity operatorTrust accessByFaction argosAccess auditState
capabilityIds connectedNodeIds storedReportIds
```

Control físico, acceso digital e integridad son obligatoriamente distintos. Capturar no concede credenciales.

Capacidades:

```text
POWER_MANAGEMENT HOSPITAL_COORDINATION PORT_LOGISTICS AIR_TRAFFIC
RADAR_FUSION MILITARY_LOGISTICS CIVIL_REGISTRY WEATHER_ANALYSIS
COMMUNICATION_RELAY VALIDATION_DATA MASTER_KEYS ARGOS_ARCHIVE
```

Stratis concentra claves y dirección; Altis, sensores, datos e infraestructura.

Recomendación:

```text
id nodeId requesterId problemType assumptions sourceReportIds modelId
recommendedAction alternativeActions confidence militaryRisk civilRisk
logisticsRisk argosModified state
```

<a id="src-persistent-campaign-data-model--18-inteligencia-evidencia-y-conocimiento"></a>
#### 18. Inteligencia, evidencia y conocimiento

Informe:

```text
id subjectType subjectId sourceIds originDataIds processingNodes
analystIds observedAt reportedAt receivedAt lastValidatedAt sectorId
content assessment estimatedStrengthMin estimatedStrengthMax
estimatedIntent sourceReliability informationCredibility confidence
realAccuracy ageState classification distributionList distributionPath
manipulationFlags relatedReportIds state
```

`confidence` es creencia del receptor; `accuracy`, verdad real normalmente oculta.

Estados visibles:

```text
UNKNOWN RUMORED ESTIMATED OBSERVED CONFIRMED OUTDATED
CONTESTED COMPROMISED
```

Creencia de comandante:

```text
commanderId subjectId estimatedSectorId estimatedStrengthMin
estimatedStrengthMax estimatedIntent confidence lastUpdatedAt
supportingReportIds contradictingReportIds sourceBias state
```

Comunicación:

```text
sender receiver channel createdAt sentAt receivedAt authentication
integrity priority status
```

Estados de comunicación:

```text
CREATED QUEUED TRANSMITTED DELAYED INTERCEPTED RECEIVED
CORRUPTED BLOCKED SPOOFED LOST
```

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

La semántica completa de evidencias, custodia, intérpretes, redundancia y publicación se rige por [INVESTIGATION_REVELATION_MATRIX.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-investigation-revelation-matrix).

La semántica de observación, procedencia, envejecimiento, clasificación, creencias, comunicaciones, recomendaciones, acceso y niebla de guerra se rige por [HELIOS_INTELLIGENCE_AND_FOG_OF_WAR_SYSTEM.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-helios-intelligence-and-fog-of-war-system).

<a id="src-persistent-campaign-data-model--19-misiones"></a>
#### 19. Misiones

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

La arquitectura, convención de IDs, puertas y estados se rige por [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md#fuente-blue-red-campaign-architecture).

La causalidad, espacios `TPL_*`/`NEED_*`/`DYN_*`, ventanas temporales, transformación, resolución externa y anti-repetición se rigen por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-dynamic-missions-and-emergent-events).

Estado comparado tras completar ambas campañas:

```text
sharedEvidence differences decisions survivors endings comparableFiles
comparisonUnlocked secretSceneUnlocked vardisFullContext
```

<a id="src-persistent-campaign-data-model--20-eventos-y-mutaciones"></a>
#### 20. Eventos y mutaciones

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

<a id="src-persistent-campaign-data-model--21-invariantes"></a>
#### 21. Invariantes

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

<a id="src-persistent-campaign-data-model--22-persistido-frente-a-calculado"></a>
#### 22. Persistido frente a calculado

Persistir: propiedad, recursos, fuerzas, relaciones, muertos, decisiones, evidencia, daño, legitimidad, eventos, progreso, módulos territoriales, memoria de combate y colas de construcción o evacuación.

Calcular: profundidad del frente, perfiles y vectores de amenaza, rutas, frentes, puntuación ofensiva, candidatos de misión, final provisional, objetivos e interfaz.

`frontDepth` y `threatProfile` pueden conservarse como caché de ejecución, pero se invalidan al cargar o cuando cambian propietario, conexión, alianza o frente. Su fuente de verdad es el grafo territorial más la memoria persistente.

Persistir derivados indiscriminadamente genera contradicciones.

<a id="src-persistent-campaign-data-model--23-guardado-y-recuperación"></a>
#### 23. Guardado y recuperación

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

<a id="src-persistent-campaign-data-model--24-migraciones-e-integridad"></a>
#### 24. Migraciones e integridad

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

<a id="src-persistent-campaign-data-model--25-autoridad-localidad-y-seguridad"></a>
#### 25. Autoridad, localidad y seguridad

Las funciones estratégicas siguen:

```sqf
if (!isServer) exitWith {};
```

El servidor controla estado, mutaciones, IA, guardado, misiones, muertes y finales. El cliente controla interfaz, cámara, audio, interacción y presentación.

Cada solicitud valida emisor, rol, bando, campaña, recursos, frecuencia y objetivo. La entidad estratégica no cambia cuando un grupo físico cambia de localidad.

<a id="src-persistent-campaign-data-model--26-proyección-de-cliente"></a>
#### 26. Proyección de cliente

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

<a id="src-persistent-campaign-data-model--27-paquetes-y-jip"></a>
#### 27. Paquetes y JIP

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

<a id="src-persistent-campaign-data-model--28-progresión-unidad-y-sucesión"></a>
#### 28. Progresión, unidad y sucesión

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

<a id="src-persistent-campaign-data-model--29-gobierno-fia-y-verde"></a>
#### 29. Gobierno, FIA y Verde

Gobierno:

```text
legitimacy cohesion administrativeCapacity constitutionalAuthority
securityControl blueDependency redDependency greenDependency
heliosControl capitalSectorId headOfStateId headOfGovernmentId
governmentState recognizedBy activeDecrees successionRules
```

FIA:

```text
politicalLegitimacy armedStrength cellCount activeFighters
supportNetwork weaponStock clandestineCapacity territorialControl
markouAuthority kallasAuthority blackFrontStrength nemesisInfluence
internalCohesion
```

Célula FIA:

```text
id regionId homeSectorId leaderCharacterId memberCount activeFighters
supporters training weaponStock safehouseIds cacheIds routeIds
politicalAlignment aggression discipline autonomy concealment exposure
trustMarkou trustKallas argosInfluence status
```

Depósito clandestino:

```text
id sectorId ownerCellId cacheType concealment exposure security
stocks capacity status civilianLocation collateralRisk knownByCharacters
```

Influencia FIA por sector:

```text
sectorId publicSupport privateSupport fear politicalTrustMarkou
militaryTrustKallas cellStrength clandestineControl openControl
recruitmentPotential counterinsurgencyPressure
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

La autonomía celular, exposición, relación Markou–Kallas, Frente Negro, Némesis, operaciones y contrainsurgencia se rigen por [FIA_INSURGENCY_AND_CLANDESTINE_WAR_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-fia-insurgency-and-clandestine-war-system).

<a id="src-persistent-campaign-data-model--30-comandantes-y-ciclos"></a>
#### 30. Comandantes y ciclos

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

Esa arquitectura se define en [STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-strategic-ai-and-chain-of-command).

<a id="src-persistent-campaign-data-model--31-combate-misiones-y-construcción"></a>
#### 31. Combate, misiones y construcción

El combate virtual considera fuerza, preparación, suministro, terreno, fortificación, inteligencia, apoyo, moral, comandante y variación con semilla registrable.

Se resuelve por fases y se pausa para todos los activos reservados que pasen a una proyección física, conforme a [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system).

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

La definición, validación y selección de `compositionId` se rige por [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-technical-3den-module-and-composition-catalog).

<a id="src-persistent-campaign-data-model--32-transferencia-altisstratis"></a>
#### 32. Transferencia Altis–Stratis

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

<a id="src-persistent-campaign-data-model--33-estado-final"></a>
#### 33. Estado final

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

El resolvedor conserva reglas superadas, razones y `fallbackUsed` para pruebas. La semántica procede de [MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md](08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md#fuente-modular-endings-and-epilogues-matrix).

<a id="src-persistent-campaign-data-model--34-transacción-conceptual"></a>
#### 34. Transacción conceptual

```text
BEGIN → VALIDATE → APPLY → CHECK → COMMIT → PUBLISH
```

Ante fallo:

```text
ROLLBACK → LOG ERROR
```

SQF la simula clonando solo las secciones afectadas antes de sustituir el estado oficial.

<a id="src-persistent-campaign-data-model--35-rendimiento"></a>
#### 35. Rendimiento

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

<a id="src-persistent-campaign-data-model--36-flags-y-configuración"></a>
#### 36. Flags y configuración

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

<a id="src-persistent-campaign-data-model--37-estructura-de-archivos"></a>
#### 37. Estructura de archivos

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

<a id="src-persistent-campaign-data-model--38-inicialización-y-recuperación"></a>
#### 38. Inicialización y recuperación

`preInit`: funciones, definiciones, constantes y configuración.

`initServer.sqf`: crear/cargar, validar, reconstruir índices, iniciar simulación y red.

`initPlayerLocal.sqf`: interfaz, jugador, snapshot y eventos locales.

Un JIP nunca crea campaña ni repite consecuencias.

Recuperación intenta autosave actual, alternativo, checkpoint y migración. El modo `RECOVERY` detiene simulación, muestra diagnóstico y permite restaurar sin sobrescribir respaldos.

<a id="src-persistent-campaign-data-model--39-pruebas"></a>
#### 39. Pruebas

Pruebas unitarias conceptuales:

* captura, aislamiento e infraestructura;
* muerte, sucesión, confianza y traición;
* rutas, convoyes, escasez y depósitos;
* control Helios sin acceso, aislamiento y destrucción;
* guardar, cargar, migrar, respaldar y corromper;
* JIP, delta perdido, solicitud inválida y paquete antiguo.

Perfiles integrales incluyen campañas nuevas, actos intermedios, protagonista muerto, Verde fragmentada, Gobierno colapsado, Stratis, Helios destruido/nacional, migración, JIP, 40 sectores, mil eventos y campaña dual.

<a id="src-persistent-campaign-data-model--40-fases-de-implementación"></a>
#### 40. Fases de implementación

1. Estado mínimo, nueve sectores del vertical slice y guardado.
2. Eventos, capturas, bajas, recursos y memoria.
3. Logística, convoyes, suministro y construcción.
4. Civiles, relaciones, legitimidad y personajes.
5. Helios, inteligencia, manipulación y evidencia.
6. IA estratégica, frentes y fuerzas virtuales.
7. Stratis, paquete, resolución y retorno.
8. Cooperativo, snapshots, deltas, JIP y permisos.

La primera versión excluye bases de datos externas, múltiples servidores, economía individual, proyectiles lejanos, miles de relaciones, sincronización completa, PvP, IA generativa y simulación nacional continua.

<a id="src-persistent-campaign-data-model--41-principios-obligatorios"></a>
#### 41. Principios obligatorios

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

<a id="src-persistent-campaign-data-model--42-referencias-técnicas"></a>
#### 42. Referencias técnicas

* [HashMap — Bohemia Interactive Community](https://community.bistudio.com/wiki/HashMap)
* [Namespace — Bohemia Interactive Community](https://community.bistudio.com/wiki/Namespace)
* [saveMissionProfileNamespace — Bohemia Interactive Community](https://community.bistudio.com/wiki/saveMissionProfileNamespace)
* [Multiplayer Scripting — Bohemia Interactive Community](https://community.bistudio.com/wiki/Multiplayer_Scripting)
* [remoteExec — Bohemia Interactive Community](https://community.bistudio.com/wiki/remoteExec)
* [CfgRemoteExec — Bohemia Interactive Community](https://community.bistudio.com/wiki/Arma_3%3A_CfgRemoteExec)

> **Una campaña persistente no consiste en guardar objetos. Consiste en guardar consecuencias.**

---

<a id="fuente-sqf-master-technical-architecture"></a>
## Fuente integrada: `SQF_MASTER_TECHNICAL_ARCHITECTURE.md`

> **Procedencia:** contenido migrado de `SQF_MASTER_TECHNICAL_ARCHITECTURE.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-sqf-master-technical-architecture--islas-fracturadas"></a>
### ISLAS FRACTURADAS

<a id="src-sqf-master-technical-architecture--documento-1014-arquitectura-técnica-maestra-de-sqf"></a>
#### Documento 10/14 — Arquitectura técnica maestra de SQF

**Versión:** 1.0
**Clasificación:** documento rector de arquitectura, código, estados y seguridad
**Motor:** Arma 3 2.18
**Lenguaje principal:** SQF
**Editor:** Editor 3DEN y Visual Studio Code
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando, servidor dedicado y Headless Client opcional
**Estado:** canon técnico previo a implementación

> **Jerarquía documental:** este Documento 10/14 gobierna capas, módulos, propiedad del estado, APIs, dependencias, inicialización, eventos, transacciones, configuración, persistencia técnica, red, seguridad, pruebas y reglas de código SQF. [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model) conserva el contrato detallado del estado canónico; [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system), las reglas de proyección y localidad; [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-technical-3den-module-and-composition-catalog), el catálogo físico; [THREEDEN_GEOGRAPHY_AND_PHYSICAL_VALIDATION_GUIDE.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide), el flujo de edición y validación geográfica; [STRATEGIC_UI_AND_PLAYER_EXPERIENCE_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system), los contratos funcionales de presentación; [DIALOGUE_RADIO_BRIEFING_AUDIO_AND_CINEMATICS_SYSTEM.md](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system), los contratos narrativos y audiovisuales; [MASTER_TESTING_PERFORMANCE_AND_BALANCE_SYSTEM.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system), la estrategia transversal de pruebas, métricas y aprobación; y [MASTER_IMPLEMENTATION_AND_PRODUCTION_PLAN.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan), la secuencia oficial de ejecución.

---

<a id="src-sqf-master-technical-architecture--1-propósito"></a>
### 1. Propósito

Este documento define la arquitectura obligatoria del código de Islas Fracturadas.

Establece:

* estructura de carpetas;
* nombres;
* módulos;
* responsabilidades;
* dependencias;
* contratos;
* inicialización;
* namespaces;
* autoridad;
* eventos;
* persistencia;
* guardado;
* migraciones;
* configuración;
* logging;
* errores;
* pruebas;
* rendimiento;
* seguridad multijugador;
* integración con 3DEN;
* reglas para añadir nuevas funcionalidades.

Su función es impedir que el proyecto evolucione como una colección de scripts independientes y acoplados.

<a id="src-sqf-master-technical-architecture--principio-central"></a>
#### Principio central

> Cada sistema debe ser propietario de su propio estado, exponer contratos claros y comunicarse mediante comandos, consultas y eventos.

Ningún módulo deberá modificar directamente estructuras internas pertenecientes a otro módulo.

---

<a id="src-sqf-master-technical-architecture--2-objetivos-arquitectónicos"></a>
### 2. Objetivos arquitectónicos

La arquitectura debe permitir:

1. Desarrollar primero una campaña individual.
2. Mantener autoridad estratégica compatible con servidor desde el inicio.
3. Separar lógica estratégica, táctica, interfaz y persistencia.
4. Probar cada módulo de forma aislada.
5. Guardar una campaña de larga duración.
6. Migrar partidas entre versiones.
7. Detectar errores antes de corromper el estado.
8. Evitar dependencias circulares.
9. Mantener rendimiento en Altis.
10. Añadir cooperativo sin reescribir los sistemas principales.
11. Poder sustituir almacenamiento local por almacenamiento de servidor.
12. Poder virtualizar fuerzas sin perder identidad.
13. Auditar cada cambio importante.
14. Explicar por qué cambió el estado.
15. Permitir que otra IA o desarrollador comprenda el proyecto por documentación.

---

<a id="src-sqf-master-technical-architecture--3-principios-técnicos-obligatorios"></a>
### 3. Principios técnicos obligatorios

1. El estado estratégico será autoritativo.
2. La interfaz nunca será propietaria del estado.
3. Los objetos físicos no serán la fuente principal de persistencia.
4. Cada módulo tendrá una responsabilidad delimitada.
5. Ningún módulo accederá directamente a datos privados de otro.
6. Los cambios se realizarán mediante funciones públicas.
7. Los eventos informarán; no sustituirán validaciones.
8. Toda mutación importante deberá validarse.
9. Toda mutación persistente deberá poder registrarse.
10. Todo ID persistente será estable.
11. Los objetos del motor usarán referencias temporales.
12. Los estados guardados no almacenarán referencias inválidas de objetos.
13. La lógica estratégica no dependerá del cliente.
14. La lógica táctica respetará localidad.
15. `remoteExec` utilizará lista blanca.
16. Los módulos se inicializarán por fases.
17. Las dependencias se declararán.
18. No existirán bucles permanentes por entidad.
19. Se utilizarán schedulers centrales.
20. Los archivos de configuración estarán separados de la lógica.
21. Las funciones tendrán cabeceras documentadas.
22. Los errores no se ocultarán silenciosamente.
23. Los datos guardados tendrán versión.
24. Cada versión podrá migrar desde la anterior soportada.
25. El vertical slice validará la arquitectura antes de escalar.

---

<a id="src-sqf-master-technical-architecture--4-separación-por-capas"></a>
### 4. Separación por capas

La solución se dividirá en seis capas.

```text
PRESENTATION
APPLICATION
DOMAIN
SIMULATION
INFRASTRUCTURE
CONFIGURATION
```

---

<a id="src-sqf-master-technical-architecture--5-capa-presentation"></a>
### 5. Capa PRESENTATION

Contiene:

* interfaz;
* mapas;
* paneles;
* notificaciones;
* diálogos;
* subtítulos;
* view models.

Puede:

* consultar datos preparados;
* enviar solicitudes;
* presentar resultados.

No puede:

* modificar directamente sectores;
* descontar recursos;
* cambiar propietario;
* registrar bajas;
* avanzar actos.

---

<a id="src-sqf-master-technical-architecture--6-capa-application"></a>
### 6. Capa APPLICATION

Coordina casos de uso.

Ejemplos:

* aceptar misión;
* ordenar convoy;
* asignar prioridad;
* iniciar auditoría;
* ejecutar guardado;
* avanzar acto.

Su función es coordinar módulos sin contener toda la lógica interna.

---

<a id="src-sqf-master-technical-architecture--7-capa-domain"></a>
### 7. Capa DOMAIN

Contiene las reglas de campaña.

Módulos principales:

* campaña;
* sectores;
* fuerzas;
* logística;
* economía;
* civiles;
* FIA;
* inteligencia;
* Helios;
* progresión;
* misiones;
* relaciones;
* personajes;
* finales.

No debe depender de:

* controles de interfaz;
* diálogos específicos de Arma;
* objetos físicos salvo mediante adaptadores.

---

<a id="src-sqf-master-technical-architecture--8-capa-simulation"></a>
### 8. Capa SIMULATION

Conecta el dominio con el mundo físico.

Contiene:

* materialización;
* grupos;
* vehículos;
* combate;
* waypoints;
* Dynamic Simulation;
* composiciones;
* entidades de 3DEN;
* eventos del motor.

---

<a id="src-sqf-master-technical-architecture--9-capa-infrastructure"></a>
### 9. Capa INFRASTRUCTURE

Contiene servicios transversales:

* guardado;
* carga;
* migración;
* logging;
* eventos;
* scheduler;
* red;
* diagnósticos;
* serialización;
* generación de IDs;
* adaptadores de almacenamiento.

---

<a id="src-sqf-master-technical-architecture--10-capa-configuration"></a>
### 10. Capa CONFIGURATION

Contiene catálogos y reglas configurables:

* facciones;
* sectores;
* unidades;
* módulos;
* composiciones;
* doctrinas;
* misiones;
* recursos;
* personajes;
* diálogos;
* balance.

<a id="src-sqf-master-technical-architecture--regla"></a>
#### Regla

Cambiar un coste o composición no deberá exigir editar funciones de dominio.

---

<a id="src-sqf-master-technical-architecture--11-prefijo-global"></a>
### 11. Prefijo global

Todo identificador público utilizará:

```text
IF_
```

Funciones:

```text
IF_fnc_nombreFuncion
```

Variables globales controladas:

```text
IF_campaignState
IF_runtime
IF_config
IF_services
IF_registries
```

Eventos:

```text
IF_EVENT_SECTOR_CAPTURED
IF_EVENT_CONVOY_DESTROYED
```

IDs:

```text
ALT_CW_NEOCHORI
FORM_BLUE_A_COY_01
CHAR_BLUE_WARD
```

---

<a id="src-sqf-master-technical-architecture--12-convención-de-nombres"></a>
### 12. Convención de nombres

<a id="src-sqf-master-technical-architecture--funciones"></a>
#### Funciones

```text
IF_fnc_moduloAccion
```

Ejemplos:

```text
IF_fnc_sectorEvaluate
IF_fnc_logisticsCreateConvoy
IF_fnc_saveCreateSnapshot
```

<a id="src-sqf-master-technical-architecture--archivos"></a>
#### Archivos

```text
fn_sectorEvaluate.sqf
fn_logisticsCreateConvoy.sqf
```

<a id="src-sqf-master-technical-architecture--variables-locales"></a>
#### Variables locales

```sqf
private _sectorId = "";
private _result = createHashMap;
```

<a id="src-sqf-master-technical-architecture--parámetros"></a>
#### Parámetros

```sqf
params [
    ["_sectorId", "", [""]],
    ["_options", createHashMap, [createHashMap]]
];
```

<a id="src-sqf-master-technical-architecture--constantes"></a>
#### Constantes

```text
IF_CONST_MAX_ACTIVE_GROUPS
IF_CONST_SAVE_SCHEMA_VERSION
```

---

<a id="src-sqf-master-technical-architecture--13-estructura-principal-de-carpetas"></a>
### 13. Estructura principal de carpetas

```text
IslasFracturadas.Altis/
├── mission.sqm
├── description.ext
├── init.sqf
├── initServer.sqf
├── initPlayerLocal.sqf
├── initPlayerServer.sqf
├── onPlayerRespawn.sqf
├── stringtable.xml
│
├── cfg/
├── core/
├── modules/
├── simulation/
├── ui/
├── campaign/
├── compositions/
├── data/
├── tests/
├── diagnostics/
├── docs/
└── assets/
```

---

<a id="src-sqf-master-technical-architecture--14-carpeta-cfg"></a>
### 14. Carpeta `cfg`

```text
cfg/
├── CfgFunctions.hpp
├── CfgRemoteExec.hpp
├── CfgSounds.hpp
├── CfgMusic.hpp
├── CfgNotifications.hpp
├── CfgDebriefing.hpp
├── RscTitles.hpp
├── dialogs.hpp
└── defines.hpp
```

<a id="src-sqf-master-technical-architecture--función"></a>
#### Función

Centralizar configuraciones cargadas por `description.ext`.

---

<a id="src-sqf-master-technical-architecture--15-carpeta-core"></a>
### 15. Carpeta `core`

```text
core/
├── bootstrap/
├── state/
├── events/
├── scheduler/
├── services/
├── validation/
├── serialization/
├── ids/
├── logging/
├── errors/
├── network/
└── utilities/
```

Contiene infraestructura compartida.

No contiene reglas propias de:

* sectores;
* FIA;
* economía;
* historia.

---

<a id="src-sqf-master-technical-architecture--16-carpeta-modules"></a>
### 16. Carpeta `modules`

```text
modules/
├── campaign/
├── sectors/
├── factions/
├── forces/
├── logistics/
├── economy/
├── construction/
├── civilians/
├── governance/
├── fia/
├── intelligence/
├── helios/
├── missions/
├── characters/
├── relationships/
├── progression/
├── evidence/
├── endings/
└── world/
```

Cada módulo tendrá la misma estructura interna.

---

<a id="src-sqf-master-technical-architecture--17-estructura-interna-de-módulo"></a>
### 17. Estructura interna de módulo

Ejemplo:

```text
modules/logistics/
├── config/
├── commands/
├── queries/
├── events/
├── handlers/
├── domain/
├── application/
├── validation/
├── serialization/
├── diagnostics/
├── tests/
└── README.md
```

---

<a id="src-sqf-master-technical-architecture--18-commands-queries-y-events"></a>
### 18. Commands, queries y events

Cada módulo separará tres tipos de operación.

<a id="src-sqf-master-technical-architecture--command"></a>
#### Command

Solicita cambiar el estado.

Ejemplo:

```text
IF_fnc_logisticsCommandCreateConvoy
```

<a id="src-sqf-master-technical-architecture--query"></a>
#### Query

Consulta sin modificar.

Ejemplo:

```text
IF_fnc_logisticsQueryGetAvailableStock
```

<a id="src-sqf-master-technical-architecture--event"></a>
#### Event

Notifica algo que ya ocurrió.

Ejemplo:

```text
IF_EVENT_CONVOY_ARRIVED
```

<a id="src-sqf-master-technical-architecture--principio"></a>
#### Principio

```text
Command:
intenta hacer algo.

Event:
informa que algo ocurrió.

Query:
pregunta por el estado.
```

---

<a id="src-sqf-master-technical-architecture--19-api-pública-de-cada-módulo"></a>
### 19. API pública de cada módulo

Cada módulo deberá documentar:

```text
PUBLIC COMMANDS
PUBLIC QUERIES
PUBLISHED EVENTS
CONSUMED EVENTS
OWNED STATE
DEPENDENCIES
```

<a id="src-sqf-master-technical-architecture--ejemplo-de-logística"></a>
#### Ejemplo de logística

<a id="src-sqf-master-technical-architecture--estado-propietario"></a>
##### Estado propietario

* centros logísticos;
* rutas;
* convoyes;
* reservas de transporte.

<a id="src-sqf-master-technical-architecture--commands"></a>
##### Commands

* crear convoy;
* cancelar;
* desviar;
* descargar.

<a id="src-sqf-master-technical-architecture--queries"></a>
##### Queries

* obtener ruta;
* obtener existencias;
* obtener demanda.

<a id="src-sqf-master-technical-architecture--events"></a>
##### Events

* convoy creado;
* convoy atacado;
* convoy llegado;
* carga perdida.

---

<a id="src-sqf-master-technical-architecture--20-estado-privado-del-módulo"></a>
### 20. Estado privado del módulo

El módulo de logística no permitirá que otro módulo haga:

```sqf
IF_campaignState get "logistics" set ["convoys", _newConvoys];
```

Deberá utilizar:

```sqf
[_convoyRequest] call IF_fnc_logisticsCommandCreateConvoy;
```

<a id="src-sqf-master-technical-architecture--razón"></a>
#### Razón

El comando:

* valida;
* reserva recursos;
* registra evento;
* actualiza índices;
* informa errores.

---

<a id="src-sqf-master-technical-architecture--21-dependencias-permitidas"></a>
### 21. Dependencias permitidas

La dirección general será:

```text
UI
↓
APPLICATION
↓
DOMAIN
↓
INFRASTRUCTURE
```

Los módulos de dominio pueden consumir servicios de infraestructura.

No deben depender de UI.

---

<a id="src-sqf-master-technical-architecture--22-dependencias-entre-módulos"></a>
### 22. Dependencias entre módulos

Se utilizarán dependencias por contrato, no acceso interno.

Ejemplo:

```text
Missions
→ consulta Logistics
→ consulta Forces
→ solicita reservations
→ crea Mission
```

Missions no modifica directamente:

* convoyes;
* fuerza efectiva;
* recursos.

---

<a id="src-sqf-master-technical-architecture--23-prevención-de-dependencias-circulares"></a>
### 23. Prevención de dependencias circulares

Ejemplo incorrecto:

```text
Logistics depende de Missions.
Missions depende de Logistics.
```

Solución:

```text
Logistics publica NEED_CREATED.
Mission Director consume NEED_CREATED.
Mission Director publica MISSION_RESOLVED.
Logistics consume MISSION_RESOLVED.
```

Los eventos rompen el acoplamiento directo.

---

<a id="src-sqf-master-technical-architecture--24-mapa-de-dependencias-de-alto-nivel"></a>
### 24. Mapa de dependencias de alto nivel

```text
Campaign
├── Acts
├── Missions
├── Progression
└── Endings

World
├── Sectors
├── Connections
├── Regions
└── Infrastructure

Military
├── Factions
├── Forces
├── StrategicAI
├── TacticalSimulation
└── Vehicles

Society
├── Civilians
├── Governance
├── FIA
└── Relations

Support
├── Logistics
├── Economy
├── Construction
└── Medical

Information
├── Intelligence
├── Evidence
├── Helios
└── Argos

Infrastructure
├── Persistence
├── Events
├── Scheduler
├── Logging
└── Network
```

---

<a id="src-sqf-master-technical-architecture--25-cfgfunctions"></a>
### 25. `CfgFunctions`

Todas las funciones permanentes se registrarán mediante una organización coherente.

Ejemplo conceptual:

```cpp
class CfgFunctions
{
    class IF
    {
        tag = "IF";

        class Core
        {
            file = "core";
            class bootstrapPreInit { preInit = 1; };
            class bootstrapPostInit { postInit = 1; };
        };

        class Sector
        {
            file = "modules\sectors";
            class sectorEvaluate {};
            class sectorQueryGet {};
            class sectorCommandSetPriority {};
        };

        class Logistics
        {
            file = "modules\logistics";
            class logisticsCreateConvoy {};
            class logisticsEvaluate {};
        };
    };
};
```

<a id="src-sqf-master-technical-architecture--regla-1"></a>
#### Regla

No registrar todas las funciones en una única categoría gigantesca.

---

<a id="src-sqf-master-technical-architecture--26-funciones-preinit"></a>
### 26. Funciones `preInit`

Solo se utilizarán para:

* constantes;
* servicios base;
* registro de funciones;
* configuración crítica;
* estructuras vacías;
* validadores básicos.

No deberán:

* crear fuerzas;
* iniciar campaña;
* materializar objetos;
* depender del mundo completamente cargado.

---

<a id="src-sqf-master-technical-architecture--27-funciones-postinit"></a>
### 27. Funciones `postInit`

Podrán:

* iniciar bootstrap;
* registrar event handlers;
* detectar contexto;
* preparar servicios;
* esperar fases posteriores.

No deberán mezclar toda la inicialización en una sola función.

---

<a id="src-sqf-master-technical-architecture--28-fases-de-inicialización"></a>
### 28. Fases de inicialización

```text
PHASE_00_PREINIT
PHASE_10_ENGINE_READY
PHASE_20_CONFIG
PHASE_30_SERVICES
PHASE_40_STATE
PHASE_50_WORLD
PHASE_60_MODULES
PHASE_70_SCENARIO
PHASE_80_UI
PHASE_90_RUNNING
```

---

<a id="src-sqf-master-technical-architecture--29-fase-00-preinit"></a>
### 29. Fase 00 — PreInit

Crea:

* constantes;
* funciones básicas;
* logger mínimo;
* registro de errores;
* identificadores de entorno.

---

<a id="src-sqf-master-technical-architecture--30-fase-10-motor-preparado"></a>
### 30. Fase 10 — Motor preparado

Verifica:

* `isServer`;
* `hasInterface`;
* multijugador;
* mundo;
* versión;
* misión;
* DLC disponibles;
* perfiles opcionales.

---

<a id="src-sqf-master-technical-architecture--31-fase-20-configuración"></a>
### 31. Fase 20 — Configuración

Carga y valida:

* sectores;
* facciones;
* recursos;
* módulos;
* composiciones;
* unidades;
* personajes;
* misiones;
* balance.

<a id="src-sqf-master-technical-architecture--resultado"></a>
#### Resultado

```text
IF_configReady = true
```

---

<a id="src-sqf-master-technical-architecture--32-fase-30-servicios"></a>
### 32. Fase 30 — Servicios

Inicializa:

* bus de eventos;
* scheduler;
* IDs;
* persistence adapter;
* network adapter;
* logger;
* transaction manager;
* diagnostics.

---

<a id="src-sqf-master-technical-architecture--33-fase-40-estado"></a>
### 33. Fase 40 — Estado

Decide:

```text
NEW_CAMPAIGN
LOAD_CAMPAIGN
LOAD_CHECKPOINT
TEST_SCENARIO
EDITOR_PREVIEW
```

Después:

* crea o carga estado;
* migra;
* valida;
* construye índices.

---

<a id="src-sqf-master-technical-architecture--34-fase-50-mundo"></a>
### 34. Fase 50 — Mundo

Registra:

* sectores;
* anclajes;
* composiciones;
* objetos 3DEN;
* marcadores;
* conexiones;
* entidades narrativas iniciales.

---

<a id="src-sqf-master-technical-architecture--35-fase-60-módulos"></a>
### 35. Fase 60 — Módulos

Inicializa módulos en orden de dependencias.

Ejemplo:

```text
World
→ Factions
→ Characters
→ Sectors
→ Forces
→ Logistics
→ Civilians
→ Intelligence
→ Missions
→ Campaign
```

---

<a id="src-sqf-master-technical-architecture--36-fase-70-escenario"></a>
### 36. Fase 70 — Escenario

Activa:

* prólogo;
* acto;
* misión;
* vertical slice;
* estados iniciales;
* materialización necesaria.

---

<a id="src-sqf-master-technical-architecture--37-fase-80-interfaz"></a>
### 37. Fase 80 — Interfaz

En clientes:

* crea view models iniciales;
* activa notificaciones;
* abre briefing si corresponde;
* sincroniza estado autorizado.

---

<a id="src-sqf-master-technical-architecture--38-fase-90-running"></a>
### 38. Fase 90 — Running

Activa:

* schedulers;
* IA estratégica;
* simulación;
* generación dinámica;
* autosave;
* diagnósticos no intrusivos.

---

<a id="src-sqf-master-technical-architecture--39-estado-de-bootstrap"></a>
### 39. Estado de bootstrap

```sqf
IF_bootstrapState = createHashMapFromArray [
    ["phase", "PHASE_40_STATE"],
    ["startedAt", diag_tickTime],
    ["errors", []],
    ["warnings", []],
    ["completedPhases", []],
    ["ready", false]
];
```

---

<a id="src-sqf-master-technical-architecture--40-fallo-de-inicialización"></a>
### 40. Fallo de inicialización

Un módulo crítico puede detener el arranque.

Ejemplos:

* esquema incompatible;
* configuración de sectores inválida;
* IDs duplicados;
* función esencial ausente.

<a id="src-sqf-master-technical-architecture--resultado-1"></a>
#### Resultado

Mostrar:

* módulo;
* fase;
* error;
* recomendación;
* log.

No continuar con estado parcial silenciosamente.

---

<a id="src-sqf-master-technical-architecture--41-namespaces"></a>
### 41. Namespaces

Se utilizarán según finalidad.

<a id="src-sqf-master-technical-architecture--missionnamespace"></a>
#### `missionNamespace`

Estado de ejecución principal.

Contiene:

* servicios;
* registros;
* estado de campaña activo;
* cachés;
* runtime.

<a id="src-sqf-master-technical-architecture--uinamespace"></a>
#### `uiNamespace`

Datos temporales de interfaz.

No contiene estado autoritativo.

<a id="src-sqf-master-technical-architecture--profilenamespace"></a>
#### `profileNamespace`

Almacenamiento local de campaña SP mediante adaptador.

<a id="src-sqf-master-technical-architecture--parsingnamespace"></a>
#### `parsingNamespace`

Uso limitado para procesamiento si resulta necesario.

<a id="src-sqf-master-technical-architecture--localnamespace"></a>
#### `localNamespace`

No será base de sistemas persistentes.

---

<a id="src-sqf-master-technical-architecture--42-variables-globales-permitidas"></a>
### 42. Variables globales permitidas

Se reducirán a contenedores controlados.

```sqf
IF_campaignState
IF_runtime
IF_config
IF_services
IF_registries
IF_diagnostics
```

<a id="src-sqf-master-technical-architecture--prohibición"></a>
#### Prohibición

No crear decenas de variables globales como:

```text
IF_blueFuel
IF_blueAmmo
IF_neochoriOwner
IF_neochoriThreat
```

Toda esa información pertenece a estructuras del dominio.

---

<a id="src-sqf-master-technical-architecture--43-ifcampaignstate"></a>
### 43. `IF_campaignState`

Contenedor persistente principal.

```sqf
IF_campaignState = createHashMapFromArray [
    ["meta", createHashMap],
    ["campaign", createHashMap],
    ["clock", createHashMap],
    ["world", createHashMap],
    ["sectors", createHashMap],
    ["factions", createHashMap],
    ["forces", createHashMap],
    ["logistics", createHashMap],
    ["civilians", createHashMap],
    ["governance", createHashMap],
    ["fia", createHashMap],
    ["intelligence", createHashMap],
    ["helios", createHashMap],
    ["missions", createHashMap],
    ["characters", createHashMap],
    ["relations", createHashMap],
    ["progression", createHashMap],
    ["evidence", createHashMap],
    ["events", []],
    ["endings", createHashMap]
];
```

---

<a id="src-sqf-master-technical-architecture--44-ifruntime"></a>
### 44. `IF_runtime`

Contiene datos no persistentes.

```sqf
IF_runtime = createHashMapFromArray [
    ["bootstrap", createHashMap],
    ["scheduler", createHashMap],
    ["activeTransactions", createHashMap],
    ["materializedEntities", createHashMap],
    ["uiSubscribers", []],
    ["networkClients", createHashMap],
    ["debugFlags", createHashMap]
];
```

---

<a id="src-sqf-master-technical-architecture--45-ifconfig"></a>
### 45. `IF_config`

Contiene catálogos inmutables durante ejecución normal.

```sqf
IF_config = createHashMapFromArray [
    ["factions", createHashMap],
    ["resources", createHashMap],
    ["sectors", createHashMap],
    ["unitCatalog", createHashMap],
    ["moduleCatalog", createHashMap],
    ["compositionCatalog", createHashMap],
    ["missionTemplates", createHashMap],
    ["characters", createHashMap],
    ["balance", createHashMap]
];
```

---

<a id="src-sqf-master-technical-architecture--46-ifregistries"></a>
### 46. `IF_registries`

Índices y referencias temporales.

```sqf
IF_registries = createHashMapFromArray [
    ["entitiesById", createHashMap],
    ["groupsById", createHashMap],
    ["vehiclesById", createHashMap],
    ["markersById", createHashMap],
    ["anchorsById", createHashMap],
    ["objectsBySector", createHashMap],
    ["subscriptions", createHashMap]
];
```

---

<a id="src-sqf-master-technical-architecture--47-ids-persistentes"></a>
### 47. IDs persistentes

Los IDs serán:

* legibles;
* estables;
* únicos;
* independientes de objetos del motor.

Ejemplos:

```text
CHAR_BLUE_WARD
ALT_CW_NEOCHORI
FORM_RED_MECH_01
CONVOY_BLUE_014
EVD_RED_ASTERION_CODES
```

---

<a id="src-sqf-master-technical-architecture--48-ids-de-ejecución"></a>
### 48. IDs de ejecución

Elementos temporales pueden utilizar:

```text
RUN_{timestamp}_{counter}
PROJ_{formationId}_{counter}
TX_{module}_{counter}
```

<a id="src-sqf-master-technical-architecture--regla-2"></a>
#### Regla

No utilizar únicamente `netId` o referencia de objeto como identidad persistente.

---

<a id="src-sqf-master-technical-architecture--49-servicio-de-ids"></a>
### 49. Servicio de IDs

Funciones:

```text
IF_fnc_idGeneratePersistent
IF_fnc_idGenerateRuntime
IF_fnc_idValidate
IF_fnc_idCheckDuplicate
```

---

<a id="src-sqf-master-technical-architecture--50-estado-y-referencias-del-motor"></a>
### 50. Estado y referencias del motor

Una estructura persistente podrá guardar:

```text
characterId
vehicleId
sectorId
```

No deberá guardar directamente como dato persistente:

```sqf
_obj
_group
```

Las referencias del motor viven en registries temporales.

---

<a id="src-sqf-master-technical-architecture--51-consultas-por-id"></a>
### 51. Consultas por ID

Ejemplo:

```sqf
private _vehicleObject = [
    "VEH_BLUE_MARSHALL_01"
] call IF_fnc_entityRegistryGetObject;
```

Si no está materializado:

```sqf
objNull
```

Esto no significa que el vehículo no exista estratégicamente.

---

<a id="src-sqf-master-technical-architecture--52-bus-de-eventos"></a>
### 52. Bus de eventos

Todos los módulos podrán publicar y consumir eventos normalizados.

Ejemplo:

```sqf
[
    "IF_EVENT_SECTOR_CAPTURED",
    createHashMapFromArray [
        ["sectorId", "ALT_CW_NEOCHORI"],
        ["oldOwner", "FAC_GREEN"],
        ["newOwner", "FAC_BLUE"]
    ]
] call IF_fnc_eventPublish;
```

---

<a id="src-sqf-master-technical-architecture--53-estructura-de-evento"></a>
### 53. Estructura de evento

```sqf
IF_event = createHashMapFromArray [
    ["id", "EVT_001234"],
    ["type", "IF_EVENT_SECTOR_CAPTURED"],
    ["createdAt", 1420],
    ["sourceModule", "SECTORS"],
    ["sourceId", "ALT_CW_NEOCHORI"],
    ["payload", createHashMap],
    ["persistent", true],
    ["processedBy", []]
];
```

---

<a id="src-sqf-master-technical-architecture--54-eventos-persistentes-y-transitorios"></a>
### 54. Eventos persistentes y transitorios

<a id="src-sqf-master-technical-architecture--persistentes"></a>
#### Persistentes

Se guardan como historial.

Ejemplos:

* sector capturado;
* personaje muerto;
* promesa rota;
* evidencia publicada.

<a id="src-sqf-master-technical-architecture--transitorios"></a>
#### Transitorios

Solo coordinan ejecución.

Ejemplos:

* panel abierto;
* waypoint completado;
* caché invalidada.

---

<a id="src-sqf-master-technical-architecture--55-publicación-síncrona-y-diferida"></a>
### 55. Publicación síncrona y diferida

<a id="src-sqf-master-technical-architecture--síncrona"></a>
#### Síncrona

Solo para:

* validaciones cortas;
* cambios que necesitan respuesta inmediata.

<a id="src-sqf-master-technical-architecture--diferida"></a>
#### Diferida

Para:

* consecuencias;
* actualizaciones secundarias;
* generación de misiones;
* logging;
* interfaz.

<a id="src-sqf-master-technical-architecture--regla-3"></a>
#### Regla

Evitar cadenas profundas de eventos síncronos.

---

<a id="src-sqf-master-technical-architecture--56-cola-de-eventos"></a>
### 56. Cola de eventos

Los eventos diferidos se procesarán mediante scheduler.

```sqf
IF_eventQueue = [];
```

Cada ciclo procesa un presupuesto limitado.

---

<a id="src-sqf-master-technical-architecture--57-idempotencia-de-eventos"></a>
### 57. Idempotencia de eventos

Un handler debe poder detectar si ya procesó un evento persistente.

<a id="src-sqf-master-technical-architecture--ejemplo"></a>
#### Ejemplo

Un evento de convoy llegado no puede descargar dos veces si:

* se reintenta;
* se carga partida;
* un handler se ejecuta nuevamente.

---

<a id="src-sqf-master-technical-architecture--58-registro-de-handlers"></a>
### 58. Registro de handlers

```sqf
[
    "IF_EVENT_CONVOY_ARRIVED",
    "LOGISTICS_STOCK_HANDLER",
    IF_fnc_logisticsHandleConvoyArrived
] call IF_fnc_eventSubscribe;
```

---

<a id="src-sqf-master-technical-architecture--59-scheduler-central"></a>
### 59. Scheduler central

No se utilizará un bucle infinito independiente por:

* sector;
* convoy;
* formación;
* personaje;
* misión.

Se utilizarán colas centrales por frecuencia.

---

<a id="src-sqf-master-technical-architecture--60-categorías-del-scheduler"></a>
### 60. Categorías del scheduler

```text
REALTIME
HIGH
MEDIUM
LOW
DAILY
EVENT_DRIVEN
```

<a id="src-sqf-master-technical-architecture--realtime"></a>
#### REALTIME

Solo para funciones tácticas necesarias.

<a id="src-sqf-master-technical-architecture--high"></a>
#### HIGH

Cada pocos segundos.

<a id="src-sqf-master-technical-architecture--medium"></a>
#### MEDIUM

Cada 30–90 segundos.

<a id="src-sqf-master-technical-architecture--low"></a>
#### LOW

Cada varios minutos.

<a id="src-sqf-master-technical-architecture--daily"></a>
#### DAILY

Ciclo estratégico diario.

---

<a id="src-sqf-master-technical-architecture--61-tarea-programada"></a>
### 61. Tarea programada

```sqf
IF_task = createHashMapFromArray [
    ["id", "TASK_LOGISTICS_TICK"],
    ["module", "LOGISTICS"],
    ["function", IF_fnc_logisticsEvaluate],
    ["interval", 60],
    ["nextRun", diag_tickTime + 60],
    ["priority", "MEDIUM"],
    ["enabled", true],
    ["maxRuntime", 0.01]
];
```

---

<a id="src-sqf-master-technical-architecture--62-presupuesto-de-ejecución"></a>
### 62. Presupuesto de ejecución

El scheduler limitará:

* funciones por frame;
* tiempo de ejecución;
* tamaño de cola.

Si una tarea excede presupuesto:

* registrar;
* dividir;
* posponer;
* degradar frecuencia.

---

<a id="src-sqf-master-technical-architecture--63-trabajo-por-lotes"></a>
### 63. Trabajo por lotes

Ejemplo incorrecto:

```sqf
{
    [_x] call IF_fnc_sectorEvaluate;
} forEach allSectors;
```

en cada frame.

Ejemplo correcto:

* evaluar sectores por lotes;
* priorizar frentes activos;
* actualizar retaguardia con menor frecuencia.

---

<a id="src-sqf-master-technical-architecture--64-reloj-de-campaña"></a>
### 64. Reloj de campaña

Se distinguirán:

```text
engineTime
strategicTime
campaignDate
```

<a id="src-sqf-master-technical-architecture--engine-time"></a>
#### Engine time

Tiempo de ejecución.

<a id="src-sqf-master-technical-architecture--strategic-time"></a>
#### Strategic time

Tiempo simulado de campaña.

<a id="src-sqf-master-technical-architecture--campaign-date"></a>
#### Campaign date

Fecha narrativa.

---

<a id="src-sqf-master-technical-architecture--65-servicio-de-reloj"></a>
### 65. Servicio de reloj

Funciones:

```text
IF_fnc_clockGetStrategicTime
IF_fnc_clockAdvance
IF_fnc_clockScheduleEvent
IF_fnc_clockConvertToDate
```

<a id="src-sqf-master-technical-architecture--regla-4"></a>
#### Regla

No utilizar únicamente `time` para todos los plazos persistentes.

---

<a id="src-sqf-master-technical-architecture--66-pausa-y-aceleración"></a>
### 66. Pausa y aceleración

La campaña individual puede permitir:

* pausa en interfaces;
* avance estratégico controlado;
* espera.

Los schedulers deben distinguir:

* tiempo real;
* tiempo estratégico.

---

<a id="src-sqf-master-technical-architecture--67-transacciones"></a>
### 67. Transacciones

Cambios complejos utilizarán transacciones.

Ejemplos:

* crear convoy;
* materializar fuerza;
* capturar sector;
* transferir recurso;
* iniciar construcción.

---

<a id="src-sqf-master-technical-architecture--68-estructura-de-transacción"></a>
### 68. Estructura de transacción

```sqf
IF_transaction = createHashMapFromArray [
    ["id", "TX_LOGISTICS_014"],
    ["module", "LOGISTICS"],
    ["state", "OPEN"],
    ["operations", []],
    ["reservations", []],
    ["startedAt", diag_tickTime],
    ["error", ""]
];
```

Estados:

```text
OPEN
VALIDATING
COMMITTING
COMMITTED
ROLLING_BACK
ROLLED_BACK
FAILED
```

---

<a id="src-sqf-master-technical-architecture--69-reserva-antes-de-commit"></a>
### 69. Reserva antes de commit

Antes de crear convoy:

1. Reservar carga.
2. Reservar vehículos.
3. Reservar escolta.
4. Validar ruta.
5. Crear entidad.
6. Confirmar.

Si falla cualquier punto:

* liberar todas las reservas.

---

<a id="src-sqf-master-technical-architecture--70-validation-layer"></a>
### 70. Validation layer

Cada command deberá validar:

* parámetros;
* existencia;
* propietario;
* estado;
* autoridad;
* recursos;
* incompatibilidades;
* duplicación.

---

<a id="src-sqf-master-technical-architecture--71-resultado-estándar"></a>
### 71. Resultado estándar

Las funciones públicas que puedan fallar devolverán:

```sqf
[
    true,
    _data,
    ""
]
```

o:

```sqf
[
    false,
    createHashMap,
    "LOGISTICS_INSUFFICIENT_TRANSPORT"
]
```

<a id="src-sqf-master-technical-architecture--regla-5"></a>
#### Regla

No utilizar solamente `nil` para representar todos los fallos.

---

<a id="src-sqf-master-technical-architecture--72-códigos-de-error"></a>
### 72. Códigos de error

Formato:

```text
MODULE_REASON_DETAIL
```

Ejemplos:

```text
SECTOR_NOT_FOUND
LOGISTICS_INSUFFICIENT_STOCK
FORCE_ALREADY_RESERVED
HELIOS_ACCESS_DENIED
SAVE_SCHEMA_INVALID
```

---

<a id="src-sqf-master-technical-architecture--73-servicio-de-errores"></a>
### 73. Servicio de errores

```text
IF_fnc_errorCreate
IF_fnc_errorRaise
IF_fnc_errorLog
IF_fnc_errorToUserMessage
```

<a id="src-sqf-master-technical-architecture--clasificación"></a>
#### Clasificación

```text
INFO
WARNING
RECOVERABLE
CRITICAL
FATAL
```

---

<a id="src-sqf-master-technical-architecture--74-errores-recuperables"></a>
### 74. Errores recuperables

Ejemplo:

* convoy no puede crearse;
* módulo de construcción bloqueado;
* autoridad insuficiente.

Se devuelve una explicación.

---

<a id="src-sqf-master-technical-architecture--75-errores-críticos"></a>
### 75. Errores críticos

Ejemplo:

* estado duplicado;
* referencia persistente rota;
* transacción inconsistente;
* save corrupto.

Pueden:

* detener módulo;
* crear snapshot de emergencia;
* mostrar diagnóstico.

---

<a id="src-sqf-master-technical-architecture--76-logging"></a>
### 76. Logging

El sistema de logs tendrá categorías.

```text
BOOT
CONFIG
STATE
SAVE
EVENT
SECTOR
FORCE
TACTICAL
LOGISTICS
CIVIL
FIA
INTEL
HELIOS
MISSION
UI
NETWORK
PERFORMANCE
```

---

<a id="src-sqf-master-technical-architecture--77-niveles-de-log"></a>
### 77. Niveles de log

```text
TRACE
DEBUG
INFO
WARN
ERROR
FATAL
```

En producción normal:

* TRACE desactivado;
* DEBUG opcional;
* INFO reducido;
* WARN y ERROR activos.

---

<a id="src-sqf-master-technical-architecture--78-formato-de-log"></a>
### 78. Formato de log

```text
[IF][LOGISTICS][INFO][1420]
Convoy creado
convoyId=CONVOY_BLUE_014
origin=KATALAKI
destination=NEOCHORI
```

---

<a id="src-sqf-master-technical-architecture--79-contexto-de-log"></a>
### 79. Contexto de log

Las funciones importantes deberán incluir:

* módulo;
* acción;
* IDs;
* transacción;
* misión;
* tiempo estratégico.

---

<a id="src-sqf-master-technical-architecture--80-registro-de-decisiones"></a>
### 80. Registro de decisiones

Separado del log técnico.

Contendrá:

* decisión;
* actor;
* contexto;
* opciones;
* resultado.

Se utiliza en:

* progresión;
* archivo de campaña;
* Argos;
* finales.

---

<a id="src-sqf-master-technical-architecture--81-diagnostics-mode"></a>
### 81. Diagnostics mode

Modos:

```text
OFF
BASIC
DEVELOPER
VERBOSE
```

<a id="src-sqf-master-technical-architecture--basic"></a>
#### BASIC

* errores;
* estado de bootstrap;
* FPS;
* tareas activas.

<a id="src-sqf-master-technical-architecture--developer"></a>
#### DEVELOPER

* sectores;
* fuerzas;
* rutas;
* proyecciones;
* eventos.

<a id="src-sqf-master-technical-architecture--verbose"></a>
#### VERBOSE

* payloads;
* transacciones;
* scheduler;
* red.

---

<a id="src-sqf-master-technical-architecture--82-herramientas-de-diagnóstico"></a>
### 82. Herramientas de diagnóstico

Se crearán paneles o comandos para:

* inspeccionar sector;
* inspeccionar formación;
* generar evento;
* avanzar tiempo;
* forzar convoy;
* guardar snapshot;
* validar estado;
* mostrar dependencias;
* mostrar entidades materializadas.

---

<a id="src-sqf-master-technical-architecture--83-comandos-de-desarrollo"></a>
### 83. Comandos de desarrollo

Ejemplos conceptuales:

```text
IF_DEBUG_VALIDATE_STATE
IF_DEBUG_SPAWN_TEST_FORCE
IF_DEBUG_FORCE_SECTOR_CAPTURE
IF_DEBUG_RUN_LOGISTICS_TICK
IF_DEBUG_EXPORT_SNAPSHOT
```

<a id="src-sqf-master-technical-architecture--regla-6"></a>
#### Regla

No estarán disponibles o tendrán protección en versión pública.

---

<a id="src-sqf-master-technical-architecture--84-configuración"></a>
### 84. Configuración

Todo catálogo deberá incluir:

```text
id
version
enabled
dependencies
fallback
validation
```

---

<a id="src-sqf-master-technical-architecture--85-catálogo-de-recursos"></a>
### 85. Catálogo de recursos

```sqf
IF_CFG_RESOURCE_FUEL = createHashMapFromArray [
    ["id", "FUEL"],
    ["displayNameKey", "STR_IF_RESOURCE_FUEL"],
    ["physical", true],
    ["transportClass", "LIQUID"],
    ["storageTags", ["FUEL_STORAGE"]],
    ["enabled", true]
];
```

---

<a id="src-sqf-master-technical-architecture--86-catálogo-de-unidades"></a>
### 86. Catálogo de unidades

No dispersar classnames por funciones.

```sqf
IF_CFG_UNIT_BLUE_RIFLEMAN = createHashMapFromArray [
    ["alias", "BLUE_RIFLEMAN"],
    ["baseClass", "CLASSNAME_VALIDATED_AT_RUNTIME"],
    ["role", "RIFLEMAN"],
    ["faction", "FAC_BLUE"],
    ["fallbackAlias", "BLUE_RIFLEMAN_FALLBACK"]
];
```

---

<a id="src-sqf-master-technical-architecture--87-validación-de-classnames"></a>
### 87. Validación de classnames

Al cargar configuración:

* comprobar existencia;
* registrar fallback;
* desactivar perfil opcional si falta;
* no romper campaña completa.

---

<a id="src-sqf-master-technical-architecture--88-configuración-vanilla-y-dlc"></a>
### 88. Configuración vanilla y DLC

Perfiles:

```text
BASE_VANILLA
OPTIONAL_DLC_1
OPTIONAL_DLC_2
MOD_PROFILE
```

<a id="src-sqf-master-technical-architecture--regla-7"></a>
#### Regla

La versión base debe funcionar sin mods.

---

<a id="src-sqf-master-technical-architecture--89-configuración-de-balance"></a>
### 89. Configuración de balance

```text
data/balance/
├── economy.hpp
├── logistics.hpp
├── combat.hpp
├── construction.hpp
├── progression.hpp
└── difficulty.hpp
```

Los valores deberán estar documentados.

---

<a id="src-sqf-master-technical-architecture--90-configuración-por-dificultad"></a>
### 90. Configuración por dificultad

La dificultad puede modificar:

* calidad de inteligencia;
* reacción;
* recursos iniciales;
* tolerancia;
* ventanas.

No debe modificar arbitrariamente estructuras fundamentales.

---

<a id="src-sqf-master-technical-architecture--91-persistencia"></a>
### 91. Persistencia

El sistema guardará consecuencias, no el mundo físico completo.

<a id="src-sqf-master-technical-architecture--guarda"></a>
#### Guarda

* estado de campaña;
* fuerzas;
* vehículos persistentes;
* sectores;
* recursos;
* relaciones;
* personajes;
* misiones;
* evidencias;
* decisiones;
* proyecciones activas necesarias.

<a id="src-sqf-master-technical-architecture--no-guarda-normalmente"></a>
#### No guarda normalmente

* cada proyectil;
* cada cadáver ambiental;
* cada waypoint temporal;
* cada objeto decorativo.

---

<a id="src-sqf-master-technical-architecture--92-adaptadores-de-almacenamiento"></a>
### 92. Adaptadores de almacenamiento

Interfaz conceptual:

```text
IF_fnc_storageSave
IF_fnc_storageLoad
IF_fnc_storageList
IF_fnc_storageDelete
```

Implementaciones:

```text
STORAGE_PROFILE_NAMESPACE
STORAGE_SERVER_EXTENSION_FUTURE
STORAGE_TEST_MEMORY
```

---

<a id="src-sqf-master-technical-architecture--93-sp-inicial"></a>
### 93. SP inicial

Usará:

```text
missionProfileNamespace
```

mediante un adaptador.

Clave maestra:

```text
IF_MAIN_CAMPAIGN
```

<a id="src-sqf-master-technical-architecture--regla-8"></a>
#### Regla

Los módulos no llamarán directamente al namespace de perfil.

---

<a id="src-sqf-master-technical-architecture--94-estructura-de-guardado"></a>
### 94. Estructura de guardado

```sqf
IF_saveEnvelope = createHashMapFromArray [
    ["schemaVersion", 1],
    ["gameVersion", "1.0.0"],
    ["campaignId", "IF_MAIN_CAMPAIGN"],
    ["campaignSide", "BLUE"],
    ["createdAt", systemTime],
    ["strategicTime", 1420],
    ["checksum", ""],
    ["payload", IF_campaignState]
];
```

---

<a id="src-sqf-master-technical-architecture--95-snapshots-ab"></a>
### 95. Snapshots A/B

Se mantendrán:

```text
SNAPSHOT_A
SNAPSHOT_B
```

<a id="src-sqf-master-technical-architecture--flujo"></a>
#### Flujo

1. Guardar en slot inactivo.
2. Validar.
3. Marcar como activo.
4. Conservar anterior.

<a id="src-sqf-master-technical-architecture--objetivo"></a>
#### Objetivo

Reducir riesgo de corrupción.

---

<a id="src-sqf-master-technical-architecture--96-autosave"></a>
### 96. Autosave

Se ejecutará:

* después de misión principal;
* después de punto de no retorno;
* después de cambio estructural;
* por intervalo seguro;
* antes de migración.

<a id="src-sqf-master-technical-architecture--no-durante"></a>
#### No durante

* transacción abierta;
* materialización incompleta;
* cambio de propietario no confirmado.

---

<a id="src-sqf-master-technical-architecture--97-checkpoints-tácticos"></a>
### 97. Checkpoints tácticos

Un checkpoint de misión deberá incluir:

* estado previo;
* reservas;
* proyecciones;
* objetivos;
* personajes;
* activos.

Al reiniciar:

* revertir la instancia completa;
* no conservar bajas del intento descartado.

---

<a id="src-sqf-master-technical-architecture--98-migraciones"></a>
### 98. Migraciones

Cada save tendrá:

```text
schemaVersion
```

Ejemplo:

```text
1 → 2 → 3
```

No se migrará directamente de 1 a 3 sin pasar por funciones controladas, salvo migración explícita equivalente.

---

<a id="src-sqf-master-technical-architecture--99-funciones-de-migración"></a>
### 99. Funciones de migración

```text
IF_fnc_migrateV1ToV2
IF_fnc_migrateV2ToV3
IF_fnc_saveMigrate
```

Cada migración:

* valida entrada;
* transforma copia;
* registra cambios;
* valida salida;
* preserva backup.

---

<a id="src-sqf-master-technical-architecture--100-cambios-incompatibles"></a>
### 100. Cambios incompatibles

Si una partida no puede migrarse:

* informar;
* conservar archivo;
* no sobrescribir;
* ofrecer versión compatible o inicio nuevo.

---

<a id="src-sqf-master-technical-architecture--101-validación-de-estado"></a>
### 101. Validación de estado

Se ejecutará:

* al cargar;
* antes de guardar;
* después de migrar;
* después de operaciones críticas;
* manualmente en diagnóstico.

---

<a id="src-sqf-master-technical-architecture--102-invariantes-globales"></a>
### 102. Invariantes globales

Ejemplos:

1. Cada sector tiene propietario válido.
2. Cada formación pertenece a una facción.
3. Cada vehículo persistente tiene un único estado.
4. Ningún recurso está duplicado.
5. Ningún personaje está vivo y muerto simultáneamente.
6. Ninguna misión activa carece de plantilla.
7. Ninguna proyección pertenece a formación inexistente.
8. Ninguna relación referencia personaje ausente.
9. Ningún convoy está llegado y en ruta.
10. Ningún módulo operativo pertenece a sector destruido sin representación válida.

---

<a id="src-sqf-master-technical-architecture--103-índices-derivados"></a>
### 103. Índices derivados

Al cargar se reconstruirán:

* sectores por propietario;
* fuerzas por sector;
* personajes por facción;
* misiones por estado;
* convoyes por ruta;
* nodos por sector.

<a id="src-sqf-master-technical-architecture--regla-9"></a>
#### Regla

No guardar todos los índices si pueden reconstruirse de forma segura.

---

<a id="src-sqf-master-technical-architecture--104-estado-autoritativo"></a>
### 104. Estado autoritativo

En SP:

```text
servidor local
```

continúa siendo autoridad lógica.

En MP futuro:

```text
servidor dedicado
```

será autoridad.

Los clientes solicitan.

El servidor valida y aplica.

---

<a id="src-sqf-master-technical-architecture--105-solicitud-de-cliente"></a>
### 105. Solicitud de cliente

Ejemplo:

```text
Cliente:
quiero asignar prioridad DEFENSA a Neochori.

Servidor:
verifica jugador.
verifica autoridad.
verifica sector.
aplica command.
publica actualización.
```

---

<a id="src-sqf-master-technical-architecture--106-prohibición-de-mutaciones-del-cliente"></a>
### 106. Prohibición de mutaciones del cliente

Un cliente nunca enviará:

```text
set sector owner to BLUE
add 100 fuel
complete mission
```

Enviará intención:

```text
REQUEST_SET_SECTOR_PRIORITY
REQUEST_ACCEPT_MISSION
REQUEST_USE_SUPPORT
```

---

<a id="src-sqf-master-technical-architecture--107-remoteexec"></a>
### 107. `remoteExec`

Se utilizará lista blanca en `CfgRemoteExec`.

Permitidos únicamente:

* requests definidos;
* respuestas de UI;
* efectos visuales autorizados;
* sincronizaciones controladas.

<a id="src-sqf-master-technical-architecture--prohibido"></a>
#### Prohibido

Permitir ejecución arbitraria de funciones.

---

<a id="src-sqf-master-technical-architecture--108-payloads-de-red"></a>
### 108. Payloads de red

Cada request tendrá:

```text
requestId
playerId
action
parameters
clientTime
```

El servidor añadirá:

* validación;
* resultado;
* error;
* serverTime.

---

<a id="src-sqf-master-technical-architecture--109-validación-del-solicitante"></a>
### 109. Validación del solicitante

Comprobar:

* jugador conectado;
* identidad;
* bando;
* rol;
* autoridad;
* estado;
* frecuencia;
* parámetros.

---

<a id="src-sqf-master-technical-architecture--110-protección-contra-spam"></a>
### 110. Protección contra spam

Requests tendrán:

* cooldown;
* deduplicación;
* request ID;
* rate limit.

---

<a id="src-sqf-master-technical-architecture--111-sincronización"></a>
### 111. Sincronización

No se transmitirá todo `IF_campaignState` continuamente.

Se enviarán:

* snapshots autorizados;
* cambios relevantes;
* view models;
* estados necesarios.

---

<a id="src-sqf-master-technical-architecture--112-datos-privados"></a>
### 112. Datos privados

Algunos datos permanecen solo en servidor:

* realidad enemiga;
* precisión verdadera;
* infiltrados no descubiertos;
* acceso Argos;
* consecuencias ocultas;
* semillas de resolución.

---

<a id="src-sqf-master-technical-architecture--113-datos-visibles-por-bando"></a>
### 113. Datos visibles por bando

El servidor construye:

```text
knownWorldState
```

o view models filtrados.

<a id="src-sqf-master-technical-architecture--regla-10"></a>
#### Regla

No enviar al cliente la realidad secreta y ocultarla solamente visualmente.

---

<a id="src-sqf-master-technical-architecture--114-jip-futuro"></a>
### 114. JIP futuro

Un jugador que entra tarde recibirá:

* estado de campaña autorizado;
* misión;
* unidad;
* relaciones compartidas;
* entidades activas;
* UI.

No recibirá:

* eventos ya irrelevantes;
* realidad oculta;
* referencias rotas.

---

<a id="src-sqf-master-technical-architecture--115-seguridad-de-acciones-irreversibles"></a>
### 115. Seguridad de acciones irreversibles

Acciones como:

* destruir Helios;
* ejecutar prisionero;
* abandonar Stratis;
* romper alianza;

deberán:

* validar autoridad;
* registrar actor;
* pedir confirmación;
* ejecutar transacción;
* crear autosave.

---

<a id="src-sqf-master-technical-architecture--116-publicvariable-y-sincronización-directa"></a>
### 116. `publicVariable` y sincronización directa

No se utilizará como mecanismo general para estructuras grandes sin control.

Se preferirá:

* requests;
* respuestas;
* actualizaciones específicas;
* eventos de red.

---

<a id="src-sqf-master-technical-architecture--117-integración-con-3den"></a>
### 117. Integración con 3DEN

3DEN contendrá:

* terreno;
* anclajes;
* ubicaciones;
* capas;
* entidades iniciales;
* objetos narrativos;
* triggers mínimos.

La lógica estratégica permanecerá en código.

---

<a id="src-sqf-master-technical-architecture--118-objetos-colocados-manualmente"></a>
### 118. Objetos colocados manualmente

Cada objeto persistente relevante en 3DEN deberá tener:

* ID;
* tipo;
* sector;
* capa;
* función;
* regla de registro.

---

<a id="src-sqf-master-technical-architecture--119-convención-de-nombres-3den"></a>
### 119. Convención de nombres 3DEN

Ejemplos:

```text
IF_ANCHOR_ALT_CW_NEOCHORI_COMMAND
IF_OBJECT_HELIOS_AIRPORT_TERMINAL
IF_SPAWN_BLUE_KATALAKI_01
IF_ZONE_NEOCHORI_CIVIL
```

---

<a id="src-sqf-master-technical-architecture--120-capas-3den"></a>
### 120. Capas 3DEN

```text
IF_WORLD
IF_ANCHORS
IF_SECTORS
IF_COMPOSITIONS
IF_CHARACTERS
IF_INITIAL_FORCES
IF_HELIOS
IF_CIVILIANS
IF_TESTING
```

<a id="src-sqf-master-technical-architecture--regla-11"></a>
#### Regla

No mezclar objetos de producción con objetos temporales de pruebas.

---

<a id="src-sqf-master-technical-architecture--121-registro-de-objetos-3den"></a>
### 121. Registro de objetos 3DEN

Durante bootstrap:

1. Buscar objetos con variables o atributos definidos.
2. Validar ID.
3. Asociar sector.
4. Registrar referencia.
5. Aplicar estado guardado.
6. Informar duplicaciones.

---

<a id="src-sqf-master-technical-architecture--122-triggers-3den"></a>
### 122. Triggers 3DEN

Se limitarán a:

* zonas espaciales;
* activación visual;
* escenas concretas;
* pruebas.

No deberán contener toda la lógica de campaña.

---

<a id="src-sqf-master-technical-architecture--123-composiciones"></a>
### 123. Composiciones

Las composiciones se gestionarán mediante catálogo.

Cada composición define:

* objetos;
* posiciones relativas;
* anclajes;
* orientación;
* variantes;
* estado de daño;
* presupuesto.

---

<a id="src-sqf-master-technical-architecture--124-materialización-de-composiciones"></a>
### 124. Materialización de composiciones

Flujo:

1. Seleccionar composición.
2. Validar clase.
3. Validar terreno.
4. Reservar módulo.
5. Crear objetos.
6. Registrar.
7. aplicar daño.
8. Confirmar.

---

<a id="src-sqf-master-technical-architecture--125-desmaterialización-de-composiciones"></a>
### 125. Desmaterialización de composiciones

Guardar:

* módulo;
* estado;
* daño;
* armas;
* capacidad.

No guardar necesariamente cada elemento decorativo.

---

<a id="src-sqf-master-technical-architecture--126-integración-con-módulos-oficiales"></a>
### 126. Integración con módulos oficiales

Los módulos oficiales de Arma 3 podrán utilizarse cuando:

* aporten una capacidad estable;
* no dupliquen el sistema estratégico;
* puedan envolverse mediante un adaptador.

<a id="src-sqf-master-technical-architecture--no-serán"></a>
#### No serán

La fuente autoritativa de:

* economía;
* sectores;
* progreso;
* IA estratégica.

---

<a id="src-sqf-master-technical-architecture--127-interfaz-mediante-view-models"></a>
### 127. Interfaz mediante view models

La UI recibirá estructuras preparadas.

Ejemplo:

```sqf
private _viewModel = [
    "ALT_CW_NEOCHORI",
    _playerContext
] call IF_fnc_uiBuildSectorViewModel;
```

La UI no debe navegar internamente por todo el estado.

---

<a id="src-sqf-master-technical-architecture--128-suscripciones-de-interfaz"></a>
### 128. Suscripciones de interfaz

La UI puede suscribirse a:

```text
SECTOR_CHANGED
MISSION_CHANGED
ALERT_CREATED
RELATION_CHANGED
```

Después solicita view model actualizado.

---

<a id="src-sqf-master-technical-architecture--129-caché-de-ui"></a>
### 129. Caché de UI

Los view models pueden almacenarse temporalmente.

Se invalidan por:

* evento;
* cambio de autoridad;
* nueva inteligencia;
* paso de tiempo relevante.

---

<a id="src-sqf-master-technical-architecture--130-stringtable"></a>
### 130. Stringtable

Todo texto visible reutilizable deberá utilizar claves.

Ejemplo:

```xml
<Key ID="STR_IF_RESOURCE_FUEL">
    <Original>Fuel</Original>
    <Spanish>Combustible</Spanish>
</Key>
```

<a id="src-sqf-master-technical-architecture--regla-12"></a>
#### Regla

No dispersar textos visibles largos dentro de funciones.

---

<a id="src-sqf-master-technical-architecture--131-localización"></a>
### 131. Localización

La base se redactará en español.

La arquitectura permitirá:

* inglés;
* otros idiomas;
* subtítulos;
* textos variables.

---

<a id="src-sqf-master-technical-architecture--132-diálogos-narrativos"></a>
### 132. Diálogos narrativos

Los diálogos tendrán archivos de datos separados.

```text
campaign/blue/act01/dialogue/
```

La lógica de misión solicitará una conversación por ID.

---

<a id="src-sqf-master-technical-architecture--133-sistema-de-condiciones"></a>
### 133. Sistema de condiciones

Las condiciones narrativas no deberán dispersarse como bloques complejos repetidos.

Se usarán funciones:

```text
IF_fnc_conditionEvaluate
IF_fnc_conditionEvaluateSet
```

---

<a id="src-sqf-master-technical-architecture--134-formato-de-condición"></a>
### 134. Formato de condición

```sqf
createHashMapFromArray [
    ["type", "RELATION_MINIMUM"],
    ["subjectId", "CHAR_BLUE_WARD"],
    ["field", "judgmentTrust"],
    ["value", 60]
]
```

---

<a id="src-sqf-master-technical-architecture--135-conjuntos-de-condiciones"></a>
### 135. Conjuntos de condiciones

Operadores:

```text
ALL
ANY
NONE
AT_LEAST
```

<a id="src-sqf-master-technical-architecture--ventaja"></a>
#### Ventaja

Permite:

* probar;
* documentar;
* explicar;
* reutilizar.

---

<a id="src-sqf-master-technical-architecture--136-sistema-de-efectos"></a>
### 136. Sistema de efectos

Las misiones y decisiones no modificarán módulos directamente mediante decenas de líneas.

Utilizarán efectos declarativos.

Ejemplo:

```sqf
[
    ["SECTOR_SET_CONTROL", ["ALT_CW_NEOCHORI", "FAC_BLUE"]],
    ["RELATION_CHANGE", ["CHAR_BLUE_WARD", "judgmentTrust", 5]],
    ["RESOURCE_TRANSFER", ["KATALAKI", "NEOCHORI", "FUEL", 12]]
] call IF_fnc_effectApplySet;
```

---

<a id="src-sqf-master-technical-architecture--137-validación-de-efectos"></a>
### 137. Validación de efectos

Cada tipo de efecto pertenece a un módulo.

El dispatcher:

* identifica propietario;
* llama command;
* recoge resultado;
* revierte si es transacción.

---

<a id="src-sqf-master-technical-architecture--138-misiones-declarativas"></a>
### 138. Misiones declarativas

Una plantilla de misión puede definir:

* condiciones;
* objetivos;
* transformaciones;
* efectos.

La lógica personalizada se reserva para comportamientos únicos.

---

<a id="src-sqf-master-technical-architecture--139-objetivos"></a>
### 139. Objetivos

Cada objetivo tendrá:

```text
objectiveId
type
state
conditions
failureConditions
optional
visible
```

Estados:

```text
INACTIVE
ACTIVE
SUCCEEDED
FAILED
CANCELLED
HIDDEN
```

---

<a id="src-sqf-master-technical-architecture--140-avance-de-actos"></a>
### 140. Avance de actos

El módulo Campaign evalúa gates.

No se debe avanzar un acto directamente desde un trigger o UI.

Command:

```text
IF_fnc_campaignCommandAdvanceAct
```

valida:

* misión;
* territorio;
* decisiones;
* punto de no retorno;
* snapshot.

---

<a id="src-sqf-master-technical-architecture--141-personajes"></a>
### 141. Personajes

Cada personaje tendrá definición en configuración y estado en campaña.

<a id="src-sqf-master-technical-architecture--configuración"></a>
#### Configuración

* identidad;
* facción;
* rol;
* voz;
* relaciones iniciales.

<a id="src-sqf-master-technical-architecture--estado"></a>
#### Estado

* vivo;
* herido;
* ubicación;
* confianza;
* conocimiento;
* inventario narrativo.

---

<a id="src-sqf-master-technical-architecture--142-conocimiento-de-personajes"></a>
### 142. Conocimiento de personajes

No se representará únicamente por diálogo.

Cada personaje puede conocer:

* eventos;
* evidencias;
* conclusiones;
* secretos.

Esto condiciona:

* decisiones;
* diálogos;
* filtraciones.

---

<a id="src-sqf-master-technical-architecture--143-ia-estratégica"></a>
### 143. IA estratégica

El módulo Strategic AI consulta:

* estado percibido;
* doctrina;
* recursos;
* planes.

No consulta directamente:

* información secreta enemiga;
* variables ocultas sin fuente.

---

<a id="src-sqf-master-technical-architecture--144-comandantes"></a>
### 144. Comandantes

Cada comandante tendrá:

```text
profile
doctrine
beliefs
priorities
riskTolerance
authority
relationships
```

La IA estratégica genera planes.

No controla unidades tácticas directamente.

---

<a id="src-sqf-master-technical-architecture--145-adaptador-táctico"></a>
### 145. Adaptador táctico

Convierte plan estratégico en:

* reservas;
* proyección;
* paquete táctico;
* órdenes.

Después devuelve resultados normalizados.

---

<a id="src-sqf-master-technical-architecture--146-event-handlers-del-motor"></a>
### 146. Event Handlers del motor

Los handlers del motor deben:

* capturar evento;
* normalizar;
* publicarlo.

Ejemplo:

```sqf
_unit addEventHandler [
    "Killed",
    {
        params ["_unit", "_killer"];
        [_unit, _killer] call IF_fnc_tacticalHandleKilled;
    }
];
```

No deben contener directamente:

* cambios de acto;
* transferencias complejas;
* guardados.

---

<a id="src-sqf-master-technical-architecture--147-limpieza-de-event-handlers"></a>
### 147. Limpieza de Event Handlers

Al desmaterializar:

* eliminar handlers propios;
* limpiar referencias;
* marcar entidad;
* evitar eventos tardíos duplicados.

---

<a id="src-sqf-master-technical-architecture--148-scripts-programados-y-no-programados"></a>
### 148. Scripts programados y no programados

Las funciones documentarán si pueden ejecutarse:

```text
SCHEDULED
UNSCHEDULED
BOTH
```

<a id="src-sqf-master-technical-architecture--regla-13"></a>
#### Regla

No usar `sleep` dentro de funciones que puedan ejecutarse en contexto no programado.

---

<a id="src-sqf-master-technical-architecture--149-funciones-largas"></a>
### 149. Funciones largas

Una función no deberá:

* validar;
* modificar cinco módulos;
* crear UI;
* guardar;
* reproducir audio;

todo en un único archivo.

Se dividirá por responsabilidad.

---

<a id="src-sqf-master-technical-architecture--150-límites-orientativos-de-funciones"></a>
### 150. Límites orientativos de funciones

No es una regla absoluta, pero una función muy extensa debe revisarse.

Indicadores de problema:

* más de una responsabilidad;
* demasiados niveles de anidación;
* múltiples módulos modificados;
* difícil de probar;
* parámetros ambiguos.

---

<a id="src-sqf-master-technical-architecture--151-cabecera-obligatoria"></a>
### 151. Cabecera obligatoria

Cada función deberá documentar:

```sqf
/*
    File:
        fn_logisticsCreateConvoy.sqf

    Purpose:
        Creates and commits a strategic convoy.

    Layer:
        Application / Logistics

    Locality:
        Server only.

    Scheduled:
        Yes.

    Parameters:
        0: HASHMAP - Convoy request.

    Returns:
        ARRAY [success, data, errorCode]

    Side effects:
        Reserves stock, vehicles and escort.
        Publishes IF_EVENT_CONVOY_CREATED.

    Dependencies:
        Logistics, Forces, Transactions, Events.

    Persistence:
        Modifies campaign state.
*/
```

---

<a id="src-sqf-master-technical-architecture--152-validación-de-parámetros"></a>
### 152. Validación de parámetros

Utilizar:

* `params`;
* tipos;
* defaults;
* validación semántica.

<a id="src-sqf-master-technical-architecture--no-confiar"></a>
#### No confiar

En que una variable existe porque la función normalmente se llama correctamente.

---

<a id="src-sqf-master-technical-architecture--153-hashmaps-y-arrays"></a>
### 153. HashMaps y arrays

<a id="src-sqf-master-technical-architecture--hashmap"></a>
#### HashMap

Para entidades con campos nombrados.

<a id="src-sqf-master-technical-architecture--array"></a>
#### Array

Para:

* listas;
* resultados estándar;
* vectores;
* estructuras de motor conocidas.

<a id="src-sqf-master-technical-architecture--regla-14"></a>
#### Regla

Evitar arrays grandes donde el significado dependa de recordar posiciones.

---

<a id="src-sqf-master-technical-architecture--154-mutación-controlada-de-hashmaps"></a>
### 154. Mutación controlada de HashMaps

Si una función recibe un HashMap perteneciente al estado:

* debe saber si puede modificarlo;
* documentarlo;
* preferir obtenerlo por ID;
* registrar cambios.

Para queries, devolver copia o view model cuando sea necesario.

---

<a id="src-sqf-master-technical-architecture--155-copias-y-referencias"></a>
### 155. Copias y referencias

Debe tenerse cuidado con:

* arrays;
* HashMaps;
* referencias compartidas.

Las funciones de lectura no deben modificar accidentalmente el estado.

---

<a id="src-sqf-master-technical-architecture--156-orden-determinista"></a>
### 156. Orden determinista

Para resoluciones persistentes:

* usar semillas guardadas;
* ordenar listas antes de seleccionar;
* evitar depender de orden arbitrario de HashMap.

---

<a id="src-sqf-master-technical-architecture--157-aleatoriedad"></a>
### 157. Aleatoriedad

Servicio:

```text
IF_fnc_randomCreateSeed
IF_fnc_randomRange
IF_fnc_randomSelectWeighted
```

<a id="src-sqf-master-technical-architecture--regla-15"></a>
#### Regla

Las decisiones críticas deben poder reproducirse durante depuración.

---

<a id="src-sqf-master-technical-architecture--158-configuración-de-semillas"></a>
### 158. Configuración de semillas

Semillas separadas por:

* campaña;
* misión;
* batalla;
* evento;
* composición.

---

<a id="src-sqf-master-technical-architecture--159-rendimiento"></a>
### 159. Rendimiento

Principios:

1. No recorrer todas las entidades en cada frame.
2. Priorizar eventos.
3. Utilizar índices.
4. Procesar por lotes.
5. Reducir objetos físicos.
6. Evitar `allUnits` como consulta constante.
7. Evitar búsquedas globales repetidas.
8. Cachear configuraciones.
9. Medir antes de optimizar.
10. Registrar funciones lentas.

---

<a id="src-sqf-master-technical-architecture--160-métricas"></a>
### 160. Métricas

Se medirán:

* tiempo por módulo;
* tareas ejecutadas;
* eventos pendientes;
* entidades físicas;
* grupos;
* view models;
* tamaño del save;
* tiempo de guardado;
* tiempo de carga.

---

<a id="src-sqf-master-technical-architecture--161-perfilador-interno"></a>
### 161. Perfilador interno

Funciones conceptuales:

```text
IF_fnc_perfStart
IF_fnc_perfEnd
IF_fnc_perfRecord
IF_fnc_perfReport
```

---

<a id="src-sqf-master-technical-architecture--162-umbrales-de-advertencia"></a>
### 162. Umbrales de advertencia

Ejemplo:

```text
Función estratégica > 10 ms:
warning.

Guardado > 3 s:
warning.

Cola de eventos > 500:
warning.

Proyecciones activas > presupuesto:
warning.
```

Los valores se ajustarán en pruebas.

---

<a id="src-sqf-master-technical-architecture--163-memoria"></a>
### 163. Memoria

Evitar:

* historial ilimitado;
* eventos duplicados;
* logs persistentes excesivos;
* objetos huérfanos;
* arrays crecientes sin limpieza.

---

<a id="src-sqf-master-technical-architecture--164-compactación-de-historial"></a>
### 164. Compactación de historial

Los eventos antiguos pueden agregarse.

Ejemplo:

En lugar de guardar cada consumo horario durante 100 días:

* conservar totales;
* conservar eventos relevantes;
* eliminar detalles temporales.

---

<a id="src-sqf-master-technical-architecture--165-versionado-del-proyecto"></a>
### 165. Versionado del proyecto

Versión semántica:

```text
MAJOR.MINOR.PATCH
```

<a id="src-sqf-master-technical-architecture--major"></a>
#### MAJOR

Cambio incompatible de campaña.

<a id="src-sqf-master-technical-architecture--minor"></a>
#### MINOR

Nuevo sistema o contenido compatible mediante migración.

<a id="src-sqf-master-technical-architecture--patch"></a>
#### PATCH

Corrección.

---

<a id="src-sqf-master-technical-architecture--166-versión-de-schema-separada"></a>
### 166. Versión de schema separada

```text
gameVersion = 1.3.0
schemaVersion = 4
```

No tienen que coincidir.

---

<a id="src-sqf-master-technical-architecture--167-changelog"></a>
### 167. Changelog

Cada versión documentará:

* cambios;
* migraciones;
* saves compatibles;
* módulos afectados;
* pruebas.

---

<a id="src-sqf-master-technical-architecture--168-documentación-de-módulo"></a>
### 168. Documentación de módulo

Cada `README.md` incluirá:

```text
Propósito
Estado propietario
API pública
Eventos
Dependencias
Configuración
Persistencia
Pruebas
Diagnósticos
Limitaciones
```

---

<a id="src-sqf-master-technical-architecture--169-registro-de-decisiones-arquitectónicas"></a>
### 169. Registro de decisiones arquitectónicas

Carpeta:

```text
docs/adr/
```

Ejemplos:

```text
ADR-001-server-authoritative-from-sp.md
ADR-002-event-bus.md
ADR-003-strategic-virtualization.md
ADR-004-save-adapter.md
```

---

<a id="src-sqf-master-technical-architecture--170-adr"></a>
### 170. ADR

Cada decisión importante registrará:

* contexto;
* opciones;
* decisión;
* consecuencias;
* estado.

<a id="src-sqf-master-technical-architecture--objetivo-1"></a>
#### Objetivo

Evitar que futuros cambios contradigan principios sin comprender por qué existían.

---

<a id="src-sqf-master-technical-architecture--171-pruebas-unitarias-conceptuales"></a>
### 171. Pruebas unitarias conceptuales

SQF no ofrece el mismo entorno que lenguajes tradicionales, pero se crearán:

* funciones puras;
* escenarios de prueba;
* assertions;
* test runner propio.

---

<a id="src-sqf-master-technical-architecture--172-assertion"></a>
### 172. Assertion

```sqf
[
    _actual isEqualTo _expected,
    "Logistics stock should decrease once."
] call IF_fnc_testAssert;
```

---

<a id="src-sqf-master-technical-architecture--173-test-runner"></a>
### 173. Test runner

```text
IF_fnc_testRunSuite
IF_fnc_testAssert
IF_fnc_testReport
```

Resultados:

```text
PASSED
FAILED
SKIPPED
```

---

<a id="src-sqf-master-technical-architecture--174-pruebas-por-capa"></a>
### 174. Pruebas por capa

<a id="src-sqf-master-technical-architecture--domain"></a>
#### Domain

Sin objetos físicos siempre que sea posible.

<a id="src-sqf-master-technical-architecture--simulation"></a>
#### Simulation

Con escenario de prueba.

<a id="src-sqf-master-technical-architecture--ui"></a>
#### UI

Con view models falsos.

<a id="src-sqf-master-technical-architecture--persistence"></a>
#### Persistence

Con snapshots controlados.

<a id="src-sqf-master-technical-architecture--network"></a>
#### Network

Con solicitudes válidas e inválidas.

---

<a id="src-sqf-master-technical-architecture--175-mocks-y-fakes"></a>
### 175. Mocks y fakes

Se crearán adaptadores falsos para:

* almacenamiento;
* tiempo;
* red;
* entidades;
* aleatoriedad.

<a id="src-sqf-master-technical-architecture--ventaja-1"></a>
#### Ventaja

Probar:

* logística;
* misiones;
* migraciones;

sin ejecutar toda la campaña.

---

<a id="src-sqf-master-technical-architecture--176-fixtures"></a>
### 176. Fixtures

Datos de prueba:

```text
tests/fixtures/
├── campaign_minimal.sqf
├── campaign_act1_blue.sqf
├── sector_neochori.sqf
├── force_blue_company.sqf
└── logistics_convoy.sqf
```

---

<a id="src-sqf-master-technical-architecture--177-pruebas-de-integración"></a>
### 177. Pruebas de integración

Ejemplos:

* captura de sector;
* convoy completo;
* misión dinámica;
* evidencia entregada;
* construcción;
* guardado y carga;
* batalla materializada.

---

<a id="src-sqf-master-technical-architecture--178-pruebas-de-regresión"></a>
### 178. Pruebas de regresión

Cada error grave debe generar una prueba.

Ejemplos:

* convoy descargado dos veces;
* personaje resucitado al cargar;
* vehículo duplicado;
* misión expirada reaparece;
* recurso negativo.

---

<a id="src-sqf-master-technical-architecture--179-validación-manual-en-3den"></a>
### 179. Validación manual en 3DEN

Cada módulo físico tendrá escenario de prueba:

```text
TEST_COMPOSITIONS
TEST_CONVOYS
TEST_GARRISON
TEST_VIRTUALIZATION
TEST_UI
```

---

<a id="src-sqf-master-technical-architecture--180-modo-sandbox"></a>
### 180. Modo sandbox

Permitirá:

* crear fuerzas;
* cambiar sector;
* generar convoy;
* dañar nodo;
* avanzar tiempo;
* probar UI.

No forma parte de campaña pública.

---

<a id="src-sqf-master-technical-architecture--181-integración-continua-local"></a>
### 181. Integración continua local

Antes de integrar cambios:

1. Validación sintáctica.
2. Tests de dominio.
3. Tests de estado.
4. Carga de escenario.
5. Revisión RPT.
6. Guardado/carga.
7. Rendimiento básico.

---

<a id="src-sqf-master-technical-architecture--182-criterio-de-módulo-terminado"></a>
### 182. Criterio de módulo terminado

Un módulo no está terminado solo porque funciona una vez.

Debe tener:

* documentación;
* configuración;
* API pública;
* validación;
* logs;
* persistencia;
* pruebas;
* diagnóstico;
* integración.

---

<a id="src-sqf-master-technical-architecture--183-orden-de-implementación-técnica"></a>
### 183. Orden de implementación técnica

<a id="src-sqf-master-technical-architecture--base-1"></a>
#### Base 1

* core;
* bootstrap;
* config;
* logging;
* errores;
* IDs.

<a id="src-sqf-master-technical-architecture--base-2"></a>
#### Base 2

* estado;
* eventos;
* scheduler;
* persistencia;
* migraciones.

<a id="src-sqf-master-technical-architecture--mundo"></a>
#### Mundo

* sectores;
* conexiones;
* facciones;
* personajes.

<a id="src-sqf-master-technical-architecture--guerra"></a>
#### Guerra

* fuerzas;
* logística;
* construcción;
* táctico.

<a id="src-sqf-master-technical-architecture--campaña"></a>
#### Campaña

* misiones;
* progresión;
* inteligencia;
* civiles.

<a id="src-sqf-master-technical-architecture--avanzado"></a>
#### Avanzado

* Helios;
* FIA;
* política;
* finales.

---

<a id="src-sqf-master-technical-architecture--184-vertical-slice-técnico"></a>
### 184. Vertical slice técnico

Debe implementar únicamente lo necesario para Acto I Azul:

```text
Core
State
Save
Events
Scheduler
Sectors
Forces
Logistics
Construction
Tactical projection
Missions
Basic civilians
Basic intelligence
Basic progression
Basic UI
```

<a id="src-sqf-master-technical-architecture--exclusiones-iniciales"></a>
#### Exclusiones iniciales

* Argos completo;
* Stratis;
* campaña Roja;
* gobierno nacional complejo;
* cooperativo;
* Headless Client.

---

<a id="src-sqf-master-technical-architecture--185-contrato-del-vertical-slice"></a>
### 185. Contrato del vertical slice

Debe demostrar:

1. Crear nueva campaña.
2. Cargar configuración.
3. Registrar nueve sectores.
4. Crear fuerzas iniciales.
5. Materializar desembarco.
6. Capturar Katalaki.
7. Guardar.
8. Cargar.
9. Crear convoy.
10. Perder o entregar carga.
11. Actualizar Neochori.
12. Ejecutar contraataque.
13. Reintegrar fuerzas.
14. Registrar evidencia.
15. actualizar relación.
16. avanzar Acto I.
17. mostrar UI.
18. producir RPT limpio.

---

<a id="src-sqf-master-technical-architecture--186-proceso-para-añadir-un-nuevo-sistema"></a>
### 186. Proceso para añadir un nuevo sistema

1. Definir propósito.
2. Definir estado propietario.
3. Definir commands.
4. Definir queries.
5. Definir eventos.
6. Definir dependencias.
7. Crear configuración.
8. Crear validadores.
9. Crear serialización.
10. Crear tests.
11. Integrar scheduler.
12. Integrar UI.
13. Documentar.

---

<a id="src-sqf-master-technical-architecture--187-proceso-para-añadir-una-nueva-misión"></a>
### 187. Proceso para añadir una nueva misión

1. Definir necesidad.
2. Definir plantilla.
3. Definir condiciones.
4. Definir objetivos.
5. Definir efectos.
6. Definir variantes.
7. Definir persistencia.
8. Definir materialización.
9. Definir UI.
10. Probar éxito, parcial, fracaso e ignorada.

---

<a id="src-sqf-master-technical-architecture--188-proceso-para-añadir-un-sector"></a>
### 188. Proceso para añadir un sector

1. Crear ID.
2. Definir configuración.
3. Definir conexiones.
4. Colocar anclajes 3DEN.
5. Validar terreno.
6. Definir población.
7. Definir producción.
8. Definir módulos posibles.
9. Probar captura.
10. Probar guardado.

---

<a id="src-sqf-master-technical-architecture--189-proceso-para-añadir-una-composición"></a>
### 189. Proceso para añadir una composición

1. Crear en 3DEN.
2. Nombrar capas.
3. Exportar.
4. Registrar catálogo.
5. Validar clases.
6. Probar terrenos.
7. Probar pathing.
8. Probar daño.
9. Probar captura.
10. Probar materialización.

---

<a id="src-sqf-master-technical-architecture--190-revisión-de-código"></a>
### 190. Revisión de código

Cada revisión debe comprobar:

* responsabilidad;
* dependencias;
* autoridad;
* persistencia;
* localidad;
* errores;
* rendimiento;
* documentación;
* pruebas.

---

<a id="src-sqf-master-technical-architecture--191-preguntas-obligatorias-de-revisión"></a>
### 191. Preguntas obligatorias de revisión

1. ¿Qué módulo posee este dato?
2. ¿Quién puede modificarlo?
3. ¿Se valida?
4. ¿Se guarda?
5. ¿Se migra?
6. ¿Se sincroniza?
7. ¿Puede duplicarse?
8. ¿Puede ejecutarse dos veces?
9. ¿Qué ocurre si falla?
10. ¿Cómo se prueba?

---

<a id="src-sqf-master-technical-architecture--192-deuda-técnica"></a>
### 192. Deuda técnica

Toda excepción temporal deberá registrarse.

Formato:

```text
TECH-DEBT-001
Contexto
Riesgo
Módulo
Fecha
Condición de resolución
```

<a id="src-sqf-master-technical-architecture--prohibición-1"></a>
#### Prohibición

No usar comentarios `TODO` indefinidos como único seguimiento.

---

<a id="src-sqf-master-technical-architecture--193-funciones-conceptuales-del-núcleo"></a>
### 193. Funciones conceptuales del núcleo

```text
IF_fnc_bootstrapStart
IF_fnc_bootstrapAdvancePhase
IF_fnc_configLoad
IF_fnc_configValidate
IF_fnc_stateCreate
IF_fnc_stateValidate
IF_fnc_eventPublish
IF_fnc_eventSubscribe
IF_fnc_eventProcessQueue
IF_fnc_schedulerRegister
IF_fnc_schedulerTick
IF_fnc_transactionBegin
IF_fnc_transactionCommit
IF_fnc_transactionRollback
IF_fnc_storageSave
IF_fnc_storageLoad
IF_fnc_saveCreateSnapshot
IF_fnc_saveValidate
IF_fnc_saveMigrate
IF_fnc_logWrite
IF_fnc_errorCreate
IF_fnc_idGenerateRuntime
IF_fnc_networkHandleRequest
IF_fnc_testRunSuite
```

---

<a id="src-sqf-master-technical-architecture--194-invariantes-de-arquitectura"></a>
### 194. Invariantes de arquitectura

1. La UI no modifica estado directamente.
2. Los módulos poseen su estado.
3. Los commands validan.
4. Las queries no mutan.
5. Los eventos son idempotentes cuando corresponde.
6. Los IDs persistentes son estables.
7. Los objetos físicos no son identidad.
8. El estado guardado no contiene referencias inválidas.
9. Las transacciones se cierran.
10. Las reservas se liberan.
11. Los saves tienen versión.
12. Las migraciones preservan backup.
13. Los clientes no son autoridad.
14. Los datos secretos no se envían.
15. Los schedulers tienen presupuesto.
16. Los errores se registran.
17. Las dependencias se documentan.
18. Los módulos pueden probarse.
19. Las configuraciones se validan.
20. Las decisiones importantes son auditables.

---

<a id="src-sqf-master-technical-architecture--195-errores-que-deben-evitarse"></a>
### 195. Errores que deben evitarse

1. Crear un archivo `functions.sqf` gigantesco.
2. Mezclar UI y dominio.
3. Modificar directamente HashMaps de otro módulo.
4. Utilizar objetos como identidad persistente.
5. Guardar referencias de grupo.
6. Crear bucles por cada entidad.
7. Ejecutar toda la simulación cada frame.
8. Utilizar variables globales dispersas.
9. Permitir `remoteExec` arbitrario.
10. Confiar en datos del cliente.
11. Enviar realidad secreta al cliente.
12. Crear eventos no idempotentes.
13. Guardar durante transacción abierta.
14. No versionar saves.
15. Cambiar schema sin migración.
16. Ignorar localidad.
17. Poner lógica estratégica en waypoints.
18. Poner lógica completa en triggers.
19. Dispersar classnames.
20. Ocultar errores con valores por defecto.
21. Usar `nil` para todos los fallos.
22. No registrar IDs duplicados.
23. Crear dependencias circulares.
24. Introducir Headless Client antes de estabilizar SP.
25. Implementar todos los sistemas antes del vertical slice.

---

<a id="src-sqf-master-technical-architecture--196-principios-obligatorios-finales"></a>
### 196. Principios obligatorios finales

1. El proyecto será modular.
2. El dominio estará separado del motor.
3. La campaña será autoritativa desde SP.
4. Cada módulo tendrá API pública.
5. El estado tendrá propietario.
6. Los cambios usarán commands.
7. Las consultas serán puras cuando sea posible.
8. Los eventos conectarán módulos.
9. Las transacciones protegerán operaciones complejas.
10. El scheduler sustituirá bucles dispersos.
11. La configuración estará fuera de la lógica.
12. Los IDs serán estables.
13. Los objetos físicos serán proyecciones.
14. La persistencia almacenará consecuencias.
15. Los saves tendrán snapshots.
16. Las migraciones serán obligatorias.
17. El logging será estructurado.
18. Los errores serán explicables.
19. La red utilizará solicitudes validadas.
20. `remoteExec` tendrá lista blanca.
21. La UI recibirá view models.
22. 3DEN definirá geometría, no toda la lógica.
23. Los módulos oficiales se usarán mediante adaptadores.
24. Cada función tendrá cabecera.
25. Cada módulo tendrá pruebas.
26. Cada error grave generará regresión.
27. El rendimiento será medido.
28. La documentación formará parte del desarrollo.
29. El vertical slice validará las decisiones.
30. Ninguna nueva funcionalidad deberá romper estos contratos sin un ADR explícito.

---

<a id="src-sqf-master-technical-architecture--197-definición-final"></a>
### 197. Definición final

La arquitectura técnica de Islas Fracturadas debe permitir que el proyecto crezca sin que cada nueva misión necesite conocer cómo funcionan todos los demás sistemas.

Una misión deberá poder solicitar un convoy sin modificar directamente combustible, camiones, rutas y escoltas.

Una captura deberá poder informar al sistema territorial sin que un trigger cambie por sí solo:

* propietario;
* Gobierno;
* logística;
* construcción;
* población;
* inteligencia.

Un soldado físico podrá morir sin que su muerte se registre dos veces.

Un vehículo podrá desaparecer del mundo físico y seguir existiendo como activo estratégico.

Una interfaz podrá mostrar una fuerza sin recibir la posición secreta real del enemigo.

Un guardado podrá sobrevivir cambios de versión porque su estructura, validación y migración estarán definidas.

> **La arquitectura no existe para añadir complejidad al código. Existe para impedir que la complejidad de la campaña se convierta en desorden.**

> **Cada módulo debe saber qué posee, qué puede pedir y qué está obligado a informar.**

> **Cuando la campaña crezca, el código no deberá depender de que una sola persona recuerde dónde se cambia cada dato. Los contratos, los eventos, los estados y la documentación deberán conservar ese conocimiento.**

> **Islas Fracturadas será una campaña grande porque sus sistemas estarán conectados. Será mantenible porque esas conexiones estarán controladas.**

<a id="src-sqf-master-technical-architecture--estado-actualizado"></a>
#### Estado actualizado

El [Documento 11/14](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide) establece qué debe colocarse manualmente en Altis, cómo crear capas, sectores, límites, anclajes, rutas, zonas civiles, puntos de materialización, nodos Helios y escenarios de prueba sin duplicar la lógica SQF.

El [Documento 12/14](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system) fija los contratos narrativos, metadatos de líneas, colas, interrupciones, localización, audio, efectos y persistencia de conversaciones.

El [Documento 13/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system) fija suites, fixtures, resultados, severidad, regresión, métricas, presupuestos y puertas de calidad.

El [Documento 14/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan) fija el orden, alcance, dependencias, hitos y puertas para implementar esta arquitectura. La colección rectora queda completa.
