disableSerialization;
params [["_rightLBCtrl",controlNull,[controlNull]],["_index",0,[0]]];

switch supportType do {

	case "Artillery" : {
		private _strikeType = ["Direct Hit","Suppress Area","Danger Close"];
		supp_param3 = _strikeType param [_index,""];
	};
	default {};
};
