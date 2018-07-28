/*
	Author: DaVidoSS
	Description: init supply drop
	Parameter: 0:OBJECT player object
	Parameter: 1:ARRAY position array
	usage : SPAWN
	Returns:VOID
*/
params [
["_caller",objNull,[objNull]],
["_heliclass", "", [""]],
["_boxclass", "Box_NATO_AmmoVeh_F",[""]],
["_position",[],[[]]],
["_marker","",[""]]
];

private _side = side _caller;
private _chuteType = ["O_Parachute_02_F","B_Parachute_02_F","I_Parachute_02_F"] select ([EAST,WEST,INDEPENDENT] find _side);
private _boxCode = compile "0 = _this spawn SUPP_fnc_dropboxInit;";
private _helistart = [getPos _caller, 2500, 3500, 10, 0, 0.6, 0, allMapMarkers, [0,0,0]] call BIS_fnc_findSafePos; 

0 = [[_caller,_position,_heliclass,_boxclass,_chuteType,_boxCode,_helistart,_side,_marker],
AIR_SUPPORT_PATH+"supplydrop.fsm"] remoteExec ["execFSM",2,false];