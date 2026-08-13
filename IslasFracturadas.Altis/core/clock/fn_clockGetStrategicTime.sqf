/* Query del tiempo estratégico persistente en minutos. */
private _result = [["clock", "campaignMinutes"]] call IF_fnc_stateQueryGet;
if !(_result # 0) exitWith {-1};
_result # 1
