/*
MWF_fnc_prepareSupport by DaVidoSS
Description: dynamically gather vehicles class names available for support task and store it in namespace variables
Parameters : 0 - SIDE  players side
Parameters : 1 - ARRAY  array of marker/s for exclude its locations for positioning.Default empty array []
Parameters : 2 - STRING  ambient faction class usually "CIV_F". Default "CIV_F"
Parameters : 3 - STRING  ambient vehicle type  usually "irrelevant". Available types: "turret", "noturret" ,"irrelevant". Default "irrelevant"
Parameters : 4 - STRING  players faction class Default "BLU_F"
Usage : spawn 
Returns : VOID
*/
if (!isServer) exitWith {};

params [
["_side",sideUnknown,[sideUnknown]],
["_blacklistedArea",[],[[]]],
["_ambientFaction","CIV_F",[""]],
["_ambientType","irrelevant",[""]],
["_playersFaction","BLU_F",[""]]
];

private [
"_sidenum","_allSideAirCfgPaths", "_allHeliCfgPaths", "_allAttackHeliCfgPaths", "_allTransportkHeliCfgPaths",
"_allUAVCfgPaths", "_allPlaneCfgPaths", "_attackHelis", "_transportHelis",
"_uavs", "_planes", "_supp_slingLoadVehicles"
];


_sidenum = [0,1,2] select ([EAST,WEST,INDEPENDENT] find _side);
_allSideAirCfgPaths = "
getNumber (_x >> 'type') isEqualTo 2 &&
{getNumber (_x >> 'side') isEqualTo _sidenum} &&
{getNumber (_x >> 'scope') >= 2}
" configClasses (configFile >> "cfgVehicles");
_allHeliCfgPaths = _allSideAirCfgPaths select {
toLower getText (_x >> 'simulation') isEqualTo "helicopterrtd" &&
{toLower getText (_x >> 'vehicleClass') != "autonomous"}
};

_allAttackHeliCfgPaths = _allHeliCfgPaths select {
"CAS_Heli" in (getArray (_x >> 'availableForSupportTypes'))
};

_allTransportkHeliCfgPaths = _allHeliCfgPaths select {
"Transport" in (getArray (_x >> 'availableForSupportTypes')) ||
{"Drop" in (getArray (_x >> 'availableForSupportTypes'))}
};
_allUAVCfgPaths = _allSideAirCfgPaths select {
toLower getText (_x >> 'vehicleClass') == "autonomous" &&
{toLower getText (_x >> 'simulation') != "helicopterrtd"}
};

_allPlaneCfgPaths = _allSideAirCfgPaths select {
toLower getText (_x >> 'simulation') isEqualTo "airplanex" && 
{"CAS_Bombing" in (getArray (_x >> 'availableForSupportTypes'))} &&
{toLower getText (_x >> 'vehicleClass') != "autonomous"}
};

_attackHelis  = +(_allAttackHeliCfgPaths apply {configName _x});
_transportHelis = +(_allTransportkHeliCfgPaths apply {configName _x});
_uavs = +(_allUAVCfgPaths apply {configName _x});
_planes = +(_allPlaneCfgPaths apply {configName _x});

_supp_slingLoadVehicles = [_side,_blacklistedArea,_ambientFaction,_ambientType,_playersFaction] call SUPP_fnc_getSlingloadVeh;
missionNamespace setVariable ["supp_slingLoadVehicles",_supp_slingLoadVehicles,true];
missionNamespace setVariable ["supp_helicopters",_transportHelis,true];
missionNamespace setVariable ["supp_attackhelis",_attackHelis,true];
missionNamespace setVariable ["supp_uavs",_uavs,true];
missionNamespace setVariable ["supp_planes",_planes,true];
missionNamespace setVariable ["support_ready",true,true];
AIR_SUPPORT_PATH = "support\";
publicVariable "AIR_SUPPORT_PATH";