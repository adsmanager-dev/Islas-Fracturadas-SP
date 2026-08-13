/*
 * Query pura sobre una ruta del estado. Devuelve una copia del valor.
 * Entrada: [ruta]. Salida: [encontrado, valor].
 */
params [["_path", [], [[]]]];

if (isNil {missionNamespace getVariable "IF_campaignState"}) exitWith {
    [false, objNull]
};
if (_path isEqualTo [] || {_path findIf {!(_x isEqualType "") || {_x isEqualTo ""}} >= 0}) exitWith {
    [false, objNull]
};

private _current = IF_campaignState;
private _found = true;
{
    if !(_current isEqualType createHashMap) exitWith {
        _found = false;
    };
    if !(_x in _current) exitWith {
        _found = false;
    };
    _current = _current get _x;
} forEach _path;

if (!_found) exitWith {[false, objNull]};
[true, [_current] call IF_fnc_valueClone]
