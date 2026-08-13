/* Convierte un valor persistible a una representación canónica y ordenada. */
params ["_value"];

if (_value isEqualType createHashMap) exitWith {
    private _sortedKeys = keys _value;
    _sortedKeys sort true;
    private _pairs = _sortedKeys apply {
        [_x, [_value get _x] call IF_fnc_serializeValue]
    };
    ["MAP", _pairs]
};

if (_value isEqualType []) exitWith {
    ["ARRAY", _value apply {[_x] call IF_fnc_serializeValue}]
};

_value
