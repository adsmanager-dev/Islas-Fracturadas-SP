// Islas Fracturadas — insignias de unidad
//
// ESTADO: PROPUESTA. No incluido todavia en description.ext.
// Para activarlo, anadir a description.ext:  #include "ui\cfg\CfgUnitInsignia.hpp"
//
// Las texturas las genera .\tools\Build-Assets.ps1 desde art\identity\*.svg.
// Mientras no existan los .paa, NO incluir este archivo: el motor registraria
// rutas invalidas y ensuciaria el RPT en cada arranque.
//
// LIMITE CONOCIDO (verificado en Biki + foros BI):
//   CfgUnitInsignia funciona desde description.ext, pero en multijugador la ruta
//   de la textura se resuelve distinto en servidor y cliente. Es fiable en SP.
//   Al abrir cooperativo, estas clases deben migrar a un addon con config.cpp.
//   Ver docs/18 (arquitectura SP con preparacion para MP).
//
// Aplicacion en juego:
//   [_unidad, "IF_AZUR1"] call BIS_fnc_setUnitInsignia;

class CfgUnitInsignia
{
    class IF_AZUR1
    {
        displayName = "AZUR-1 «Vanguardia»";
        author = "Equipo Islas Fracturadas";
        texture = "ui\insignia\if_azur1_ca.paa";
        material = "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\default_insignia.rvmat";
        textureVehicle = "";
    };

    class IF_RUBI1
    {
        displayName = "RUBÍ-1 «Bastión»";
        author = "Equipo Islas Fracturadas";
        texture = "ui\insignia\if_rubi1_ca.paa";
        material = "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\default_insignia.rvmat";
        textureVehicle = "";
    };

    class IF_VERDE
    {
        displayName = "Fuerza Verde — Gobierno de Altis";
        author = "Equipo Islas Fracturadas";
        texture = "ui\insignia\if_verde_ca.paa";
        material = "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\default_insignia.rvmat";
        textureVehicle = "";
    };

    class IF_FIA
    {
        displayName = "FIA — Frente de Liberación de Altis";
        author = "Equipo Islas Fracturadas";
        texture = "ui\insignia\if_fia_ca.paa";
        material = "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\default_insignia.rvmat";
        textureVehicle = "";
    };

    // Narrativamente NO debe ser seleccionable como identidad propia del jugador:
    // su funcion es aparecer sobre cadaveres, pintadas y reivindicaciones.
    class IF_FRENTE_NEGRO
    {
        displayName = "Frente Negro — firma «Némesis»";
        author = "Equipo Islas Fracturadas";
        texture = "ui\insignia\if_frente_negro_ca.paa";
        material = "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\default_insignia.rvmat";
        textureVehicle = "";
    };

    class IF_HELIOS
    {
        displayName = "Helios — marca de instalación";
        author = "Equipo Islas Fracturadas";
        texture = "ui\insignia\if_helios_ca.paa";
        material = "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\default_insignia.rvmat";
        textureVehicle = "";
    };
};
