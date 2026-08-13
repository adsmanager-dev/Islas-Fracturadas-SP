/*
 * Command autoritativo de propietario militar.
 * Salida: [éxito, sector, evento, cambió, razón].
 */
params [
    ["_sectorId", "", [""]],
    ["_newOwner", "", [""]],
    ["_commandId", "", [""]]
];

if (!isServer) exitWith {[false, createHashMap, createHashMap, false, "NOT_AUTHORITY"]};
_newOwner = toUpper _newOwner;
if !(_newOwner in ["FAC_BLUE", "FAC_GREEN", "FAC_RED", "FAC_FIA", "FAC_NONE"]) exitWith {
    [false, createHashMap, createHashMap, false, "INVALID_OWNER"]
};

private _sectorResult = [_sectorId] call IF_fnc_worldQueryGetSector;
if !(_sectorResult # 0) exitWith {[false, createHashMap, createHashMap, false, _sectorResult # 2]};
private _sector = _sectorResult # 1;
private _oldOwner = _sector getOrDefault ["militaryOwner", ""];
if (_oldOwner isEqualTo _newOwner) exitWith {[true, _sector, createHashMap, false, "UNCHANGED"]};

_sector set ["militaryOwner", _newOwner];
private _transaction = ["WORLD"] call IF_fnc_transactionBegin;
if !(_transaction # 0) exitWith {[false, createHashMap, createHashMap, false, _transaction # 1]};
private _transactionId = _transaction # 1;
private _write = [["sectors", _sectorId], _sector, _transactionId] call IF_fnc_stateCommandSet;
if !(_write # 0) exitWith {
    [_transactionId] call IF_fnc_transactionRollback;
    [false, createHashMap, createHashMap, false, "SECTOR_WRITE_FAILED"]
};
private _commit = [_transactionId] call IF_fnc_transactionCommit;
if !(_commit # 0) exitWith {[false, createHashMap, createHashMap, false, "SECTOR_COMMIT_FAILED"]};

private _eventId = if (_commandId isEqualTo "") then {""} else {
    format ["IF_EVT_SECTOR_OWNER_%1", _commandId]
};
private _eventResult = [
    "IF_EVENT_SECTOR_MILITARY_OWNER_CHANGED",
    createHashMapFromArray [
        ["sectorId", _sectorId],
        ["oldOwner", _oldOwner],
        ["newOwner", _newOwner],
        ["commandId", _commandId]
    ],
    true,
    "WORLD",
    _sectorId,
    false,
    _eventId
] call IF_fnc_eventPublish;
if !(_eventResult # 0) exitWith {
    ["ERROR", "WORLD", "Propietario confirmado sin evento de dominio", [
        ["sectorId", _sectorId], ["oldOwner", _oldOwner], ["newOwner", _newOwner]
    ]] call IF_fnc_log;
    [false, _write # 1, createHashMap, true, "EVENT_PUBLISH_FAILED_AFTER_COMMIT"]
};

[true, _write # 1, _eventResult # 1, true, ""]
