// init include server
#ifndef __XSETUP_INCL__
#define THIS_FILE "i_server.sqf"
#include "x_setup.sqf"
#endif

GVAR(bap_counter) = 0;
_mpos = markerPos QGVAR(bonus_create_pos);
_mpos set [2,0];
GVAR(bonus_create_pos) = _mpos;
GVAR(bonus_air_positions) = [];
for "_i" from 1 to 10000 do {
    _mna = format [QGVAR(bonus_air_positions_%1), _i];
    _mpos = markerPos _mna;
    _mpos set [2,0];
    if (str _mpos == "[0,0,0]") exitWith {};
    GVAR(bonus_air_positions) set [count GVAR(bonus_air_positions), [_mpos, markerDir _mna]];
};

GVAR(bvp_counter) = 0;
GVAR(bonus_vec_positions) = [];
for "_i" from 1 to 10000 do {
    _mna = format [QGVAR(bonus_vec_positions_%1), _i];
    _mpos = markerPos _mna;
    _mpos set [2,0];
    if (str _mpos == "[0,0,0]") exitWith {};
    GVAR(bonus_vec_positions) set [count GVAR(bonus_vec_positions), [_mpos, markerDir _mna]];
};

GVAR(wreck_hangars) = [];
GVAR(wreck_hangar_triggers) = [];
for "_i" from 1 to 3 do {
    _mna = format [QGVAR(wreck_hangar_%1), _i];
    _mpos = markerPos _mna;
    _mpos set [2,0];
    if (str _mpos == "[0,0,0]") exitWith {};
    GVAR(wreck_hangars) set [count GVAR(wreck_hangars), [_mpos, markerDir _mna]];
    
    _vehicle = createVehicle ["Land_Mil_hangar_EP1", _mpos, [], 0, "NONE"];
    _vehicle setDir (markerDir _mna);
    _vehicle addEventHandler ["handleDamage", {0}];
    
    _trigger = [QGVAR(%1_trigger), _mna];
    GVAR(_trigger) = createTrigger ["EmptyDetector", _mpos];
    GVAR(_trigger) setTriggerArea [12, 20, -30, true];
    GVAR(_trigger) setTriggerActivation ["ANY", "PRESENT", true];
    GVAR(_trigger) setTriggerStatements [
        "{_x isKindOf 'Air'} count thislist > 0",
        "X_JIPH setVariable ['d_wreck_hangars_occupied', (X_JIPH getVariable 'd_wreck_hangars_occupied') + 1, true]",
        "X_JIPH setVariable ['d_wreck_hangars_occupied', (X_JIPH getVariable 'd_wreck_hangars_occupied') - 1, true]"
    ];
    
    GVAR(wreck_hangar_triggers) set [count GVAR(wreck_hangar_triggers), GVAR(_trigger)];
};

GVAR(firebase) =
#ifdef __CO__
if (GVAR(enemy_side) == "EAST") then {"Firebase1_RU"} else {"Firebase1_US"};
#endif
#ifdef __OA__
if (GVAR(enemy_side) == "EAST") then {"Firebase1_TK_EP1"} else {"Firebase1_US_EP1"};
#endif

#ifdef __CO__
GVAR(artillery_radar) = switch (GVAR(enemy_side)) do {
    case "WEST": {"USMC_WarfareBArtilleryRadar"};
    case "EAST": {"RU_WarfareBArtilleryRadar"};
    case "GUER": {"Gue_WarfareBArtilleryRadar"};
};
#endif
#ifdef __OA__
GVAR(artillery_radar) = switch (GVAR(enemy_side)) do {
    case "WEST": {"US_WarfareBArtilleryRadar_EP1"};
    case "EAST": {"TK_WarfareBArtilleryRadar_EP1"};
    case "GUER": {"TK_GUE_WarfareBArtilleryRadar_EP1"};
};
#endif

#ifdef __CO__
GVAR(air_radar) = switch (GVAR(enemy_side)) do {
    case "WEST": {"USMC_WarfareBAntiAirRadar"};
    case "EAST": {"RU_WarfareBAntiAirRadar"};
    case "GUER": {"GUE_WarfareBAntiAirRadar"};
};
#endif
#ifdef __OA__
GVAR(air_radar) = switch (GVAR(enemy_side)) do {
    case "WEST": {"US_WarfareBAntiAirRadar_EP1"};
    case "EAST": {"TK_WarfareBAntiAirRadar_EP1"};
    case "GUER": {"TK_GUE_WarfareBAntiAirRadar_EP1"};
};
#endif

#ifdef __CO__
GVAR(enemy_hq) = switch (GVAR(enemy_side)) do {
    case "EAST": {"BTR90_HQ_unfolded"};
    case "WEST": {"LAV25_HQ_unfolded"};
    case "GUER": {"BRDM2_HQ_Gue_unfolded"};
};
#endif
#ifdef __OA__
GVAR(enemy_hq) = switch (GVAR(enemy_side)) do {
    case "EAST": {"BMP2_HQ_TK_unfolded_EP1"};
    case "WEST": {"M1130_HQ_unfolded_EP1"};
    case "GUER": {"BRDM2_HQ_TK_GUE_unfolded_EP1"};
};
#endif

// _E = East
// _W = West
// _G = Guer
// this is what gets spawned
GVAR(allmen_E) =
#ifdef __CO__
[
    ["East","RU","Infantry","RU_InfSquad"] call FUNC(GetConfigGroup),
    ["East","RU","Infantry","RU_InfSection"] call FUNC(GetConfigGroup),
    ["East","RU","Infantry","RU_InfSection_AT"] call FUNC(GetConfigGroup),
    ["East","RU","Infantry","RU_InfSection_AA"] call FUNC(GetConfigGroup),
    ["East","RU","Infantry","RU_InfSection_MG"] call FUNC(GetConfigGroup),
    ["East","RU","Infantry","RU_SniperTeam"] call FUNC(GetConfigGroup),
    ["East","RU","Infantry","RUS_ReconTeam"] call FUNC(GetConfigGroup),
    ["East","RU","Infantry","MVD_AssaultTeam"] call FUNC(GetConfigGroup),
    ["East","INS","Infantry","INS_InfSquad"] call FUNC(GetConfigGroup),
    ["East","INS","Infantry","INS_InfSquad_Weapons"] call FUNC(GetConfigGroup),
    ["East","INS","Infantry","INS_InfSection_AT"] call FUNC(GetConfigGroup),
    ["East","INS","Infantry","INS_InfSection_AA"] call FUNC(GetConfigGroup),
    ["East","INS","Infantry","INS_SniperTeam"] call FUNC(GetConfigGroup),
    ["East","INS","Infantry","INS_MilitiaSquad"] call FUNC(GetConfigGroup)
];
#endif
#ifdef __OA__
[
    ["East","BIS_TK","Infantry","TK_InfantrySquad"] call FUNC(GetConfigGroup),
    ["East","BIS_TK","Infantry","TK_InfantrySection"] call FUNC(GetConfigGroup),
    ["East","BIS_TK","Infantry","TK_InfantrySectionAT"] call FUNC(GetConfigGroup),
    ["East","BIS_TK","Infantry","TK_InfantrySectionAA"] call FUNC(GetConfigGroup),
    ["East","BIS_TK","Infantry","TK_InfantrySectionMG"] call FUNC(GetConfigGroup),
    ["East","BIS_TK","Infantry","TK_SniperTeam"] call FUNC(GetConfigGroup),
    ["East","BIS_TK","Infantry","TK_SpecialPurposeSquad"] call FUNC(GetConfigGroup),
    ["East","BIS_TK_INS","Infantry","TK_INS_Group"] call FUNC(GetConfigGroup),
    ["East","BIS_TK_INS","Infantry","TK_INS_Patrol"] call FUNC(GetConfigGroup),
    ["East","BIS_TK_INS","Infantry","TK_INS_AATeam"] call FUNC(GetConfigGroup),
    ["East","BIS_TK_INS","Infantry","TK_INS_ATTeam"] call FUNC(GetConfigGroup)
];
#endif
// BAF groups
// ["West","BIS_BAF_MTP","Infantry","BAF_Section_MTP"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry","BAF_Fireteam_MTP"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry","BAF_Support_MTP"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry","BAF_MG_MTP"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry","BAF_AT_MTP"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry","BAF_HAT_MTP"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry","BAF_SnipersN_MTP"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_DDPM","BAF_Section_DDPM"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_DDPM","BAF_Fireteam_DDPM"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_DDPM","BAF_Support_DDPM"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_DDPM","BAF_MG_DDPM"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_DDPM","BAF_AT_DDPM"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_DDPM","BAF_HAT_DDPM"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_W","BAF_Section_W"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_W","BAF_Fireteam_W"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_W","BAF_Support_W"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_W","BAF_MG_W"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_W","BAF_AT_W"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_W","BAF_HAT_W"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_W","BAF_Snipers_W"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_W","BAF_SnipersN_W"] call FUNC(GetConfigGroup),
// ["West","BIS_BAF_MTP","Infantry_W","BAF_SnipersN_W"] call FUNC(GetConfigGroup)
GVAR(allmen_W) = 
#ifdef __CO__
[
    ["West","USMC","Infantry","USMC_InfSquad"] call FUNC(GetConfigGroup),
    ["West","USMC","Infantry","USMC_FireTeam"] call FUNC(GetConfigGroup),
    ["West","USMC","Infantry","USMC_FireTeam_MG"] call FUNC(GetConfigGroup),
    ["West","USMC","Infantry","USMC_FireTeam_AT"] call FUNC(GetConfigGroup),
    ["West","USMC","Infantry","USMC_FireTeam_Support"] call FUNC(GetConfigGroup),
    ["West","USMC","Infantry","USMC_HeavyATTeam"] call FUNC(GetConfigGroup),
    ["West","USMC","Infantry","USMC_SniperTeam"] call FUNC(GetConfigGroup),
    ["West","USMC","Infantry","USMC_FRTeam"] call FUNC(GetConfigGroup),
    ["West","USMC","Infantry","USMC_FRTeam_Razor"] call FUNC(GetConfigGroup),
    ["West","CDF","Infantry","CDF_InfSquad"] call FUNC(GetConfigGroup),
    ["West","CDF","Infantry","CDF_InfSquad_Weapons"] call FUNC(GetConfigGroup),
    ["West","CDF","Infantry","CDF_InfSection_AT"] call FUNC(GetConfigGroup),
    ["West","CDF","Infantry","CDF_InfSection_AA"] call FUNC(GetConfigGroup),
    ["West","CDF","Infantry","CDF_InfSection_MG"] call FUNC(GetConfigGroup),
    ["West","CDF","Infantry","CDF_InfSection_Patrol"] call FUNC(GetConfigGroup),
    ["West","CDF","Infantry","CDF_SniperTeam"] call FUNC(GetConfigGroup)
];
#endif
#ifdef __OA__
[
    ["West","BIS_US","Infantry","US_RifleSquad"] call FUNC(GetConfigGroup),
    ["West","BIS_US","Infantry","US_WeaponsSquad"] call FUNC(GetConfigGroup),
    ["West","BIS_US","Infantry","US_Team"] call FUNC(GetConfigGroup),
    ["West","BIS_US","Infantry","US_TeamMG"] call FUNC(GetConfigGroup),
    ["West","BIS_US","Infantry","US_TeamAT"] call FUNC(GetConfigGroup),
    ["West","BIS_US","Infantry","US_TeamSupport"] call FUNC(GetConfigGroup),
    ["West","BIS_US","Infantry","US_HeavyATTeam"] call FUNC(GetConfigGroup),
    ["West","BIS_US","Infantry","US_SniperTeam"] call FUNC(GetConfigGroup),
    ["West","BIS_US","Infantry","US_DeltaForceTeam"] call FUNC(GetConfigGroup),
    ["West","BIS_CZ","Infantry","ACR_InfantryPatrol"] call FUNC(GetConfigGroup),
    ["West","BIS_CZ","Infantry","ACR_SpecialForcesTeam"] call FUNC(GetConfigGroup),
    ["West","BIS_GER","Infantry","KSKTeam"] call FUNC(GetConfigGroup)
];
#endif
GVAR(allmen_G) =
#ifdef __CO__
[
    ["Guerrila","GUE","Infantry","GUE_InfSquad"] call FUNC(GetConfigGroup),
    ["Guerrila","GUE","Infantry","GUE_InfSquad_Assault"] call FUNC(GetConfigGroup),
    ["Guerrila","GUE","Infantry","GUE_InfSquad_Weapons"] call FUNC(GetConfigGroup),
    ["Guerrila","GUE","Infantry","GUE_InfTeam_1"] call FUNC(GetConfigGroup),
    ["Guerrila","GUE","Infantry","GUE_InfTeam_2"] call FUNC(GetConfigGroup),
    ["Guerrila","GUE","Infantry","GUE_InfTeam_AT"] call FUNC(GetConfigGroup),
    ["Guerrila","GUE","Infantry","GUE_GrpInf_TeamAA"] call FUNC(GetConfigGroup),
    ["Guerrila","GUE","Infantry","GUE_GrpInf_TeamSniper"] call FUNC(GetConfigGroup),
    ["Guerrila","GUE","Infantry","GUE_MilitiaSquad"] call FUNC(GetConfigGroup)
];
#endif
#ifdef __OA__
[
    ["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_Group"] call FUNC(GetConfigGroup),
    ["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_GroupWeapons"] call FUNC(GetConfigGroup),
    ["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_Patrol"] call FUNC(GetConfigGroup),
    ["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_ATTeam"] call FUNC(GetConfigGroup),
    ["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_AATeam"] call FUNC(GetConfigGroup),
    ["Guerrila","BIS_TK_GUE","Infantry","TK_GUE_SniperTeam"] call FUNC(GetConfigGroup),
    ["Guerrila","BIS_UN","Infantry","UN_Patrol"] call FUNC(GetConfigGroup)
];
#endif

#ifdef __CO__
GVAR(specops_E) = ["RUS_Soldier_TL","RUS_Soldier_GL","RUS_Soldier_Marksman","RUS_Soldier3","RUS_Soldier1","RUS_Soldier2"];
GVAR(specops_W) = ["FR_TL","FR_AC","FR_GL","FR_Commander","FR_AR","FR_R","FR_Corpsman","FR_Marksman","FR_Sapper","FR_Assault_R","FR_Assault_GL"];
GVAR(specops_G) = ["GUE_Soldier_Sab","GUE_Soldier_Scout"];

GVAR(sabotage_E) = ["RUS_Soldier1","RUS_Soldier2"];
GVAR(sabotage_W) = ["FR_R","FR_Sapper"];
GVAR(sabotage_G) = ["GUE_Soldier_Sab"];
#endif
#ifdef __OA__
GVAR(specops_E) = ["TK_Special_Forces_TL_EP1","TK_Special_Forces_EP1","TK_Special_Forces_MG_EP1"];
GVAR(specops_W) = ["US_Delta_Force_TL_EP1","US_Delta_Force_EP1","US_Delta_Force_Medic_EP1","US_Delta_Force_Assault_EP1","US_Delta_Force_SD_EP1","US_Delta_Force_MG_EP1","US_Delta_Force_AR_EP1","US_Delta_Force_Night_EP1","US_Delta_Force_Marksman_EP1","US_Delta_Force_M14_EP1","US_Delta_Force_Air_Controller_EP1"];
GVAR(specops_G) = ["TK_GUE_Soldier_EP1","TK_GUE_Soldier_2_EP1","TK_GUE_Soldier_3_EP1","TK_GUE_Soldier_4_EP1"];

GVAR(sabotage_E) = ["TK_Special_Forces_EP1"];
GVAR(sabotage_W) = ["US_Delta_Force_SD_EP1"];
GVAR(sabotage_G) = ["TK_GUE_Soldier_EP1"];
#endif

GVAR(veh_a_E) = switch (true) do {
    case (__OAVer): {
        [
            ["T72_TK_EP1","T55_TK_EP1","T34_TK_EP1"],
            ["BMP2_TK_EP1", "M113_TK_EP1"],
            ["BRDM2_ATGM_TK_EP1","BRDM2_TK_EP1","BTR60_TK_EP1"],
            ["ZSU_TK_EP1","Ural_ZU23_TK_EP1"],
            ["UAZ_MG_TK_EP1","BTR40_MG_TK_INS_EP1","LandRover_MG_TK_INS_EP1","LandRover_MG_TK_EP1"],
            ["UAZ_AGS30_TK_EP1","LandRover_SPG9_TK_INS_EP1","LandRover_SPG9_TK_EP1"],
            ["KORD_high_TK_EP1","KORD_TK_EP1","DSHkM_Mini_TriPod_TK_INS_EP1","DSHKM_TK_INS_EP1","SPG9_TK_INS_EP1"],
            ["2b14_82mm_TK_EP1","AGS_TK_EP1","Igla_AA_pod_TK_EP1","Metis_TK_EP1","ZU23_TK_EP1","2b14_82mm_TK_INS_EP1","AGS_TK_INS_EP1","ZU23_TK_INS_EP1"],
            ["D30_TK_EP1","GRAD_TK_EP1","D30_TK_INS_EP1"],
            ["UralRefuel_TK_EP1"],
            ["UralRepair_TK_EP1"],
            ["UralReammo_TK_EP1"]
        ]
    };
    case (__COVer): {
        [
            ["T72_RU","T90","T72_INS"],
            ["BMP3","BMP2_INS"],
            ["BTR90","BTR90_HQ","BRDM2_INS","BRDM2_ATGM_INS"],
            ["2S6M_Tunguska","ZSU_INS","Ural_ZU23_INS"],
            ["GAZ_Vodnik","GAZ_Vodnik_HMG"],
            ["UAZ_AGS30_RU","UAZ_AGS30_INS","UAZ_MG_INS","UAZ_SPG9_INS"],
            ["KORD"],
            ["AGS_RU","Igla_AA_pod_East","Metis","2b14_82mm"],
            ["D30_RU","GRAD_INS"],
            ["KamazRefuel"],
            ["KamazRepair"],
            ["KamazReammo"]
        ]
    };
};

GVAR(veh_a_W) = switch (true) do {
    case (__OAVer): {
        [
            ["M1A2_US_TUSK_MG_EP1","M1A1_US_DES_EP1"],
            ["M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1128_MGS_EP1","M1135_ATGMV_EP1"],
            ["M2A2_EP1","M2A3_EP1"],
            ["M6_EP1","HMMWV_Avenger_DES_EP1"],
            ["HMMWV_M1151_M2_DES_EP1","HMMWV_M998_crows_M2_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1","LandRover_Special_CZ_EP1"],
            ["HMMWV_M998_crows_MK19_DES_EP1","HMMWV_MK19_DES_EP1","HMMWV_TOW_DES_EP1"],
            ["M2HD_mini_TriPod_US_EP1","M2StaticMG_US_EP1"],
            ["M252_US_EP1","MK19_TriPod_US_EP1","Stinger_Pod_US_EP1","TOW_TriPod_US_EP1"],
            ["M119_US_EP1","MLRS_DES_EP1"],
            ["MtvrRefuel_DES_EP1"],
            ["MtvrRepair_DES_EP1"],
            ["MtvrReammo_DES_EP1"]
        ]
    };
    case (__COVer): {
        [
            ["M1A1","M1A2_TUSK_MG","T72_CDF"],
            ["LAV25","BRDM2_CDF","BRDM2_ATGM_CDF"],
            ["AAV","BMP2_CDF"],
            ["HMMWV_Avenger","ZSU_CDF"],
            ["HMMWV_M2","HMMWV_Armored","UAZ_MG_CDF"],
            ["HMMWV_MK19","HMMWV_TOW","UAZ_AGS30_CDF"],
            ["M2StaticMG","M2HD_mini_TriPod","AGS_CDF"],
            ["Stinger_Pod","M2HD_mini_TriPod","MK19_TriPod","M252","M2StaticMG","TOW_TriPod","ZU23_CDF"],
            ["M119","MLRS","GRAD_CDF"],
            ["MtvrRefuel"],
            ["MtvrRepair"],
            ["MtvrReammo"]
        ]
    };
};
GVAR(veh_a_G) =
#ifdef __CO__
[
    ["T72_Gue","T34"],
    ["BMP2_Gue"],
    ["BRDM2_Gue"],
    ["Ural_ZU23_Gue"],
    ["Offroad_DSHKM_Gue"],
    ["Offroad_SPG9_Gue"],
    ["DSHKM_Gue","2b14_82mm_GUE"],
    ["2b14_82mm_GUE","SPG9_Gue"],
    ["ZU23_Gue"],
    ["V3S_Gue"],
    ["V3S_Gue"],
    ["V3S_Gue"]
];
#endif
#ifdef __OA__
[
    ["T55_TK_GUE_EP1","T34_TK_GUE_EP1"],
    ["BRDM2_TK_GUE_EP1"],
    ["BTR40_MG_TK_GUE_EP1"],
    ["Ural_ZU23_TK_GUE_EP1"],
    ["Offroad_DSHKM_TK_GUE_EP1"],
    ["Offroad_SPG9_TK_GUE_EP1"],
    ["DSHkM_Mini_TriPod_TK_GUE_EP1","DSHKM_TK_GUE_EP1"],
    ["2b14_82mm_TK_GUE_EP1","AGS_TK_GUE_EP1","SPG9_TK_GUE_EP1","ZU23_TK_GUE_EP1"],
    ["D30_TK_GUE_EP1"],
    ["V3S_Refuel_TK_GUE_EP1"],
    ["V3S_Repair_TK_GUE_EP1"],
    ["V3S_Reammo_TK_GUE_EP1"]
];
#endif

// first element (array. for example: [2,1]): number of vehicle groups that will get spawned, the first number is the max number that will get spawned,
// the second one the minimum. So [2,0] means, there can be no vehicle groups at all or a maximum of 2 groups of this kind
// second element: maximum number of vehicles in group; randomly chosen
switch (GVAR(WithLessArmor)) do {
    case 0: {
        GVAR(vehicle_numbers_guard) = [
            [[1,0], 1], // tanks
            [[1,0], 1], // apc (bmp)
            [[1,1], 1], // apc2 (brdm)
            [[1,1], 1], // jeep with mg (uaz mg)
            [[1,0], 1] // jeep with gl (uaz grenade)
        ];
        GVAR(vehicle_numbers_guard_static) = [
            [[1,1], 1], // tanks
            [[1,1], 1], // apc (bmp)
            [[2,1], 1] // aa (shilka)
        ];
        GVAR(vehicle_numbers_patrol) = [
            [[1,1], 1], // tanks
            [[1,1], 1], // apc (bmp)
            [[1,1], 1], // apc2 (brdm)
            [[2,1], 1], // jeep with mg (uaz mg)
            [[2,1], 1] // jeep with gl (uaz grenade)
        ];

        // allmost the same like above
        // first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
        GVAR(footunits_guard) = [
#ifndef __TT__
            [1,1], // basic groups
            [1,1] // specop groups
#else
            [2,1], // basic groups
            [2,1] // specop groups
#endif
        ];
        GVAR(footunits_patrol) = [
            [5,3], // basic groups
            [5,3] // specop groups
        ];
        GVAR(footunits_guard_static) = [
            [1,1], // basic groups
            [1,0] // specop groups
        ];
        GVAR(footunits_attack) = [
            [3,1], // basic groups
            [2,1] // specop groups
        ];
        GVAR(vehicle_numbers_attack) = [
            [[1,1], 1], // tanks
            [[1,1], 1], // apc (bmp)
            [[1,1], 1], // apc2 (brdm)
            [[2,1], 1], // jeep with mg (uaz mg)
            [[2,1], 1], // jeep with gl (uaz grenade)
            [[1,1], 1] // Shilka/AA
        ];
    };
    case 1: {
        GVAR(vehicle_numbers_guard) = [
            [[1,0], 1], // tanks
            [[1,0], 1], // apc (bmp)
            [[1,0], 1], // apc2 (brdm)
            [[1,1], 1], // jeep with mg (uaz mg)
            [[1,1], 1] // jeep with gl (uaz grenade)
        ];
        GVAR(vehicle_numbers_guard_static) = [
            [[1,0], 1], // tanks
            [[1,0], 1], // apc (bmp)
            [[1,0], 1] // aa (shilka)
        ];
        GVAR(vehicle_numbers_patrol) = [
            [[1,0], 1], // tanks
            [[1,0], 1], // apc (bmp)
            [[1,0], 1], // apc2 (brdm)
            [[1,1], 1], // jeep with mg (uaz mg)
            [[1,1], 1] // jeep with gl (uaz grenade)
        ];

        // allmost the same like above
        // first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
        GVAR(footunits_guard) = [
#ifndef __TT__
            [3,1], // basic groups
            [3,1] // specop groups
#else
            [3,1], // basic groups
            [3,1] // specop groups
#endif
        ];
        GVAR(footunits_patrol) = [
            [8,3], // basic groups
            [8,3] // specop groups
        ];
        GVAR(footunits_guard_static) = [
            [3,1], // basic groups
            [2,1] // specop groups
        ];
        GVAR(footunits_attack) = [
            [3,1], // basic groups
            [2,1] // specop groups
        ];
        GVAR(vehicle_numbers_attack) = [
            [[1,0], 1], // tanks
            [[1,0], 1], // apc (bmp)
            [[1,0], 1], // apc2 (brdm)
            [[1,1], 1], // jeep with mg (uaz mg)
            [[1,1], 1], // jeep with gl (uaz grenade)
            [[1,0], 1] // Shilka/AA
        ];
    };
    case 2: {
        GVAR(vehicle_numbers_guard) = [
            [[0,0], 1], // tanks
            [[0,0], 1], // apc (bmp)
            [[0,0], 1], // apc2 (brdm)
            [[2,1], 1], // jeep with mg (uaz mg)
            [[2,1], 1] // jeep with gl (uaz grenade)
        ];
        GVAR(vehicle_numbers_guard_static) = [
            [[0,0], 1], // tanks
            [[0,0], 1], // apc (bmp)
            [[0,0], 1] // aa (shilka)
        ];
        GVAR(vehicle_numbers_patrol) = [
            [[0,0], 1], // tanks
            [[0,0], 1], // apc (bmp)
            [[0,0], 1], // apc2 (brdm)
            [[2,1], 1], // jeep with mg (uaz mg)
            [[2,1], 1] // jeep with gl (uaz grenade)
        ];

        // allmost the same like above
        // first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
        GVAR(footunits_guard) = [
#ifndef __TT__
            [4,1], // basic groups
            [4,1] // specop groups
#else
            [4,1], // basic groups
            [4,1] // specop groups
#endif
        ];
        GVAR(footunits_patrol) = [
            [8,3], // basic groups
            [6,3] // specop groups
        ];
        GVAR(footunits_guard_static) = [
            [4,1], // basic groups
            [3,1] // specop groups
        ];
        GVAR(footunits_attack) = [
            [6,1], // basic groups
            [6,1] // specop groups
        ];
        GVAR(vehicle_numbers_attack) = [
            [[0,0], 1], // tanks
            [[0,0], 1], // apc (bmp)
            [[0,0], 1], // apc2 (brdm)
            [[2,1], 1], // jeep with mg (uaz mg)
            [[2,1], 1], // jeep with gl (uaz grenade)
            [[1,0], 1] // Shilka/AA
        ];
    };
};

GVAR(arti_observer_E) = "TK_Soldier_Spotter_EP1";
GVAR(arti_observer_W) = "US_Soldier_Spotter_EP1";
GVAR(arti_observer_G) = "TK_GUE_Soldier_AR_EP1";

GVAR(number_attack_planes) = 1;
GVAR(number_attack_choppers) = 1;

GVAR(airki_attack_plane) = ["Su25_TK_EP1","L39_TK_EP1"];
GVAR(airki_attack_chopper) = ["Mi24_D_TK_EP1"];
GVAR(light_attack_chopper) = ["UH1H_TK_EP1"];
GVAR(transport_chopper) = ["Mi17_TK_EP1"];

// enemy ai skill: [base skill, random value (random 0.3) that gets added to the base skill]
GVAR(skill_array) = switch (GVAR(EnemySkill)) do {
    case 1: {[0.2,0.2]};
    case 2: {[0.4,0.3]};
    case 3: {[0.7,0.3]};
};

GVAR(drop_aircraft) = "C130J_US_EP1";
GVAR(taxi_aircraft) = "UH60M_EP1";

// max count for target clear
GVAR(man_count_for_target_clear) = 6;
GVAR(tank_count_for_target_clear) = 1;
GVAR(car_count_for_target_clear) = 1;

// add some random patrols on the island
// if the array is empty, no patrols
// simply place a rectangular marker called "d_isledefense_marker", marker text = number of patrols
if (GVAR(WithIsleDefense) == 0) then {
    _mname = QGVAR(isledefense_marker);
    _mpos = markerPos _mname;
    if (str _mpos == "[0,0,0]") exitWith {
        GVAR(with_isledefense) = [];
    };
    _mpos set [2,0];
    _mtext = markerText _mname;
    GVAR(with_isledefense) = [_mpos, (markerSize _mname) select 0, (markerSize _mname) select 1, markerDir _mname, parseNumber _mtext];
} else {
    GVAR(with_isledefense) = [];
};

__TRACE_1("","d_with_isledefense")

#ifndef __TT__
// if set to true no enemy AI will attack base and destroy bonus vehicles or whatever
GVAR(no_sabotage) = (GVAR(WithBaseAttack) == 1);
#endif

// time (in sec) between attack planes and choppers over main target will respawn once they were shot down (a random value between 0 and 240 will be added)
GVAR(airki_respawntime) = 1200;

GVAR(side_missions_random) = [];

// don't remove GVAR(recapture_indices) even if you set GVAR(WithRecapture) to 1
GVAR(recapture_indices) = [];

// max number of cities that the enemy will recapture at once
// if set to -1 no check is done
GVAR(max_recaptures) = 1;

0 spawn {
    scriptName "spawn_CreateWarFac";
    _wairfac = switch (GVAR(own_side)) do {
        case "WEST": {GVAR(WarfareAircraftFactory_West)};
        case "EAST": {GVAR(WarfareAircraftFactory_East)};
        case "GUER": {GVAR(WarfareAircraftFactory_Guer)};
    };
    _pos = (GVAR(aircraft_facs) select 0) select 0;
    _dir = (GVAR(aircraft_facs) select 0) select 1;
    [QGVAR(jet_serviceH),false] call FUNC(NetSetJIP);
    _fac = createVehicle [_wairfac, _pos, [], 0, "NONE"];
    _fac setDir _dir;
    _fac setPos _pos;
    _fac addEventHandler ["HandleDamage", {false}];

    _pos = (GVAR(aircraft_facs) select 1) select 0;
    _dir = (GVAR(aircraft_facs) select 1) select 1;
    [QGVAR(chopper_serviceH),false] call FUNC(NetSetJIP);
    _fac = createVehicle [_wairfac, _pos, [], 0, "NONE"];
    _fac setDir _dir;
    _fac setPos _pos;
    _fac addEventHandler ["HandleDamage", {false}];

    _pos = (GVAR(aircraft_facs) select 2) select 0;
    _dir = (GVAR(aircraft_facs) select 2) select 1;
    [QGVAR(wreck_repairH),false] call FUNC(NetSetJIP);
    _fac = createVehicle [_wairfac, _pos, [], 0, "NONE"];
    _fac setDir _dir;
    _fac setPos _pos;
    _fac addEventHandler ["HandleDamage", {false}];
};

GVAR(time_until_next_sidemission) = [
    [10,300], // if player number <= 10, it'll take 300 seconds = 5 minutes until the next sidemission
    [20,600], // if player number <= 20, it'll take 600 seconds = 10 minutes until the next sidemission
    [30,900], // if player number <= 30, it'll take 900 seconds = 15 minutes until the next sidemission
    [40,1200] // if player number <= 40, it'll take 1200 seconds = 20 minutes until the next sidemission
];

#ifdef __CO__
GVAR(civilians_t) = ["Assistant","Citizen1","Citizen2","Citizen2","Citizen4","Worker1","Worker2","Worker3","Worker4","Priest","Doctor","Functionary1","Functionary2","Damsel1","Damsel2","Damsel3","Damsel4","Damsel5","Profiteer1","Profiteer2","Profiteer3","Profiteer4","Rocker1","Rocker2","Rocker3","Rocker4","Woodlander1","Woodlander2","Woodlander3","Woodlander4","Villager1","Villager2","Villager3","Villager4","Secretary1","Secretary2","Secretary3","Secretary4","Sportswoman1","Sportswoman2","Sportswoman3","Sportswoman4","Madam1","Madam2","Madam3","Madam4","Farmwife1","Farmwife2","Farmwife3","Farmwife4","HouseWife1","HouseWife2","HouseWife3","HouseWife4","Hooker1","Hooker2","Hooker3","Hooker4","WorkWoman1","WorkWoman2","WorkWoman3","WorkWoman4","SchoolTeacher","Policeman"];
#endif
#ifdef __OA__
GVAR(civilians_t) = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1","Citizen2_EP1","Citizen3_EP1","CIV_EuroMan01_EP1","CIV_EuroMan02_EP1","Haris_Press_EP1","Profiteer2_EP1"];
#endif

GVAR(wreck_cur_ar) = [];

GVAR(misc_stores) = GVAR(HeliHEmpty) createVehicleLocal [0,0,0];

FUNC(StoreAdd) = {GVAR(misc_stores) setVariable [_this select 0, _this select 1]};
FUNC(StoreGet) = {GV2(GVAR(misc_stores),_this)};

["EAST", east] call FUNC(StoreAdd);
["WEST", west] call FUNC(StoreAdd);
["GUER", resistance] call FUNC(StoreAdd);
["CIV", civilian] call FUNC(StoreAdd);

#ifdef __CO__
["FEAST", "FlagCarrierRU"] call FUNC(StoreAdd);
["FWEST", "FlagCarrierUSA"] call FUNC(StoreAdd);
["FGUER", "FlagCarrierGUE"] call FUNC(StoreAdd);
#endif
#ifdef __OA__
["FEAST", "FlagCarrierTakistan_EP1"] call FUNC(StoreAdd);
["FWEST", "FlagCarrierUSA_EP1"] call FUNC(StoreAdd);
["FGUER", "FlagCarrierTKMilitia_EP1"] call FUNC(StoreAdd);
#endif

#ifdef __OA__
GVAR(soldier_officer) = switch (GVAR(enemy_side)) do {
    case "EAST": {"TK_Soldier_Officer_EP1"};
    case "WEST": {"US_Soldier_Officer_EP1"};
    case "GUER": {"TK_GUE_Warlord_EP1"};
};
GVAR(soldier_officer2) = switch (GVAR(enemy_side)) do {
    case "EAST": {"TK_INS_Warlord_EP1"};
    case "WEST": {"US_Soldier_Officer_EP1"};
    case "GUER": {"TK_GUE_Warlord_EP1"};
};
GVAR(sm_arty) = switch (GVAR(enemy_side)) do {
    case "EAST": {"D30_TK_EP1"};
    case "WEST": {"M119_US_EP1"};
    case "GUER": {"D30_TK_GUE_EP1"};
};
GVAR(sm_plane) = switch (GVAR(enemy_side)) do {
    case "EAST": {"Su25_TK_EP1"};
    case "WEST": {"A10_US_EP1"};
};
GVAR(sm_tank) = switch (GVAR(enemy_side)) do {
    case "EAST": {"T72_TK_EP1"};
    case "WEST": {"M1A2_US_TUSK_MG_EP1"};
    case "GUER": {"T55_TK_GUE_EP1"};
};
GVAR(sm_chopper) = switch (GVAR(enemy_side)) do {
    case "EAST": {"Mi24_D_TK_EP1"};
    case "WEST": {"AH64D_EP1"};
};
GVAR(sm_pilottype) = switch (GVAR(enemy_side)) do {
    case "EAST": {"US_Soldier_Pilot_EP1"};
    case "WEST": {"TK_Soldier_Pilot_EP1"};
};
GVAR(sm_wrecktype) = switch (GVAR(enemy_side)) do {
    case "EAST": {"UH60_wreck_EP1"};
    case "WEST": {"Mi8Wreck"};
};
GVAR(sm_ammotrucktype) = switch (GVAR(enemy_side)) do {
    case "EAST": {"UralReammo_TK_EP1"};
    case "WEST": {"MtvrReammo_DES_EP1"};
    case "GUER": {"V3S_Reammo_TK_GUE_EP1"};
};
GVAR(sm_fortress) = "Land_Fort_Watchtower_EP1";
GVAR(functionary) = "Functionary1_EP1";
GVAR(fuel_station) = "Land_Ind_FuelStation_Build_EP1";
GVAR(cruise_missile) = "Chukar_EP1";
GVAR(sm_cargo) = "Land_Misc_Cargo1Eo_EP1";
GVAR(sm_hangar) = "Land_Mil_hangar_EP1";
GVAR(sm_tent) = "ACamp_EP1";

GVAR(sm_SCUD) = "MAZ_543_SCUD_TK_EP1";
GVAR(sm_simple_soldier_east) = "TK_Soldier_EP1";
#endif
#ifdef __CO__
GVAR(soldier_officer) = switch (GVAR(enemy_side)) do {
    case "EAST": {"RU_Commander"};
    case "WEST": {"USMC_Soldier_Officer"};
    case "GUER": {"GUE_Commander"};
};
GVAR(soldier_officer2) = switch (GVAR(enemy_side)) do {
    case "EAST": {"RU_Commander"};
    case "WEST": {"USMC_Soldier_Officer"};
    case "GUER": {"GUE_Commander"};
};
GVAR(sm_arty) = switch (GVAR(enemy_side)) do {
    case "EAST": {"D30_RU"};
    case "WEST": {"M119"};
    case "GUER": {"D30_Ins"};
};
GVAR(sm_plane) = switch (GVAR(enemy_side)) do {
    case "EAST": {"Su34"};
    case "WEST": {"F35B"};
};
GVAR(sm_tank) = switch (GVAR(enemy_side)) do {
    case "EAST": {"T90"};
    case "WEST": {"M1A2_TUSK_MG"};
    case "GUER": {"T72_Gue"};
};
GVAR(sm_chopper) = switch (GVAR(enemy_side)) do {
    case "EAST": {"Ka52Black"};
    case "WEST": {"AH1Z"};
};
GVAR(sm_pilottype) = switch (GVAR(enemy_side)) do {
    case "EAST": {"USMC_Soldier_Pilot"};
    case "WEST": {"RU_Soldier_Pilot"};
};
GVAR(sm_wrecktype) = switch (GVAR(enemy_side)) do {
    case "EAST": {"UH1Wreck"};
    case "WEST": {"Mi8Wreck"};
};
GVAR(sm_ammotrucktype) = switch (GVAR(enemy_side)) do {
    case "EAST": {"KamazReammo"};
    case "WEST": {"MtvrReammo"};
    case "GUER": {"V3S_Gue"};
};
GVAR(sm_fortress) = "Land_Fort_Watchtower";
GVAR(functionary) = "Functionary1";
GVAR(fuel_station) = "Land_A_FuelStation_Build";
GVAR(cruise_missile) = "CruiseMissile2";
GVAR(sm_cargo) = "Misc_Cargo1B_military";
GVAR(sm_hangar) = "Land_SS_hangar";
GVAR(sm_tent) = "ACamp";
#endif

GVAR(enemyai_mt_start_pos) = [];

_civcenter = createCenter civilian;

#ifdef __OWN_SIDE_WEST__
_eastcenter = createCenter east;
_guercenter = createCenter resistance;
west setFriend [east, 0.1];
east setFriend [west, 0.1];
west setFriend [resistance, 1];
resistance setFriend [west, 1];
east setFriend [resistance, 0.1];
resistance setFriend [east, 0.1];
#endif

#ifdef __OWN_SIDE_EAST__
_westcenter = createCenter west;
_guercenter = createCenter resistance;
west setFriend [east, 0.1];
east setFriend [west, 0.1];
west setFriend [resistance, 0.1];
resistance setFriend [west, 0.1];
east setFriend [resistance, 1];
resistance setFriend [east, 1];
#endif

#ifdef __OWN_SIDE_GUER__
_westcenter = createCenter west;
_eastcenter = createCenter east;
west setFriend [east, 0.1];
east setFriend [west, 0.1];
resistance setFriend [west, 0.1];
resistance setFriend [east, 0.1];
west setFriend [resistance, 0.1];
east setFriend [resistance, 0.1];
#endif

GVAR(ArtyShellsWest) = [
    "ARTY_Flare_Medium", //flare
    "ARTY_Sh_105_HE", // HE
    "ARTY_SmokeShellWhite", // Smoke
    "G_30mm_HE", // dpicm
    "ARTY_Sh_105_SADARM" // SADARM
];

GVAR(ArtyShellsEast) = [
    "ARTY_Flare_Medium", //flare
    "ARTY_Sh_122_HE", // HE
    "ARTY_SmokeShellWhite", // Smoke
    "G_40mm_HE", // dpicm
    "ARTY_Sh_122_SADARM" // SADARM
];

#ifdef __OA__
GVAR(ClamShell) = "76n6ClamShell_EP1";
#endif
#ifdef __CO__
GVAR(ClamShell) = "76n6ClamShell";
#endif
#ifdef __OA__
GVAR(baseAARadarUS) = "US_WarfareBAntiAirRadar_EP1";
GVAR(baseAARadarEast) = "TK_WarfareBAntiAirRadar_EP1";
#endif
#ifdef __CO__
GVAR(baseAARadarUS) = "USMC_WarfareBAntiAirRadar";
GVAR(baseAARadarEast) = "RU_WarfareBAntiAirRadar";
#endif

GVAR(base_aavecs_check) = ["HMMWV_AVENGER", "2S6M_TUNGUSKA", "ZSU_TK_EP1", "HMMWV_AVENGER_DES_EP1", "M6_EP1"]; // toupper!

GVAR(all_simulation_stoped) = false;

GVAR(hd_sim_types) = ["SHOTPIPEBOMB", "SHOTTIMEBOMB"]; // uppercase!

// west, east
GVAR(vec_spawn_default_Crew) =
#ifdef __CO__
    ["USMC_Soldier_Crew", "RU_Soldier_Crew"];
#endif
#ifdef __OA__
    ["US_Soldier_Crew_EP1", "TK_Soldier_Crew_EP1"];
#endif

GVAR(isle_defense_marker) = "n_mech_inf";

// Some inf groups are reduced if no players are near them.
// Here you can set the distance to a player unit.
GVAR(reduce_distance) = 1200;
