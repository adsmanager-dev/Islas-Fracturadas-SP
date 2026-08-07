/*
 * Instala el grafo M3 en las raíces persistentes reservadas desde M1.
 * No sobrescribe un mundo cargado ni intenta reparar estados parciales.
 * Salida: [éxito, creado, razón].
 */
if (!isServer) exitWith {[false, false, "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_campaignState"}) exitWith {
    [false, false, "STATE_MISSING"]
};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {
    [false, false, "RUNTIME_MISSING"]
};
if (isNil {missionNamespace getVariable "IF_config"}) exitWith {
    [false, false, "CONFIG_MISSING"]
};

private _regionsState = IF_campaignState getOrDefault ["regions", objNull];
private _sectorsState = IF_campaignState getOrDefault ["sectors", objNull];
private _connectionsState = IF_campaignState getOrDefault ["connections", objNull];
if !(
    _regionsState isEqualType createHashMap
    && {_sectorsState isEqualType createHashMap}
    && {_connectionsState isEqualType createHashMap}
) exitWith {[false, false, "INVALID_WORLD_ROOT_TYPE"]};

private _worldCounts = [count _regionsState, count _sectorsState, count _connectionsState];
if ((_worldCounts findIf {_x > 0}) >= 0) exitWith {
    if ((_worldCounts findIf {_x isEqualTo 0}) >= 0) then {
        [false, false, "PARTIAL_WORLD_STATE"]
    } else {
        private _validation = [IF_campaignState] call IF_fnc_worldValidate;
        [_validation # 0, false, if (_validation # 0) then {"ALREADY_INITIALIZED"} else {"INVALID_EXISTING_WORLD"}]
    }
};

private _configRegions = IF_config getOrDefault ["regions", createHashMap];
private _configSectors = IF_config getOrDefault ["sectors", createHashMap];
private _configConnections = IF_config getOrDefault ["connections", createHashMap];
if ((count _configRegions) isEqualTo 0 || {(count _configSectors) isEqualTo 0} || {(count _configConnections) isEqualTo 0}) exitWith {
    [false, false, "CONFIG_WORLD_EMPTY"]
};

private _regionValues = createHashMap;
{
    private _source = _configRegions get _x;
    _regionValues set [_x, createHashMapFromArray [
        ["id", _source get "id"],
        ["displayName", _source get "displayName"],
        ["sectorIds", +(_source get "sectorIds")],
        ["regionalIdentity", _source get "displayName"],
        ["regionCode", _source get "regionCode"],
        ["validationStatus", _source get "validationStatus"],
        ["economicProfile", createHashMap],
        ["historicalGrievance", 0],
        ["governmentSupport", 0],
        ["greenTradition", 0],
        ["fiaInfluence", 0],
        ["blueDependency", 0],
        ["redDependency", 0],
        ["heliosDependency", 0]
    ]];
} forEach keys _configRegions;

private _sectorValues = createHashMap;
{
    private _source = _configSectors get _x;
    private _sector = createHashMapFromArray [
        ["id", _source get "id"],
        ["regionId", _source get "regionId"],
        ["displayName", _source get "displayName"],
        ["sectorType", _source get "sectorType"],
        ["positionATL", +(_source get "positionATL")],
        ["radius", _source get "radius"],
        ["connectionIds", +(_source get "connectionIds")],
        ["militaryOwner", _source get "initialMilitaryOwner"],
        ["militaryControl", 0],
        ["politicalAuthority", "FAC_NONE"],
        ["politicalLegitimacy", 0],
        ["clandestineInfluence", createHashMap],
        ["heliosAccess", 0],
        ["contestState", "UNRESOLVED"],
        ["captureProgress", 0],
        ["structuralLevel", _source get "structuralLevel"],
        ["maxStructuralLevel", _source get "maxStructuralLevel"],
        ["fortificationLevel", _source get "fortificationLevel"],
        ["strategicRole", _source get "strategicRole"],
        ["functionalCapacityBase", 0],
        ["defensiveCapacityBase", 0],
        ["functionalCapacityModifier", 0],
        ["defensiveCapacityModifier", 0],
        ["functionalCapacityUsed", 0],
        ["defensiveCapacityUsed", 0],
        ["garrisonId", ""],
        ["readiness", 0],
        ["supplyLevel", 0],
        ["morale", 0],
        ["population", 0],
        ["civilState", "UNRESOLVED"],
        ["infrastructure", createHashMap],
        ["production", createHashMap],
        ["demands", []],
        ["damage", createHashMap],
        ["moduleIds", []],
        ["combatMemory", []],
        ["constructionQueue", []],
        ["evacuationQueue", []],
        ["intelByFaction", createHashMap],
        ["eventMemory", []],
        ["activeMissionIds", []],
        ["flags", createHashMapFromArray [
            ["anchorId", _source get "anchorId"],
            ["anchorPositionATL", +(_source get "anchorPositionATL")],
            ["anchorStatus", _source get "anchorStatus"],
            ["validationStatus", _source get "validationStatus"],
            ["designStatus", _source get "designStatus"]
        ]]
    ];
    if ("blueBeachhead" in _source) then {
        (_sector get "flags") set ["blueBeachhead", [(_source get "blueBeachhead")] call IF_fnc_valueClone];
    };
    _sectorValues set [_x, _sector];
} forEach keys _configSectors;

private _connectionValues = createHashMap;
{
    private _source = _configConnections get _x;
    _connectionValues set [_x, createHashMapFromArray [
        ["id", _source get "id"],
        ["from", _source get "from"],
        ["to", _source get "to"],
        ["connectionType", _source get "connectionType"],
        ["distance", -1],
        ["capacity", -1],
        ["condition", -1],
        ["ownerControl", "FAC_GREEN"],
        ["threat", 0],
        ["blocked", false],
        ["mined", false],
        ["bridgeRequired", false],
        ["heliosLinked", false],
        ["designStatus", _source get "designStatus"],
        ["validationStatus", _source get "validationStatus"]
    ]];
} forEach keys _configConnections;

private _transaction = ["WORLD"] call IF_fnc_transactionBegin;
if !(_transaction # 0) exitWith {[false, false, _transaction # 1]};
private _transactionId = _transaction # 1;
private _commandsOk = true;
private _failureReason = "";

private _meta = IF_campaignState get "meta";
private _previousBuildId = _meta getOrDefault ["buildId", ""];
if !(_previousBuildId isEqualTo "M3_WORLD_GRAPH_DEV") then {
    private _history = +(_meta getOrDefault ["migrationHistory", []]);
    _history pushBack createHashMapFromArray [
        ["kind", "DOMAIN_DEFAULTS"],
        ["fromBuildId", _previousBuildId],
        ["toBuildId", "M3_WORLD_GRAPH_DEV"],
        ["appliedAt", +systemTimeUTC]
    ];
    {
        if (_commandsOk) then {
            private _result = [["meta", _x # 0], _x # 1, _transactionId] call IF_fnc_stateCommandSet;
            if !(_result # 0) then {
                _commandsOk = false;
                _failureReason = "META_UPGRADE_FAILED";
            };
        };
    } forEach [
        ["campaignVersion", "0.3.0-m3-dev"],
        ["buildId", "M3_WORLD_GRAPH_DEV"],
        ["migrationHistory", _history]
    ];
};

if (_commandsOk) then {
    private _worldCommand = [["world", "graph"], createHashMapFromArray [
        ["id", "ALTIS_M3_WORLD"],
        ["graphRevision", 1],
        ["implementationStatus", "IMPLEMENTADO_PENDIENTE_VALIDACION_3DEN"],
        ["depthSourceSectorIds", ["ALT_W_NERI_PANOCHORI"]],
        ["registeredSectorIds", keys _sectorValues],
        ["registeredConnectionIds", keys _connectionValues]
    ], _transactionId] call IF_fnc_stateCommandSet;
    if !(_worldCommand # 0) then {
        _commandsOk = false;
        _failureReason = "WORLD_ROOT_WRITE_FAILED";
    };
};

{
    if (_commandsOk) then {
        private _result = [["regions", _x], _regionValues get _x, _transactionId] call IF_fnc_stateCommandSet;
        if !(_result # 0) then {
            _commandsOk = false;
            _failureReason = "REGION_WRITE_FAILED";
        };
    };
} forEach keys _regionValues;
{
    if (_commandsOk) then {
        private _result = [["sectors", _x], _sectorValues get _x, _transactionId] call IF_fnc_stateCommandSet;
        if !(_result # 0) then {
            _commandsOk = false;
            _failureReason = "SECTOR_WRITE_FAILED";
        };
    };
} forEach keys _sectorValues;
{
    if (_commandsOk) then {
        private _result = [["connections", _x], _connectionValues get _x, _transactionId] call IF_fnc_stateCommandSet;
        if !(_result # 0) then {
            _commandsOk = false;
            _failureReason = "CONNECTION_WRITE_FAILED";
        };
    };
} forEach keys _connectionValues;

if (!_commandsOk) exitWith {
    [_transactionId] call IF_fnc_transactionRollback;
    [false, false, _failureReason]
};

private _commit = [_transactionId] call IF_fnc_transactionCommit;
if !(_commit # 0) exitWith {[false, false, "WORLD_COMMIT_FAILED"]};

private _rebuild = [] call IF_fnc_runtimeRebuildAfterLoad;
if !(_rebuild # 0) exitWith {[false, true, "RUNTIME_REBUILD_FAILED"]};

["INFO", "WORLD", "Grafo estratégico M3 instalado", [
    ["regions", count _regionValues],
    ["sectors", count _sectorValues],
    ["connections", count _connectionValues]
]] call IF_fnc_log;

[true, true, ""]
