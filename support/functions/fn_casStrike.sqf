/*	
SUPP_fnc_casStrike
Author: DaVidoSS
Description: create comms menu and call CAS from server
Parameter: 0 OBJECT player
Parameter: 1 ARRAY position
Parameter: 2 OBJECT target from cursortarget
Parameter: 3 BOOLEAN true or false false if call from map
Parameter: 4 NUMMBER index 
Parameter: 5 NUMMBER weapons type 0 = machinegun, 1= missilelauncher 2 = machinegun + missilelauncher  3 = bomblauncher
usage : SPAWN
Returns:VOID  
*/
params [ 

["_caller", objNull,[objNull]],
["_desiredpos", [], [[]]],
["_targetObj", objNull, [objNull]],
["_is3D",true,[true]],
["_id",0,[0]],
["_weaponTypesID",3,[0]]
];
if (!isServer) exitWith {};
0 = [support_hqts, "cas_bombing_request"] remoteExecCall ["sideRadio", _side, false];
missionNamespace setVariable ["support_ready",false,true];
sleep 5;
0 = [support_hqts, "cas_bombing_acknowledged"] remoteExecCall ["sideRadio", _side, false];

_planeClass = selectRandom (missionNamespace getVariable ["supp_planes",["B_Plane_CAS_01_F"]]);
_planeCfg = configFile >> "cfgVehicles" >> _planeClass;
if !(isClass _planeCfg) exitWith {["Vehicle class '%1' not found",_planeClass] call bis_fnc_error; false};

//--- Detect gun
_weaponTypes = switch _weaponTypesID do {
case 0: {["machinegun"]};
case 1: {["missilelauncher"]};
case 2: {["machinegun","missilelauncher"]};
case 3: {["bomblauncher"]};
default {[]};
};
_weapons = [];
{
if (toLower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then {
_modes = getArray (configFile >> "cfgWeapons" >> _x >> "modes");
if (count _modes > 0) then {
_mode = _modes select 0;
if (_mode == "this") then {_mode = _x;};
_weapons set [count _weapons,[_x,_mode]];
};
};
} forEach (_planeClass call bis_fnc_weaponsEntityType);
if (count _weapons == 0) exitWith {["No weapon of types %2 wound on '%1'",_planeClass,_weaponTypes] call bis_fnc_error; false};

_posATL = ASLToATL _desiredpos;
_pos = +_posATL;
_pos set [2,(_pos select 2) + getTerrainHeightASL _pos];
_dir = (random 360);

_dis = 5000;
_alt = 1000;
_pitch = aTan (_alt / _dis);
_speed = 400 / 3.6;
_duration = ([0,0] distance [_dis,_alt]) / _speed;

//--- Create plane
_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
_planePos set [2,(_pos select 2) + _alt];
_planeSide = (getNumber (_planeCfg >> "side")) call bis_fnc_sideType;
_planeArray = [_planePos,_dir,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
_plane = _planeArray select 0;
_group = group _plane;
_crew = crew _plane;
_plane setPosASL _planePos;
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
_plane disableAi "MOVE";
_plane disableAi "TARGET";
_plane disableAi "AUTOTARGET";
_plane setCombatMode "BLUE";

_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_plane setVectorDir _vectorDir;
[_plane,-90 + aTan (_dis / _alt),0] call bis_fnc_setpitchbank;
_vectorUp = vectorUp _plane;

//--- Remove all other weapons;
_currentWeapons = weapons _plane;
{
if !(toLower ((_x call bis_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"])) then {
_plane removeWeapon _x;
};
} forEach _currentWeapons;


//--- Approach
_fire = [] spawn {waitUntil {false}};
_fireNull = true;
_time = time;
_offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};
waitUntil {

_fireProgress = _plane getVariable ["fireProgress",0];

//--- Set the plane approach vector
_plane setVelocityTransformation [
_planePos, [_pos select 0,_pos select 1,(_pos select 2) + _offset + _fireProgress * 12],
_velocity, _velocity,
_vectorDir,_vectorDir,
_vectorUp, _vectorUp,
(time - _time) / _duration
];
_plane setVelocity velocity _plane;

//--- Fire!
if ((getPosASL _plane) distance _pos < 1000 && _fireNull) then {


//--- Create laser target
_target = ((_posATL nearEntities [["LaserTarget","LaserTargetC","LaserTargetE","LaserTargetW"],300])) param [0,objNull];
if (isNull _target) then {
if !(isNull _targetObj) then {
_target = createVehicle ["LaserTargetC",position _targetObj,[],0,"none"];
} else {
_target = createVehicle ["LaserTargetC",_posATL,[],0,"none"];
};
};
_plane reveal laserTarget _target;
_plane doWatch laserTarget _target;
_plane doTarget laserTarget _target;

_fireNull = false;
terminate _fire;
_fire = [_plane,_weapons,_target,_weaponTypesID] spawn {
_plane = _this select 0;
_planeDriver = driver _plane;
_weapons = _this select 1;
_target = _this select 2;
_weaponTypesID = _this select 3;
_duration = 3;
_time = time + _duration;
waitUntil {
{
_planeDriver fireAtTarget [_target,(_x select 0)];
} forEach _weapons;
_plane setVariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
sleep 0.1;
(time > _time || _weaponTypesID == 3) || {!alive _plane} || {isNull _plane} //--- Shoot only for specific period or only one bomb
};
if (!alive _plane ||  isNull _plane) exitWith {};
sleep 1;
};
};

sleep 0.01;
scriptDone _fire || {!alive _plane} || {isNull _plane}
};

if (!alive (driver _plane) || {!alive _plane} || {isNull _plane}) exitWith {

0 = [support_hqts,"cas_bombing_destroyed"] remoteExec ["sideRadio", _side, false];

if (random 1 < 0.25) then {
sleep 4;
if (isNull objectParent _caller) then {

0 = [_caller, ["fucksake", 100, 1]] remoteExec ["say3D", [0,-2] select isDedicated, false];

} else {

0 = [(vehicle _caller),"Ooh for fuck sake!"] remoteExecCall ["vehicleChat", (crew (vehicle _caller)) select {isPlayer _x}, false];
};
};

sleep 30;
deleteVehicle _plane;
{deleteVehicle _x} forEach _crew;
deleteGroup _group;
missionNamespace setVariable ["support_ready",true,true];
0 = [support_hqts,"support_standby"] remoteExec ["sideRadio", _side, false];

};

_plane setVelocity velocity _plane;
_plane flyInHeight _alt;
0 = [support_hqts,"cas_bombing_accomplished"] remoteExec ["sideRadio", _side, false];
//--- Fire CM
if ({_x == "bomblauncher"} count _weaponTypes == 0) then {
for "_i" from 0 to 1 do {
driver _plane forceWeaponFire ["CMFlareLauncher","Burst"];
_time = time + 1.1;
waitUntil {time > _time || !alive _plane || isNull _plane};
};
};

waitUntil {sleep 30; _plane distance _pos > _dis || {!alive _plane}};
deleteVehicle _plane;
{deleteVehicle _x} forEach _crew;
deleteGroup _group;
missionNamespace setVariable ["support_ready",true,true];
0 = [support_hqts,"support_standby"] remoteExec ["sideRadio", _side, false];