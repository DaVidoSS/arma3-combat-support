//Made by Rockhount - HandleCargoLift Script v1.0
//edit for this mission by DaVidoSS
if (!isServer) exitWith {};

	
	
	_var_Exit = params [

		["_heliType","",[""]],
		["_heliPilotType","",[""]],
		["_heliSpawnPos",[],[[]]],
		["_side",sideUnknown,[sideUnknown]],
		["_flightAlt",50,[0]],
		["_vehicle",objNull,[objNull]],
		["_dropPos",[],[[]]],
		["_delTime",0,[0]],
		["_heliDespawnPos",[],[[]]],
		["_fullCrew",false,[true]],
		["_dropPosCor",false,[true]],
		["_varName","",[""]],
		["_var_caller",objNull,[objNull]],
		["_marker","",[""]]
	];


	private _var_ropeFail = false;
	


	if (!_var_Exit) exitWith {
		diag_log "HandleCargoLift Error: Wrong parameters";
	};

	if (!canSuspend) exitWith {
		diag_log "HandleCargoLift Error: This script does not work in an unscheduled environment";
	};

	private _fnc_SearchRealTimeErrors = {

		params ["_var_AirVehicle", "_var_Cargo"];
		
		private _var_return = false;
		private _var_handle_Ropes = false;
		private _var_handle_alive = false;
		
		if ((isNull _var_Cargo) || {!alive _var_Cargo}) then {

				_var_AirVehicle call _fnc_ManageRopes;
				diag_log "HandleCargoLift Error: Cargo got destroyed";
				_var_handle_Ropes = true;
		};

		{
			if (isNull _x || !alive _x || !canMove _x) then {

				diag_log "HandleCargoLift Error: Helicopter or Pilot got destroyed";
				_var_handle_alive = true;
			};
			
		} forEach [_var_AirVehicle, driver _var_AirVehicle];

		if (((count (ropes _var_AirVehicle)) > 0) && (count (ropeAttachedObjects _var_AirVehicle)) isEqualTo 0) then {

			_var_AirVehicle call _fnc_ManageRopes;
			diag_log "HandleCargoLift Error: Cargo has been lost";
			_var_handle_Ropes = true;
		};
					
		if (_var_handle_Ropes) then {

			deleteVehicle _var_Cargo;
		};
		
		if (_var_handle_alive || _var_handle_Ropes) then {
			_var_return = true;
		};
		
		(_var_return)
	};
	
	
	private _fnc_SpawnVehicle = {

		params [
			["_var_Pos", [],[[]]],
			["_var_VehType","",[""]],
			["_var_UnitType","",[""]],
			["_var_Side",sideUnknown,[sideUnknown]],
			["_var_SpawnFullCrew",false,[true]]
		];

		private ["_var_Group", "_var_Vehicle", "_var_CurSeatCount", "_var_CurUnit"];

		_var_Group = createGroup _var_Side;
		_var_Vehicle = createVehicle [_var_VehType, _var_Pos, [], 0, "FLY"];
		_var_Vehicle setPosATL [_var_Pos select 0,_var_Pos select 1,100];


		_var_CurSeatCount = _var_Vehicle emptyPositions "Driver";

		if (_var_CurSeatCount > 0) then {

			_var_CurUnit = _var_Group createUnit [_var_UnitType, _var_Pos, [], 0, "NONE"];
			_var_CurUnit assignAsDriver _var_Vehicle;
			_var_CurUnit moveInDriver _var_Vehicle;
		};

		if (_var_SpawnFullCrew) then {

			_var_CurSeatCount = _var_Vehicle emptyPositions "Commander";

				if (_var_CurSeatCount > 0) then {

					_var_CurUnit = _var_Group createUnit [_var_UnitType, _var_Pos, [], 0, "NONE"];
					_var_CurUnit assignAsCommander _var_Vehicle;
					_var_CurUnit moveInCommander _var_Vehicle;
				};

			_var_CurSeatCount = _var_Vehicle emptyPositions "Gunner";

				if (_var_CurSeatCount > 0) then {

					_var_CurUnit = _var_Group createUnit [_var_UnitType, _var_Pos, [], 0, "NONE"];
					_var_CurUnit assignAsGunner _var_Vehicle;
					_var_CurUnit moveInGunner _var_Vehicle;
				};
		};
		
		if (dynamicSimulationSystemEnabled) then {
			{_x triggerDynamicSimulation false} forEach ((units _var_Group) + [_var_Vehicle]);
		};

		_var_Vehicle
	};


	private _fnc_ControlHeight = {

		params [

			["_var_AirVeh",objNull,[objNull]],
			["_var_FlightAltitude",50,[0]]
		];

		while {alive _var_AirVeh} do {

			if (((getPosATL _var_AirVeh) select 2) <= _var_FlightAltitude) then {

				_var_AirVeh setVelocity ((velocity _var_AirVeh) vectorAdd [0,0,.3]);
			};
			sleep .1;
		};
	};


	private _fnc_ManageRopes = {

		params [

			["_var_AirVehicle",objNull,[objNull]],
			["_var_Cargo",objNull,[objNull]]
		];

		private ["_var_AirVehicleSlingLoadPoint", "_var_CargoSlingLoadPoints", "_var_FakeRope", "_var_Rope"];
		
		if !(isNull _var_Cargo) then {

			_var_AirVehicleSlingLoadPoint = getText (configFile >> "CfgVehicles" >> typeOf _var_AirVehicle >> "slingLoadMemoryPoint");
			_var_CargoSlingLoadPoints = getArray (configFile >> "CfgVehicles" >> typeOf _var_Cargo >> "slingLoadCargoMemoryPoints");
			_var_FakeRope = ropeCreate [_var_AirVehicle, _var_AirVehicleSlingLoadPoint, 1];
			ropeUnwind [_var_FakeRope, 12, (_var_AirVehicle distance _var_Cargo)];
			sleep ((_var_AirVehicle distance _var_Cargo) / 12);
			ropeDestroy _var_FakeRope;

			{
				_var_Rope = ropeCreate [_var_AirVehicle, _var_AirVehicleSlingLoadPoint, _var_Cargo, _x, (_var_AirVehicle distance _var_Cargo)];
				
				if !(isNil "_var_Rope") then {

					ropeUnwind [_var_Rope, 5, (_var_AirVehicle distance _var_Cargo) / 3];
				} else {

					diag_log "HandleCargoLift Error: Cant create rope";
				};
			} forEach _var_CargoSlingLoadPoints;

			sleep ((((_var_AirVehicle distance _var_Cargo) / 3) * 2) / 5);

			if ((ropeAttachedObjects _var_AirVehicle) isEqualTo []) exitWith {

				diag_log "HandleCargoLift Error: Cant create ropes";
				_var_ropeFail = true;
			};

		
		} else {

			_var_AirVehicle setVariable ["Object_var_RopeCount", (count (ropes _var_AirVehicle)), false];

			{
				0 = [_x, _var_AirVehicle] spawn {

					params [

						["_var_Rope",objNull,[objNull]],
						["_var_AirVehicle",objNull,[objNull]]
					];

					ropeUnwind [_var_Rope, 2.5, ((getPos _var_AirVehicle) select 2)];
					sleep ((((getPos _var_AirVehicle) select 2) - (ropeLength _var_Rope)) / 2.5);
					ropeCut [_var_Rope, (ropeLength _var_Rope) - 1];
					ropeUnwind [_var_Rope, 12, 1];
					sleep (((ropeLength _var_Rope) - 1) / 12);
					ropeDestroy _var_Rope;
					_var_AirVehicle setVariable ["Object_var_RopeCount", (_var_AirVehicle getVariable "Object_var_RopeCount") - 1, false];
				};
			} forEach (ropes _var_AirVehicle);

			waitUntil {sleep 1;(_var_AirVehicle getVariable "Object_var_RopeCount") < 1};
		};	
	};


	private _fnc_AutoHover = {

		params [
			["_var_AirVehicle",objNull,[objNull]],
			["_var_Cargo",objNull,[objNull]],
			["_var_CatchPos",[],[[]]],
			["_var_Distance",0,[0]]
		];

		private ["_var_Index", "_var_Dir", "_hoverFail", "_status"];
		
		_hoverFail = false;
		_var_Index = 1;

		while {(_var_AirVehicle distance2D _var_CatchPos) > _var_Distance} do {

				_var_Dir = ((getDir _var_AirVehicle) + (_var_AirVehicle getRelDir _var_CatchPos));
				_var_AirVehicle setVelocity (velocity _var_AirVehicle vectorAdd [sin _var_Dir * 0.20,cos _var_Dir * 0.20,0]);
				_var_Index = _var_Index + 1;
				if ((_var_Index % 20) == 0) then
				{
					_status = [_var_AirVehicle, _var_Cargo] call _fnc_SearchRealTimeErrors;
					if (_status) exitWith {_hoverFail = true};
				};
			sleep 0.1;
			if (_hoverFail) exitWith {};
		};
	};
	
	private _fnc_clear = {

		params [ 
			["_var_AirVehicle",objNull,[objNull]],
			["_var_Group",grpNull,[grpNull]],
			["_varName","",[""]],
			["_var_caller",objNull,[objNull]],
			["_var_cargo",objNull,[objNull]],
			["_mark",nil,[""]]
		];
		private _var_Side = side _var_Group;
		0 = [support_hqts, "drop_destroyed"] remoteExec ["sideRadio", side _var_Group, false];
				
		if (alive _var_caller && (random 1 < 0.25)) then {
				
			sleep 4;
			if (isNull objectParent _var_caller) then {
				
				0 = [_var_caller, ["fucksake", 100, 1]] remoteExec ["say3D", [0,-2] select isDedicated, false];
					
			} else {
				
				0 = [
					(vehicle _var_caller),
					"Ooh for fuck sake!"
				] remoteExecCall ["vehicleChat", (crew (vehicle _var_caller)) select {isPlayer _x}, false];
			};					
		};
		
		sleep 60;
		{
		_var_AirVehicle deleteVehicleCrew _x
		} forEach (crew _var_AirVehicle);
		 		
		deleteVehicle _var_AirVehicle;
		deleteGroup _var_Group;
		if (!isNull _var_cargo && {((crew _var_cargo) select {alive _x}) isEqualTo []}) then {
			deleteVehicle _var_cargo;
		};
		missionNamespace setVariable [_varName, nil, true];
		missionNamespace setVariable ["support_ready",true,true];
		0 = [support_hqts,"support_standby"] remoteExec ["sideRadio", _var_Side, false];
		if !(isNil "_mark") then {deleteMarker _mark};
	};
	

	
	private _fnc_returnToSpawn = {
	
		params [
		
			["_heliDespawnPos",[],[[]]],
			["_var_AirVehicle",objNull,[objNull]],
			["_var_Pilot",objNull,[objNull]],
			["_var_Group",grpNull,[grpNull]],
			["_flightAlt",50,[0]],
			["_varName","",[""]],
			["_var_caller",objNull,[objNull]],
			["_mark",nil,[""]]
		];

		_var_AirVehicle flyinheight _flightAlt;
		_var_Pilot doMove _heliDespawnPos;
		_var_Group setSpeedMode "NORMAL";
		_var_Side = side _var_Group;	
		waitUntil {
			sleep 2;
			((_var_AirVehicle distance2D _heliDespawnPos) < 500 && {(speed _var_AirVehicle) < 2}) ||
			{(!alive _var_AirVehicle || {!alive _var_Pilot || {!canMove _var_AirVehicle}})}
		};

		if ((_var_AirVehicle distance2D _heliDespawnPos) > 500) exitWith {
		
			0 = [support_hqts, "drop_destroyed"] remoteExec ["sideRadio", side _var_Group, false];
				
			if (alive _var_caller && (random 1 < 0.25)) then {
				
				sleep 4;
				if (isNull objectParent _var_caller) then {
				
					0 = [_var_caller, ["fucksake", 100, 1]] remoteExec ["say3D", [0,-2] select isDedicated, false];
					
				} else {
				
					0 = [
						(vehicle _var_caller),
						"Ooh for fuck sake!"
					] remoteExecCall ["vehicleChat", (crew (vehicle _var_caller)) select {isPlayer _x}, false];
				};					
			};
		
			sleep 60;
			{
			_var_AirVehicle deleteVehicleCrew _x
			} forEach (crew _var_AirVehicle);
					
			deleteVehicle _var_AirVehicle;
			deleteGroup _var_Group;
			missionNamespace setVariable [_varName, nil, true];
			missionNamespace setVariable ["support_ready",true,true];	
			0 = [support_hqts,"support_standby"] remoteExec ["sideRadio", _var_Side, false];
		};
			
			sleep 2;
			{
			_var_AirVehicle deleteVehicleCrew _x
			} forEach (crew _var_AirVehicle);
					
			deleteVehicle _var_AirVehicle;
			deleteGroup _var_Group;
			missionNamespace setVariable [_varName, nil, true];
			missionNamespace setVariable ["support_ready",true,true];
			0 = [support_hqts,"support_standby"] remoteExec ["sideRadio", _var_Side, false];
			if !(isNil "_mark") then {deleteMarker _mark};
	};
	
	
	//Transportation
	private _var_AirVehicle = [_heliSpawnPos, _heliType, _heliPilotType, _side, _fullCrew] call _fnc_SpawnVehicle;
	private _var_Pilot = driver _var_AirVehicle;
	private _var_Group = group _var_Pilot;
	[_var_AirVehicle, _flightAlt / 2] spawn _fnc_ControlHeight;
	
	if !(_varName isEqualTo "") then {
		missionNamespace setVariable [_varName, _var_AirVehicle, true];
	};
	
	_vehicle enableRopeAttach true;
	private _var_CurDropPos = _dropPos findEmptyPosition [1,150,typeOf _vehicle];
		
	if (_var_CurDropPos isEqualTo 0) then {
				
		_var_CurDropPos = _dropPos findEmptyPosition [1,150];
	};
	private _var_CatchPos = (getPosATL _vehicle) vectorAdd [0,0, _flightAlt / 2];
				
	//Flight
	_var_Pilot doMove _var_CatchPos;
	_var_Group setSpeedMode "NORMAL";
	_var_Group setBehaviour "CARELESS";
	_var_AirVehicle flyinheight _flightAlt;
		
	waitUntil {
		sleep 3;
		([_var_AirVehicle, _vehicle] call _fnc_SearchRealTimeErrors) ||
		(_var_AirVehicle distance _var_CatchPos) < 200
	};
		
	if ( !alive _var_AirVehicle || {!alive _var_Pilot || {!canMove _var_AirVehicle}}) exitWith {
		[_var_AirVehicle, _var_Group, _varName, _var_caller,_vehicle,_marker] call _fnc_clear;
	};
	//Hover
	_var_Group setSpeedMode "LIMITED";
	_var_AirVehicle flyinheight (_flightAlt / 2);
		
	waitUntil {
		sleep 1;
		([_var_AirVehicle, _vehicle] call _fnc_SearchRealTimeErrors) ||
		(_var_AirVehicle distance2D _var_CatchPos) < 100 ||
		(speed _var_AirVehicle) < 5
	};
		
	if ( !alive _var_AirVehicle || {!alive _var_Pilot || {!canMove _var_AirVehicle}}) exitWith {
		[_var_AirVehicle, _var_Group, _varName, _var_caller,_vehicle,_marker] call _fnc_clear;
	};
		
	[_var_AirVehicle, _vehicle, _var_CatchPos, 2] call _fnc_AutoHover;
	
	if ( !alive _var_AirVehicle || {!alive _var_Pilot || {!canMove _var_AirVehicle}}) exitWith {
		[_var_AirVehicle, _var_Group, _varName, _var_caller,_vehicle,_marker] call _fnc_clear;
	};
	//kickoff all non local units to prevent desync and rope break
	if !((crew _vehicle) isEqualTo []) then {
		{ 
			0 = [_x,["getOut",_vehicle]] remoteExecCall ["action",_x,false];
		} forEach ((crew _vehicle) select {!local _x});
	};
	//Mount
	[_var_AirVehicle, _vehicle] call _fnc_ManageRopes;
	
	sleep 5;
	//breake if mount failed
	if (_var_ropeFail) exitWith {
	
		if (alive _var_AirVehicle && canMove _var_AirVehicle && alive _var_Pilot) then {
			[_heliDespawnPos,_var_AirVehicle,_var_Pilot,_var_Group,_flightAlt,_varName,_var_caller] call _fnc_returnToSpawn;
		} else {
			[_var_AirVehicle, _var_Group, _varName, _var_caller,_vehicle,_marker] call _fnc_clear;
		};

	};

	//Flight
	_var_AirVehicle flyinheight _flightAlt;
	_var_Pilot doMove _var_CurDropPos;
				
	if ((_var_AirVehicle distance2D _var_CurDropPos) > 1000) then {
			
		_var_Group setSpeedMode "NORMAL";
	};
				
	waitUntil {
		sleep 3;
		([_var_AirVehicle, _vehicle] call _fnc_SearchRealTimeErrors) ||
		(_var_AirVehicle distance _var_CurDropPos) < 200
	};
		
	if ( !alive _var_AirVehicle || {!alive _var_Pilot || {!canMove _var_AirVehicle}}) exitWith {
		_vehicle setDamage 1;
		[_var_AirVehicle, _var_Group, _varName, _var_caller,_vehicle,_marker] call _fnc_clear;
	};
	
	if ((ropeAttachedObjects _var_AirVehicle) isEqualTo []) exitWith {
		_vehicle setDamage 1;
		[_heliDespawnPos,_var_AirVehicle,_var_Pilot,_var_Group,_flightAlt,_varName,_var_caller] call _fnc_returnToSpawn;
	};
		
	//Hover
	_var_Group setSpeedMode "LIMITED";
	_var_AirVehicle flyinheight (_flightAlt / 2);
		
	waitUntil {
		sleep 1;
		([_var_AirVehicle, _vehicle] call _fnc_SearchRealTimeErrors) ||
		(_var_AirVehicle distance _var_CurDropPos) < 100 ||
		(speed _var_AirVehicle) < 5
	};
		
	if ( !alive _var_AirVehicle || {!alive _var_Pilot || {!canMove _var_AirVehicle}}) exitWith {

		if (!canMove _vehicle) then {_vehicle setDamage 1};

		if (!alive _vehicle) then {
			[_var_AirVehicle, _var_Group, _varName, _var_caller,_vehicle,_marker] call _fnc_clear;
		} else {
			[_var_AirVehicle, _var_Group, _varName, _var_caller,_marker] call _fnc_clear;
		};
	};
	if ((ropeAttachedObjects _var_AirVehicle) isEqualTo []) exitWith {

		if (!canMove _vehicle) then {_vehicle setDamage 1};

		[_heliDespawnPos,_var_AirVehicle,_var_Pilot,_var_Group,_flightAlt,_varName,_var_caller] call _fnc_returnToSpawn;
	};
		
	[_var_AirVehicle, _vehicle, _var_CurDropPos, 2] call _fnc_AutoHover;
	
	if ( !alive _var_AirVehicle || {!alive _var_Pilot || {!canMove _var_AirVehicle}}) exitWith {
		[_var_AirVehicle, _var_Group, _varName, _var_caller,_vehicle,_marker] call _fnc_clear;
	};
	
	if ((ropeAttachedObjects _var_AirVehicle) isEqualTo []) exitWith {

		if (!canMove _vehicle) then {_vehicle setDamage 1};

		[_heliDespawnPos,_var_AirVehicle,_var_Pilot,_var_Group,_flightAlt,_varName,_var_caller] call _fnc_returnToSpawn;
	};
	//Drop
	_var_AirVehicle call _fnc_ManageRopes;

	if ( !alive _var_AirVehicle || {!alive _var_Pilot || {!canMove _var_AirVehicle}}) exitWith {
		[_var_AirVehicle, _var_Group, _varName, _var_caller,_vehicle,_marker] call _fnc_clear;
	};
	
	0 = [support_hqts,"drop_accomplished"] remoteExec ["sideRadio", side _var_caller, false];
	
	if (_dropPosCor) then {
		
		_vehicle enableSimulation false;
		_vehicle setPos _var_CurDropPos;
		_vehicle enableSimulation true;
	};
		
	sleep 5;
		
	if (_delTime > 0) then {
		
		0 = [_delTime, _vehicle] spawn {
						
			params ["_var_Time", "_var_Cargo"];
				
			sleep _var_Time;
				
				if (!isNull _var_Cargo) then {
						
					{
						_var_Cargo deleteVehicleCrew _x
					} forEach crew _var_Cargo;
					deleteVehicle _var_Cargo;
				};
		};
	};
	
	if (alive _var_AirVehicle && canMove _var_AirVehicle && alive _var_Pilot) then {
		
		[_heliDespawnPos,_var_AirVehicle,_var_Pilot,_var_Group,_flightAlt,_varName,_var_caller,_marker] call _fnc_returnToSpawn;
	} else {
		[_var_AirVehicle, _var_Group, _varName, _var_caller,_marker] call _fnc_clear;
	};