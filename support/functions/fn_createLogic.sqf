/*
MWF_fnc_createLogic by DaVidoSS
Description: dynamically created HQ modules for usage with side radio side chat and others
Parameters : 0 - SIDE  players side
Parameters : 1 - BOOLEAN dynamic simulation on /of
Usage : spawn 
Returns : VOID
*/
params [

	["_side",sideUnknown,[sideUnknown]],
	["_dynamicSim",false,[true]]
];

private ["_sideNum","_logicCenter","_logicGroup","_hqPapa"];

if (!isServer) exitWith {};

_sideNum = [0,1,2] select ([EAST,WEST,INDEPENDENT] find _side);
_logicCenter = createCenter sideLogic;

//PAPA-BEAR
_logicGroup = createGroup _logicCenter;
_hqPapa = _logicGroup createUnit ["ModuleHQ_F", [0,0,0], [], 0, "NONE"];
if (_dynamicSim) then {
	_hqPapa triggerDynamicSimulation false; 
};
_hqPapa setVehicleVarName "hq_logic_papa";
hq_logic_papa = _hqPapa;
publicVariable "hq_logic_papa";

_hqPapa setVariable ["callsign","STR_A3_CfgHQIdentities_BLU_0",true];
_hqPapa setVariable ["side",_sideNum,true];
_hqPapa setVariable ["identity",1,true];
_hqPapa setVariable ["callsigncustom","PAPA-BEAR",true];

0 = [_hqPapa,"init"] remoteExec ["BIS_fnc_moduleInit", 0, true];
0 = [_hqPapa] remoteExec ["BIS_fnc_moduleHQ", 0, true];


//SUPPORT-HQ
_logicGroup = createGroup _logicCenter;
_hqPapa = _logicGroup createUnit ["ModuleHQ_F", [0,0,0], [], 0, "NONE"];
if (_dynamicSim) then {
_hqPapa triggerDynamicSimulation false; 
};
_hqPapa setVehicleVarName "support_hqts";
support_hqts = _hqPapa;
publicVariable "support_hqts";

_hqPapa setVariable ["callsign","STR_A3_CfgHQIdentities_Base_0",true];
_hqPapa setVariable ["side",_sideNum,true];
_hqPapa setVariable ["identity",0,true];
_hqPapa setVariable ["callsigncustom","SUPPORT-HQ",true];

0 = [_hqPapa,"init"] remoteExec ["BIS_fnc_moduleInit", 0, true];
0 = [_hqPapa] remoteExec ["BIS_fnc_moduleHQ", 0, true];