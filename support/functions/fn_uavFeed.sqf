
	params [
	["_desiredpos",[],[[]]],
	["_side",sideUnknown,[sideUnknown]]
	];
	
	private [
	"_planeClass", "_posATL", "_desiredpos", "_dir", "_dis", "_pitch", "_speed", "_duration", 
	"_planePos", "_planeArray", "_plane", "_wp1", "_wp2"
	];
	
	if (!isServer) exitWith {};
	
	_planeClass = selectRandom (missionNamespace getVariable ["supp_uavs",["B_UAV_05_F"]]);
	_posATL = ASLToATL _desiredpos;
	_pos = +_posATL;
	_pos set [2,(_pos select 2) + getTerrainHeightASL _pos];
	_dir = (random 360);

	_dis = 5000;
	_alt = 500;
	_pitch = atan (_alt / _dis);
	_speed = 200 / 3.6;
	_duration = ([0,0] distance [_dis,_alt]) / _speed;

	//--- Create plane
	_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
	_planePos set [2,(_pos select 2) + _alt];
	_planeArray = [_planePos,_dir,_planeClass,_side] call bis_fnc_spawnVehicle;
	_plane = _planeArray select 0;
	_plane setPosASL _planePos;
	_plane setVehicleVarName "uavspy";
	uavspy = _plane;
	publicVariable "uavspy";

	 _wp1 = (group _plane) addWaypoint [_pos, 100];
	 _wp1 setWaypointCombatMode "BLUE";
	 _wp1 setWaypointBehaviour "CARELESS";
	 _wp1 setWaypointType "MOVE";
	 _wp1 setWaypointSpeed "FULL";
	 _wp1 setWaypointStatements ["true", ""];
	 _wp2 = (group _plane) addWaypoint [_pos, 100];
	 _wp2 setWaypointCombatMode "BLUE";
	 _wp2 setWaypointBehaviour "CARELESS";
	 _wp2 setWaypointType "LOITER";
	 _wp2 setWaypointLoiterType "CIRCLE";
	 _wp2 setWaypointLoiterRadius 400;
	 _wp2 setWaypointStatements ["true", ""];
