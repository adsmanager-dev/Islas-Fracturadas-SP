/* Acepta únicamente tipos de datos admitidos por el estado persistente. */
params ["_value"];

if (_value isEqualType createHashMap) exitWith {
    (keys _value) findIf {
        !(_x isEqualType "") || {!([_value get _x] call IF_fnc_valueIsPersistable)}
    } < 0
};

if (_value isEqualType []) exitWith {
    _value findIf {!([_x] call IF_fnc_valueIsPersistable)} < 0
};

(_value isEqualType "") || {_value isEqualType 0} || {_value isEqualType true}
