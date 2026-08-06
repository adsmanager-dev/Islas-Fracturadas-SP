/*
 * Materializa la configuración mínima M1 desde missionConfigFile.
 * IF_config es local e inmutable por convención tras esta carga.
 */
if !(isNil {missionNamespace getVariable "IF_config"}) exitWith {
    [true, missionNamespace getVariable "IF_config", false]
};

private _sectorClass = missionConfigFile >> "ALT_W_NERI_PANOCHORI";
if !(isClass _sectorClass) exitWith {[false, createHashMap, false]};

private _beachhead = _sectorClass >> "BlueBeachhead";
private _sectorId = getText (_sectorClass >> "id");
private _sector = createHashMapFromArray [
    ["id", _sectorId],
    ["validationStatus", getText (_sectorClass >> "validationStatus")],
    ["blueBeachhead", createHashMapFromArray [
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
    ]]
];

private _sectors = createHashMapFromArray [[_sectorId, _sector]];
private _config = createHashMapFromArray [
    ["factions", createHashMap],
    ["resources", createHashMap],
    ["sectors", _sectors],
    ["unitCatalog", createHashMap],
    ["moduleCatalog", createHashMap],
    ["compositionCatalog", createHashMap],
    ["missionTemplates", createHashMap],
    ["characters", createHashMap],
    ["balance", createHashMap]
];

missionNamespace setVariable ["IF_config", _config];
[true, _config, true]
