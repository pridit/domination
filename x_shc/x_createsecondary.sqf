// by Xeno
#define THIS_FILE "x_createsecondary.sqf"
#include "x_setup.sqf"

#define __getPos \
_poss = [_posarx, _mtradius] call FUNC(GetRanPointCircleBig);\
if (isOnRoad _poss) then {_poss = []};\
while {count _poss == 0} do {\
    _poss = [_posarx, _mtradius] call FUNC(GetRanPointCircleBig);\
    if (isOnRoad _poss) then {_poss = []};\
}

#define __specops \
__GetEGrp(_newgroup)\
_unit_array = [#specops, GVAR(enemy_side)] call FUNC(getunitliste);\
[_poss, _unit_array select 0, _newgroup,true] spawn FUNC(makemgroup);\
sleep 1.0112;\
_newgroup allowFleeing 0;\
_newgroup setVariable [QGVAR(defend), true]; \
[_newgroup, _poss] spawn FUNC(taskDefend); \
_newgroup setVariable [QGVAR(gstate), 1]; \
if (GVAR(doRespawnGroups)) then { \
    GVAR(reduce_groups) set [count GVAR(reduce_groups), _newgroup]; \
};

private ["_poss", "_newgroup", "_vehicle", "_mtmhandle", "_dummy", "_act2", "_nrcamps", "_i", "_wf", "_flagPole", "_trg_center", "_posarx"];
if !(call FUNC(checkSHC)) exitWith {};

PARAMS_3(_wp_array,_mtradius,_trg_center);

sleep 3.120;

_mtmhandle = _wp_array execVM "x_mtmissions\x_getmtmission.sqf";

waitUntil {sleep 0.321;scriptDone _mtmhandle};

sleep 5.0123;

__TargetInfo

_posarx = _trg_center;
__getPos;
_vehicle = createVehicle [GVAR(illum_tower), _poss, [], 0, "NONE"];
_vehicle setPos _poss;
_vehicle setVectorUp [0,0,1];
[_vehicle] call FUNC(CheckMTHardTarget);
[_vehicle, __XJIPGetVar(GVAR(current_target_index))] spawn FUNC(fixor);
[QGVAR(mt_radio_down),false] call FUNC(NetSetJIP);
["mt_radio_pos",_poss] call FUNC(NetSetJIP);
[QGVAR(main_target_radiotower), _poss,"ICON","ColorBlack",[0.5,0.5],(localize "STR_DOM_MISSIONSTRING_521"),0,"mil_dot"] call FUNC(CreateMarkerGlobal);

#ifndef __TT__
[QGVAR(kbmsg), [9]] call FUNC(NetCallEventCTS);
#else
[QGVAR(kbmsg), [10]] call FUNC(NetCallEventCTS);
#endif
sleep 1.0112;
__specops;

sleep 5.234;
_dummy = GVAR(target_names) select __XJIPGetVar(GVAR(current_target_index));
_current_target_pos = _dummy select 0;
_current_target_radius = _dummy select 2;
_act2 = GVAR(enemy_side) + " D";
GVAR(mt_spotted) = false;
GVAR(f_check_trigger) = [_current_target_pos, [_current_target_radius + 300, _current_target_radius + 300, 0, false], [GVAR(own_side_trigger), _act2, false], ["this", "0 = 0 spawn {if (!d_create_new_paras) then {d_create_new_paras = true;0 execFSM 'fsms\Parahandler.fsm'};d_mt_spotted = true;['d_kbmsg', [12]] call d_fnc_NetCallEventCTS;sleep 5;deleteVehicle d_f_check_trigger}", ""]] call FUNC(CreateTrigger);

sleep 5.234;
_d_currentcamps = [];
_nrcamps = ceil random 5;
if (_nrcamps < 3) then {_nrcamps = 3};
_ctype = GVAR(wcamp);

GVAR(sum_camps) = _nrcamps;
if (!isServer) then {
    [QGVAR(sSetVar), [QGVAR(sum_camps), _nrcamps]] call FUNC(NetCallEventCTS);
};
_posarx = _trg_center;
for "_i" from 1 to _nrcamps do {
    __getPos;
    _wf = createVehicle [_ctype, _poss, [], 0, "NONE"];
    _wf setDir floor random 360;
    _svec = sizeOf _ctype;
    _xcountx = 0;
    _isFlat = [];
    while {_xcountx < 99} do {
        _isFlat = (position _wf) isFlatEmpty [_svec / 2, 150, 0.7, _svec, 0, false, _wf];
        if (count _isFlat > 0) then {
            _isFlat set [2, 0];
            if (!isOnRoad _isFlat) then {
                _poss = _isFlat;
            } else {
                _isFlat = [];
            };
        };
        if (count _isFlat > 0) exitWith {};
        __INC(_xcountx);
    };
    _poss set [2, 0];
    _wf setPos _poss;
    _d_currentcamps set [count _d_currentcamps, _wf];
    _wf setVariable [QGVAR(SIDE), GVAR(enemy_side), true];
    _wf setVariable [QGVAR(INDEX), _i, true];
    _wf setVariable [QGVAR(CAPTIME), 40 + (floor random 10), true];
    _wf setVariable [QGVAR(CURCAPTIME), 0, true];
    #ifndef __TT__
    _wf setVariable [QGVAR(CURCAPTURER), GVAR(own_side_trigger)];
    #else
    _wf setVariable [QGVAR(CURCAPTURER), ""];
    #endif
    _wf setVariable [QGVAR(STALL), false, true];
    _wf setVariable [QGVAR(TARGET_MID_POS), _trg_center];
    _flagPole = createVehicle [(call FUNC(GetEnemyFlagType)), position _wf, [], 0, "NONE"];
    _flagPole setPos (position _wf);
    _wf setVariable [QGVAR(FLAG), _flagPole, true];
    _maname = format[QGVAR(camp%1),_i];
    _wf setVariable [QGVAR(markername), _maname];
    [_maname, _poss,"ICON","ColorBlack",[0.5,0.5],"",0,"Strongpoint"] call FUNC(CreateMarkerGlobal);
    
    _wf addEventHandler ["HandleDamage", {0}];
    [_wf, _flagPole] execFSM "fsms\HandleCamps2.fsm";
    sleep 0.5;
};
[QGVAR(currentcamps),_d_currentcamps] call FUNC(NetSetJIP);
__XJIPSetVar [QGVAR(campscaptured), 0, true];
//__XJIPSetVar [QGVAR(numcamps), _nrcamps];
[QGVAR(kbmsg), [15, _nrcamps]] call FUNC(NetCallEventCTS);

sleep 5.213;
GVAR(main_target_ready) = true;
if (!isServer) then {
    [QGVAR(sSetVar), [QGVAR(main_target_ready), true]] call FUNC(NetCallEventCTS);
};

sleep 5;
[__XJIPGetVar(GVAR(current_target_index)), _current_target_pos] execFSM "fsms\CampIntegrity.fsm";
