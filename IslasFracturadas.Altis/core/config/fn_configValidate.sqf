/* Valida la forma mínima de IF_config sin modificarla. */
params [["_config", missionNamespace getVariable ["IF_config", createHashMap], [createHashMap]]];

private _errors = [];
private _requiredRoots = [
    "factions", "resources", "sectors", "unitCatalog", "moduleCatalog",
    "compositionCatalog", "missionTemplates", "characters", "balance"
];
{
    if !(_x in _config) then {_errors pushBack ["MISSING_CONFIG_ROOT", _x];};
} forEach _requiredRoots;

if ("sectors" in _config) then {
    private _sectors = _config get "sectors";
    if !(_sectors isEqualType createHashMap) then {
        _errors pushBack ["INVALID_SECTORS_TYPE", typeName _sectors];
    } else {
        private _ids = keys _sectors;
        private _idValidation = [_ids] call IF_fnc_validateIds;
        if !(_idValidation # 0) then {_errors append (_idValidation # 1);};
        {
            private _sector = _sectors get _x;
            private _beachhead = _sector getOrDefault ["blueBeachhead", createHashMap];
            {
                private _position = _beachhead getOrDefault [_x, []];
                if (count _position != 3) then {
                    _errors pushBack ["INVALID_POSITION", _sector get "id", _x];
                };
            } forEach ["landingAlpha", "landingBravo", "landingCharlie", "fobCandidate", "logisticsEntry"];
        } forEach _ids;
    };
};

[_errors isEqualTo [], _errors]
