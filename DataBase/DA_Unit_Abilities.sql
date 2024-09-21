insert or replace into TypeTags(Type,Tag)
select UnitType ,'CLASS_LAND_COMBAT' from Units where FormationClass = 'FORMATION_CLASS_LAND_COMBAT';
insert or replace into TypeTags(Type,Tag)
select UnitType ,'CLASS_LAND_UNITS' from Units where Domain = 'DOMAIN_LAND';
insert or replace into TypeTags(Type,Tag)
select UnitType ,'CLASS_NAVAL' from Units where FormationClass = 'FORMATION_CLASS_NAVAL';
insert or replace into TypeTags(Type,Tag)
select UnitType ,'CLASS_AIR' from Units where FormationClass = 'FORMATION_CLASS_AIR';
insert or replace into TypeTags(Type,Tag)
select UnitType ,'CLASS_MILITARY' from Units where FormationClass != 'FORMATION_CLASS_CIVILIAN' AND FormationClass != 'FORMATION_CLASS_SUPPORT';

insert or replace into Tags
	(Tag,									Vocabulary)
values
	('CLASS_MILITARY_ENGINEER',				'ABILITY_CLASS'),
	('CLASS_BUILDER',						'ABILITY_CLASS'),
	('CLASS_SETTLER',						'ABILITY_CLASS'),
	('CLASS_MILITARY',						'ABILITY_CLASS'),
	('CLASS_LAND_UNITS',					'ABILITY_CLASS'),
	('CLASS_AIR',							'ABILITY_CLASS'),
	('CLASS_NAVAL',							'ABILITY_CLASS'),
	('CLASS_LAND_COMBAT',					'ABILITY_CLASS');

insert or replace into TypeTags
	(Type,									Tag)
values
	('UNIT_MILITARY_ENGINEER', 'CLASS_MILITARY_ENGINEER'),
	('UNIT_BUILDER', 'CLASS_BUILDER'),
	('UNIT_SETTLER', 'CLASS_SETTLER');

insert or replace into Types
	(Type,														Kind)
values

	-- ('ABILITY_SUPPRESSING',											'KIND_ABILITY'),
	('ABILITY_SUPPRESSED',												'KIND_ABILITY'),


	('ABILITY_BUILDROAD_MODE',										'KIND_ABILITY'),
	('ABILITY_TRIBE_STRENGTH',										'KIND_ABILITY'),
	('ABILITY_BISHOP_EXTRA_MOVEMENT',							'KIND_ABILITY'),
	('ABILITY_GUILDMASTER_TRAINED_BUILDER_MOVEMENT','KIND_ABILITY'),
	('ABILITY_EXPEDITION_TRAINED_SETTLER_MOVEMENT',	'KIND_ABILITY'),

	('ABILITY_BARRACK_FARM',											'KIND_ABILITY'),
	('ABILITY_STABLED_CAMP',											'KIND_ABILITY'),
	('ABILITY_COOPERATIVE_FLANKING',							'KIND_ABILITY'),
	('ABILITY_FORGE_WEAPON_STRENGTH',							'KIND_ABILITY'),
	('ABILITY_COOPERATIVE_SUPPORT',								'KIND_ABILITY'),
	('ABILITY_CARRIAGE_TRANSPORT_MOVEMENT',				'KIND_ABILITY');

insert or replace into Types	(Type,																Kind) select
	'ABILITY_LOSE_'||numbers||'_BUILD_CHARGES',		'KIND_ABILITY'
	from counter where numbers > 0 and numbers < 11;

insert or replace into Types	(Type,																Kind) select
	'ABILITY_ADD_'||numbers||'_BUILD_CHARGES',		'KIND_ABILITY'
	from counter where numbers > 0 and numbers < 11;

insert or replace into TypeTags
	(Type,																Tag)
values
	('ABILITY_SUPPRESSED',												'CLASS_MILITARY'),


	('ABILITY_BUILDROAD_MODE',										'CLASS_BUILDER'),
	('ABILITY_TRIBE_STRENGTH',										'CLASS_MILITARY'),
	('ABILITY_BISHOP_EXTRA_MOVEMENT',									'CLASS_RELIGIOUS_ALL'),
	('ABILITY_GUILDMASTER_TRAINED_BUILDER_MOVEMENT',					'CLASS_BUILDER'),
	('ABILITY_EXPEDITION_TRAINED_SETTLER_MOVEMENT',					'CLASS_SETTLER'),


	('ABILITY_BARRACK_FARM',											'CLASS_MELEE'),
	('ABILITY_BARRACK_FARM',											'CLASS_RANGED'),
	('ABILITY_BARRACK_FARM',											'CLASS_ANTI_CAVALRY'),	

	('ABILITY_STABLED_CAMP',											'CLASS_LIGHT_CAVALRY'),
	('ABILITY_STABLED_CAMP',											'CLASS_HEAVY_CAVALRY'),
	('ABILITY_STABLED_CAMP',											'CLASS_HEAVY_CHARIOT'),


	('ABILITY_COOPERATIVE_FLANKING',							'CLASS_LAND_COMBAT'),
	('ABILITY_FORGE_WEAPON_STRENGTH',							'CLASS_MILITARY'),	
	('ABILITY_COOPERATIVE_SUPPORT',								'CLASS_LAND_COMBAT'),
	('ABILITY_CARRIAGE_TRANSPORT_MOVEMENT',				'CLASS_LAND_UNITS');

insert or replace into TypeTags	(Type,																Tag) select
	'ABILITY_LOSE_'||numbers||'_BUILD_CHARGES',		'CLASS_BUILDER'
	from counter where numbers > 0 and numbers < 11;

insert or replace into TypeTags	(Type,																Tag) select
	'ABILITY_ADD_'||numbers||'_BUILD_CHARGES',		'CLASS_BUILDER'
	from counter where numbers > 0 and numbers < 11;

insert or replace into UnitAbilities (UnitAbilityType, Name, Description, Inactive) values


    ('ABILITY_SUPPRESSED',
    'LOC_ABILITY_SUPPRESSED_NAME',
    'LOC_ABILITY_SUPPRESSED_DESCRIPTION',
    1),

    ('ABILITY_BUILDROAD_MODE',
		NULL,
		NULL,
    1),
    ('ABILITY_TRIBE_STRENGTH',
    'LOC_ABILITY_TRIBE_STRENGTH_NAME',
    'LOC_ABILITY_TRIBE_STRENGTH_DESCRIPTION',
    1),
   	('ABILITY_BISHOP_EXTRA_MOVEMENT',
		'LOC_ABILITY_BISHOP_EXTRA_MOVEMENT_NAME',
 		'LOC_ABILITY_BISHOP_EXTRA_MOVEMENT_DESCRIPTION',
 		1),	
		('ABILITY_GUILDMASTER_TRAINED_BUILDER_MOVEMENT',
		'LOC_ABILITY_GUILDMASTER_TRAINED_BUILDER_MOVEMENT_NAME',
	 	'LOC_ABILITY_GUILDMASTER_TRAINED_BUILDER_MOVEMENT_DESCRIPTION',
	 	1),	
		('ABILITY_EXPEDITION_TRAINED_SETTLER_MOVEMENT',
		'LOC_ABILITY_EXPEDITION_TRAINED_SETTLER_MOVEMENT_NAME',
	 	'LOC_ABILITY_EXPEDITION_TRAINED_SETTLER_MOVEMENT_DESCRIPTION',
	 	1),	
 		('ABILITY_BARRACK_FARM',
    'LOC_ABILITY_BARRACK_FARM_NAME',
    'LOC_ABILITY_BARRACK_FARM_DESCRIPTION',
    1),
    ('ABILITY_STABLED_CAMP',
    'LOC_ABILITY_STABLED_CAMP_NAME',
    'LOC_ABILITY_STABLED_CAMP_DESCRIPTION',
    1),
    ('ABILITY_COOPERATIVE_FLANKING',
    'LOC_ABILITY_COOPERATIVE_FLANKING_NAME',
    'LOC_ABILITY_COOPERATIVE_FLANKING_DESCRIPTION',
    1),
    ('ABILITY_COOPERATIVE_SUPPORT',
    'LOC_ABILITY_COOPERATIVE_SUPPORT_NAME',
    'LOC_ABILITY_COOPERATIVE_SUPPORT_DESCRIPTION',
    1),
    ('ABILITY_FORGE_WEAPON_STRENGTH',
    'LOC_ABILITY_FORGE_WEAPON_STRENGTH_NAME',
    'LOC_ABILITY_FORGE_WEAPON_STRENGTH_DESCRIPTION',
    1),
      ('ABILITY_CARRIAGE_TRANSPORT_MOVEMENT',
    'LOC_ABILITY_CARRIAGE_TRANSPORT_MOVEMENT_NAME',
    'LOC_ABILITY_CARRIAGE_TRANSPORT_MOVEMENT_DESCRIPTION',
    1);

insert or replace into UnitAbilities (UnitAbilityType, Name, Description, Inactive) select
	'ABILITY_LOSE_'||numbers||'_BUILD_CHARGES', null, null, 1
	from counter where numbers > 0 and numbers < 11;

insert or replace into UnitAbilities (UnitAbilityType, Name, Description, Inactive) select
	'ABILITY_ADD_'||numbers||'_BUILD_CHARGES', null, null, 1
	from counter where numbers > 0 and numbers < 11;

insert or replace into UnitAbilityModifiers
	(UnitAbilityType,										ModifierId							)
values
	('ABILITY_SUPPRESSED',											'SUPPRESSED_LOSE_MOVEMENT'),


	('ABILITY_BUILDROAD_MODE',									'BUILDROAD_MODE_IGNORE_TERRAIN'),
	('ABILITY_BUILDROAD_MODE',									'BUILDROAD_MODE_IGNORE_RIVER'),

	('ABILITY_TRIBE_STRENGTH',									'TRIBE_STRENGTH'	),
	('ABILITY_BISHOP_EXTRA_MOVEMENT',						'BISHOP_EXTRA_MOVEMENT'),
	('ABILITY_GUILDMASTER_TRAINED_BUILDER_MOVEMENT', 'LIANG_EXTRA_MOVEMENT'),
	('ABILITY_EXPEDITION_TRAINED_SETTLER_MOVEMENT', 'MAGNUS_EXTRA_MOVEMENT'),

	('ABILITY_BARRACK_FARM',										'BARRACK_FARM_FOOD'),
	('ABILITY_BARRACK_FARM',										'BARRACK_FARM_COST'),
	('ABILITY_BARRACK_FARM',										'BARRACK_FARM_COST_DISCOUNT'),

	('ABILITY_STABLED_CAMP',										'STABLED_CAMP_FOOD'),
	('ABILITY_STABLED_CAMP',										'STABLED_CAMP_COST'),
	('ABILITY_STABLED_CAMP',										'STABLED_CAMP_COST_DISCOUNT'),

	('ABILITY_FORGE_WEAPON_STRENGTH',						'FORGE_WEAPON_STRENGTH_MODIFIER'	),
	('ABILITY_COOPERATIVE_FLANKING',						'COOPERATIVE_FLANKING_MODIFIER'		),
	('ABILITY_COOPERATIVE_SUPPORT',							'COOPERATIVE_SUPPORT_MODIFIER'		),
	('ABILITY_CARRIAGE_TRANSPORT_MOVEMENT',			'CARRIAGE_TRANSPORT_MOVEMENT_MODIFIER'	);

insert or replace into UnitAbilityModifiers(UnitAbilityType,										ModifierId) select
	'ABILITY_LOSE_'||numbers||'_BUILD_CHARGES', 'LOSE_'||numbers||'_BUILD_CHARGES'
	from counter where numbers > 0 and numbers < 11;

insert or replace into UnitAbilityModifiers(UnitAbilityType,										ModifierId) select
	'ABILITY_ADD_'||numbers||'_BUILD_CHARGES', 'ADD_'||numbers||'_BUILD_CHARGES'
	from counter where numbers > 0 and numbers < 11;

insert or replace into Modifiers(ModifierId, 				ModifierType) values
	('SUPPRESSED_LOSE_MOVEMENT',										'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT'),


	('BUILDROAD_MODE_IGNORE_TERRAIN',									'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_TERRAIN_COST'),
	('BUILDROAD_MODE_IGNORE_RIVER',										'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_RIVERS'),

	('TRIBE_STRENGTH',											'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH'),
	('BISHOP_EXTRA_MOVEMENT',								'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT'),
	('LIANG_EXTRA_MOVEMENT',							'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT'),
	('MAGNUS_EXTRA_MOVEMENT',							'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT'),


	('BARRACK_FARM_COST',										'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE'),
	('STABLED_CAMP_COST',										'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE'),
	('BARRACK_FARM_FOOD_MOD',								'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS'),
	('STABLED_CAMP_FOOD_MOD',								'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS'),


	('FORGE_WEAPON_STRENGTH_MODIFIER',				'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH'),
	('COOPERATIVE_FLANKING_MODIFIER',				'MODIFIER_PLAYER_UNIT_ADJUST_FLANKING_BONUS_MODIFIER'),
	('COOPERATIVE_SUPPORT_MODIFIER',				'MODIFIER_PLAYER_UNIT_ADJUST_SUPPORT_BONUS_MODIFIER'),
	('CARRIAGE_TRANSPORT_MOVEMENT_MODIFIER',		'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT');

insert or replace into Modifiers(ModifierId, 				ModifierType) select
	'LOSE_'||numbers||'_BUILD_CHARGES',			'MODIFIER_UNIT_ADJUST_BUILDER_CHARGES'
	from counter where numbers > 0 and numbers < 11;

insert or replace into Modifiers(ModifierId, 				ModifierType) select
	'ADD_'||numbers||'_BUILD_CHARGES',			'MODIFIER_UNIT_ADJUST_BUILDER_CHARGES'
	from counter where numbers > 0 and numbers < 11;

insert or replace into Modifiers(ModifierId, 				ModifierType, SubjectRequirementSetId, OwnerRequirementSetId,	SubjectStackLimit) values

	('BARRACK_FARM_FOOD',										'MODIFIER_PLAYER_PLOTS_ATTACH_MODIFIER',		'RS_FARM_OR_PLANTATION_NEAR',null, 1),
	('BARRACK_FARM_COST_DISCOUNT',					'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE',			null, 'RS_ON_EACAMPMENT_OR_FORT', null),
	('STABLED_CAMP_FOOD',										'MODIFIER_PLAYER_PLOTS_ATTACH_MODIFIER',		'RS_CAMP_OR_PASTURE_NEAR',null, 1),
	('STABLED_CAMP_COST_DISCOUNT',					'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE',			null, 'RS_ON_EACAMPMENT_OR_FORT', null);





insert or replace into ModifierArguments
	(ModifierId,											Name,					Value)
values
	('SUPPRESSED_LOSE_MOVEMENT',										'Amount',						-3),



	('BUILDROAD_MODE_IGNORE_TERRAIN',								'Ignore',						1),
	('BUILDROAD_MODE_IGNORE_TERRAIN',								'Type',							'ALL'),
	('BUILDROAD_MODE_IGNORE_RIVER',									'Ignore',						1),

	('TRIBE_STRENGTH',														'Amount',							4),	
	('BISHOP_EXTRA_MOVEMENT',											'Amount',							2),
	('LIANG_EXTRA_MOVEMENT',											'Amount',							2),
	('MAGNUS_EXTRA_MOVEMENT',											'Amount',							2),


	('BARRACK_FARM_FOOD',														'ModifierId',				'BARRACK_FARM_FOOD_MOD'),
	('STABLED_CAMP_FOOD',														'ModifierId',				'STABLED_CAMP_FOOD_MOD'),
	('BARRACK_FARM_FOOD_MOD',												'YieldType',				'YIELD_FOOD'),
	('BARRACK_FARM_FOOD_MOD',												'Amount',						1),
	('BARRACK_FARM_COST',														'YieldType',				'YIELD_GOLD'),
	('BARRACK_FARM_COST',														'Amount',						-12),	
	('BARRACK_FARM_COST_DISCOUNT',									'YieldType',				'YIELD_GOLD'),
	('BARRACK_FARM_COST_DISCOUNT',									'Amount',						12),
	('STABLED_CAMP_FOOD_MOD',												'YieldType',				'YIELD_FOOD'),
	('STABLED_CAMP_FOOD_MOD',												'Amount',						1),
	('STABLED_CAMP_COST',														'YieldType',				'YIELD_GOLD'),
	('STABLED_CAMP_COST',														'Amount',						-12),	
	('STABLED_CAMP_COST_DISCOUNT',									'YieldType',				'YIELD_GOLD'),
	('STABLED_CAMP_COST_DISCOUNT',									'Amount',						6),

	('FORGE_WEAPON_STRENGTH_MODIFIER',							'Amount',				3),
	('COOPERATIVE_FLANKING_MODIFIER',								'Percent',				50),
	('COOPERATIVE_SUPPORT_MODIFIER',								'Percent',				50),
	('CARRIAGE_TRANSPORT_MOVEMENT_MODIFIER',				'Amount',				1);

insert or replace into ModifierArguments(ModifierId,											Name,					Value) select
	'LOSE_'||numbers||'_BUILD_CHARGES',			'Amount',			-1
	from counter where numbers > 0 and numbers < 11;

insert or replace into ModifierArguments(ModifierId,											Name,					Value) select
	'ADD_'||numbers||'_BUILD_CHARGES',			'Amount',			1
	from counter where numbers > 0 and numbers < 11;


insert or replace into RequirementSets(RequirementSetId,	RequirementSetType) values
	('RS_ON_EACAMPMENT_OR_FORT',				'REQUIREMENTSET_TEST_ANY'),

	('RS_FARM_OR_PLANTATION_NEAR',			'REQUIREMENTSET_TEST_ALL'),
	('RS_CAMP_OR_PASTURE_NEAR',					'REQUIREMENTSET_TEST_ALL');


insert or replace into RequirementSetRequirements(RequirementSetId,	RequirementId) values
	('RS_ON_EACAMPMENT_OR_FORT',				'REQ_PLOT_HAS_FORT_IMPROVEMENT'),
	('RS_ON_EACAMPMENT_OR_FORT',				'REQ_PLOT_ON_DISTRICT_ENCAMPMENT'),

	
	('RS_FARM_OR_PLANTATION_NEAR',			'REQ_PLOT_HAS_BARRACK_FARM_IMPROVEMENT'),
	('RS_FARM_OR_PLANTATION_NEAR',			'REQ_OBJECT_WITHIN_1_TILES'),
	('RS_CAMP_OR_PASTURE_NEAR',					'REQ_PLOT_HAS_STABLED_CAMP_IMPROVEMENT'),
	('RS_CAMP_OR_PASTURE_NEAR',					'REQ_OBJECT_WITHIN_1_TILES');





insert or replace into ModifierStrings
	(ModifierId,										Context,	Text)
values
	('FORGE_WEAPON_STRENGTH_MODIFIER',					'Preview',	'+{1_Amount} {LOC_FORGE_WEAPON_STRENGTH_MODIFIER_PREVIEW_TEXT}'),
	('TRIBE_STRENGTH',													'Preview',	'+{1_Amount} {LOC_TRIBE_STRENGTH_PREVIEW_TEXT}');

