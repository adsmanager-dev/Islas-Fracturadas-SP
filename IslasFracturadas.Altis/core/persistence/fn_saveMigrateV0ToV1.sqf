/* Migra la única fixture legacy admitida: envelope v0 -> v1. */
params ["_legacy"];

if (!isServer) exitWith {[false, createHashMap, "NOT_AUTHORITY"]};
if !(_legacy isEqualType createHashMap) exitWith {[false, createHashMap, "INVALID_TYPE"]};
if ((_legacy getOrDefault ["schemaVersion", _legacy getOrDefault ["version", -1]]) != 0) exitWith {
    [false, createHashMap, "NOT_V0"]
};

private _payload = _legacy getOrDefault ["payload", []];
if (_payload isEqualType createHashMap) then {
    _payload = [_payload] call IF_fnc_serializeValue;
};
private _state = [_payload] call IF_fnc_deserializeValue;
if (isNil "_state" || {!(_state isEqualType createHashMap)}) exitWith {
    [false, createHashMap, "INVALID_V0_PAYLOAD"]
};

private _history = +(_legacy getOrDefault ["migrationHistory", []]);
_history pushBack createHashMapFromArray [
    ["from", 0],
    ["to", 1],
    ["appliedAt", +systemTimeUTC]
];

private _campaign = _state getOrDefault ["campaign", createHashMap];
private _clock = _state getOrDefault ["clock", createHashMap];
private _meta = _state getOrDefault ["meta", createHashMap];
private _migrated = createHashMapFromArray [
    ["format", "IF_SAVE_ENVELOPE"],
    ["schemaVersion", 1],
    ["gameVersion", "0.2.0-m2"],
    ["campaignId", _legacy getOrDefault ["campaignId", _campaign getOrDefault ["campaignId", "IF_MAIN_CAMPAIGN"]]],
    ["campaignSide", _legacy getOrDefault ["campaignSide", _campaign getOrDefault ["campaignSide", "BLUE"]]],
    ["createdAt", +(_legacy getOrDefault ["createdAt", systemTimeUTC])],
    ["strategicTime", _legacy getOrDefault ["strategicTime", _clock getOrDefault ["campaignMinutes", 0]]],
    ["stateRevision", _legacy getOrDefault ["stateRevision", _meta getOrDefault ["stateRevision", 0]]],
    ["migrationHistory", _history],
    ["checksum", [_payload] call IF_fnc_checksumCreate],
    ["payload", _payload]
];

private _validation = [_migrated] call IF_fnc_saveValidate;
if !(_validation # 0) exitWith {[false, createHashMap, "MIGRATED_INVALID"]};
[true, _migrated, ""]
