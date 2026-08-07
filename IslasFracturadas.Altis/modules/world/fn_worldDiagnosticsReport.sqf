/* Diagnóstico RPT del grafo M3; no acredita una UI ni validación 3DEN. */
private _depthResult = [] call IF_fnc_worldQueryCalculateDepth;
private _depth = if (_depthResult # 0) then {_depthResult # 1} else {createHashMap};
private _sectors = IF_campaignState getOrDefault ["sectors", createHashMap];
private _connections = IF_campaignState getOrDefault ["connections", createHashMap];
private _summaries = [];
private _calibratedAnchors = 0;

{
    private _sector = _sectors get _x;
    private _flags = _sector getOrDefault ["flags", createHashMap];
    private _anchorReady = (count (_flags getOrDefault ["anchorPositionATL", []])) isEqualTo 3;
    if (_anchorReady) then {_calibratedAnchors = _calibratedAnchors + 1;};
    _summaries pushBack [
        _x,
        _sector getOrDefault ["militaryOwner", ""],
        _depth getOrDefault [_x, -1],
        _flags getOrDefault ["validationStatus", ""],
        _anchorReady
    ];
} forEach keys _sectors;

private _report = [
    ["implementationStatus", ((IF_campaignState getOrDefault ["world", createHashMap]) getOrDefault ["graph", createHashMap]) getOrDefault ["implementationStatus", "MISSING"]],
    ["sectorCount", count _sectors],
    ["connectionCount", count _connections],
    ["calibratedAnchorCount", _calibratedAnchors],
    ["pendingAnchorCount", (count _sectors) - _calibratedAnchors],
    ["depthCalculated", _depthResult # 0],
    ["sectors", _summaries]
];

missionNamespace setVariable ["IF_m3WorldDiagnostics", _report];
["INFO", "WORLD", "Informe de diagnóstico M3", _report] call IF_fnc_log;
_report
