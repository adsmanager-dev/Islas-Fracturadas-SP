/* Lee y deserializa un valor sin devolver referencias al adaptador. */
params [["_key", "", [""]]];

if (!isServer) exitWith {[false, objNull, "NOT_AUTHORITY"]};
if (_key isEqualTo "") exitWith {[false, objNull, "INVALID_KEY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, objNull, "RUNTIME_MISSING"]};

private _adapter = IF_runtime getOrDefault ["storageAdapter", "STORAGE_PROFILE_NAMESPACE"];
private _raw = objNull;

if (_adapter isEqualTo "STORAGE_TEST_MEMORY") then {
    private _memory = IF_runtime get "testStorage";
    if !(_key in _memory) exitWith {};
    _raw = [_memory get _key] call IF_fnc_valueClone;
} else {
    if !(_adapter isEqualTo "STORAGE_PROFILE_NAMESPACE") exitWith {
        IF_runtime set ["storageLastError", "UNKNOWN_ADAPTER"];
    };
    private _variable = format ["IF_STORAGE_%1", _key];
    if (isNil {missionProfileNamespace getVariable _variable}) exitWith {};
    _raw = missionProfileNamespace getVariable _variable;
};

if (_raw isEqualType objNull) exitWith {[false, objNull, "NOT_FOUND"]};
private _decoded = [_raw] call IF_fnc_deserializeValue;
if (isNil "_decoded" || {_decoded isEqualType objNull}) exitWith {
    [false, objNull, "DESERIALIZE_FAILED"]
};

[true, _decoded, ""]
