class CfgCommunicationMenu	{

    class battlefield_support	{
        text = "Call Support";
        submenu = "";
		expression = "SUPP_thisCall = _this spawn SUPP_fnc_callSupport";
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        removeAfterExpressionCall = 0;
    };
};
/*
class CfgCommunicationMenu	{

    class supp_drop	{
        text = "Call Supply Drop";
        submenu = "";
        expression = "null = _this spawn SUPP_fnc_supplydrop";
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        removeAfterExpressionCall = 0;
    };
	
    class supp_vehdrop	{
        text = "Call Vehicle Drop";
        submenu = "";
		expression = "null = _this spawn SUPP_fnc_preparesupplyvehicledrop";
        icon = "\a3\Ui_f\data\GUI\Cfg\Hints\SlingLoading_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        removeAfterExpressionCall = 0;
    };
	
    class supp_transport	{
        text = "Call Helicopter Transport";
        submenu = "";
        expression = "null = _this spawn SUPP_fnc_transport";
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        removeAfterExpressionCall = 0;
    };
	
    class supp_artillery	{
        text = "Call Artillery";
        submenu = "";
        expression = "null = _this spawn SUPP_fnc_artillery";
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        removeAfterExpressionCall = 0;
    };
	
    class supp_casheli	{
        text = "Call CAS Helicopter";
        submenu = "";
        expression = "null = _this spawn SUPP_fnc_casheli";
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\casheli_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        removeAfterExpressionCall = 0;
    };
	
    class supp_casbombing	{
        text = "Call Bomb Run";
        submenu = "";
        expression = "null = _this spawn SUPP_fnc_casbombing";
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\cas_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        removeAfterExpressionCall = 0;
    };
	
    class supp_uav	{
        text = "Call UAV Support";
        submenu = "";
        expression = "null = _this spawn SUPP_fnc_uavsupport";
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        removeAfterExpressionCall = 0;
    };
};
*/