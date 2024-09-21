






--================================

--狩猎女神临时改为 有资源营地+1锤
update Modifiers set SubjectRequirementSetId = 'RS_PLOT_HAS_IMPROVEMENT_CAMP_WITH_RESOURCE'
	where ModifierId in ('GODDESS_OF_THE_HUNT_CAMP_FOOD_MODIFIER', 'GODDESS_OF_THE_HUNT_CAMP_PRODUCTION_MODIFIER');
delete from BeliefModifiers where ModifierId = 'GODDESS_OF_THE_HUNT_CAMP_FOOD';

insert or replace into BeliefModifiers
	(BeliefType,						ModifierID)
values 
	('BELIEF_GOD_OF_THE_SEA',			'GOD_OF_THE_SEA_FISHERY_WITH_RESOURCE_FOOD');

insert or replace into Modifiers
	(ModifierId,															ModifierType,													SubjectRequirementSetId)
values
	('GOD_OF_THE_SEA_FISHERY_WITH_RESOURCE_FOOD',							'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'),
	('GOD_OF_THE_SEA_FISHERY_WITH_RESOURCE_FOOD_MOD',						'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',					'RS_PLOT_HAS_IMPROVEMENT_FISHERY_WITH_RESOURCE');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('GOD_OF_THE_SEA_FISHERY_WITH_RESOURCE_FOOD',			'ModifierId',	'GOD_OF_THE_SEA_FISHERY_WITH_RESOURCE_FOOD_MOD'),
	('GOD_OF_THE_SEA_FISHERY_WITH_RESOURCE_FOOD_MOD',		'YieldType',	'YIELD_FOOD'),
	('GOD_OF_THE_SEA_FISHERY_WITH_RESOURCE_FOOD_MOD',		'Amount',		'1');

insert or replace into Types(Type, Kind) values
	('BELIEF_TRANSLATION_MOVEMENT',	'KIND_BELIEF');

insert or replace into Beliefs(BeliefType,						Name,										Description,											BeliefClassType) values
	('BELIEF_TRANSLATION_MOVEMENT',			'LOC_BELIEF_TRANSLATION_MOVEMENT_NAME',	'LOC_BELIEF_TRANSLATION_MOVEMENT_DESCRIPTION',	'BELIEF_CLASS_FOLLOWER');

delete from BeliefModifiers
	where BeliefType in
	('BELIEF_FEED_THE_WORLD',
	'BELIEF_CHORAL_MUSIC',
	'BELIEF_RELIGIOUS_COMMUNITY',
	'BELIEF_WORK_ETHIC',
	'BELIEF_ZEN_MEDITATION'

		);


insert or replace into BeliefModifiers
	(BeliefType,						ModifierID)
values
	('BELIEF_FEED_THE_WORLD',			'FEED_THE_WORLD_TIER1'),  --每级给每人口减0.2粮食消耗
	('BELIEF_FEED_THE_WORLD',			'FEED_THE_WORLD_TIER2'),  --每级给每人口减0.2粮食消耗
	('BELIEF_FEED_THE_WORLD',			'FEED_THE_WORLD_TIER3'),  --每级给每人口减0.2粮食消耗
	('BELIEF_CHORAL_MUSIC',				'CHORAL_MUSIC_CULTURE'),  --圣地相邻加琴
	('BELIEF_CHORAL_MUSIC',				'CHORAL_MUSIC_FAITH'),  --剧院相邻加鸽子
	('BELIEF_CHORAL_MUSIC',				'CHORAL_MUSIC_FAITH'),  --剧院相邻加鸽子
	('BELIEF_RELIGIOUS_COMMUNITY',		'RELIGIOUS_COMMUNITY_DISTRICT_HOUSING'),  
	('BELIEF_RELIGIOUS_COMMUNITY',		'RELIGIOUS_COMMUNITY_IMPROVEMENT_HOUSING'),  
	('BELIEF_WORK_ETHIC',				'WORK_ETHIC_PRODUCTION'),  
	('BELIEF_WORK_ETHIC',				'WORK_ETHIC_PRODUCTION_EX'),

	('BELIEF_TRANSLATION_MOVEMENT',		'TRANSLATION_MOVEMENT_SCINECE_1'),
	('BELIEF_TRANSLATION_MOVEMENT',		'TRANSLATION_MOVEMENT_SCINECE_2'),
	('BELIEF_TRANSLATION_MOVEMENT',		'TRANSLATION_MOVEMENT_SCINECE_3');


	--('BELIEF_TRANSLATION_MOVEMENT',				'XXXX'); --效果代码在postProcess.sql里




insert or replace into Modifiers
	(ModifierId,												ModifierType,													SubjectRequirementSetId)
values
	('FEED_THE_WORLD_TIER1',							'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('FEED_THE_WORLD_TIER1_MOD',						'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		'RS_CITY_HAS_BUILDING_SHRINE'),
	('FEED_THE_WORLD_TIER2',							'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('FEED_THE_WORLD_TIER2_MOD',						'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		'RS_CITY_HAS_BUILDING_TEMPLE'),
	('FEED_THE_WORLD_TIER3',							'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('FEED_THE_WORLD_TIER3_MOD',						'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		'RS_CITY_HAS_HOLY_SITE_TIER3'),
	('CHORAL_MUSIC_CULTURE',							'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('CHORAL_MUSIC_CULTURE_MOD',						'MODIFIER_SINGLE_CITY_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',	'RS_CITY_HAS_DISTRICT_THEATER'),
	('CHORAL_MUSIC_FAITH',								'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('CHORAL_MUSIC_FAITH_MOD',							'MODIFIER_SINGLE_CITY_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',	'RS_CITY_HAS_DISTRICT_HOLY_SITE'),
	('RELIGIOUS_COMMUNITY_DISTRICT_HOUSING',			'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('RELIGIOUS_COMMUNITY_DISTRICT_HOUSING_MOD',		'MODIFIER_SINGLE_CITY_DISTRICT_ADJUST_HOUSING',					'RS_ADJACENT_TO_HOLY_SITE'),
	('RELIGIOUS_COMMUNITY_IMPROVEMENT_HOUSING',			'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('RELIGIOUS_COMMUNITY_IMPROVEMENT_HOUSING_MOD',		'MODIFIER_SINGLE_CITY_PLOT_ADJUST_HOUSING',						'RS_IMPROVED_ADJACENT_TO_HOLY_SITE'),
	('WORK_ETHIC_PRODUCTION',							'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('WORK_ETHIC_PRODUCTION_MOD',						'MODIFIER_FOLLOWER_YIELD_MODIFIER',								NULL),
	('WORK_ETHIC_PRODUCTION_EX',						'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('WORK_ETHIC_PRODUCTION_EX_MOD',					'MODIFIER_FOLLOWER_YIELD_MODIFIER',								'RS_CITY_HAS_5_ADJACENCY_DISTRICT_HOLY_SITE'),

	('TRANSLATION_MOVEMENT_SCINECE_1',					'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('TRANSLATION_MOVEMENT_SCINECE_1_MOD',				'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',					'RS_PLOT_HAS_DISTRICT_HOLY_SITE'),
	('TRANSLATION_MOVEMENT_SCINECE_2',					'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('TRANSLATION_MOVEMENT_SCINECE_2_MOD',				'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',					NULL),
	('TRANSLATION_MOVEMENT_SCINECE_3',					'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',							'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
	('TRANSLATION_MOVEMENT_SCINECE_3_MOD',				'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',					NULL);



insert or replace into ModifierArguments
	(ModifierId,												Name,					Value)
values
	-- Follower
	('FEED_THE_WORLD_TIER1',								'ModifierId',			'FEED_THE_WORLD_TIER1_MOD'),
	('FEED_THE_WORLD_TIER1_MOD',							'YieldType',			'YIELD_FOOD'),
	('FEED_THE_WORLD_TIER1_MOD',							'Amount',				0.2),
	('FEED_THE_WORLD_TIER2',								'ModifierId',			'FEED_THE_WORLD_TIER2_MOD'),
	('FEED_THE_WORLD_TIER2_MOD',							'YieldType',			'YIELD_FOOD'),
	('FEED_THE_WORLD_TIER2_MOD',							'Amount',				0.2),
	('FEED_THE_WORLD_TIER3',								'ModifierId',			'FEED_THE_WORLD_TIER3_MOD'),
	('FEED_THE_WORLD_TIER3_MOD',							'YieldType',			'YIELD_FOOD'),
	('FEED_THE_WORLD_TIER3_MOD',							'Amount',				0.2),
	('CHORAL_MUSIC_CULTURE',								'ModifierId',			'CHORAL_MUSIC_CULTURE_MOD'),
	('CHORAL_MUSIC_CULTURE_MOD',							'DistrictType',			'DISTRICT_HOLY_SITE'),
	('CHORAL_MUSIC_CULTURE_MOD',							'YieldTypeToGrant',		'YIELD_CULTURE'),
	('CHORAL_MUSIC_CULTURE_MOD',							'YieldTypeToMirror',	'YIELD_FAITH'),
	('CHORAL_MUSIC_FAITH',									'ModifierId',			'CHORAL_MUSIC_FAITH_MOD'),
	('CHORAL_MUSIC_FAITH_MOD',							    'DistrictType',			'DISTRICT_THEATER'),
	('CHORAL_MUSIC_FAITH_MOD',								'YieldTypeToGrant',		'YIELD_FAITH'),
	('CHORAL_MUSIC_FAITH_MOD',								'YieldTypeToMirror',	'YIELD_CULTURE'),
	('RELIGIOUS_COMMUNITY_DISTRICT_HOUSING',				'ModifierId',			'RELIGIOUS_COMMUNITY_DISTRICT_HOUSING_MOD'),
	('RELIGIOUS_COMMUNITY_DISTRICT_HOUSING_MOD',			'Amount',				'2'),
	('RELIGIOUS_COMMUNITY_IMPROVEMENT_HOUSING',				'ModifierId',			'RELIGIOUS_COMMUNITY_IMPROVEMENT_HOUSING_MOD'),
	('RELIGIOUS_COMMUNITY_IMPROVEMENT_HOUSING_MOD',			'Amount',				'1'),
	('WORK_ETHIC_PRODUCTION',								'ModifierId',			'WORK_ETHIC_PRODUCTION_MOD'),
	('WORK_ETHIC_PRODUCTION_MOD',							'YieldType',			'YIELD_PRODUCTION'),
	('WORK_ETHIC_PRODUCTION_MOD',							'Amount',				'1'),	
	('WORK_ETHIC_PRODUCTION_EX',							'ModifierId',			'YIELD_FAITH'),
	('WORK_ETHIC_PRODUCTION_EX_MOD',						'YieldType',			'YIELD_PRODUCTION'),
	('WORK_ETHIC_PRODUCTION_EX_MOD',						'Amount',				'1'),

	('TRANSLATION_MOVEMENT_SCINECE_1',						'ModifierId',			'TRANSLATION_MOVEMENT_SCINECE_1_MOD'),
	('TRANSLATION_MOVEMENT_SCINECE_1_MOD',					'YieldType',			'YIELD_SCIENCE'),
	('TRANSLATION_MOVEMENT_SCINECE_1_MOD',					'Amount',				'1'),	
	('TRANSLATION_MOVEMENT_SCINECE_2',						'ModifierId',			'TRANSLATION_MOVEMENT_SCINECE_2_MOD'),
	('TRANSLATION_MOVEMENT_SCINECE_2_MOD',					'YieldType',			'YIELD_SCIENCE'),
	('TRANSLATION_MOVEMENT_SCINECE_2_MOD',					'Amount',				'1'),
	('TRANSLATION_MOVEMENT_SCINECE_2_MOD',					'BuildingType',			'BUILDING_SHRINE'),
	('TRANSLATION_MOVEMENT_SCINECE_3',						'ModifierId',			'TRANSLATION_MOVEMENT_SCINECE_3_MOD'),
	('TRANSLATION_MOVEMENT_SCINECE_3_MOD',					'YieldType',			'YIELD_SCIENCE'),
	('TRANSLATION_MOVEMENT_SCINECE_3_MOD',					'Amount',				'1'),
	('TRANSLATION_MOVEMENT_SCINECE_3_MOD',					'BuildingType',			'BUILDING_TEMPLE');



insert or replace INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
('RS_ADJACENT_TO_HOLY_SITE', 'REQUIREMENTSET_TEST_ALL'),
('RS_IMPROVED_ADJACENT_TO_HOLY_SITE', 'REQUIREMENTSET_TEST_ALL');

insert or replace INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
('RS_ADJACENT_TO_HOLY_SITE', 			'REQ_ADJACENT_TO_HOLY_SITE'),
('RS_IMPROVED_ADJACENT_TO_HOLY_SITE', 	'REQ_ADJACENT_TO_HOLY_SITE'),
('RS_IMPROVED_ADJACENT_TO_HOLY_SITE', 	'REQ_IMPROVED');


insert or replace INTO Requirements (RequirementId, RequirementType) VALUES 
('REQ_ADJACENT_TO_HOLY_SITE', 	'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES'),
('REQ_IMPROVED', 				'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT');

insert or replace INTO RequirementArguments (RequirementId, Name, Value) VALUES 
('REQ_ADJACENT_TO_HOLY_SITE', 'DistrictType', 'DISTRICT_HOLY_SITE'), 
('REQ_ADJACENT_TO_HOLY_SITE', 'MaxRange', '1'), 
('REQ_ADJACENT_TO_HOLY_SITE', 'MinRange', '1');


-- 禅修
insert or replace into 	BeliefModifiers	(BeliefType,		ModifierID)
	select 'BELIEF_ZEN_MEDITATION',		'MEDITATION_ADJACENCY_TIER_'||(numbers * 2)
	from counter where numbers >=1 and numbers <= 5;

insert or replace into 	BeliefModifiers	(BeliefType,		ModifierID)
	select 'BELIEF_ZEN_MEDITATION',		'MEDITATION_AMENITY_TIER_'||(numbers * 2)
	from counter where numbers >=1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'MEDITATION_ADJACENCY_TIER_'||(numbers * 2),		'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',		'CITY_FOLLOWS_RELIGION_REQUIREMENTS'
	from counter where numbers >=1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'MEDITATION_AMENITY_TIER_'||(numbers * 2),		'MODIFIER_ALL_CITIES_ATTACH_MODIFIER',		'CITY_FOLLOWS_RELIGION_REQUIREMENTS'
	from counter where numbers >=1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'MEDITATION_ADJACENCY_TIER_'||(numbers * 2)||'_MOD',		'MODIFIER_CITY_DISTRICT_ADJUST_YIELD_BASED_ON_APPEAL',		NULL
	from counter where numbers >=1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'MEDITATION_AMENITY_TIER_'||(numbers * 2)||'_MOD',		'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_AMENITY',		'RS_HOLY_SITE_APPEAL_'||(numbers * 2)
	from counter where numbers >=1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'MEDITATION_ADJACENCY_TIER_'||(numbers * 2),	'ModifierId',	'MEDITATION_ADJACENCY_TIER_'||(numbers * 2)||'_MOD'
	from counter where numbers >=1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'MEDITATION_AMENITY_TIER_'||(numbers * 2),	'ModifierId',	'MEDITATION_AMENITY_TIER_'||(numbers * 2)||'_MOD'
	from counter where numbers >=1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'MEDITATION_ADJACENCY_TIER_'||(numbers * 2)||'_MOD',	'DistrictType',	'DISTRICT_HOLY_SITE'
	from counter where numbers >=1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'MEDITATION_ADJACENCY_TIER_'||(numbers * 2)||'_MOD',	'RequiredAppeal',	numbers * 2
	from counter where numbers >=1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'MEDITATION_ADJACENCY_TIER_'||(numbers * 2)||'_MOD',	'YieldChange',	1
	from counter where numbers >=1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'MEDITATION_ADJACENCY_TIER_'||(numbers * 2)||'_MOD',	'YieldType',	'YIELD_FAITH'
	from counter where numbers >=1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'MEDITATION_AMENITY_TIER_'||(numbers * 2)||'_MOD',	'Amount',	1
	from counter where numbers >=1 and numbers <= 5;


insert or replace into RequirementSets(RequirementSetId,	RequirementSetType)
	select	'RS_HOLY_SITE_APPEAL_'||(numbers * 2),		'REQUIREMENTSET_TEST_ALL'
	from counter where numbers >=1 and numbers <= 5;

insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId)  
	select 'RS_HOLY_SITE_APPEAL_'||(numbers * 2),		'REQUIRES_DISTRICT_IS_HOLY_SITE'
	from counter where numbers >=1 and numbers <= 5;

insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId)  
	select 'RS_HOLY_SITE_APPEAL_'||(numbers * 2),		'REQ_PLOT_APPEAL_'||(numbers * 2)
	from counter where numbers >=1 and numbers <= 5;





insert or replace into Types
	(Type,								Kind)
select 'BELIEF_EMPTY_PANTHEON_'||numbers,	'KIND_BELIEF'
from counter where numbers > 0 and numbers < 50;


insert or replace into Beliefs
	(BeliefType,						Name,										Description,											BeliefClassType)
select 'BELIEF_EMPTY_PANTHEON_'||numbers,  'LOC_BELIEF_EMPTY_PANTHEON_NAME', 'LOC_BELIEF_EMPTY_PANTHEON_DESCRIPTION', 'BELIEF_CLASS_PANTHEON'
from counter where numbers > 0 and numbers < 50;


--测试用代码 送100鸽子用于发万神殿
-- insert or replace into TraitModifiers(TraitType, ModifierId) values
-- 	('TRAIT_LEADER_MAJOR_CIV', 'GRANT_100_FAITH');

-- insert or replace into Modifiers(ModifierId, ModifierType) values
-- 	('GRANT_100_FAITH', 'MODIFIER_PLAYER_GRANT_YIELD');


-- insert or replace into ModifierArguments(ModifierId, Name, Value) values
-- 	('GRANT_100_FAITH', 'YieldType', 'YIELD_FAITH'),
-- 	('GRANT_100_FAITH', 'Amount', 	'100');



-- Sort Index
create table 'BeliefsSortIndex'(
	'BeliefType' TEXT NOT NULL,
	'SortIndex' Int NOT NULL,
	PRIMARY KEY('BeliefType')
);

insert or replace into BeliefsSortIndex
	(BeliefType,			SortIndex)
select
	BeliefType,				10
from Beliefs;

-- 万神殿 - 追随 - 创立 - 强化 - 祭祀
-- Pantheon(0-99) 
-- 排序依据：海洋万神[0]、资源类[改良类型优先(10)]、无资源发教类[地形(30)-地貌(40)-其他(50)]、无资源不发教类[地形(60)-地貌(70)-其他(80)] 
-- 海洋系
update BeliefsSortIndex set SortIndex =	0 where BeliefType = 'BELIEF_GOD_OF_THE_SEA';
update BeliefsSortIndex set SortIndex =	1 where BeliefType = 'BELIEF_OCEAN_MOTHER';
update BeliefsSortIndex set SortIndex =	2 where BeliefType = 'BELIEF_HD_MAZU_BELIEF';
update BeliefsSortIndex set SortIndex =	3 where BeliefType = 'BELIEF_FISHING_TRADITION';
update BeliefsSortIndex set SortIndex =	4 where BeliefType = 'BELIEF_HD_UTAKI';
update BeliefsSortIndex set SortIndex =	5 where BeliefType = 'BELIEF_HD_SONG_OF_SIREN';
-- 资源系
update BeliefsSortIndex set SortIndex =	10 where BeliefType = 'BELIEF_GODDESS_OF_THE_HARVEST';
update BeliefsSortIndex set SortIndex =	11 where BeliefType = 'BELIEF_HD_SUN_GOD';

update BeliefsSortIndex set SortIndex =	13 where BeliefType = 'BELIEF_RELIGIOUS_IDOLS'; --2,4 矿山采石
update BeliefsSortIndex set SortIndex =	14 where BeliefType = 'BELIEF_TALE_OF_DWALVES';
update BeliefsSortIndex set SortIndex =	15 where BeliefType = 'BELIEF_STONE_CIRCLES';
update BeliefsSortIndex set SortIndex =	16 where BeliefType = 'BELIEF_MEGALITHIC_WORSHIP';
update BeliefsSortIndex set SortIndex =	19 where BeliefType = 'BELIEF_GOD_OF_THE_OPEN_SKY'; --17,18 伐木 位于resourceful2
update BeliefsSortIndex set SortIndex =	20 where BeliefType = 'BELIEF_TENGRI';
update BeliefsSortIndex set SortIndex =	21 where BeliefType = 'BELIEF_GODDESS_OF_THE_HUNT';
update BeliefsSortIndex set SortIndex =	22 where BeliefType = 'BELIEF_HD_WOLF_GOD';
update BeliefsSortIndex set SortIndex =	23 where BeliefType = 'BELIEF_ORAL_TRADITION';
update BeliefsSortIndex set SortIndex =	24 where BeliefType = 'BELIEF_GODDESS_OF_FESTIVALS';
update BeliefsSortIndex set SortIndex =	25 where BeliefType = 'BELIEF_GOD_OF_CRAFTSMEN';
-- 发教-地形
update BeliefsSortIndex set SortIndex =	30 where BeliefType = 'BELIEF_GODDESS_OF_THE_DESERT';--市中心、圣地
update BeliefsSortIndex set SortIndex =	31 where BeliefType = 'BELIEF_DESERT_FOLKLORE';
update BeliefsSortIndex set SortIndex =	33 where BeliefType = 'BELIEF_DANCE_OF_THE_AURORA';
update BeliefsSortIndex set SortIndex =	35 where BeliefType = 'BELIEF_RIVER_GODDESS';
update BeliefsSortIndex set SortIndex =	37 where BeliefType = 'BELIEF_HD_POSTERITY_OF_MOUNTAIN';
-- 发教-地貌
update BeliefsSortIndex set SortIndex =	40 where BeliefType = 'BELIEF_SACRED_PATH';
update BeliefsSortIndex set SortIndex =	41 where BeliefType = 'BELIEF_GODDESS_OF_FIRE';
-- 发教-其他

update BeliefsSortIndex set SortIndex =	51 where BeliefType = 'BELIEF_EARTH_GODDESS';
update BeliefsSortIndex set SortIndex =	52 where BeliefType = 'BELIEF_ONE_WITH_NATURE';
update BeliefsSortIndex set SortIndex =	53 where BeliefType = 'BELIEF_GOD_OF_WAR';
update BeliefsSortIndex set SortIndex =	54 where BeliefType = 'BELIEF_RELIGIOUS_SETTLEMENTS';
update BeliefsSortIndex set SortIndex =	55 where BeliefType = 'BELIEF_HD_GOD_KING';
-- 不发教-地形
update BeliefsSortIndex set SortIndex =	60 where BeliefType = 'BELIEF_THE_PEOPLE_OF_POLAR';
-- 不发教-地貌
update BeliefsSortIndex set SortIndex =	70 where BeliefType = 'BELIEF_LADY_OF_THE_REEDS_AND_MARSHES';
update BeliefsSortIndex set SortIndex =	71 where BeliefType = 'BELIEF_VOODOO';
update BeliefsSortIndex set SortIndex =	72 where BeliefType = 'BELIEF_HD_DRUID';
-- 不发教-其他
update BeliefsSortIndex set SortIndex =	80 where BeliefType = 'BELIEF_MONUMENT_TO_THE_GODS';
update BeliefsSortIndex set SortIndex =	81 where BeliefType = 'BELIEF_FERTILITY_RITES';
update BeliefsSortIndex set SortIndex =	83 where BeliefType = 'BELIEF_SPARTA_SPIRIT';
update BeliefsSortIndex set SortIndex =	84 where BeliefType = 'BELIEF_ILLUMINATORS';
--update BeliefsSortIndex set SortIndex =	86 where BeliefType = 'BELIEF_STARLIGHT_NAVIGATER';
update BeliefsSortIndex set SortIndex =	85 where BeliefType = 'BELIEF_HD_HERMES';
update BeliefsSortIndex set SortIndex =	86 where BeliefType = 'BELIEF_HD_DIONYSIAN_MYSTERIES';
update BeliefsSortIndex set SortIndex =	87 where BeliefType = 'BELIEF_CITY_PATRON_GODDESS';
update BeliefsSortIndex set SortIndex =	88 where BeliefType = 'BELIEF_DIVINE_SPARK';
update BeliefsSortIndex set SortIndex =	89 where BeliefType = 'BELIEF_GOD_OF_THE_FORGE';


create table 'PantheonAnalysis'(
	'BeliefType' TEXT NOT NULL,
	'ModifierId' TEXT NOT NULL,
	'EffectType' TEXT NOT NULL,
	'CollectionType' TEXT NOT NULL,
	'ModifierType' TEXT,
	PRIMARY KEY('BeliefType', 'ModifierId')
);

insert or ignore into PantheonAnalysis(BeliefType, ModifierId, EffectType, CollectionType)
	select Beliefs.BeliefType, BeliefModifiers.ModifierId, EffectType, CollectionType
	from Beliefs join BeliefModifiers 
	on  Beliefs.BeliefType = BeliefModifiers.BeliefType 
	join Modifiers
	on BeliefModifiers.ModifierId = Modifiers.ModifierId
	join DynamicModifiers
	on DynamicModifiers.ModifierType = Modifiers.ModifierType
	where Beliefs.BeliefClassType = 'BELIEF_CLASS_PANTHEON';

insert or ignore into Types(Type,		Kind)
select 'NEA_OWNER_'||EffectType, 'KIND_MODIFIER'
from PantheonAnalysis where CollectionType = 'COLLECTION_ALL_PLAYERS';

insert or ignore into DynamicModifiers
	(ModifierType,		CollectionType,		EffectType)
select 'NEA_OWNER_'||EffectType, 'COLLECTION_OWNER', EffectType
from PantheonAnalysis where CollectionType = 'COLLECTION_ALL_PLAYERS';

update PantheonAnalysis set ModifierType = 'NEA_OWNER_'||EffectType where CollectionType = 'COLLECTION_ALL_PLAYERS';

insert or ignore into Types(Type,		Kind)
select 'NEA_PLAYER_CITIES_'||EffectType, 'KIND_MODIFIER'
from PantheonAnalysis where CollectionType = 'COLLECTION_ALL_CITIES';

insert or ignore into DynamicModifiers
	(ModifierType,		CollectionType,		EffectType)
select 'NEA_PLAYER_CITIES_'||EffectType, 'COLLECTION_PLAYER_CITIES', EffectType
from PantheonAnalysis where CollectionType = 'COLLECTION_ALL_CITIES';

update PantheonAnalysis set ModifierType = 'NEA_PLAYER_CITIES_'||EffectType where CollectionType = 'COLLECTION_ALL_CITIES';


insert or ignore into Types(Type,		Kind)
select 'NEA_PLAYER_DISTRICTS_'||EffectType, 'KIND_MODIFIER'
from PantheonAnalysis where CollectionType = 'COLLECTION_ALL_DISTRICTS';

insert or ignore into DynamicModifiers
	(ModifierType,		CollectionType,		EffectType)
select 'NEA_PLAYER_DISTRICTS_'||EffectType, 'COLLECTION_PLAYER_DISTRICTS', EffectType
from PantheonAnalysis where CollectionType = 'COLLECTION_ALL_DISTRICTS';

update PantheonAnalysis set ModifierType = 'NEA_PLAYER_DISTRICTS_'||EffectType where CollectionType = 'COLLECTION_ALL_DISTRICTS';



insert or replace into Modifiers(ModifierId, ModifierType) select
	'FREE_'||ModifierId, ModifierType
	from PantheonAnalysis;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'FREE_'||PantheonAnalysis.ModifierId, Name, Value
	from PantheonAnalysis join ModifierArguments
	on PantheonAnalysis.ModifierId = ModifierArguments.ModifierId;







-- insert or replace into ModifierArguments(ModifierId, Name, Value) select
-- 	'FREE_'||ModifierId, Name, Value
-- 	from ModifierArguments where ModifierId in 
-- 	(select ModifierId from BeliefModifiers a union Beliefs b 
-- 		on a.BeliefType = b.BeliefType 
-- 		where BeliefClassType = 'BELIEF_CLASS_PANTHEON');


