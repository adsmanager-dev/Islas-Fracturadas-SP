/*
 * Copia recursivamente valores persistibles para evitar que una query exponga
 * referencias mutables del estado canónico.
 */
params ["_value"];

if (_value isEqualType createHashMap) exitWith {
    private _copy = createHashMap;
    {
        _copy set [_x, [_value get _x] call IF_fnc_valueClone];
    } forEach keys _value;
    _copy
};

if (_value isEqualType []) exitWith {
    _value apply {[_x] call IF_fnc_valueClone}
};

_value
