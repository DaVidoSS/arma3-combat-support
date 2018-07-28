disableSerialization;
params [["_leftLBCtrl",controlNull,[controlNull]],["_index",0,[0]]];

private _dialog = findDisplay 11150;
private _middleLBTextCtrl = _dialog displayCtrl 11152;
private _rightLBTextCtrl = _dialog displayCtrl 11153;
private _pictureCtrl = _dialog displayCtrl 11155;
private _middleLBCtrl = _dialog displayCtrl 11157;
private _rightLBCtrl = _dialog displayCtrl 11158;
private _side = side player;

switch supportType do {

	case "Supply Drop" : {
		private _boxes = [];
		private _helicopter = ((missionNamespace getVariable ["supp_helicopters",[]]) param [_index,""]);
		private _vehboxclass =  ["Box_East_AmmoVeh_F","Box_NATO_AmmoVeh_F","Box_IND_AmmoVeh_F"] select ([EAST,WEST,INDEPENDENT] find _side);
		private _supplyboxclass =  ["O_supplyCrate_F","B_supplyCrate_F","I_supplyCrate_F"] select ([EAST,WEST,INDEPENDENT] find _side);
		{_boxes pushBack _x} forEach [_vehboxclass,_supplyboxclass];
		private _picture = getText (configFile >> "CfgVehicles" >> _helicopter >> "editorPreview");	
		{lbClear _x} forEach [_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];	
		_middleLBTextCtrl ctrlSetText "Select supply";
		_pictureCtrl ctrlSetText _picture;
		{_middleLBCtrl lbAdd (getText (configFile >> "CfgVehicles" >> _x >> "displayName"))} forEach _boxes;
		supp_param1 = _helicopter;
	};
	case "Vehicle Drop" : {

		private _helicopter = ["O_Heli_Transport_04_covered_F","B_Heli_Transport_03_unarmed_F","I_Heli_Transport_02_F"] select ([EAST,WEST,INDEPENDENT] find _side);
		private _slingLoadVeh = missionNamespace getVariable ["supp_slingLoadVehicles",[]];
		private _picture = getText (configFile >> "CfgVehicles" >> _helicopter >> "editorPreview");	
		{lbClear _x} forEach [_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];	
		_middleLBTextCtrl ctrlSetText "Select vehicle";
		_pictureCtrl ctrlSetText _picture;
		{_middleLBCtrl lbAdd (getText (configFile >> "CfgVehicles" >> _x >> "displayName"))} forEach _slingLoadVeh;
		supp_param1 = _helicopter;
	};
	case "Helicopter Transport" : {
		private _helicopter = ((missionNamespace getVariable ["supp_helicopters",[]]) param [_index,""]);
		private _picture = getText (configFile >> "CfgVehicles" >> _helicopter >> "editorPreview");	
		{lbClear _x} forEach [_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];
		_pictureCtrl ctrlSetText _picture;
		supp_param1 = _helicopter;
	};
	case "Artillery" : {
		private _shellType = ["Shell Smoke","Shell Flare","Shell HE"];
		private _salvo = ["1","2","3","4","5","6","7","8","9","10"];
		private _picture = "support\image\artillery.jpg";
		{lbClear _x} forEach [_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];	
		_middleLBTextCtrl ctrlSetText "Select salvo";
		_pictureCtrl ctrlSetText _picture;
		{_middleLBCtrl lbAdd _x} forEach _salvo;	
		supp_param1 = _shellType param [_index,""];
	};
	case "CAS Helicopter" : {
		private _helicopter = ((missionNamespace getVariable ["supp_attackhelis",[]]) param [_index,""]);
		private _picture = getText (configFile >> "CfgVehicles" >> _helicopter >> "editorPreview");	
		{lbClear _x} forEach [_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];	
		_pictureCtrl ctrlSetText _picture;
		supp_param1 = _helicopter;
	};
	case "Air Strike" : {
		private _weaponType = ["Canon","Missiles","Canon + Missiles","Bombs"];
		private _jet = ((missionNamespace getVariable ["supp_planes",[]]) param [_index,""]);
		private _picture = getText (configFile >> "CfgVehicles" >> _jet >> "editorPreview");	
		{lbClear _x} forEach [_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];	
		_middleLBTextCtrl ctrlSetText "Select weapon";
		_pictureCtrl ctrlSetText _picture;
		{_middleLBCtrl lbAdd _x} forEach _weaponType;
		supp_param1 = _jet;
	};
	case "UAV Recon" : {
		private _uav = ((missionNamespace getVariable ["supp_uavs",[]]) param [_index,""]);
		private _picture = getText (configFile >> "CfgVehicles" >> _uav >> "editorPreview");	
		{lbClear _x} forEach [_middleLBCtrl,_rightLBCtrl];
		{_x ctrlSetText ""} forEach [_middleLBTextCtrl,_rightLBTextCtrl,_pictureCtrl];	
		_pictureCtrl ctrlSetText _picture;
		supp_param1 = _uav;
	};
	default {};
};
