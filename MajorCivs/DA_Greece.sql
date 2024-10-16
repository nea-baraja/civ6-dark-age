--戈尔戈，塞莫皮莱
delete from TraitModifiers where ModifierId = 'UNIQUE_LEADER_CULTURE_KILLS';
delete from TraitModifiers where ModifierId = 'UNIQUE_LEADER_CULTURE_KILLS_GRANT_ABILITY';

create table "effect_table" (
	'id' INTEGER AUTO_INCREMENT ,
	'effect' VARCHAR(50) ,
	PRIMARY KEY(id)
);

insert into effect_table(effect)values
	('ADJUST_LEVIED_UNIT_COMBAT'),
	('LEVIED_UNIT_GET_CULTURE_BY_KILL_UNIT');
	


insert or replace into TraitModifiers(TraitType,	ModifierId) 
select	'CULTURE_KILLS_TRAIT',	'DA_TRAIT_MODIFIER_'||effect||"_"||numbers
from effect_table,counter where numbers>=1 and numbers<=10;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId,	RunOnce,	Permanent) 
select	'DA_TRAIT_MODIFIER_'||effect||"_"||numbers,	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_'||numbers,	0,	0
from effect_table,counter where numbers>=1 and numbers<=10;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId,	RunOnce,	Permanent) 
select	'DA_MODIFIER_LEVIED_GRANT_'||effect||'_DA_ABILITY_'||numbers,	'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',	'UNIT_IS_LEVIED_REQUIREMENTS_XP2',	0,	0
from effect_table,counter where numbers>=1 and numbers<=10;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) 
select	'DA_TRAIT_MODIFIER_'||effect||"_"||numbers,	'ModifierId',	'DA_MODIFIER_LEVIED_GRANT_'||effect||'_DA_ABILITY_'||numbers
from effect_table,counter where numbers>=1 and numbers<=10;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) 
select	'DA_MODIFIER_LEVIED_GRANT_'||effect||'_DA_ABILITY_'||numbers,	'AbilityType',	'DA_ABILITY_'||effect||"_"||numbers
from effect_table,counter where numbers>=1 and numbers<=10;

insert or replace into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_'||numbers,				'REP_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_UP_'||numbers
from counter where numbers>=1 and numbers<=10;

insert or replace into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_'||numbers,				'REQUIREMENTID_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_DOWN_'||numbers
from counter where numbers>=1 and numbers<=10;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_'||numbers,	'REQUIREMENTSET_TEST_ALL'
from counter where numbers>=1 and numbers<=10;

insert or replace into Requirements (RequirementId, RequirementType,	Inverse)
select 'REP_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_UP_'||numbers, 'REQUIREMENT_PLOT_PROPERTY_MATCHES',	0
from counter where numbers>=1 and numbers<=10;

insert or replace into Requirements (RequirementId, RequirementType,	Inverse)
select 'REQUIREMENTID_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_DOWN_'||numbers, 'REQUIREMENT_PLOT_PROPERTY_MATCHES',	1
from counter where numbers>=1 and numbers<=10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REP_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_UP_'||numbers, 'PropertyName', 'MilitaryPolicySlotNum'
from counter where numbers>=1 and numbers<=10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQUIREMENTID_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_DOWN_'||numbers, 'PropertyName', 'MilitaryPolicySlotNum'
from counter where numbers>=1 and numbers<=10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REP_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_UP_'||numbers, 'PropertyMinimum', numbers
from counter where numbers>=1 and numbers<=10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQUIREMENTID_HAS_PROPERTY_MILITARYPOLICYSLOTNUM_DOWN_'||numbers, 'PropertyMinimum', numbers+1
from counter where numbers>=1 and numbers<=10;

insert or replace into Types(Type,	Kind) 
select	'DA_ABILITY_'||effect||"_"||numbers,	'KIND_ABILITY'
from effect_table,counter where numbers>=1 and numbers<=10;

insert or replace into TypeTags(Type,	Tag) 
select	'DA_ABILITY_'||effect||"_"||numbers,	'CLASS_MILITARY'
from effect_table,counter where numbers>=1 and numbers<=10;

insert or replace into UnitAbilities(UnitAbilityType, Name, Description, Inactive) 
select	'DA_ABILITY_'||effect||"_"||numbers,	'LOC_ABILITY_'||effect||"_"||numbers||'_NAME',	'LOC_ABILITY_'||effect||"_"||numbers||'_DESCRIPTION',	1
from effect_table,counter where numbers>=1 and numbers<=10;

insert or replace into UnitAbilityModifiers(UnitAbilityType,	ModifierId) 
select	'DA_ABILITY_'||effect||"_"||numbers,	'DA_ABILITY_MODIFIER_'||effect||"_"||numbers
from effect_table,counter where numbers>=1 and numbers<=10;


insert or replace into Modifiers (ModifierId, 				ModifierType, SubjectRequirementSetId, OwnerRequirementSetId,	SubjectStackLimit)
select 'DA_ABILITY_MODIFIER_ADJUST_LEVIED_UNIT_COMBAT_'||numbers, 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',	null, null, null
from counter where numbers>=1 and numbers<=10;

insert or replace into Modifiers (ModifierId, 				ModifierType, SubjectRequirementSetId, OwnerRequirementSetId,	SubjectStackLimit)
select 'DA_ABILITY_MODIFIER_LEVIED_UNIT_GET_CULTURE_BY_KILL_UNIT_'||numbers, 'MODIFIER_UNIT_ADJUST_POST_COMBAT_YIELD',	null, null, null
from counter where numbers>=1 and numbers<=10;

insert or replace into ModifierArguments (ModifierId,	Name,	Value)
select 'DA_ABILITY_MODIFIER_ADJUST_LEVIED_UNIT_COMBAT_'||numbers, 'Amount',	numbers*2
from counter where numbers>=1 and numbers<=10;

insert or replace into ModifierArguments (ModifierId,	Name,	Value)
select 'DA_ABILITY_MODIFIER_LEVIED_UNIT_GET_CULTURE_BY_KILL_UNIT_'||numbers, 'YieldType',	'YIELD_CULTURE'
from counter where numbers>=1 and numbers<=10;

insert or replace into ModifierArguments (ModifierId,	Name,	Value)
select 'DA_ABILITY_MODIFIER_LEVIED_UNIT_GET_CULTURE_BY_KILL_UNIT_'||numbers, 'PercentDefeatedStrength',	numbers*33
from counter where numbers>=1 and numbers<=10;

insert or replace into ModifierStrings(ModifierId,	Context,	Text) 
select	'DA_ABILITY_MODIFIER_ADJUST_LEVIED_UNIT_COMBAT_'||numbers,	'Preview',	'DA_ABILITY_MODIFIER_ADJUST_LEVIED_UNIT_COMBAT_'||numbers||'_DESCRIPTION'
from counter where numbers>=1 and numbers<=10;

create table "unit_class_table" (
	'id' INTEGER AUTO_INCREMENT ,
	'unit_promotion_class' VARCHAR(50) ,
	PRIMARY KEY(id)
);

insert into unit_class_table(unit_promotion_class)values
('ANTI_CAVALRY'),('MELEE'),('RANGED'),('LIGHT_CAVALRY'),('HEAVY_CAVALRY');

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId,	RunOnce,	Permanent) 
select	'DA_MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS_IN_CAPITAL_'||unit_promotion_class,	"MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS_IN_CAPITAL",	null,	1,	1
from unit_class_table;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) 
select	'DA_MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS_IN_CAPITAL_'||unit_promotion_class,	'UnitPromotionClassType',	'PROMOTION_CLASS_'||unit_promotion_class
from unit_class_table;


insert or replace into Types(Type,	Kind)values                                    
	('MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS_IN_CAPITAL',	'KIND_MODIFIER');
	
insert or replace into DynamicModifiers(ModifierType,	CollectionType,	EffectType)values
	('MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS_IN_CAPITAL',	'COLLECTION_PLAYER_CAPITAL_CITY',	"EFFECT_GRANT_UNIT_BY_CLASS");

-----------------------------------------------------------------
--伯利克里，提洛同盟

--大科学家-科技城邦
--大预言家-宗教城邦
--大商人-贸易城邦
--大作家，大艺术家，大音乐家-文化城邦
--大将军-军事城邦
--大工程师-工业城邦
delete from TraitModifiers where ModifierId = 'TRAIT_CULTURE_PER_CITY_STATE_TRIBUTARY';

create table "table_great_person_and_modifier" (
	'id' INTEGER AUTO_INCREMENT ,
	'great_person_type' VARCHAR(20) ,
	'minor_civ_number' INTEGER ,
	'minor_civ_type' VARCHAR(20),
	PRIMARY KEY(id)
);

insert into table_great_person_and_modifier(great_person_type, minor_civ_number, minor_civ_type) select 'GENERAL', numbers, 'MILITARISTIC' from counter where numbers>=1 and numbers<=20;
insert into table_great_person_and_modifier(great_person_type, minor_civ_number, minor_civ_type) select 'ENGINEER', numbers, 'INDUSTRIAL' from counter where numbers>=1 and numbers<=20;
insert into table_great_person_and_modifier(great_person_type, minor_civ_number, minor_civ_type) select 'MERCHANT', numbers, 'TRADE' from counter where numbers>=1 and numbers<=20;
insert into table_great_person_and_modifier(great_person_type, minor_civ_number, minor_civ_type) select 'PROPHET', numbers, 'RELIGIOUS' from counter where numbers>=1 and numbers<=20;
insert into table_great_person_and_modifier(great_person_type, minor_civ_number, minor_civ_type) select 'SCIENTIST', numbers, 'SCIENTIFIC' from counter where numbers>=1 and numbers<=20;
insert into table_great_person_and_modifier(great_person_type, minor_civ_number, minor_civ_type) select 'WRITER', numbers, 'CULTURAL' from counter where numbers>=1 and numbers<=20;
insert into table_great_person_and_modifier(great_person_type, minor_civ_number, minor_civ_type) select 'MUSICIAN', numbers, 'CULTURAL' from counter where numbers>=1 and numbers<=20;
insert into table_great_person_and_modifier(great_person_type, minor_civ_number, minor_civ_type) select 'ARTIST', numbers, 'CULTURAL' from counter where numbers>=1 and numbers<=20;

insert or replace into TraitModifiers(TraitType,	ModifierId) 
select	'TRAIT_LEADER_SURROUNDED_BY_GLORY',		'DA_TRAIT_ADD_GREAT_'||great_person_type||'_POINTS_'||minor_civ_number||'_BY_MINOR_CITY'
from table_great_person_and_modifier;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId) 
select	'DA_TRAIT_ADD_GREAT_'||great_person_type||'_POINTS_'||minor_civ_number||'_BY_MINOR_CITY',	'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS_PERCENT',	'DA_'||great_person_type||'_SUZERAIN_'||minor_civ_number||'_REQUIREMENTS'
from table_great_person_and_modifier;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) 
select	'DA_TRAIT_ADD_GREAT_'||great_person_type||'_POINTS_'||minor_civ_number||'_BY_MINOR_CITY',	'GreatPersonClassType',	'GREAT_PERSON_CLASS_'||great_person_type
from table_great_person_and_modifier;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) 
select	'DA_TRAIT_ADD_GREAT_'||great_person_type||'_POINTS_'||minor_civ_number||'_BY_MINOR_CITY',	'Amount',	25
from table_great_person_and_modifier;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'DA_'||great_person_type||'_SUZERAIN_'||minor_civ_number||'_REQUIREMENTS',				'REQUIREMENTSET_TEST_ALL'
from table_great_person_and_modifier;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'DA_'||great_person_type||'_SUZERAIN_'||minor_civ_number||'_REQUIREMENTS',				'DA_REQ_'||great_person_type||'_SUZERAIN_'||minor_civ_number
from table_great_person_and_modifier;

insert or replace into Requirements (RequirementId, RequirementType)
select 'DA_REQ_'||great_person_type||'_SUZERAIN_'||minor_civ_number, 'REQUIREMENT_PLAYER_IS_SUZERAIN_X_TYPE'
from table_great_person_and_modifier;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'DA_REQ_'||great_person_type||'_SUZERAIN_'||minor_civ_number, 'Amount', minor_civ_number
from table_great_person_and_modifier;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'DA_REQ_'||great_person_type||'_SUZERAIN_'||minor_civ_number, 'LeaderType', 'LEADER_MINOR_CIV_'||minor_civ_type
from table_great_person_and_modifier;

--伟人全入境
insert or replace into TraitModifiers(TraitType,	ModifierId)	values
	('TRAIT_LEADER_SURROUNDED_BY_GLORY','DA_TRAIT_MODIFIER_GREAT_PERSON_OPEN_BORDERS');
	
insert or replace into Types(Type,	Kind) values
	('DA_ABILITY_GREAT_PERSON_OPEN_BORDERS',	'KIND_ABILITY');
	
insert or replace into Tags(Tag,	Vocabulary) values
	('CLASS_GREAT_PERSON_DELIAN_LEAGUE',	'ABILITY_CLASS');	

insert or replace into TypeTags(Type,	Tag) values
	('DA_ABILITY_GREAT_PERSON_OPEN_BORDERS',	'CLASS_GREAT_PERSON_DELIAN_LEAGUE');

insert or replace into TypeTags(Type,	Tag) 
select	'UNIT_GREAT_'||great_person_type,		'CLASS_GREAT_PERSON_DELIAN_LEAGUE'
from table_great_person_and_modifier;
	
insert or replace into UnitAbilities(UnitAbilityType, Name, Description,	Inactive) values
	('DA_ABILITY_GREAT_PERSON_OPEN_BORDERS',	'LOC_DA_ABILITY_GREAT_PERSON_OPEN_BORDERS_NAME',	'LOC_DA_ABILITY_GREAT_PERSON_OPEN_BORDERS_DESCRIPTION',	1);

insert or replace into UnitAbilityModifiers(UnitAbilityType,	ModifierId) values
	('DA_ABILITY_GREAT_PERSON_OPEN_BORDERS',	'DA_ABILTY_MODIFIER_GREAT_PERSON_OPEN_BORDERS');
	
insert or replace into Modifiers(ModifierId,	ModifierType,	Permanent)	values
	('DA_TRAIT_MODIFIER_GREAT_PERSON_OPEN_BORDERS','MODIFIER_PLAYER_UNITS_GRANT_ABILITY',	1),
	('DA_ABILTY_MODIFIER_GREAT_PERSON_OPEN_BORDERS','MODIFIER_PLAYER_UNIT_ADJUST_ENTER_FOREIGN_LANDS',	null);

insert or replace into ModifierArguments(ModifierId,	Name,	Value)	values
	('DA_TRAIT_MODIFIER_GREAT_PERSON_OPEN_BORDERS','AbilityType',	'DA_ABILITY_GREAT_PERSON_OPEN_BORDERS'),
	('DA_ABILTY_MODIFIER_GREAT_PERSON_OPEN_BORDERS','Enter',	1);

--卫城 相邻加成 相邻加影响力
delete from District_Adjacencies where DistrictType = 'DISTRICT_ACROPOLIS';

insert or replace into District_Adjacencies
    (DistrictType,            YieldChangeId) values
    ('DISTRICT_ACROPOLIS',          'DA_THEATER_GOVERNMENT_CULTURE'),
    ('DISTRICT_ACROPOLIS',          'DA_ACROPOLIS_DISTRICT_CULTURE'),
    ('DISTRICT_ACROPOLIS',          'DA_THEATER_WONDER_CULTURE');


insert or replace into Adjacency_YieldChanges
    (ID,                      Description,                      YieldType,YieldChange,TilesRequired,OtherDistrictAdjacent)
  VALUES
    ('DA_ACROPOLIS_DISTRICT_CULTURE','LOC_DA_ACROPOLIS_DISTRICT_CULTURE_DESCRIPTION','YIELD_CULTURE','2','1','1');

delete from DistrictModifiers where ModifierId = 'CIVIC_AWARD_ONE_INFLUENCE_TOKEN';

insert or replace into TraitModifiers(TraitType, ModifierId) select
	'TRAIT_CIVILIZATION_DISTRICT_ACROPOLIS', 		'DA_DISTRICT_ACROPOLIS_INFLUENCE_FROM_ADJACENCY_'||numbers
	from counter where numbers > 0 and numbers < 16;

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'DA_DISTRICT_ACROPOLIS_INFLUENCE_FROM_ADJACENCY_'||numbers, 'MODIFIER_PLAYER_DISTRICTS_ADJUST_INFLUENCE_POINTS_PER_TURN', 'RS_IS_'||(numbers * 2)||'_ADJACENCY_DISTRICT_ACROPOLIS_FIX'
	from counter where numbers > 0 and numbers < 16;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'DA_DISTRICT_ACROPOLIS_INFLUENCE_FROM_ADJACENCY_'||numbers, 'Amount', 1	
	from counter where numbers > 0 and numbers < 16;

--卫城 丘陵上加速建筑建造 可以建在任何地形
delete from District_ValidTerrains where DistrictType = 'DISTRICT_ACROPOLIS';

insert or replace into TraitModifiers(TraitType, ModifierId) select
	'TRAIT_CIVILIZATION_DISTRICT_ACROPOLIS',		'ACROPOLIS_HILL_FASTER_'||BuildingType
	from Buildings where PrereqDistrict = 'DISTRICT_THEATER';

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'ACROPOLIS_HILL_FASTER_'||BuildingType,	'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER',	'RS_PLOT_HAS_DISTRICT_THEATER'
	from Buildings where PrereqDistrict = 'DISTRICT_THEATER';

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) select
	'ACROPOLIS_HILL_FASTER_'||BuildingType||'_MODIFIER',	'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION',	'RS_PLOT_IS_TERRAIN_CLASS_HILLS'
	from Buildings where PrereqDistrict = 'DISTRICT_THEATER';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'ACROPOLIS_HILL_FASTER_'||BuildingType||'_MODIFIER',	'BuildingType',		BuildingType
	from Buildings where PrereqDistrict = 'DISTRICT_THEATER';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'ACROPOLIS_HILL_FASTER_'||BuildingType||'_MODIFIER',	'Amount',		50
	from Buildings where PrereqDistrict = 'DISTRICT_THEATER';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'ACROPOLIS_HILL_FASTER_'||BuildingType, 'ModifierId', 'ACROPOLIS_HILL_FASTER_'||BuildingType||'_MODIFIER'
	from Buildings where PrereqDistrict = 'DISTRICT_THEATER';

--理想国 加前置需求
update Modifiers set SubjectRequirementSetId = 'RS_PLAYER_HAS_CIVIC_POLITICAL_PHILOSOPHY' where ModifierId = 'TRAIT_WILDCARD_GOVERNMENT_SLOT';


