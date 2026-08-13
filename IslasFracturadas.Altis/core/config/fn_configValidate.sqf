/* Valida el grafo declarativo M3 sin modificar IF_config. */
params [["_config", missionNamespace getVariable ["IF_config", createHashMap], [createHashMap]]];

private _errors = [];
private _requiredRoots = [
    "factions", "resources", "regions", "sectors", "connections",
    "unitCatalog", "moduleCatalog", "compositionCatalog", "missionTemplates",
    "characters", "balance"
];
{
    if !(_x in _config) then {_errors pushBack ["MISSING_CONFIG_ROOT", _x];};
} forEach _requiredRoots;

private _regions = _config getOrDefault ["regions", objNull];
private _sectors = _config getOrDefault ["sectors", objNull];
private _connections = _config getOrDefault ["connections", objNull];
private _factions = _config getOrDefault ["factions", objNull];

{
    if !((_x # 1) isEqualType createHashMap) then {
        _errors pushBack ["INVALID_CONFIG_ROOT_TYPE", _x # 0, typeName (_x # 1)];
    };
} forEach [
    ["regions", _regions],
    ["sectors", _sectors],
    ["connections", _connections],
    ["factions", _factions]
];

if (_regions isEqualType createHashMap && {_sectors isEqualType createHashMap} && {_connections isEqualType createHashMap} && {_factions isEqualType createHashMap}) then {
    private _regionIds = keys _regions;
    private _sectorIds = keys _sectors;
    private _connectionIds = keys _connections;
    private _allIds = _regionIds + _sectorIds + _connectionIds;
    private _idValidation = [_allIds] call IF_fnc_validateIds;
    if !(_idValidation # 0) then {_errors append (_idValidation # 1);};

    private _expectedM3Sectors = [
        "ALT_W_NERI_PANOCHORI",
        "ALT_W_AGIOS_DIONYSIOS",
        "ALT_CW_STAVROS_WHISKEY",
        "ALT_CW_LAKKA",
        "ALT_CW_AAC",
        "ALT_CW_POLIAKKO_THERISA",
        "ALT_CW_XIROLIMNI_ZAROS",
        "ALT_C_AIRPORT_WEST",
        "ALT_C_AIRPORT_TERMINAL"
    ];
    if ((count _sectorIds) != 9) then {
        _errors pushBack ["INVALID_M3_SECTOR_COUNT", count _sectorIds];
    };
    {
        if !(_x in _sectors) then {_errors pushBack ["MISSING_M3_SECTOR", _x];};
    } forEach _expectedM3Sectors;

    {
        private _regionId = _x;
        private _region = _regions get _regionId;
        if !(_region isEqualType createHashMap) then {
            _errors pushBack ["INVALID_REGION_TYPE", _regionId];
        } else {
            if !((_region getOrDefault ["id", ""]) isEqualTo _regionId) then {
                _errors pushBack ["REGION_ID_MISMATCH", _regionId];
            };
            private _members = _region getOrDefault ["sectorIds", []];
            if !(_members isEqualType []) then {
                _errors pushBack ["INVALID_REGION_MEMBERS", _regionId];
            } else {
                {
                    if !(_x in _sectors) then {
                        _errors pushBack ["REGION_UNKNOWN_SECTOR", _regionId, _x];
                    };
                } forEach _members;
            };
        };
    } forEach _regionIds;

    {
        private _sectorId = _x;
        private _sector = _sectors get _sectorId;
        if !(_sector isEqualType createHashMap) then {
            _errors pushBack ["INVALID_SECTOR_TYPE", _sectorId];
        } else {
            if !((_sector getOrDefault ["id", ""]) isEqualTo _sectorId) then {
                _errors pushBack ["SECTOR_ID_MISMATCH", _sectorId];
            };
            private _regionId = _sector getOrDefault ["regionId", ""];
            if !(_regionId in _regions) then {
                _errors pushBack ["SECTOR_UNKNOWN_REGION", _sectorId, _regionId];
            } else {
                if !(_sectorId in ((_regions get _regionId) getOrDefault ["sectorIds", []])) then {
                    _errors pushBack ["REGION_MEMBERSHIP_MISMATCH", _sectorId, _regionId];
                };
            };

            private _position = _sector getOrDefault ["positionATL", []];
            private _anchorPosition = _sector getOrDefault ["anchorPositionATL", []];
            private _validationStatus = _sector getOrDefault ["validationStatus", ""];
            if !((count _position) in [0, 3]) then {
                _errors pushBack ["INVALID_POSITION", _sectorId];
            };
            if !((count _anchorPosition) in [0, 3]) then {
                _errors pushBack ["INVALID_ANCHOR_POSITION", _sectorId];
            };
            if (_validationStatus isEqualTo "VALIDADO_3DEN" && {
                (count _position) != 3
                || {(_sector getOrDefault ["radius", -1]) <= 0}
                || {(count _anchorPosition) != 3}
            }) then {
                _errors pushBack ["FALSE_3DEN_VALIDATION", _sectorId];
            };

            private _owner = _sector getOrDefault ["initialMilitaryOwner", ""];
            if !(_owner in (keys _factions)) then {
                _errors pushBack ["UNKNOWN_INITIAL_OWNER", _sectorId, _owner];
            };
            {
                if !(_x in _connections) then {
                    _errors pushBack ["SECTOR_UNKNOWN_CONNECTION", _sectorId, _x];
                };
            } forEach (_sector getOrDefault ["connectionIds", []]);

            private _beachhead = _sector getOrDefault ["blueBeachhead", createHashMap];
            if ((count _beachhead) > 0) then {
                {
                    if ((count (_beachhead getOrDefault [_x, []])) != 3) then {
                        _errors pushBack ["INVALID_BEACHHEAD_POSITION", _sectorId, _x];
                    };
                } forEach ["landingAlpha", "landingBravo", "landingCharlie", "fobCandidate", "logisticsEntry"];
            };
        };
    } forEach _sectorIds;

    {
        private _connectionId = _x;
        private _connection = _connections get _connectionId;
        if !(_connection isEqualType createHashMap) then {
            _errors pushBack ["INVALID_CONNECTION_TYPE", _connectionId];
        } else {
            private _from = _connection getOrDefault ["from", ""];
            private _to = _connection getOrDefault ["to", ""];
            if !((_connection getOrDefault ["id", ""]) isEqualTo _connectionId) then {
                _errors pushBack ["CONNECTION_ID_MISMATCH", _connectionId];
            };
            if !(_from in _sectors) then {
                _errors pushBack ["CONNECTION_UNKNOWN_FROM", _connectionId, _from];
            };
            if !(_to in _sectors) then {
                _errors pushBack ["CONNECTION_UNKNOWN_TO", _connectionId, _to];
            };
            if (_from isEqualTo _to) then {
                _errors pushBack ["CONNECTION_SELF_LOOP", _connectionId];
            };
            if !(_connectionId in ((_sectors getOrDefault [_from, createHashMap]) getOrDefault ["connectionIds", []])) then {
                _errors pushBack ["CONNECTION_MISSING_FROM_SECTOR", _connectionId, _from];
            };
            if !(_connectionId in ((_sectors getOrDefault [_to, createHashMap]) getOrDefault ["connectionIds", []])) then {
                _errors pushBack ["CONNECTION_MISSING_TO_SECTOR", _connectionId, _to];
            };
        };
    } forEach _connectionIds;
};

[_errors isEqualTo [], _errors]
