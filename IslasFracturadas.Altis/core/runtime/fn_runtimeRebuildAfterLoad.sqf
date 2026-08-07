/* Reconstruye únicamente índices efímeros derivados tras instalar un snapshot. */
if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "RUNTIME_MISSING"]};
if (isNil {missionNamespace getVariable "IF_campaignState"}) exitWith {[false, "STATE_MISSING"]};

private _processed = createHashMap;
private _events = IF_campaignState getOrDefault ["events", createHashMap];
{
    private _eventId = _x;
    private _event = _events get _x;
    if (_event isEqualType createHashMap) then {
        private _consumers = _event getOrDefault ["processedBy", []];
        if (_consumers isEqualType []) then {
            _processed set [_eventId, +_consumers];
        };
    };
} forEach keys _events;

IF_runtime set ["processedEvents", _processed];
IF_runtime set ["eventQueue", []];
IF_runtime set ["activeTransactions", createHashMap];
IF_runtime set ["materializedEntities", createHashMap];

[true, count _processed]
