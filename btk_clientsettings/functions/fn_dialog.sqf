/*
	File: fn_dialog.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Opens the client settings dialog.

	Parameter(s):
		-

	Returns:
	BOOLEAN - true when open

	Syntax:
	_dialog = [] call BTK_clientsettings_fnc_dialog;
*/


private ["_dialog","_display"];


// Anim
if (((vehicle player) == player) && ((animationState player) !="amovpsitmstpslowwrfldnon") && ((animationState player) !="amovpercmstpsraswrfldnon_salute")) then { player playActionNow "Gear"; };


// Create dialog
disableSerialization;
_dialog = createDialog "btk_clientsettings_dialog";


// Dialog open
waitUntil {_dialog};
_display = (uiNamespace getVariable "btk_clientsettings_dialog_display");


// Set slider ranges and position
sliderSetRange [1900, ((btk_clientsettings_viewdistance_min / 1000) max 0.5), ((btk_clientsettings_viewdistance_max / 1000) min 20)];
sliderSetRange [1901, (([btk_clientsettings_terraingrid_min, 1] call BTK_clientsettings_fnc_terrainGrid) max 1), (([btk_clientsettings_terraingrid_max, 1] call BTK_clientsettings_fnc_terrainGrid) min 49)];
sliderSetPosition [1900 , (viewDistance / 1000)];
sliderSetPosition [1901, btk_clientsettings_terraingrid];


// Reset dialog
[] spawn {

	// Dialog open
	waitUntil {(dialog)};

	// Reset background
	btk_clientsettings_dialog_blur ppEffectEnable false;

	// Blur background
	btk_clientsettings_dialog_blur ppEffectAdjust [0.3];
	btk_clientsettings_dialog_blur ppEffectEnable true;
	btk_clientsettings_dialog_blur ppEffectCommit 1.5;

	// Dialog closed or died
	waitUntil {!(dialog) || !(alive player)};

	// Reset
	if (dialog) then { closeDialog 0; };
	btk_clientsettings_dialog_open = false;

	// Fade out background
	btk_clientsettings_dialog_blur ppEffectAdjust [0];
	btk_clientsettings_dialog_blur ppEffectCommit 0.75;

};


// Terrain grid
[] spawn {

	// While dialog open
	while {dialog} do {

		// Get terraingrid
		_terrainGrid = btk_clientsettings_terraingrid;
		_terrainGridReal = ([btk_clientsettings_terraingrid, 0] call BTK_clientsettings_fnc_terrainGrid);

		// Get terraingrid text
		_terrainGridText = switch (true) do {
			case (_terrainGridReal <= 10) : { "Very high"; };
			case ((_terrainGridReal > 10) && (_terrainGridReal <= 20)) : { "High"; };
			case ((_terrainGridReal > 20) && (_terrainGridReal <= 30)) : { "Normal"; };
			case ((_terrainGridReal > 30) && (_terrainGridReal <= 35)) : { "Low"; };
			case (_terrainGridReal > 35) : { "Very low"; };
		};

		// Set terraingrid text
		_text = format["Terrain detail (%1) (%2)", _terrainGridReal, _terrainGridText];
		ctrlSetText [1002, _text];

		// Set terraingrid
		setTerrainGrid _terrainGridReal;

		// Wait until updated or dialog closed
		waitUntil {(_terrainGrid != btk_clientsettings_terraingrid) || !(dialog)};

		// Exit if closed
		if (!(dialog)) exitWith {};

		sleep 0.1;

	};

};


// FPS counter, view distance
[] spawn {

	// While dialog open
	while {dialog} do {

		// Get view distance, fps
		_vd = format["View distance (%1)", (viewDistance)];
		_fps = format["FPS %1", (round diag_fps)];

		// Set view distance, fps
		ctrlSetText [1000, _vd];
		ctrlSetText [1003, _fps];

		sleep 0.1;

	};

};


true