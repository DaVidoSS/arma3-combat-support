terminate SUPP_thisCall;
if (supportType in allMapMarkers) then {
	deleteMarker supportType;
};
{_x = nil} forEach [supportType,supp_param1,supp_param2,supp_param4,supp_param3];
closeDialog 0;
