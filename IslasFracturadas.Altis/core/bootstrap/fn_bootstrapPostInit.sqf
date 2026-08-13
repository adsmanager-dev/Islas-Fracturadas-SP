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

missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_20_CONFIG"];
private _configLoadResult = [] call IF_fnc_configLoad;
private _configServiceValidation = [] call IF_fnc_configValidate;
private _configReady = (_configLoadResult # 0) && {_configServiceValidation # 0};
missionNamespace setVariable ["IF_configValidation", _configServiceValidation];
missionNamespace setVariable ["IF_configReady", _configReady];

if (_configReady) then {
    private _loadedConfig = _configLoadResult # 1;
    [
        "INFO",
        "CONFIG",
        "Configuración estratégica M3 validada",
        [
            ["regions", count (_loadedConfig get "regions")],
            ["sectors", count (_loadedConfig get "sectors")],
            ["connections", count (_loadedConfig get "connections")]
        ]
    ] call IF_fnc_log;
} else {
    [
        "ERROR",
        "CONFIG",
        "Falló la validación de configuración",
        _configServiceValidation # 1
    ] call IF_fnc_log;
};

missionNamespace setVariable ["IF_bootstrapPostInitComplete", true];

private _smokePassed = [] call IF_fnc_smokeTest;
missionNamespace setVariable ["IF_smokeTestPassed", _smokePassed];

private _m1Passed = true;
private _m2Passed = true;
private _m3Passed = true;
private _persistenceLoaded = false;
private _persistenceSlot = "";
private _probeMode = paramsArray param [1, 0, [0]];
private _probePassed = true;
private _runIntegrationTests = (paramsArray param [2, 0, [0]]) isEqualTo 1;
if (isServer) then {
    missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_30_SERVICES"];
    private _runtimeResult = [] call IF_fnc_runtimeCreate;

    missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_40_STATE"];
    private _loadResult = if (_runtimeResult # 0) then {
        [] call IF_fnc_loadCampaign
    } else {
        [false, createHashMap, "", false, false, "RUNTIME_MISSING"]
    };
    _persistenceLoaded = _loadResult # 0;
    _persistenceSlot = _loadResult # 2;
    private _stateResult = if (_persistenceLoaded) then {
        [true, _loadResult # 1]
    } else {
        [] call IF_fnc_stateCreate
    };
    private _stateValidation = [] call IF_fnc_stateValidate;

    missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_50_WORLD"];
    private _worldResult = if ((_stateResult # 0) && {_stateValidation # 0} && {_configReady}) then {
        [] call IF_fnc_worldInitialize
    } else {
        [false, false, "PREREQUISITES_MISSING"]
    };
    private _worldValidation = if (_worldResult # 0) then {
        [] call IF_fnc_worldValidate
    } else {
        [false, [[_worldResult # 2]]]
    };

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
        && {_worldResult # 0}
        && {_worldValidation # 0}
        && {_eventTaskResult # 0}
    );

    if (_servicesReady) then {
        missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_60_TESTS"];
        if (_runIntegrationTests) then {
            _m1Passed = [] call IF_fnc_m1CoreTest;
            _m2Passed = [] call IF_fnc_m2PersistenceTest;
            _m3Passed = [] call IF_fnc_m3WorldTest;
        } else {
            _m1Passed = false;
            _m2Passed = false;
            _m3Passed = false;
            ["INFO", "TEST", "Suites M1-M3 omitidas; ejecución no solicitada"] call IF_fnc_log;
        };

        if (_probeMode isEqualTo 1) then {
            private _probeValue = format ["M2_RESTART_%1", systemTimeUTC];
            private _probeCommand = [["progression", "m2RestartProbe"], _probeValue] call IF_fnc_stateCommandSet;
            private _probeSave = if (_probeCommand # 0) then {
                ["AUTO"] call IF_fnc_saveCampaign
            } else {
                [false, "", "PROBE_COMMAND_FAILED"]
            };
            _probePassed = _probeSave # 0;
            missionNamespace setVariable ["IF_m2PersistenceProbeValue", _probeValue];
            missionNamespace setVariable ["IF_m2PersistenceProbeSaved", _probePassed];
            [
                if (_probePassed) then {"INFO"} else {"ERROR"},
                "TEST",
                format ["M2 persistence.restart.stage1: %1", if (_probePassed) then {"PASS"} else {"FAIL"}],
                [["slot", _probeSave # 1], ["reason", _probeSave # 2]]
            ] call IF_fnc_log;
        };

        if (_probeMode isEqualTo 2) then {
            private _probeQuery = [["progression", "m2RestartProbe"]] call IF_fnc_stateQueryGet;
            _probePassed = _persistenceLoaded && {_probeQuery # 0} && {!((_probeQuery # 1) isEqualTo "")};
            missionNamespace setVariable ["IF_m2PersistenceProbeLoaded", _probePassed];
            [
                if (_probePassed) then {"INFO"} else {"ERROR"},
                "TEST",
                format ["M2 persistence.restart.stage2: %1", if (_probePassed) then {"PASS"} else {"FAIL"}],
                [["slot", _persistenceSlot], ["loaded", _persistenceLoaded]]
            ] call IF_fnc_log;
        };

        if (_probeMode isEqualTo 3) then {
            private _probeQuery = [["progression", "m2RestartProbe"]] call IF_fnc_stateQueryGet;
            private _probeFound = _persistenceLoaded && {_probeQuery # 0} && {!((_probeQuery # 1) isEqualTo "")};
            if (_probeFound) then {
                _probePassed = true;
                missionNamespace setVariable ["IF_m2PersistenceProbeLoaded", true];
                [
                    "INFO",
                    "TEST",
                    "M2 persistence.restart.auto.stage2: PASS",
                    [["slot", _persistenceSlot], ["loaded", true]]
                ] call IF_fnc_log;
            } else {
                private _probeValue = format ["M2_RESTART_%1", systemTimeUTC];
                private _probeCommand = [["progression", "m2RestartProbe"], _probeValue] call IF_fnc_stateCommandSet;
                private _probeSave = if (_probeCommand # 0) then {
                    ["AUTO"] call IF_fnc_saveCampaign
                } else {
                    [false, "", "PROBE_COMMAND_FAILED"]
                };
                _probePassed = _probeSave # 0;
                missionNamespace setVariable ["IF_m2PersistenceProbeValue", _probeValue];
                missionNamespace setVariable ["IF_m2PersistenceProbeSaved", _probePassed];
                [
                    if (_probePassed) then {"INFO"} else {"ERROR"},
                    "TEST",
                    format ["M2 persistence.restart.auto.stage1: %1", if (_probePassed) then {"PASS"} else {"FAIL"}],
                    [["slot", _probeSave # 1], ["reason", _probeSave # 2]]
                ] call IF_fnc_log;
            };
        };
    } else {
        _m1Passed = false;
        _m2Passed = false;
        _m3Passed = false;
        [
            "IF_ERR_BOOTSTRAP_M3",
            "CRITICAL",
            "BOOT",
            "No se pudieron iniciar todos los servicios hasta M3",
            [
                ["runtime", _runtimeResult # 0],
                ["config", _configReady],
                ["state", _stateResult # 0],
                ["validation", _stateValidation # 0],
                ["world", _worldResult # 0],
                ["worldValidation", _worldValidation # 0],
                ["scheduler", _eventTaskResult # 0]
            ]
        ] call IF_fnc_errorCreate;
    };

    missionNamespace setVariable ["IF_m1CoreTestPassed", _m1Passed];
    missionNamespace setVariable ["IF_m2PersistenceTestPassed", _m2Passed];
    missionNamespace setVariable ["IF_m3WorldTestPassed", _m3Passed];
    missionNamespace setVariable ["IF_integrationTestsRun", _runIntegrationTests];
    missionNamespace setVariable ["IF_persistenceLoaded", _persistenceLoaded];
    missionNamespace setVariable ["IF_persistenceSlot", _persistenceSlot];
    missionNamespace setVariable [
        "IF_bootstrapPhase",
        if (_servicesReady && {(!_runIntegrationTests || {_m1Passed && {_m2Passed} && {_m3Passed}})} && {_probePassed}) then {"PHASE_90_RUNNING"} else {"PHASE_99_DEGRADED"}
    ];
} else {
    _m1Passed = false;
    _m2Passed = false;
    _m3Passed = false;
    _runIntegrationTests = false;
    missionNamespace setVariable ["IF_m1CoreTestPassed", false];
    missionNamespace setVariable ["IF_m2PersistenceTestPassed", false];
    missionNamespace setVariable ["IF_m3WorldTestPassed", false];
    missionNamespace setVariable ["IF_integrationTestsRun", false];
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
        ["m2Passed", _m2Passed],
        ["m3Passed", _m3Passed],
        ["integrationTestsRun", _runIntegrationTests],
        ["persistenceLoaded", _persistenceLoaded],
        ["persistenceSlot", _persistenceSlot],
        ["persistenceProbe", _probeMode],
        ["persistenceProbePassed", _probePassed],
        ["isAuthority", isServer]
    ]
] call IF_fnc_log;

true
