/* Registra una operación reversible antes de mutar el estado. */
params [
    ["_transactionId", "", [""]],
    ["_path", [], [[]]],
    ["_oldExists", false, [true]],
    ["_oldValue", objNull]
];

if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "RUNTIME_MISSING"]};

private _transactions = IF_runtime get "activeTransactions";
if !(_transactionId in _transactions) exitWith {[false, "TRANSACTION_NOT_FOUND"]};
private _transaction = _transactions get _transactionId;
if !((_transaction get "state") isEqualTo "OPEN") exitWith {[false, "TRANSACTION_NOT_OPEN"]};

private _operations = _transaction get "operations";
_operations pushBack createHashMapFromArray [
    ["path", +_path],
    ["oldExists", _oldExists],
    ["oldValue", [_oldValue] call IF_fnc_valueClone]
];

[true, count _operations]
