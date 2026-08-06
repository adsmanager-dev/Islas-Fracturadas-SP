/* Procesa una cantidad acotada de eventos diferidos. */
params [["_budget", 8, [0]]];

if (!isServer) exitWith {[false, 0]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, 0]};

private _queue = IF_runtime get "eventQueue";
private _processed = 0;
private _success = true;
while {_processed < _budget && {count _queue > 0}} do {
    private _event = _queue deleteAt 0;
    private _result = [_event] call IF_fnc_eventProcess;
    _success = _success && {_result # 0};
    _processed = _processed + 1;
};

[_success, _processed]
