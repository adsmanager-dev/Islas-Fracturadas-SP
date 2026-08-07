/* Guarda un valor persistible mediante el adaptador operativo seleccionado. */
params [["_key", "", [""]], "_value"];

if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (_key isEqualTo "" || {!([_value] call IF_fnc_valueIsPersistable)}) exitWith {
    [false, "INVALID_INPUT"]
};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "RUNTIME_MISSING"]};

private _adapter = IF_runtime getOrDefault ["storageAdapter", "STORAGE_PROFILE_NAMESPACE"];
private _stored = [_value] call IF_fnc_serializeValue;

if (_adapter isEqualTo "STORAGE_TEST_MEMORY") exitWith {
    private _memory = IF_runtime get "testStorage";
    _memory set [_key, [_stored] call IF_fnc_valueClone];
    [true, _key]
};

if !(_adapter isEqualTo "STORAGE_PROFILE_NAMESPACE") exitWith {
    IF_runtime set ["storageLastError", "UNKNOWN_ADAPTER"];
    [false, "UNKNOWN_ADAPTER"]
};

private _variable = format ["IF_STORAGE_%1", _key];
private _indexVariable = "IF_STORAGE_INDEX";
private _hadPrevious = !(isNil {missionProfileNamespace getVariable _variable});
private _previous = missionProfileNamespace getVariable [_variable, []];
private _previousIndex = +(missionProfileNamespace getVariable [_indexVariable, []]);
private _newIndex = +_previousIndex;
_newIndex pushBackUnique _key;

missionProfileNamespace setVariable [_variable, _stored];
missionProfileNamespace setVariable [_indexVariable, _newIndex];
private _persisted = saveMissionProfileNamespace;

if (!_persisted) then {
    if (_hadPrevious) then {
        missionProfileNamespace setVariable [_variable, _previous];
    } else {
        missionProfileNamespace setVariable [_variable, nil];
    };
    missionProfileNamespace setVariable [_indexVariable, _previousIndex];
    IF_runtime set ["storageLastError", "PROFILE_SAVE_FAILED"];
    [false, "PROFILE_SAVE_FAILED"]
} else {
    IF_runtime set ["storageLastError", ""];
    [true, _key]
}
