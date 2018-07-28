/*
MWF_fn_dropboxInit by DaVidoSS
init supply droppbox 
parameters:
0: OBJECT box object
return VOID
*/

params [
["_dropbox",objNull,[objNull]],
["_side",sideUnknown,[sideUnknown]],
["_dropMarker","",[""]]
]; 
private ["_supplyLight", "_supplySmoke"];
waitUntil {sleep 1;(getPos _dropbox select 2) < 2};
clearWeaponCargoGlobal _dropbox;
clearMagazineCargoGlobal _dropbox;
clearItemCargoGlobal _dropbox;
clearBackpackCargoGlobal _dropbox;
_supplyLight = "NVG_TargetW" createVehicle (position _dropbox);
_supplyLight attachTo [_dropbox, [0,0,0.75]];
_supplySmoke = "SmokeShellGreen" createVehicle (position _dropbox);
_supplySmoke attachTo [_dropbox, [0,0,0.6]];
0 = [_dropbox,_side] spawn SUPP_fnc_inventoryFill;
if (!isNil {fnc_initBox}) then {0 = [_dropbox] spawn fnc_initBox};
waitUntil {sleep 60; !([getPos _dropbox, 1000] call CBA_fnc_nearPlayer) || !alive _dropbox};
if (_dropMarker in allMapMarkers && {((getMarkerPos _dropMarker) distance2d _dropbox) < 200}) then {
	deleteMarker _dropMarker;
};
deleteVehicle _dropbox;