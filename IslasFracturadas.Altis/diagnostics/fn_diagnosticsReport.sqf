/*
 * Produce un informe no intrusivo en el RPT según el modo seleccionado.
 */
private _mode = missionNamespace getVariable ["IF_diagnosticsMode", "OFF"];

if (_mode isEqualTo "OFF") exitWith {
    []
};

private _report = [
    ["mode", _mode],
    ["phase", missionNamespace getVariable ["IF_bootstrapPhase", "UNKNOWN"]],
    ["preInit", missionNamespace getVariable ["IF_bootstrapPreInitComplete", false]],
    ["postInit", missionNamespace getVariable ["IF_bootstrapPostInitComplete", false]],
    ["smokePassed", missionNamespace getVariable ["IF_smokeTestPassed", false]],
    ["m1Passed", missionNamespace getVariable ["IF_m1CoreTestPassed", false]],
    ["configReady", missionNamespace getVariable ["IF_configReady", false]],
    ["hasCanonicalState", !(isNil {missionNamespace getVariable "IF_campaignState"})]
];

if (_mode in ["DEVELOPER", "VERBOSE"]) then {
    private _sectorConfig = missionConfigFile >> "ALT_W_NERI_PANOCHORI";
    _report append [
        ["sectorId", getText (_sectorConfig >> "id")],
        ["sectorValidationStatus", getText (_sectorConfig >> "validationStatus")],
        ["landingAlpha", getArray (_sectorConfig >> "BlueBeachhead" >> "landingAlpha")],
        ["landingBravo", getArray (_sectorConfig >> "BlueBeachhead" >> "landingBravo")],
        ["landingCharlie", getArray (_sectorConfig >> "BlueBeachhead" >> "landingCharlie")]
    ];
};

if (_mode isEqualTo "VERBOSE") then {
    _report append [
        ["isServer", isServer],
        ["hasInterface", hasInterface],
        ["isMultiplayer", isMultiplayer],
        ["worldName", worldName]
    ];
};

["INFO", "BOOT", "Informe de diagnóstico M1", _report] call IF_fnc_log;

_report
