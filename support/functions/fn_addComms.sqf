/*
SUPP_fnc_addComms
Author: DaVidoSS
Description:
Synchronize player with support modules switch when leader
Parameter: 0:OBJECT player object
usage : SPAWN
Returns:VOID
*/

params [["_player",objNull,[objNull]]];
private ["_syncModule", "_group","_leader","_islinked","_supplydrop","_supplyvehdrop","_supplytransport","_supplyartillery","_supplycasheli","_supplycasbombing"];

_syncModule = ((allMissionObjects "CBA_main_require") param [0,objNull]);
if (isNull _syncModule) exitWith {};

waitUntil {sleep 10; !isNil "support_hqts" && {missionNamespace getVariable ["support_ready",false]}};

while {alive _player} do {


_group = group _player;
_leader = leader _group;
_islinked = synchronizedObjects _player;



if ( _player isEqualTo _leader && {_islinked isEqualTo []}) then {

//player is leader and not linked
_supplydrop = [_player, "battlefield_support"] call BIS_fnc_addCommMenuItem;
/*
_supplyvehdrop = [_player ,"supp_vehdrop"] call BIS_fnc_addCommMenuItem;
_supplytransport = [_player ,"supp_transport"] call BIS_fnc_addCommMenuItem;
_supplyartillery = [_player ,"supp_artillery"] call BIS_fnc_addCommMenuItem;
_supplycasheli = [_player ,"supp_casheli"] call BIS_fnc_addCommMenuItem;
_supplycasbombing = [_player ,"supp_casbombing"] call BIS_fnc_addCommMenuItem;
_supplyuav = [_player ,"supp_uav"] call BIS_fnc_addCommMenuItem;
*/			
_player synchronizeObjectsAdd [_syncModule];
support_hqts sideRadio "support_standby";
};

if ( !(_player isEqualTo _leader) && {!(_islinked isEqualTo [])}) then {

//player is not leader and is linked
[_player,_supplydrop] call BIS_fnc_removeCommMenuItem;
//{[_player,_x] call BIS_fnc_removeCommMenuItem} forEach [_supplydrop,_supplyvehdrop,_supplytransport,_supplyartillery,_supplycasheli,_supplycasbombing,_supplyuav];
_player synchronizeObjectsRemove [_syncModule];
_supplydrop = nil;
/*
_supplyvehdrop = nil;
_supplytransport = nil;
_supplyartillery = nil;
_supplycasheli = nil;
_supplycasbombing = nil;
_supplyuav = nil;
*/
};

sleep 60;
};
