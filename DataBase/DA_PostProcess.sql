

--城市守护女神  区域相邻信仰

-- insert or replace into BeliefModifiers 	(BeliefType,	ModifierID)
-- 	select 'BELIEF_CITY_PATRON_GODDESS',	'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH'
-- 	from Districts, ConfigValues where ConfigId = 'CONFIG_BELIEF' and ConfigVal = 1;

-- insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
-- 	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',	'PLAYER_HAS_PANTHEON_REQUIREMENTS'
-- 	from Districts;

-- insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
-- 	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'MODIFIER_PLAYER_CITIES_DISTRICT_ADJACENCY',	NULL
-- 	from Districts;

-- insert or replace into ModifierArguments(ModifierId,	Name,	Value)
-- 	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH',	'ModifierId',	'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD'
-- 	from Districts;

-- insert or replace into ModifierArguments(ModifierId,	Name,	Value)
-- 	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'Amount',	1
-- 	from Districts;

-- insert or replace into ModifierArguments(ModifierId,	Name,	Value)
-- 	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'DistrictType',	DistrictType
-- 	from Districts;

-- insert or replace into ModifierArguments(ModifierId,	Name,	Value)
-- 	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'YieldType',	'YIELD_FAITH'
-- 	from Districts;




/*
insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'Description',	'???'
	from Districts;
	*/

--畜力机械
/*
insert or replace into BuildingModifiers(BuildingType,	ModifierId)	select
	'BUILDING_STG_ANIMAL_POWER',		'ANIMAL_POWER_FOR_'||BuildingType
	from Building_YieldChanges;

insert or replace into Modifiers(ModifierId,	ModifierType) select
	'ANIMAL_POWER_FOR_'||BuildingType,	'MODIFIER_BUILDING_YIELD_CHANGE'
	from Building_YieldChanges;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ANIMAL_POWER_FOR_'||BuildingType,	'BuildingType',		BuildingType
	from Building_YieldChanges;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ANIMAL_POWER_FOR_'||BuildingType,	'YieldType',		'YIELD_PRODUCTION'
	from Building_YieldChanges;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ANIMAL_POWER_FOR_'||BuildingType,	'Amount',		1
	from Building_YieldChanges;
*/

insert or ignore into BeliefModifiers 	(BeliefType,	ModifierID)
	select 'BELIEF_TRANSLATION_MOVEMENT',	'TRANSLATION_MOVEMENT_PURCHASE_'||Buildings.BuildingType
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;


insert or ignore into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'TRANSLATION_MOVEMENT_PURCHASE_'||Buildings.BuildingType,	'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',	'CITY_FOLLOWS_RELIGION_REQUIREMENTS'
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	
insert or ignore into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'TRANSLATION_MOVEMENT_PURCHASE_'||Buildings.BuildingType||'_MOD',	'MODIFIER_CITY_ENABLE_SPECIFIC_BUILDING_FAITH_PURCHASE', null
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	

insert or ignore into ModifierArguments(ModifierId,	Name,	Value)
	select 'TRANSLATION_MOVEMENT_PURCHASE_'||Buildings.BuildingType,	'ModifierId',	'TRANSLATION_MOVEMENT_PURCHASE_'||Buildings.BuildingType||'_MOD'
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	
insert or ignore into ModifierArguments(ModifierId,	Name,	Value)
	select 'TRANSLATION_MOVEMENT_PURCHASE_'||Buildings.BuildingType||'_MOD',	'BuildingType',	Buildings.BuildingType
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	


insert or ignore into BeliefModifiers 	(BeliefType,	ModifierID)
	select 'BELIEF_TRANSLATION_MOVEMENT',	'TRANSLATION_MOVEMENT_ADD_FAITH_'||Buildings.BuildingType
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	
insert or ignore into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'TRANSLATION_MOVEMENT_ADD_FAITH_'||Buildings.BuildingType,	'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',	'CITY_FOLLOWS_RELIGION_REQUIREMENTS'
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	
insert or ignore into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'TRANSLATION_MOVEMENT_ADD_FAITH_'||Buildings.BuildingType||'_MOD',	'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD', null
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	

insert or ignore into ModifierArguments(ModifierId,	Name,	Value)
	select 'TRANSLATION_MOVEMENT_ADD_FAITH_'||Buildings.BuildingType,	'ModifierId',	'TRANSLATION_MOVEMENT_ADD_FAITH_'||Buildings.BuildingType||'_MOD'
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	
insert or ignore into ModifierArguments(ModifierId,	Name,	Value)
	select 'TRANSLATION_MOVEMENT_ADD_FAITH_'||Buildings.BuildingType||'_MOD',	'BuildingType',	Buildings.BuildingType
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	
insert or ignore into ModifierArguments(ModifierId,	Name,	Value)
	select 'TRANSLATION_MOVEMENT_ADD_FAITH_'||Buildings.BuildingType||'_MOD',	'YieldType',	'YIELD_FAITH'
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	
insert or ignore into ModifierArguments(ModifierId,	Name,	Value)
	select 'TRANSLATION_MOVEMENT_ADD_FAITH_'||Buildings.BuildingType||'_MOD',	'Amount',	YieldChange
	from Building_YieldChanges, Buildings where YieldType = 'YIELD_SCIENCE' and YieldChange > 0
	and Building_YieldChanges.BuildingType = Buildings.BuildingType and Buildings.RequiresPlacement = 0;
	
--治所加维护费，现在已经废弃
-- insert or ignore into BuildingModifiers(BuildingType, ModifierId)
	-- select 'BUILDING_ZHISUO', 'ZHISUO_GOLD_'||BuildingType
	-- from Buildings where PrereqDistrict = 'DISTRICT_CITY_CENTER' and Maintenance > 0;

-- insert or ignore into Modifiers(ModifierId, ModifierType)
	-- select 'ZHISUO_GOLD_'||BuildingType, 'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD'
	-- from Buildings where PrereqDistrict = 'DISTRICT_CITY_CENTER' and Maintenance > 0;

-- insert or ignore into ModifierArguments(ModifierId,	Name,	Value)
	-- select 'ZHISUO_GOLD_'||BuildingType,	'YieldType',	'YIELD_GOLD'
	-- from Buildings where PrereqDistrict = 'DISTRICT_CITY_CENTER' and Maintenance > 0;

-- insert or ignore into ModifierArguments(ModifierId,	Name,	Value)
	-- select 'ZHISUO_GOLD_'||BuildingType,	'Amount',	Maintenance
	-- from Buildings where PrereqDistrict = 'DISTRICT_CITY_CENTER' and Maintenance > 0;

-- insert or ignore into ModifierArguments(ModifierId,	Name,	Value)
	-- select 'ZHISUO_GOLD_'||BuildingType,	'BuildingType',	'BUILDING_ZHISUO'
	-- from Buildings where PrereqDistrict = 'DISTRICT_CITY_CENTER' and Maintenance > 0;
	
-- 为拥有治所的其他城市提供本城总督初始头衔


-- 先筛选出来总督的初始头衔
create temporary table ZhiSuo_BaseGovernorPromotions
(
GovernorPromotionType text not null,
primary key (GovernorPromotionType)
);

insert or ignore into ZhiSuo_BaseGovernorPromotions
(GovernorPromotionType)
SELECT
GovernorPromotionType
from GovernorPromotions	where BaseAbility = 1;

-- 城主
insert into BuildingModifiers
(BuildingType,                  ModifierId)
select 
'BUILDING_ZHISUO',	'ZHISUO_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_REDOUBT';

insert into Modifiers
	(ModifierId,					ModifierType,						OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_GOVERNOR_PROMOTION_REDOUBT_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_REDOUBT';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'ModifierId',	'ZHISUO_ATTACH_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_REDOUBT';

insert into Modifiers
	(ModifierId,							ModifierType,									OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_REDOUBT';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'ModifierId',	ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_REDOUBT';

-- 外交官
insert into BuildingModifiers
(BuildingType,                  ModifierId)
select 
'BUILDING_ZHISUO',	'ZHISUO_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_AMBASSADOR_MESSENGER';

insert into Modifiers
	(ModifierId,					ModifierType,						OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_GOVERNOR_PROMOTION_AMBASSADOR_MESSENGER_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_AMBASSADOR_MESSENGER';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'ModifierId',	'ZHISUO_ATTACH_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_AMBASSADOR_MESSENGER';

insert into Modifiers
	(ModifierId,							ModifierType,									OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_AMBASSADOR_MESSENGER';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'ModifierId',	ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_AMBASSADOR_MESSENGER';

-- 金融家
insert into BuildingModifiers
(BuildingType,                  ModifierId)
select 
'BUILDING_ZHISUO',	'ZHISUO_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION';

insert into Modifiers
	(ModifierId,					ModifierType,						OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'ModifierId',	'ZHISUO_ATTACH_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION';

insert into Modifiers
	(ModifierId,							ModifierType,									OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'ModifierId',	ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MERCHANT_LAND_ACQUISITION';

-- 红衣主教
insert into BuildingModifiers
(BuildingType,                  ModifierId)
select 
'BUILDING_ZHISUO',	'ZHISUO_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_CARDINAL_MENTOR';

insert into Modifiers
	(ModifierId,					ModifierType,						OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_GOVERNOR_PROMOTION_CARDINAL_MENTOR_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_CARDINAL_MENTOR';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'ModifierId',	'ZHISUO_ATTACH_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_CARDINAL_MENTOR';

insert into Modifiers
	(ModifierId,							ModifierType,									OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_CARDINAL_MENTOR';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'ModifierId',	ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_CARDINAL_MENTOR';

-- 测量师
insert into BuildingModifiers
(BuildingType,                  ModifierId)
select 
'BUILDING_ZHISUO',	'ZHISUO_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_BUILDER_LEADER';

insert into Modifiers
	(ModifierId,					ModifierType,						OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_GOVERNOR_PROMOTION_BUILDER_LEADER_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_BUILDER_LEADER';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'ModifierId',	'ZHISUO_ATTACH_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_BUILDER_LEADER';

insert into Modifiers
	(ModifierId,							ModifierType,									OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_BUILDER_LEADER';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'ModifierId',	ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_BUILDER_LEADER';

-- 总务官
insert into BuildingModifiers
(BuildingType,                  ModifierId)
select 
'BUILDING_ZHISUO',	'ZHISUO_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MANAGER_EXPEDITION';

insert into Modifiers
	(ModifierId,					ModifierType,						OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_GOVERNOR_PROMOTION_MANAGER_EXPEDITION_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MANAGER_EXPEDITION';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'ModifierId',	'ZHISUO_ATTACH_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MANAGER_EXPEDITION';

insert into Modifiers
	(ModifierId,							ModifierType,									OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MANAGER_EXPEDITION';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'ModifierId',	ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_MANAGER_EXPEDITION';

-- 教育家
insert into BuildingModifiers
(BuildingType,                  ModifierId)
select 
'BUILDING_ZHISUO',	'ZHISUO_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS';

insert into Modifiers
	(ModifierId,					ModifierType,						OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_'||ModifierId, 	'ModifierId',	'ZHISUO_ATTACH_ATTACH_'||ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS';

insert into Modifiers
	(ModifierId,							ModifierType,									OwnerRequirementSetId,		SubjectRequirementSetId)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',		NULL,      					'REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA'
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS';

insert into ModifierArguments
	(ModifierId,					Name,			Value)
SELECT
	'ZHISUO_ATTACH_ATTACH_'||ModifierId, 	'ModifierId',	ModifierId
from GovernorPromotionModifiers 
where GovernorPromotionType='GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS';

-- 城市有已就职的总督头衔
insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select
    'REQSET_CITY_HAS_'||GovernorPromotionType||'_DA',         	'REQUIREMENTSET_TEST_ALL'
from ZhiSuo_BaseGovernorPromotions;
	
insert or ignore into Requirements
    (RequirementId,                                 RequirementType)
select
    'REQ_CITY_HAS_'||GovernorPromotionType||'_DA',         	'REQUIREMENT_CITY_HAS_SPECIFIC_GOVERNOR_PROMOTION_TYPE'
from ZhiSuo_BaseGovernorPromotions;

insert or ignore into RequirementArguments
(RequirementId, 										Name, 						Value)
select
    'REQ_CITY_HAS_'||GovernorPromotionType||'_DA',    	'Established', 				1
from ZhiSuo_BaseGovernorPromotions;

insert or ignore into RequirementArguments
(RequirementId, 										Name, 						Value)
select
    'REQ_CITY_HAS_'||GovernorPromotionType||'_DA',     	'GovernorPromotionType', 	GovernorPromotionType
from ZhiSuo_BaseGovernorPromotions;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select
    'REQSET_CITY_HAS_'||GovernorPromotionType||'_DA',   'REQ_CITY_HAS_'||GovernorPromotionType||'_DA'
from ZhiSuo_BaseGovernorPromotions;


-- 拥有建筑且1格以外
insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
values
    ('REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA',         	'REQUIREMENTSET_TEST_ALL');

insert or ignore into Requirements
    (RequirementId,                                 RequirementType)
values
    ('REQ_CITY_HAS_ZHISUO',                         'REQUIREMENT_CITY_HAS_BUILDING'),
    ('REQ_PLOT_1_TILE_AWAY',                    	'REQUIREMENT_PLOT_ADJACENT_TO_OWNER');

insert or ignore into RequirementArguments
(RequirementId, 							Name, 				Value)
VALUES
    ('REQ_CITY_HAS_ZHISUO',                'BuildingType', 		'BUILDING_ZHISUO'),
    ('REQ_PLOT_1_TILE_AWAY',               'MinDistance', 		1),
	('REQ_PLOT_1_TILE_AWAY',               'MaxDistance', 		200);
	
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
values
    ('REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA',       'REQ_CITY_HAS_ZHISUO'),
    ('REQSET_CITY_HAS_ZHISUO_1_TILE_AWAY_DA',       'REQ_PLOT_1_TILE_AWAY');



--包容da新增的建筑
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_CITY_HAS_'||BuildingType, 'REQUIREMENT_CITY_HAS_BUILDING'
from Buildings;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||BuildingType, 'BuildingType', BuildingType
from Buildings;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_'||BuildingType,				'REQUIREMENTSET_TEST_ALL'
from Buildings;                                

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_'||BuildingType,				'REQ_CITY_HAS_'||BuildingType
from Buildings;


insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
values	('RS_CITY_HAS_BUILDING',							'REQUIREMENTSET_TEST_ANY');

insert or replace into RequirementSetRequirements(RequirementSetId,		RequirementId) select
	'RS_CITY_HAS_BUILDING',			'REQ_CITY_HAS_'||BuildingType
	from Buildings where BuildingType not like '%CITY_POLICY%' and BuildingType not like '%FLAG%' and BuildingType not like '%CTZY%'; 


-- insert or replace into UnitOperations(OperationType, Description, Icon, VisibleInUI, HoldCycling, CategoryInUI, InterfaceMode, BaseProbability, LevelProbChange, EnemyProbChange, EnemyLevelProbChange, TargetDistrict, Offensive) values
-- 	('UNITOPERATION_SPY_TEST', 'LOC_UNITOPERATION_SPY_TEST_DESCRIPTION',	'ICON_UNITOPERATION_SPY_TEST',	1, 1, 'OFFENSIVESPY','INTERFACEMODE_SPY_CHOOSE_MISSION', 50, 1, 1, 1, 'DISTRICT_HOLY_SITE',	1);
update Governors set TransitionStrength = 600;



--这些建筑给的专家伟人点和建筑产伟人点对齐
insert or replace into Building_Citizen_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn) select
    BuildingType, GreatPersonClassType, PointsPerTurn
    from Building_GreatPersonPoints where BuildingType in ('BUILDING_LIBRARY', 'BUILDING_SHRINE', 'BUILDING_STABLE', 'BUILDING_BARRACKS', 'BUILDING_MARKET', 'BUILDING_AMPHITHEATER',
        'BUILDING_LIGHTHOUSE', 'BUILDING_WORKSHOP', 'BUILDING_UNIVERSITY', 'BUILDING_RESEARCH_LAB', 'BUILDING_ARENA', 'BUILDING_FACTORY', 'BUILDING_COAL_POWER_PLANT', 'BUILDING_FOSSIL_FUEL_POWER_PLANT', 'BUILDING_POWER_PLANT')
        or BuildingType in (select CivUniqueBuildingType from BuildingReplaces where ReplacesBuildingType in 
            ('BUILDING_LIBRARY', 'BUILDING_SHRINE', 'BUILDING_STABLE', 'BUILDING_BARRACKS', 'BUILDING_MARKET', 'BUILDING_AMPHITHEATER',
        'BUILDING_LIGHTHOUSE', 'BUILDING_WORKSHOP', 'BUILDING_UNIVERSITY', 'BUILDING_RESEARCH_LAB', 'BUILDING_ARENA',
        'BUILDING_FACTORY', 'BUILDING_COAL_POWER_PLANT', 'BUILDING_FOSSIL_FUEL_POWER_PLANT', 'BUILDING_POWER_PLANT'));


--建筑提升专家的伟人点产出
insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) select
    BuildingType||'_CITIZEN_'||GreatPersonClassType||'_'||numbers, 'MODIFIER_PLAYER_DISTRICT_ADJUST_GREAT_PERSON_POINTS', 'RS_PLOT_HAS_'||numbers||'_WORKERS'
    from Building_Citizen_GreatPersonPoints, counter_m where numbers > 0 and numbers < 20;

insert or replace into BuildingModifiers(BuildingType, ModifierId) select
    BuildingType, BuildingType||'_CITIZEN_'||GreatPersonClassType||'_'||numbers
    from Building_Citizen_GreatPersonPoints, counter_m where numbers > 0 and numbers < 20;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
    BuildingType||'_CITIZEN_'||GreatPersonClassType||'_'||numbers, 'GreatPersonClassType', GreatPersonClassType
    from Building_Citizen_GreatPersonPoints, counter_m where numbers > 0 and numbers < 20;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
    BuildingType||'_CITIZEN_'||GreatPersonClassType||'_'||numbers, 'Amount', PointsPerTurn
    from Building_Citizen_GreatPersonPoints, counter_m where numbers > 0 and numbers < 20;

--提供给toolTipHelper使用  建筑给专家带来的更多伟人点数
insert or replace into CitizenBonus(ItemType,       BonusType,      Amount) select
    BuildingType, GreatPersonClassType, PointsPerTurn
     from Building_Citizen_GreatPersonPoints;

--盈余物流 DA_Governors.sql
-- insert or ignore into GovernorPromotionModifiers(GovernorPromotionType, ModifierId) select
-- 	'GOVERNOR_PROMOTION_MANAGER_SURPLUS',		'SURPLUS_TRADE_'||DistrictType||'_'||YieldType
-- 	from District_TradeRouteYields where YieldChangeAsDomesticDestination != 0;

-- insert or ignore into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
-- 	'SURPLUS_TRADE_'||DistrictType||'_'||YieldType, 'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS', 'RS_CITY_HAS_'||DistrictType
-- 	from District_TradeRouteYields where YieldChangeAsDomesticDestination != 0;

-- insert or ignore into ModifierArguments(ModifierId, Name, Value) select
-- 	'SURPLUS_TRADE_'||DistrictType||'_'||YieldType, 'YieldType', YieldType
-- 	from District_TradeRouteYields where YieldChangeAsDomesticDestination != 0;

-- insert or ignore into ModifierArguments(ModifierId, Name, Value) select
-- 	'SURPLUS_TRADE_'||DistrictType||'_'||YieldType, 'Amount', YieldChangeAsDomesticDestination
-- 	from District_TradeRouteYields where YieldChangeAsDomesticDestination != 0;

-- insert or ignore into ModifierArguments(ModifierId, Name, Value) select
-- 	'SURPLUS_TRADE_'||DistrictType||'_'||YieldType, 'Domestic', 1
-- 	from District_TradeRouteYields where YieldChangeAsDomesticDestination != 0;


--初始开拓者 行动加速 来自hd hd又抄的不知道谁
INSERT OR IGNORE INTO Types (Type, Kind) VALUES
('FSS_MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_TERRAIN_COST', 'KIND_MODIFIER');

INSERT OR IGNORE INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES
('FSS_MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_TERRAIN_COST', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_UNIT_IGNORE_TERRAIN_COST');

INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_MAJOR_CIV', 'FSS_SETTLER_SPEED_BOOST'),
('TRAIT_LEADER_MAJOR_CIV', 'FSS_SETTLER_IGNORE_TERRAIN'),
('TRAIT_LEADER_MAJOR_CIV', 'FSS_SETTLER_IGNORE_RIVERS'),
('TRAIT_LEADER_MAJOR_CIV', 'FSS_SETTLER_IGNORE_EMBARK');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, Permanent, SubjectRequirementSetId) VALUES
('FSS_SETTLER_SPEED_BOOST', 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT', 1, 'FSS_SETTLER_SPEED_REQSET'),
('FSS_SETTLER_IGNORE_TERRAIN', 'FSS_MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_TERRAIN_COST', 1, 'FSS_SETTLER_SPEED_REQSET'),
('FSS_SETTLER_IGNORE_RIVERS', 'MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_RIVERS', 1, 'FSS_SETTLER_SPEED_REQSET'),
('FSS_SETTLER_IGNORE_EMBARK', 'MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_SHORES', 1, 'FSS_SETTLER_SPEED_REQSET');

INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
('FSS_SETTLER_SPEED_BOOST', 'Amount', 1),
('FSS_SETTLER_IGNORE_TERRAIN', 'Ignore', 1),
('FSS_SETTLER_IGNORE_TERRAIN', 'Type', 'ALL'),
('FSS_SETTLER_IGNORE_RIVERS', 'Ignore', 1),
('FSS_SETTLER_IGNORE_EMBARK', 'Ignore', 1);

INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('FSS_SETTLER_SPEED_REQSET', 'REQUIREMENTSET_TEST_ALL');

INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('FSS_SETTLER_SPEED_REQSET', 'FSS_REQUIRES_UNIT_IS_SETTLER'),
('FSS_SETTLER_SPEED_REQSET', 'FSS_REQUIRES_NO_PALACE');

INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType, Inverse) VALUES
('FSS_REQUIRES_UNIT_IS_SETTLER', 'REQUIREMENT_UNIT_TYPE_MATCHES', 0),
('FSS_REQUIRES_NO_PALACE', 'REQUIREMENT_PLAYER_HAS_AT_LEAST_NUM_BUILDINGS', 1);

INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
('FSS_REQUIRES_UNIT_IS_SETTLER', 'UnitType', 'UNIT_SETTLER'),
('FSS_REQUIRES_NO_PALACE', 'BuildingType', 'BUILDING_PALACE'),
('FSS_REQUIRES_NO_PALACE', 'Amount', 1);

--某资源在同一城市可多次生效
insert or ignore into Modifiers(ModifierId, ModifierType) select
	'NO_CAP_'||ResourceType, 'MODIFIER_SINGLE_PLAYER_ADJUST_NO_CAP_RESOURCE'
	from Resources  where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'NO_CAP_'||ResourceType, 'ResourceType', ResourceType
	from Resources  where ResourceClassType = 'RESOURCECLASS_LUXURY';
