/*
 * Inicialización posterior idempotente.
 * Valida configuración y levanta el núcleo M1 únicamente en la autoridad.
 */
if (missionNamespace getVariable ["IF_bootstrapPostInitComplete", false]) exitWith {
    true
};

missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_10_ENGINE_READY"];

private _diagnosticsIndex = paramsArray param [0, 1, [0]];
private _diagnosticsMode = [_diagnosticsIndex] call IF_fnc_diagnosticsSetMode;

private _sectorConfig = missionConfigFile >> "ALT_W_NERI_PANOCHORI";
private _sectorId = if (isClass _sectorConfig) then {
    getText (_sectorConfig >> "id")
} else {
    ""
};
private _configValidation = [[_sectorId]] call IF_fnc_validateIds;
missionNamespace setVariable ["IF_configValidation", _configValidation];
missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_20_CONFIG"];
private _configLoadResult = [] call IF_fnc_configLoad;
private _configServiceValidation = [] call IF_fnc_configValidate;
private _configReady = (
    (_configValidation # 0)
    && {_configLoadResult # 0}
    && {_configServiceValidation # 0}
);
missionNamespace setVariable ["IF_configReady", _configReady];

if (_configReady) then {
    [
        "INFO",
        "CONFIG",
        "Configuración mínima validada",
        [["sectorId", _sectorId]]
    ] call IF_fnc_log;
} else {
    [
        "ERROR",
        "CONFIG",
        "Falló la validación de configuración",
        _configValidation # 1
    ] call IF_fnc_log;
};

missionNamespace setVariable ["IF_bootstrapPostInitComplete", true];

private _smokePassed = [] call IF_fnc_smokeTest;
missionNamespace setVariable ["IF_smokeTestPassed", _smokePassed];

private _m1Passed = true;
if (isServer) then {
    missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_30_SERVICES"];
    private _runtimeResult = [] call IF_fnc_runtimeCreate;

    missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_40_STATE"];
    private _stateResult = [] call IF_fnc_stateCreate;
    private _stateValidation = [] call IF_fnc_stateValidate;

    private _eventTaskResult = [
        "IF_TASK_EVENT_QUEUE",
        "EVENT",
        {
            [8] call IF_fnc_eventProcessQueue;
            true
        },
        0.1,
        diag_tickTime + 0.1,
        "HIGH",
        0.002
    ] call IF_fnc_schedulerRegister;

    private _schedulerHandlerId = addMissionEventHandler [
        "EachFrame",
        {
            if (isServer) then {
                [] call IF_fnc_schedulerTick;
            };
        }
    ];
    IF_runtime set ["schedulerHandlerId", _schedulerHandlerId];

    private _servicesReady = (
        (_runtimeResult # 0)
        && {_configReady}
        && {_stateResult # 0}
        && {_stateValidation # 0}
        && {_eventTaskResult # 0}
    );

    if (_servicesReady) then {
        missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_50_WORLD"];
        missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_60_TESTS"];
        _m1Passed = [] call IF_fnc_m1CoreTest;
    } else {
        _m1Passed = false;
        [
            "IF_ERR_BOOTSTRAP_M1",
            "CRITICAL",
            "BOOT",
            "No se pudieron iniciar todos los servicios M1",
            [
                ["runtime", _runtimeResult # 0],
                ["config", _configReady],
                ["state", _stateResult # 0],
                ["validation", _stateValidation # 0],
                ["scheduler", _eventTaskResult # 0]
            ]
        ] call IF_fnc_errorCreate;
    };

    missionNamespace setVariable ["IF_m1CoreTestPassed", _m1Passed];
    missionNamespace setVariable [
        "IF_bootstrapPhase",
        if (_m1Passed) then {"PHASE_90_RUNNING"} else {"PHASE_99_DEGRADED"}
    ];
} else {
    missionNamespace setVariable ["IF_m1CoreTestPassed", false];
    missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_30_CLIENT_READY"];
};

if !(_diagnosticsMode isEqualTo "OFF") then {
    [] call IF_fnc_diagnosticsReport;
};

[
    "INFO",
    "BOOT",
    "postInit completado",
    [
        ["phase", missionNamespace getVariable ["IF_bootstrapPhase", "UNKNOWN"]],
        ["diagnostics", _diagnosticsMode],
        ["smokePassed", _smokePassed],
        ["m1Passed", _m1Passed],
        ["isAuthority", isServer]
    ]
] call IF_fnc_log;

true
