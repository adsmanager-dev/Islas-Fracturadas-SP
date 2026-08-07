/* Aplica migraciones secuenciales sobre una copia; v1 es idempotente. */
params ["_envelope"];

if (!isServer) exitWith {[false, createHashMap, false, "NOT_AUTHORITY"]};
if !(_envelope isEqualType createHashMap) exitWith {[false, createHashMap, false, "INVALID_TYPE"]};

private _version = _envelope getOrDefault ["schemaVersion", _envelope getOrDefault ["version", -1]];
if (_version isEqualTo 1) exitWith {
    private _copy = [_envelope] call IF_fnc_valueClone;
    private _validation = [_copy] call IF_fnc_saveValidate;
    [_validation # 0, _copy, false, if (_validation # 0) then {""} else {"INVALID_V1"}]
};
if (_version isEqualTo 0) exitWith {
    private _result = [_envelope] call IF_fnc_saveMigrateV0ToV1;
    [_result # 0, _result # 1, _result # 0, _result # 2]
};

[false, createHashMap, false, "UNSUPPORTED_SCHEMA"]
