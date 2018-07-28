//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class support_call_system_dialog
{
	idd = 11150;
	onLoad = "0 = _this spawn SUPP_fnc_onLoadDialog; false";
	//onUnload = "systemChat 'killed'";
	class ControlsBackground
	{
		class supp_background : IGUIBack
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.265625;
			y = safeZoneY + safeZoneH * 0.04555556;
			w = safeZoneW * 0.465625;
			h = safeZoneH * 0.90111112;
			style = 64;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 2;
			
		};
		class supp_tittle : RscText
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.2675;
			y = safeZoneY + safeZoneH * 0.04666667;
			w = safeZoneW * 0.4625;
			h = safeZoneH * 0.03666667;
			style = 2;
			text = "SUPPORT CALL SYSTEM";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class supp_supporttype : RscText
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.2675;
			y = safeZoneY + safeZoneH * 0.09555556;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.03666667;
			style = 2+192;
			text = "Select support type";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class supp_supportparam : RscText 
		{
			type = 0;
			idc = 11151;
			x = safeZoneX + safeZoneW * 0.4425;
			y = safeZoneY + safeZoneH * 0.09555556;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 2+192;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class supp_supportparam2 : RscText
		{
			type = 0;
			idc = 11152;
			x = safeZoneX + safeZoneW * 0.5425;
			y = safeZoneY + safeZoneH * 0.09555556;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 2+192;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class supp_supportparam3 : RscText
		{
			type = 0;
			idc = 11153;
			x = safeZoneX + safeZoneW * 0.6425;
			y = safeZoneY + safeZoneH * 0.09555556;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 2+192;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class supp_vehpicture : RscPicture
		{
			type = 0;
			idc = 11155;
			x = safeZoneX + safeZoneW * 0.2675;
			y = safeZoneY + safeZoneH * 0.21777778;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.22555556;
			style = 48+2048;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class supp_map : RscMapControl
		{
			idc = 11159;
			x = safeZoneX + safeZoneW * 0.268125;
			y = safeZoneY + safeZoneH * 0.46222223;
			w = safeZoneW * 0.4625;
			h = safeZoneH * 0.47666667;
			onMouseButtonClick = "0 = [((_this select 0) ctrlMapScreenToWorld [ (_this select 2), (_this select 3)])] spawn SUPP_fnc_dialogMap; false";
		};
		
	};
	class Controls
	{
		class supp_combobox : RscCombo
		{
			type = 4;
			idc = 11154;
			x = safeZoneX + safeZoneW * 0.2675;
			y = safeZoneY + safeZoneH * 0.14444445;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.05555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0,0,0,0};
			colorDisabled[] = {0.2, 0.2, 0.2, 1};
			colorSelect[] = {0.302, 0.502, 0.302, 1};
			colorSelectBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
			onLBSelChanged = "0 = _this spawn SUPP_fnc_onComboSelect; false";
		};	
		class supp_listbox : RscListBox
		{
			type = 5;
			idc = 11156;
			x = safeZoneX + safeZoneW * 0.4425;
			y = safeZoneY + safeZoneH * 0.14444445;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.3;
			style = 16;
			colorBackground[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.302,0.502,0.302,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			onLBSelChanged = "0 = _this spawn SUPP_fnc_onLeftLBselect; false";	
			
		};
		class supp_listbox2 : RscListBox
		{
			type = 5;
			idc = 11157;
			x = safeZoneX + safeZoneW * 0.5425;
			y = safeZoneY + safeZoneH * 0.14444445;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.3;
			style = 16;
			colorBackground[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.302,0.502,0.302,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			onLBSelChanged = "0 = _this spawn SUPP_fnc_onMiddleLBselect; false";
		};
		class supp_listbox3 : RscListBox
		{
			type = 5;
			idc = 11158;
			x = safeZoneX + safeZoneW * 0.6425;
			y = safeZoneY + safeZoneH * 0.14444445;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.3;
			style = 16;
			colorBackground[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.302,0.502,0.302,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			onLBSelChanged = "0 = _this spawn SUPP_fnc_onRightLBselect; false";
		};
		class supp_buttoncall : RscButton
		{
			type = 1;
			idc = 11160;
			x = safeZoneX + safeZoneW * 0.6;
			y = safeZoneY + safeZoneH * 0.88777778;
			w = safeZoneW * 0.075;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "CALL";
			borderSize = 0;
			colorBackground[] = {0.6,0.6,0.6,1};
			colorBackgroundActive[] = {0.302,0.502,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {1,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			action = "0 = [] spawn SUPP_fnc_onCallButtonHit";
			
		};
		class supp_buttonexit : RscButton
		{
			type = 1;
			idc = 11161;
			x = safeZoneX + safeZoneW * 0.3225;
			y = safeZoneY + safeZoneH * 0.88777778;
			w = safeZoneW * 0.075;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "EXIT";
			borderSize = 0;
			colorBackground[] = {0.6,0.6,0.6,1};
			colorBackgroundActive[] = {0.302,0.502,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {1,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			action = "0 = [] spawn SUPP_fnc_onExitButtonHit";
		};
		
	};
	
};
