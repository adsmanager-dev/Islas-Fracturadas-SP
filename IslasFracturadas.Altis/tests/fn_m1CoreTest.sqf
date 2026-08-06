/*
 * Suite de integración M1. Usa IDs exclusivos y limpia las fixtures que
 * podrían persistir; no depende de UI ni crea entidades físicas.
 */
if (!isServer) exitWith {false};

private _checks = [];

private _configValidation = [] call IF_fnc_configValidate;
_checks pushBack [
    "config.valid",
    (missionNamespace getVariable ["IF_configReady", false]) && {_configValidation # 0}
];

private _candidateResult = [false] call IF_fnc_stateCreate;
private _candidateValidation = if (_candidateResult # 0) then {
    [_candidateResult # 1] call IF_fnc_stateValidate
} else {
    [false, []]
};
_checks pushBack ["state.new", (_candidateResult # 0) && {_candidateValidation # 0}];

private _duplicateIdResult = [["M1_DUPLICATE", "M1_DUPLICATE"]] call IF_fnc_validateIds;
_checks pushBack ["ids.duplicateRejected", !(_duplicateIdResult # 0)];

private _transactionResult = ["M1_TEST", "IF_TX_M1_ROLLBACK"] call IF_fnc_transactionBegin;
private _commandResult = if (_transactionResult # 0) then {
    [["campaign", "currentPhase"], "BEACHHEAD", "IF_TX_M1_ROLLBACK"] call IF_fnc_stateCommandSet
} else {
    [false]
};
private _changedQuery = [["campaign", "currentPhase"]] call IF_fnc_stateQueryGet;
private _rollbackResult = if (_commandResult # 0) then {
    ["IF_TX_M1_ROLLBACK"] call IF_fnc_transactionRollback
} else {
    [false]
};
private _restoredQuery = [["campaign", "currentPhase"]] call IF_fnc_stateQueryGet;
_checks pushBack [
    "state.commandAndQuery",
    (_commandResult # 0) && {_changedQuery # 0} && {(_changedQuery # 1) isEqualTo "BEACHHEAD"}
];
_checks pushBack [
    "transaction.rollback",
    (_rollbackResult # 0) && {_restoredQuery # 0} && {(_restoredQuery # 1) isEqualTo "APPROACH"}
];

IF_runtime set ["m1EventHandlerCount", 0];
private _subscriptionResult = [
    "IF_EVENT_M1_TEST_COMPLETED",
    "IF_M1_TEST_CONSUMER",
    {
        IF_runtime set [
            "m1EventHandlerCount",
            (IF_runtime getOrDefault ["m1EventHandlerCount", 0]) + 1
        ];
        true
    }
] call IF_fnc_eventSubscribe;
private _persistentEvent = [
    "IF_EVENT_M1_TEST_COMPLETED",
    createHashMapFromArray [["fixture", "M1"]],
    true,
    "TEST",
    "M1",
    false,
    "IF_EVT_M1_REPEAT"
] call IF_fnc_eventPublish;
private _repeatedEvent = [
    "IF_EVENT_M1_TEST_COMPLETED",
    createHashMapFromArray [["fixture", "M1"]],
    true,
    "TEST",
    "M1",
    false,
    "IF_EVT_M1_REPEAT"
] call IF_fnc_eventPublish;
private _eventCount = IF_runtime getOrDefault ["m1EventHandlerCount", 0];
private _history = IF_campaignState get "events";
_checks pushBack [
    "event.persistent",
    (_subscriptionResult # 0) && {_persistentEvent # 0} && {"IF_EVT_M1_REPEAT" in _history}
];
_checks pushBack [
    "event.repeatedOnce",
    (_repeatedEvent # 0) && {_eventCount isEqualTo 1} && {((_repeatedEvent # 2) # 2) >= 1}
];

IF_runtime set ["m1ScheduledCount", 0];
private _scheduledResult = [
    "IF_TASK_M1_ONCE",
    "TEST",
    {
        IF_runtime set [
            "m1ScheduledCount",
            (IF_runtime getOrDefault ["m1ScheduledCount", 0]) + 1
        ];
        true
    },
    0,
    diag_tickTime - 0.01,
    "EVENT_DRIVEN",
    0.01
] call IF_fnc_schedulerRegister;
private _tickResult = [diag_tickTime, 8, 0.02] call IF_fnc_schedulerTick;
private _tasks = IF_runtime get "scheduler";
_checks pushBack [
    "scheduler.once",
    (_scheduledResult # 0)
    && {_tickResult # 0}
    && {(IF_runtime getOrDefault ["m1ScheduledCount", 0]) isEqualTo 1}
    && {!("IF_TASK_M1_ONCE" in _tasks)}
];

private _clockTransaction = ["M1_TEST", "IF_TX_M1_CLOCK"] call IF_fnc_transactionBegin;
private _clockAdvance = if (_clockTransaction # 0) then {
    [90, "IF_TX_M1_CLOCK"] call IF_fnc_clockAdvance
} else {
    [false]
};
private _strategicTime = [] call IF_fnc_clockGetStrategicTime;
private _clockRollback = if (_clockAdvance # 0) then {
    ["IF_TX_M1_CLOCK"] call IF_fnc_transactionRollback
} else {
    [false]
};
private _restoredTime = [] call IF_fnc_clockGetStrategicTime;
_checks pushBack [
    "clock.advance",
    (_clockAdvance # 0)
    && {_strategicTime isEqualTo 90}
    && {_clockRollback # 0}
    && {_restoredTime isEqualTo 0}
];

private _criticalError = [
    "IF_ERR_M1_TEST_CRITICAL",
    "CRITICAL",
    "TEST",
    "Fixture de error crítico M1",
    [],
    false
] call IF_fnc_errorCreate;
_checks pushBack [
    "error.critical",
    (_criticalError get "classification") isEqualTo "CRITICAL"
    && {_criticalError get "isCritical"}
];

/* Limpieza de fixtures persistibles; métricas efímeras quedan para diagnóstico. */
_history deleteAt "IF_EVT_M1_REPEAT";

private _failedChecks = _checks select {!(_x # 1)};
private _passed = _failedChecks isEqualTo [];
{
    private _level = if (_x # 1) then {"INFO"} else {"ERROR"};
    private _result = if (_x # 1) then {"PASS"} else {"FAIL"};
    [_level, "TEST", format ["M1 %1: %2", _x # 0, _result]] call IF_fnc_log;
} forEach _checks;

missionNamespace setVariable ["IF_m1CoreTestResult", [_passed, _checks]];
_passed
