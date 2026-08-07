/* Carga el primer snapshot válido siguiendo la cadena de recuperación. */
if (!isServer) exitWith {[false, createHashMap, "", false, false, "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {
    [false, createHashMap, "", false, false, "RUNTIME_MISSING"]
};

private _marker = ["IF_MAIN_CAMPAIGN_ACTIVE"] call IF_fnc_storageLoad;
private _active = if (_marker # 0 && {(_marker # 1) isEqualType ""}) then {_marker # 1} else {""};
private _alternate = if (_active isEqualTo "IF_MAIN_CAMPAIGN_AUTOSAVE_A") then {
    "IF_MAIN_CAMPAIGN_AUTOSAVE_B"
} else {
    "IF_MAIN_CAMPAIGN_AUTOSAVE_A"
};
private _candidates = [];
if !(_active isEqualTo "") then {_candidates pushBackUnique _active};
_candidates pushBackUnique _alternate;
_candidates pushBackUnique "IF_MAIN_CAMPAIGN_AUTOSAVE_A";
_candidates pushBackUnique "IF_MAIN_CAMPAIGN_AUTOSAVE_B";
_candidates pushBackUnique "IF_MAIN_CAMPAIGN_CHECKPOINT";
_candidates pushBackUnique "IF_MAIN_CAMPAIGN_MANUAL_1";

private _loadedState = createHashMap;
private _loadedSlot = "";
private _migrated = false;
private _errors = [];

{
    if (_loadedSlot isEqualTo "") then {
        private _read = [_x] call IF_fnc_storageLoad;
        if (_read # 0) then {
            private _envelope = _read # 1;
            private _migration = [_envelope] call IF_fnc_saveMigrate;
            if (_migration # 0) then {
                private _candidate = _migration # 1;
                private _validation = [_candidate] call IF_fnc_saveValidate;
                if (_validation # 0) then {
                    if (_migration # 2) then {
                        private _backupKey = _x + "_PRE_MIGRATION_V0";
                        private _migratedKey = _x + "_MIGRATED_V1";
                        private _backup = [_backupKey, _envelope] call IF_fnc_storageSave;
                        private _migratedWrite = [_migratedKey, _candidate] call IF_fnc_storageSave;
                        private _migratedRead = [_migratedKey] call IF_fnc_storageLoad;
                        private _migratedValid = if (_migratedRead # 0) then {
                            [_migratedRead # 1] call IF_fnc_saveValidate
                        } else {
                            [false]
                        };
                        if !((_backup # 0) && {_migratedWrite # 0} && {_migratedValid # 0}) then {
                            _errors pushBack [_x, "MIGRATION_PERSIST_FAILED"];
                        } else {
                            _loadedState = _validation # 2;
                            _loadedSlot = _migratedKey;
                            _migrated = true;
                        };
                    } else {
                        _loadedState = _validation # 2;
                        _loadedSlot = _x;
                    };
                } else {
                    _errors pushBack [_x, "INVALID", _validation # 1];
                };
            } else {
                _errors pushBack [_x, "MIGRATION_FAILED", _migration # 3];
            };
        };
    };
} forEach _candidates;

if (_loadedSlot isEqualTo "") exitWith {
    private _reason = if (_errors isEqualTo []) then {"NOT_FOUND"} else {"NO_VALID_SNAPSHOT"};
    if !(_errors isEqualTo []) then {
        ["WARN", "SAVE", "No se encontró snapshot recuperable", _errors] call IF_fnc_log;
    };
    [false, createHashMap, "", false, false, _reason]
};

missionNamespace setVariable ["IF_campaignState", _loadedState];
private _rebuild = [] call IF_fnc_runtimeRebuildAfterLoad;
if !(_rebuild # 0) exitWith {[false, createHashMap, _loadedSlot, false, _migrated, "RUNTIME_REBUILD_FAILED"]};

private _recovered = !(_active isEqualTo "") && {!(_loadedSlot isEqualTo _active)};
[
    "INFO", "SAVE", "Campaña cargada",
    [["slot", _loadedSlot], ["recovered", _recovered], ["migrated", _migrated], ["schemaVersion", 1]]
] call IF_fnc_log;

if !(isNil {missionNamespace getVariable "IF_fnc_eventPublish"}) then {
    [
        "IF_EVENT_CAMPAIGN_LOADED",
        createHashMapFromArray [["slot", _loadedSlot], ["recovered", _recovered], ["migrated", _migrated]],
        false,
        "SAVE",
        _loadedSlot
    ] call IF_fnc_eventPublish;
};

[true, _loadedState, _loadedSlot, _recovered, _migrated, ""]
