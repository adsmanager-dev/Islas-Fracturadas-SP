/* Suite M2 aislada: usa almacenamiento en memoria y restaura el estado real. */
if (!isServer) exitWith {false};

private _checks = [];
private _originalState = [IF_campaignState] call IF_fnc_valueClone;
private _originalAdapter = IF_runtime getOrDefault ["storageAdapter", "STORAGE_PROFILE_NAMESPACE"];
private _originalMemory = IF_runtime getOrDefault ["testStorage", createHashMap];

IF_runtime set ["storageAdapter", "STORAGE_TEST_MEMORY"];
IF_runtime set ["testStorage", createHashMap];

private _baseMarker = [["progression", "m2Fixture"], "BASE"] call IF_fnc_stateCommandSet;
private _saveA = ["AUTO"] call IF_fnc_saveCampaign;
private _slotA = _saveA param [1, ""];

private _markerV1 = [["progression", "m2Fixture"], "V1"] call IF_fnc_stateCommandSet;
private _saveB = ["AUTO"] call IF_fnc_saveCampaign;
private _slotB = _saveB param [1, ""];

private _markerV2 = [["progression", "m2Fixture"], "V2"] call IF_fnc_stateCommandSet;
private _saveA2 = ["AUTO"] call IF_fnc_saveCampaign;
private _slots = [] call IF_fnc_storageList;
_checks pushBack [
    "save.abRotation",
    (_baseMarker # 0) && {_saveA # 0} && {_slotA isEqualTo "IF_MAIN_CAMPAIGN_AUTOSAVE_A"}
    && {_markerV1 # 0} && {_saveB # 0} && {_slotB isEqualTo "IF_MAIN_CAMPAIGN_AUTOSAVE_B"}
    && {_markerV2 # 0} && {_saveA2 # 0}
    && {"IF_MAIN_CAMPAIGN_AUTOSAVE_A" in _slots}
    && {"IF_MAIN_CAMPAIGN_AUTOSAVE_B" in _slots}
];

private _mutateAfterSave = [["progression", "m2Fixture"], "UNSAVED"] call IF_fnc_stateCommandSet;
private _loadLatest = [] call IF_fnc_loadCampaign;
private _latestMarker = [["progression", "m2Fixture"]] call IF_fnc_stateQueryGet;
_checks pushBack [
    "load.latest",
    (_mutateAfterSave # 0) && {_loadLatest # 0} && {_latestMarker # 0} && {(_latestMarker # 1) isEqualTo "V2"}
];

private _readA = ["IF_MAIN_CAMPAIGN_AUTOSAVE_A"] call IF_fnc_storageLoad;
private _corruptA = if (_readA # 0) then {
    private _broken = [_readA # 1] call IF_fnc_valueClone;
    _broken set ["checksum", "CORRUPTED_BY_M2_TEST"];
    ["IF_MAIN_CAMPAIGN_AUTOSAVE_A", _broken] call IF_fnc_storageSave
} else {
    [false]
};
private _recovery = [] call IF_fnc_loadCampaign;
private _recoveredMarker = [["progression", "m2Fixture"]] call IF_fnc_stateQueryGet;
_checks pushBack [
    "recovery.corruptAFallsBackB",
    (_corruptA # 0) && {_recovery # 0} && {_recovery # 3}
    && {(_recovery # 2) isEqualTo "IF_MAIN_CAMPAIGN_AUTOSAVE_B"}
    && {_recoveredMarker # 0} && {(_recoveredMarker # 1) isEqualTo "V1"}
];

private _manual = ["MANUAL"] call IF_fnc_saveCampaign;
private _manualRead = ["IF_MAIN_CAMPAIGN_MANUAL_1"] call IF_fnc_storageLoad;
private _manualValidation = if (_manualRead # 0) then {
    [_manualRead # 1] call IF_fnc_saveValidate
} else {
    [false]
};
_checks pushBack ["save.manual", (_manual # 0) && {_manualValidation # 0}];

private _transaction = ["M2_TEST", "IF_TX_M2_SAVE_BLOCK"] call IF_fnc_transactionBegin;
private _blockedSave = ["AUTO"] call IF_fnc_saveCampaign;
private _rollback = ["IF_TX_M2_SAVE_BLOCK"] call IF_fnc_transactionRollback;
_checks pushBack [
    "save.openTransactionRejected",
    (_transaction # 0) && {!(_blockedSave # 0)} && {(_blockedSave # 2) isEqualTo "OPEN_TRANSACTION"} && {_rollback # 0}
];

private _incomplete = [IF_campaignState] call IF_fnc_valueClone;
_incomplete deleteAt "clock";
private _incompleteSnapshot = [_incomplete] call IF_fnc_saveCreateSnapshot;
_checks pushBack ["save.incompleteStateRejected", !(_incompleteSnapshot # 0)];

private _legacy = createHashMapFromArray [
    ["version", 0],
    ["campaignId", "IF_MAIN_CAMPAIGN"],
    ["campaignSide", "BLUE"],
    ["payload", [_originalState] call IF_fnc_serializeValue]
];
private _migration = [_legacy] call IF_fnc_saveMigrate;
private _migrationAgain = if (_migration # 0) then {
    [_migration # 1] call IF_fnc_saveMigrate
} else {
    [false]
};
private _migrationValidation = if (_migration # 0) then {
    [_migration # 1] call IF_fnc_saveValidate
} else {
    [false]
};
_checks pushBack [
    "migration.v0ToV1Idempotent",
    (_migration # 0) && {_migration # 2} && {_migrationValidation # 0}
    && {_migrationAgain # 0} && {!(_migrationAgain # 2)}
    && {((_migrationAgain # 1) get "checksum") isEqualTo ((_migration # 1) get "checksum")}
];

IF_runtime set ["testStorage", createHashMap];
private _legacyWrite = ["IF_MAIN_CAMPAIGN_CHECKPOINT", _legacy] call IF_fnc_storageSave;
private _legacyLoad = [] call IF_fnc_loadCampaign;
private _legacyKeys = [] call IF_fnc_storageList;
_checks pushBack [
    "migration.preservesOriginal",
    (_legacyWrite # 0) && {_legacyLoad # 0} && {_legacyLoad # 4}
    && {"IF_MAIN_CAMPAIGN_CHECKPOINT_PRE_MIGRATION_V0" in _legacyKeys}
    && {"IF_MAIN_CAMPAIGN_CHECKPOINT_MIGRATED_V1" in _legacyKeys}
];

missionNamespace setVariable ["IF_campaignState", _originalState];
IF_runtime set ["storageAdapter", _originalAdapter];
IF_runtime set ["testStorage", _originalMemory];
[] call IF_fnc_runtimeRebuildAfterLoad;

private _failedChecks = _checks select {!(_x # 1)};
private _passed = _failedChecks isEqualTo [];
{
    private _level = if (_x # 1) then {"INFO"} else {"ERROR"};
    private _result = if (_x # 1) then {"PASS"} else {"FAIL"};
    [_level, "TEST", format ["M2 %1: %2", _x # 0, _result]] call IF_fnc_log;
} forEach _checks;

missionNamespace setVariable ["IF_m2PersistenceTestResult", [_passed, _checks]];
_passed
