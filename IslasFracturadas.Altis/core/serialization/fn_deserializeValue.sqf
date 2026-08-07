/* Restaura una representación producida por IF_fnc_serializeValue. */
params ["_value"];

if !(_value isEqualType []) exitWith {_value};
if ((count _value) != 2 || {!((_value # 0) isEqualType "")}) exitWith {objNull};

private _tag = _value # 0;
private _body = _value # 1;

if (_tag isEqualTo "ARRAY") exitWith {
    if !(_body isEqualType []) exitWith {objNull};
    private _result = [];
    private _valid = true;
    {
        private _decoded = [_x] call IF_fnc_deserializeValue;
        if (isNil "_decoded" || {_decoded isEqualType objNull}) exitWith {_valid = false};
        _result pushBack _decoded;
    } forEach _body;
    if (_valid) then {_result} else {objNull}
};

if (_tag isEqualTo "MAP") exitWith {
    if !(_body isEqualType []) exitWith {objNull};
    private _result = createHashMap;
    private _valid = true;
    {
        if !(_x isEqualType [] && {(count _x) isEqualTo 2} && {(_x # 0) isEqualType ""}) exitWith {
            _valid = false;
        };
        if ((_x # 0) in _result) exitWith {_valid = false};
        private _decoded = [_x # 1] call IF_fnc_deserializeValue;
        if (isNil "_decoded" || {_decoded isEqualType objNull}) exitWith {_valid = false};
        _result set [_x # 0, _decoded];
    } forEach _body;
    if (_valid) then {_result} else {objNull}
};

objNull
