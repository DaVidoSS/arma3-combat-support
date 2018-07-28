params [ ["_caller", objNull,[objNull]]];

showCommandingMenu "";
sleep 1;

_side = side _caller;

if !(missionNamespace getVariable ["support_ready",false]) exitWith {
	sleep 1;
	0 = [support_hqts, "drop_destroyed"] remoteExecCall ["sideRadio", _side, false];		
	if (random 1 < 0.25) then {			
		sleep 4;
		if (isNull objectParent player) then {
			0 = [player, ["fucksake", 100, 1]] remoteExec ["say3D", [0,-2] select isDedicated, false];
		} else {
			0 = [(vehicle player),"Ooh for fuck sake!"] remoteExecCall ["vehicleChat", (crew (vehicle player)) select {isPlayer _x}, false];
		};
	};
};

if (!(isNull objectParent _caller) && {(speed (vehicle _caller)) > 5}) exitWith {
	hint "You cannot call support while driving a vehicle. Stop first"
};

supp_array = false;
supportType = "";
supp_param1 = "";
supp_param2 = "";
supp_param3 = "";
supp_param4 = [];

createDialog 'support_call_system_dialog';

waitUntil {supp_array || isNull (findDisplay 11150)};

if (supp_array) then {

	switch supportType do {


		case "Supply Drop" : {
		
			0 = [_caller,supp_param1,supp_param2,supp_param4,supportType] spawn SUPP_fnc_supplydrop;
		};
		case "Vehicle Drop" : {
		
			0 = [_caller,supp_param1,supp_param2,supp_param4,supportType] spawn SUPP_fnc_supplyvehicledrop;
		};
		case "Helicopter Transport" : {

		};
		case "Artillery" : {

		};
		case "CAS Helicopter" : {

		};
		case "Air Strike" : {

		};
		case "UAV Recon" : {

		};
		default {};
	};
};