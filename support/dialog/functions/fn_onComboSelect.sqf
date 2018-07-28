disableSerialization;
params [["_comboBoxCtrl",controlNull,[controlNull]],["_index",0,[0]]];

//hint format ["%1,%2",str _comboBoxCtrl,str _index];
//creating left listbox after combo click

private _supportList = [
	"Supply Drop",
	"Vehicle Drop",
	"Helicopter Transport",
	"Artillery",
	"CAS Helicopter",
	"Air Strike",
	"UAV Recon"
];

private _dialog = findDisplay 11150;
private _leftLBTextCtrl = _dialog displayCtrl 11151;
private _middleLBTextCtrl = _dialog displayCtrl 11152;
private _rightLBTextCtrl = _dialog displayCtrl 11153;
private _pictureCtrl = _dialog displayCtrl 11155;
private _leftLBCtrl = _dialog displayCtrl 11156;
private _middleLBCtrl = _dialog displayCtrl 11157;
private _rightLBCtrl = _dialog displayCtrl 11158;
//private _mapCtrl = _dialog displayCtrl 11159;

private _supportType = _supportList select _index;
supportType = _supportType;

switch _supportType do {

	case "Supply Drop" : {
		private _helicopters = missionNamespace getVariable ["supp_helicopters",[]];
		{lbClear _x} forEach [_leftLBCtrl,_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_leftLBTextCtrl,_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];
		_leftLBTextCtrl ctrlSetText "Select chopper";
		{_leftLBCtrl lbAdd (getText (configFile >> "CfgVehicles" >> _x >> "displayName"))} forEach _helicopters;
	};
	case "Vehicle Drop" : {
		private _helicopter = ["O_Heli_Transport_04_covered_F","B_Heli_Transport_03_unarmed_F","I_Heli_Transport_02_F"] select ([EAST,WEST,INDEPENDENT] find (side player));
		{lbClear _x} forEach [_leftLBCtrl,_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_leftLBTextCtrl,_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];
		_leftLBTextCtrl ctrlSetText "Transport chopper";
		_leftLBCtrl lbAdd (getText (configFile >> "CfgVehicles" >> _helicopter >> "displayName"));
	};
	case "Helicopter Transport" : {
		private _helicopters = missionNamespace getVariable ["supp_helicopters",[]];
		{lbClear _x} forEach [_leftLBCtrl,_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_leftLBTextCtrl,_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];
		_leftLBTextCtrl ctrlSetText "Select chopper";
		{_leftLBCtrl lbAdd (getText (configFile >> "CfgVehicles" >> _x >> "displayName"))} forEach _helicopters;
	};
	case "Artillery" : {
		_shellType = ["Shell Smoke","Shell Flare","Shell HE"];
		{lbClear _x} forEach [_leftLBCtrl,_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_leftLBTextCtrl,_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];
		_leftLBTextCtrl ctrlSetText "Select shell";
		{_leftLBCtrl lbAdd _x} forEach _shellType;
	};
	case "CAS Helicopter" : {
		private _helicopters = missionNamespace getVariable ["supp_attackhelis",[]];
		{lbClear _x} forEach [_leftLBCtrl,_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_leftLBTextCtrl,_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];
		_leftLBTextCtrl ctrlSetText "Select gunship";
		{_leftLBCtrl lbAdd (getText (configFile >> "CfgVehicles" >> _x >> "displayName"))} forEach _helicopters;	
	};
	case "Air Strike" : {
		private _planes = missionNamespace getVariable ["supp_planes",[]];
		{lbClear _x} forEach [_leftLBCtrl,_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_leftLBTextCtrl,_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];
		_leftLBTextCtrl ctrlSetText "Select plane";
		{_leftLBCtrl lbAdd (getText (configFile >> "CfgVehicles" >> _x >> "displayName"))} forEach _planes;
	};
	case "UAV Recon" : {
		private _uavs = missionNamespace getVariable ["supp_uavs",[]];
		{lbClear _x} forEach [_leftLBCtrl,_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_leftLBTextCtrl,_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];
		_leftLBTextCtrl ctrlSetText "Select UAV";
		{_leftLBCtrl lbAdd (getText (configFile >> "CfgVehicles" >> _x >> "displayName"))} forEach _uavs;
	};
	default {};
};