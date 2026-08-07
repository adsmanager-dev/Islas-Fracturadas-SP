/* Valida estructura, checksum y payload de un envelope v1. */
params ["_envelope"];

private _errors = [];
if (!isServer) exitWith {[false, [["NOT_AUTHORITY"]], createHashMap]};
if !(_envelope isEqualType createHashMap) exitWith {
    [false, [["INVALID_ENVELOPE_TYPE", typeName _envelope]], createHashMap]
};

private _required = [
    "format", "schemaVersion", "gameVersion", "campaignId", "campaignSide",
    "createdAt", "strategicTime", "stateRevision", "migrationHistory",
    "checksum", "payload"
];
{
    if !(_x in _envelope) then {_errors pushBack ["MISSING_FIELD", _x]};
} forEach _required;

if ((_envelope getOrDefault ["format", ""]) != "IF_SAVE_ENVELOPE") then {
    _errors pushBack ["INVALID_FORMAT"];
};
if ((_envelope getOrDefault ["schemaVersion", -1]) != 1) then {
    _errors pushBack ["UNSUPPORTED_SCHEMA", _envelope getOrDefault ["schemaVersion", -1]];
};
if ((_envelope getOrDefault ["campaignId", ""]) != "IF_MAIN_CAMPAIGN") then {
    _errors pushBack ["INVALID_CAMPAIGN_ID"];
};
if !((_envelope getOrDefault ["campaignSide", ""]) in ["BLUE", "RED"]) then {
    _errors pushBack ["INVALID_CAMPAIGN_SIDE"];
};
if !((_envelope getOrDefault ["createdAt", []]) isEqualType []) then {
    _errors pushBack ["INVALID_CREATED_AT"];
};
if !((_envelope getOrDefault ["strategicTime", -1]) isEqualType 0) then {
    _errors pushBack ["INVALID_STRATEGIC_TIME_TYPE"];
} else {
    if ((_envelope getOrDefault ["strategicTime", -1]) < 0) then {
        _errors pushBack ["INVALID_STRATEGIC_TIME"];
    };
};
if !((_envelope getOrDefault ["stateRevision", -1]) isEqualType 0) then {
    _errors pushBack ["INVALID_STATE_REVISION_TYPE"];
} else {
    if ((_envelope getOrDefault ["stateRevision", -1]) < 0) then {
        _errors pushBack ["INVALID_STATE_REVISION"];
    };
};
if !((_envelope getOrDefault ["migrationHistory", objNull]) isEqualType []) then {
    _errors pushBack ["INVALID_MIGRATION_HISTORY"];
};

private _payload = _envelope getOrDefault ["payload", []];
private _expectedChecksum = [_payload] call IF_fnc_checksumCreate;
if ((_envelope getOrDefault ["checksum", ""]) != _expectedChecksum) then {
    _errors pushBack ["CHECKSUM_MISMATCH"];
};

private _state = [_payload] call IF_fnc_deserializeValue;
if (isNil "_state" || {!(_state isEqualType createHashMap)}) then {
    _errors pushBack ["PAYLOAD_DESERIALIZE_FAILED"];
    _state = createHashMap;
} else {
    private _stateValidation = [_state] call IF_fnc_stateValidate;
    if !(_stateValidation # 0) then {
        _errors pushBack ["INVALID_STATE", _stateValidation # 1];
    };
};

[_errors isEqualTo [], _errors, _state]
