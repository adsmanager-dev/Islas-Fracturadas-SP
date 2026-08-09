/*
 * Completa metadatos físicos M3 ausentes desde configuración sin reconstruir
 * sectores ni sobrescribir posiciones persistidas válidas.
 * Salida: [éxito, cambió, cambios, razón].
 */
if (!isServer) exitWith {[false, false, [], "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_campaignState"}) exitWith {
    [false, false, [], "STATE_MISSING"]
};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {
    [false, false, [], "RUNTIME_MISSING"]
};
if (isNil {missionNamespace getVariable "IF_config"}) exitWith {
    [false, false, [], "CONFIG_MISSING"]
};

private _worldRootNames = ["regions", "sectors", "connections"];
private _presentRootCount = {_x in IF_campaignState} count _worldRootNames;
if (_presentRootCount > 0 && {_presentRootCount < count _worldRootNames}) exitWith {
    [false, false, [], "PARTIAL_WORLD_STATE"]
};
if !(_presentRootCount isEqualTo (count _worldRootNames)) exitWith {
    [false, false, [], "INVALID_WORLD_ROOT_TYPE"]
};

private _regionsState = IF_campaignState get "regions";
private _sectorsState = IF_campaignState get "sectors";
private _connectionsState = IF_campaignState get "connections";
if !(
    _regionsState isEqualType createHashMap
    && {_sectorsState isEqualType createHashMap}
    && {_connectionsState isEqualType createHashMap}
) exitWith {[false, false, [], "INVALID_WORLD_ROOT_TYPE"]};

private _worldCounts = [count _regionsState, count _sectorsState, count _connectionsState];
if ((_worldCounts findIf {_x > 0}) < 0) exitWith {
    [false, false, [], "WORLD_NOT_INITIALIZED"]
};
if ((_worldCounts findIf {_x isEqualTo 0}) >= 0) exitWith {
    [false, false, [], "PARTIAL_WORLD_STATE"]
};

private _worldValidation = [IF_campaignState] call IF_fnc_worldValidate;
if !(_worldValidation # 0) exitWith {
    [false, false, [], "INVALID_EXISTING_WORLD"]
};
private _stateValidationTarget = [IF_campaignState] call IF_fnc_valueClone;
private _stateValidation = [_stateValidationTarget] call IF_fnc_stateValidate;
if !(_stateValidation # 0) exitWith {
    [false, false, [], "INVALID_EXISTING_STATE"]
};

private _meta = IF_campaignState getOrDefault ["meta", objNull];
if !(_meta isEqualType createHashMap) exitWith {
    [false, false, [], "INVALID_META"]
};
private _migrationHistory = _meta getOrDefault ["migrationHistory", objNull];
if !(_migrationHistory isEqualType []) exitWith {
    [false, false, [], "INVALID_MIGRATION_HISTORY"]
};

private _configValidation = [] call IF_fnc_configValidate;
if !(_configValidation # 0) exitWith {
    [false, false, [], "INVALID_WORLD_CONFIG"]
};
private _configSectors = IF_config getOrDefault ["sectors", objNull];
if !(_configSectors isEqualType createHashMap) exitWith {
    [false, false, [], "INVALID_WORLD_CONFIG"]
};

private _changes = [];
private _affectedSectorIds = [];
private _fieldsAdded = [];
private _preparationErrors = [];
private _queueChange = {
    params ["_sectorId", "_path", "_field", "_oldExists", "_oldValue", "_newValue"];
    _changes pushBack createHashMapFromArray [
        ["sectorId", _sectorId],
        ["path", +_path],
        ["field", _field],
        ["oldExists", _oldExists],
        ["oldValue", [_oldValue] call IF_fnc_valueClone],
        ["newValue", [_newValue] call IF_fnc_valueClone]
    ];
    _affectedSectorIds pushBackUnique _sectorId;
    _fieldsAdded pushBackUnique _field;
};

private _configSectorIds = keys _configSectors;
_configSectorIds sort true;
{
    private _sectorId = _x;
    if !(_sectorId in _sectorsState) then {
        _preparationErrors pushBack ["CONFIG_SECTOR_NOT_PERSISTED", _sectorId];
    } else {
        private _storedSector = _sectorsState get _sectorId;
        private _configSector = _configSectors get _sectorId;
        if !(_storedSector isEqualType createHashMap && {_configSector isEqualType createHashMap}) then {
            _preparationErrors pushBack ["INVALID_SECTOR_TYPE", _sectorId];
        } else {
            private _storedFlags = _storedSector getOrDefault ["flags", objNull];
            if !(_storedFlags isEqualType createHashMap) then {
                _preparationErrors pushBack ["INVALID_SECTOR_FLAGS", _sectorId];
            } else {
                private _storedPosition = _storedSector getOrDefault ["positionATL", objNull];
                private _configPosition = _configSector getOrDefault ["positionATL", objNull];
                private _positionReady = _storedPosition isEqualType [] && {(count _storedPosition) isEqualTo 3};
                if (_storedPosition isEqualType [] && {(count _storedPosition) isEqualTo 0}) then {
                    if (_configPosition isEqualType [] && {(count _configPosition) isEqualTo 3}) then {
                        [
                            _sectorId,
                            ["sectors", _sectorId, "positionATL"],
                            "positionATL",
                            "positionATL" in _storedSector,
                            _storedPosition,
                            _configPosition
                        ] call _queueChange;
                        _positionReady = true;
                    } else {
                        _preparationErrors pushBack ["CONFIG_POSITION_UNAVAILABLE", _sectorId];
                    };
                };

                private _storedAnchorPosition = _storedFlags getOrDefault ["anchorPositionATL", objNull];
                private _configAnchorPosition = _configSector getOrDefault ["anchorPositionATL", objNull];
                private _anchorPositionReady = _storedAnchorPosition isEqualType []
                    && {(count _storedAnchorPosition) isEqualTo 3};
                if (_storedAnchorPosition isEqualType [] && {(count _storedAnchorPosition) isEqualTo 0}) then {
                    if (_configAnchorPosition isEqualType [] && {(count _configAnchorPosition) isEqualTo 3}) then {
                        [
                            _sectorId,
                            ["sectors", _sectorId, "flags", "anchorPositionATL"],
                            "flags.anchorPositionATL",
                            "anchorPositionATL" in _storedFlags,
                            _storedAnchorPosition,
                            _configAnchorPosition
                        ] call _queueChange;
                        _anchorPositionReady = true;
                    } else {
                        _preparationErrors pushBack ["CONFIG_ANCHOR_POSITION_UNAVAILABLE", _sectorId];
                    };
                };

                if (_positionReady && {_anchorPositionReady}) then {
                    {
                        private _statusField = _x;
                        private _storedStatusExists = _statusField in _storedFlags;
                        private _storedStatus = _storedFlags getOrDefault [_statusField, ""];
                        private _configStatus = _configSector getOrDefault [_statusField, ""];
                        private _safeTransition = (
                            (!_storedStatusExists || {_storedStatus isEqualTo "POR_CALIBRAR"})
                            && {_configStatus isEqualTo "VALIDACION_3DEN_EN_CURSO"}
                        );
                        if (_safeTransition && {!(_storedStatus isEqualTo _configStatus)}) then {
                            [
                                _sectorId,
                                ["sectors", _sectorId, "flags", _statusField],
                                "flags." + _statusField,
                                _storedStatusExists,
                                _storedStatus,
                                _configStatus
                            ] call _queueChange;
                        };
                    } forEach ["anchorStatus", "validationStatus"];
                };
            };
        };
    };
} forEach _configSectorIds;

if !(_preparationErrors isEqualTo []) exitWith {
    [false, false, [], "RECONCILIATION_PREPARATION_FAILED"]
};
if (_changes isEqualTo []) exitWith {
    [true, false, [], "NO_CHANGES"]
};

_affectedSectorIds sort true;
_fieldsAdded sort true;
private _history = [_migrationHistory] call IF_fnc_valueClone;
_history pushBack createHashMapFromArray [
    ["kind", "PHYSICAL_METADATA_RECONCILIATION"],
    ["reconciliationType", "M3_ADDITIVE_PHYSICAL_METADATA"],
    ["sectorIds", +_affectedSectorIds],
    ["fieldsAdded", +_fieldsAdded],
    ["changeCount", count _changes],
    ["appliedAt", +systemTimeUTC]
];

private _transaction = ["WORLD_RECONCILIATION"] call IF_fnc_transactionBegin;
if !(_transaction # 0) exitWith {[false, false, [], _transaction # 1]};
private _transactionId = _transaction # 1;
private _commandsOk = true;
private _failureReason = "";

{
    if (_commandsOk) then {
        private _result = [
            _x get "path",
            _x get "newValue",
            _transactionId
        ] call IF_fnc_stateCommandSet;
        if !(_result # 0) then {
            _commandsOk = false;
            _failureReason = "PHYSICAL_METADATA_WRITE_FAILED";
        };
    };
} forEach _changes;

if (_commandsOk) then {
    private _auditResult = [
        ["meta", "migrationHistory"],
        _history,
        _transactionId
    ] call IF_fnc_stateCommandSet;
    if !(_auditResult # 0) then {
        _commandsOk = false;
        _failureReason = "RECONCILIATION_AUDIT_WRITE_FAILED";
    };
};

if (!_commandsOk) exitWith {
    [_transactionId] call IF_fnc_transactionRollback;
    [false, false, [], _failureReason]
};

private _postApplyValidation = [IF_campaignState] call IF_fnc_worldValidate;
if !(_postApplyValidation # 0) exitWith {
    [_transactionId] call IF_fnc_transactionRollback;
    [false, false, [], "RECONCILED_WORLD_INVALID"]
};

private _commit = [_transactionId] call IF_fnc_transactionCommit;
if !(_commit # 0) exitWith {
    [false, false, [], "RECONCILIATION_COMMIT_FAILED"]
};

["INFO", "WORLD", "Metadatos físicos M3 reconciliados", [
    ["reconciliationType", "M3_ADDITIVE_PHYSICAL_METADATA"],
    ["sectorIds", +_affectedSectorIds],
    ["fieldsAdded", +_fieldsAdded],
    ["changeCount", count _changes]
]] call IF_fnc_log;

[true, true, +_changes, ""]
