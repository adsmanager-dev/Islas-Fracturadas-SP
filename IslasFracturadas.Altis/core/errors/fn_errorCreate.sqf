/*
 * Construye y, por defecto, registra un error estructurado.
 * Entrada: [código, clasificación, módulo, mensaje, contexto, registrar].
 */
params [
    ["_code", "IF_ERR_UNKNOWN", [""]],
    ["_classification", "RECOVERABLE", [""]],
    ["_module", "CORE", [""]],
    ["_message", "Error sin descripción", [""]],
    ["_context", [], [[]]],
    ["_record", true, [true]]
];

private _allowed = ["INFO", "WARNING", "RECOVERABLE", "CRITICAL", "FATAL"];
private _normalizedClassification = toUpper _classification;
if !(_normalizedClassification in _allowed) then {
    _normalizedClassification = "RECOVERABLE";
};

private _errorId = if !(isNil {missionNamespace getVariable "IF_runtime"}) then {
    ["ERR"] call IF_fnc_idGenerateRuntime
} else {
    format ["IF_ERR_BOOT_%1", round (diag_tickTime * 1000)]
};

private _error = createHashMapFromArray [
    ["id", _errorId],
    ["code", _code],
    ["classification", _normalizedClassification],
    ["module", toUpper _module],
    ["message", _message],
    ["context", [_context] call IF_fnc_valueClone],
    ["createdAt", diag_tickTime],
    ["isCritical", _normalizedClassification in ["CRITICAL", "FATAL"]]
];

if (_record) then {
    if !(isNil {missionNamespace getVariable "IF_runtime"}) then {
        private _errors = IF_runtime get "errors";
        _errors pushBack _error;
        if (count _errors > 100) then {
            _errors deleteAt 0;
        };
        if (_error get "isCritical") then {
            IF_runtime set ["degraded", true];
        };
    };

    private _logLevel = switch (_normalizedClassification) do {
        case "INFO": {"INFO"};
        case "WARNING": {"WARN"};
        case "RECOVERABLE": {"WARN"};
        default {"ERROR"};
    };
    [_logLevel, _module, format ["%1: %2", _code, _message], _context] call IF_fnc_log;
};

_error
