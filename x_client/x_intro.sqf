// by Xeno
#define THIS_FILE "x_intro.sqf"
#include "x_setup.sqf"
private ["_s","_str"];
if (!X_Client) exitWith {};

disableSerialization;

waitUntil {sleep 0.112;!isNil QGVAR(preloaddone)};
sleep 0.01;
1 fadeSound 1;

GVAR(still_in_intro) = true;

//enableRadio false;
showCinemaBorder false;

createDialog "X_RscAnimatedLetters";
setMousePosition [1, 1];
_line = 0;
GVAR(animL_i) = 0;
titleText ["", "BLACK IN",4];

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [6];
"dynamicBlur" ppEffectCommit 0;
"dynamicBlur" ppEffectAdjust [0.0];
"dynamicBlur" ppEffectCommit 15;

if (daytime > 19.75 || daytime < 4.15) then {camUseNVG true};

GVAR(intro_color) = switch (GVAR(own_side)) do {case "WEST": {[0.85,0.88,1,1]};case "EAST": {[1,0.36,0.34,1]};case "GUER": {[1,1,0,1]};};

//_camstart = camstart;
// private "_camera";
// _camera = "camera" camCreate [getPosASL _camstart select 0, (getPosASL _camstart select 1) + 1, 120];
// _camera camSetTarget [getPosASL player select 0, getPosASL player select 1 , 1.5];
// _camera camSetFov 0.7;
// _camera cameraEffect ["INTERNAL", "Back"];
// _camera camCommit 1;
// waitUntil {camCommitted _camera};

_str = "One Team - " + GVAR(version_string);
_start_pos = 5;
_str2 = "";
_sarray = toArray (_str2);
_start_pos2 = switch (count _sarray) do {
    case 2: {11};
    case 3: {11};
    case 4: {10};
    case 5: {10};
    case 6: {9};
    case 7: {9};
    case 8: {8};
    case 9: {8};
    case 10: {8};
    case 11: {7};
    case 12: {6};
    case 13: {5};
    case 14: {5};
    case 15: {4};
    case 16: {3};
    default {1};
};

1 cutRsc ["XDomLabel","PLAIN",2];
2 cutRsc ["XDomAward","PLAIN",2];
3 cutRsc ["XDomTwo", "PLAIN",2];
4 cutRsc ["XA2Logo","PLAIN",2];
sleep 4;
[_start_pos, _str, 5] execVM "IntroAnim\animateLettersX.sqf";__INC(_line); waitUntil {GVAR(animL_i) == _line};
if (count _sarray > 0) then {[_start_pos2, _str2, 6] execVM "IntroAnim\animateLettersX.sqf";__INC(_line); waitUntil {GVAR(animL_i) == _line}};
switch (GVAR(MissionType)) do {
    case 2: {
        [4, (localize "STR_DOM_MISSIONSTRING_263"), 4] execVM "IntroAnim\animateLettersX.sqf";__INC(_line); waitUntil {GVAR(animL_i) == _line};
    };
    case 1: {
        [4, (localize "STR_DOM_MISSIONSTRING_264"), 4] execVM "IntroAnim\animateLettersX.sqf";__INC(_line); waitUntil {GVAR(animL_i) == _line};
    };
};

// _camera camSetTarget player;
// _p_tpos = [getPosASL player select 0, getPosASL player select 1, 2];
// _camera camSetPos _p_tpos;
// _camera camCommit 18;

0 spawn {
    private ["_control", "_posdom", "_control2", "_pos", "_oldy"];
    disableSerialization;
    sleep 3;
    _control = __uiGetVar(XDomLabel) displayCtrl 50;
    _posdom = ctrlPosition _control;
    _control ctrlSetPosition [(_posdom select 0) - 0.08, _posdom select 1];
    _control ctrlCommit 0.3;
    waitUntil {ctrlCommitted _control};
    _control2 = __uiGetVar(XDomTwo) displayCtrl 50;
    _pos = ctrlPosition _control2;
    _control2 ctrlSetPosition [0.69, _pos select 1];
    _control2 ctrlCommit 0.5;
    waitUntil {ctrlCommitted _control2};
    0 cutRsc [QGVAR(Lightning1),"PLAIN"];
    11 cutRsc [QGVAR(Eyeflare),"PLAIN"];
    sleep 0.1;
    playSound "DThunder";
};
55 cutRsc ["dXlabel","PLAIN"];
sleep 14.5;
// waitUntil {camCommitted _camera};
player cameraEffect ["terminate","back"];
// camDestroy _camera;
closeDialog 0;

enableRadio true;
"dynamicBlur" ppEffectEnable false;

private "_uidcheck_done";
_uidcheck_done = false;
if (GVAR(reserved_slot) != "" && {str(player) == GVAR(reserved_slot)}) then {
    _uidcheck_done = true;
    execVM "x_client\x_reservedslot.sqf";
};
if (!_uidcheck_done && {count GVAR(uid_reserved_slots) > 0} && {count GVAR(uids_for_reserved_slots) > 0}) then {
    for "_xi" from 0 to (count GVAR(uid_reserved_slots) - 1) do {
        GVAR(uid_reserved_slots) set [_xi, toUpper (GVAR(uid_reserved_slots) select _xi)];
    };
    if (toUpper str(player) in GVAR(uid_reserved_slots)) then {
        if !(getPlayerUID player in GVAR(uids_for_reserved_slots)) then {
            execVM "x_client\x_reservedslot2.sqf";
        };
        GVAR(uid_reserved_slots) = nil;
        GVAR(uids_for_reserved_slots) = nil;
    };
};

GVAR(still_in_intro) = false;

sleep 5;
// [(localize "STR_DOM_MISSIONSTRING_265"), name player, (localize "STR_DOM_MISSIONSTRING_266")] spawn FUNC(infoText);
sleep 1;
if (!isNil QGVAR(server_name)) then {
    if (isNil QGVAR(player_stats)) then {
        format [localize "STR_DOM_MISSIONSTRING_1438", name player, GVAR(server_name)] call FUNC(GlobalChat);
    } else {
        if (GVAR(player_stats) select 2 > 0) then {
            format [localize "STR_DOM_MISSIONSTRING_1439", name player, GVAR(server_name)] call FUNC(GlobalChat);
        } else {
            format [localize "STR_DOM_MISSIONSTRING_1438", name player, GVAR(server_name)] call FUNC(GlobalChat);
        };
    };
};
if (!isNil QGVAR(player_stats)) then {
    format [localize "STR_DOM_MISSIONSTRING_1440", GVAR(player_stats) select 2, (GVAR(player_stats) select 1) call FUNC(ConvertTime), GVAR(player_stats) select 0] call FUNC(GlobalChat);
};
sleep 7;
xr_phd_invulnerable = false;
__pSetVar ["ace_w_allow_dam", nil];