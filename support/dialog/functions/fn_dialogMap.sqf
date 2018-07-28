
params [ ["_data",[],[[]]] ];

disableSerialization;

switch supportType do {

	case "Supply Drop" : {

		if (supportType in allMapMarkers) then {
			deleteMarker supportType;
		};
		_mrkr = createMarker [supportType, _data]; 
		_mrkr setMarkerShape "ICON"; 
		_mrkr setMarkerColor "Default"; 
		_mrkr setMarkerSize [1, 1]; 
		_mrkr setMarkerType "hd_end"; 
		_mrkr setMarkerText toUpper supportType;
		supp_param4 = _data;
	};


case "Vehicle Drop" : {

		if (supportType in allMapMarkers) then {
			deleteMarker supportType;
		};
		_mrkr = createMarker [supportType, _data]; 
		_mrkr setMarkerShape "ICON"; 
		_mrkr setMarkerColor "Default"; 
		_mrkr setMarkerSize [1, 1]; 
		_mrkr setMarkerType "hd_end"; 
		_mrkr setMarkerText toUpper supportType;
		supp_param4 = _data;

};
case "Helicopter Transport" : {

		if (supportType in allMapMarkers) then {
			deleteMarker supportType;
		};
		_mrkr = createMarker [supportType, _data]; 
		_mrkr setMarkerShape "ICON"; 
		_mrkr setMarkerColor "Default"; 
		_mrkr setMarkerSize [1, 1]; 
		_mrkr setMarkerType "hd_pickup"; 
		_mrkr setMarkerText toUpper supportType;
		supp_param4 = _data;

};
case "Artillery" : {
		if (supportType in allMapMarkers) then {
			deleteMarker supportType;
		};
		_mrkr = createMarker [supportType, _data]; 
		_mrkr setMarkerShape "ICON"; 
		_mrkr setMarkerColor "Default"; 
		_mrkr setMarkerSize [1, 1]; 
		_mrkr setMarkerType "hd_warning"; 
		_mrkr setMarkerText toUpper supportType;
		supp_param4 = _data;
};
case "CAS Helicopter" : {
		if (supportType in allMapMarkers) then {
			deleteMarker supportType;
		};
		_mrkr = createMarker [supportType, _data]; 
		_mrkr setMarkerShape "ICON"; 
		_mrkr setMarkerColor "Default"; 
		_mrkr setMarkerSize [1, 1]; 
		_mrkr setMarkerType "KIA"; 
		_mrkr setMarkerText toUpper supportType;
		supp_param4 = _data;
};
case "Air Strike" : {
		if (supportType in allMapMarkers) then {
			deleteMarker supportType;
		};
		_mrkr = createMarker [supportType, _data]; 
		_mrkr setMarkerShape "ICON"; 
		_mrkr setMarkerColor "Default"; 
		_mrkr setMarkerSize [1, 1]; 
		_mrkr setMarkerType "hd_destroy"; 
		_mrkr setMarkerText toUpper supportType;
		supp_param4 = _data;
};
case "UAV Recon" : {
		if (supportType in allMapMarkers) then {
			deleteMarker supportType;
		};
		_mrkr = createMarker [supportType, _data]; 
		_mrkr setMarkerShape "ICON"; 
		_mrkr setMarkerColor "Default"; 
		_mrkr setMarkerSize [1, 1]; 
		_mrkr setMarkerType "hd_unknown"; 
		_mrkr setMarkerText toUpper supportType;
		supp_param4 = _data;
};
default {};
};
