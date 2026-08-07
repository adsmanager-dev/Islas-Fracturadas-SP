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
private _m2Passed = true;
private _persistenceLoaded = false;
private _persistenceSlot = "";
private _probeMode = paramsArray param [1, 0, [0]];
private _probePassed = true;
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
        _m2Passed = [] call IF_fnc_m2PersistenceTest;

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
    missionNamespace setVariable ["IF_m2PersistenceTestPassed", _m2Passed];
    missionNamespace setVariable ["IF_persistenceLoaded", _persistenceLoaded];
    missionNamespace setVariable ["IF_persistenceSlot", _persistenceSlot];
    missionNamespace setVariable [
        "IF_bootstrapPhase",
        if (_m1Passed && {_m2Passed} && {_probePassed}) then {"PHASE_90_RUNNING"} else {"PHASE_99_DEGRADED"}
    ];
} else {
    missionNamespace setVariable ["IF_m1CoreTestPassed", false];
    missionNamespace setVariable ["IF_m2PersistenceTestPassed", false];
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
        ["persistenceLoaded", _persistenceLoaded],
        ["persistenceSlot", _persistenceSlot],
        ["persistenceProbe", _probeMode],
        ["persistenceProbePassed", _probePassed],
        ["isAuthority", isServer]
    ]
] call IF_fnc_log;

true
