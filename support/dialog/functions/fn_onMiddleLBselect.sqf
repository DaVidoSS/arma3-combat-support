disableSerialization;
params [["_middleLBCtrl",controlNull,[controlNull]],["_index",0,[0]]];

private _dialog = findDisplay 11150;
private _rightLBTextCtrl = _dialog displayCtrl 11153;
private _pictureCtrl = _dialog displayCtrl 11155;
private _rightLBCtrl = _dialog displayCtrl 11158;
private _side = side player;

switch supportType do {

	case "Supply Drop" : {
		private _boxes = [];
		private _vehboxclass =  ["Box_East_AmmoVeh_F","Box_NATO_AmmoVeh_F","Box_IND_AmmoVeh_F"] select ([EAST,WEST,INDEPENDENT] find _side);
		private _supplyboxclass =  ["O_supplyCrate_F","B_supplyCrate_F","I_supplyCrate_F"] select ([EAST,WEST,INDEPENDENT] find _side);
		{_boxes pushBack _x} forEach [_vehboxclass,_supplyboxclass];
		private _box = _boxes param [_index,""];
		private _picture = getText (configFile >> "CfgVehicles" >> _box >> "editorPreview");	
		lbClear _rightLBCtrl;
		{_x ctrlSetText ""} forEach [_rightLBTextCtrl,_pictureCtrl];	
		_pictureCtrl ctrlSetText _picture;
		supp_param2 = _box;
	};
	case "Vehicle Drop" : {
		private _slingLoadVeh = (missionNamespace getVariable ["supp_slingLoadVehicles",[]]) param [_index,""];
		private _picture = getText (configFile >> "CfgVehicles" >> _slingLoadVeh >> "editorPreview");	
		lbClear _rightLBCtrl;
		{_x ctrlSetText ""} forEach [_rightLBTextCtrl,_pictureCtrl];	
		_pictureCtrl ctrlSetText _picture;
		supp_param2 = _slingLoadVeh;
	};

	case "Artillery" : {
		private _strikeType = ["Direct Hit","Suppress Area","Danger Close"];
		private _salvo = ["1","2","3","4","5","6","7","8","9","10"];
		lbClear _rightLBCtrl;
		_rightLBTextCtrl ctrlSetText "";	
		_rightLBTextCtrl ctrlSetText "Select strike";
		{_rightLBCtrl lbAdd _x} forEach _strikeType;
		supp_param2 = _salvo param [_index,""];		
	};
	default {};
};
