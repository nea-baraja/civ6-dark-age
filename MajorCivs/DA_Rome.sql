--图拉真圆柱
delete from TraitModifiers where TraitType = 'TRAJANS_COLUMN_TRAIT' and ModifierId = 'TRAIT_ADJUST_NON_CAPITAL_FREE_CHEAPEST_BUILDING';

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAJANS_COLUMN_TRAIT',			'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType
	from Buildings;

insert or replace into Modifiers(ModifierId,		ModifierType,		SubjectRequirementSetId) select
	'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType,		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION',	'RS_PLAYER_HAS_'||BuildingType
	from Buildings;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType,	'BuildingType',		BuildingType
	from Buildings;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType,	'Amount',		25
	from Buildings;	

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType,	'Amount',		100
	from Buildings where PrereqDistrict = 'DISTRICT_CITY_CENTER';	

--条条大路通罗马
insert or replace into TraitModifiers(TraitType,	ModifierId) values
	('TRAIT_CIVILIZATION_ALL_ROADS_TO_ROME',		'ROME_UNITS_MOVEMENT_IN_CITY_CENTER'),
	('TRAIT_CIVILIZATION_ALL_ROADS_TO_ROME',		'ROME_UNITS_MOVEMENT_IN_ROME');

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) values
	('ROME_UNITS_MOVEMENT_IN_CITY_CENTER',			'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	null),
	('ROME_UNITS_MOVEMENT_IN_ROME',					'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_CITY_HAS_BUILDING_PALACE'),
	('ROME_UNITS_MOVEMENT_IN_CITY_CENTER_MOD',		'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',	'RS_OBJECT_SAME_PLOT'),
	('ROME_UNITS_MOVEMENT_IN_ROME_MOD',				'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',	'RS_OBJECT_SAME_PLOT');

insert or replace into ModifierArguments(ModifierId,	Name,	Value) values
	('ROME_UNITS_MOVEMENT_IN_CITY_CENTER',			'ModifierId',			'ROME_UNITS_MOVEMENT_IN_CITY_CENTER_MOD'),
	('ROME_UNITS_MOVEMENT_IN_ROME',					'ModifierId',			'ROME_UNITS_MOVEMENT_IN_ROME_MOD'),
	('ROME_UNITS_MOVEMENT_IN_CITY_CENTER_MOD',		'Amount',				2),
	('ROME_UNITS_MOVEMENT_IN_ROME_MOD',				'Amount',				2);

--浴场宜居度
update ModifierArguments set Value = 3 where ModifierId = 'BATH_ADDAMENITIES' and Name = 'Amount';

-- insert into CivicModifiers(CivicType, ModifierId) values
-- 	('CIVIC_GAMES_RECREATION',		'UNLOCK_BATH');

-- insert into Modifiers(ModifierId, ModifierType) values
-- 	('UNLOCK_BATH', 'MODIFIER_PLAYER_ADJUST_DISTRICT_UNLOCK');

-- insert into ModifierArguments(ModifierId, Name, Value) values
-- 	('UNLOCK_BATH', 'CivicType', 'CIVIC_GAMES_RECREATION');





------------------------------------------------------------------------------------
--凯撒
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_CAESAR' and ModifierId like 'BARBARIAN_CAMP_GOLD%';
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_CAESAR' and ModifierId like 'TRAIT_CAESAR_%';

--TRAIT_LEADER_CONQUER_GAUL--征服高卢
--TRAIT_LEADER_CAESAR--凯撒

--征服高卢
insert or replace into Types(Type,	Kind) values
	('TRAIT_LEADER_A_CONQUER_GAUL',	'KIND_TRAIT'),
	('DA_ABILTY_CONQUER_GAUL',	'KIND_ABILITY');
	
insert or replace into LeaderTraits(LeaderType,	TraitType) select
	'LEADER_JULIUS_CAESAR',	'TRAIT_LEADER_A_CONQUER_GAUL'
	where exists (select * from Leaders where LeaderType = 'LEADER_JULIUS_CAESAR');
	
insert or replace into Traits(TraitType,	Name,	Description) values
	('TRAIT_LEADER_A_CONQUER_GAUL',	'LOC_TRAIT_LEADER_CONQUER_GAUL_NAME',	'LOC_TRAIT_LEADER_CONQUER_GAUL_DESCRIPTION');
	
insert or replace into TypeTags(Type,	Tag) values
	('DA_ABILTY_CONQUER_GAUL',	'CLASS_MELEE'),
	('DA_ABILTY_CONQUER_GAUL',	'CLASS_ANTI_CAVALRY'),
	('DA_ABILTY_CONQUER_GAUL',	'CLASS_LIGHT_CAVALRY'),
	('DA_ABILTY_CONQUER_GAUL',	'CLASS_HEAVY_CAVALRY'),
	('DA_ABILTY_CONQUER_GAUL',	'CLASS_NAVAL_MELEE');
	
insert or replace into UnitAbilities(UnitAbilityType, Name, Description,	Inactive) values
	('DA_ABILTY_CONQUER_GAUL',	'LOC_DA_ABILTY_CONQUER_GAUL_NAME',	'LOC_DA_ABILTY_CONQUER_GAUL_DESCRIPTION',	1);

insert or replace into UnitAbilityModifiers(UnitAbilityType,	ModifierId) values
	('DA_ABILTY_CONQUER_GAUL',	'DA_ABILTY_MODIFIER_CONQUER_GAUL');

insert or replace into TraitModifiers(TraitType,	ModifierId) values
	('TRAIT_LEADER_A_CONQUER_GAUL',	'DA_TRAIT_LEADER_MODIFIER_CONQUER_GAUL');
	
insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) values
	('DA_TRAIT_LEADER_MODIFIER_CONQUER_GAUL',	'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',	null),
	('DA_ABILTY_MODIFIER_CONQUER_GAUL',	'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',	'RS_UNIT_STRENGTH_HIGHER');
	
insert or replace into ModifierArguments(ModifierId,	Name,	Value) values
	('DA_TRAIT_LEADER_MODIFIER_CONQUER_GAUL',	'AbilityType','DA_ABILTY_CONQUER_GAUL'),
	('DA_ABILTY_MODIFIER_CONQUER_GAUL',	'Amount',	5);
	
insert or replace into ModifierStrings
	(ModifierId,										Context,	Text)
values
	('DA_ABILTY_MODIFIER_CONQUER_GAUL',					'Preview',	'+{1_Amount} {LOC_ABILTY_MODIFIER_CONQUER_GAUL_PREVIEW_TEXT}');

insert or replace into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId) values
    ('RS_UNIT_STRENGTH_HIGHER',	'REQ_UNIT_STRENGTH_HIGHER');
    
insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType) values
    ('RS_UNIT_STRENGTH_HIGHER',	'REQUIREMENTSET_TEST_ALL');
    
insert or replace into Requirements (RequirementId, RequirementType,	Inverse) values
	('REQ_UNIT_STRENGTH_HIGHER',	'REQUIREMENT_OPPONENT_IS_STRONGER',1);
	
--凯撒
insert or replace into TraitModifiers(TraitType,	ModifierId) 
select	'TRAIT_LEADER_CAESAR',	'DA_CAESAR_'||ModifierId
from GovernmentModifiers where exists (select * from Traits where TraitType = 'TRAIT_LEADER_CAESAR');

insert or ignore into Modifiers(ModifierId,  	ModifierType, 		SubjectRequirementSetId) 
select	'DA_CAESAR_'||ModifierId,	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'DA_CAESAR_RS_'||GovernmentType
from GovernmentModifiers;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
select 'DA_CAESAR_'||ModifierId,	'ModifierId',	ModifierId
from GovernmentModifiers;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'DA_CAESAR_RS_'||GovernmentType,					'REQUIREMENTSET_TEST_ALL'
from GovernmentModifiers;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'DA_CAESAR_RS_'||GovernmentType,				'DA_CAESAR_REQ_'||GovernmentType  
from GovernmentModifiers;

insert or ignore into Requirements (RequirementId, RequirementType)
select 'DA_CAESAR_REQ_'||GovernmentType, 'REQUIREMENT_PLOT_PROPERTY_MATCHES'
from GovernmentModifiers;

insert or ignore into RequirementArguments (RequirementId, Name, Value)
select 'DA_CAESAR_REQ_'||GovernmentType, 'PropertyName', 'DA_CAESAR_PROPERTY_'||GovernmentType
from GovernmentModifiers;

insert or ignore into RequirementArguments (RequirementId, Name, Value)
select 'DA_CAESAR_REQ_'||GovernmentType, 'PropertyMinimum', 1
from GovernmentModifiers;


