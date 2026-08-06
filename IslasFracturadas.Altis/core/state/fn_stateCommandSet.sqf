/*
 * Command autoritativo para reemplazar un valor existente del estado.
 * Entrada: [ruta, valor, transactionId]. Salida: [éxito, valor o error].
 */
params [
    ["_path", [], [[]]],
    ["_value", objNull],
    ["_transactionId", "", [""]]
];

if (!isServer) exitWith {
    [false, [
        "IF_ERR_STATE_AUTHORITY", "RECOVERABLE", "STATE",
        "Un cliente intentó modificar el estado canónico"
    ] call IF_fnc_errorCreate]
};
if (isNil {missionNamespace getVariable "IF_campaignState"}) exitWith {
    [false, [
        "IF_ERR_STATE_MISSING", "CRITICAL", "STATE",
        "IF_campaignState no existe"
    ] call IF_fnc_errorCreate]
};
if (count _path < 2 || {_path findIf {!(_x isEqualType "") || {_x isEqualTo ""}} >= 0}) exitWith {
    [false, [
        "IF_ERR_STATE_PATH", "RECOVERABLE", "STATE",
        "La ruta del command no es válida", [["path", _path]]
    ] call IF_fnc_errorCreate]
};
if !([_value] call IF_fnc_valueIsPersistable) exitWith {
    [false, [
        "IF_ERR_STATE_VALUE_TYPE", "RECOVERABLE", "STATE",
        "El valor no es persistible", [["path", _path], ["type", typeName _value]]
    ] call IF_fnc_errorCreate]
};

private _parent = IF_campaignState;
private _pathValid = true;
private _lastIndex = (count _path) - 1;
for "_index" from 0 to (_lastIndex - 1) do {
    private _key = _path # _index;
    if !(_parent isEqualType createHashMap) exitWith {
        _pathValid = false;
    };
    if !(_key in _parent) exitWith {
        _pathValid = false;
    };
    private _next = _parent get _key;
    if !(_next isEqualType createHashMap) exitWith {
        _pathValid = false;
    };
    _parent = _next;
};

if (!_pathValid) exitWith {
    [false, [
        "IF_ERR_STATE_PATH", "RECOVERABLE", "STATE",
        "La ruta no pertenece al estado canónico", [["path", _path]]
    ] call IF_fnc_errorCreate]
};

private _leaf = _path # _lastIndex;
private _oldExists = _leaf in _parent;
private _oldValue = if (_oldExists) then {
    [_parent get _leaf] call IF_fnc_valueClone
} else {
    objNull
};

private _transactionResult = [true];
if !(_transactionId isEqualTo "") then {
    _transactionResult = [
        _transactionId,
        _path,
        _oldExists,
        _oldValue
    ] call IF_fnc_transactionRecord;
};
if !(_transactionResult # 0) exitWith {_transactionResult};

private _storedValue = [_value] call IF_fnc_valueClone;
_parent set [_leaf, _storedValue];

private _meta = IF_campaignState get "meta";
_meta set ["stateRevision", (_meta getOrDefault ["stateRevision", 0]) + 1];
_meta set ["updatedAt", diag_tickTime];

if (_transactionId isEqualTo "" && {!(isNil {missionNamespace getVariable "IF_fnc_eventPublish"})}) then {
    [
        "IF_EVENT_STATE_VALUE_CHANGED",
        createHashMapFromArray [
            ["path", +_path],
            ["transactionId", _transactionId]
        ],
        false,
        "STATE",
        _path # 0
    ] call IF_fnc_eventPublish;
};

[true, [_storedValue] call IF_fnc_valueClone]
