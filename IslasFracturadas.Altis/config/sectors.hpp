/*
 * Grafo estratégico mínimo M3.
 *
 * Los sectores proceden del catálogo confirmado de 38 sectores. La selección
 * de ALT_W_AGIOS_DIONYSIOS como primer enlace occidental es una propuesta M3.
 * Ninguna posición, radio, conexión física o ancla sin evidencia recibe
 * VALIDADO_3DEN. Los valores -1 y los arrays vacíos significan POR_CALIBRAR.
 */

class IF_Regions
{
    class REG_R1_KAVALA_WEST
    {
        id = "REG_R1_KAVALA_WEST";
        regionCode = "R1";
        displayName = "Kavala occidental";
        sectorIds[] = {"ALT_W_NERI_PANOCHORI"};
        validationStatus = "DISEÑO_CONFIRMADO";
    };

    class REG_R3_AGIOS_CORRIDOR
    {
        id = "REG_R3_AGIOS_CORRIDOR";
        regionCode = "R3";
        displayName = "Corredor de Agios Dionysios";
        sectorIds[] = {"ALT_W_AGIOS_DIONYSIOS", "ALT_CW_LAKKA"};
        validationStatus = "DISEÑO_CONFIRMADO";
    };

    class REG_R4_KATALAKI_NEOCHORI
    {
        id = "REG_R4_KATALAKI_NEOCHORI";
        regionCode = "R4";
        displayName = "Katalaki-Neochori";
        sectorIds[] = {"ALT_CW_STAVROS_WHISKEY"};
        validationStatus = "DISEÑO_CONFIRMADO";
    };

    class REG_R5_SOUTHWEST_BASIN
    {
        id = "REG_R5_SOUTHWEST_BASIN";
        regionCode = "R5";
        displayName = "Cuenca suroccidental";
        sectorIds[] = {"ALT_CW_AAC", "ALT_CW_POLIAKKO_THERISA", "ALT_CW_XIROLIMNI_ZAROS"};
        validationStatus = "DISEÑO_CONFIRMADO";
    };

    class REG_R6_AIRPORT_CENTER
    {
        id = "REG_R6_AIRPORT_CENTER";
        regionCode = "R6";
        displayName = "Centro aeroportuario";
        sectorIds[] = {"ALT_C_AIRPORT_WEST", "ALT_C_AIRPORT_TERMINAL"};
        validationStatus = "DISEÑO_CONFIRMADO";
    };
};

class IF_Sectors
{
    class ALT_W_NERI_PANOCHORI
    {
        id = "ALT_W_NERI_PANOCHORI";
        regionId = "REG_R1_KAVALA_WEST";
        displayName = "Neri-Panochori";
        sectorType = "RURAL_COASTAL_LOGISTICS";
        positionATL[] = {};
        radius = -1;
        connectionIds[] = {"CONN_M3_NERI_AGIOS"};
        initialMilitaryOwner = "FAC_BLUE";
        structuralLevel = 0;
        maxStructuralLevel = 2;
        fortificationLevel = 1;
        strategicRole = "BLUE_BEACHHEAD";
        anchorId = "ANCHOR_M3_NERI_PANOCHORI";
        anchorPositionATL[] = {};
        anchorStatus = "POR_CALIBRAR";
        validationStatus = "VALIDACION_3DEN_EN_CURSO";
        designStatus = "DISEÑO_CONFIRMADO";

        class BlueBeachhead
        {
            landingAlpha[] = {4414.902, 10201.400, 0};
            landingBravo[] = {4527.117, 10163.956, 0};
            landingCharlie[] = {4674.484, 10014.150, 0};
            fobCandidate[] = {4828.627, 10611.693, 0};
            logisticsEntry[] = {4878.441, 10518.442, 0};
            lightVehicleRouteValidated = 1;
            heavyVehicleRouteValidated = 1;
            convoyRouteValidated = 1;
            maritimeRouteValidated = 0;
            moduleFootprintValidated = 0;
            dominantHeightsValidated = 0;
        };
    };

    class ALT_W_AGIOS_DIONYSIOS
    {
        id = "ALT_W_AGIOS_DIONYSIOS";
        regionId = "REG_R3_AGIOS_CORRIDOR";
        displayName = "Agios Dionysios";
        sectorType = "PASS_DEFENSE";
        positionATL[] = {};
        radius = -1;
        connectionIds[] = {"CONN_M3_NERI_AGIOS", "CONN_M3_AGIOS_LAKKA"};
        initialMilitaryOwner = "FAC_GREEN";
        structuralLevel = 0;
        maxStructuralLevel = 3;
        fortificationLevel = 0;
        strategicRole = "WESTERN_CORRIDOR_FIRST_LINK";
        anchorId = "ANCHOR_M3_AGIOS_DIONYSIOS";
        anchorPositionATL[] = {};
        anchorStatus = "POR_CALIBRAR";
        validationStatus = "POR_CALIBRAR";
        designStatus = "PROPUESTA_M3";
    };

    class ALT_CW_STAVROS_WHISKEY
    {
        id = "ALT_CW_STAVROS_WHISKEY";
        regionId = "REG_R4_KATALAKI_NEOCHORI";
        displayName = "Stavros-Whiskey";
        sectorType = "MILITARY_BASE";
        positionATL[] = {};
        radius = -1;
        connectionIds[] = {"CONN_M3_LAKKA_STAVROS", "CONN_M3_STAVROS_POLIAKKO"};
        initialMilitaryOwner = "FAC_GREEN";
        structuralLevel = 3;
        maxStructuralLevel = 4;
        fortificationLevel = 3;
        strategicRole = "GREEN_FORWARD_POSITION";
        anchorId = "ANCHOR_M3_STAVROS_WHISKEY";
        anchorPositionATL[] = {};
        anchorStatus = "POR_CALIBRAR";
        validationStatus = "POR_CALIBRAR";
        designStatus = "DISEÑO_CONFIRMADO";
    };

    class ALT_CW_LAKKA
    {
        id = "ALT_CW_LAKKA";
        regionId = "REG_R3_AGIOS_CORRIDOR";
        displayName = "Lakka";
        sectorType = "CROSSROADS";
        positionATL[] = {};
        radius = -1;
        connectionIds[] = {"CONN_M3_AGIOS_LAKKA", "CONN_M3_LAKKA_STAVROS", "CONN_M3_LAKKA_AAC", "CONN_M3_LAKKA_AIRPORT_WEST"};
        initialMilitaryOwner = "FAC_GREEN";
        structuralLevel = 2;
        maxStructuralLevel = 3;
        fortificationLevel = 2;
        strategicRole = "WEST_CENTER_CHOKEPOINT";
        anchorId = "ANCHOR_M3_LAKKA";
        anchorPositionATL[] = {};
        anchorStatus = "POR_CALIBRAR";
        validationStatus = "POR_CALIBRAR";
        designStatus = "DISEÑO_CONFIRMADO";
    };

    class ALT_CW_AAC
    {
        id = "ALT_CW_AAC";
        regionId = "REG_R5_SOUTHWEST_BASIN";
        displayName = "AAC Airfield";
        sectorType = "LIGHT_AIRFIELD";
        positionATL[] = {};
        radius = -1;
        connectionIds[] = {"CONN_M3_LAKKA_AAC", "CONN_M3_AAC_POLIAKKO"};
        initialMilitaryOwner = "FAC_GREEN";
        structuralLevel = 2;
        maxStructuralLevel = 4;
        fortificationLevel = 2;
        strategicRole = "LIGHT_AIR_OPERATIONS";
        anchorId = "ANCHOR_M3_AAC";
        anchorPositionATL[] = {};
        anchorStatus = "POR_CALIBRAR";
        validationStatus = "POR_CALIBRAR";
        designStatus = "DISEÑO_CONFIRMADO";
    };

    class ALT_CW_POLIAKKO_THERISA
    {
        id = "ALT_CW_POLIAKKO_THERISA";
        regionId = "REG_R5_SOUTHWEST_BASIN";
        displayName = "Poliakko-Therisa";
        sectorType = "RURAL_LOGISTICS";
        positionATL[] = {};
        radius = -1;
        connectionIds[] = {"CONN_M3_STAVROS_POLIAKKO", "CONN_M3_AAC_POLIAKKO", "CONN_M3_POLIAKKO_XIROLIMNI"};
        initialMilitaryOwner = "FAC_GREEN";
        structuralLevel = 1;
        maxStructuralLevel = 2;
        fortificationLevel = 0;
        strategicRole = "SOUTHWEST_FLANK";
        anchorId = "ANCHOR_M3_POLIAKKO_THERISA";
        anchorPositionATL[] = {};
        anchorStatus = "POR_CALIBRAR";
        validationStatus = "POR_CALIBRAR";
        designStatus = "DISEÑO_CONFIRMADO";
    };

    class ALT_CW_XIROLIMNI_ZAROS
    {
        id = "ALT_CW_XIROLIMNI_ZAROS";
        regionId = "REG_R5_SOUTHWEST_BASIN";
        displayName = "Xirolimni-Zaros";
        sectorType = "RURAL_INFRASTRUCTURE";
        positionATL[] = {};
        radius = -1;
        connectionIds[] = {"CONN_M3_POLIAKKO_XIROLIMNI"};
        initialMilitaryOwner = "FAC_GREEN";
        structuralLevel = 1;
        maxStructuralLevel = 3;
        fortificationLevel = 1;
        strategicRole = "WATER_ENERGY_FLANK";
        anchorId = "ANCHOR_M3_XIROLIMNI_ZAROS";
        anchorPositionATL[] = {};
        anchorStatus = "POR_CALIBRAR";
        validationStatus = "POR_CALIBRAR";
        designStatus = "DISEÑO_CONFIRMADO";
    };

    class ALT_C_AIRPORT_WEST
    {
        id = "ALT_C_AIRPORT_WEST";
        regionId = "REG_R6_AIRPORT_CENTER";
        displayName = "Airport West";
        sectorType = "AIRFIELD_BASE";
        positionATL[] = {};
        radius = -1;
        connectionIds[] = {"CONN_M3_LAKKA_AIRPORT_WEST", "CONN_M3_AIRPORT_WEST_TERMINAL"};
        initialMilitaryOwner = "FAC_GREEN";
        structuralLevel = 3;
        maxStructuralLevel = 4;
        fortificationLevel = 3;
        strategicRole = "AIRPORT_WESTERN_BASE";
        anchorId = "ANCHOR_M3_AIRPORT_WEST";
        anchorPositionATL[] = {};
        anchorStatus = "POR_CALIBRAR";
        validationStatus = "POR_CALIBRAR";
        designStatus = "DISEÑO_CONFIRMADO";
    };

    class ALT_C_AIRPORT_TERMINAL
    {
        id = "ALT_C_AIRPORT_TERMINAL";
        regionId = "REG_R6_AIRPORT_CENTER";
        displayName = "Airport Terminal";
        sectorType = "INTERNATIONAL_AIRPORT";
        positionATL[] = {};
        radius = -1;
        connectionIds[] = {"CONN_M3_AIRPORT_WEST_TERMINAL"};
        initialMilitaryOwner = "FAC_GREEN";
        structuralLevel = 4;
        maxStructuralLevel = 4;
        fortificationLevel = 2;
        strategicRole = "OPERATIONAL_HEART";
        anchorId = "ANCHOR_M3_AIRPORT_TERMINAL";
        anchorPositionATL[] = {};
        anchorStatus = "POR_CALIBRAR";
        validationStatus = "POR_CALIBRAR";
        designStatus = "DISEÑO_CONFIRMADO";
    };
};

class IF_Connections
{
    class CONN_M3_NERI_AGIOS
    {
        id = "CONN_M3_NERI_AGIOS";
        from = "ALT_W_NERI_PANOCHORI";
        to = "ALT_W_AGIOS_DIONYSIOS";
        connectionType = "ROAD_SECONDARY";
        designStatus = "PROPUESTA_M3";
        validationStatus = "POR_CALIBRAR";
    };
    class CONN_M3_AGIOS_LAKKA
    {
        id = "CONN_M3_AGIOS_LAKKA";
        from = "ALT_W_AGIOS_DIONYSIOS";
        to = "ALT_CW_LAKKA";
        connectionType = "ROAD_MAIN";
        designStatus = "DISEÑO_CONFIRMADO";
        validationStatus = "POR_CALIBRAR";
    };
    class CONN_M3_LAKKA_STAVROS
    {
        id = "CONN_M3_LAKKA_STAVROS";
        from = "ALT_CW_LAKKA";
        to = "ALT_CW_STAVROS_WHISKEY";
        connectionType = "ROAD_MAIN";
        designStatus = "DISEÑO_CONFIRMADO";
        validationStatus = "POR_CALIBRAR";
    };
    class CONN_M3_LAKKA_AAC
    {
        id = "CONN_M3_LAKKA_AAC";
        from = "ALT_CW_LAKKA";
        to = "ALT_CW_AAC";
        connectionType = "ROAD_SECONDARY";
        designStatus = "PROPUESTA_M3";
        validationStatus = "POR_CALIBRAR";
    };
    class CONN_M3_STAVROS_POLIAKKO
    {
        id = "CONN_M3_STAVROS_POLIAKKO";
        from = "ALT_CW_STAVROS_WHISKEY";
        to = "ALT_CW_POLIAKKO_THERISA";
        connectionType = "ROAD_SECONDARY";
        designStatus = "PROPUESTA_M3";
        validationStatus = "POR_CALIBRAR";
    };
    class CONN_M3_AAC_POLIAKKO
    {
        id = "CONN_M3_AAC_POLIAKKO";
        from = "ALT_CW_AAC";
        to = "ALT_CW_POLIAKKO_THERISA";
        connectionType = "ROAD_SECONDARY";
        designStatus = "PROPUESTA_M3";
        validationStatus = "POR_CALIBRAR";
    };
    class CONN_M3_POLIAKKO_XIROLIMNI
    {
        id = "CONN_M3_POLIAKKO_XIROLIMNI";
        from = "ALT_CW_POLIAKKO_THERISA";
        to = "ALT_CW_XIROLIMNI_ZAROS";
        connectionType = "ROAD_SECONDARY";
        designStatus = "DISEÑO_CONFIRMADO";
        validationStatus = "POR_CALIBRAR";
    };
    class CONN_M3_LAKKA_AIRPORT_WEST
    {
        id = "CONN_M3_LAKKA_AIRPORT_WEST";
        from = "ALT_CW_LAKKA";
        to = "ALT_C_AIRPORT_WEST";
        connectionType = "ROAD_MAIN";
        designStatus = "DISEÑO_CONFIRMADO";
        validationStatus = "POR_CALIBRAR";
    };
    class CONN_M3_AIRPORT_WEST_TERMINAL
    {
        id = "CONN_M3_AIRPORT_WEST_TERMINAL";
        from = "ALT_C_AIRPORT_WEST";
        to = "ALT_C_AIRPORT_TERMINAL";
        connectionType = "ROAD_MAIN";
        designStatus = "PROPUESTA_M3";
        validationStatus = "POR_CALIBRAR";
    };
};
