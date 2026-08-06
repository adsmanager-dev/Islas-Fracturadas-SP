/*
 * Comprueba la forma mínima y los invariantes básicos del estado M1.
 * Entrada opcional: [estado]. Salida: [válido, errores].
 */
params [["_state", missionNamespace getVariable ["IF_campaignState", createHashMap], [createHashMap]]];

private _errors = [];
if (!isServer) exitWith {[false, [["NOT_AUTHORITY"]]]};
private _requiredRoots = [
    "meta", "campaign", "clock", "world", "regions", "sectors",
    "connections", "factions", "forces", "vehicles", "logistics",
    "characters", "roles", "relations", "civilians", "government",
    "helios", "intelligence", "evidence", "knowledge", "missions",
    "events", "progression", "endings"
];

{
    if !(_x in _state) then {
        _errors pushBack ["MISSING_ROOT", _x];
    };
} forEach _requiredRoots;

if !([_state] call IF_fnc_valueIsPersistable) then {
    _errors pushBack ["NON_PERSISTABLE_VALUE"];
};

if ("meta" in _state) then {
    private _meta = _state get "meta";
    if !(_meta isEqualType createHashMap) then {
        _errors pushBack ["INVALID_ROOT_TYPE", "meta", typeName _meta];
    } else {
        if !((_meta getOrDefault ["schemaVersion", -1]) isEqualTo 1) then {
            _errors pushBack ["UNSUPPORTED_SCHEMA", _meta getOrDefault ["schemaVersion", -1]];
        };
        if ((_meta getOrDefault ["stateRevision", -1]) < 0) then {
            _errors pushBack ["INVALID_REVISION", _meta getOrDefault ["stateRevision", -1]];
        };
    };
};

if ("campaign" in _state) then {
    private _campaign = _state get "campaign";
    if !(_campaign isEqualType createHashMap) then {
        _errors pushBack ["INVALID_ROOT_TYPE", "campaign", typeName _campaign];
    } else {
        if !((_campaign getOrDefault ["campaignSide", ""]) in ["BLUE", "RED"]) then {
            _errors pushBack ["INVALID_CAMPAIGN_SIDE", _campaign getOrDefault ["campaignSide", ""]];
        };
    };
};

if ("clock" in _state) then {
    private _clock = _state get "clock";
    if !(_clock isEqualType createHashMap) then {
        _errors pushBack ["INVALID_ROOT_TYPE", "clock", typeName _clock];
    } else {
        if ((_clock getOrDefault ["campaignMinutes", -1]) < 0) then {
            _errors pushBack ["INVALID_CAMPAIGN_TIME", _clock getOrDefault ["campaignMinutes", -1]];
        };
    };
};

private _valid = _errors isEqualTo [];
if ("meta" in _state && {(_state get "meta") isEqualType createHashMap}) then {
    private _meta = _state get "meta";
    _meta set ["isValid", _valid];
    _meta set ["lastValidationErrors", +_errors];
};

[_valid, _errors]
