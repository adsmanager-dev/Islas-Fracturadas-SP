/*
 * Procesa un envelope una vez por consumidor.
 * La clave (eventId, consumerId) materializa la idempotencia de sesión M1.
 */
params [["_event", createHashMap, [createHashMap]]];

if (!isServer) exitWith {[false, 0, 0, ["NOT_AUTHORITY"]]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {
    [false, 0, 0, ["RUNTIME_MISSING"]]
};

private _eventId = _event getOrDefault ["id", ""];
private _eventType = _event getOrDefault ["type", ""];
if (_eventId isEqualTo "" || {_eventType find "IF_EVENT_" != 0}) exitWith {
    [false, 0, 0, ["INVALID_EVENT"]]
};

private _allSubscribers = IF_runtime get "eventSubscribers";
private _subscribers = _allSubscribers getOrDefault [_eventType, []];
private _processedEvents = IF_runtime get "processedEvents";
private _processedBy = _processedEvents getOrDefault [_eventId, []];
private _processedCount = 0;
private _skippedCount = 0;
private _failures = [];

{
    _x params ["_consumerId", "_handler"];
    if (_consumerId in _processedBy) then {
        _skippedCount = _skippedCount + 1;
    } else {
        private _handlerResult = [_event] call _handler;
        if (_handlerResult isEqualTo true) then {
            _processedBy pushBack _consumerId;
            _processedCount = _processedCount + 1;
        } else {
            _failures pushBack _consumerId;
            [
                "IF_ERR_EVENT_HANDLER",
                "RECOVERABLE",
                "EVENT",
                "Un consumidor rechazó el evento",
                [["eventId", _eventId], ["consumerId", _consumerId]]
            ] call IF_fnc_errorCreate;
        };
    };
} forEach _subscribers;

_processedEvents set [_eventId, _processedBy];
_event set ["processedBy", +_processedBy];

[_failures isEqualTo [], _processedCount, _skippedCount, _failures]
