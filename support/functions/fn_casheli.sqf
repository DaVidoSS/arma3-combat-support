/*
	Author: DaVidoSS
	Description: init cas and call fsm from server
	Parameter: 0:OBJECT player object
	Parameter: 1:ARRAY position array
	usage : SPAWN
	Returns:VOID
*/
params [ 
	["_caller", objNull,[objNull]],
	["_desiredpos", [], [[]]]
];

if (isNull _caller) exitWith {};
if !(local _caller) exitWith {};

if (!(isNull objectParent _caller) && {(speed (vehicle _caller)) > 5}) exitWith {

	hint "You cannot call support while driving a vehicle. Stop first"
};

if !(missionNamespace getVariable ["support_ready",false]) exitWith {
	

	0 = [support_hqts, "cas_heli_destroyed"] remoteExec ["sideRadio", side _caller, false];
			
	if (random 1 < 0.25) then {
			
		sleep 5;
		if (isNull objectParent _caller) then {
				
			0 = [_caller, ["fucksake", 100, 1]] remoteExec ["say3D", [0,-2] select isDedicated, false];
					
		} else {
				
			0 = [
				(vehicle _caller),
				"Ooh for fuck sake!"
			] remoteExecCall ["vehicleChat", (crew (vehicle _caller)) select {isPlayer _x}, false];
		};
	};
};
	
if !(isNull objectParent _caller) then {
	
	_desiredpos = getPos (vehicle _caller);
		
} else {
	
	if (_desiredpos isEqualTo []) then {
	
		_desiredpos = getPos _caller;
	};
};
	
private _side = side _caller;
private _heliclass = selectRandom (missionNamespace getVariable ["supp_attackhelis",[]]);
private _helistart = [getPos _caller, 2000, 3000, 10, 0, 0.3, 0, allMapMarkers, [0,0,0]] call BIS_fnc_findSafePos;
 
private _mrkr = createMarker ["cas_target", _desiredpos]; 
_mrkr setMarkerShape "ICON"; 
_mrkr setMarkerColor "Default"; 
_mrkr setMarkerSize [1, 1]; 
_mrkr setMarkerType "KIA"; 
_mrkr setMarkerText "CAS TARGET"; 

0 = [[_caller,_desiredpos,_heliclass,_helistart,_side,_mrkr],
AIR_SUPPORT_PATH+"cas.fsm"] remoteExec ["execFSM",2,false];