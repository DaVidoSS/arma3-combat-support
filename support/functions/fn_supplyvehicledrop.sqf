/*
	Author: DaVidoSS
	Description: init slingload support
	Parameter: 0 ARRAY position
	Parameter: 1 STRING vehicle class or OBJECT vehicle
	usage : SPAWN
	Returns:VOID
*/


params [
["_caller",objNull,[objNull]],
["_heliclass", "", [""]],
["_vehclass", "",[""]],
["_position",[],[[]]],
["_marker","",[""]]
];

	private ["_spawnVehpos", "_vehicle", "_helipilottype", "_helispawnpos", "_side", "_flightalt", "_timetodel", "_fullcrew", "_dropposcor", "_globalVar"];

	_side = side _caller;
	_vehicle = objNull;
	
	0 = [support_hqts, "drop_request"] remoteExec ["sideRadio", _side, false];
	sleep 4;
	0 = [support_hqts,"drop_acknowledged"] remoteExec ["sideRadio", _side, false];
	
	_spawnVehpos = [getPos player, 2000, 3000, 10, 0, 0.4, 0, allMapMarkers, []] call BIS_fnc_findSafePos;
	_vehicle = _vehclass createVehicle _spawnVehpos;

	_helipilottype = ["O_helipilot_F", "B_Helipilot_F", "I_helipilot_F"] select ([EAST,WEST,INDEPENDENT] find _side);
	_helispawnpos = [getPos _vehicle, 10, 1000, 10, 0, 0.4, 0, allMapMarkers, []] call BIS_fnc_findSafePos;
	_flightalt = 50;
	_timetodel = 0;
	_fullcrew = false;
	_dropposcor = false;
	_globalVar = "CargoHeli1";

	0 = [
	_heliclass, _helipilottype, _helispawnpos, _side, _flightalt, _vehicle,
	_position, _timetodel, _helispawnpos, _fullcrew, _dropposcor, _globalVar, _caller,_marker] remoteExec ["SUPP_fnc_handleCargoLift", 2, false];
	missionNamespace setVariable ["support_ready",false,true];