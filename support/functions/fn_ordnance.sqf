/*
	Author: DaVidoSS
	Description: simulate artillery strike using delivered parameters
	Parameter: 0 STRING  type of strike "smoke","flare" or "he". Default "he"
	Parameter: 1 NUMMBER how many strikes. Default 1
	Parameter: 2 STRING strike type "direct_hit","suppress_area" or "danger_close". Default "direct_hit"
	Parameter: 3 OBJECT player who call the ordnance
	Parameter: 4 ARRAY position of attack
	Parameter: 5 OBJECT target from cursortarget
	Parameter: 6 BOOLEAN true or false false if call from map
	usage : SPAWN
	Returns:VOID  
*/
params [ 
["_shellType","he",[""]],
["_shellCount",1,[0]],
["_fireType","direct_hit",[""]],
["_caller", objNull,[objNull]],
["_desiredpos", [], [[]]],
["_targetObj", objNull, [objNull]],
["_is3D",true,[true]]
];


private [
"_side", "_art_voice", "_rel_Pos_sound", "_colorSmoke",
"_fluier", "_rel_Pos_target", "_smoke", "_colorFlare", "_flare", "_roundType",
"_bomb", "_mrkr", "_markers", "_directions"
];
if (!isServer) exitWith {};
_side = side _caller;
_art_voice = "land_helipadempty_f" createVehicle (getPos _caller);
_rel_Pos_sound = _caller getRelPos [50, random 360];
_art_voice setPos _rel_Pos_sound;
if (_desiredpos isEqualTo []) then {_desiredpos = getPos _caller};
0 = [support_hqts, "artillery_request"] remoteExecCall ["sideRadio", _side, false];
sleep 5;
0 = [support_hqts, "artillery_acknowledged"] remoteExecCall ["sideRadio", _side, false];
if (_desiredpos distance2d _caller < 100 && _fireType != "danger_close" && _shellType == "he") exitWith {
sleep 5;
0 = [support_hqts, "Friendly units in target area. Fire mission Danger Close is required! Out!"] remoteExecCall ["sideChat", _side, false];
};
if (isNull _targetObj && _fireType == "direct_hit") exitWith {
sleep 5;
0 = [support_hqts, "Target unknown. Out!"] remoteExecCall ["sideChat", _side, false];
};

missionNamespace setVariable ["support_ready",false,true];
sleep (random [20,30,40]);

switch _fireType do {

case "direct_hit": {

switch _shellType do {

case "smoke": {

_colorSmoke = selectRandom ["SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "SmokeShellWhite"];

for "_i" from 1 to _shellCount do {

0 = [support_hqts,"artillery_rounds_complete"] remoteExecCall ["sideRadio", _side, false];
sleep (3 + random 0.5);
_fluier = selectRandom  ["fluier_1", "fluier_2", "fluier_3", "fluier_4", "fluier_5", "fluier_6", "fluier_7", "fluier_8", "fluier_9", "fluier_91", "fluier_92", "fluier_93"];	
0 = [_art_voice,[_fluier,500]] remoteExecCall ["say3d",_side,false];
sleep 0.5;
0 = [support_hqts, "artillery_accomplished"] remoteExecCall ["sideRadio", _side, false];
sleep 0.5;
_rel_Pos_target = [((getPos _targetObj) select 0)-15*sin(random 360),((getPos _targetObj) select 1)-15*cos(random 360),150+(random 100)];
_smoke 	= _colorSmoke createVehicle _rel_Pos_target;
_smoke setVelocity [+0.5,+1,+1];
sleep 5;
};

};

case "flare": {

_colorFlare = selectRandom ["F_20mm_white", "F_20mm_Red", "F_20mm_yellow", "F_20mm_green"];

for "_i" from 1 to _shellCount do {
0 = [support_hqts,"artillery_rounds_complete"] remoteExecCall ["sideRadio", _side, false];
sleep (3 + random 0.5);
_fluier = selectRandom  ["fluier_1", "fluier_2", "fluier_3", "fluier_4", "fluier_5", "fluier_6", "fluier_7", "fluier_8", "fluier_9", "fluier_91", "fluier_92", "fluier_93"];	
0 = [_art_voice,[_fluier,500]] remoteExecCall ["say3d",_side,false];
sleep 0.5;
0 = [support_hqts, "artillery_accomplished"] remoteExecCall ["sideRadio", _side, false];
sleep 0.5;
_rel_Pos_target = [((getPos _targetObj) select 0)-15*sin(random 360),((getPos _targetObj) select 1)-15*cos(random 360),150+(random 100)];
_flare 	= _colorFlare createVehicle _rel_Pos_target;
_flare setVelocity [+0.5,+1,+1];
sleep 5;
};				
};

case "he": {

_roundType = selectRandom ["Bo_GBU12_LGB","Sh_125mm_HE","Sh_155mm_AMOS_LG","R_230mm_HE"];

for "_i" from 1 to _shellCount do {
0 = [support_hqts,"artillery_rounds_complete"] remoteExecCall ["sideRadio", _side, false];
sleep (3 + random 0.5);						
_fluier = selectRandom  ["fluier_1", "fluier_2", "fluier_3", "fluier_4", "fluier_5", "fluier_6", "fluier_7", "fluier_8", "fluier_9", "fluier_91", "fluier_92", "fluier_93"];	
0 = [_art_voice,[_fluier,500]] remoteExecCall ["say3d",_side,false];
sleep 0.5;
0 = [support_hqts, "artillery_accomplished"] remoteExecCall ["sideRadio", _side, false];				
sleep 0.5;
_rel_Pos_target = [((getPos _targetObj) select 0)-5*sin(random 360),((getPos _targetObj) select 1)-5*cos(random 360),150+(random 100)];
_bomb = _roundType createVehicle _rel_Pos_target;
[_bomb, -90, 0] call BIS_fnc_setPitchBank;
_bomb setVelocity [0,0,-100];
sleep 5;
};				

};
default {};
};
};

case "suppress_area": {

_mrkr = createMarker ["area_alias", _desiredpos]; 
_mrkr setMarkerShape "ICON"; 
_mrkr setMarkerColor "Default"; 
_mrkr setMarkerSize [1, 1]; 
_mrkr setMarkerType "KIA"; 
_mrkr setMarkerText "ARTILLERY TARGET"; 

switch _shellType do {

case "smoke": {

_colorSmoke = selectRandom ["SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "SmokeShellWhite"];

for "_i" from 1 to _shellCount do {
0 = [support_hqts,"artillery_rounds_complete"] remoteExecCall ["sideRadio", _side, false];
sleep (3 + random 0.5);
_fluier = selectRandom  ["fluier_1", "fluier_2", "fluier_3", "fluier_4", "fluier_5", "fluier_6", "fluier_7", "fluier_8", "fluier_9", "fluier_91", "fluier_92", "fluier_93"];	
0 = [_art_voice,[_fluier,500]] remoteExecCall ["say3d",_side,false];
sleep 0.5;
0 = [support_hqts, "artillery_accomplished"] remoteExecCall ["sideRadio", _side, false];
sleep 0.5;
_rel_Pos_target = [(_desiredpos select 0)-150*sin(random 360),(_desiredpos select 1)-150*cos(random 360),150+(random 100)];
_smoke 	= _colorSmoke createVehicle _rel_Pos_target;
_smoke setVelocity [+0.5,+1,+1];
sleep 5;
};

};

case "flare": {

_colorFlare = selectRandom ["F_20mm_white", "F_20mm_Red", "F_20mm_yellow", "F_20mm_green"];

for "_i" from 1 to _shellCount do {
0 = [support_hqts,"artillery_rounds_complete"] remoteExecCall ["sideRadio", _side, false];
sleep (3 + random 0.5);
_fluier = selectRandom  ["fluier_1", "fluier_2", "fluier_3", "fluier_4", "fluier_5", "fluier_6", "fluier_7", "fluier_8", "fluier_9", "fluier_91", "fluier_92", "fluier_93"];	
0 = [_art_voice,[_fluier,500]] remoteExecCall ["say3d",_side,false];
sleep 0.5;
0 = [support_hqts, "artillery_accomplished"] remoteExecCall ["sideRadio", _side, false];
sleep 0.5;
_rel_Pos_target = [(_desiredpos select 0)-150*sin(random 360),(_desiredpos select 1)-150*cos(random 360),150+(random 100)];
_flare 	= _colorFlare createVehicle _rel_Pos_target;
_flare setVelocity [+0.5,+1,+1];
sleep 5;
};				
};

case "he": {

_roundType = selectRandom ["Bo_GBU12_LGB","Sh_125mm_HE","Sh_155mm_AMOS_LG","R_230mm_HE"];

for "_i" from 1 to _shellCount do {
0 = [support_hqts,"artillery_rounds_complete"] remoteExecCall ["sideRadio", _side, false];
sleep (3 + random 0.5);						
_fluier = selectRandom  ["fluier_1", "fluier_2", "fluier_3", "fluier_4", "fluier_5", "fluier_6", "fluier_7", "fluier_8", "fluier_9", "fluier_91", "fluier_92", "fluier_93"];	
0 = [_art_voice,[_fluier,500]] remoteExecCall ["say3d",_side,false];
sleep 0.5;
0 = [support_hqts, "artillery_accomplished"] remoteExecCall ["sideRadio", _side, false];				
sleep 0.5;
_rel_Pos_target = [(_desiredpos select 0)-100*sin(random 360),(_desiredpos select 1)-100*cos(random 360),150+(random 100)];
_bomb = _roundType createVehicle _rel_Pos_target;
[_bomb, -90, 0] call BIS_fnc_setPitchBank;
_bomb setVelocity [0,0,-100];
sleep 5;
};				

};
default {};
};
deleteMarker _mrkr;
};

case "danger_close": {

_markers = [];
_directions = [0,36,72,108,144,180,216,252,288,324];

{
_markers pushBack createMarker [format ["danger_close_%1",_forEachIndex],[_desiredpos, random [70,100,130], _x] call BIS_fnc_relPos];
} forEach _directions;

switch _shellType do {

case "smoke": {

_colorSmoke = selectRandom ["SmokeShellGreen", "SmokeShellRed", "SmokeShellBlue", "SmokeShellWhite"];

for "_i" from 1 to _shellCount do {
0 = [support_hqts,"artillery_rounds_complete"] remoteExecCall ["sideRadio", _side, false];
sleep (3 + random 0.5);
_fluier = selectRandom  ["fluier_1", "fluier_2", "fluier_3", "fluier_4", "fluier_5", "fluier_6", "fluier_7", "fluier_8", "fluier_9", "fluier_91", "fluier_92", "fluier_93"];	
0 = [_art_voice,[_fluier,500]] remoteExecCall ["say3d",_side,false];
sleep 0.5;
0 = [support_hqts, "artillery_accomplished"] remoteExecCall ["sideRadio", _side, false];
sleep 0.5;
{
_rel_Pos_target = [((getMarkerPos _x) select 0)-50*sin(random 360),((getMarkerPos _x) select 1)-50*cos(random 360),150+(random 100)];
_smoke 	= _colorSmoke createVehicle _rel_Pos_target;
_smoke setVelocity [+0.5,+1,+1];
} forEach _markers;
sleep 5;
};

};

case "flare": {

_colorFlare = selectRandom ["F_20mm_white", "F_20mm_Red", "F_20mm_yellow", "F_20mm_green"];

for "_i" from 1 to _shellCount do {
0 = [support_hqts,"artillery_rounds_complete"] remoteExecCall ["sideRadio", _side, false];
sleep (3 + random 0.5);
_fluier = selectRandom  ["fluier_1", "fluier_2", "fluier_3", "fluier_4", "fluier_5", "fluier_6", "fluier_7", "fluier_8", "fluier_9", "fluier_91", "fluier_92", "fluier_93"];	
0 = [_art_voice,[_fluier,500]] remoteExecCall ["say3d",_side,false];
sleep 0.5;
0 = [support_hqts, "artillery_accomplished"] remoteExecCall ["sideRadio", _side, false];
sleep 0.5;
{
_rel_Pos_target = [((getMarkerPos _x) select 0)-50*sin(random 360),((getMarkerPos _x) select 1)-50*cos(random 360),150+(random 100)];
_flare 	= _colorFlare createVehicle _rel_Pos_target;
_flare setVelocity [+0.5,+1,+1];
sleep 1;
} forEach _markers;
sleep 5;
};				
};

case "he": {

_roundType = selectRandom ["M_Mo_82mm_AT_LG","Sh_120mm_HE","Sh_155mm_AMOS_LG","R_230mm_HE"];

for "_i" from 1 to _shellCount do {
0 = [support_hqts,"artillery_rounds_complete"] remoteExecCall ["sideRadio", _side, false];
sleep (3 + random 0.5);						
_fluier = selectRandom  ["fluier_1", "fluier_2", "fluier_3", "fluier_4", "fluier_5", "fluier_6", "fluier_7", "fluier_8", "fluier_9", "fluier_91", "fluier_92", "fluier_93"];	
0 = [_art_voice,[_fluier,500]] remoteExecCall ["say3d",_side,false];
sleep 0.5;
0 = [support_hqts, "artillery_accomplished"] remoteExecCall ["sideRadio", _side, false];				
sleep 0.5;
{
_rel_Pos_target = [((getMarkerPos _x) select 0)-50*sin(random 360),((getMarkerPos _x) select 1)-50*cos(random 360),150+(random 100)];
_bomb = _roundType createVehicle _rel_Pos_target;
[_bomb, -90, 0] call BIS_fnc_setPitchBank;
_bomb setVelocity [0,0,-100];
sleep 1;
} forEach _markers;
sleep 5;

};				

};

default {};
};

{deleteMarker _x} forEach _markers;
};

default {};
};
deleteVehicle _art_voice;
sleep 30;
0 = [support_hqts,"support_standby"] remoteExec ["sideRadio", _side, false];
missionNamespace setVariable ["support_ready",true,true];

