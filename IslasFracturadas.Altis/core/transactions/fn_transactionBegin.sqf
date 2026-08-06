/* Inicia una transacción autoritativa con diario de deshacer. */
params [["_module", "CORE", [""]], ["_transactionId", "", [""]]];

if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "RUNTIME_MISSING"]};
if (_transactionId isEqualTo "") then {
    _transactionId = ["TX"] call IF_fnc_idGenerateRuntime;
};

private _transactions = IF_runtime get "activeTransactions";
if (_transactionId in _transactions) exitWith {[false, "DUPLICATE_TRANSACTION"]};

private _transaction = createHashMapFromArray [
    ["id", _transactionId],
    ["module", toUpper _module],
    ["state", "OPEN"],
    ["operations", []],
    ["reservations", []],
    ["startedAt", diag_tickTime],
    ["closedAt", -1],
    ["error", ""]
];
_transactions set [_transactionId, _transaction];

[true, _transactionId]
