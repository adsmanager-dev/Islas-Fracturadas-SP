/* Construye un envelope v1 sin modificar el estado canónico. */
params [["_state", missionNamespace getVariable ["IF_campaignState", createHashMap], [createHashMap]]];

if (!isServer) exitWith {[false, createHashMap, "NOT_AUTHORITY"]};
private _copy = [_state] call IF_fnc_valueClone;
private _stateValidation = [_copy] call IF_fnc_stateValidate;
if !(_stateValidation # 0) exitWith {[false, createHashMap, "INVALID_STATE"]};

private _meta = _copy get "meta";
_meta set ["campaignVersion", "0.3.0-m3-dev"];
_meta set ["buildId", "M3_WORLD_GRAPH_DEV"];
_meta set ["updatedAt", diag_tickTime];
_meta set ["checksum", ""];

private _payload = [_copy] call IF_fnc_serializeValue;
private _campaign = _copy get "campaign";
private _clock = _copy get "clock";
private _envelope = createHashMapFromArray [
    ["format", "IF_SAVE_ENVELOPE"],
    ["schemaVersion", 1],
    ["gameVersion", "0.3.0-m3-dev"],
    ["campaignId", _campaign getOrDefault ["campaignId", ""]],
    ["campaignSide", _campaign getOrDefault ["campaignSide", ""]],
    ["createdAt", +systemTimeUTC],
    ["strategicTime", _clock getOrDefault ["campaignMinutes", 0]],
    ["stateRevision", _meta getOrDefault ["stateRevision", 0]],
    ["migrationHistory", +(_meta getOrDefault ["migrationHistory", []])],
    ["checksum", [_payload] call IF_fnc_checksumCreate],
    ["payload", _payload]
];

[true, _envelope, ""]
