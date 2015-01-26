/*
	BTK Client Settings main init.
*/


private ["_path","_keyNames","_keyIndex"];


// Init
waitUntil {(isDedicated) || !(isNull player)};


// No dedicated
if (isDedicated) exitWith {};


// Userconfig
_path = if (isClass (configFile >> "CfgPatches" >> "btk_clientsettings")) then { "\userconfig\btk\btk_clientsettings.hpp"; } else { "btk_clientsettings\btk_clientsettings.hpp"; };
[] call (compile (preprocessFileLineNumbers _path));


// Userconfig not found
if (isNil "btk_clientsettings_enabled") then {
	[] call (compile (preprocessFileLineNumbers "btk_clientsettings\btk_clientsettings.hpp"));
	[] spawn { sleep 1; hint parseText format["<t align='left'><t color='#ff0000'>WARNING</t><br />BTK Client Settings userconfig is missing!<br />Using default config...</t>"]; };
};


// Exit if already initialized or disabled
if (!(isNil "btk_clientsettings_init") || !(btk_clientsettings_enabled)) exitWith {};


// Config
btk_clientsettings_viewdistance_min = 500; // Min viewdistance
btk_clientsettings_viewdistance_max = 20000; // Max viewdistance
btk_clientsettings_terraingrid_min = 45; // Min terraingrid
btk_clientsettings_terraingrid_max = 5; // Max terraingrid


// Required variables
btk_clientsettings_keys_current = [];
btk_clientsettings_dialog_open = false;
btk_clientsettings_terraingrid = ([15, 1] call BTK_clientsettings_fnc_terrainGrid);


// Variables
_keys = btk_clientsettings_keys;
_keyNames = "";
_keyIndex = 0;


// Compile key names
{

	private ["_keyName","_fontFace"];

	_keyName = (keyName (_keys select _keyIndex));
	_fontFace = format["<font color='%1'>", ([(profileNamespace getVariable ["GUI_BCG_RGB_R", 0.3843]), (profileNamespace getVariable ["GUI_BCG_RGB_G", 0.7019]), (profileNamespace getVariable ["GUI_BCG_RGB_B", 0.8862]), (profileNamespace getVariable ["GUI_BCG_RGB_A", 0.7])] call BIS_fnc_colorRGBAtoHTML)];

	if (_keyIndex == ((count _keys) - 1)) then {
		_keyNames = (_keyNames + _fontFace + _keyName + "</font>");
	} else {
		_keyNames = (_keyNames + _fontFace + _keyName + "</font>" + " + ");
	};

	_keyIndex = _keyIndex + 1;

} forEach _keys;


// Note
player createDiarySubject ["BTK", "BTK"];
player createDiaryRecord ["BTK", ["BTK Client Settings", format["<br /><font color='%2'>Addon:</font> BTK Client Settings<br /><font color='%2'>Version:</font> 1.0.2<br /><font color='%2'>Author:</font> sxp2high (BTK) (btk@arma3.cc)<br /><br /><font color='%2'>Readme, Changelog, License</font> <br />https://github.com/sxp2high/BTK-Client-Settings<br /><br /><font color='%2'>Key bindings</font><br />Press %3 to open the dialog.", ([(profileNamespace getVariable ["GUI_BCG_RGB_R", 0.3843]), (profileNamespace getVariable ["GUI_BCG_RGB_G", 0.7019]), (profileNamespace getVariable ["GUI_BCG_RGB_B", 0.8862]), (profileNamespace getVariable ["GUI_BCG_RGB_A", 0.7])] call BIS_fnc_colorRGBAtoHTML), "#c9cacc", _keyNames]]];


// Create background blur
btk_clientsettings_dialog_blur = ppEffectCreate ["DynamicBlur", 160];
btk_clientsettings_dialog_blur ppEffectEnable false;


// Main flow
[] spawn {

	// Wait until ingame
	waituntil {!(isNull (finddisplay 46))};
	sleep 0.1;

	// Add keyhandlers
	_keyHandlerDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (((_this select 1) != 1) && !((_this select 1) in btk_clientsettings_keys_current) && ((count btk_clientsettings_keys_current) < (count btk_clientsettings_keys))) then { btk_clientsettings_keys_current set [(count btk_clientsettings_keys_current), (_this select 1)]; };"];
	_keyHandlerUp = (findDisplay 46) displayAddEventHandler ["KeyUp", "if (((_this select 1) != 1) && ((_this select 1) in btk_clientsettings_keys_current)) then { btk_clientsettings_keys_current = btk_clientsettings_keys_current - [(_this select 1)]; };"];

};


// Dialog flow
[] spawn {

	while {true} do {

		// Keys match
		waitUntil {(alive player) && ({(_x in btk_clientsettings_keys)} count btk_clientsettings_keys_current == (count btk_clientsettings_keys))};

		// Dialog open?
		if (btk_clientsettings_dialog_open) then {

			// Close
			if (dialog) then { closeDialog 0; };

		} else {

			// Open
			if (!(dialog)) then {
				btk_clientsettings_dialog_open = true;
				[] call BTK_clientsettings_fnc_dialog;
			};

		};

		// Keys free
		waitUntil {({((_x in btk_clientsettings_keys))} count btk_clientsettings_keys_current != (count btk_clientsettings_keys))};

	};

};


// All done
btk_clientsettings_init = true;