
create table "DA_Boosts" (
	'id' INTEGER AUTO_INCREMENT ,
	'ItemType' VARCHAR ,
	'Text' VARCHAR(50) ,
	'ModifierValue' FLOAT(3),
	PRIMARY KEY(ItemType)
);
insert into DA_Boosts(ItemType,Text,ModifierValue) values

	("TECH_IRRIGATION","LOC_DA_BOOST_TECH_IRRIGATION","0.5"),
	("TECH_ARCHERY","LOC_DA_BOOST_TECH_ARCHERY","0.5"),
	("TECH_BRONZE_WORKING","LOC_DA_BOOST_TECH_BRONZE_WORKING","1"),
	("TECH_MASONRY","LOC_DA_BOOST_TECH_MASONRY","1"),
	("TECH_WRITING","LOC_DA_BOOST_TECH_WRITING","0.5"),
	("TECH_ASTROLOGY","LOC_DA_BOOST_TECH_ASTROLOGY","1"),
	("TECH_SAILING","LOC_DA_BOOST_TECH_SAILING","1"),
	("TECH_THE_WHEEL","LOC_DA_BOOST_TECH_THE_WHEEL","0.1"),

	("TECH_SHIPBUILDING","LOC_DA_BOOST_TECH_SHIPBUILDING","0.5"),
	("TECH_PAPER_MAKING_DA","LOC_DA_BOOST_TECH_PAPER_MAKING_DA","0.5"),
	("TECH_ENGINEERING","LOC_DA_BOOST_TECH_ENGINEERING","0.3"),
	("TECH_CONSTRUCTION","LOC_DA_BOOST_TECH_CONSTRUCTION","0.25"),
	("TECH_CURRENCY","LOC_DA_BOOST_TECH_CURRENCY","0.03"),
	("TECH_IRON_WORKING","LOC_DA_BOOST_TECH_IRON_WORKING","1"),
	("TECH_HORSEBACK_RIDING","LOC_DA_BOOST_TECH_HORSEBACK_RIDING","1"),
	("TECH_CELESTIAL_NAVIGATION","LOC_DA_BOOST_TECH_CELESTIAL_NAVIGATION","0.01"),
	("TECH_MATHEMATICS","LOC_DA_BOOST_TECH_MATHEMATICS","0.05");


	
-- create table "DA_Boost_Civic" (
-- 	'id' INTEGER AUTO_INCREMENT , 
-- 	'CivicType' VARCHAR ,
-- 	'Text' VARCHAR(50) ,
-- 	'ModifierValue' FLOAT(3) ,
-- 	PRIMARY KEY(CivicType)
-- );
insert into DA_Boosts(ItemType,Text,ModifierValue) values
	("CIVIC_MYSTICISM","LOC_DA_BOOST_CIVIC_MYSTICISM","0.02"),	
	("CIVIC_FOREIGN_TRADE","LOC_DA_BOOST_CIVIC_FOREIGN_TRADE","0.5"),
	("CIVIC_MILITARY_TRADITION","LOC_DA_BOOST_CIVIC_MILITARY_TRADITION","0.25"),	
	("CIVIC_STATE_WORKFORCE","LOC_DA_BOOST_CIVIC_STATE_WORKFORCE","0.5"),
	("CIVIC_EARLY_EMPIRE","LOC_DA_BOOST_CIVIC_EARLY_EMPIRE","0.1"),	
	("CIVIC_CRAFTSMANSHIP",	"LOC_DA_BOOST_CIVIC_CRAFTSMANSHIP","0.25"),

	("CIVIC_POLITICAL_PHILOSOPHY",	"LOC_DA_CIVIC_POLITICAL_PHILOSOPHY","0.25"),
	("CIVIC_DRAMA_POETRY",	"LOC_DA_BOOST_CIVIC_DRAMA_POETRY","1"),
	("CIVIC_GAMES_RECREATION",	"LOC_DA_BOOST_CIVIC_GAMES_RECREATION","0.2"),
	("CIVIC_THEOLOGY",	"LOC_DA_BOOST_CIVIC_THEOLOGY","0.04"),
	("CIVIC_MILITARY_TRAINING",	"LOC_DA_BOOST_CIVIC_MILITARY_TRAINING","0.2"),
	("CIVIC_DEFENSIVE_TACTICS",	"LOC_DA_BOOST_CIVIC_DEFENSIVE_TACTICS","0.3"),
	("CIVIC_RECORDED_HISTORY",	"LOC_DA_BOOST_CIVIC_RECORDED_HISTORY","0.25");

update Boosts set Boost = 0 where exists(select * from DA_Boosts where Boosts.TechnologyType = DA_Boosts.ItemType or Boosts.CivicType = DA_Boosts.ItemType);
update Boosts set BoostClass = "BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH" where exists(select * from DA_Boosts where Boosts.TechnologyType = DA_Boosts.ItemType or Boosts.CivicType = DA_Boosts.ItemType);


--常规改良计数
insert or replace into Modifiers(ModifierId, ModifierType) select
	'DA_'||ImprovementType||'_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY'
	from Improvements;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_'||ImprovementType||'_COUNT',			'Amount',		1
	from Improvements;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_'||ImprovementType||'_COUNT',			'Key',			ImprovementType||'_COUNT'
	from Improvements;

insert or replace into ImprovementModifiers(ImprovementType, ModifierId) select
	ImprovementType,	'DA_'||ImprovementType||'_COUNT'
	from Improvements;

--常规区域计数
insert or replace into Modifiers(ModifierId, ModifierType) select
	'DA_'||DistrictType||'_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY'
	from Districts;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_'||DistrictType||'_COUNT',			'Amount',		1
	from Districts;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_'||DistrictType||'_COUNT',			'Key',			DistrictType||'_COUNT'
	from Districts;

insert or replace into DistrictModifiers(DistrictType, ModifierId) select
	DistrictType,	'DA_'||DistrictType||'_COUNT'
	from Districts;

--专业区域计数
insert or replace into Modifiers(ModifierId, ModifierType) values
	('DA_SP_DISTRICT_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_SP_DISTRICT_COUNT',			'Amount',		1);

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_SP_DISTRICT_COUNT',			'Key',			'SP_DISTRICT_COUNT');

insert or replace into DistrictModifiers(DistrictType, ModifierId) select
	DistrictType,	'DA_SP_DISTRICT_COUNT'
	from Districts where RequiresPopulation = 1;

--专业区域种类计数  --Unused
insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'DA_HAS_'||DistrictType||'_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY', 	'RS_PLAYER_HAS_'||DistrictType
	from Districts where RequiresPopulation = 1;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_HAS_'||DistrictType||'_COUNT',			'Amount',		1
	from Districts where RequiresPopulation = 1;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_HAS_'||DistrictType||'_COUNT',			'Key',			DistrictType||'_COUNT'
	from Districts where RequiresPopulation = 1;

insert or replace into DistrictModifiers(DistrictType, ModifierId) select
	DistrictType,	'DA_HAS_'||DistrictType||'_COUNT'
	from Districts where RequiresPopulation = 1;




--沿海改良计数 沿海区域计数
insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('DA_BY_SEA_IMPROVEMENT_COUNT_ATTACH',		'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER', 'RS_PLOT_ADJACENT_TERRAIN_COAST'),
	('DA_BY_SEA_DISTRICT_COUNT_ATTACH',			'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 	'RS_NEAR_WATER_DISTRICT'),
	('DA_BY_SEA_DIS_OR_IMP_COUNT',				'MODIFIER_PLAYER_ADJUST_PROPERTY', 				NULL);

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_BY_SEA_IMPROVEMENT_COUNT_ATTACH',		'ModifierId', 		'DA_BY_SEA_DIS_OR_IMP_COUNT'),
	('DA_BY_SEA_DISTRICT_COUNT_ATTACH',			'ModifierId', 		'DA_BY_SEA_DIS_OR_IMP_COUNT'),
	('DA_BY_SEA_DIS_OR_IMP_COUNT',				'Key', 				'BY_SEA_DIS_OR_IMP_COUNT'),
	('DA_BY_SEA_DIS_OR_IMP_COUNT',				'Amount', 			1);

insert or replace into TraitModifiers(TraitType, ModifierId) values
	('TRAIT_LEADER_MAJOR_CIV',		'DA_BY_SEA_IMPROVEMENT_COUNT_ATTACH'),
	('TRAIT_LEADER_MAJOR_CIV',		'DA_BY_SEA_DISTRICT_COUNT_ATTACH');


--总改良计数
insert or replace into Modifiers(ModifierId, ModifierType) values
	('DA_ALL_IMPROVEMENT_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_ALL_IMPROVEMENT_COUNT',			'Amount',		1);

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_ALL_IMPROVEMENT_COUNT',			'Key',			'ALL_IMPROVEMENT_COUNT');

insert or replace into ImprovementModifiers(ImprovementType, ModifierId) select
	ImprovementType,	'DA_ALL_IMPROVEMENT_COUNT'
	from Improvements;


--改良的马计数
insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('DA_IMPROVED_HORSE_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY',	'RS_PLOT_HAS_RESOURCE_HORSES');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_IMPROVED_HORSE_COUNT',			'Amount',		1);

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_IMPROVED_HORSE_COUNT',			'Key',			'IMPROVED_HORSE_COUNT');

insert or replace into ImprovementModifiers(ImprovementType, ModifierId) values
	('IMPROVEMENT_PASTURE',			'DA_IMPROVED_HORSE_COUNT');


--改良的铁计数
insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('DA_IMPROVED_IRON_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY',	'RS_PLOT_HAS_RESOURCE_IRON');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_IMPROVED_IRON_COUNT',			'Amount',		1);

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_IMPROVED_IRON_COUNT',			'Key',			'IMPROVED_IRON_COUNT');

insert or replace into ImprovementModifiers(ImprovementType, ModifierId) values
	('IMPROVEMENT_MINE',			'DA_IMPROVED_IRON_COUNT');

--改良资源的渔场计数
insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('DA_FISHERY_WITH_RESOURCE_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY',	'RS_PLOT_HAS_IMPROVED_RESOURCE');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_FISHERY_WITH_RESOURCE_COUNT',			'Amount',		1);

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_FISHERY_WITH_RESOURCE_COUNT',			'Key',			'FISHERY_WITH_RESOURCE_COUNT');

insert or replace into ImprovementModifiers(ImprovementType, ModifierId) values
	('IMPROVEMENT_FISHERY',			'DA_FISHERY_WITH_RESOURCE_COUNT');

--改良资源的农场计数
insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('DA_FARM_WITH_RESOURCE_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY',	'RS_PLOT_HAS_IMPROVED_RESOURCE');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_FARM_WITH_RESOURCE_COUNT',			'Amount',		1);

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_FARM_WITH_RESOURCE_COUNT',			'Key',			'FARM_WITH_RESOURCE_COUNT');

insert or replace into ImprovementModifiers(ImprovementType, ModifierId) values
	('IMPROVEMENT_FARM',			'DA_FARM_WITH_RESOURCE_COUNT');

--总人口计数
insert or replace into DistrictModifiers(DistrictType, ModifierId) select
	'DISTRICT_CITY_CENTER',		'DA_POP_'||numbers||'_COUNT'
	from counter where numbers > 0 and numbers < 41;

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'DA_POP_'||numbers||'_COUNT',		'MODIFIER_PLAYER_ADJUST_PROPERTY', 'RS_CITY_HAS_'||numbers||'_POPULATION'
	from counter where numbers > 0 and numbers < 41;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_POP_'||numbers||'_COUNT',	'Amount',		1
	from counter where numbers > 0 and numbers < 41;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_POP_'||numbers||'_COUNT',	'Key',		'ALL_POP_COUNT'
	from counter where numbers > 0 and numbers < 41;





--建筑计数
insert or replace into Modifiers(ModifierId, ModifierType) select
	'DA_'||BuildingType||'_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY'
	from Buildings;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_'||BuildingType||'_COUNT',			'Amount',		1
	from Buildings;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_'||BuildingType||'_COUNT',			'Key',			BuildingType||'_COUNT'
	from Buildings;

insert or replace into BuildingModifiers(BuildingType, ModifierId) select
	BuildingType,	'DA_'||BuildingType||'_COUNT'
	from Buildings;

--奇观计数
insert or replace into Modifiers(ModifierId, ModifierType) values
	('DA_ALL_WONDER_COUNT', 'MODIFIER_PLAYER_ADJUST_PROPERTY');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_ALL_WONDER_COUNT',			'Amount',		1);

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_ALL_WONDER_COUNT',			'Key',			'ALL_WONDER_COUNT');

insert or replace into BuildingModifiers(BuildingType, ModifierId) select
	BuildingType,	'DA_ALL_WONDER_COUNT'
	from Buildings where IsWonder = 1;


--陆海单位计数
insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('DA_LAND_COMBAT_COUNT', 		'MODIFIER_PLAYER_ADJUST_PROPERTY',				null),
	('DA_LAND_COMBAT_COUNT_ATTACH', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER',		'RS_IS_CLASS_LAND_COMBAT');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_LAND_COMBAT_COUNT',			'Amount',			1),
	('DA_LAND_COMBAT_COUNT_ATTACH',		'ModifierId',		'DA_LAND_COMBAT_COUNT'),
	('DA_LAND_COMBAT_COUNT',			'Key',				'LAND_COMBAT_COUNT');

insert or replace into TraitModifiers(TraitType, ModifierId) values
	('TRAIT_LEADER_MAJOR_CIV',		'DA_LAND_COMBAT_COUNT_ATTACH');


insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('DA_NAVAL_COUNT', 			'MODIFIER_PLAYER_ADJUST_PROPERTY',				null),
	('DA_NAVAL_COUNT_ATTACH', 	'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER',		'RS_IS_CLASS_NAVAL');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('DA_NAVAL_COUNT',			'Amount',			1),
	('DA_NAVAL_COUNT_ATTACH',	'ModifierId',		'DA_NAVAL_COUNT'),
	('DA_NAVAL_COUNT',			'Key',				'NAVAL_COUNT');

insert or replace into TraitModifiers(TraitType, ModifierId) values
	('TRAIT_LEADER_MAJOR_CIV',		'DA_NAVAL_COUNT_ATTACH');







-- select count(Value), Modifiers.ModifierId, Value, DynamicModifiers.EffectType from ModifierArguments, Modifiers, DynamicModifiers where Name = 'TerrainType' and ModifierArguments.ModifierId = Modifiers.ModifierId and Modifiers.ModifierType = DynamicModifiers.ModifierType;
-- select count(ModifierId) from Modifiers;
