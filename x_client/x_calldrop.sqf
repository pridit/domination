// by Xeno
#define THIS_FILE "x_calldrop.sqf"
#include "x_setup.sqf"
if (!X_Client) exitWith {};
private ["_array","_control","_display","_oldpos","_exitIt"];

if (!alive player) exitWith {};
if (vehicle player == player && {position player select 2 > 10}) exitWith {};

if (!__XJIPGetVar(para_available)) exitWith {
    (localize "STR_DOM_MISSIONSTRING_163") call FUNC(HQChat);
};

["arti1_marker_1",getPosASL player,"ELLIPSE","ColorYellow",[GVAR(drop_max_dist), GVAR(drop_max_dist)],"",0,"","FDiagonal"] call FUNC(CreateMarkerLocal);

GVAR(x_drop_type) = "";
_oldpos = getPosASL GVAR(X_DropZone);
disableSerialization;
createDialog "XD_AirDropDialog";
#define CTRL(A) (_display displayCtrl A)
_display = __uiGetVar(D_DROP_DIALOG);
_array = GVAR(x_drop_array) select 0;
CTRL(11002) ctrlSetText (_array select 0);
if (count GVAR(x_drop_array) > 1) then {
    _array = GVAR(x_drop_array) select 1;
    CTRL(11003) ctrlSetText (_array select 0);
} else {
    ctrlShow [11003, false];
    ctrlShow [11004, false];
};
if (count GVAR(x_drop_array) > 2) then {
    _array = GVAR(x_drop_array) select 2;
    CTRL(11004) ctrlSetText (_array select 0);
};

waitUntil {GVAR(x_drop_type) != "" || {!GVAR(airdrop_dialog_open)} || {!alive player}};

deleteMarkerLocal "arti1_marker_1";
if (!alive player) exitWith {if (GVAR(airdrop_dialog_open)) then {closeDialog 0}};
if (GVAR(x_drop_type) != "") then {
    _ppl = getPosASL player;
    _ppl set [2,0];
    if (_ppl distance [getPosASL GVAR(X_DropZone) select 0, getPosASL GVAR(X_DropZone) select 1, 0] > GVAR(drop_max_dist)) exitWith {
        (format [(localize "STR_DOM_MISSIONSTRING_166"), GVAR(drop_max_dist)]) call FUNC(HQChat);
        GVAR(x_dropzone) setPosASL _oldpos;
        QGVAR(drop_zone) setMarkerPos _oldpos;
    };
    player kbTell [GVAR(kb_logic1),GVAR(kb_topic_side),"DropCalled",["1","",[GVAR(x_drop_type), 0] call FUNC(GetDisplayName),[]],true];
    [QGVAR(x_dr_t), [GVAR(x_drop_type), markerPos QGVAR(drop_zone), player]] call FUNC(NetCallEventCTS);
} else {
    GVAR(x_dropzone) setPosASL _oldpos;
    QGVAR(drop_zone) setMarkerPos _oldpos;
};