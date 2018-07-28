disableSerialization;

params [["_display",displayNull,[displayNull]]];

private _supportList = [
	"Supply Drop",
	"Vehicle Drop",
	"Helicopter Transport",
	"Artillery",
	"CAS Helicopter",
	"Air Strike",
	"UAV Recon"
];
private _supportListIcons = [
	"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa",
	"\a3\Ui_f\data\GUI\Cfg\Hints\SlingLoading_ca.paa",
	"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa",
	"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa",
	"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\casheli_ca.paa",
	"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\cas_ca.paa",
	"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa"
];

private _comboBoxCtrl = _display displayCtrl 11154;
lbClear _comboBoxCtrl;
{
	_comboBoxCtrl lbAdd _x;
	_comboBoxCtrl lbSetPicture [_foreachindex,(_supportListIcons select _forEachIndex)];
} foreach _supportList;