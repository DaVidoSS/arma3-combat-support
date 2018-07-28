params [ 
	["_caller", objNull,[objNull]],
	["_desiredpos", [], [[]]],
	["_targetObj", objNull, [objNull]],
	["_is3D",true,[true]],
	["_index",0,[0]]
];

private ["_targets", "_feed", "_origFeedPosScale", "_fnc_resizePIP", "_killFeed"];


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
	
missionNamespace setVariable ["support_ready",false,true];
_fnc_resizePIP = {

	params[ "_dispPos", "_scale" ];
	private ["_display", "_basePos", "_baseScale", "_scaleDiff", "_ctrl", "_diff", "_newpos"];		
	_display = uiNamespace getVariable "BIS_fnc_PIP_RscPIP";
	_basePos = ctrlPosition ( _display displayCtrl 2300 );
	_baseScale = ctrlScale ( _display displayCtrl 2300 );
	_scaleDiff = _scale / _baseScale;
	{
		_ctrl = _x;
		_pos = ctrlPosition _ctrl;
		_pos resize 2;
			{
				_diff = _x - ( _basePos select _forEachIndex );
				_newpos = ( _dispPos select _forEachIndex ) + ( _diff * _scaleDiff );
				_pos set [ _forEachIndex, _newpos ];
			}forEach _pos;
		_ctrl ctrlSetPosition _pos;
		_ctrl ctrlSetScale _scale;
		_ctrl ctrlCommit 0;
	}forEach allControls _display;
			
	[ _basePos, _baseScale ]
};
if (_desiredpos isEqualTo []) then {_desiredpos = getPos _caller};

0 = [_desiredpos,side _caller] remoteExec ["MWF_fnc_uavFeed",2,false];

waitUntil {sleep 1; !isNil "uavspy" && {(uavspy distance2d _desiredpos) < 500}};

_targets = ((entities [["Man","Tank","Car","Air"], [], false, true]) select {!((side _x) isEqualTo (side _caller)) && {(side _x) != CIVILIAN} && {(position _x) inArea [_desiredpos, 1000, 1000, 360, false, -1]}});


if !(_targets isEqualTo []) then {

	{
		_target = _x;

		_feed = [ getPos uavspy vectorAdd [ 0, 0, -1 ], _target, _caller ] call BIS_fnc_liveFeed;
		 
		if (_feed) then {

			waitUntil {sleep 1; !isNil "BIS_livefeed" };
			
			//Question 1 : Attach camera below drone
			BIS_livefeed attachTo [ uavspy, [ 0, 0, -1 ] ];
			


			sleep 5;
			
			//Set feed display size and position
			_origFeedPosScale = [ [ 0, 0 ], 5 ] call _fnc_resizePIP;
			
			//Zoom camera
			for "_zoom" from 2 to 0 step -0.1 do {
				//Question 3
				BIS_liveFeed camPrepareFov _zoom;
				BIS_livefeed camCommitPrepared 0;
				sleep 0.5;
			};

			sleep 5;

			//Set feed display back to default size and position
			_origFeedPosScale call _fnc_resizePIP;
			sleep 5;
			_killFeed = [] call BIS_fnc_liveFeedTerminate;
			waitUntil {_killFeed};
		};
	} forEach _targets;
	
	sleep 10;
	deleteVehicle uavspy;
};
missionNamespace setVariable ["support_ready",true,true];