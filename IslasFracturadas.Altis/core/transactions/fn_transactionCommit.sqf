/* Valida y cierra una transacción. */
params [["_transactionId", "", [""]]];

if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "RUNTIME_MISSING"]};

private _transactions = IF_runtime get "activeTransactions";
if !(_transactionId in _transactions) exitWith {[false, "TRANSACTION_NOT_FOUND"]};
private _transaction = _transactions get _transactionId;
if !((_transaction get "state") isEqualTo "OPEN") exitWith {[false, "TRANSACTION_NOT_OPEN"]};

_transaction set ["state", "VALIDATING"];
private _validation = [] call IF_fnc_stateValidate;
if !(_validation # 0) exitWith {
    _transaction set ["state", "FAILED"];
    _transaction set ["error", "STATE_INVALID"];
    [_transactionId] call IF_fnc_transactionRollback
};

_transaction set ["state", "COMMITTING"];
_transaction set ["state", "COMMITTED"];
_transaction set ["closedAt", diag_tickTime];
_transactions deleteAt _transactionId;
(IF_runtime get "closedTransactions") set [_transactionId, _transaction];

private _paths = (_transaction get "operations") apply {+(_x get "path")};
[
    "IF_EVENT_TRANSACTION_COMMITTED",
    createHashMapFromArray [
        ["transactionId", _transactionId],
        ["module", _transaction get "module"],
        ["paths", _paths]
    ],
    false,
    "TRANSACTION",
    _transactionId
] call IF_fnc_eventPublish;

[true, "COMMITTED"]
