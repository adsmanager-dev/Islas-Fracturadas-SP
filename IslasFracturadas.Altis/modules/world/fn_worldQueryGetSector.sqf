/* Query pura: devuelve una copia de un sector persistente. */
params [["_sectorId", "", [""]]];

if (_sectorId isEqualTo "") exitWith {[false, objNull, "INVALID_SECTOR_ID"]};
private _result = [["sectors", _sectorId]] call IF_fnc_stateQueryGet;
if !(_result # 0) exitWith {[false, objNull, "SECTOR_NOT_FOUND"]};
[true, _result # 1, ""]
