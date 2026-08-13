/* Valida el contrato persistente y la conectividad del grafo M3. */
params [["_state", missionNamespace getVariable ["IF_campaignState", createHashMap], [createHashMap]]];

if (!isServer) exitWith {[false, [["NOT_AUTHORITY"]]]};
private _errors = [];
private _regions = _state getOrDefault ["regions", objNull];
private _sectors = _state getOrDefault ["sectors", objNull];
private _connections = _state getOrDefault ["connections", objNull];

{
    if !((_x # 1) isEqualType createHashMap) then {
        _errors pushBack ["INVALID_WORLD_ROOT_TYPE", _x # 0, typeName (_x # 1)];
    };
} forEach [["regions", _regions], ["sectors", _sectors], ["connections", _connections]];

if (_regions isEqualType createHashMap && {_sectors isEqualType createHashMap} && {_connections isEqualType createHashMap}) then {
    private _expectedSectorIds = [
        "ALT_W_NERI_PANOCHORI", "ALT_W_AGIOS_DIONYSIOS",
        "ALT_CW_STAVROS_WHISKEY", "ALT_CW_LAKKA", "ALT_CW_AAC",
        "ALT_CW_POLIAKKO_THERISA", "ALT_CW_XIROLIMNI_ZAROS",
        "ALT_C_AIRPORT_WEST", "ALT_C_AIRPORT_TERMINAL"
    ];
    private _sectorIds = keys _sectors;
    private _connectionIds = keys _connections;
    private _idValidation = [(keys _regions) + _sectorIds + _connectionIds] call IF_fnc_validateIds;
    if !(_idValidation # 0) then {_errors append (_idValidation # 1);};
    if ((count _sectorIds) != 9) then {_errors pushBack ["INVALID_M3_SECTOR_COUNT", count _sectorIds];};
    {
        if !(_x in _sectors) then {_errors pushBack ["MISSING_M3_SECTOR", _x];};
    } forEach _expectedSectorIds;

    {
        private _regionId = _x;
        private _region = _regions get _regionId;
        if !(_region isEqualType createHashMap) then {
            _errors pushBack ["INVALID_REGION_TYPE", _regionId];
        } else {
            if !((_region getOrDefault ["id", ""]) isEqualTo _regionId) then {
                _errors pushBack ["REGION_ID_MISMATCH", _regionId];
            };
            private _regionMembers = _region getOrDefault ["sectorIds", objNull];
            if !(_regionMembers isEqualType []) then {
                _errors pushBack ["INVALID_REGION_MEMBERS", _regionId];
            } else {
                {
                    if !(_x in _sectors) then {
                        _errors pushBack ["REGION_UNKNOWN_SECTOR", _regionId, _x];
                    };
                } forEach _regionMembers;
            };
        };
    } forEach keys _regions;

    {
        private _sectorId = _x;
        private _sector = _sectors get _sectorId;
        if !(_sector isEqualType createHashMap) then {
            _errors pushBack ["INVALID_SECTOR_TYPE", _sectorId];
        } else {
            private _requiredFields = [
                "id", "regionId", "displayName", "sectorType", "positionATL",
                "radius", "connectionIds", "militaryOwner", "militaryControl",
                "contestState", "structuralLevel", "maxStructuralLevel",
                "fortificationLevel", "strategicRole", "flags"
            ];
            {
                if !(_x in _sector) then {_errors pushBack ["SECTOR_MISSING_FIELD", _sectorId, _x];};
            } forEach _requiredFields;
            if !((_sector getOrDefault ["id", ""]) isEqualTo _sectorId) then {
                _errors pushBack ["SECTOR_ID_MISMATCH", _sectorId];
            };
            private _regionId = _sector getOrDefault ["regionId", ""];
            if !(_regionId in _regions) then {
                _errors pushBack ["SECTOR_UNKNOWN_REGION", _sectorId, _regionId];
            } else {
                private _regionMembers = (_regions get _regionId) getOrDefault ["sectorIds", objNull];
                if !(_regionMembers isEqualType []) then {
                    _errors pushBack ["INVALID_REGION_MEMBERS", _regionId];
                } else {
                    if !(_sectorId in _regionMembers) then {
                        _errors pushBack ["REGION_MEMBERSHIP_MISMATCH", _sectorId, _regionId];
                    };
                };
            };
            if !((_sector getOrDefault ["militaryOwner", ""]) in ["FAC_BLUE", "FAC_GREEN", "FAC_RED", "FAC_FIA", "FAC_NONE"]) then {
                _errors pushBack ["INVALID_SECTOR_OWNER", _sectorId];
            };
            private _position = _sector getOrDefault ["positionATL", objNull];
            if !(_position isEqualType []) then {
                _errors pushBack ["INVALID_POSITION_TYPE", _sectorId];
                _position = [];
            };
            if !((count _position) in [0, 3]) then {_errors pushBack ["INVALID_POSITION", _sectorId];};
            private _radius = _sector getOrDefault ["radius", objNull];
            if !(_radius isEqualType 0) then {
                _errors pushBack ["INVALID_RADIUS_TYPE", _sectorId];
                _radius = -1;
            };
            private _flags = _sector getOrDefault ["flags", objNull];
            if !(_flags isEqualType createHashMap) then {
                _errors pushBack ["INVALID_SECTOR_FLAGS", _sectorId];
                _flags = createHashMap;
            };
            private _anchorPosition = _flags getOrDefault ["anchorPositionATL", objNull];
            if !(_anchorPosition isEqualType []) then {
                _errors pushBack ["INVALID_ANCHOR_POSITION_TYPE", _sectorId];
                _anchorPosition = [];
            };
            if !((count _anchorPosition) in [0, 3]) then {_errors pushBack ["INVALID_ANCHOR_POSITION", _sectorId];};
            if ((_flags getOrDefault ["validationStatus", ""]) isEqualTo "VALIDADO_3DEN" && {
                (count _position) != 3
                || {_radius <= 0}
                || {(count _anchorPosition) != 3}
            }) then {
                _errors pushBack ["FALSE_3DEN_VALIDATION", _sectorId];
            };
            private _structural = _sector getOrDefault ["structuralLevel", objNull];
            private _maxStructural = _sector getOrDefault ["maxStructuralLevel", objNull];
            if !(_structural isEqualType 0 && {_maxStructural isEqualType 0}) then {
                _errors pushBack ["INVALID_STRUCTURAL_LEVEL_TYPE", _sectorId];
            } else {
                if (_structural < 0 || {_maxStructural < 0} || {_structural > _maxStructural}) then {
                    _errors pushBack ["INVALID_STRUCTURAL_LEVEL", _sectorId, _structural, _maxStructural];
                };
            };
            private _sectorConnectionIds = _sector getOrDefault ["connectionIds", objNull];
            if !(_sectorConnectionIds isEqualType []) then {
                _errors pushBack ["INVALID_SECTOR_CONNECTIONS", _sectorId];
            } else {
                {
                    if !(_x in _connections) then {
                        _errors pushBack ["SECTOR_UNKNOWN_CONNECTION", _sectorId, _x];
                    };
                } forEach _sectorConnectionIds;
            };
        };
    } forEach _sectorIds;

    private _adjacency = createHashMap;
    {_adjacency set [_x, []];} forEach _sectorIds;
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
            if !(_from in _sectors) then {_errors pushBack ["CONNECTION_UNKNOWN_FROM", _connectionId, _from];};
            if !(_to in _sectors) then {_errors pushBack ["CONNECTION_UNKNOWN_TO", _connectionId, _to];};
            if (_from isEqualTo _to) then {_errors pushBack ["CONNECTION_SELF_LOOP", _connectionId];};
            if !((_connection getOrDefault ["connectionType", ""]) in [
                "ROAD_MAIN", "ROAD_SECONDARY", "TRACK", "SEA_ROUTE", "AIR_ROUTE",
                "POWER_LINE", "COMMUNICATION_LINK", "HELIOS_LINK"
            ]) then {
                _errors pushBack ["INVALID_CONNECTION_KIND", _connectionId];
            };
            if !((_connection getOrDefault ["blocked", objNull]) isEqualType false) then {
                _errors pushBack ["INVALID_CONNECTION_BLOCKED", _connectionId];
            };
            if (_from in _sectors && {_to in _sectors}) then {
                private _fromConnections = (_sectors get _from) getOrDefault ["connectionIds", objNull];
                private _toConnections = (_sectors get _to) getOrDefault ["connectionIds", objNull];
                if !(_fromConnections isEqualType []) then {
                    _errors pushBack ["INVALID_SECTOR_CONNECTIONS", _from];
                } else {
                    if !(_connectionId in _fromConnections) then {
                        _errors pushBack ["CONNECTION_MISSING_FROM_SECTOR", _connectionId, _from];
                    };
                };
                if !(_toConnections isEqualType []) then {
                    _errors pushBack ["INVALID_SECTOR_CONNECTIONS", _to];
                } else {
                    if !(_connectionId in _toConnections) then {
                        _errors pushBack ["CONNECTION_MISSING_TO_SECTOR", _connectionId, _to];
                    };
                };
                if (_fromConnections isEqualType [] && {_toConnections isEqualType []}) then {
                    (_adjacency get _from) pushBackUnique _to;
                    (_adjacency get _to) pushBackUnique _from;
                };
            };
        };
    } forEach _connectionIds;

    if ("ALT_W_NERI_PANOCHORI" in _adjacency) then {
        private _visited = ["ALT_W_NERI_PANOCHORI"];
        private _queue = ["ALT_W_NERI_PANOCHORI"];
        while {count _queue > 0} do {
            private _current = _queue deleteAt 0;
            {
                if !(_x in _visited) then {
                    _visited pushBack _x;
                    _queue pushBack _x;
                };
            } forEach (_adjacency get _current);
        };
        if ((count _visited) != (count _sectorIds)) then {
            _errors pushBack ["WORLD_GRAPH_DISCONNECTED", count _visited, count _sectorIds];
        };
    };
};

[_errors isEqualTo [], _errors]
