/* Revierte el diario en orden inverso y cierra la transacción. */
params [["_transactionId", "", [""]]];

if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[false, "RUNTIME_MISSING"]};
if (isNil {missionNamespace getVariable "IF_campaignState"}) exitWith {[false, "STATE_MISSING"]};

private _transactions = IF_runtime get "activeTransactions";
if !(_transactionId in _transactions) exitWith {[false, "TRANSACTION_NOT_FOUND"]};
private _transaction = _transactions get _transactionId;
if !((_transaction get "state") in ["OPEN", "VALIDATING", "FAILED"]) exitWith {
    [false, "TRANSACTION_NOT_ROLLBACKABLE"]
};

_transaction set ["state", "ROLLING_BACK"];
private _operations = +(_transaction get "operations");
reverse _operations;
private _rollbackValid = true;

{
    private _path = _x get "path";
    private _parent = IF_campaignState;
    private _lastIndex = (count _path) - 1;
    private _pathValid = count _path >= 2;
    for "_index" from 0 to (_lastIndex - 1) do {
        private _key = _path # _index;
        if !(_parent isEqualType createHashMap) exitWith {_pathValid = false;};
        if !(_key in _parent) exitWith {_pathValid = false;};
        _parent = _parent get _key;
    };

    if (_pathValid && {_parent isEqualType createHashMap}) then {
        private _leaf = _path # _lastIndex;
        if (_x get "oldExists") then {
            _parent set [_leaf, [(_x get "oldValue")] call IF_fnc_valueClone];
        } else {
            _parent deleteAt _leaf;
        };
        private _meta = IF_campaignState get "meta";
        _meta set ["stateRevision", (_meta getOrDefault ["stateRevision", 0]) + 1];
        _meta set ["updatedAt", diag_tickTime];
    } else {
        _rollbackValid = false;
    };
} forEach _operations;

if (_rollbackValid) then {
    _transaction set ["state", "ROLLED_BACK"];
} else {
    _transaction set ["state", "FAILED"];
    _transaction set ["error", "ROLLBACK_PATH_INVALID"];
};
_transaction set ["closedAt", diag_tickTime];
_transactions deleteAt _transactionId;
(IF_runtime get "closedTransactions") set [_transactionId, _transaction];

[
    "IF_EVENT_TRANSACTION_ROLLED_BACK",
    createHashMapFromArray [["transactionId", _transactionId]],
    false,
    "TRANSACTION",
    _transactionId
] call IF_fnc_eventPublish;

[_rollbackValid, _transaction get "state"]
