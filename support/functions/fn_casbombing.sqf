/*	
	SUPP_fnc_artillery
	Author: DaVidoSS
	Description: create comms menu and call CAS from server
	Parameter: 0 OBJECT player
	Parameter: 1 ARRAY position
	Parameter: 2 OBJECT target from cursortarget
	Parameter: 3 BOOLEAN true or false false if call from map
	Parameter: 4 NUMMBER index 
	usage : SPAWN
	Returns:VOID  
*/

	params [ 

		["_caller", objNull,[objNull]],
		["_desiredpos", [], [[]]],
		["_targetObj", objNull, [objNull]],
		["_is3D",true,[true]],
		["_id",0,[0]]
	];
	
	casStrike = -1;
	
	MENU_COMMS_CAS_0 =
	[
		["Submenu",false],
		["Canon", [2], "", -5, [["expression", "casStrike = 0;"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
		["Missiles", [3], "", -5, [["expression", "casStrike = 1;"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
		["Canon + Missiles", [4], "", -5, [["expression", "casStrike = 2;"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
		["Bombs", [5], "", -5, [["expression", "casStrike = 3;"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
	];

	showCommandingMenu "#USER:MENU_COMMS_CAS_0";
	waitUntil {sleep 1; casStrike >= 0 || commandingMenu == ""};
	if (casStrike == -1) exitWith {};
	
	if (isNull _caller) exitWith {};
	if !(local _caller) exitWith {};

	if (!(isNull objectParent _caller) && {(speed (vehicle _caller)) > 5}) exitWith {

		hint "You cannot call support while driving a vehicle. Stop first"
	};
	
	if !(isNull objectParent _caller) then {
		_desiredpos = getPos (vehicle _caller);
	} else {
		if (_desiredpos isEqualTo []) then {
			_desiredpos = getPos _caller;
		};
	};
	
	if !(missionNamespace getVariable ["support_ready",false]) exitWith {
	
		0 = [support_hqts,"cas_bombing_destroyed"] remoteExec ["sideRadio", _side, false];
		
			if (random 1 < 0.25) then {
				sleep 4;
				if (isNull objectParent _caller) then {
				
					0 = [_caller, ["fucksake", 100, 1]] remoteExec ["say3D", [0,-2] select isDedicated, false];
					
				} else {
				
					0 = [(vehicle _caller),"Ooh for fuck sake!"] remoteExecCall ["vehicleChat", (crew (vehicle _caller)) select {isPlayer _x}, false];
				};
			};
	};
	
	_this pushBack casStrike;
	
	0 = _this remoteExec ["SUPP_fnc_casStrike",2,false];