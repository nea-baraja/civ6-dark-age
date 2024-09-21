
--==========================================================================================================================
-- GAME MODES
--==========================================================================================================================
	-- GAMEMODE_INTERESTING_AMENITY
	------------------------------------------------------------------------------------------------------------------------
		-- Parameters
		--------------------------------------------------------------------------
			INSERT INTO Parameters
				(
					ParameterId,
					Name,
					Description,
					Domain,
					DefaultValue,
					ConfigurationGroup,
					ConfigurationId,
					GroupId
				)
			VALUES
				(
					'GameMode_Interesting_Amenity',
					'LOC_GAMEMODE_INTERESTING_AMENITY_NAME',
					'LOC_GAMEMODE_INTERESTING_AMENITY_DESCRIPTION',
					'bool',
					0,
					'Game',
					'GAMEMODE_INTERESTING_AMENITY',
					'GameModes'
				);
		--------------------------------------------------------------------------
		-- ParameterCriteria
		--------------------------------------------------------------------------
			INSERT INTO ParameterCriteria
					(ParameterId,							ConfigurationGroup,		ConfigurationId,	Operator,		ConfigurationValue)
			VALUES	('GameMode_Interesting_Amenity',		'Game',					'GAMEMODE_RANDOM',	'NotEquals',	'1');
		--------------------------------------------------------------------------
		-- ParameterDependencies
		--------------------------------------------------------------------------
			INSERT INTO ParameterDependencies
					(ParameterId,							ConfigurationGroup,		ConfigurationId,	Operator,	ConfigurationValue)
			VALUES	('GameMode_Interesting_Amenity',		'Game',					'RULESET',			'Exists',	'RULESET_EXPANSION_1,RULESET_EXPANSION_2');
		--------------------------------------------------------------------------
		-- GameModeItems
		--------------------------------------------------------------------------
			INSERT INTO GameModeItems
				(
					GameModeType,
					Name,

					Icon,
					Portrait,
					Background,

					SortIndex
				)
			VALUES
				(
					'GAMEMODE_INTERESTING_AMENITY',
					'LOC_GAMEMODE_INTERESTING_AMENITY_NAME',

					'ICON_GAMEMODE_DA_TEST',
					'GAMEMODE_TREE_RANDOMIZER_NEUTRAL',
					'GAMEMODE_TREE_RANDOMIZER_BACKGROUND',

					10
				);

	-- GAMEMODE_CREATE_YOUR_PANTHEON
	------------------------------------------------------------------------------------------------------------------------
		-- Parameters
		--------------------------------------------------------------------------
			INSERT INTO Parameters
				(
					ParameterId,
					Name,
					Description,
					Domain,
					DefaultValue,
					ConfigurationGroup,
					ConfigurationId,
					GroupId
				)
			VALUES
				(
					'GameMode_Create_Your_Pantheon',
					'LOC_GAMEMODE_CREATE_YOUR_PANTHEON_NAME',
					'LOC_GAMEMODE_CREATE_YOUR_PANTHEON_DESCRIPTION',
					'bool',
					0,
					'Game',
					'GAMEMODE_CREATE_YOUR_PANTHEON',
					'GameModes'
				);
		--------------------------------------------------------------------------
		-- ParameterCriteria
		--------------------------------------------------------------------------
			INSERT INTO ParameterCriteria
					(ParameterId,							ConfigurationGroup,		ConfigurationId,	Operator,		ConfigurationValue)
			VALUES	('GameMode_Create_Your_Pantheon',		'Game',					'GAMEMODE_RANDOM',	'NotEquals',	'1');
		--------------------------------------------------------------------------
		-- ParameterDependencies
		--------------------------------------------------------------------------
			INSERT INTO ParameterDependencies
					(ParameterId,							ConfigurationGroup,		ConfigurationId,	Operator,	ConfigurationValue)
			VALUES	('GameMode_Create_Your_Pantheon',		'Game',					'RULESET',			'Exists',	'RULESET_EXPANSION_1,RULESET_EXPANSION_2');
		--------------------------------------------------------------------------
		-- GameModeItems
		--------------------------------------------------------------------------
			INSERT INTO GameModeItems
				(
					GameModeType,
					Name,

					Icon,
					Portrait,
					Background,

					SortIndex
				)
			VALUES
				(
					'GAMEMODE_CREATE_YOUR_PANTHEON',
					'LOC_GAMEMODE_CREATE_YOUR_PANTHEON_NAME',

					'ICON_GAMEMODE_DA_TEST',
					'GAMEMODE_TREE_RANDOMIZER_NEUTRAL',
					'GAMEMODE_TREE_RANDOMIZER_BACKGROUND',

					11
				);
-
--==========================================================================================================================
--==========================================================================================================================