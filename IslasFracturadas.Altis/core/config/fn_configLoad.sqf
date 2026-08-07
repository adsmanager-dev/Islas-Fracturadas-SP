/*
 * Materializa la configuración declarativa M3 desde missionConfigFile.
 * IF_config es local e inmutable por convención tras esta carga.
 * Salida: [éxito, configuración, creada].
 */
if !(isNil {missionNamespace getVariable "IF_config"}) exitWith {
    [true, missionNamespace getVariable "IF_config", false]
};

private _regionsRoot = missionConfigFile >> "IF_Regions";
private _sectorsRoot = missionConfigFile >> "IF_Sectors";
private _connectionsRoot = missionConfigFile >> "IF_Connections";
if !(isClass _regionsRoot && {isClass _sectorsRoot} && {isClass _connectionsRoot}) exitWith {
    [false, createHashMap, false]
};

private _regions = createHashMap;
{
    private _id = getText (_x >> "id");
    _regions set [_id, createHashMapFromArray [
        ["id", _id],
        ["regionCode", getText (_x >> "regionCode")],
        ["displayName", getText (_x >> "displayName")],
        ["sectorIds", getArray (_x >> "sectorIds")],
        ["validationStatus", getText (_x >> "validationStatus")]
    ]];
} forEach ("true" configClasses _regionsRoot);

private _sectors = createHashMap;
{
    private _sectorClass = _x;
    private _id = getText (_sectorClass >> "id");
    private _sector = createHashMapFromArray [
        ["id", _id],
        ["regionId", getText (_sectorClass >> "regionId")],
        ["displayName", getText (_sectorClass >> "displayName")],
        ["sectorType", getText (_sectorClass >> "sectorType")],
        ["positionATL", getArray (_sectorClass >> "positionATL")],
        ["radius", getNumber (_sectorClass >> "radius")],
        ["connectionIds", getArray (_sectorClass >> "connectionIds")],
        ["initialMilitaryOwner", getText (_sectorClass >> "initialMilitaryOwner")],
        ["structuralLevel", getNumber (_sectorClass >> "structuralLevel")],
        ["maxStructuralLevel", getNumber (_sectorClass >> "maxStructuralLevel")],
        ["fortificationLevel", getNumber (_sectorClass >> "fortificationLevel")],
        ["strategicRole", getText (_sectorClass >> "strategicRole")],
        ["anchorId", getText (_sectorClass >> "anchorId")],
        ["anchorPositionATL", getArray (_sectorClass >> "anchorPositionATL")],
        ["anchorStatus", getText (_sectorClass >> "anchorStatus")],
        ["validationStatus", getText (_sectorClass >> "validationStatus")],
        ["designStatus", getText (_sectorClass >> "designStatus")]
    ];

    private _beachhead = _sectorClass >> "BlueBeachhead";
    if (isClass _beachhead) then {
        _sector set ["blueBeachhead", createHashMapFromArray [
            ["landingAlpha", getArray (_beachhead >> "landingAlpha")],
            ["landingBravo", getArray (_beachhead >> "landingBravo")],
            ["landingCharlie", getArray (_beachhead >> "landingCharlie")],
            ["fobCandidate", getArray (_beachhead >> "fobCandidate")],
            ["logisticsEntry", getArray (_beachhead >> "logisticsEntry")],
            ["lightVehicleRouteValidated", getNumber (_beachhead >> "lightVehicleRouteValidated") isEqualTo 1],
            ["heavyVehicleRouteValidated", getNumber (_beachhead >> "heavyVehicleRouteValidated") isEqualTo 1],
            ["convoyRouteValidated", getNumber (_beachhead >> "convoyRouteValidated") isEqualTo 1],
            ["maritimeRouteValidated", getNumber (_beachhead >> "maritimeRouteValidated") isEqualTo 1],
            ["moduleFootprintValidated", getNumber (_beachhead >> "moduleFootprintValidated") isEqualTo 1],
            ["dominantHeightsValidated", getNumber (_beachhead >> "dominantHeightsValidated") isEqualTo 1]
        ]];
    };

    _sectors set [_id, _sector];
} forEach ("true" configClasses _sectorsRoot);

private _connections = createHashMap;
{
    private _id = getText (_x >> "id");
    _connections set [_id, createHashMapFromArray [
        ["id", _id],
        ["from", getText (_x >> "from")],
        ["to", getText (_x >> "to")],
        ["connectionType", getText (_x >> "connectionType")],
        ["designStatus", getText (_x >> "designStatus")],
        ["validationStatus", getText (_x >> "validationStatus")]
    ]];
} forEach ("true" configClasses _connectionsRoot);

private _factions = createHashMap;
{
    _factions set [_x, createHashMapFromArray [["id", _x]]];
} forEach ["FAC_BLUE", "FAC_GREEN", "FAC_RED", "FAC_FIA", "FAC_NONE"];

private _config = createHashMapFromArray [
    ["factions", _factions],
    ["resources", createHashMap],
    ["regions", _regions],
    ["sectors", _sectors],
    ["connections", _connections],
    ["unitCatalog", createHashMap],
    ["moduleCatalog", createHashMap],
    ["compositionCatalog", createHashMap],
    ["missionTemplates", createHashMap],
    ["characters", createHashMap],
    ["balance", createHashMap]
];

missionNamespace setVariable ["IF_config", _config];
[true, _config, true]
