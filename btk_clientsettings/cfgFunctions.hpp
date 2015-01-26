class btk_clientsettings {

	tag = "BTK_clientsettings";

	class Init {

		class init { file = "btk_clientsettings\init.sqf"; postInit = 1; };

	};

	class Misc {

		file = "btk_clientsettings\functions";

		class dialog {};
		class terrainGrid {};

	};

};