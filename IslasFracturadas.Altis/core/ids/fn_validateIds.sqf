/*
 * Valida una colección local de IDs estables.
 * Entrada: [ids]. Salida: [válido, errores].
 */
params [
    ["_ids", [], [[]]]
];

private _errors = [];
private _seen = [];

{
    private _id = _x;
    private _index = _forEachIndex;

    if !(_id isEqualType "") then {
        _errors pushBack ["INVALID_TYPE", _index, typeName _id];
    } else {
        if (_id isEqualTo "") then {
            _errors pushBack ["EMPTY_ID", _index];
        } else {
            if (_id in _seen) then {
                _errors pushBack ["DUPLICATE_ID", _id, _index];
            } else {
                _seen pushBack _id;
            };
        };
    };
} forEach _ids;

[_errors isEqualTo [], _errors]
