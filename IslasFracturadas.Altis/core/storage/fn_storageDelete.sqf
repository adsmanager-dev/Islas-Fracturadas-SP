/* Elimina una clave. Se reserva para fixtures y mantenimiento explícito. */
params [["_key", "", [""]]];

if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (_key isEqualTo "") exitWith {[false, "INVALID_KEY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "RUNTIME_MISSING"]};

private _adapter = IF_runtime getOrDefault ["storageAdapter", "STORAGE_PROFILE_NAMESPACE"];
if (_adapter isEqualTo "STORAGE_TEST_MEMORY") exitWith {
    (IF_runtime get "testStorage") deleteAt _key;
    [true, _key]
};

private _variable = format ["IF_STORAGE_%1", _key];
private _index = +(missionProfileNamespace getVariable ["IF_STORAGE_INDEX", []]);
private _previousIndex = +_index;
private _hadPrevious = !(isNil {missionProfileNamespace getVariable _variable});
private _previous = missionProfileNamespace getVariable [_variable, []];
private _indexPosition = _index find _key;
if (_indexPosition >= 0) then {_index deleteAt _indexPosition};
missionProfileNamespace setVariable [_variable, nil];
missionProfileNamespace setVariable ["IF_STORAGE_INDEX", _index];
if (saveMissionProfileNamespace) then {
    [true, _key]
} else {
    if (_hadPrevious) then {missionProfileNamespace setVariable [_variable, _previous]};
    missionProfileNamespace setVariable ["IF_STORAGE_INDEX", _previousIndex];
    [false, "PROFILE_SAVE_FAILED"]
}
