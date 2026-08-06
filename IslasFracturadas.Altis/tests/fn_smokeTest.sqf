/*
 * Smoke test no destructivo para M0.
 * No crea objetos, no modifica estado de campaña y registra cada comprobación.
 */
private _validIdsResult = [["ALT_W_NERI_PANOCHORI"]] call IF_fnc_validateIds;
private _invalidIdsResult = [["", "DUPLICATE", "DUPLICATE"]] call IF_fnc_validateIds;
private _sectorConfig = missionConfigFile >> "ALT_W_NERI_PANOCHORI";

private _checks = [
    ["function.log", !(isNil { IF_fnc_log })],
    ["function.validateIds", !(isNil { IF_fnc_validateIds })],
    ["bootstrap.preInit", missionNamespace getVariable ["IF_bootstrapPreInitComplete", false]],
    ["bootstrap.postInit", missionNamespace getVariable ["IF_bootstrapPostInitComplete", false]],
    ["config.sectorClass", isClass _sectorConfig],
    ["ids.validAccepted", _validIdsResult # 0],
    ["ids.invalidRejected", !(_invalidIdsResult # 0) && {count (_invalidIdsResult # 1) >= 2}]
];

private _failedChecks = _checks select {!(_x # 1)};
private _passed = _failedChecks isEqualTo [];

{
    private _level = if (_x # 1) then {"INFO"} else {"ERROR"};
    private _result = if (_x # 1) then {"PASS"} else {"FAIL"};
    [_level, "BOOT", format ["Smoke %1: %2", _x # 0, _result]] call IF_fnc_log;
} forEach _checks;

missionNamespace setVariable ["IF_smokeTestResult", [_passed, _checks]];

_passed
