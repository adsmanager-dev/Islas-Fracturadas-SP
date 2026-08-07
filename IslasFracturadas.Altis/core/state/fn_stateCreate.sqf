/*
 * Construye el estado canónico inicial de campaña.
 * Entrada: [instalar]. Salida: [éxito, estado o error].
 */
params [["_install", true, [true]]];

if (!isServer) exitWith {
    private _error = [
        "IF_ERR_STATE_AUTHORITY",
        "RECOVERABLE",
        "STATE",
        "Solo el servidor puede crear el estado canónico"
    ] call IF_fnc_errorCreate;
    [false, _error]
};

if (_install && {!(isNil {missionNamespace getVariable "IF_campaignState"})}) exitWith {
    private _error = [
        "IF_ERR_STATE_DUPLICATE",
        "CRITICAL",
        "STATE",
        "IF_campaignState ya existe"
    ] call IF_fnc_errorCreate;
    [false, _error]
};

private _state = createHashMapFromArray [
    ["meta", createHashMapFromArray [
        ["schemaVersion", 1],
        ["campaignVersion", "0.3.0-m3-dev"],
        ["saveFormat", "IF_STATE_V1"],
        ["saveSlot", ""],
        ["createdAt", diag_tickTime],
        ["updatedAt", diag_tickTime],
        ["playTimeSeconds", 0],
        ["buildId", "M3_WORLD_GRAPH_DEV"],
        ["stateRevision", 0],
        ["checksum", ""],
        ["migrationHistory", []],
        ["isValid", true],
        ["lastValidationErrors", []]
    ]],
    ["campaign", createHashMapFromArray [
        ["campaignId", "IF_MAIN_CAMPAIGN"],
        ["campaignSide", "BLUE"],
        ["campaignMode", "SP"],
        ["currentWorld", "ALTIS"],
        ["currentAct", 0],
        ["currentPhase", "APPROACH"],
        ["narrativeDay", 1],
        ["campaignStarted", false],
        ["campaignCompleted", false],
        ["stratisUnlocked", false],
        ["stratisCompleted", false],
        ["epilogueUnlocked", false],
        ["dualCampaignCompleted", false],
        ["dualOperationUnlocked", false],
        ["difficultyProfile", "STANDARD"],
        ["ironman", false]
    ]],
    ["clock", createHashMapFromArray [
        ["campaignMinutes", 0],
        ["year", 2042],
        ["month", 6],
        ["day", 24],
        ["hour", 5],
        ["minute", 30],
        ["scale", 1],
        ["nextCycles", createHashMap]
    ]],
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

if (_install) then {
    missionNamespace setVariable ["IF_campaignState", _state];
    ["INFO", "STATE", "IF_campaignState creado", [["schemaVersion", 1]]] call IF_fnc_log;
};

[true, _state]
