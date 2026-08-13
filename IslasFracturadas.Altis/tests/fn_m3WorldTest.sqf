/* Suite M3 aislada: valida grafo, command/evento y persistencia en memoria. */
if (!isServer) exitWith {false};

private _checks = [];
private _originalState = [IF_campaignState] call IF_fnc_valueClone;
private _originalAdapter = IF_runtime getOrDefault ["storageAdapter", "STORAGE_PROFILE_NAMESPACE"];
private _originalMemory = IF_runtime getOrDefault ["testStorage", createHashMap];

private _configValidation = [] call IF_fnc_configValidate;
private _configSectors = IF_config getOrDefault ["sectors", createHashMap];
private _configConnections = IF_config getOrDefault ["connections", createHashMap];
private _expectedAnchorPositions = createHashMapFromArray [
    ["ALT_W_NERI_PANOCHORI", [5059.8296, 11299.381, 0]],
    ["ALT_W_AGIOS_DIONYSIOS", [9366.166, 15886.582, 0]],
    ["ALT_CW_STAVROS_WHISKEY", [12948.381, 15032.742, 0]],
    ["ALT_CW_LAKKA", [12359.11, 15630.292, 0]],
    ["ALT_CW_AAC", [11479.819, 11632.228, 0]],
    ["ALT_CW_POLIAKKO_THERISA", [11246.036, 13627.0205, 0]],
    ["ALT_CW_XIROLIMNI_ZAROS", [9138.721, 13938.911, 0]],
    ["ALT_C_AIRPORT_WEST", [14383.358, 15922.19, 0]],
    ["ALT_C_AIRPORT_TERMINAL", [15185.31, 16774.15, 0]]
];
private _reconciledSectorIds = [
    "ALT_CW_STAVROS_WHISKEY",
    "ALT_CW_AAC",
    "ALT_CW_POLIAKKO_THERISA",
    "ALT_CW_XIROLIMNI_ZAROS",
    "ALT_C_AIRPORT_WEST",
    "ALT_C_AIRPORT_TERMINAL"
];
_checks pushBack [
    "config.nineSectors",
    (_configValidation # 0) && {(count _configSectors) isEqualTo 9}
    && {(count _configConnections) isEqualTo 9}
];

private _worldValidation = [] call IF_fnc_worldValidate;
_checks pushBack ["world.valid", _worldValidation # 0];

private _initializeAgain = [] call IF_fnc_worldInitialize;
_checks pushBack [
    "world.initializeIdempotent",
    (_initializeAgain # 0) && {!(_initializeAgain # 1)}
    && {(_initializeAgain # 2) isEqualTo "ALREADY_INITIALIZED"}
];

private _m2CandidateResult = [false] call IF_fnc_stateCreate;
private _m2DefaultsUpgraded = false;
private _newWorldNinePositions = false;
if (_m2CandidateResult # 0) then {
    private _m2Candidate = _m2CandidateResult # 1;
    private _m2Meta = _m2Candidate get "meta";
    _m2Meta set ["campaignVersion", "0.2.0-m2"];
    _m2Meta set ["buildId", "M2_PERSISTENCE"];
    missionNamespace setVariable ["IF_campaignState", _m2Candidate];
    private _upgrade = [] call IF_fnc_worldInitialize;
    private _upgradedMeta = IF_campaignState get "meta";
    private _newWorldPositionsValid = true;
    {
        private _sector = (IF_campaignState get "sectors") get _x;
        private _flags = _sector get "flags";
        private _expectedPosition = _expectedAnchorPositions get _x;
        if !(
            (_sector get "positionATL") isEqualTo _expectedPosition
            && {(_flags get "anchorPositionATL") isEqualTo _expectedPosition}
        ) then {
            _newWorldPositionsValid = false;
        };
    } forEach keys _expectedAnchorPositions;
    _newWorldNinePositions = (_upgrade # 0) && {_upgrade # 1} && {_newWorldPositionsValid};
    _m2DefaultsUpgraded = (_upgrade # 0) && {_upgrade # 1}
        && {(_upgradedMeta get "campaignVersion") isEqualTo "0.3.0-m3-dev"}
        && {(_upgradedMeta get "buildId") isEqualTo "M3_WORLD_GRAPH_DEV"}
        && {(count (_upgradedMeta getOrDefault ["migrationHistory", []])) isEqualTo 1}
        && {(count (IF_campaignState get "sectors")) isEqualTo 9};
};
_checks pushBack ["world.m2DefaultsUpgraded", _m2DefaultsUpgraded];
_checks pushBack ["world.newNinePhysicalPositions", _newWorldNinePositions];
missionNamespace setVariable ["IF_campaignState", [(_originalState)] call IF_fnc_valueClone];
[] call IF_fnc_runtimeRebuildAfterLoad;

private _protectedSnapshot = {
    params ["_state", "_sectorIds"];
    private _snapshot = [_state] call IF_fnc_valueClone;
    _snapshot deleteAt "meta";
    private _snapshotSectors = _snapshot get "sectors";
    {
        private _sector = _snapshotSectors get _x;
        private _flags = _sector get "flags";
        _sector deleteAt "positionATL";
        _flags deleteAt "anchorPositionATL";
        _flags deleteAt "anchorStatus";
        _flags deleteAt "validationStatus";
    } forEach _sectorIds;
    _snapshot
};

private _legacyState = [_originalState] call IF_fnc_valueClone;
private _legacySectors = _legacyState get "sectors";
{
    private _sector = _legacySectors get _x;
    private _flags = _sector get "flags";
    _sector set ["positionATL", []];
    _flags set ["anchorPositionATL", []];
    _flags set ["anchorStatus", "POR_CALIBRAR"];
    _flags set ["validationStatus", "POR_CALIBRAR"];
} forEach _reconciledSectorIds;

private _dynamicSector = _legacySectors get "ALT_CW_STAVROS_WHISKEY";
_dynamicSector set ["militaryOwner", "FAC_RED"];
_dynamicSector set ["militaryControl", 0.73];
_dynamicSector set ["garrisonId", "FORCE_TEST_STAVROS"];
_dynamicSector set ["readiness", 0.64];
_dynamicSector set ["morale", -0.2];
_dynamicSector set ["supplyLevel", 0.41];
_dynamicSector set ["production", createHashMapFromArray [["TEST_SUPPLY", 17]]];
_dynamicSector set ["damage", createHashMapFromArray [["TEST_INFRA", 0.35]]];
_dynamicSector set ["structuralLevel", 2];
_dynamicSector set ["fortificationLevel", 4];
(_legacyState get "forces") set ["FORCE_TEST_STAVROS", createHashMapFromArray [["strength", 23]]];
(_legacyState get "logistics") set ["LOG_TEST_STAVROS", createHashMapFromArray [["supply", 9]]];
(_legacyState get "relations") set ["REL_TEST_STAVROS", 0.18];
(_legacyState get "missions") set ["MISSION_TEST_STAVROS", createHashMapFromArray [["status", "ACTIVE"]]];

private _legacyWorldValidation = [_legacyState] call IF_fnc_worldValidate;
missionNamespace setVariable ["IF_campaignState", _legacyState];
private _historyBefore = count ((IF_campaignState get "meta") getOrDefault ["migrationHistory", []]);
private _protectedBefore = [IF_campaignState, _reconciledSectorIds] call _protectedSnapshot;
private _firstReconciliation = [] call IF_fnc_worldReconcilePhysicalMetadata;
private _stateAfterFirst = [IF_campaignState] call IF_fnc_valueClone;
private _protectedAfter = [IF_campaignState, _reconciledSectorIds] call _protectedSnapshot;
private _historyAfterFirst = (IF_campaignState get "meta") getOrDefault ["migrationHistory", []];
private _audit = if ((count _historyAfterFirst) > _historyBefore) then {
    _historyAfterFirst # ((count _historyAfterFirst) - 1)
} else {
    createHashMap
};
private _positionsReconciled = true;
{
    private _sector = (IF_campaignState get "sectors") get _x;
    private _flags = _sector get "flags";
    private _expectedPosition = _expectedAnchorPositions get _x;
    if !(
        (_sector get "positionATL") isEqualTo _expectedPosition
        && {(_flags get "anchorPositionATL") isEqualTo _expectedPosition}
        && {(_flags get "anchorStatus") isEqualTo "VALIDADO_3DEN"}
        && {(_flags get "validationStatus") isEqualTo "VALIDACION_3DEN_EN_CURSO"}
        && {(_sector get "radius") isEqualTo -1}
    ) then {
        _positionsReconciled = false;
    };
} forEach _reconciledSectorIds;

_checks pushBack [
    "reconcile.oldSavePhysicalMetadata",
    (_legacyWorldValidation # 0)
    && {(_firstReconciliation # 0)}
    && {(_firstReconciliation # 1)}
    && {(count (_firstReconciliation # 2)) isEqualTo 24}
    && {_positionsReconciled}
    && {(count _historyAfterFirst) isEqualTo (_historyBefore + 1)}
    && {(_audit getOrDefault ["kind", ""]) isEqualTo "PHYSICAL_METADATA_RECONCILIATION"}
    && {(_audit getOrDefault ["changeCount", -1]) isEqualTo 24}
    && {(count (_audit getOrDefault ["sectorIds", []])) isEqualTo 6}
    && {(count (_audit getOrDefault ["fieldsAdded", []])) isEqualTo 4}
];
_checks pushBack ["reconcile.dynamicStatePreserved", _protectedBefore isEqualTo _protectedAfter];

private _secondReconciliation = [] call IF_fnc_worldReconcilePhysicalMetadata;
private _stateAfterSecond = [IF_campaignState] call IF_fnc_valueClone;
_checks pushBack [
    "reconcile.idempotent",
    (_secondReconciliation # 0)
    && {!(_secondReconciliation # 1)}
    && {(_secondReconciliation # 3) isEqualTo "NO_CHANGES"}
    && {_stateAfterSecond isEqualTo _stateAfterFirst}
    && {(count ((IF_campaignState get "meta") getOrDefault ["migrationHistory", []])) isEqualTo (count _historyAfterFirst)}
];

private _pass2State = [_originalState] call IF_fnc_valueClone;
private _pass2Sectors = _pass2State get "sectors";
{
    private _flags = (_pass2Sectors get _x) get "flags";
    _flags set ["anchorStatus", "VALIDACION_3DEN_EN_CURSO"];
} forEach _reconciledSectorIds;
missionNamespace setVariable ["IF_campaignState", _pass2State];
private _pass2Promotion = [] call IF_fnc_worldReconcilePhysicalMetadata;
private _pass2StatusesValid = (_reconciledSectorIds findIf {
    private _flags = (_pass2Sectors get _x) get "flags";
    !((_flags getOrDefault ["anchorStatus", ""]) isEqualTo "VALIDADO_3DEN")
}) < 0;
_checks pushBack [
    "reconcile.pass2AnchorStatusesPromoted",
    (_pass2Promotion # 0)
    && {_pass2Promotion # 1}
    && {(count (_pass2Promotion # 2)) isEqualTo 6}
    && {_pass2StatusesValid}
];

private _persistedPositionState = [_originalState] call IF_fnc_valueClone;
private _persistedPositionSector = (_persistedPositionState get "sectors") get "ALT_CW_AAC";
private _persistedPositionFlags = _persistedPositionSector get "flags";
private _persistedPosition = [11111.25, 12222.5, 3];
_persistedPositionSector set ["positionATL", +_persistedPosition];
_persistedPositionFlags set ["anchorPositionATL", +_persistedPosition];
missionNamespace setVariable ["IF_campaignState", _persistedPositionState];
private _persistedPositionBefore = [IF_campaignState] call IF_fnc_valueClone;
private _persistedPositionResult = [] call IF_fnc_worldReconcilePhysicalMetadata;
_checks pushBack [
    "reconcile.persistedPositionWins",
    (_persistedPositionResult # 0)
    && {!(_persistedPositionResult # 1)}
    && {((_persistedPositionSector get "positionATL") isEqualTo _persistedPosition)}
    && {((_persistedPositionFlags get "anchorPositionATL") isEqualTo _persistedPosition)}
    && {IF_campaignState isEqualTo _persistedPositionBefore}
];

private _initializeReconciliationState = [_originalState] call IF_fnc_valueClone;
private _initializeReconciliationSector = (_initializeReconciliationState get "sectors") get "ALT_CW_AAC";
private _initializeReconciliationFlags = _initializeReconciliationSector get "flags";
_initializeReconciliationSector set ["positionATL", []];
_initializeReconciliationFlags set ["anchorPositionATL", []];
_initializeReconciliationFlags set ["anchorStatus", "POR_CALIBRAR"];
_initializeReconciliationFlags set ["validationStatus", "POR_CALIBRAR"];
missionNamespace setVariable ["IF_campaignState", _initializeReconciliationState];
private _initializeReconciliation = [] call IF_fnc_worldInitialize;
private _initializeAfterReconciliation = [] call IF_fnc_worldInitialize;
_checks pushBack [
    "reconcile.worldInitializeExistingUpdated",
    (_initializeReconciliation # 0)
    && {!(_initializeReconciliation # 1)}
    && {(_initializeReconciliation # 2) isEqualTo "ALREADY_INITIALIZED_RECONCILED"}
    && {(_initializeReconciliationSector get "positionATL") isEqualTo (_expectedAnchorPositions get "ALT_CW_AAC")}
    && {(_initializeReconciliationFlags get "anchorPositionATL") isEqualTo (_expectedAnchorPositions get "ALT_CW_AAC")}
    && {(_initializeAfterReconciliation # 0)}
    && {(_initializeAfterReconciliation # 2) isEqualTo "ALREADY_INITIALIZED"}
];

private _partialState = [_originalState] call IF_fnc_valueClone;
_partialState deleteAt "connections";
missionNamespace setVariable ["IF_campaignState", _partialState];
private _partialBefore = [IF_campaignState] call IF_fnc_valueClone;
private _partialReconciliation = [] call IF_fnc_worldReconcilePhysicalMetadata;
private _partialInitialize = [] call IF_fnc_worldInitialize;
_checks pushBack [
    "reconcile.partialWorldRejected",
    !(_partialReconciliation # 0)
    && {(_partialReconciliation # 3) isEqualTo "PARTIAL_WORLD_STATE"}
    && {!(_partialInitialize # 0)}
    && {(_partialInitialize # 2) isEqualTo "PARTIAL_WORLD_STATE"}
    && {IF_campaignState isEqualTo _partialBefore}
];

missionNamespace setVariable ["IF_campaignState", [(_originalState)] call IF_fnc_valueClone];
[] call IF_fnc_runtimeRebuildAfterLoad;

private _pathResult = [
    "ALT_W_NERI_PANOCHORI",
    "ALT_C_AIRPORT_TERMINAL"
] call IF_fnc_worldQueryFindPath;
_checks pushBack [
    "graph.pathTraversable",
    (_pathResult # 0)
    && {(_pathResult # 1) isEqualTo [
        "ALT_W_NERI_PANOCHORI",
        "ALT_W_AGIOS_DIONYSIOS",
        "ALT_CW_LAKKA",
        "ALT_C_AIRPORT_WEST",
        "ALT_C_AIRPORT_TERMINAL"
    ]}
];

private _depthResult = [["ALT_W_NERI_PANOCHORI"]] call IF_fnc_worldQueryCalculateDepth;
_checks pushBack [
    "graph.depthCalculated",
    (_depthResult # 0) && {(count (_depthResult # 1)) isEqualTo 9}
    && {((_depthResult # 1) getOrDefault ["ALT_W_NERI_PANOCHORI", -1]) isEqualTo 0}
    && {((_depthResult # 1) getOrDefault ["ALT_C_AIRPORT_TERMINAL", -1]) isEqualTo 4}
];

private _invalidState = [IF_campaignState] call IF_fnc_valueClone;
(_invalidState get "connections") deleteAt "CONN_M3_AGIOS_LAKKA";
private _invalidValidation = [_invalidState] call IF_fnc_worldValidate;
_checks pushBack ["world.invalidReferenceRejected", !(_invalidValidation # 0)];

IF_runtime set ["storageAdapter", "STORAGE_TEST_MEMORY"];
IF_runtime set ["testStorage", createHashMap];
private _ownerCommand = [
    "ALT_CW_LAKKA",
    "FAC_BLUE",
    "IF_CMD_M3_OWNER_PERSIST"
] call IF_fnc_worldCommandSetSectorOwner;
private _ownerEventId = "IF_EVT_SECTOR_OWNER_IF_CMD_M3_OWNER_PERSIST";
private _eventHistory = IF_campaignState get "events";
_checks pushBack [
    "owner.commandPublishesEvent",
    (_ownerCommand # 0) && {_ownerCommand # 3}
    && {((_ownerCommand # 1) get "militaryOwner") isEqualTo "FAC_BLUE"}
    && {_ownerEventId in _eventHistory}
    && {((_eventHistory get _ownerEventId) get "type") isEqualTo "IF_EVENT_SECTOR_MILITARY_OWNER_CHANGED"}
];

private _repeatCommand = [
    "ALT_CW_LAKKA",
    "FAC_BLUE",
    "IF_CMD_M3_OWNER_PERSIST"
] call IF_fnc_worldCommandSetSectorOwner;
_checks pushBack [
    "owner.commandIdempotent",
    (_repeatCommand # 0) && {!(_repeatCommand # 3)}
    && {(_repeatCommand # 4) isEqualTo "UNCHANGED"}
];

private _save = ["AUTO"] call IF_fnc_saveCampaign;
private _mutateAfterSave = [
    "ALT_CW_LAKKA",
    "FAC_GREEN",
    "IF_CMD_M3_OWNER_UNSAVED"
] call IF_fnc_worldCommandSetSectorOwner;
private _load = [] call IF_fnc_loadCampaign;
private _loadedSector = ["ALT_CW_LAKKA"] call IF_fnc_worldQueryGetSector;
_checks pushBack [
    "persistence.ownerRoundTrip",
    (_save # 0) && {_mutateAfterSave # 0} && {_load # 0}
    && {_loadedSector # 0} && {((_loadedSector # 1) get "militaryOwner") isEqualTo "FAC_BLUE"}
];

private _rebuiltDepth = IF_runtime getOrDefault ["sectorDepth", createHashMap];
_checks pushBack [
    "runtime.depthRebuiltAfterLoad",
    (count _rebuiltDepth) isEqualTo 9
    && {(_rebuiltDepth getOrDefault ["ALT_C_AIRPORT_TERMINAL", -1]) isEqualTo 4}
];

private _placedAnchors = 0;
private _validatedAnchorIds = [];
{
    private _flags = (_configSectors get _x);
    if ((count (_flags getOrDefault ["anchorPositionATL", []])) isEqualTo 3) then {
        _placedAnchors = _placedAnchors + 1;
        if ((_flags getOrDefault ["anchorStatus", ""]) isEqualTo "VALIDADO_3DEN") then {
            _validatedAnchorIds pushBack _x;
        };
    };
} forEach keys _configSectors;
_validatedAnchorIds sort true;
_checks pushBack [
    "anchors.allPlacedNineValidated",
    _placedAnchors isEqualTo 9
    && {_validatedAnchorIds isEqualTo [
        "ALT_CW_AAC",
        "ALT_CW_LAKKA",
        "ALT_CW_POLIAKKO_THERISA",
        "ALT_CW_STAVROS_WHISKEY",
        "ALT_CW_XIROLIMNI_ZAROS",
        "ALT_C_AIRPORT_TERMINAL",
        "ALT_C_AIRPORT_WEST",
        "ALT_W_AGIOS_DIONYSIOS",
        "ALT_W_NERI_PANOCHORI"
    ]}
];

private _allPhysicalConfigsValid = true;
{
    private _sector = _configSectors get _x;
    private _expectedPosition = _expectedAnchorPositions get _x;
    if !(
        (_sector getOrDefault ["positionATL", []]) isEqualTo _expectedPosition
        && {(_sector getOrDefault ["anchorPositionATL", []]) isEqualTo _expectedPosition}
        && {(_sector getOrDefault ["anchorStatus", ""]) isEqualTo "VALIDADO_3DEN"}
        && {(_sector getOrDefault ["validationStatus", ""]) isEqualTo "VALIDACION_3DEN_EN_CURSO"}
        && {(_sector getOrDefault ["radius", 0]) isEqualTo -1}
    ) then {
        _allPhysicalConfigsValid = false;
    };
} forEach keys _expectedAnchorPositions;
_checks pushBack ["anchors.allValidatedCoordinates", _allPhysicalConfigsValid];

private _diagnosticReport = createHashMapFromArray ([] call IF_fnc_worldDiagnosticsReport);
_checks pushBack [
    "diagnostics.anchorPlacementValidationSplit",
    (_diagnosticReport getOrDefault ["placedAnchorCount", -1]) isEqualTo 9
    && {(_diagnosticReport getOrDefault ["pendingPlacementCount", -1]) isEqualTo 0}
    && {(_diagnosticReport getOrDefault ["validatedAnchorCount", -1]) isEqualTo 9}
    && {(_diagnosticReport getOrDefault ["pendingValidationCount", -1]) isEqualTo 0}
];

missionNamespace setVariable ["IF_campaignState", _originalState];
IF_runtime set ["storageAdapter", _originalAdapter];
IF_runtime set ["testStorage", _originalMemory];
[] call IF_fnc_runtimeRebuildAfterLoad;

private _failedChecks = _checks select {!(_x # 1)};
private _passed = _failedChecks isEqualTo [];
{
    private _level = if (_x # 1) then {"INFO"} else {"ERROR"};
    private _result = if (_x # 1) then {"PASS"} else {"FAIL"};
    [_level, "TEST", format ["M3 %1: %2", _x # 0, _result]] call IF_fnc_log;
} forEach _checks;

missionNamespace setVariable ["IF_m3WorldTestResult", [_passed, _checks]];
_passed
