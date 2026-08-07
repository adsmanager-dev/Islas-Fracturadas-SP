/* Query pura: devuelve [sector vecino, conexión] para aristas transitables. */
params [
    ["_sectorId", "", [""]],
    ["_includeBlocked", false, [true]]
];

private _sectorResult = [_sectorId] call IF_fnc_worldQueryGetSector;
if !(_sectorResult # 0) exitWith {[false, [], _sectorResult # 2]};
private _sector = _sectorResult # 1;
private _connections = IF_campaignState getOrDefault ["connections", createHashMap];
private _neighbors = [];

{
    private _connectionId = _x;
    private _connection = _connections getOrDefault [_connectionId, objNull];
    if (_connection isEqualType createHashMap && {
        _includeBlocked || {!(_connection getOrDefault ["blocked", false])}
    }) then {
        private _from = _connection getOrDefault ["from", ""];
        private _to = _connection getOrDefault ["to", ""];
        private _neighborId = if (_from isEqualTo _sectorId) then {_to} else {
            if (_to isEqualTo _sectorId) then {_from} else {""}
        };
        if !(_neighborId isEqualTo "") then {
            _neighbors pushBackUnique [_neighborId, _connectionId];
        };
    };
} forEach (_sector getOrDefault ["connectionIds", []]);

[true, _neighbors, ""]
