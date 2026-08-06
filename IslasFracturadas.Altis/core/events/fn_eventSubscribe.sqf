/*
 * Registra un consumidor autoritativo de un hecho ya ocurrido.
 * Entrada: [tipo, consumerId, handler].
 */
params [
    ["_eventType", "", [""]],
    ["_consumerId", "", [""]],
    ["_handler", {}, [{}]]
];

if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "RUNTIME_MISSING"]};
if (_eventType find "IF_EVENT_" != 0 || {_consumerId isEqualTo ""}) exitWith {
    [false, "INVALID_CONTRACT"]
};

private _subscribers = IF_runtime get "eventSubscribers";
private _handlers = _subscribers getOrDefault [_eventType, []];
if (_handlers findIf {(_x # 0) isEqualTo _consumerId} >= 0) exitWith {
    [false, "DUPLICATE_CONSUMER"]
};

_handlers pushBack [_consumerId, _handler];
_subscribers set [_eventType, _handlers];

[true, _consumerId]
