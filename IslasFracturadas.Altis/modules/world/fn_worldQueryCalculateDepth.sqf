/* Query BFS: calcula profundidad lógica desde uno o varios sectores fuente. */
params [["_sourceSectorIds", [], [[]]]];

if (isNil {missionNamespace getVariable "IF_campaignState"}) exitWith {
    [false, createHashMap, "STATE_MISSING"]
};
if (_sourceSectorIds isEqualTo []) then {
    private _graph = (IF_campaignState getOrDefault ["world", createHashMap]) getOrDefault ["graph", createHashMap];
    _sourceSectorIds = +(_graph getOrDefault ["depthSourceSectorIds", []]);
};
if (_sourceSectorIds isEqualTo []) exitWith {[false, createHashMap, "NO_DEPTH_SOURCES"]};

private _depth = createHashMap;
private _queue = [];
private _sourcesValid = true;
{
    private _sectorResult = [_x] call IF_fnc_worldQueryGetSector;
    if !(_sectorResult # 0) then {
        _sourcesValid = false;
    } else {
        if !(_x in _depth) then {
            _depth set [_x, 0];
            _queue pushBack _x;
        };
    };
} forEach _sourceSectorIds;
if (!_sourcesValid) exitWith {[false, createHashMap, "INVALID_DEPTH_SOURCE"]};

while {count _queue > 0} do {
    private _current = _queue deleteAt 0;
    private _currentDepth = _depth get _current;
    private _neighborsResult = [_current] call IF_fnc_worldQueryGetNeighbors;
    if (_neighborsResult # 0) then {
        {
            private _neighborId = _x # 0;
            if !(_neighborId in _depth) then {
                _depth set [_neighborId, _currentDepth + 1];
                _queue pushBack _neighborId;
            };
        } forEach (_neighborsResult # 1);
    };
};

[true, _depth, ""]
