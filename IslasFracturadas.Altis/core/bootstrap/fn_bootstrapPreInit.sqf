/*
 * Inicialización temprana local e idempotente.
 * No crea objetos ni inicia sistemas jugables.
 */
if (missionNamespace getVariable ["IF_bootstrapPreInitComplete", false]) exitWith {
    true
};

missionNamespace setVariable [
    "IF_logLevels",
    ["TRACE", "DEBUG", "INFO", "WARN", "ERROR", "FATAL"]
];
missionNamespace setVariable [
    "IF_diagnosticsModes",
    ["OFF", "BASIC", "DEVELOPER", "VERBOSE"]
];
missionNamespace setVariable ["IF_bootstrapPhase", "PHASE_00_PREINIT"];
missionNamespace setVariable ["IF_bootstrapPreInitComplete", true];

[
    "INFO",
    "BOOT",
    "preInit completado",
    [
        ["phase", "PHASE_00_PREINIT"],
        ["isServer", isServer],
        ["hasInterface", hasInterface]
    ]
] call IF_fnc_log;

true
