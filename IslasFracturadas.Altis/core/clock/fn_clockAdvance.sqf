/*
 * Avanza de forma autoritativa el reloj narrativo M1.
 * Entrada: [minutos, transactionId].
 */
params [["_minutes", 0, [0]], ["_transactionId", "", [""]]];

if (!isServer) exitWith {[false, "NOT_AUTHORITY"]};
if (_minutes <= 0 || {_minutes != floor _minutes}) exitWith {[false, "INVALID_MINUTES"]};
if (isNil {missionNamespace getVariable "IF_campaignState"}) exitWith {[false, "STATE_MISSING"]};

private _clock = IF_campaignState get "clock";
private _campaignMinutes = (_clock get "campaignMinutes") + _minutes;
private _dayMinutes = ((_clock get "hour") * 60) + (_clock get "minute") + _minutes;
private _dayAdvance = floor (_dayMinutes / 1440);
private _minuteOfDay = _dayMinutes mod 1440;
private _newHour = floor (_minuteOfDay / 60);
private _newMinute = _minuteOfDay mod 60;
private _newDay = (_clock get "day") + _dayAdvance;

private _changes = [
    [["clock", "campaignMinutes"], _campaignMinutes],
    [["clock", "day"], _newDay],
    [["clock", "hour"], _newHour],
    [["clock", "minute"], _newMinute]
];
private _success = true;
{
    private _result = [_x # 0, _x # 1, _transactionId] call IF_fnc_stateCommandSet;
    if !(_result # 0) exitWith {_success = false;};
} forEach _changes;

if (!_success) exitWith {[false, "STATE_COMMAND_FAILED"]};

if (_transactionId isEqualTo "") then {
    [
        "IF_EVENT_CAMPAIGN_TIME_ADVANCED",
        createHashMapFromArray [
            ["minutes", _minutes],
            ["campaignMinutes", _campaignMinutes]
        ],
        false,
        "CLOCK",
        "IF_MAIN_CAMPAIGN"
    ] call IF_fnc_eventPublish;
};

[true, _campaignMinutes]
