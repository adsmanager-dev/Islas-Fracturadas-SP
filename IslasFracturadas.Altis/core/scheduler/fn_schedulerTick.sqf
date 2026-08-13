/*
 * Ejecuta tareas vencidas respetando presupuesto por frame.
 * Entrada: [ahora, máximo de tareas, máximo de segundos].
 */
params [
    ["_now", diag_tickTime, [0]],
    ["_taskBudget", 8, [0]],
    ["_timeBudget", 0.004, [0]]
];

if (!isServer) exitWith {[false, 0]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, 0]};

private _tasks = IF_runtime get "scheduler";
private _taskIds = keys _tasks;
_taskIds sort true;
private _startedAt = diag_tickTime;
private _executed = 0;

{
    if (_executed >= _taskBudget || {diag_tickTime - _startedAt >= _timeBudget}) exitWith {};
    private _taskId = _x;
    if (_taskId in _tasks) then {
        private _task = _tasks get _taskId;
        if ((_task getOrDefault ["enabled", false]) && {_now >= (_task getOrDefault ["nextRun", 1e12])}) then {
            private _taskStartedAt = diag_tickTime;
            private _function = _task get "function";
            private _result = [_task] call _function;
            private _runtime = diag_tickTime - _taskStartedAt;
            _task set ["lastRuntime", _runtime];
            _task set ["runCount", (_task getOrDefault ["runCount", 0]) + 1];
            _executed = _executed + 1;

            if !(_result isEqualTo true) then {
                [
                    "IF_ERR_SCHEDULER_TASK",
                    "RECOVERABLE",
                    "PERFORMANCE",
                    "Una tarea programada devolvió fallo",
                    [["taskId", _taskId]]
                ] call IF_fnc_errorCreate;
            };
            if (_runtime > (_task get "maxRuntime")) then {
                [
                    "WARN",
                    "PERFORMANCE",
                    "Tarea por encima de su presupuesto",
                    [["taskId", _taskId], ["runtime", _runtime]]
                ] call IF_fnc_log;
            };

            private _interval = _task get "interval";
            if (_interval <= 0) then {
                _tasks deleteAt _taskId;
            } else {
                _task set ["nextRun", _now + _interval];
            };
        };
    };
} forEach _taskIds;

[true, _executed]
