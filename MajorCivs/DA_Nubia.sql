--删除ua的矿加产
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_TA_SETI' and ModifierId in ('TRAIT_BONUS_MINE_GOLD', 'TRAIT_LUXURY_MINE_GOLD', 'TRAIT_STRATEGIC_MINE_PRODUCTION');

update Improvement_YieldChanges set YieldChange = 6 where ImprovementType = 'IMPROVEMENT_PYRAMID' and YieldType = 'YIELD_FAITH';
update Improvement_YieldChanges set YieldChange = 0 where ImprovementType = 'IMPROVEMENT_PYRAMID' and YieldType = 'YIELD_FOOD';
update Improvements set SameAdjacentValid = 0 where ImprovementType = 'IMPROVEMENT_PYRAMID';

insert or replace into ImprovementModifiers(ImprovementType, ModifierId) values
	('IMPROVEMENT_PYRAMID',		'PYRAMID_COST_FLOODPLAINS_FOOD');

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('PYRAMID_COST_FLOODPLAINS_FOOD',		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'RS_IS_FEATURE_FLOODPLAINS');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('PYRAMID_COST_FLOODPLAINS_FOOD',		'YieldType',		'YIELD_FOOD'),
	('PYRAMID_COST_FLOODPLAINS_FOOD',		'Amount',			'-2');

delete from TraitModifiers where TraitType = 'TRAIT_LEADER_KANDAKE_OF_MEROE';

insert or replace into TraitModifiers(TraitType, ModifierId) select
	'TRAIT_LEADER_KANDAKE_OF_MEROE',		'PYRAMID_FASTER_'||BuildingType
	from Districts join Buildings on Districts.DistrictType = Buildings.PrereqDistrict
	 where Districts.DistrictType != 'DISTRICT_WONDER'
	 and BuildingType not in (select Building from BuildingPrereqs);


insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'PYRAMID_FASTER_'||BuildingType,	'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER',	'RS_PLOT_HAS_'||DistrictType
	from Districts join Buildings on Districts.DistrictType = Buildings.PrereqDistrict
	 where Districts.DistrictType != 'DISTRICT_WONDER'
	 and BuildingType not in (select Building from BuildingPrereqs);

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) select
	'PYRAMID_FASTER_'||BuildingType||'_MODIFIER',	'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION',	'RS_ADJACENT_IMPROVEMENT_PYRAMID'
	from Districts join Buildings on Districts.DistrictType = Buildings.PrereqDistrict
	 where Districts.DistrictType != 'DISTRICT_WONDER'
	 and BuildingType not in (select Building from BuildingPrereqs);

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PYRAMID_FASTER_'||BuildingType||'_MODIFIER',	'BuildingType',		BuildingType
	from Districts join Buildings on Districts.DistrictType = Buildings.PrereqDistrict
	 where Districts.DistrictType != 'DISTRICT_WONDER'
	 and BuildingType not in (select Building from BuildingPrereqs);

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PYRAMID_FASTER_'||BuildingType||'_MODIFIER',	'Amount',		100
	from Districts join Buildings on Districts.DistrictType = Buildings.PrereqDistrict
	 where Districts.DistrictType != 'DISTRICT_WONDER'
	 and BuildingType not in (select Building from BuildingPrereqs);

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'PYRAMID_FASTER_'||BuildingType, 'ModifierId', 'PYRAMID_FASTER_'||BuildingType||'_MODIFIER'
	from Districts join Buildings on Districts.DistrictType = Buildings.PrereqDistrict
	 where Districts.DistrictType != 'DISTRICT_WONDER'
	 and BuildingType not in (select Building from BuildingPrereqs);


insert or replace into TraitModifiers(TraitType, ModifierId) values
	('TRAIT_LEADER_MAJOR_CIV',			'PYRAMID_CULTURE_BOMB'),
	('TRAIT_LEADER_KANDAKE_OF_MEROE',	'FREE_PYRAMID_CHARGES'),
	('TRAIT_CIVILIZATION_TA_SETI',		'TA_SETI_EUREKA_ARCHERY'),
	('TRAIT_CIVILIZATION_TA_SETI',		'TA_SETI_EUREKA_MASONRY');

insert or replace into Modifiers(ModifierId, ModifierType) values
	('PYRAMID_CULTURE_BOMB',		'MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER'),
	('FREE_PYRAMID_CHARGES',		'MODIFIER_PLAYER_ADJUST_PROPERTY'),
	('TA_SETI_EUREKA_ARCHERY',		'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST'),
	('TA_SETI_EUREKA_MASONRY',		'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('PYRAMID_CULTURE_BOMB',		'CaptureOwnedTerritory',		'0'),
	('PYRAMID_CULTURE_BOMB',		'ImprovementType',				'IMPROVEMENT_PYRAMID'),
	('FREE_PYRAMID_CHARGES',		'Key',		'PROP_FREE_PYRAMID_CHARGES'),
	('FREE_PYRAMID_CHARGES',		'Amount',	1),
	('TA_SETI_EUREKA_ARCHERY',		'TechType',	'TECH_ARCHERY'),
	('TA_SETI_EUREKA_MASONRY',		'TechType',	'TECH_MASONRY');


insert or replace into PropertyRequirements(PropertyType, Threshold) values
	('PROP_FREE_PYRAMID_CHARGES',	1);



