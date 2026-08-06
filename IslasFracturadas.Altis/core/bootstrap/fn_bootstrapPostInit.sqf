/*
 * Inicialización posterior local e idempotente para el esqueleto M0.
 * Valida configuración, selecciona diagnóstico y ejecuta el smoke test.
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

if (_configValidation # 0) then {
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
        ["smokePassed", _smokePassed]
    ]
] call IF_fnc_log;

true
