#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)


class IGUIBack;
class RscText;
class RscButton;


class btk_slider_base {

	style = 1024;
	type = 43;
	shadow = 2;
	x = 0;
	y = 0;
	h = 0.02;
	w = 0.4;
	color[] = {1,1,1,0.7};
	colorActive[] = {1,1,1,0.9};
	colorDisabled[] = {1,1,1,0.5};
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";

};


class btk_clientsettings_dialog {

    idd = -1;
    movingEnable = true;
	enableSimulation = true;
    onLoad = "uiNamespace setVariable ['btk_clientsettings_dialog_display', (_this select 0)];";

    class Controls {

		class IGUIBack_2200: IGUIBack {
			idc = 2200;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 23 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};

		class IGUIBack_2201: IGUIBack {
			idc = 2201;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 16.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};

		class IGUIBack_2203: IGUIBack {
			idc = 2203;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 20.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.6};
		};

		class RscText_1000: RscText {
			idc = 1000;
			text = "View distance";
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			shadow = 0;
			colorBackground[] = {"(profilenamespace getVariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getVariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getVariable ['GUI_BCG_RGB_B',0.8862])",0.9};
			sizeEx = 1 * GUI_GRID_H;
		};

		class RscSlider_1900: btk_slider_base {
			idc = 1900;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			onSliderPosChanged = "if ((typeName (_this select 1)) == 'SCALAR') then { setViewDistance round((_this select 1)*1000) };";
		};

		class RscText_1002: RscText {
			idc = 1002;
			text = "Terrain detail";
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 19 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			shadow = 0;
			colorBackground[] = {"(profilenamespace getVariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getVariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getVariable ['GUI_BCG_RGB_B',0.8862])",0.9};
			sizeEx = 1 * GUI_GRID_H;
		};

		class RscText_1003: RscText {
			idc = 1003;
			text = "FPS";
			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,0.9};
			colorBackground[] = {1,1,1,0};
			tooltip = "Frames Per Second";
			sizeEx = 1.25 * GUI_GRID_H;
		};

		class RscButton_1604: RscButton {
			idc = 1604;
			text = "Exit";
			x = 24.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			tooltip = "Exit (ESC)";
			onButtonClick = "closeDialog 0;";
			colorBackground[] = {"(profilenamespace getVariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getVariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getVariable ['GUI_BCG_RGB_B',0.8862])",0.9};
		};

		class RscSlider_1901: btk_slider_base {
			idc = 1901;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			onSliderPosChanged = "if ((typeName (_this select 1)) == 'SCALAR') then { btk_clientsettings_terraingrid = ((round(_this select 1)) max 1); };";
		};

    };

};