/*	
	SUPP_fnc_artillery
	Author: DaVidoSS
	Description: create comms menu and call ordnance from server
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
["_index",0,[0]]
];

strike = [];
MENU_COMMS_ARTY_0 =
[
["Submenu",false],
["Shell Smoke", [2], "", -5, [["expression", "strike pushBack 'smoke';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["Shell Flare", [3], "", -5, [["expression", "strike pushBack 'flare';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["Shell HE", [4], "", -5, [["expression", "strike pushBack 'he';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]

];

MENU_COMMS_ARTY_1 =
[
["Submenu",false],
["", [2], "", -5, [["expression", "strike pushBack (1);"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["", [3], "", -5, [["expression", "strike pushBack (2);"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["", [4], "", -5, [["expression", "strike pushBack (3);"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["", [5], "", -5, [["expression", "strike pushBack (4);"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["", [6], "", -5, [["expression", "strike pushBack (5);"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["", [7], "", -5, [["expression", "strike pushBack (6);"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["", [8], "", -5, [["expression", "strike pushBack (7);"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["", [9], "", -5, [["expression", "strike pushBack (8);"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
];

MENU_COMMS_ARTY_2 =
[
["Submenu",false],
["Direct Hit", [2], "", -5, [["expression", "strike pushBack 'direct_hit';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["Suppress Area", [3], "", -5, [["expression", "strike pushBack 'suppress_area';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
["Danger Close", [4], "", -5, [["expression", "strike pushBack 'danger_close';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
];

showCommandingMenu "#USER:MENU_COMMS_ARTY_0";
waitUntil {count strike > 0 || commandingMenu == ""};
if (count strike == 0) exitWith {};
showCommandingMenu "#USER:MENU_COMMS_ARTY_1";
waitUntil {count strike > 1 || commandingMenu == ""};
if (count strike == 1) exitWith {};
showCommandingMenu "#USER:MENU_COMMS_ARTY_2";
waitUntil {count strike > 2 || commandingMenu == ""};	
if (count strike == 2) exitWith {};
{strike pushBack _x} forEach _this;


if !(missionNamespace getVariable ["support_ready",false]) exitWith {
	0 = [support_hqts,"artillery_destroyed"] remoteExec ["sideRadio", side _caller, false];
	if (random 1 < 0.25) then {
	sleep 4;
		if (isNull objectParent _caller) then {
			0 = [_caller, ["fucksake", 100, 1]] remoteExec ["say3D", [0,-2] select isDedicated, false];
		} else {
			0 = [(vehicle _caller),"Ooh for fuck sake!"] remoteExecCall ["vehicleChat", (crew (vehicle _caller)) select {isPlayer _x}, false];
		};
	};
};

0 = strike remoteExec ["SUPP_fnc_ordnance",2,false];