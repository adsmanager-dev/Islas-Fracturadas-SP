/*
 * Crea el contenedor operativo no persistente de M1.
 * Solo la autoridad puede instalarlo; llamadas repetidas son idempotentes.
 * Salida: [éxito, runtime, creado].
 */
if (!isServer) exitWith {
    ["WARN", "STATE", "Un cliente intentó crear IF_runtime"] call IF_fnc_log;
    [false, createHashMap, false]
};

if !(isNil {missionNamespace getVariable "IF_runtime"}) exitWith {
    [true, missionNamespace getVariable "IF_runtime", false]
};

private _runtime = createHashMapFromArray [
    ["bootstrap", createHashMap],
    ["scheduler", createHashMap],
    ["activeTransactions", createHashMap],
    ["closedTransactions", createHashMap],
    ["eventSubscribers", createHashMap],
    ["processedEvents", createHashMap],
    ["eventQueue", []],
    ["runtimeIds", createHashMap],
    ["errors", []],
    ["materializedEntities", createHashMap],
    ["sectorDepth", createHashMap],
    ["uiSubscribers", []],
    ["networkClients", createHashMap],
    ["debugFlags", createHashMap],
    ["storageAdapter", "STORAGE_PROFILE_NAMESPACE"],
    ["testStorage", createHashMap],
    ["storageLastError", ""],
    ["materializationInProgress", false],
    ["ownershipConfirmed", true],
    ["degraded", false]
];

missionNamespace setVariable ["IF_runtime", _runtime];
["INFO", "STATE", "IF_runtime creado", [["isServer", isServer]]] call IF_fnc_log;

[true, _runtime, true]
