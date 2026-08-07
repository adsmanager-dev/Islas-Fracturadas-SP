/* Lista las claves conocidas por el adaptador seleccionado. */
if (!isServer) exitWith {[]};
if (isNil {missionNamespace getVariable "IF_runtime"}) exitWith {[]};

private _adapter = IF_runtime getOrDefault ["storageAdapter", "STORAGE_PROFILE_NAMESPACE"];
if (_adapter isEqualTo "STORAGE_TEST_MEMORY") exitWith {
    private _result = keys (IF_runtime get "testStorage");
    _result sort true;
    _result
};

private _result = +(missionProfileNamespace getVariable ["IF_STORAGE_INDEX", []]);
_result sort true;
_result
