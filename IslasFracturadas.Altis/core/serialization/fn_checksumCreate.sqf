/*
 * Checksum Adler-32 textual para detectar corrupción accidental.
 * No pretende ofrecer seguridad criptográfica.
 */
params ["_value"];

private _text = str _value;
private _a = 1;
private _b = 0;
private _bytes = toArray _text;
{
    _a = (_a + _x) mod 65521;
    _b = (_b + _a) mod 65521;
} forEach _bytes;

format ["IFC1-%1-%2-%3", count _bytes, _a, _b]
