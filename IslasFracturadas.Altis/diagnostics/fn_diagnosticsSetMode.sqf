/*
 * Selecciona el nivel de diagnóstico sin modificar la lógica jugable.
 * Acepta índice 0..3 o nombre OFF/BASIC/DEVELOPER/VERBOSE.
 */
params [
    ["_mode", "BASIC", ["", 0]]
];

private _modes = missionNamespace getVariable [
    "IF_diagnosticsModes",
    ["OFF", "BASIC", "DEVELOPER", "VERBOSE"]
];
private _numericModeIsValid = (
    _mode isEqualType 0
    && {_mode isEqualTo floor _mode}
    && {_mode >= 0}
    && {_mode < count _modes}
);
private _normalizedMode = if (_mode isEqualType 0) then {
    if (_numericModeIsValid) then {_modes # _mode} else {"OFF"}
} else {
    toUpper _mode
};
private _invalidInput = if (_mode isEqualType 0) then {
    !_numericModeIsValid
} else {
    !(_normalizedMode in _modes)
};

if (_invalidInput) then {
    _normalizedMode = "OFF";
    [
        "WARN",
        "BOOT",
        "Modo de diagnóstico inválido; se utiliza OFF",
        [["received", _mode]]
    ] call IF_fnc_log;
};

missionNamespace setVariable ["IF_diagnosticsMode", _normalizedMode];

[
    "INFO",
    "BOOT",
    "Modo de diagnóstico configurado",
    [["mode", _normalizedMode]]
] call IF_fnc_log;

_normalizedMode
