/* Diagnóstico RPT del grafo M3; no acredita una UI ni validación 3DEN. */
private _depthResult = [] call IF_fnc_worldQueryCalculateDepth;
private _depth = if (_depthResult # 0) then {_depthResult # 1} else {createHashMap};
private _sectors = IF_campaignState getOrDefault ["sectors", createHashMap];
private _connections = IF_campaignState getOrDefault ["connections", createHashMap];
private _summaries = [];
private _placedAnchors = 0;
private _validatedAnchors = 0;

{
    private _sector = _sectors get _x;
    private _flags = _sector getOrDefault ["flags", createHashMap];
    private _anchorPlaced = (count (_flags getOrDefault ["anchorPositionATL", []])) isEqualTo 3;
    private _anchorValidated = (_flags getOrDefault ["anchorStatus", ""]) isEqualTo "VALIDADO_3DEN";
    if (_anchorPlaced) then {_placedAnchors = _placedAnchors + 1;};
    if (_anchorValidated) then {_validatedAnchors = _validatedAnchors + 1;};
    _summaries pushBack [
        _x,
        _sector getOrDefault ["militaryOwner", ""],
        _depth getOrDefault [_x, -1],
        _flags getOrDefault ["validationStatus", ""],
        _anchorPlaced,
        _anchorValidated
    ];
} forEach keys _sectors;

private _report = [
    ["implementationStatus", ((IF_campaignState getOrDefault ["world", createHashMap]) getOrDefault ["graph", createHashMap]) getOrDefault ["implementationStatus", "MISSING"]],
    ["sectorCount", count _sectors],
    ["connectionCount", count _connections],
    ["placedAnchorCount", _placedAnchors],
    ["pendingPlacementCount", (count _sectors) - _placedAnchors],
    ["validatedAnchorCount", _validatedAnchors],
    ["pendingValidationCount", (count _sectors) - _validatedAnchors],
    ["depthCalculated", _depthResult # 0],
    ["sectors", _summaries]
];

missionNamespace setVariable ["IF_m3WorldDiagnostics", _report];
["INFO", "WORLD", "Informe de diagnóstico M3", _report] call IF_fnc_log;
_report
