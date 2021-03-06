// by Xeno
private ["_poss", "_ogroup", "_bpos", "_leadero"];
#include "x_setup.sqf"

_mpos = markerPos QGVAR(sm_11);
_mpos set [2,0];
GVAR(x_sm_pos) = [_mpos]; // Find and eliminate Nib Nedal in the region around mount Bamjahan
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client && {!GVAR(IS_HC_CLIENT)}) then {
    GVAR(current_mission_text) = (localize "STR_DOM_MISSIONSTRING_826");
    GVAR(current_mission_resolved_text) = (localize "STR_DOM_MISSIONSTRING_827");
    [(localize "STR_DOM_MISSIONSTRING_826"), "Assassinate", _mpos] call FUNC(x_newtask);
};

if (call FUNC(checkSHC)) then {
    __PossAndOther
    _newpos = [_poss, 400] call FUNC(GetRanPointCircle);
    __GetEGrp(_ogroup)
    _sm_vehicle = _ogroup createUnit [GVAR(soldier_officer2), _newpos, [], 0, "FORM"];
    _sm_vehicle setPos _newpos;
    if (GVAR(without_nvg) == 0) then {
        if (_sm_vehicle hasWeapon "NVGoggles") then {_sm_vehicle removeWeapon "NVGoggles"};
    };
    _sm_vehicle setVariable ["BIS_noCoreConversations", true];
    __addDead(_sm_vehicle)
    _sm_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetNormal)}];
    sleep 2.123;
    ["specops", 1, "basic", 0, _newpos, 0,true] call FUNC(CreateInf);
    sleep 2.123;
    _leadero = leader _ogroup;
    _leadero setRank "COLONEL";
    _ogroup allowFleeing 0;
    _ogroup setbehaviour "AWARE";
    _leadero disableAI "MOVE";
};