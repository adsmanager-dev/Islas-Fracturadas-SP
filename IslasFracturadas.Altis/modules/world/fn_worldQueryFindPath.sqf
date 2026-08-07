/* Query BFS sobre conexiones no bloqueadas. Salida: [encontrado, ruta, razón]. */
params [
    ["_fromSectorId", "", [""]],
    ["_toSectorId", "", [""]]
];

private _fromResult = [_fromSectorId] call IF_fnc_worldQueryGetSector;
if !(_fromResult # 0) exitWith {[false, [], "FROM_SECTOR_NOT_FOUND"]};
private _toResult = [_toSectorId] call IF_fnc_worldQueryGetSector;
if !(_toResult # 0) exitWith {[false, [], "TO_SECTOR_NOT_FOUND"]};
if (_fromSectorId isEqualTo _toSectorId) exitWith {[true, [_fromSectorId], ""]};

private _visited = [_fromSectorId];
private _queue = [_fromSectorId];
private _parents = createHashMap;
private _found = false;

while {count _queue > 0 && {!_found}} do {
    private _current = _queue deleteAt 0;
    private _neighborsResult = [_current] call IF_fnc_worldQueryGetNeighbors;
    if (_neighborsResult # 0) then {
        {
            private _neighborId = _x # 0;
            if !(_neighborId in _visited) then {
                _visited pushBack _neighborId;
                _parents set [_neighborId, _current];
                if (_neighborId isEqualTo _toSectorId) then {
                    _found = true;
                } else {
                    _queue pushBack _neighborId;
                };
            };
        } forEach (_neighborsResult # 1);
    };
};

if (!_found) exitWith {[false, [], "PATH_NOT_FOUND"]};
private _path = [_toSectorId];
private _cursor = _toSectorId;
while {!(_cursor isEqualTo _fromSectorId)} do {
    _cursor = _parents get _cursor;
    _path pushBack _cursor;
};
reverse _path;
[true, _path, ""]
