/*
 * Guarda la campaña sin reemplazar el último snapshot válido hasta verificar
 * por lectura el candidato nuevo. AUTO alterna A/B; MANUAL conserva backup.
 */
params [["_mode", "AUTO", [""]]];

_mode = toUpper _mode;
if (!isServer) exitWith {[false, "", "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "", "RUNTIME_MISSING"]};
if (isNil {missionNamespace getVariable "IF_campaignState"}) exitWith {[false, "", "STATE_MISSING"]};
if !(_mode in ["AUTO", "MANUAL", "CHECKPOINT"]) exitWith {[false, "", "INVALID_MODE"]};
if ((count (keys (IF_runtime get "activeTransactions"))) > 0) exitWith {[false, "", "OPEN_TRANSACTION"]};
if (IF_runtime getOrDefault ["materializationInProgress", false]) exitWith {[false, "", "MATERIALIZATION_INCOMPLETE"]};
if !(IF_runtime getOrDefault ["ownershipConfirmed", true]) exitWith {[false, "", "OWNERSHIP_UNCONFIRMED"]};

private _snapshotResult = [IF_campaignState] call IF_fnc_saveCreateSnapshot;
if !(_snapshotResult # 0) exitWith {[false, "", _snapshotResult # 2]};
private _envelope = _snapshotResult # 1;

private _slot = "";
private _markerKey = "IF_MAIN_CAMPAIGN_ACTIVE";
private _previousSlot = "";

if (_mode isEqualTo "AUTO") then {
    private _activeResult = [_markerKey] call IF_fnc_storageLoad;
    if (_activeResult # 0 && {(_activeResult # 1) isEqualType ""}) then {
        _previousSlot = _activeResult # 1;
    };
    _slot = if (_previousSlot isEqualTo "IF_MAIN_CAMPAIGN_AUTOSAVE_A") then {
        "IF_MAIN_CAMPAIGN_AUTOSAVE_B"
    } else {
        "IF_MAIN_CAMPAIGN_AUTOSAVE_A"
    };
} else {
    _slot = if (_mode isEqualTo "MANUAL") then {
        "IF_MAIN_CAMPAIGN_MANUAL_1"
    } else {
        "IF_MAIN_CAMPAIGN_CHECKPOINT"
    };

    private _previous = [_slot] call IF_fnc_storageLoad;
    if (_previous # 0) then {
        private _backupKey = _slot + "_BACKUP";
        private _backupWrite = [_backupKey, _previous # 1] call IF_fnc_storageSave;
        if !(_backupWrite # 0) exitWith {_slot = ""};
        private _backupRead = [_backupKey] call IF_fnc_storageLoad;
        private _backupValidation = if (_backupRead # 0) then {
            [_backupRead # 1] call IF_fnc_saveValidate
        } else {
            [false]
        };
        if !(_backupValidation # 0) then {_slot = ""};
    };
};

if (_slot isEqualTo "") exitWith {[false, "", "BACKUP_FAILED"]};
private _write = [_slot, _envelope] call IF_fnc_storageSave;
if !(_write # 0) exitWith {[false, _slot, _write # 1]};

private _readBack = [_slot] call IF_fnc_storageLoad;
if !(_readBack # 0) exitWith {[false, _slot, "READ_BACK_FAILED"]};
private _verification = [_readBack # 1] call IF_fnc_saveValidate;
if !(_verification # 0) exitWith {
    ["ERROR", "SAVE", "Snapshot escrito no superó verificación", [["slot", _slot], ["errors", _verification # 1]]] call IF_fnc_log;
    [false, _slot, "VERIFY_FAILED"]
};

if (_mode isEqualTo "AUTO") then {
    private _markerWrite = [_markerKey, _slot] call IF_fnc_storageSave;
    if !(_markerWrite # 0) exitWith {_slot = ""};
};
if (_slot isEqualTo "") exitWith {[false, "", "ACTIVE_MARKER_FAILED"]};

private _meta = IF_campaignState get "meta";
_meta set ["saveSlot", _slot];
_meta set ["checksum", _envelope get "checksum"];

[
    "INFO", "SAVE", "Snapshot verificado y activado",
    [["mode", _mode], ["slot", _slot], ["schemaVersion", 1], ["previous", _previousSlot]]
] call IF_fnc_log;

if !(isNil {missionNamespace getVariable "IF_fnc_eventPublish"}) then {
    [
        "IF_EVENT_CAMPAIGN_SAVED",
        createHashMapFromArray [["mode", _mode], ["slot", _slot], ["schemaVersion", 1]],
        false,
        "SAVE",
        _slot
    ] call IF_fnc_eventPublish;
};

[true, _slot, ""]
