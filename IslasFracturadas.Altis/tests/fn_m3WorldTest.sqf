/* Suite M3 aislada: valida grafo, command/evento y persistencia en memoria. */
if (!isServer) exitWith {false};

private _checks = [];
private _originalState = [IF_campaignState] call IF_fnc_valueClone;
private _originalAdapter = IF_runtime getOrDefault ["storageAdapter", "STORAGE_PROFILE_NAMESPACE"];
private _originalMemory = IF_runtime getOrDefault ["testStorage", createHashMap];

private _configValidation = [] call IF_fnc_configValidate;
private _configSectors = IF_config getOrDefault ["sectors", createHashMap];
private _configConnections = IF_config getOrDefault ["connections", createHashMap];
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
if (_m2CandidateResult # 0) then {
    private _m2Candidate = _m2CandidateResult # 1;
    private _m2Meta = _m2Candidate get "meta";
    _m2Meta set ["campaignVersion", "0.2.0-m2"];
    _m2Meta set ["buildId", "M2_PERSISTENCE"];
    missionNamespace setVariable ["IF_campaignState", _m2Candidate];
    private _upgrade = [] call IF_fnc_worldInitialize;
    private _upgradedMeta = IF_campaignState get "meta";
    _m2DefaultsUpgraded = (_upgrade # 0) && {_upgrade # 1}
        && {(_upgradedMeta get "campaignVersion") isEqualTo "0.3.0-m3-dev"}
        && {(_upgradedMeta get "buildId") isEqualTo "M3_WORLD_GRAPH_DEV"}
        && {(count (_upgradedMeta getOrDefault ["migrationHistory", []])) isEqualTo 1}
        && {(count (IF_campaignState get "sectors")) isEqualTo 9};
};
_checks pushBack ["world.m2DefaultsUpgraded", _m2DefaultsUpgraded];
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

private _pendingAnchors = 0;
{
    private _flags = (_configSectors get _x);
    if ((count (_flags getOrDefault ["anchorPositionATL", []])) isEqualTo 0) then {
        _pendingAnchors = _pendingAnchors + 1;
    };
} forEach keys _configSectors;
_checks pushBack ["anchors.pendingExplicit", _pendingAnchors isEqualTo 9];

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
