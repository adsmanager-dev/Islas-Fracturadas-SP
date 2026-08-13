/*
 * Publica un evento normalizado, síncrono o diferido.
 * Contrato v1: [tipo, payload, persistente, módulo, sourceId, diferido, eventId].
 * Salida: [éxito, envelope, resultado de proceso].
 */
params [
    ["_eventType", "", [""]],
    ["_payload", createHashMap, [createHashMap]],
    ["_persistent", false, [true]],
    ["_sourceModule", "CORE", [""]],
    ["_sourceId", "", [""]],
    ["_deferred", false, [true]],
    ["_eventId", "", [""]]
];

if (!isServer) exitWith {[false, createHashMap, [false, "NOT_AUTHORITY"]]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {
    [false, createHashMap, [false, "RUNTIME_MISSING"]]
};
if (_eventType find "IF_EVENT_" != 0) exitWith {
    [false, createHashMap, [false, "INVALID_EVENT_TYPE"]]
};
if !([_payload] call IF_fnc_valueIsPersistable) exitWith {
    [false, createHashMap, [false, "INVALID_PAYLOAD"]]
};

if (_eventId isEqualTo "") then {
    _eventId = ["EVT"] call IF_fnc_idGenerateRuntime;
};
if (_eventId isEqualTo "") exitWith {
    [false, createHashMap, [false, "INVALID_EVENT_ID"]]
};

private _createdAt = if (isNil {missionNamespace getVariable "IF_campaignState"}) then {
    0
} else {
    ((IF_campaignState get "clock") getOrDefault ["campaignMinutes", 0])
};

private _event = createHashMapFromArray [
    ["id", _eventId],
    ["type", _eventType],
    ["version", 1],
    ["createdAt", _createdAt],
    ["sourceModule", toUpper _sourceModule],
    ["sourceId", _sourceId],
    ["payload", [_payload] call IF_fnc_valueClone],
    ["persistent", _persistent],
    ["processedBy", []]
];

if (_persistent && {!(isNil {missionNamespace getVariable "IF_campaignState"})}) then {
    private _history = IF_campaignState get "events";
    if (_eventId in _history) then {
        _event = _history get _eventId;
    } else {
        _history set [_eventId, _event];
        private _meta = IF_campaignState get "meta";
        _meta set ["stateRevision", (_meta getOrDefault ["stateRevision", 0]) + 1];
        _meta set ["updatedAt", diag_tickTime];
    };
};

private _processResult = [true, 0, 0, []];
if (_deferred) then {
    private _queue = IF_runtime get "eventQueue";
    if (_queue findIf {((_x get "id") isEqualTo _eventId)} < 0) then {
        _queue pushBack _event;
    };
} else {
    _processResult = [_event] call IF_fnc_eventProcess;
};

[true, _event, _processResult]
