/*
 * Solicita una única reproducción local de la música de apertura.
 * No modifica volumen, estado de campaña ni autoridad de red.
 */
if (!hasInterface) exitWith {
    true
};

if (missionNamespace getVariable ["IF_introMusicRequested", false]) exitWith {
    true
};

private _trackId = "IF_Voces_Partidas_La_Isla_Hablara";
private _trackConfig = missionConfigFile >> "CfgMusic" >> _trackId;
if !(isClass _trackConfig) exitWith {
    ["ERROR", "PRESENTATION", "No existe la pista de apertura en CfgMusic", [["track", _trackId]]] call IF_fnc_log;
    false
};

missionNamespace setVariable ["IF_introMusicRequested", true];

[_trackId] spawn {
    params ["_trackId"];

    waitUntil {
        uiSleep 0.1;
        !isNull (findDisplay 46)
    };

    playMusic _trackId;
    missionNamespace setVariable ["IF_introMusicStarted", true];
    ["INFO", "PRESENTATION", "Música de apertura iniciada", [["track", _trackId]]] call IF_fnc_log;
};

true