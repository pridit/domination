// by Xeno
private ["_newgroup", "_poss", "_fortress", "_bpos", "_leader"];
#include "x_setup.sqf"

_mpos = markerPos QGVAR(sm_12);
_mpos set [2,0];
_mpos2 = markerPos QGVAR(sm_12_1);
_mpos2 set [2,0];
GVAR(x_sm_pos) = [_mpos, _mpos2]; // index: 12,   Officer at Lake Charsu
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (X_Client && {!GVAR(IS_HC_CLIENT)}) then {
    GVAR(current_mission_text) = (localize "STR_DOM_MISSIONSTRING_828");
    GVAR(current_mission_resolved_text) = (localize "STR_DOM_MISSIONSTRING_735");
};

if (call FUNC(checkSHC)) then {
    __PossAndOther
    ["shilka", 1, "bmp", 1, "tank", 0, _pos_other,1,0] spawn FUNC(CreateArmor);
    sleep 2.123;
    __GetEGrp(_newgroup)
    _fortress = createVehicle [GVAR(sm_fortress), _poss, [], 0, "NONE"];
    _fortress setDir (markerDir QGVAR(sm_12));
    _fortress setPos _poss;
    __AddToExtraVec(_fortress)
    _sm_vehicle = _newgroup createUnit [GVAR(soldier_officer), _poss, [], 0, "FORM"];
    if (GVAR(without_nvg) == 0) then {
        if (_sm_vehicle hasWeapon "NVGoggles") then {_sm_vehicle removeWeapon "NVGoggles"};
    };
    _sm_vehicle setVariable ["BIS_noCoreConversations", true];
    __addDeadAI(_sm_vehicle)
    if (GVAR(domdatabase)) then {
        _sm_vehicle addEventHandler ["killed", {if (isPlayer (_this select 1)) then {[QGVAR(PAIKP), _this select 1] call FUNC(NetCallEventCTS)}}];
    };
    _sm_vehicle addEventHandler ["killed", {_this call FUNC(KilledSMTargetNormal)}];
    sleep 2.123;
    _bpos = position _fortress;
    _sm_vehicle setPos _bpos;
    sleep 2.123;
    _leader = leader _newgroup;
    _leader setRank "COLONEL";
    _newgroup allowFleeing 0;
    _newgroup setbehaviour "AWARE";
    _leader disableAI "MOVE";
    sleep 2.123;
    ["specops", 2, "basic", 1, _poss,0] spawn FUNC(CreateInf);
};