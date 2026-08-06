/*
 * Genera un ID efímero monotónico. No debe persistirse entre sesiones.
 */
params [["_prefix", "RUNTIME", [""]]];

if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {""};

private _normalized = toUpper _prefix;
if (_normalized isEqualTo "" || {_normalized find " " >= 0}) exitWith {""};

private _counters = IF_runtime get "runtimeIds";
private _next = (_counters getOrDefault [_normalized, 0]) + 1;
_counters set [_normalized, _next];

format ["IF_%1_%2", _normalized, _next]
