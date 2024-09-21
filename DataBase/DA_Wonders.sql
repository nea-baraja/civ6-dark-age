
delete from BuildingModifiers where BuildingType in ('BUILDING_TEMPLE_ARTEMIS', 'BUILDING_ORACLE', 'BUILDING_HANGING_GARDENS');--, 'BUILDING_ETEMENANKI'
delete from BuildingModifiers where BuildingType = 'BUILDING_PYRAMIDS' and ModifierId = 'PYRAMID_GRANT_BUILDERS';
update Buildings set Description = 'LOC_'||BuildingType||'_DESCRIPTION' where BuildingType in
	('BUILDING_PYRAMIDS', 'BUILDING_GREAT_BATH', 'BUILDING_TEMPLE_ARTEMIS', 'BUILDING_ORACLE', 'BUILDING_HANGING_GARDENS',
		'BUILDING_JEBEL_BARKAL');



insert or ignore into BuildingModifiers(BuildingType,	ModifierId) values
	('BUILDING_PYRAMIDS',		'PRYAMID_BUILDER_EXTRA_MOVEMENTS'),
	('BUILDING_GREAT_BATH',		'GREAT_BATH_RIVER_DISTRICT_AMENITY');

insert or ignore into BuildingModifiers(BuildingType, ModifierId) select
	'BUILDING_HANGING_GARDENS',		'HANGING_GARDENS_DISTRICT_FOOD_FROM_'||TerrainType
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');


insert or ignore into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('PRYAMID_BUILDER_EXTRA_MOVEMENTS',			'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',					'RS_UNIT_IS_CLASS_BUILDER'),
	('GREAT_BATH_RIVER_DISTRICT_AMENITY',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_DISTRICT_AMENITY',		'RS_RIVER_DISTRICT');

insert or ignore into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'HANGING_GARDENS_DISTRICT_FOOD_FROM_'||TerrainType, 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',  'RS_NOT_WONDER_ON_'||TerrainType
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');

insert or ignore into Modifiers(ModifierId,	ModifierType) values
	('DA_GREAT_BATH_AMENITY', 		'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_AMENITY'),
	('DA_GREAT_BATH_HOUSING', 		'MODIFIER_SINGLE_CITY_ADJUST_POLICY_HOUSING'),
	('DA_GREAT_BATH_POPULATION', 	'MODIFIER_SINGLE_CITY_ADD_POPULATION');

--insert or replace into Modifiers



insert or ignore into ModifierArguments(ModifierId, Name, Value) values
	('PRYAMID_BUILDER_EXTRA_MOVEMENTS',			'Amount',			1),
	('GREAT_BATH_RIVER_DISTRICT_AMENITY',		'Amount',			1),
	('DA_GREAT_BATH_AMENITY', 					'Amount',			1),
	('DA_GREAT_BATH_HOUSING', 					'Amount',			2),
	('DA_GREAT_BATH_POPULATION', 				'Amount',			1);

insert or ignore into ModifierArguments(ModifierId, Name, Value) select
	'HANGING_GARDENS_DISTRICT_FOOD_FROM_'||TerrainType, 'YieldType', YieldType
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');

insert or ignore into ModifierArguments(ModifierId, Name, Value) select
	'HANGING_GARDENS_DISTRICT_FOOD_FROM_'||TerrainType, 'Amount', YieldChange
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');



insert or ignore into RequirementSets(RequirementSetId,	RequirementSetType) select
	'RS_NOT_WONDER_ON_'||TerrainType, 'REQUIREMENTSET_TEST_ALL'
	from Terrains
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');	

insert or ignore into RequirementSetRequirements(RequirementSetId,	RequirementId) select
	'RS_NOT_WONDER_ON_'||TerrainType, 'REQ_NOT_WONDER'
	from Terrains
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');		

insert or ignore into RequirementSetRequirements(RequirementSetId,	RequirementId) select
	'RS_NOT_WONDER_ON_'||TerrainType, 'REQ_PLOT_IS_'||TerrainType
	from Terrains
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');	


--阿尔特弥斯神庙单位能力
insert or replace into Types
	(Type,														Kind)
values

	('ABILITY_DA_ARTEMIS_CAMP_STRENGTH',						'KIND_ABILITY');

insert or replace into TypeTags
	(Type,										Tag)
values 
	('ABILITY_DA_ARTEMIS_CAMP_STRENGTH',		'CLASS_RANGED');

insert or replace into UnitAbilities
	(UnitAbilityType,							Name,												Description,											Inactive)
values
	('ABILITY_DA_ARTEMIS_CAMP_STRENGTH',		'LOC_ABILITY_DA_ARTEMIS_CAMP_STRENGTH_NAME',		'LOC_ABILITY_DA_ARTEMIS_CAMP_STRENGTH_DESCRIPTION',		1);

insert or replace into UnitAbilityModifiers
	(UnitAbilityType,									ModifierId)
values

	('ABILITY_DA_ARTEMIS_CAMP_STRENGTH',				'RANGED_UNIT_DA_ARTEMIS_CAMP_STRENGTH');

insert or replace into Modifiers
	(ModifierId,								ModifierType,									OwnerRequirementSetId,		SubjectRequirementSetId)
values

	('RANGED_UNIT_DA_ARTEMIS_CAMP_STRENGTH',	'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',			NULL,						NULL);

insert or replace into ModifierArguments
	(ModifierId,										Name,					value)
values

	('RANGED_UNIT_DA_ARTEMIS_CAMP_STRENGTH',			'Key',					'COMBAT_STRENGTH_FOR_RANGED_FROM_ARTEMIS');

insert or replace into ModifierStrings
(ModifierId,										Context,			Text)
values
	('RANGED_UNIT_DA_ARTEMIS_CAMP_STRENGTH',		'Preview',			'LOC_ABILITY_DA_ARTEMIS_CAMP_STRENGTH_PREVIEW');

--马丘比丘全山脉相邻
insert or replace into BuildingModifiers(BuildingType, ModifierId) select
	'BUILDING_MACHU_PICCHU', 'MACHU_PICCHU_'||DistrictType||'_'||TerrainType
	from DA_District_Yields, TerrainClass_Terrains where 
	DistrictType in ('DISTRICT_CAMPUS', 'DISTRICT_HOLY_SITE', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR')
	and TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';

insert or replace into Modifiers(ModifierId, ModifierType) select
	'MACHU_PICCHU_'||DistrictType||'_'||TerrainType, 'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY'
	from DA_District_Yields, TerrainClass_Terrains where 
	DistrictType in ('DISTRICT_CAMPUS', 'DISTRICT_HOLY_SITE', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR')
	and TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MACHU_PICCHU_'||DistrictType||'_'||TerrainType, 'Amount', 1
	from DA_District_Yields, TerrainClass_Terrains where 
	DistrictType in ('DISTRICT_CAMPUS', 'DISTRICT_HOLY_SITE', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR')
	and TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MACHU_PICCHU_'||DistrictType||'_'||TerrainType, 'DistrictType', DistrictType
	from DA_District_Yields, TerrainClass_Terrains where 
	DistrictType in ('DISTRICT_CAMPUS', 'DISTRICT_HOLY_SITE', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR')
	and TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MACHU_PICCHU_'||DistrictType||'_'||TerrainType, 'TerrainType', TerrainType
	from DA_District_Yields, TerrainClass_Terrains where 
	DistrictType in ('DISTRICT_CAMPUS', 'DISTRICT_HOLY_SITE', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR')
	and TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MACHU_PICCHU_'||DistrictType||'_'||TerrainType, 'YieldType', YieldType
	from DA_District_Yields, TerrainClass_Terrains where 
	DistrictType in ('DISTRICT_CAMPUS', 'DISTRICT_HOLY_SITE', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR')
	and TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MACHU_PICCHU_'||DistrictType||'_'||TerrainType, 'Description', 'LOC_BUILDING_MACHU_PICCHU_'||YieldType||'_ADJACENCY'
	from DA_District_Yields, TerrainClass_Terrains where 
	DistrictType in ('DISTRICT_CAMPUS', 'DISTRICT_HOLY_SITE', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR')
	and TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';



--博尔戈尔山 沙漠相邻
delete from BuildingModifiers where BuildingType = 'BUILDING_JEBEL_BARKAL';
insert or replace into BuildingModifiers(BuildingType, ModifierId) select
	'BUILDING_JEBEL_BARKAL', 'JEBEL_BARKAL_ADJACENCY_'||DistrictType||'_'||TerrainType
	from Districts, TerrainClass_Terrains where 
	RequiresPopulation = 1 and TraitType is not null
	and TerrainClassType = 'TERRAIN_CLASS_DESERT';

insert or replace into Modifiers(ModifierId, ModifierType) select
	'JEBEL_BARKAL_ADJACENCY_'||DistrictType||'_'||TerrainType, 'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY'
	from Districts, TerrainClass_Terrains where 
	RequiresPopulation = 1 and TraitType is not null
	and TerrainClassType = 'TERRAIN_CLASS_DESERT';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'JEBEL_BARKAL_ADJACENCY_'||DistrictType||'_'||TerrainType, 'Amount', '1'
	from Districts, TerrainClass_Terrains where 
	RequiresPopulation = 1 and TraitType is not null
	and TerrainClassType = 'TERRAIN_CLASS_DESERT';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'JEBEL_BARKAL_ADJACENCY_'||DistrictType||'_'||TerrainType, 'DistrictType', DistrictType
	from Districts, TerrainClass_Terrains where 
	RequiresPopulation = 1 and TraitType is not null
	and TerrainClassType = 'TERRAIN_CLASS_DESERT';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'JEBEL_BARKAL_ADJACENCY_'||DistrictType||'_'||TerrainType, 'TerrainType', TerrainType
	from Districts, TerrainClass_Terrains where 
	RequiresPopulation = 1 and TraitType is not null
	and TerrainClassType = 'TERRAIN_CLASS_DESERT';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'JEBEL_BARKAL_ADJACENCY_'||DistrictType||'_'||TerrainType, 'YieldType', 'YIELD_FAITH'
	from Districts, TerrainClass_Terrains where 
	RequiresPopulation = 1 and TraitType is not null
	and TerrainClassType = 'TERRAIN_CLASS_DESERT';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'JEBEL_BARKAL_ADJACENCY_'||DistrictType||'_'||TerrainType, 'Description', 'LOC_BUILDING_JEBEL_BARKAL_ADJACENCY'
	from Districts, TerrainClass_Terrains where 
	RequiresPopulation = 1 and TraitType is not null
	and TerrainClassType = 'TERRAIN_CLASS_DESERT';

--佩特拉古城 
delete from BuildingModifiers where BuildingType = 'BUILDING_PETRA';
insert or replace into BuildingModifiers(BuildingType, ModifierId) values
	('BUILDING_PETRA', 'PETRA_DISTRICT_FOOD_DESERT'),
	('BUILDING_PETRA', 'PETRA_DISTRICT_FOOD_DESERT_HILLS');

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('PETRA_DISTRICT_FOOD_DESERT', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'RS_NOT_WONDER_ON_TERRAIN_DESERT'),
	('PETRA_DISTRICT_FOOD_DESERT_HILLS', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'RS_NOT_WONDER_ON_TERRAIN_DESERT_HILLS');


insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('PETRA_DISTRICT_FOOD_DESERT', 'YieldType', 'YIELD_FOOD'),
	('PETRA_DISTRICT_FOOD_DESERT', 'Amount', '1'),
	('PETRA_DISTRICT_FOOD_DESERT_HILLS', 'YieldType', 'YIELD_FOOD'),
	('PETRA_DISTRICT_FOOD_DESERT_HILLS', 'Amount', '1');

insert or replace into BuildingModifiers(BuildingType, ModifierId) select
	'BUILDING_PETRA', 'PETRA_TRADE_ORIGINAL_'||DistrictType
	from DA_District_Yields;

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'PETRA_TRADE_ORIGINAL_'||DistrictType, 'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'RS_PLOT_HAS_'||DistrictType
	from DA_District_Yields;

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) select
	'PETRA_TRADE_ORIGINAL_'||DistrictType||'_MODIFIER', 'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC', 'RS_PLOT_IS_TERRAIN_CLASS_DESERT'
	from DA_District_Yields;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PETRA_TRADE_ORIGINAL_'||DistrictType, 'ModifierId', 'PETRA_TRADE_ORIGINAL_'||DistrictType||'_MODIFIER'
	from DA_District_Yields;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PETRA_TRADE_ORIGINAL_'||DistrictType||'_MODIFIER', 'YieldType', YieldType
	from DA_District_Yields;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PETRA_TRADE_ORIGINAL_'||DistrictType||'_MODIFIER', 'Amount', Amount
	from DA_District_Yields;

----------------
insert or replace into BuildingModifiers(BuildingType, ModifierId) select
	'BUILDING_PETRA', 'PETRA_TRADE_TARGET_'||DistrictType
	from DA_District_Yields;

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'PETRA_TRADE_TARGET_'||DistrictType, 'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'RS_PLOT_HAS_'||DistrictType
	from DA_District_Yields;

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) select
	'PETRA_TRADE_TARGET_'||DistrictType||'_MODIFIER', 'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS', 'RS_PLOT_IS_TERRAIN_CLASS_DESERT'
	from DA_District_Yields;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PETRA_TRADE_TARGET_'||DistrictType, 'ModifierId', 'PETRA_TRADE_TARGET_'||DistrictType||'_MODIFIER'
	from DA_District_Yields;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PETRA_TRADE_TARGET_'||DistrictType||'_MODIFIER', 'YieldType', YieldType
	from DA_District_Yields;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PETRA_TRADE_TARGET_'||DistrictType||'_MODIFIER', 'Amount', Amount
	from DA_District_Yields;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PETRA_TRADE_TARGET_'||DistrictType||'_MODIFIER', 'Domestic', 1
	from DA_District_Yields;

--罗马斗兽场
delete from BuildingModifiers where BuildingType = 'BUILDING_COLOSSEUM';
insert or replace into BuildingModifiers(BuildingType, ModifierId) values
    ('BUILDING_COLOSSEUM',              'ARENA_GIFT_CIRCUS'),
    ('BUILDING_COLOSSEUM',              'ARENA_GIFT_OLYMPIC'),
    ('BUILDING_COLOSSEUM',              'ARENA_GIFT_WRESTLE'),

    ('BUILDING_COLOSSEUM',              'NO_CAP_RESOURCE_CIRCUS'),
    ('BUILDING_COLOSSEUM',              'NO_CAP_RESOURCE_OLYMPIC'),
    ('BUILDING_COLOSSEUM',              'NO_CAP_RESOURCE_WRESTLE');


--兵马俑 --宙斯像
delete from BuildingModifiers where ModifierId = 'TERRACOTTA_ARMY_ARCHAEOLOGIST_OPEN_BORDERS';
delete from BuildingModifiers where BuildingType = 'BUILDING_STATUE_OF_ZEUS';
insert or replace into BuildingModifiers(BuildingType, ModifierId) values
	('BUILDING_STATUE_OF_ZEUS',		'STATUE_OF_ZEUS_GRANT_SCOUT'),
	('BUILDING_STATUE_OF_ZEUS',		'STATUE_OF_ZEUS_GRANT_MELEE'),
	('BUILDING_STATUE_OF_ZEUS',		'STATUE_OF_ZEUS_GRANT_RANGED'),
	('BUILDING_STATUE_OF_ZEUS',		'STATUE_OF_ZEUS_GRANT_SIEGE'),
	('BUILDING_STATUE_OF_ZEUS',		'STATUE_OF_ZEUS_GRANT_ANTI_CAVALRY'),
	('BUILDING_STATUE_OF_ZEUS',		'STATUE_OF_ZEUS_GRANT_LIGHT_CAVALRY'),
	('BUILDING_STATUE_OF_ZEUS',		'STATUE_OF_ZEUS_GRANT_HEAVY_CAVALRY');

insert or replace into Modifiers(ModifierId, ModifierType) values
	('TERRACOTTA_ARMY_ADD_CULTURE',				'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD'),
	('STATUE_OF_ZEUS_ADD_SCIENCE',				'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD'),
	('STATUE_OF_ZEUS_GRANT_SCOUT',				'MODIFIER_SINGLE_CITY_GRANT_UNIT_BY_CLASS'),
	('STATUE_OF_ZEUS_GRANT_MELEE',				'MODIFIER_SINGLE_CITY_GRANT_UNIT_BY_CLASS'),
	('STATUE_OF_ZEUS_GRANT_RANGED',				'MODIFIER_SINGLE_CITY_GRANT_UNIT_BY_CLASS'),
	('STATUE_OF_ZEUS_GRANT_SIEGE',				'MODIFIER_SINGLE_CITY_GRANT_UNIT_BY_CLASS'),
	('STATUE_OF_ZEUS_GRANT_ANTI_CAVALRY',		'MODIFIER_SINGLE_CITY_GRANT_UNIT_BY_CLASS'),
	('STATUE_OF_ZEUS_GRANT_LIGHT_CAVALRY',		'MODIFIER_SINGLE_CITY_GRANT_UNIT_BY_CLASS'),
	('STATUE_OF_ZEUS_GRANT_HEAVY_CAVALRY',		'MODIFIER_SINGLE_CITY_GRANT_UNIT_BY_CLASS');


insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('TERRACOTTA_ARMY_ADD_CULTURE',		'BuildingType',		'BUILDING_TERRACOTTA_ARMY'),
	('TERRACOTTA_ARMY_ADD_CULTURE',		'YieldType',		'YIELD_CULTURE'),
	('TERRACOTTA_ARMY_ADD_CULTURE',		'Amount',			'1'),
	('STATUE_OF_ZEUS_ADD_SCIENCE',		'BuildingType',		'BUILDING_STATUE_OF_ZEUS'),
	('STATUE_OF_ZEUS_ADD_SCIENCE',		'YieldType',		'YIELD_SCIENCE'),
	('STATUE_OF_ZEUS_ADD_SCIENCE',		'Amount',			'1'),
	('STATUE_OF_ZEUS_GRANT_SCOUT',		'UnitPromotionClassType',			'PROMOTION_CLASS_RECON'),
	('STATUE_OF_ZEUS_GRANT_MELEE',		'UnitPromotionClassType',			'PROMOTION_CLASS_MELEE'),
	('STATUE_OF_ZEUS_GRANT_RANGED',		'UnitPromotionClassType',			'PROMOTION_CLASS_RANGED'),
	('STATUE_OF_ZEUS_GRANT_SIEGE',		'UnitPromotionClassType',			'PROMOTION_CLASS_SIEGE'),
	('STATUE_OF_ZEUS_GRANT_ANTI_CAVALRY',		'UnitPromotionClassType',			'PROMOTION_CLASS_ANTI_CAVALRY'),
	('STATUE_OF_ZEUS_GRANT_LIGHT_CAVALRY',		'UnitPromotionClassType',			'PROMOTION_CLASS_LIGHT_CAVALRY'),
	('STATUE_OF_ZEUS_GRANT_HEAVY_CAVALRY',		'UnitPromotionClassType',			'PROMOTION_CLASS_HEAVY_CAVALRY');
