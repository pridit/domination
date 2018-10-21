// by Xeno
#define THIS_FILE "x_sidefactory.sqf"
#include "x_setup.sqf"
private ["_b1", "_b2", "_b3", "_b1_down", "_b2_down", "_b3_down"];
if !(call FUNC(checkSHC)) exitWith {};

PARAMS_3(_b1,_b2,_b3);

_b1_down = false;
_b2_down = false;
_b3_down = false;

#ifdef __TT__
GVAR(sm_points_west) = 0;
GVAR(sm_points_east) = 0;
_b1 addEventHandler ["killed", {_this call FUNC(AddSMPoints)}];
_b2 addEventHandler ["killed", {_this call FUNC(AddSMPoints)}];
_b3 addEventHandler ["killed", {_this call FUNC(AddSMPoints)}];
#endif

while {!_b1_down && {!_b2_down} && {!_b3_down}} do {
    __MPCheck;
    if (!_b1_down && {!alive  _b1}) then {_b1_down = true};
    if (!_b2_down && {!alive  _b2}) then {_b2_down = true};
    if (!_b3_down && {!alive  _b3}) then {_b3_down = true};
    sleep 5.321;
};

#ifndef __TT__
GVAR(side_mission_winner) = 2;
#else
if (GVAR(sm_points_west) > GVAR(sm_points_east)) then {
    GVAR(side_mission_winner) = 2;
} else {
    if (GVAR(sm_points_east) > GVAR(sm_points_west)) then {
        GVAR(side_mission_winner) = 1;
    } else {
        if (GVAR(sm_points_east) == GVAR(sm_points_west)) then {
            GVAR(side_mission_winner) = 123;
        };
    };
};
#endif
GVAR(side_mission_resolved) = true;
if (GVAR(IS_HC_CLIENT)) then {
    [QGVAR(sm_var), GVAR(side_mission_winner)] call FUNC(NetCallEventCTS);
};