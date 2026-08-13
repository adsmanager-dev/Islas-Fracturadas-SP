/*
 * Registra una tarea en el scheduler central de tiempo real.
 * Entrada: [id, módulo, función, intervalo, próxima ejecución, prioridad, máximo].
 */
params [
    ["_taskId", "", [""]],
    ["_module", "CORE", [""]],
    ["_function", {}, [{}]],
    ["_interval", 1, [0]],
    ["_nextRun", -1, [0]],
    ["_priority", "MEDIUM", [""]],
    ["_maxRuntime", 0.004, [0]]
];

if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "RUNTIME_MISSING"]};
if (_taskId isEqualTo "" || {_interval < 0} || {_maxRuntime <= 0}) exitWith {
    [false, "INVALID_TASK"]
};

private _normalizedPriority = toUpper _priority;
if !(_normalizedPriority in ["REALTIME", "HIGH", "MEDIUM", "LOW", "DAILY", "EVENT_DRIVEN"]) exitWith {
    [false, "INVALID_PRIORITY"]
};

private _tasks = IF_runtime get "scheduler";
if (_taskId in _tasks) exitWith {[false, "DUPLICATE_TASK"]};
if (_nextRun < 0) then {
    _nextRun = diag_tickTime + _interval;
};

private _task = createHashMapFromArray [
    ["id", _taskId],
    ["module", toUpper _module],
    ["function", _function],
    ["interval", _interval],
    ["nextRun", _nextRun],
    ["priority", _normalizedPriority],
    ["enabled", true],
    ["maxRuntime", _maxRuntime],
    ["runCount", 0],
    ["lastRuntime", 0]
];
_tasks set [_taskId, _task];

[true, _task]
