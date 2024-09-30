

-- 食物和矿物改良 REQ
INSERT OR IGNORE INTO Vocabularies
		(Vocabulary)
VALUES	('IMPROVEMENT_CLASS');

INSERT OR IGNORE INTO Tags
		(Tag,						Vocabulary)
VALUES	('CLASS_FOOD_IMPROVEMENT',			'IMPROVEMENT_CLASS'),
		('CLASS_MINE_IMPROVEMENT',			'IMPROVEMENT_CLASS'),
		('CLASS_BARRACK_FARM_IMPROVEMENT',	'IMPROVEMENT_CLASS'),
		('CLASS_STABLED_CAMP_IMPROVEMENT',	'IMPROVEMENT_CLASS'),
		('CLASS_FORT_IMPROVEMENT',			'IMPROVEMENT_CLASS'),

		('CLASS_MAKE_WINE_IMPROVEMENT', 	  'IMPROVEMENT_CLASS');


INSERT OR IGNORE INTO TypeTags
		(Tag,						Type)
VALUES	
		('CLASS_BARRACK_FARM_IMPROVEMENT',	'IMPROVEMENT_FARM'),
		('CLASS_BARRACK_FARM_IMPROVEMENT',	'IMPROVEMENT_PLANTATION'),
		('CLASS_STABLED_CAMP_IMPROVEMENT',	'IMPROVEMENT_CAMP'),
		('CLASS_STABLED_CAMP_IMPROVEMENT',	'IMPROVEMENT_PASTURE'),

		('CLASS_FORT_IMPROVEMENT',	'IMPROVEMENT_MAORI_PA'),
		('CLASS_FORT_IMPROVEMENT',	'IMPROVEMENT_GREAT_WALL'),
		('CLASS_FORT_IMPROVEMENT',	'IMPROVEMENT_ROMAN_FORT'),
		('CLASS_FORT_IMPROVEMENT',	'IMPROVEMENT_FORT'),

		('CLASS_FOOD_IMPROVEMENT',	'IMPROVEMENT_FARM'),
		('CLASS_FOOD_IMPROVEMENT',	'IMPROVEMENT_PLANTATION'),
		('CLASS_FOOD_IMPROVEMENT',	'IMPROVEMENT_PASTURE'),
		('CLASS_FOOD_IMPROVEMENT',	'IMPROVEMENT_CAMP'),
		('CLASS_FOOD_IMPROVEMENT',	'IMPROVEMENT_FISHING_BOATS'),
		('CLASS_MINE_IMPROVEMENT',	'IMPROVEMENT_LUMBER_MILL'),		
		('CLASS_MINE_IMPROVEMENT',	'IMPROVEMENT_QUARRY'),
		('CLASS_MINE_IMPROVEMENT',	'IMPROVEMENT_MINE'),
		('CLASS_MAKE_WINE_IMPROVEMENT',	'IMPROVEMENT_FARM'),
		('CLASS_MAKE_WINE_IMPROVEMENT',	'IMPROVEMENT_PLANTATION');

insert or replace into Requirements (RequirementId, RequirementType)
values 	
		('REQ_PLOT_HAS_MINE_IMPROVEMENT',		          'REQUIREMENT_PLOT_IMPROVEMENT_TAG_MATCHES'),
	   	('REQ_PLOT_HAS_FOOD_IMPROVEMENT',		          'REQUIREMENT_PLOT_IMPROVEMENT_TAG_MATCHES'),
	   	('REQ_PLOT_HAS_FORT_IMPROVEMENT',		          'REQUIREMENT_PLOT_IMPROVEMENT_TAG_MATCHES'),
		('REQ_PLOT_HAS_BARRACK_FARM_IMPROVEMENT',		          'REQUIREMENT_PLOT_IMPROVEMENT_TAG_MATCHES'),
	   	('REQ_PLOT_HAS_STABLED_CAMP_IMPROVEMENT',		          'REQUIREMENT_PLOT_IMPROVEMENT_TAG_MATCHES'),
	  	   	
	   	('REQ_PLOT_HAS_MAKE_WINE_IMPROVEMENT',		      'REQUIREMENT_PLOT_IMPROVEMENT_TAG_MATCHES');
	   	
insert or replace into RequirementArguments (RequirementId, Name, Value)
values 	
		('REQ_PLOT_HAS_MINE_IMPROVEMENT',			'Tag', 		'CLASS_MINE_IMPROVEMENT'),
	   	('REQ_PLOT_HAS_FOOD_IMPROVEMENT',			'Tag', 		'CLASS_FOOD_IMPROVEMENT'),
	   	('REQ_PLOT_HAS_FORT_IMPROVEMENT',			'Tag', 		'CLASS_FORT_IMPROVEMENT'),
	   	
		('REQ_PLOT_HAS_BARRACK_FARM_IMPROVEMENT',			'Tag', 		'CLASS_BARRACK_FARM_IMPROVEMENT'),
	   	('REQ_PLOT_HAS_STABLED_CAMP_IMPROVEMENT',			'Tag', 		'CLASS_STABLED_CAMP_IMPROVEMENT'),
	   	
	   	('REQ_PLOT_HAS_MAKE_WINE_IMPROVEMENT',		'Tag', 		'CLASS_MAKE_WINE_IMPROVEMENT');

--单元格有某改良 REQ/RS
insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_HAS_'||ImprovementType,				'REQUIREMENTSET_TEST_ALL'
from Improvements;
                                   

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_HAS_'||ImprovementType,				'REQ_PLOT_HAS_'||ImprovementType
from Improvements;


insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLOT_HAS_'||ImprovementType, 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES'
from Improvements;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_HAS_'||ImprovementType, 'ImprovementType', ImprovementType
from Improvements;

--单元格相邻某改良 REQ/RS
insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_ADJACENT_'||ImprovementType,				'REQUIREMENTSET_TEST_ALL'
from Improvements;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_ADJACENT_'||ImprovementType,				'REQ_ADJACENT_'||ImprovementType
from Improvements;


insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_ADJACENT_'||ImprovementType, 'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES'
from Improvements;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_ADJACENT_'||ImprovementType, 'ImprovementType', ImprovementType
from Improvements;




--单元格有某改良且带资源 RS
insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_HAS_'||ImprovementType||'_WITH_RESOURCE',				'REQUIREMENTSET_TEST_ALL'
from Improvements;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_HAS_'||ImprovementType||'_WITH_RESOURCE',				'REQ_PLOT_HAS_'||ImprovementType
from Improvements;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_HAS_'||ImprovementType||'_WITH_RESOURCE',				'REQ_PLOT_HAS_RESOURCE'
from Improvements;

INSERT OR REPLACE INTO 		Requirements (RequirementId,				   RequirementType, Inverse) VALUES		
('REQ_PLOT_HAS_RESOURCE',                 'REQUIREMENT_PLOT_HAS_ANY_RESOURCE',	0),
('REQ_PLOT_NO_RESOURCE',                 'REQUIREMENT_PLOT_HAS_ANY_RESOURCE',	1);

--有改良 有/无资源 RS

insert or replace into RequirementSets(RequirementSetId, RequirementSetType) values
	('RS_PLOT_HAS_IMPROVED_RESOURCE',			'REQUIREMENTSET_TEST_ALL'),
	('RS_PLOT_HAS_IMPROVED_NO_RESOURCE',		'REQUIREMENTSET_TEST_ALL');

insert or replace into RequirementSetRequirements(RequirementSetId,	RequirementId) values
	('RS_PLOT_HAS_IMPROVED_RESOURCE',		'REQ_PLOT_HAS_IMPROVEMENT'),
	('RS_PLOT_HAS_IMPROVED_RESOURCE',		'REQ_PLOT_HAS_RESOURCE'),
	('RS_PLOT_HAS_IMPROVED_NO_RESOURCE',	'REQ_PLOT_HAS_IMPROVEMENT'),
	('RS_PLOT_HAS_IMPROVED_NO_RESOURCE',	'REQ_PLOT_NO_RESOURCE');

insert or replace into Requirements(RequirementId, RequirementType, Inverse) values
	('REQ_PLOT_HAS_IMPROVEMENT',		'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT', 0),
	('REQ_PLOT_NO_IMPROVEMENT',			'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT', 1);




--单元格有某资源
insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_HAS_'||ResourceType,				'REQUIREMENTSET_TEST_ALL'
from Resources;
                                   

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_HAS_'||ResourceType,				'REQ_PLOT_HAS_'||ResourceType
from Resources;


insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLOT_HAS_'||ResourceType, 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'
from Resources;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_HAS_'||ResourceType, 'ResourceType', ResourceType
from Resources;



--玩家有/无某科技/市政 REQ/RS
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLAYER_HAS_'||TechnologyType, 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'
from Technologies;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLAYER_HAS_'||TechnologyType, 'TechnologyType', TechnologyType
from Technologies;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLAYER_HAS_'||TechnologyType,				'REQUIREMENTSET_TEST_ALL'
from Technologies;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLAYER_HAS_'||TechnologyType,				'REQ_PLAYER_HAS_'||TechnologyType
from Technologies;

insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_PLAYER_NO_'||TechnologyType, 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY', 1
from Technologies;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLAYER_NO_'||TechnologyType, 'TechnologyType', TechnologyType
from Technologies;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLAYER_NO_'||TechnologyType,				'REQUIREMENTSET_TEST_ALL'
from Technologies;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLAYER_NO_'||TechnologyType,				'REQ_PLAYER_NO_'||TechnologyType
from Technologies;


insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLAYER_HAS_'||CivicType, 'REQUIREMENT_PLAYER_HAS_CIVIC'
from Civics;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLAYER_HAS_'||CivicType, 'CivicType', CivicType
from Civics;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLAYER_HAS_'||CivicType,				'REQUIREMENTSET_TEST_ALL'
from Civics;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLAYER_HAS_'||CivicType,				'REQ_PLAYER_HAS_'||CivicType
from Civics;

insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_PLAYER_NO_'||CivicType, 'REQUIREMENT_PLAYER_HAS_CIVIC', 1
from Civics;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLAYER_NO_'||CivicType, 'CivicType', CivicType
from Civics;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLAYER_NO_'||CivicType,				'REQUIREMENTSET_TEST_ALL'
from Civics;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLAYER_NO_'||CivicType,				'REQ_PLAYER_NO_'||CivicType
from Civics;



--城市有某/无区域 REQ/RS
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_CITY_HAS_'||DistrictType, 'REQUIREMENT_CITY_HAS_DISTRICT'
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||DistrictType, 'DistrictType', DistrictType
from Districts;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_'||DistrictType,				'REQUIREMENTSET_TEST_ALL'
from Districts;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_'||DistrictType,				'REQ_CITY_HAS_'||DistrictType
from Districts;

insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_CITY_NO_'||DistrictType, 'REQUIREMENT_CITY_HAS_DISTRICT', 1
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_NO_'||DistrictType, 'DistrictType', DistrictType
from Districts;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_NO_'||DistrictType,				'REQUIREMENTSET_TEST_ALL'
from Districts;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_NO_'||DistrictType,				'REQ_CITY_NO_'||DistrictType
from Districts;


--玩家有某/无区域 REQ/RS
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLAYER_HAS_'||DistrictType, 'REQUIREMENT_PLAYER_HAS_DISTRICT'
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLAYER_HAS_'||DistrictType, 'DistrictType', DistrictType
from Districts;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLAYER_HAS_'||DistrictType,				'REQUIREMENTSET_TEST_ALL'
from Districts;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLAYER_HAS_'||DistrictType,				'REQ_PLAYER_HAS_'||DistrictType
from Districts;

insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_PLAYER_NO_'||DistrictType, 'REQUIREMENT_PLAYER_HAS_DISTRICT', 1
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLAYER_NO_'||DistrictType, 'DistrictType', DistrictType
from Districts;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLAYER_NO_'||DistrictType,				'REQUIREMENTSET_TEST_ALL'
from Districts;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLAYER_NO_'||DistrictType,				'REQ_PLAYER_NO_'||DistrictType
from Districts;



--城市有/无某建筑 REQ/RS
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


insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_CITY_NO_'||BuildingType, 'REQUIREMENT_CITY_HAS_BUILDING', 1
from Buildings;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_NO_'||BuildingType, 'BuildingType', BuildingType
from Buildings;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_NO_'||BuildingType,				'REQUIREMENTSET_TEST_ALL'
from Buildings;                                

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_NO_'||BuildingType,				'REQ_CITY_NO_'||BuildingType
from Buildings;


insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
values	('RS_CITY_HAS_ENCAMPMENT_TIER1',				'REQUIREMENTSET_TEST_ALL');                              

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
values	('RS_CITY_HAS_ENCAMPMENT_TIER1',				'REQ_CITY_HAS_BUILDING_BARRACKS'),  
		('RS_CITY_HAS_ENCAMPMENT_TIER1',				'REQ_CITY_HAS_BUILDING_STABLE');                            

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
values	('RS_CITY_HAS_HOLY_SITE_TIER3',				'REQUIREMENTSET_TEST_ALL');                              

insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId)
select 'RS_CITY_HAS_HOLY_SITE_TIER3', 'REQ_CITY_HAS_'||BuildingType from Buildings where EnabledByReligion = 1;


--玩家有某建筑 REQ/RS
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLAYER_HAS_'||BuildingType, 'REQUIREMENT_PLAYER_HAS_BUILDING'
from Buildings;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLAYER_HAS_'||BuildingType, 'BuildingType', BuildingType
from Buildings;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLAYER_HAS_'||BuildingType,				'REQUIREMENTSET_TEST_ALL'
from Buildings;                                

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLAYER_HAS_'||BuildingType,				'REQ_PLAYER_HAS_'||BuildingType
from Buildings;



--城市有/无X人口 REQ/RS
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_CITY_HAS_'||numbers||'_POPULATION',		'REQUIREMENT_CITY_HAS_X_POPULATION'
from counter where numbers >= 1 and numbers <= 50;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_POPULATION', 'Amount', numbers
from counter where numbers >= 1 and numbers <= 50;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_'||numbers||'_POPULATION',				'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= 1 and numbers <= 50;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_'||numbers||'_POPULATION',				'REQ_CITY_HAS_'||numbers||'_POPULATION'
from counter where numbers >= 1 and numbers <= 50;


insert or replace into Requirements (RequirementId, RequirementType,Inverse)
select 'REQ_CITY_NO_'||(numbers-1)||'_POPULATION',		'REQUIREMENT_CITY_HAS_X_POPULATION', 1
from counter where numbers >= 2 and numbers <= 50;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_NO_'||(numbers-1)||'_POPULATION', 'Amount', numbers
from counter where numbers >= 2 and numbers <= 50;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_NO_'||(numbers-1)||'_POPULATION',				'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= 2 and numbers <= 50;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_NO_'||(numbers-1)||'_POPULATION',				'REQ_CITY_NO_'||(numbers-1)||'_POPULATION'
from counter where numbers >= 2 and numbers <= 50;

--城市宜居度-最少1到20/最多0到19 REQ/RS
/*WITH RECURSIVE
  Indices(i) AS (SELECT 0 UNION ALL SELECT (i + 1) FROM Indices LIMIT 10)
insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_AT_LEAST_'||i||'_AMENITIES', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 0 from Indices
union all
select 'REQ_AT_MOST_'||(i-1)||'_AMENITIES',  'REQUIREMENT_PLOT_PROPERTY_MATCHES', 1 from Indices;

WITH RECURSIVE
  Indices(i) AS (SELECT 0 UNION ALL SELECT (i + 1) FROM Indices LIMIT 10)
insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_AT_LEAST_'||i||'_AMENITIES', 'PropertyName', 'CITY_AMENITY' from Indices
union all
select 'REQ_AT_LEAST_'||i||'_AMENITIES',  'PropertyMinimum', i from Indices
union all
select 'REQ_AT_MOST_'||(i-1)||'_AMENITIES', 'PropertyName', 'CITY_AMENITY' from Indices
union all
select 'REQ_AT_MOST_'||(i-1)||'_AMENITIES',  'PropertyMinimum', i from Indices; */

insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_AT_MOST_'||(numbers-1)||'_AMENITIES', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 1
from counter where numbers >= -15 and numbers <= 20;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_AT_MOST_'||(numbers-1)||'_AMENITIES', 'PropertyMinimum', numbers
from counter where numbers >= -15 and numbers <= 20;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_AT_MOST_'||(numbers-1)||'_AMENITIES', 'PropertyName', 'CITY_AMENITY'
from counter where numbers >= -15 and numbers <= 20;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_AT_MOST_'||(numbers-1)||'_AMENITIES',				'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= -15 and numbers <= 20;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_AT_MOST_'||(numbers-1)||'_AMENITIES',				'REQ_AT_MOST_'||(numbers-1)||'_AMENITIES'
from counter where numbers >= -15 and numbers <= 20;


insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_AT_LEAST_'||numbers||'_AMENITIES', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'
from counter where numbers >= 1 and numbers <= 20;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_AT_LEAST_'||numbers||'_AMENITIES', 'PropertyMinimum', numbers
from counter where numbers >= 1 and numbers <= 20;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_AT_LEAST_'||numbers||'_AMENITIES', 'PropertyName', 'CITY_AMENITY'
from counter where numbers >= 1 and numbers <= 20;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_AT_LEAST_'||numbers||'_AMENITIES',				'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= 1 and numbers <= 20;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_AT_LEAST_'||numbers||'_AMENITIES',				'REQ_AT_LEAST_'||numbers||'_AMENITIES'
from counter where numbers >= 1 and numbers <= 20;


-- 区域有1-20相邻 REQ/RS



insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_CITY_HAS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType,		'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT'
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 20;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType, 'Amount', numbers
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 20;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType, 'YieldType', YieldType
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 20;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType, 'DistrictType', DistrictType
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 20;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_'||numbers||'_ADJACENCY_'||DistrictType,					'REQUIREMENTSET_TEST_ANY'
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 20;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_'||numbers||'_ADJACENCY_'||DistrictType,				'REQ_CITY_HAS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 20;

-- insert or ignore into RequirementSets
--     (RequirementSetId,                                  RequirementSetType)
-- select	'RS_CITY_HAS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType,					'REQUIREMENTSET_TEST_ANY'
-- from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 20;

-- insert or ignore into RequirementSetRequirements
--     (RequirementSetId,                                  RequirementId)
-- select	'RS_CITY_HAS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType,				'REQ_CITY_HAS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType
-- from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 20;




--单位是某类型 REQ/RS

insert or replace into Requirements (RequirementId, RequirementType)
	select 'REQ_UNIT_IS_'||Tag, 'REQUIREMENT_UNIT_TAG_MATCHES'
from Tags where Vocabulary = 'ABILITY_CLASS';

insert or replace into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_UNIT_IS_'||Tag, 'Tag', Tag
from Tags where Vocabulary = 'ABILITY_CLASS';

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_UNIT_IS_'||Tag,						'REQUIREMENTSET_TEST_ALL'
from Tags where Vocabulary = 'ABILITY_CLASS';
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_UNIT_IS_'||Tag,				'REQ_UNIT_IS_'||Tag
from Tags where Vocabulary = 'ABILITY_CLASS';

--单位属于某时代
insert or replace into Requirements (RequirementId, RequirementType)
	select 'REQ_UNIT_IN_'||EraType, 'REQUIREMENT_UNIT_ERA_TYPE_MATCHES'
from Eras;

insert or replace into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_UNIT_IN_'||EraType, 'EraType', EraType
from Eras;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
	select	'RS_UNIT_IN_'||EraType,						'REQUIREMENTSET_TEST_ALL'
from Eras;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
	select	'RS_UNIT_IN_'||EraType,				'REQ_UNIT_IN_'||EraType
from Eras;



--对象离自己1-10格 REQ/RS

insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_OBJECT_WITHIN_'||numbers||'_TILES', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER'
from counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_OBJECT_WITHIN_'||numbers||'_TILES', 'MinDistance', '0'
from counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_OBJECT_WITHIN_'||numbers||'_TILES', 'MaxDistance', numbers
from counter where numbers >= 1 and numbers <= 10;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_OBJECT_WITHIN_'||numbers||'_TILES',				'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= 1 and numbers <= 10;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_OBJECT_WITHIN_'||numbers||'_TILES',				'REQ_OBJECT_WITHIN_'||numbers||'_TILES'
from counter where numbers >= 1 and numbers <= 10;


--对象离自己严格1-10格 REQ/RS
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_OBJECT_AWAY_'||numbers||'_TILES', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER'
from counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_OBJECT_AWAY_'||numbers||'_TILES', 'MinDistance', numbers
from counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_OBJECT_AWAY_'||numbers||'_TILES', 'MaxDistance', numbers
from counter where numbers >= 1 and numbers <= 10;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_OBJECT_AWAY_'||numbers||'_TILES',				'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= 1 and numbers <= 10;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_OBJECT_AWAY_'||numbers||'_TILES',				'REQ_OBJECT_AWAY_'||numbers||'_TILES'
from counter where numbers >= 1 and numbers <= 10;


--相邻或在同一个格子 REQ/RS
insert or replace into Requirements(RequirementId,	RequirementType,Inverse) values
	('REQ_OBJECT_SAME_OR_ADJACENT',			'REQUIREMENT_PLOT_ADJACENT_TO_OWNER',	0),

	('REQ_OBJECT_SAME_OR_ADJACENT',			'REQUIREMENT_PLOT_ADJACENT_TO_OWNER',	0),
	('REQ_OBJECT_NOT_ADJACENT',				'REQUIREMENT_PLOT_ADJACENT_TO_OWNER',	1);

insert or replace into RequirementArguments(RequirementId,	Name,	Value) values
	('REQ_OBJECT_SAME_OR_ADJACENT',			'MinDistance',	0),
	('REQ_OBJECT_SAME_OR_ADJACENT',			'MaxDistance',	1),
	('REQ_OBJECT_NOT_ADJACENT',			'MinDistance',	1),
	('REQ_OBJECT_NOT_ADJACENT',			'MaxDistance',	1);

insert or replace into RequirementSets(RequirementSetId,	RequirementSetType) values
	('RS_OBJECT_SAME_PLOT',				'REQUIREMENTSET_TEST_ALL'),
	('RS_OBJECT_SAME_OR_ADJACENT',		'REQUIREMENTSET_TEST_ALL');

insert or replace into RequirementSetRequirements(RequirementSetId,	RequirementId) values
	('RS_OBJECT_SAME_PLOT',			'REQ_OBJECT_SAME_OR_ADJACENT'),
	('RS_OBJECT_SAME_PLOT',			'REQ_OBJECT_NOT_ADJACENT'),
	('RS_OBJECT_SAME_OR_ADJACENT',	'REQ_OBJECT_SAME_OR_ADJACENT');


--某格是某地形  REQ/RS

insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLOT_IS_'||TerrainType, 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES'
from Terrains;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_IS_'||TerrainType, 'TerrainType', TerrainType
from Terrains;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_IS_'||TerrainType,						'REQUIREMENTSET_TEST_ALL'
from Terrains;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_IS_'||TerrainType,						'REQ_PLOT_IS_'||TerrainType
from Terrains;


--城市至少有几格某地形  REQ/RS  --警告：这个req很有可能刷新频率低，特别是数全国格子数量的时候

insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_CITY_HAS_'||numbers||'_'||TerrainType, 'REQUIREMENT_COLLECTION_COUNT_ATLEAST'
from Terrains, counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_'||TerrainType, 'CollectionType', 'COLLECTION_CITY_PLOT_YIELDS'
from Terrains, counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_'||TerrainType, 'Count', numbers
from Terrains, counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_'||TerrainType, 'RequirementSetId', 'RS_PLOT_IS_'||TerrainType
from Terrains, counter where numbers >= 1 and numbers <= 10;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_'||numbers||'_'||TerrainType,						'REQUIREMENTSET_TEST_ALL'
from Terrains, counter where numbers >= 1 and numbers <= 10;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_'||numbers||'_'||TerrainType,						'REQ_CITY_HAS_'||numbers||'_'||TerrainType
from Terrains, counter where numbers >= 1 and numbers <= 10;




--某格是某类地形 官方定义了山和五种气候类的地形 实际上我还在地形文件定义了平坦和丘陵类 REQ/RS

insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLOT_IS_'||TerrainClassType, 'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES'
from TerrainClasses;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_IS_'||TerrainClassType, 'TerrainClass', TerrainClassType
from TerrainClasses;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_IS_'||TerrainClassType,						'REQUIREMENTSET_TEST_ALL'
from TerrainClasses;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_IS_'||TerrainClassType,						'REQ_PLOT_IS_'||TerrainClassType
from TerrainClasses;



--某格相邻某地形
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLOT_ADJACENT_'||TerrainType, 'REQUIREMENT_PLOT_ADJACENT_TERRAIN_TYPE_MATCHES'
from Terrains;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_ADJACENT_'||TerrainType, 'TerrainType', TerrainType
from Terrains;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_ADJACENT_'||TerrainType, 'MaxRange', 	1
from Terrains;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_ADJACENT_'||TerrainType,						'REQUIREMENTSET_TEST_ALL'
from Terrains;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_ADJACENT_'||TerrainType,						'REQ_PLOT_ADJACENT_'||TerrainType
from Terrains;


--某格相邻某类地形
insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_ADJACENT_'||TerrainClassType,			'REQUIREMENTSET_TEST_ANY'
from TerrainClass_Terrains;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_ADJACENT_'||TerrainClassType,			'REQ_PLOT_ADJACENT_'||TerrainType
from TerrainClass_Terrains;

--城市至少有几格某类地形  REQ/RS  --警告：这个req很有可能刷新频率低，特别是数全国格子数量的时候

insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_CITY_HAS_'||numbers||'_'||TerrainClassType, 'REQUIREMENT_COLLECTION_COUNT_ATLEAST'
from TerrainClasses, counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_'||TerrainClassType, 'CollectionType', 'COLLECTION_CITY_PLOT_YIELDS'
from TerrainClasses, counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_'||TerrainClassType, 'Count', numbers
from TerrainClasses, counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_'||TerrainClassType, 'RequirementSetId', 'RS_PLOT_IS_'||TerrainClassType
from TerrainClasses, counter where numbers >= 1 and numbers <= 10;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_'||numbers||'_'||TerrainClassType,						'REQUIREMENTSET_TEST_ALL'
from TerrainClasses, counter where numbers >= 1 and numbers <= 10;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_'||numbers||'_'||TerrainClassType,						'REQ_CITY_HAS_'||numbers||'_'||TerrainClassType
from TerrainClasses, counter where numbers >= 1 and numbers <= 10;



--城市有信教/不信教 REQ/RS
INSERT OR REPLACE INTO RequirementSets 				(RequirementSetId ,     RequirementSetType) 	VALUES
('RS_CITY_FOLLOWS_RELIGION' , 			'REQUIREMENTSET_TEST_ALL'),
('RS_CITY_NO_RELIGION' , 		'REQUIREMENTSET_TEST_ALL');

INSERT OR REPLACE INTO RequirementSetRequirements 	(RequirementSetId ,   RequirementId) 			VALUES
('RS_CITY_FOLLOWS_RELIGION' , 'REQ_CITY_FOLLOWS_RELIGION'),
('RS_CITY_NO_RELIGION' , 		  'REQ_CITY_NO_RELIGION');
 
INSERT OR REPLACE INTO 		Requirements (RequirementId,				   RequirementType) VALUES		
('REQ_CITY_FOLLOWS_RELIGION',                      'REQUIREMENT_CITY_FOLLOWS_RELIGION');

INSERT OR REPLACE INTO 		Requirements (RequirementId,				   RequirementType,			             Inverse) VALUES		
('REQ_CITY_NO_RELIGION',                  'REQUIREMENT_CITY_FOLLOWS_RELIGION', 1);

--城市有xx改良资源 REQ/RS
insert or ignore into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_CITY_HAS_IMPROVED_' || ResourceType, 'ResourceType', ResourceType from Resources;

insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_CITY_HAS_IMPROVED_' || ResourceType, 'REQUIREMENT_CITY_HAS_RESOURCE_TYPE_IMPROVED' from Resources;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_IMPROVED_' || ResourceType,						'REQUIREMENTSET_TEST_ALL'
from Resources;        
                           
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_IMPROVED_' || ResourceType,						'REQ_CITY_HAS_IMPROVED_' || ResourceType
from Resources;




--城市有奇观
INSERT OR REPLACE INTO RequirementSets 				(RequirementSetId ,     RequirementSetType) 	VALUES
('RS_CITY_HAS_WONDER' , 		'REQUIREMENTSET_TEST_ALL');

INSERT OR REPLACE INTO RequirementSetRequirements 	(RequirementSetId ,   RequirementId) 			VALUES
('RS_CITY_HAS_WONDER' , 		  'REQ_CITY_HAS_WONDER');
 
INSERT OR REPLACE INTO 		Requirements (RequirementId,				   RequirementType) VALUES		
('REQ_CITY_HAS_WONDER',                 'REQUIREMENT_CITY_HAS_ANY_WONDER');






--文明有xx改良资源 REQ/RS
insert or ignore into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_PLAYER_HAS_IMPROVED_' || ResourceType, 'ResourceType', ResourceType from Resources;

insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_PLAYER_HAS_IMPROVED_' || ResourceType, 'REQUIREMENT_PLAYER_HAS_RESOURCE_IMPROVED' from Resources;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLAYER_HAS_IMPROVED_' || ResourceType,						'REQUIREMENTSET_TEST_ALL'
from Resources;        
                           
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLAYER_HAS_IMPROVED_' || ResourceType,						'REQ_PLAYER_HAS_IMPROVED_' || ResourceType
from Resources;



--单元格魅力值 REQ/RS
insert or ignore into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_PLOT_APPEAL_' || numbers, 'MaximumAppeal', numbers from counter where numbers >= -4 and numbers <= 20;

insert or ignore into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_PLOT_APPEAL_' || numbers, 'MinimumAppeal', numbers from counter where numbers >= -4 and numbers <= 20;

insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_PLOT_APPEAL_' || numbers, 'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN' 
from counter where numbers >= -4 and numbers <= 20;


insert or replace into RequirementArguments(RequirementId,	Name,	Value)
	select 'REQ_PLOT_APPEAL_AT_LEAST_' || numbers, 'MinimumAppeal', numbers from counter where numbers >= -4 and numbers <= 20;

insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_PLOT_APPEAL_AT_LEAST_' || numbers, 'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN' 
from counter where numbers >= -4 and numbers <= 20;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_APPEAL_AT_LEAST_' || numbers,			'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= -4 and numbers <= 20;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_APPEAL_AT_LEAST_' || numbers,			'REQ_PLOT_APPEAL_AT_LEAST_' || numbers
from counter where numbers >= -4 and numbers <= 20;




-- PLOT_ADJACENT_TO_RIVER_REQUIREMENTS

--某格有xx地形/地貌  REQ/RS
insert or ignore into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_IS_' || TerrainType, 'TerrainType', TerrainType from Terrains;

insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_IS_' || TerrainType, 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES' from Terrains;

insert or ignore into RequirementSets (RequirementSetId, RequirementSetType)
	select 'RS_IS_' || TerrainType, 'REQUIREMENTSET_TEST_ALL' from Terrains;
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId)
	select 'RS_IS_' || TerrainType, 'REQ_IS_' || TerrainType from Terrains;



insert or ignore into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_IS_' || FeatureType, 'FeatureType', FeatureType from Features;

insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_IS_' || FeatureType, 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES' from Features;

insert or ignore into RequirementSets (RequirementSetId, RequirementSetType)
	select 'RS_IS_' || FeatureType, 'REQUIREMENTSET_TEST_ALL' from Features;
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId)
	select 'RS_IS_' || FeatureType, 'REQ_IS_' || FeatureType from Features;

--城市拥有某地貌
insert or ignore into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_CITY_HAS_' || FeatureType, 'FeatureType', FeatureType from Features;
insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_CITY_HAS_' || FeatureType, 'REQUIREMENT_CITY_HAS_FEATURE' from Features;

insert or ignore into RequirementSets (RequirementSetId, RequirementSetType)
	select 'RS_CITY_HAS_' || FeatureType, 'REQUIREMENTSET_TEST_ALL' from Features;
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId)
	select 'RS_CITY_HAS_' || FeatureType, 'REQ_CITY_HAS_' || FeatureType from Features;

--城市有自然奇观
insert or ignore into RequirementSets (RequirementSetId, RequirementSetType) values
	('RS_CITY_HAS_NATURAL_WONDER',		'REQUIREMENTSET_TEST_ANY');

insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId)
	select 'RS_CITY_HAS_NATURAL_WONDER', 'REQ_CITY_HAS_' || FeatureType from Features where NaturalWonder = 1;



--水相关 REQ/RS
insert or ignore into RequirementSets 				(RequirementSetId ,     RequirementSetType) 	values
('RS_IS_RIVER' , 									'REQUIREMENTSET_TEST_ALL'),
('RS_RIVER_DISTRICT' , 								'REQUIREMENTSET_TEST_ALL'),
('RS_NEAR_COAST_DISTRICT' , 						'REQUIREMENTSET_TEST_ALL'),
('RS_NEAR_WATER_DISTRICT' , 						'REQUIREMENTSET_TEST_ALL'),
('RS_NOT_WONDER' , 									'REQUIREMENTSET_TEST_ALL'),
('RS_NOT_WONDER_OR_CITY_CENTER' , 					'REQUIREMENTSET_TEST_ALL'),

('RS_IS_FRESH' , 									'REQUIREMENTSET_TEST_ALL'),
('RS_NOT_FRESH' , 									'REQUIREMENTSET_TEST_ALL'),
('RS_IS_COASTAL_LAND' , 							'REQUIREMENTSET_TEST_ALL'),
('RS_NEAR_COAST' , 									'REQUIREMENTSET_TEST_ANY'),
('RS_NO_WATER' , 									'REQUIREMENTSET_TEST_ALL');
--('RS_HAS_WATER' , 									'REQUIREMENTSET_TEST_ALL');



insert or ignore into RequirementSetRequirements 	(RequirementSetId ,   RequirementId) 			values
('RS_IS_RIVER' , 									'REQ_IS_RIVER'),
('RS_RIVER_DISTRICT' , 								'REQ_IS_RIVER'),
('RS_RIVER_DISTRICT' , 								'REQ_NOT_WONDER'),
('RS_NEAR_COAST_DISTRICT' , 						'REQ_NEAR_COAST'),
('RS_NEAR_COAST_DISTRICT' , 						'REQ_NOT_WONDER'),
('RS_NEAR_WATER_DISTRICT' , 						'REQ_PLOT_ADJACENT_TERRAIN_COAST'),
('RS_NEAR_WATER_DISTRICT' , 						'REQ_NOT_WONDER'),
('RS_NOT_WONDER' , 									'REQ_NOT_WONDER'),
('RS_NOT_WONDER_OR_CITY_CENTER' , 					'REQ_NOT_WONDER'),
('RS_NOT_WONDER_OR_CITY_CENTER' , 					'REQ_NOT_CITY_CENTER'),

('RS_IS_FRESH' , 		'REQ_IS_FRESH'),
('RS_NOT_FRESH' , 		'REQ_NOT_FRESH'),
('RS_IS_COASTAL_LAND' , 'REQ_IS_COASTAL_LAND'),
('RS_NEAR_COAST' , 		'REQ_IS_COAST'),
('RS_NEAR_COAST' , 		'REQ_IS_COASTAL_LAND'),
('RS_NO_WATER' , 		'REQ_NOT_FRESH'),
('RS_NO_WATER' , 		'REQ_NOT_COASTAL_LAND'),
('RS_NO_WATER' , 		'REQ_NOT_COAST'),
('RS_NO_WATER' , 		'REQ_NOT_OCEAN');

insert or replace into		Requirements (RequirementId,				   RequirementType, Inverse) values	
('REQ_NOT_CITY_CENTER',               'REQUIREMENT_DISTRICT_TYPE_MATCHES',			1),
('REQ_NOT_WONDER',                    'REQUIREMENT_DISTRICT_TYPE_MATCHES',			1),
('REQ_IS_RIVER',                      'REQUIREMENT_PLOT_ADJACENT_TO_RIVER',			0),
('REQ_NEAR_COAST',                    'REQUIREMENT_REQUIREMENTSET_IS_MET',			0),

('REQ_IS_FRESH',                      'REQUIREMENT_PLOT_IS_FRESH_WATER',			0),
('REQ_NOT_FRESH',                     'REQUIREMENT_PLOT_IS_FRESH_WATER',			1),
('REQ_IS_COAST',                      'REQUIREMENT_PLOT_IS_COAST',						0),
('REQ_IS_COASTAL_LAND',               'REQUIREMENT_PLOT_IS_COASTAL_LAND',			0),
('REQ_NOT_COASTAL_LAND',              'REQUIREMENT_PLOT_IS_COASTAL_LAND',			1),
('REQ_NOT_COAST',              				'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES',	1),
('REQ_NOT_OCEAN',              				'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES',	1);


insert or replace into RequirementArguments (RequirementId, Name, Value) values
('REQ_NOT_WONDER',                      'DistrictType',						'DISTRICT_WONDER'),
('REQ_NOT_CITY_CENTER',                 'DistrictType',						'DISTRICT_CITY_CENTER'),
('REQ_NEAR_COAST',                      'RequirementSetId',					'RS_NEAR_COAST'),

('REQ_NOT_COAST',                      'TerrainType',						'TERRAIN_COAST'),
('REQ_NOT_OCEAN',                      'TerrainType',						'TERRAIN_OCEAN');


--地块有某区域  RS/REQ
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLOT_HAS_'||DistrictType, 'REQUIREMENT_DISTRICT_TYPE_MATCHES'
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_HAS_'||DistrictType, 'DistrictType', DistrictType
from Districts;


insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_HAS_'||DistrictType,				'REQUIREMENTSET_TEST_ALL'
from Districts;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_HAS_'||DistrictType,				'REQ_PLOT_HAS_'||DistrictType
from Districts;



insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLOT_ON_1'||DistrictType, 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES'
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_ON_1'||DistrictType, 'DistrictType', DistrictType
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_ON_1'||DistrictType, 'MaxRange', 1
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_ON_1'||DistrictType, 'MinRange', 0
from Districts;

insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_PLOT_ON_2'||DistrictType, 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES', 1
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_ON_2'||DistrictType, 'DistrictType', DistrictType
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_ON_2'||DistrictType, 'MaxRange', 1
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_ON_2'||DistrictType, 'MinRange', 1
from Districts;


insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_ON_'||DistrictType,				'REQUIREMENTSET_TEST_ALL'
from Districts;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_ON_'||DistrictType,				'REQ_PLOT_ON_1'||DistrictType
from Districts;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_ON_'||DistrictType,				'REQ_PLOT_ON_2'||DistrictType
from Districts;


insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLOT_ON_'||DistrictType, 'REQUIREMENT_REQUIREMENTSET_IS_MET'
from Districts;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_ON_'||DistrictType, 'RequirementSetId', 'RS_PLOT_ON_'||DistrictType
from Districts;

--是水利区域
insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) values
	('RS_IS_WATER_DISTRICT',		'REQUIREMENTSET_TEST_ANY');

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) values
	('RS_IS_WATER_DISTRICT',		'REQ_PLOT_HAS_DISTRICT_AQUEDUCT'),
	('RS_IS_WATER_DISTRICT',		'REQ_PLOT_HAS_DISTRICT_DAM'),
	('RS_IS_WATER_DISTRICT',		'REQ_PLOT_HAS_DISTRICT_CANAL');



--地块工作人口  RS/REQ
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLOT_HAS_'||numbers||'_WORKERS', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'
from counter where numbers >= 0 and numbers <= 20;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_HAS_'||numbers||'_WORKERS', 'PropertyMinimum', numbers
from counter where numbers >= 0 and numbers <= 20;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLOT_HAS_'||numbers||'_WORKERS', 'PropertyName', 'WORKER_COUNT'
from counter where numbers >= 0 and numbers <= 20;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLOT_HAS_'||numbers||'_WORKERS',				'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= 0 and numbers <= 20;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLOT_HAS_'||numbers||'_WORKERS',				'REQ_PLOT_HAS_'||numbers||'_WORKERS'
from counter where numbers >= 0 and numbers <= 20;


insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_'||DistrictType||'_HAS_'||numbers||'_WORKERS',				'REQUIREMENTSET_TEST_ALL'
from counter, Districts where numbers >= 0 and numbers <= 8;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_'||DistrictType||'_HAS_'||numbers||'_WORKERS',				'REQ_PLOT_HAS_'||numbers||'_WORKERS'
from counter, Districts where numbers >= 0 and numbers <= 8;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_'||DistrictType||'_HAS_'||numbers||'_WORKERS',				'REQ_PLOT_HAS_'||DistrictType
from counter, Districts where numbers >= 0 and numbers <= 8;

--区域相邻加成FIX  RS/REQ
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_IS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType||'_FIX',		'REQUIREMENT_PLOT_PROPERTY_MATCHES'
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 30;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_IS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType||'_FIX', 'PropertyName', 'ADJACENCY_'||YieldType
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 30;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_IS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType||'_FIX', 'PropertyMinimum', numbers
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 30;


insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_IS_'||numbers||'_ADJACENCY_'||DistrictType||'_FIX',					'REQUIREMENTSET_TEST_ALL'
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 30;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_IS_'||numbers||'_ADJACENCY_'||DistrictType||'_FIX',				'REQ_IS_'||numbers||'_ADJACENCY_'||YieldType||'_'||DistrictType||'_FIX'
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 30;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_IS_'||numbers||'_ADJACENCY_'||DistrictType||'_FIX',				'REQ_PLOT_HAS_'||DistrictType
from counter CROSS JOIN DA_District_Yields where numbers >= 1 and numbers <= 30;


--城市有几个专业区域  REQ/RS
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_CITY_HAS_'||numbers||'_DISTRICTS', 'REQUIREMENT_CITY_HAS_X_SPECIALTY_DISTRICTS'
from counter where numbers >= 0 and numbers <= 9;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||numbers||'_DISTRICTS', 'Amount', numbers
from counter where numbers >= 0 and numbers <= 9;


insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_'||numbers||'_DISTRICTS',				'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= 0 and numbers <= 9;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_'||numbers||'_DISTRICTS',				'REQ_CITY_HAS_'||numbers||'_DISTRICTS'
from counter where numbers >= 0 and numbers <= 9;

--是/不是专业区域 RS
insert or replace into RequirementSets(RequirementSetId, RequirementSetType) values
('RS_IS_SPECIALITY_DISTRICT',	'REQUIREMENTSET_TEST_ANY'),
('RS_NOT_SPECIALITY_DISTRICT',	'REQUIREMENTSET_TEST_ANY');

insert or replace into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_IS_SPECIALITY_DISTRICT',	'REQ_PLOT_HAS_'||DistrictType
	from Districts where RequiresPopulation = 1 and TraitType is null;

insert or replace into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_NOT_SPECIALITY_DISTRICT',	'REQ_PLOT_HAS_'||DistrictType
	from Districts where RequiresPopulation = 0 and DistrictType != 'DISTRICT_WONDER' and TraitType is null;



--XX政体传承
insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_'||GovernmentType||'_LEGACY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 0
from Governments;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_'||GovernmentType||'_LEGACY', 'PropertyMinimum', 1
from Governments;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_'||GovernmentType||'_LEGACY', 'PropertyName', 'PROP_'||GovernmentType||'_LEGACY'
from Governments;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_'||GovernmentType||'_LEGACY',				'REQUIREMENTSET_TEST_ALL'
from Governments;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_'||GovernmentType||'_LEGACY',				'REQ_'||GovernmentType||'_LEGACY'
from Governments;


--某战略资源缺乏/不缺
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_LACK_'||ResourceType, 	'REQUIREMENT_PLOT_PROPERTY_MATCHES'
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_LACK_'||ResourceType, 'PropertyMinimum', 1
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_LACK_'||ResourceType, 'PropertyName', 'PROP_LACK_'||ResourceType
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or ignore into RequirementSets
    (RequirementSetId,                          RequirementSetType)
select	'RS_LACK_'||ResourceType,				'REQUIREMENTSET_TEST_ALL'
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_LACK_'||ResourceType,				'REQ_LACK_'||ResourceType
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';


insert or replace into Requirements (RequirementId, RequirementType,	Inverse)
select 'REQ_ENOUGH_'||ResourceType, 	'REQUIREMENT_PLOT_PROPERTY_MATCHES',	1
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_ENOUGH_'||ResourceType, 'PropertyMinimum', 1
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_ENOUGH_'||ResourceType, 'PropertyName', 'PROP_LACK_'||ResourceType
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or ignore into RequirementSets
    (RequirementSetId,                          RequirementSetType)
select	'RS_ENOUGH_'||ResourceType,				'REQUIREMENTSET_TEST_ALL'
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_ENOUGH_'||ResourceType,				'REQ_ENOUGH_'||ResourceType
from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

--政体任务
insert or replace into Requirements (RequirementId, RequirementType) values
	('REQ_TRIBE_BONUS_1',	'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
	('REQ_TRIBE_BONUS_2',	'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
	('REQ_CITYSTATE_BONUS_1','REQUIREMENT_PLOT_PROPERTY_MATCHES'),
	('REQ_CITYSTATE_BONUS_2','REQUIREMENT_PLOT_PROPERTY_MATCHES'),
	('REQ_PRIEST_BONUS_1','REQUIREMENT_PLOT_PROPERTY_MATCHES'),
	('REQ_PRIEST_BONUS_2','REQUIREMENT_PLOT_PROPERTY_MATCHES');

insert or replace into RequirementArguments(RequirementId,	Name,	Value) values
	('REQ_TRIBE_BONUS_1',	'PropertyName',				'PROP_TRIBE_BONUS_MILICARD'),
	('REQ_TRIBE_BONUS_1',	'PropertyMinimum',			1),
	('REQ_TRIBE_BONUS_2',	'PropertyName',				'PROP_TRIBE_BONUS_ECOCARD'),
	('REQ_TRIBE_BONUS_2',	'PropertyMinimum',			1),
	('REQ_CITYSTATE_BONUS_1',	'PropertyName',				'PROP_CITYSTATE_BONUS_MILICARD'),
	('REQ_CITYSTATE_BONUS_1',	'PropertyMinimum',			1),
	('REQ_CITYSTATE_BONUS_2',	'PropertyName',				'PROP_CITYSTATE_BONUS_ECOCARD'),
	('REQ_CITYSTATE_BONUS_2',	'PropertyMinimum',			1),
	('REQ_PRIEST_BONUS_1',	'PropertyName',				'PROP_PRIEST_BONUS_MILICARD'),
	('REQ_PRIEST_BONUS_1',	'PropertyMinimum',			1),
	('REQ_PRIEST_BONUS_2',	'PropertyName',				'PROP_PRIEST_BONUS_ECOCARD'),
	('REQ_PRIEST_BONUS_2',	'PropertyMinimum',			1);

insert or replace into RequirementSets(RequirementSetId,	RequirementSetType) values
	('RS_TRIBE_BONUS_1',			'REQUIREMENTSET_TEST_ALL'),
	('RS_TRIBE_BONUS_2',			'REQUIREMENTSET_TEST_ALL'),
	('RS_CITYSTATE_BONUS_1',			'REQUIREMENTSET_TEST_ALL'),
	('RS_CITYSTATE_BONUS_2',			'REQUIREMENTSET_TEST_ALL'),
	('RS_PRIEST_BONUS_1',			'REQUIREMENTSET_TEST_ALL'),
	('RS_PRIEST_BONUS_2',			'REQUIREMENTSET_TEST_ALL');

insert or replace into RequirementSetRequirements(RequirementSetId,		RequirementId) values
	('RS_TRIBE_BONUS_1',	'REQ_TRIBE_BONUS_1'),
	('RS_TRIBE_BONUS_1',	'REQ_CITY_HAS_BUILDING_PALACE'),
	('RS_TRIBE_BONUS_2',	'REQ_TRIBE_BONUS_2'),
	('RS_TRIBE_BONUS_2',	'REQ_CITY_HAS_BUILDING_PALACE'),
	('RS_CITYSTATE_BONUS_1',	'REQ_CITYSTATE_BONUS_1'),
	('RS_CITYSTATE_BONUS_1',	'REQ_CITY_HAS_BUILDING_PALACE'),
	('RS_CITYSTATE_BONUS_2',	'REQ_CITYSTATE_BONUS_2'),
	('RS_CITYSTATE_BONUS_2',	'REQ_CITY_HAS_BUILDING_PALACE'),
	('RS_PRIEST_BONUS_1',	'REQ_PRIEST_BONUS_1'),
	('RS_PRIEST_BONUS_1',	'REQ_CITY_HAS_BUILDING_PALACE'),
	('RS_PRIEST_BONUS_2',	'REQ_PRIEST_BONUS_2'),
	('RS_PRIEST_BONUS_2',	'REQ_CITY_HAS_BUILDING_PALACE');
--玩家有xx trait
insert or ignore into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_PLAYER_IS_' || CivilizationType, 'CivilizationType'	, CivilizationType from Civilizations;
insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_PLAYER_IS_' || CivilizationType, 'REQUIREMENT_PLAYER_TYPE_MATCHES' from Civilizations;
insert or ignore into RequirementSets (RequirementSetId, RequirementSetType)
	select 'RS_PLAYER_IS_' || CivilizationType, 'REQUIREMENTSET_TEST_ANY' from Civilizations;
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId)
	select 'RS_PLAYER_IS_' || CivilizationType, 'REQ_PLAYER_IS_' || CivilizationType from Civilizations;


insert or ignore into RequirementArguments (RequirementId, Name, Value)
	select 'REQ_PLAYER_IS_' || LeaderType, 'LeaderType'	, LeaderType from Leaders;
insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_PLAYER_IS_' || LeaderType, 'REQUIREMENT_PLAYER_TYPE_MATCHES' from Leaders;
insert or ignore into RequirementSets (RequirementSetId, RequirementSetType)
	select 'RS_PLAYER_IS_' || LeaderType, 'REQUIREMENTSET_TEST_ANY' from Leaders;
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId)
	select 'RS_PLAYER_IS_' || LeaderType, 'REQ_PLAYER_IS_' || LeaderType from Leaders;



-- plot_property相关requirements properties  --放到preprocess了
-- create table "PropertyRequirements" (
-- 	"PropertyType" TEXT NOT NULL,
-- 	"Threshold" INTEGER NOT NULL DEFAULT 1,
-- 	"Match" BOOLEAN NOT NULL DEFAULT 0,
-- 	PRIMARY KEY(PropertyType)
-- );	

insert or replace into PropertyRequirements(PropertyType, Threshold, Match) values
	('PROP_CITY_PRODUCTION_TO_FOOD',	2, 0),
	('GARRISON_LEVEL',					7, 1),
	('PROP_CONSECRATION',				1, 1),
	('PROP_INFRASTRUCTURE',				2, 1),
	('PROP_DOMESTIC_INCOMING',			20, 1),
	('PROP_DAM_FOOD',					2, 0),
	('PROP_DAM_PRODUCTION',				2, 0);



insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_'||PropertyType||'_'||numbers, 	'REQUIREMENT_PLOT_PROPERTY_MATCHES'
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_'||PropertyType||'_'||numbers, 'PropertyMinimum', numbers
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_'||PropertyType||'_'||numbers, 'PropertyName', PropertyType
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold;

insert or replace into Requirements (RequirementId, RequirementType, Inverse)
select 'REQ_'||PropertyType||'_NO_'||numbers, 	'REQUIREMENT_PLOT_PROPERTY_MATCHES', 1
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold+1;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_'||PropertyType||'_NO_'||numbers, 'PropertyMinimum', numbers
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold+1;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_'||PropertyType||'_NO_'||numbers, 'PropertyName', PropertyType
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold+1;



insert or ignore into RequirementSets
    (RequirementSetId,                          RequirementSetType)
select	'RS_'||PropertyType||'_'||numbers,	'REQUIREMENTSET_TEST_ALL'
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_'||PropertyType||'_'||numbers,				'REQ_'||PropertyType||'_'||numbers
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold;


insert or ignore into RequirementSets
    (RequirementSetId,                          RequirementSetType)
select	'RS_'||PropertyType||'_IS_'||numbers,	'REQUIREMENTSET_TEST_ALL'
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_'||PropertyType||'_IS_'||numbers,			'REQ_'||PropertyType||'_'||numbers
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_'||PropertyType||'_IS_'||numbers,			'REQ_'||PropertyType||'_NO_'||(numbers+1)
from PropertyRequirements, counter where numbers > 0 and numbers <= Threshold;

--REQ 是某单位
insert or ignore into Requirements (RequirementId, RequirementType)
	select 'REQ_IS_' || UnitType , 'REQUIREMENT_UNIT_TYPE_MATCHES' from Units;
insert or ignore into RequirementArguments (RequirementId, Name, Value) 
	select 'REQ_IS_' || UnitType , 'UnitType', UnitType from Units;

insert or replace into RequirementSets(RequirementSetId, RequirementSetType)
	select 'RS_IS_' || UnitType,	'REQUIREMENTSET_TEST_ANY' from Units;
insert or replace into RequirementSetRequirements(RequirementSetId, RequirementId)
	select 'RS_IS_' || UnitType,	'REQ_IS_' || UnitType from Units;


--UNIT_IS_RELIGIOUS_ALL  来自hd 用于单位训练判定
insert or ignore into RequirementSetRequirements 
	(RequirementSetId,				RequirementId)	
values
	--('RS_UNIT_IS_LAND_COMBAT',			'REQ_UNIT_IS_LAND_COMBAT'),
	('RS_UNIT_IS_RELIGOUS_ALL',			'REQ_IS_UNIT_MISSIONARY'),
	('RS_UNIT_IS_RELIGOUS_ALL',			'REQ_IS_UNIT_APOSTLE'),
	('RS_UNIT_IS_RELIGOUS_ALL',			'REQ_IS_UNIT_INQUISITOR'),
	('RS_UNIT_IS_RELIGOUS_ALL',			'REQ_IS_UNIT_GURU'),
	('RS_UNIT_IS_RELIGOUS_ALL_AND_MONK','REQ_IS_UNIT_MISSIONARY'),
	('RS_UNIT_IS_RELIGOUS_ALL_AND_MONK','REQ_IS_UNIT_APOSTLE'),
	('RS_UNIT_IS_RELIGOUS_ALL_AND_MONK','REQ_IS_UNIT_INQUISITOR'),
	('RS_UNIT_IS_RELIGOUS_ALL_AND_MONK','REQ_IS_UNIT_GURU'),
	('RS_UNIT_IS_RELIGOUS_ALL_AND_MONK','REQ_IS_UNIT_WARRIOR_MONK');

insert or ignore into RequirementSets (RequirementSetId,	RequirementSetType)	values
	--('RS_UNIT_IS_LAND_COMBAT',			'REQUIREMENTSET_TEST_ALL'),
	('RS_UNIT_IS_RELIGOUS_ALL_AND_MONK','REQUIREMENTSET_TEST_ANY'),
	('RS_UNIT_IS_RELIGOUS_ALL',			'REQUIREMENTSET_TEST_ANY');

-- insert or ignore into Requirements (RequirementId, RequirementType) values 
-- 	('REQ_UNIT_IS_LAND_COMBAT', 'REQUIREMENT_UNIT_TAG_MATCHES');
-- insert or ignore into RequirementArguments (RequirementId, Name, Value) values
-- 	('REQ_UNIT_IS_LAND_COMBAT', 'Tag', 'CLASS_LAND_COMBAT');

--单位 tag req/rs
insert or ignore into Requirements(RequirementId, RequirementType) select
	'REQ_IS_'||Tag, 'REQUIREMENT_UNIT_TAG_MATCHES'
	from Tags where Vocabulary = 'ABILITY_CLASS';

insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_IS_'||Tag, 'Tag', Tag
	from Tags where Vocabulary = 'ABILITY_CLASS';

insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_IS_'||Tag,	'REQUIREMENTSET_TEST_ALL'
	from Tags where Vocabulary = 'ABILITY_CLASS';

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_IS_'||Tag,	'REQ_IS_'||Tag
	from Tags where Vocabulary = 'ABILITY_CLASS';


--单位 晋升类型 req/rs
insert or ignore into Requirements(RequirementId, RequirementType) select
	'REQ_IS_'||PromotionClassType, 'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES'
	from UnitPromotionClasses;

insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_IS_'||PromotionClassType, 'UnitPromotionClass', PromotionClassType
	from UnitPromotionClasses;

insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_IS_'||PromotionClassType,	'REQUIREMENTSET_TEST_ALL'
	from UnitPromotionClasses;

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_IS_'||PromotionClassType,	'REQ_IS_'||PromotionClassType
	from UnitPromotionClasses;



--城市有某总督升级 req/rs
insert or ignore into Requirements(RequirementId, RequirementType) select
	'REQ_'||GovernorPromotionType, 'REQUIREMENT_CITY_HAS_SPECIFIC_GOVERNOR_PROMOTION_TYPE'
	from GovernorPromotions;

insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_'||GovernorPromotionType, 'GovernorPromotionType', GovernorPromotionType
	from GovernorPromotions;

insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_'||GovernorPromotionType,	'REQUIREMENTSET_TEST_ALL'
	from GovernorPromotions;

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GovernorPromotionType,	'REQ_'||GovernorPromotionType
	from GovernorPromotions;

--总督有x头衔 req/rs
insert or ignore into Requirements(RequirementId, RequirementType) select
	'REQ_'||numbers||'_GOVERNOR_TITLES', 'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES'
	from counter where numbers > 0 and numbers < 9;

insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_'||numbers||'_GOVERNOR_TITLES', 'Amount', numbers
	from counter where numbers > 0 and numbers < 9;

insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_'||numbers||'_GOVERNOR_TITLES', 'Established', 1
	from counter where numbers > 0 and numbers < 9;

insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_'||numbers||'_GOVERNOR_TITLES',	'REQUIREMENTSET_TEST_ALL'
	from counter where numbers > 0 and numbers < 9;

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||numbers||'_GOVERNOR_TITLES',	'REQ_'||numbers||'_GOVERNOR_TITLES'
	from counter where numbers > 0 and numbers < 9;



