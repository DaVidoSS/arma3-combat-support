/*
MWF_fnc_getSlingloadVeh by DaVidoSS
determine vehicles with slingload capabilities
parameters:
Parameters : 0 - SIDE  players side
Parameters : 1 - ARRAY  array of marker/s for exclude its locations for positioning.Default empty array []
Parameters : 2 - STRING  ambient faction class usually "CIV_F". Default "CIV_F"
Parameters : 3 - STRING  ambient vehicle type  usually "irrelevant". Available types: "turret", "noturret" ,"irrelevant". Default "irrelevant"
Parameters : 4 - STRING  players faction class Default "BLU_F"
usage call 
return ARRAY
*/

params [
["_side",sideUnknown,[sideUnknown]],
["_blacklistedArea",[],[[]]],
["_ambientFaction","CIV_F",[""]],
["_ambientType","irrelevant",[""]],
["_playersFaction","BLU_F",[""]]

];

private [
"_factionSide","_allowedVehType","_forbidedVehClass","_fnc_getFactions","_fnc_getVehicles", "_fnc_slingloadcheck",
"_playerSideFactions", "_carClasses", "_shipclasses", "_vehclasses", "_supp_vehiclesarray", "_supp_vehicles"
]; 

if (!isServer) exitWith {};

_factionSide = 3;
_allowedVehType = "LandVehicle";
_forbidedVehClass = []; 

switch (STR _side) do {

case "EAST": {_factionSide = 0;};
case "WEST": {_factionSide = 1;};
case "GUER": {_factionSide = 2;};
case "CIV": {_factionSide = 3;};
default {};
};

_fnc_getFactions = {

params [ ["_sidenum",3,[0]] ];
private ["_return","_cfgfactionClasses","_deniedFactions"];

_return = [];
_cfgfactionClasses = configFile >> "CfgFactionClasses";
_deniedFactions = [];

{
if (isClass _x && !(_x in _deniedFactions)) then {

_return pushBack (configName _x);
};
} forEach ("getNumber (_x >> 'side') isEqualTo _sidenum" configClasses _cfgfactionClasses);

_return

};

_fnc_getVehicles = {

params [ ["_factions",[],[[]]],["_vehType","",[""]],["_denyClasses",[],[[]]] ];
private ["_return","_cfgVehicles"];
_return = [];
_cfgVehicles = configFile >> "CfgVehicles";

{
if (
isClass _x &&
(configName _x) isKindoF _vehType &&
!((configName _x) in _denyClasses) &&
(getNumber (_cfgVehicles >> (configName _x) >> "scope")) isEqualTo 2 &&
!((getArray (_cfgVehicles >> (configName _x) >> "slingLoadCargoMemoryPoints")) isEqualTo [])

) then {

_return pushBack (configName _x);
};

} forEach ("getText (_x >> 'faction') in _factions" configClasses _cfgVehicles);

_return
};

_fnc_slingloadcheck = {

params [ 
["_array",[],[[]]],
["_sidethis",sideUnknown,[sideUnknown]],
["_blacklisted",[],[[]]]
];
private ["_position","_pos","_return","_helitype","_hel","_veh"];

_position = [[worldSize/2, worldSize/2, 0], 0, worldSize/2, 10, 0, 0.4, 0, _blacklisted, []] call BIS_fnc_findSafePos;
_pos = [[worldSize/2, worldSize/2, 0], 0, worldSize/2, 20, 0, 0.4, 0, _blacklisted, []] call BIS_fnc_findSafePos;  
_return = [];
_helitype = ["O_Heli_Transport_04_covered_F","B_Heli_Transport_03_unarmed_F","I_Heli_Transport_02_F"] select ([EAST,WEST,INDEPENDENT] find _sidethis);
_hel = _helitype createVehicleLocal _position;
_hel enableSimulation false;
hideObject _hel;

{
_veh = _x createVehicleLocal _pos;
_veh enableSimulation false;
hideObject _veh;
if (_hel canSlingLoad _veh) then {_return pushBack _x};
deleteVehicle _veh;
} forEach _array;

deleteVehicle _hel;
_return

};

_carClasses = [_ambientFaction, "LandVehicle", _ambientType, []] call SUPP_fnc_getClasses;
_shipclasses = [_playersFaction, "Ship", "irrelevant", []] call SUPP_fnc_getClasses;
_playerSideFactions = _factionSide call _fnc_getFactions;
_vehclasses = [_playerSideFactions, _allowedVehType, _forbidedVehClass] call _fnc_getVehicles;
_supp_vehiclesarray = [_vehclasses  + _carClasses + _shipclasses, _side,_blacklistedArea] call _fnc_slingloadcheck;

_supp_vehicles = [];
{_supp_vehicles pushBackUnique _x} forEach _supp_vehiclesarray;

(_supp_vehicles)