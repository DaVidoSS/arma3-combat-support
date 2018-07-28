/*
MWF_fnc_getClasses by DaVidoSS
get class names thats meets parameters
parameters:
0: STRING
1: STRING
2: STRING
3: ARRAY
return ARRAY	
Usage:
[
"faction",  					STRING: faction class , for boxes use "Default"
"LandVehicle", 					STRING: vehicle class type: "Man", "LandVehicle", "StaticWeapon", "Plane", "Helicopter", "Ship", "ReammoBox_F", "FlagCarrier"
"turret",						STRING: select armed or unarmed vehicles or irrelevant "turret", "noturret" ,"irrelevant",
["Unarmed","SpecialOperative"]	ARRAY: select exclusion by role. Usable only if iterate for  "Man", otherwise an empty array []
] call MWF_fnc_getClasses;
*/

params [

["_faction","",[""]],
["_vehicletype","",[""]],
["_state","",[""]],
["_role",[],[[]]] 

];


private _array = [];

switch _vehicletype do {

case "Man": {

{
private _class = (configName _x);

if (_class isKindoF _vehicletype) then {

if (getNumber (configFile >> "CfgVehicles" >> _class >> "scope") == 2) then  {

if !(_role isEqualTo []) then {

if !(getText (configFile >> "CfgVehicles" >> _class >> "role") in _role) then {

_array pushBack	_class;

};

} else {

_array pushBack	_class;

};
};
};
} forEach ("getText (_x >> 'faction') == _faction" configClasses (configFile >> "CfgVehicles"));
};

case "LandVehicle": {

{
private _class = (configName _x);

if (_class isKindoF _vehicletype) then {

if (getNumber (configFile >> "CfgVehicles" >> _class >> "scope") == 2) then  {

if (getNumber (configFile >> "CfgVehicles" >> _class >> "hasDriver") == 1) then {

_array pushBack	_class;

};

};
};
} forEach ("getText (_x >> 'faction') == _faction" configClasses (configFile >> "CfgVehicles"));

switch _state do {

case "turret": {_array = _array select {!(([_x, false] call BIS_fnc_allTurrets) isEqualTo [])}};
case "noturret": {_array = _array select {([_x, false] call BIS_fnc_allTurrets) isEqualTo []}};
case "irrelevant": {};
default {
diag_log format ["ERROR: *********** ModernWarfare: MWF_fnc_getClasses: wrong vehicle state type given - parameter 2: %1. Valid types are 'turret', 'noturret', 'irrelevant' ***********", _state];
};
};		
};

case "StaticWeapon": {

{
private _class = (configName _x);

if (_class isKindoF _vehicletype) then {

if (getNumber (configFile >> "CfgVehicles" >> _class >> "scope") == 2) then  {

_array pushBack	_class;

};
};

} forEach ("getText (_x >> 'faction') == _faction" configClasses (configFile >> "CfgVehicles"));
};

case "Plane": {

{
private _class = (configName _x);

if (_class isKindoF _vehicletype) then {

if (getNumber (configFile >> "CfgVehicles" >> _class >> "scope") == 2) then  {

_array pushBack	_class;

};
};

} forEach ("getText (_x >> 'faction') == _faction" configClasses (configFile >> "CfgVehicles"));

switch _state do {

case "turret": {_array = _array select {!(([_x, false] call BIS_fnc_allTurrets) isEqualTo [])}};
case "noturret": {_array = _array select {([_x, false] call BIS_fnc_allTurrets) isEqualTo []}};
case "irrelevant": {};
default {
diag_log format ["ERROR: *********** ModernWarfare: MWF_fnc_getClasses: wrong vehicle state type given - parameter 2: %1. Valid types are 'turret', 'noturret', 'irrelevant' ***********", _state];
};
};
};

case "Helicopter": {

{
private _class = (configName _x);

if (_class isKindoF _vehicletype) then {

if (getNumber (configFile >> "CfgVehicles" >> _class >> "scope") == 2) then  {

_array pushBack	_class;

};
};

} forEach ("getText (_x >> 'faction') == _faction" configClasses (configFile >> "CfgVehicles"));

switch _state do {

case "turret": {_array = _array select {!(([_x, false] call BIS_fnc_allTurrets) isEqualTo [])}};
case "noturret": {_array = _array select {([_x, false] call BIS_fnc_allTurrets) isEqualTo []}};
case "irrelevant": {};
default {
diag_log format ["ERROR: *********** ModernWarfare: MWF_fnc_getClasses: wrong vehicle state type given - parameter 2: %1. Valid types are 'turret', 'noturret', 'irrelevant' ***********", _state];
};
};
};

case "Ship": {

{
private _class = (configName _x);

if (_class isKindoF _vehicletype) then {

if (getNumber (configFile >> "CfgVehicles" >> _class >> "scope") == 2) then  {

_array pushBack	_class;

};
};

} forEach ("getText (_x >> 'faction') == _faction" configClasses (configFile >> "CfgVehicles"));

switch _state do {

case "turret": {_array = _array select {!(([_x, false] call BIS_fnc_allTurrets) isEqualTo [])}};
case "noturret": {_array = _array select {([_x, false] call BIS_fnc_allTurrets) isEqualTo []}};
case "irrelevant": {};
default {
diag_log format ["ERROR: *********** ModernWarfare: MWF_fnc_getClasses: wrong vehicle state type given - parameter 2: %1. Valid types are 'turret', 'noturret', 'irrelevant' ***********", _state];
};
};
};

case "ReammoBox_F": {

_faction = "Default";

{
private _class = (configName _x);

if (_class isKindoF _vehicletype) then {

if (getNumber (configFile >> "CfgVehicles" >> _class >> "scope") == 2) then  {

_array pushBack	_class;

};
};

} forEach ("getText (_x >> 'faction') == _faction" configClasses (configFile >> "CfgVehicles"));
};

case "FlagCarrier": {

_faction = "Default";

{
private _class = (configName _x);

if (_class isKindoF _vehicletype) then {

if (getNumber (configFile >> "CfgVehicles" >> _class >> "scope") == 2) then  {

_array pushBack	_class;

};
};

} forEach ("getText (_x >> 'faction') == _faction" configClasses (configFile >> "CfgVehicles"));
};

default { 
diag_log format ["ERROR: *********** ModernWarfare: MWF_fnc_getClasses: wrong vehicle class type given - parameter 1: %1. Valid types are 'Man', 'LandVehicle', 'StaticWeapon', 'Plane', 'Helicopter', 'Ship', 'ReammoBox_F' ***********",_vehicletype];
};

};

(_array)