/*
 * Registra una línea estructurada en el RPT local de cada máquina.
 * Entrada: [nivel, módulo, mensaje, contexto].
 * Salida: true si el mensaje fue aceptado; false si la entrada es inválida.
 */
params [
    ["_level", "INFO", [""]],
    ["_module", "CORE", [""]],
    ["_message", "", [""]],
    ["_context", [], [[]]]
];

private _normalizedLevel = toUpper _level;
private _normalizedModule = toUpper _module;
private _allowedLevels = missionNamespace getVariable [
    "IF_logLevels",
    ["TRACE", "DEBUG", "INFO", "WARN", "ERROR", "FATAL"]
];

if !(_normalizedLevel in _allowedLevels) exitWith {
    diag_log format [
        "[IF][LOGGING][ERROR][%1] Nivel de log inválido | %2",
        round diag_tickTime,
        _level
    ];
    false
};

if (_normalizedModule isEqualTo "" || {_message isEqualTo ""}) exitWith {
    diag_log format [
        "[IF][LOGGING][ERROR][%1] Módulo o mensaje vacío",
        round diag_tickTime
    ];
    false
};

private _contextText = if (_context isEqualTo []) then {
    ""
} else {
    format [" | %1", _context]
};

diag_log format [
    "[IF][%1][%2][%3] %4%5",
    _normalizedModule,
    _normalizedLevel,
    round diag_tickTime,
    _message,
    _contextText
];

true
