

update Buildings set Description = 'LOC_'||BuildingType||'_DESCRIPTION' where BuildingType in
    ('BUILDING_GRANARY', 'BUILDING_AMPHITHEATER', 'BUILDING_MONUMENT', 'BUILDING_LIBRARY', 'BUILDING_UNIVERSITY', 'BUILDING_RESEARCH_LAB', 'BUILDING_ARENA',
        'BUILDING_WORKSHOP', 'BUILDING_FACTORY', 'BUILDING_POWER_PLANT');





insert or replace into Types
    (Type,                                      Kind)
values
    ('BUILDING_FLAG_ONE_DISTRICT',             'KIND_BUILDING'),
    ('BUILDING_FLAG_TWO_DISTRICT',             'KIND_BUILDING'),
    ('BUILDING_FLAG_THREE_DISTRICT',           'KIND_BUILDING'),

    ('BUILDING_FORGING',                       'KIND_BUILDING'),
    ('BUILDING_MASON',                         'KIND_BUILDING'),
    ('BUILDING_OBSERVATORY',                   'KIND_BUILDING'),
    ('BUILDING_TRIUMPHAL',                     'KIND_BUILDING'),

    ('BUILDING_TINGTAI',                       'KIND_BUILDING'),
    ('BUILDING_PAPER_MAKER',                   'KIND_BUILDING'),
    ('BUILDING_ZHISUO',                        'KIND_BUILDING'),

    --JNR
    ('BUILDING_JNR_ACADEMY',                   'KIND_BUILDING'),
    ('BUILDING_JNR_SCHOOL',                    'KIND_BUILDING'),
    ('BUILDING_JNR_IZ_WATER_MILL',             'KIND_BUILDING'),
    ('BUILDING_JNR_WIND_MILL',                 'KIND_BUILDING'),
    ('BUILDING_FLAG_JNR_WIND_MILL',            'KIND_BUILDING');


insert or replace into Buildings
    (BuildingType,                      Name,                                       Cost,   Maintenance,    Description,                                        
        PrereqTech,                     PrereqCivic,                                PrereqDistrict,         PurchaseYield,          Housing) 
values
    ('BUILDING_FLAG_ONE_DISTRICT',     'LOC_BUILDING_FLAG_ONE_DISTRICT_NAME',       0,      0,              'LOC_BUILDING_FLAG_ONE_DISTRICT_DESCRIPTION',                
    null,                               null,                                       NULL,   null,                   null),
    ('BUILDING_FLAG_TWO_DISTRICT',     'LOC_BUILDING_FLAG_TWO_DISTRICT_NAME',       0,      0,              'LOC_BUILDING_FLAG_TWO_DISTRICT_DESCRIPTION',                
    null,                               null,                                       NULL,   null,                   null),
    ('BUILDING_FLAG_THREE_DISTRICT',    'LOC_BUILDING_FLAG_THREE_DISTRICT_NAME',    0,      0,              'LOC_BUILDING_FLAG_THREE_DISTRICT_DESCRIPTION',                
    null,                               null,                                       NULL,   null,                   null), 
    ('BUILDING_FORGING',                'LOC_BUILDING_FORGING_NAME',                125,    5,              'LOC_BUILDING_FORGING_DESCRIPTION',                
    'TECH_IRON_WORKING',                null,                                        'DISTRICT_CITY_CENTER', 'YIELD_GOLD',          null),
    ('BUILDING_MASON',                  'LOC_BUILDING_MASON_NAME',                  70,     2,              'LOC_BUILDING_MASON_DESCRIPTION',                
    'TECH_MINING',                      null,                                       'DISTRICT_CITY_CENTER', 'YIELD_GOLD',           null),
    ('BUILDING_OBSERVATORY',            'LOC_BUILDING_OBSERVATORY_NAME',            80,     3,              'LOC_BUILDING_OBSERVATORY_DESCRIPTION',                
    'TECH_ASTROLOGY',                   null,                                       'DISTRICT_CITY_CENTER', 'YIELD_GOLD',           null),
    ('BUILDING_TRIUMPHAL',              'LOC_BUILDING_TRIUMPHAL_NAME',              80,     3,              'LOC_BUILDING_TRIUMPHAL_DESCRIPTION',                
    NULL,                               'CIVIC_MILITARY_TRADITION',                 'DISTRICT_CITY_CENTER', 'YIELD_GOLD',           null),
    ('BUILDING_PAPER_MAKER',            'LOC_BUILDING_PAPER_MAKER_NAME',            125,    5,              'LOC_BUILDING_PAPER_MAKER_DESCRIPTION',                
    'TECH_PAPER_MAKING_DA',             null,                                     'DISTRICT_CITY_CENTER', 'YIELD_GOLD',           null),
    ('BUILDING_TINGTAI',                'LOC_BUILDING_TINGTAI_NAME',                125,    5,              'LOC_BUILDING_TINGTAI_DESCRIPTION',                
    'TECH_CONSTRUCTION',                null,                                     'DISTRICT_CITY_CENTER', 'YIELD_GOLD',           null),

    ('BUILDING_ZHISUO',                 'LOC_BUILDING_ZHISUO_NAME',                 300,    8,              'LOC_BUILDING_ZHISUO_DESCRIPTION',                
    null,                               'CIVIC_CIVIL_SERVICE',                      'DISTRICT_CITY_CENTER', 'YIELD_GOLD',           1),

    --JNR
    ('BUILDING_JNR_ACADEMY',            'LOC_BUILDING_JNR_ACADEMY_NAME',            100,    4,              'LOC_BUILDING_JNR_ACADEMY_DESCRIPTION',                
    'TECH_WRITING',                      null,                                      'DISTRICT_CAMPUS',             'YIELD_GOLD',           null),
    ('BUILDING_JNR_SCHOOL',             'LOC_BUILDING_JNR_SCHOOL_NAME',             400,    10,              'LOC_BUILDING_JNR_SCHOOL_DESCRIPTION',                
    null,                               'CIVIC_GUILDS',                             'DISTRICT_CAMPUS',             'YIELD_GOLD',           1),
    ('BUILDING_JNR_IZ_WATER_MILL',      'LOC_BUILDING_JNR_IZ_WATER_MILL_NAME',      150,    6,              'LOC_BUILDING_JNR_IZ_WATER_MILL_DESCRIPTION',                
    'TECH_ENGINEERING',                  null,                                      'DISTRICT_INDUSTRIAL_ZONE',    'YIELD_GOLD',           null),    
    ('BUILDING_JNR_WIND_MILL',          'LOC_BUILDING_JNR_WIND_MILL_NAME',          150,    6,              'LOC_BUILDING_JNR_WIND_MILL_DESCRIPTION',                
    null,                 null,                                      'DISTRICT_INDUSTRIAL_ZONE',    'YIELD_GOLD',           null),
    ('BUILDING_FLAG_JNR_WIND_MILL',     'LOC_BUILDING_JNR_WIND_MILL_NAME',          0,    0,              'LOC_BUILDING_JNR_WIND_MILL_DESCRIPTION',                
    NULL,                 null,                                      'DISTRICT_INDUSTRIAL_ZONE',    null,           null);

update Buildings set RequiresAdjacentRiver = 0 where BuildingType = 'BUILDING_WATER_MILL';

update Buildings set Entertainment = 1 where BuildingType = 'BUILDING_TRIUMPHAL';
update Buildings set Entertainment = 2 where BuildingType = 'BUILDING_TINGTAI';
update Buildings set PrereqTech = 'TECH_SAILING' where BuildingType = 'BUILDING_LIGHTHOUSE';

update Buildings set MustPurchase = 1 ,InternalOnly = 0 
    where BuildingType in ('BUILDING_FLAG_ONE_DISTRICT', 'BUILDING_FLAG_TWO_DISTRICT', 'BUILDING_FLAG_THREE_DISTRICT', 'BUILDING_FLAG_JNR_WIND_MILL');


insert or replace into BuildingPrereqs(Building,    PrereqBuilding) values

    ('BUILDING_OBSERVATORY',            'BUILDING_FLAG_ONE_DISTRICT'),
    ('BUILDING_WATER_MILL',             'BUILDING_FLAG_ONE_DISTRICT'),
    ('BUILDING_TRIUMPHAL',              'BUILDING_FLAG_ONE_DISTRICT'),

    ('BUILDING_FORGING',                'BUILDING_FLAG_TWO_DISTRICT'),
    ('BUILDING_PAPER_MAKER',            'BUILDING_FLAG_TWO_DISTRICT'),
    ('BUILDING_TINGTAI',                'BUILDING_FLAG_TWO_DISTRICT'),

    ('BUILDING_ZHISUO',                 'BUILDING_FLAG_THREE_DISTRICT'),

    ('BUILDING_JNR_SCHOOL',             'BUILDING_LIBRARY'),
    ('BUILDING_JNR_SCHOOL',             'BUILDING_JNR_ACADEMY'),
    ('BUILDING_UNIVERSITY',             'BUILDING_JNR_ACADEMY'),
    ('BUILDING_RESEARCH_LAB',           'BUILDING_JNR_SCHOOL'),

    ('BUILDING_WORKSHOP',               'BUILDING_JNR_IZ_WATER_MILL'),
    ('BUILDING_WORKSHOP',               'BUILDING_JNR_WIND_MILL');


   
insert or replace into MutuallyExclusiveBuildings(Building, MutuallyExclusiveBuilding) VALUES
    ('BUILDING_LIBRARY',                'BUILDING_JNR_ACADEMY'),
    ('BUILDING_JNR_ACADEMY',            'BUILDING_LIBRARY'),
    ('BUILDING_JNR_SCHOOL',             'BUILDING_UNIVERSITY'),
    ('BUILDING_UNIVERSITY',             'BUILDING_JNR_SCHOOL'),
    ('BUILDING_JNR_IZ_WATER_MILL',      'BUILDING_JNR_WIND_MILL'),
    ('BUILDING_JNR_WIND_MILL',          'BUILDING_JNR_IZ_WATER_MILL');


-- Uniques
insert or replace into MutuallyExclusiveBuildings
        (Building,                          MutuallyExclusiveBuilding)
select  CivUniqueBuildingType,              'BUILDING_JNR_ACADEMY'
from    BuildingReplaces    where   ReplacesBuildingType='BUILDING_LIBRARY';

insert or replace into MutuallyExclusiveBuildings
        (Building,                          MutuallyExclusiveBuilding)
select  CivUniqueBuildingType,              'BUILDING_JNR_SCHOOL'
from    BuildingReplaces    where   ReplacesBuildingType='BUILDING_UNIVERSITY';

insert or replace into MutuallyExclusiveBuildings
        (Building,                          MutuallyExclusiveBuilding)
select  CivUniqueBuildingType,              'BUILDING_JNR_WIND_MILL'
from    BuildingReplaces    where   ReplacesBuildingType='BUILDING_JNR_IZ_WATER_MILL';

insert or replace into MutuallyExclusiveBuildings
        (Building,                          MutuallyExclusiveBuilding)
select  CivUniqueBuildingType,              'BUILDING_JNR_IZ_WATER_MILL'
from    BuildingReplaces    where   ReplacesBuildingType='BUILDING_JNR_WIND_MILL';

insert or replace into DistrictModifiers(DistrictType,  ModifierId) values
    ('DISTRICT_CITY_CENTER',        'ONE_DISTRICT_GRANT_FLAG'),
    ('DISTRICT_CITY_CENTER',        'TWO_DISTRICT_GRANT_FLAG'),
    ('DISTRICT_CITY_CENTER',        'THREE_DISTRICT_GRANT_FLAG');

insert or replace into Modifiers(ModifierId,    ModifierType,   SubjectRequirementSetId) values
    ('ONE_DISTRICT_GRANT_FLAG',         'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',   'RS_CITY_HAS_1_DISTRICTS'),
    ('TWO_DISTRICT_GRANT_FLAG',         'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',   'RS_CITY_HAS_2_DISTRICTS'),
    ('THREE_DISTRICT_GRANT_FLAG',       'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',   'RS_CITY_HAS_3_DISTRICTS');

insert or replace into ModifierArguments(ModifierId,    Name,   Value) values
    ('ONE_DISTRICT_GRANT_FLAG',     'BuildingType',     'BUILDING_FLAG_ONE_DISTRICT'),
    ('TWO_DISTRICT_GRANT_FLAG',     'BuildingType',     'BUILDING_FLAG_TWO_DISTRICT'),
    ('THREE_DISTRICT_GRANT_FLAG',   'BuildingType',     'BUILDING_FLAG_THREE_DISTRICT');

--在百科中屏蔽
insert or replace into CivilopediaPageExcludes(SectionId,   PageId) values
('BUILDINGS',  'BUILDING_FLAG_ONE_DISTRICT'),
('BUILDINGS',  'BUILDING_FLAG_TWO_DISTRICT'),
('BUILDINGS',  'BUILDING_FLAG_THREE_DISTRICT'),
('BUILDINGS',  'BUILDING_FLAG_JNR_WIND_MILL');

-- insert or replace into BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) values
--     ('BUILDING_JNR_WIND_MILL',      'BUILDING_FLAG_JNR_WIND_MILL');


delete from Building_CitizenYieldChanges
    where BuildingType in ('BUILDING_LIBRARY','BUILDING_AMPHITHEATER','BUILDING_SHRINE','BUILDING_TEMPLE','BUILDING_LIGHTHOUSE','BUILDING_BARRACKS','BUILDING_MARKET',
        'BUILDING_UNIVERSITY', 'BUILDING_RESEARCH_LAB', 'BUILDING_FACTORY', 'BUILDING_WORKSHOP', 'BUILDING_FOSSIL_FUEL_POWER_PLANT', 'BUILDING_POWER_PLANT', 'BUILDING_COAL_POWER_PLANT');
insert or replace into Building_CitizenYieldChanges
    (BuildingType,                          YieldType,          YieldChange)
values
    ('BUILDING_TEMPLE',                     'YIELD_FAITH',      4),
    ('BUILDING_TEMPLE',                     'YIELD_FOOD',       -1),

    ('BUILDING_UNIVERSITY',                 'YIELD_SCIENCE',    2),
    ('BUILDING_UNIVERSITY',                 'YIELD_FOOD',       -1),
    ('BUILDING_JNR_SCHOOL',                 'YIELD_SCIENCE',    2),
    ('BUILDING_JNR_SCHOOL',                 'YIELD_FOOD',       -1),
    ('BUILDING_RESEARCH_LAB',               'YIELD_SCIENCE',    4),
    ('BUILDING_RESEARCH_LAB',               'YIELD_FOOD',       -2),

    ('BUILDING_FACTORY',                    'YIELD_FOOD',       -2),
    ('BUILDING_FACTORY',                    'YIELD_PRODUCTION', 4);




--注意  未来可能会需要有建筑的大音乐家大艺术家点
--delete from Building_GreatPersonPoints;

update Buildings set CitizenSlots = 0
where BuildingType in ('BUILDING_TEMPLE');

update Buildings set CitizenSlots = 1
where BuildingType in ('BUILDING_WORKSHOP', 'BUILDING_JNR_IZ_WATER_MILL', 'BUILDING_JNR_WIND_MILL', 'BUILDING_JNR_ACADEMY');

update Buildings set Entertainment = 0, CitizenSlots = 1
where BuildingType = 'BUILDING_ARENA';

update Buildings set Housing = 1
where BuildingType = 'BUILDING_GRANARY'  or BuildingType = 'BUILDING_WATER_MILL';

update Buildings set Housing = 0
where BuildingType = 'BUILDING_UNIVERSITY';

update Buildings set  CitizenSlots = 2
where BuildingType in ('BUILDING_RESEARCH_LAB', 'BUILDING_COAL_POWER_PLANT', 'BUILDING_FOSSIL_FUEL_POWER_PLANT');

update Buildings set  CitizenSlots = 3
where BuildingType = 'BUILDING_POWER_PLANT';

delete from Building_YieldChanges 
    where BuildingType in ('BUILDING_PALACE','BUILDING_MONUMENT','BUILDING_SHRINE','BUILDING_TEMPLE','BUILDING_LIBRARY','BUILDING_AMPHITHEATER','BUILDING_LIGHTHOUSE',
        'BUILDING_BARRACKS','BUILDING_STABLE','BUILDING_MARKET','BUILDING_GRANARY','BUILDING_WATER_MILL','BUILDING_ARENA',
        'BUILDING_UNIVERSITY', 'BUILDING_RESEARCH_LAB');

insert or replace into Building_YieldChanges
    (BuildingType,                  YieldType,              YieldChange)
values
    -- City Center
    ('BUILDING_PALACE',             'YIELD_FOOD',           1),
    ('BUILDING_PALACE',             'YIELD_PRODUCTION',     3),
    ('BUILDING_PALACE',             'YIELD_SCIENCE',        2),
    ('BUILDING_PALACE',             'YIELD_CULTURE',        2),
    ('BUILDING_PALACE',             'YIELD_GOLD',           7),

    ('BUILDING_MONUMENT',           'YIELD_CULTURE',        2),
    ('BUILDING_OBSERVATORY',        'YIELD_SCIENCE',        2),
    ('BUILDING_TRIUMPHAL',          'YIELD_CULTURE',        1),

    ('BUILDING_GRANARY',            'YIELD_FOOD',           1),
    ('BUILDING_MASON',              'YIELD_PRODUCTION',     1),
    ('BUILDING_FORGING',            'YIELD_PRODUCTION',     2),

    ('BUILDING_WATER_MILL',         'YIELD_FOOD',           1),
    ('BUILDING_WATER_MILL',         'YIELD_PRODUCTION',     1),
   
    ('BUILDING_PAPER_MAKER',        'YIELD_SCIENCE',        1),
    ('BUILDING_PAPER_MAKER',        'YIELD_CULTURE',        1),

    ('BUILDING_TINGTAI',            'YIELD_CULTURE',        1),
    ('BUILDING_TINGTAI',            'YIELD_SCIENCE',        1),

    ('BUILDING_ZHISUO',             'YIELD_CULTURE',        4),

    ('BUILDING_BARRACKS',           'YIELD_PRODUCTION',     1),
    ('BUILDING_STABLE',             'YIELD_FOOD',           1),

    ('BUILDING_SHRINE',             'YIELD_FAITH',          4),
    ('BUILDING_TEMPLE',             'YIELD_FAITH',          4),

    ('BUILDING_LIBRARY',            'YIELD_SCIENCE',        2),
    ('BUILDING_JNR_ACADEMY',        'YIELD_SCIENCE',        2),
    ('BUILDING_UNIVERSITY',         'YIELD_SCIENCE',        5),
    ('BUILDING_JNR_SCHOOL',         'YIELD_SCIENCE',        5),
    ('BUILDING_RESEARCH_LAB',       'YIELD_SCIENCE',        8),

    ('BUILDING_JNR_IZ_WATER_MILL',  'YIELD_PRODUCTION',     3),
    ('BUILDING_JNR_WIND_MILL',      'YIELD_PRODUCTION',     3),
    ('BUILDING_WORKSHOP',           'YIELD_PRODUCTION',     3),
    ('BUILDING_FACTORY',            'YIELD_PRODUCTION',     6),
    ('BUILDING_ELECTRONICS_FACTORY','YIELD_PRODUCTION',     6),
    ('BUILDING_COAL_POWER_PLANT',   'YIELD_PRODUCTION',     8),
    ('BUILDING_FOSSIL_FUEL_POWER_PLANT','YIELD_PRODUCTION',10),
    ('BUILDING_POWER_PLANT',        'YIELD_PRODUCTION',     6),
    ('BUILDING_POWER_PLANT',        'YIELD_SCIENCE',        6),

    ('BUILDING_MARKET',             'YIELD_GOLD',           6),

    ('BUILDING_AMPHITHEATER',       'YIELD_CULTURE',        2),

    ('BUILDING_ARENA',              'YIELD_CULTURE',        1),

    ('BUILDING_LIGHTHOUSE',         'YIELD_FOOD',           2);


-- Maintainance and Cost
-- City Center
update Buildings set Maintenance = 1,   Cost = 60   where BuildingType = 'BUILDING_MONUMENT';
update Buildings set Maintenance = 2,   Cost = 70   where BuildingType = 'BUILDING_GRANARY';
update Buildings set Maintenance = 3,   Cost = 80   where BuildingType = 'BUILDING_WATER_MILL';

update Buildings set Maintenance = 4,   Cost = 100  where BuildingType = 'BUILDING_LIBRARY';
update Buildings set Maintenance = 10,  Cost = 400  where BuildingType = 'BUILDING_UNIVERSITY';
update Buildings set Maintenance = 16,  Cost = 800  where BuildingType = 'BUILDING_RESEARCH_LAB';

update Buildings set Maintenance = 6,   Cost = 200  where BuildingType = 'BUILDING_WORKSHOP';
update Buildings set Maintenance = 12,  Cost = 500  where BuildingType = 'BUILDING_FACTORY';
update Buildings set Maintenance = 16,  Cost = 800  where BuildingType = 'BUILDING_COAL_POWER_PLANT';
update Buildings set Maintenance = 18,  Cost = 1000 where BuildingType = 'BUILDING_FOSSIL_FUEL_POWER_PLANT';
update Buildings set Maintenance = 20,  Cost = 1200 where BuildingType = 'BUILDING_POWER_PLANT';
update Buildings set Maintenance = 12,  Cost = 500  where BuildingType = 'BUILDING_ELECTRONICS_FACTORY';

update Buildings set Maintenance = 4,   Cost = 100  where BuildingType = 'BUILDING_AMPHITHEATER';

update Buildings set Maintenance = 0,   Cost = 100   where BuildingType = 'BUILDING_MARKET';

update Buildings set Maintenance = 0,   Cost = 50   where BuildingType = 'BUILDING_SHRINE';
update Buildings set Maintenance = 5,   Cost = 125   where BuildingType = 'BUILDING_TEMPLE';

update Buildings set Maintenance = 3,   Cost = 80   where BuildingType = 'BUILDING_BARRACKS';
update Buildings set Maintenance = 3,   Cost = 80   where BuildingType = 'BUILDING_STABLE';

update Buildings set Maintenance = 3,   Cost = 80   where BuildingType = 'BUILDING_LIGHTHOUSE';

update Buildings set Maintenance = 4,   Cost = 100   where BuildingType = 'BUILDING_ARENA';

/*
insert or replace into Building_YieldsPerEra
    (BuildingType,                  YieldType,          YieldChange)  values
    ('BUILDING_MONUMENT',           'YIELD_CULTURE',    '1');
*/


delete from BuildingModifiers
     where BuildingType in ('BUILDING_PALACE','BUILDING_MONUMENT','BUILDING_SHRINE','BUILDING_TEMPLE','BUILDING_LIBRARY','BUILDING_AMPHITHEATER','BUILDING_LIGHTHOUSE',
        'BUILDING_MARKET','BUILDING_GRANARY','BUILDING_WATER_MILL','BUILDING_ARENA',
        'BUILDING_UNIVERSITY','BUILDING_RESEARCH_LAB',
        'BUILDING_GOV_TALL', 'BUILDING_GOV_WIDE', 'BUILDING_GOV_CONQUEST');





insert or replace into BuildingModifiers
    (BuildingType,                  ModifierId)
values

    ('BUILDING_GRANARY',            'GRANARY_PLANTATION_FOOD'),

    ('BUILDING_MASON',              'MASON_QUARRY_PRODUCTION'),

    ('BUILDING_MONUMENT',           'MONUMENT_CULTURE_WITH_WONDER'),
    -- ('BUILDING_MONUMENT',           'MONUMENT_SCIENCE_WITHOUT_CAMPUS'),
    -- ('BUILDING_MONUMENT',           'MONUMENT_CULTURE_WITHOUT_THEATER'),
    -- ('BUILDING_MONUMENT',           'MONUMENT_FAITH_WITHOUT_HOLY_SITE'),
    -- ('BUILDING_MONUMENT',           'MONUMENT_LOYALTY_WITH_CAMPUS'),
    -- ('BUILDING_MONUMENT',           'MONUMENT_LOYALTY_WITH_THEATER'),
    -- ('BUILDING_MONUMENT',           'MONUMENT_LOYALTY_WITH_HOLY_SITE'),
    ('BUILDING_WATER_MILL',           'WATER_MILL_SP_DISTRICTS_FOOD'),
    ('BUILDING_WATER_MILL',           'WATER_MILL_SP_DISTRICTS_PRODUCTION'),
    -- ('BUILDING_WATER_MILL',           'WATER_MILL_NOT_SP_DISTRICTS_PRODUCTION'),

    ('BUILDING_OBSERVATORY',          'OBSERVATORY_SCIENCE_WITH_NATURAL_WONDER'),
    ('BUILDING_OBSERVATORY',          'OBSERVATORY_SCIENCE_ADJACENT_TO_WATER'),
    ('BUILDING_OBSERVATORY',          'OBSERVATORY_SCIENCE_ADJACENT_TO_MOUNTAIN'),

    ('BUILDING_TRIUMPHAL',            'TRIUMPHAL_ENABLE_TRIUMPH'),

    ('BUILDING_FORGING',              'FORGING_IMPROVED_RESOURCE_PRODUCTION'),
    ('BUILDING_FORGING',              'FORGING_IMPROVED_NO_RESOURCE_PRODUCTION'),
    ('BUILDING_PAPER_MAKER',          'PAPER_MAKER_CAMPUS_ADJACENCY'),  
    --('BUILDING_PAPER_MAKER',          'PAPER_MAKER_COMMERCIAL_HUB_ADJACENCY'),  
    ('BUILDING_PAPER_MAKER',          'PAPER_MAKER_THERTER_ADJACENCY'), 
    ('BUILDING_PAPER_MAKER',          'PAPER_MAKER_HOLY_SITE_ADJACENCY'),   
    ('BUILDING_TINGTAI',              'TINGTAI_APPEAL_AMENITY'), 
    ('BUILDING_TINGTAI',              'TINGTAI_APPEAL_HOUSING'), 
    ('BUILDING_TINGTAI',              'TINGTAI_APPEAL_TINGTAI_SCIENCE'), 
    ('BUILDING_TINGTAI',              'TINGTAI_APPEAL_TINGTAI_CULTURE'), 

    ('BUILDING_ZHISUO',             'ZHISUO_ADJUST_UNITY'),   --其余能力在postProcess里


    ('BUILDING_SHRINE',             'SHRINE_BUILDER_PURCHASE'),
    ('BUILDING_SHRINE',             'SHRINE_TRADER_PURCHASE'),
    ('BUILDING_TEMPLE',             'TEMPLE_SETTLER_PURCHASE'),
	('BUILDING_TEMPLE',             'TEMPLE_POP_FAITH_BASE'),
	('BUILDING_TEMPLE',             'TEMPLE_POP_FAITH_AFTER_PAPER'),

    -- ('BUILDING_BARRACKS',           'BARRACKS_UNIT_PRODUCTION'),
    -- ('BUILDING_STABLE',             'STABLE_UNIT_PRODUCTION'),
    ('BUILDING_STABLE',             'STABLE_PASTURE_FOOD'),
    ('BUILDING_STABLE',             'STABLE_PASTURE_PRODUCTION'),


    ('BUILDING_LIBRARY',            'LIBRARY_POP_SCIENCE_AFTER_PAPER'),
	('BUILDING_LIBRARY',            'LIBRARY_POP_SCIENCE_BASE'),
	('BUILDING_JNR_ACADEMY',        'SISHU_CAMPUS_DISTRICT_ADJACENCY'),
    --('BUILDING_UNIVERSITY',         'UNIVERSITY_DISTRICT_SCIENCE_FROM_DISTRICT'),
    ('BUILDING_JNR_SCHOOL',         'CITY_SCHOOL_POP_SCIENCE'),    
    ('BUILDING_JNR_SCHOOL',         'CITY_SCHOOL_POP_SCIENCE_3_DIS'),    
    ('BUILDING_RESEARCH_LAB',       'RESEARCH_LAB_DISTRICT_SCIENCE_FROM_DISTRICT'),
    ('BUILDING_RESEARCH_LAB',       'RESEARCH_LAB_POP_SCIENCE_AFTER_CIVIC'),
    ('BUILDING_RESEARCH_LAB',       'RESEARCH_LAB_SCIENCE_MOD_WITH_POWER'),

    ('BUILDING_JNR_WIND_MILL',      'WIND_MILL_WIND_DISTRICT_PRODUCTION'),
    ('BUILDING_JNR_WIND_MILL',      'WIND_MILL_WIND_DISTRICT_PRODUCTION_EX'),
    ('BUILDING_JNR_IZ_WATER_MILL',  'IZ_WATERMILL_WATER_DISTRICT_PRODUCTION'),
    ('BUILDING_JNR_IZ_WATER_MILL',  'IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_EX'),
    ('BUILDING_WORKSHOP',           'WORKSHOP_POP_PRODUCTION_AFTER_CIVIC'),
    ('BUILDING_FACTORY',            'FACTORY_DISTRICT_PRODUCTION_FROM_DISTRICT'),
    ('BUILDING_COAL_POWER_PLANT',   'COAL_POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER'),
    ('BUILDING_COAL_POWER_PLANT',   'COAL_POWER_PLANT_POP_PRODUCTION_AFTER_CIVIC'),
    ('BUILDING_FOSSIL_FUEL_POWER_PLANT',  'FOSSIL_FUEL_POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER'),
    ('BUILDING_FOSSIL_FUEL_POWER_PLANT',  'FOSSIL_FUEL_POWER_PLANT_DISTRICT_PRODUCTION_FROM_DISTRICT'),

    ('BUILDING_GOV_WIDE',           'GOV_WIDE_CITY_UNITY'),
    ('BUILDING_GOV_WIDE',           'GOV_WIDE_CITY_UNITY_GOVERNOR'),
    ('BUILDING_GOV_CONQUEST',       'GOV_CONQUEST_CITY_UNITY'),

    ('BUILDING_AMPHITHEATER',       'AMPHITHEATER_POP_CULTURE_AFTER_PAPER'),
	('BUILDING_AMPHITHEATER',       'AMPHITHEATER_POP_CULTURE_BASE'),

    ('BUILDING_ARENA',              'ARENA_GIFT_CIRCUS'),
    ('BUILDING_ARENA',              'ARENA_GIFT_OLYMPIC'),
    ('BUILDING_ARENA',              'ARENA_GIFT_WRESTLE'),

    ('BUILDING_MARKET',             'MARKET_TRADE_ROUTE_CAPACITY'),
    ('BUILDING_MARKET',             'MARKET_POP_GOLD'),
    ('BUILDING_LIGHTHOUSE',         'LIGHTHOUSE_TRADE_ROUTE_CAPACITY'),
    ('BUILDING_LIGHTHOUSE',         'LIGHTHOUSE_FOOD_FOR_FISHING_BOATS'),
    ('BUILDING_LIGHTHOUSE',         'LIGHTHOUSE_PRODUCTION_FOR_FISHING_BOATS');

   
insert or replace into TraitModifiers
    (TraitType,                         ModifierId)
values

    ('TRAIT_LEADER_MAJOR_CIV',          'GRANARY_ADJACENT_GRASS_FOOD'),
    ('TRAIT_LEADER_MAJOR_CIV',          'GRANARY_ADJACENT_PLAINS_FOOD'),
    ('TRAIT_LEADER_MAJOR_CIV',          'GRANARY_ADJACENT_FLOODPLAINS_FOOD'),
    ('TRAIT_LEADER_MAJOR_CIV',          'GRANARY_ADJACENT_GRASS_FOOD_EXTRA'),
    ('TRAIT_LEADER_MAJOR_CIV',          'GRANARY_ADJACENT_PLAINS_FOOD_EXTRA'),
    ('TRAIT_LEADER_MAJOR_CIV',          'GRANARY_ADJACENT_FLOODPLAINS_FOOD_EXTRA'),
    ('TRAIT_LEADER_MAJOR_CIV',          'BUILDING_OBSERVATORY_FAITH_PURCHASE'),
  
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_GRASS_HILL_PRODUCTION'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_PLAINS_HILL_PRODUCTION'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_GRASS_HILL_PRODUCTION_EXTRA'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_PLAINS_HILL_PRODUCTION_EXTRA'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION_EXTRA'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION_EXTRA');
    -- ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION'),
    -- ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION');

insert or replace into TraitModifiers select
    'TRAIT_LEADER_MAJOR_CIV',   BuildingType||'_FAITH_PURCHASE'
    from Buildings
    where PrereqDistrict = 'DISTRICT_HOLY_SITE' 
    and BuildingType not like '%CITY_POLICY%'
    and BuildingType not like '%CTZY%'
    and BuildingType not like '%FLAG%';



insert or replace into Modifiers
    (ModifierId,                                    ModifierType,                                                   SubjectRequirementSetId)
values
  --   ('MONUMENT_CAN_BUILD_TEST',                     'MODIFIER_PLAYER_ADJUST_DISTRICT_UNLOCK',                     NULL),
  
    --('GRANARY_POP_GROWTH',                          'MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH',                      NULL),
    ('SHRINE_BUILDER_PURCHASE',                     'MODIFIER_CITY_ENABLE_UNIT_FAITH_PURCHASE',                     NULL),
    ('SHRINE_TRADER_PURCHASE',                      'MODIFIER_CITY_ENABLE_UNIT_FAITH_PURCHASE',                     NULL),    
    ('TEMPLE_SETTLER_PURCHASE',                     'MODIFIER_CITY_ENABLE_UNIT_FAITH_PURCHASE',                     NULL),
    ('TEMPLE_POP_FAITH_BASE',                       'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                         NULL),
	('TEMPLE_POP_FAITH_AFTER_PAPER',                'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                         'RS_PLAYER_HAS_TECH_PAPER_MAKING_DA'),

    ('BARRACKS_UNIT_PRODUCTION',                    'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PRODUCTION_CHANGE',           NULL),
    ('STABLE_UNIT_PRODUCTION',                      'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PRODUCTION_CHANGE',           NULL),
    ('STABLE_PASTURE_FOOD',                         'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_PASTURE'),
    ('STABLE_PASTURE_PRODUCTION',                   'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_PASTURE'),
   
    ('MARKET_TRADE_ROUTE_CAPACITY',                 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY',                  NULL),
    ('MARKET_POP_GOLD',                             'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                         'RS_PLAYER_HAS_TECH_PAPER_MAKING_DA'),
   

    ('LIGHTHOUSE_TRADE_ROUTE_CAPACITY',             'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY',                  NULL),
    ('LIGHTHOUSE_FOOD_FOR_FISHING_BOATS',           'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_FISHING_BOATS'),
    ('LIGHTHOUSE_PRODUCTION_FOR_FISHING_BOATS',     'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_FISHING_BOATS'),
    

    ('MONUMENT_CULTURE_WITH_WONDER',                'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',                   'RS_CITY_HAS_WONDER'),
    ('OBSERVATORY_SCIENCE_WITH_NATURAL_WONDER',     'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',                   'RS_CITY_HAS_NATURAL_WONDER'),
    ('FORGING_IMPROVED_RESOURCE_PRODUCTION',        'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVED_RESOURCE'),
    ('PAPER_MAKER_CAMPUS_ADJACENCY',                'MODIFIER_CITY_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',             'RS_PLOT_HAS_DISTRICT_CAMPUS'),
    ('PAPER_MAKER_HOLY_SITE_ADJACENCY',             'MODIFIER_CITY_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',             'RS_PLOT_HAS_DISTRICT_HOLY_SITE'),
    ('PAPER_MAKER_THERTER_ADJACENCY',               'MODIFIER_CITY_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',             'RS_PLOT_HAS_DISTRICT_THEATER'),
    ('TINGTAI_APPEAL_HOUSING',                      'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_HOUSING',              'RS_PLOT_APPEAL_AT_LEAST_2_AND_NOT_WONDER'),
    ('TINGTAI_APPEAL_AMENITY',                      'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_AMENITY',              'RS_PLOT_APPEAL_AT_LEAST_4_AND_NOT_WONDER'),
    ('TINGTAI_APPEAL_TINGTAI_CULTURE',              'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',                      'RS_PLOT_APPEAL_AT_LEAST_2_AND_NOT_WONDER'),
    ('TINGTAI_APPEAL_TINGTAI_CULTURE_MOD',          'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',                   NULL),
    ('TINGTAI_APPEAL_TINGTAI_SCIENCE',              'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',                      'RS_PLOT_APPEAL_AT_LEAST_4_AND_NOT_WONDER'),
    ('TINGTAI_APPEAL_TINGTAI_SCIENCE_MOD',          'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',                   NULL),
    ('TRIUMPHAL_ENABLE_TRIUMPH',                    'MODIFIER_PLAYER_ADJUST_PROPERTY',                              NULL),

	
	('ZHISUO_ADJUST_UNITY',							'MODIFIER_PLAYER_ADJUST_PROPERTY',								NULL),

    ('LIBRARY_POP_SCIENCE_AFTER_PAPER',             'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                          'RS_PLAYER_HAS_TECH_PAPER_MAKING_DA'),
    ('LIBRARY_POP_SCIENCE_BASE',                    'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                          NULL),    
    ('CITY_SCHOOL_POP_SCIENCE',                     'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                          NULL),
    ('CITY_SCHOOL_POP_SCIENCE_3_DIS',               'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                          'RS_CITY_HAS_3_DISTRICTS'),
    ('SISHU_CAMPUS_DISTRICT_ADJACENCY',             'MODIFIER_SINGLE_CITY_DISTRICT_ADJACENCY',                       NULL),
    --('UNIVERSITY_DISTRICT_SCIENCE',                 'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',                   'RS_IS_SPECIALITY_DISTRICT'),
    ('RESEARCH_LAB_DISTRICT_SCIENCE',               'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',                   'RS_IS_SPECIALITY_DISTRICT'),
    ('RESEARCH_LAB_POP_SCIENCE_AFTER_CIVIC',        'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                          'RS_PLAYER_HAS_CIVIC_MASS_MEDIA'),
    ('RESEARCH_LAB_SCIENCE_MOD_WITH_POWER',         'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',               'CITY_IS_POWERED'),

    ('WORKSHOP_POP_PRODUCTION_AFTER_CIVIC',         'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                          'RS_PLAYER_HAS_CIVIC_GUILDS'),
    ('COAL_POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER',  'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',         'CITY_IS_POWERED'),
    ('FOSSIL_FUEL_POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER',  'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',  'CITY_IS_POWERED'),
    ('COAL_POWER_PLANT_POP_PRODUCTION_AFTER_CIVIC', 'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                          'RS_PLAYER_HAS_CIVIC_CIVIL_ENGINEERING'),
    ('POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',               'CITY_IS_POWERED'),
    ('POWER_PLANT_YIELD_SCIENCE_MOD_WITH_POWER',    'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',               'CITY_IS_POWERED'),
    ('FACTORY_DISTRICT_PRODUCTION',                 'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',                   'RS_IS_SPECIALITY_DISTRICT'),
    ('FOSSIL_FUEL_POWER_PLANT_DISTRICT_PRODUCTION', 'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',                   'RS_IS_SPECIALITY_DISTRICT'),


    ('GOV_WIDE_CITY_UNITY',                         'MODIFIER_PLAYER_CITIES_ADJUST_PLAYER_PROPERTY',                 NULL),
    ('GOV_WIDE_CITY_UNITY_GOVERNOR',                'MODIFIER_PLAYER_CITIES_ADJUST_PLAYER_PROPERTY',                 'CITY_HAS_GOVERNOR_FOUNDED'),
    ('GOV_CONQUEST_CITY_UNITY',                     'MODIFIER_PLAYER_CITIES_ADJUST_PLAYER_PROPERTY',                 'CITY_NOT_FOUNDED'),

    ('AMPHITHEATER_POP_CULTURE_AFTER_PAPER',      	'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                  		'RS_PLAYER_HAS_TECH_PAPER_MAKING_DA'),
	('AMPHITHEATER_POP_CULTURE_BASE',               'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',                       	NULL),

    ('ARENA_GIFT_CIRCUS',                               'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY',               NULL),
    ('ARENA_GIFT_OLYMPIC',                              'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY',               'RS_CITY_HAS_DISTRICT_HOLY_SITE'),
    ('ARENA_GIFT_WRESTLE',                              'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY',               'RS_CITY_HAS_DISTRICT_ENCAMPMENT'),

    ('PLAYERS_HOLY_SITE_FAITH_PURCHASE',            'MODIFIER_PLAYER_CITIES_ENABLE_BUILDING_FAITH_PURCHASE',        NULL),
    ('WATER_MILL_SP_DISTRICTS_FOOD',                'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',                  'RS_IS_SPECIALITY_DISTRICT'),
    --('WATER_MILL_NOT_SP_DISTRICTS_PRODUCTION',      'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',                  'RS_NOT_SPECIALITY_DISTRICT'),
    ('BUILDING_OBSERVATORY_FAITH_PURCHASE',         'MODIFIER_PLAYER_CITIES_ENABLE_SPECIFIC_BUILDING_FAITH_PURCHASE',NULL);
    
    -- ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON'),
    -- ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON');  
   
insert or replace into Modifiers
    (ModifierId,                                    ModifierType,                                                   SubjectRequirementSetId,            OwnerRequirementSetId)
values
    --('WATER_MILL_NOT_SP_DISTRICTS_PRODUCTION',      'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',                  'RS_NOT_SPECIALITY_DISTRICT',               'RS_PLAYER_HAS_TECH_ENGINEERING'),
    ('OBSERVATORY_SCIENCE_ADJACENT_TO_WATER',       'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',                   'RS_PLOT_ADJACENT_TERRAIN_COAST',           'RS_PLAYER_HAS_TECH_MATHEMATICS'),
    ('OBSERVATORY_SCIENCE_ADJACENT_TO_MOUNTAIN',    'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',                   'RS_PLOT_ADJACENT_TERRAIN_CLASS_MOUNTAIN',  'RS_PLAYER_HAS_TECH_MATHEMATICS'),
    ('FORGING_IMPROVED_NO_RESOURCE_PRODUCTION',     'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVED_NO_RESOURCE',         'RS_PLAYER_HAS_TECH_MACHINERY'),

    ('GRANARY_ADJACENT_GRASS_FOOD',                 'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_GRANARY',              'RS_PLAYER_NO_TECH_IRRIGATION'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_GRANARY',              'RS_PLAYER_NO_TECH_IRRIGATION'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'MODIFIER_PLAYER_CITIES_FEATURE_ADJACENCY',                     'RS_CITY_HAS_BUILDING_GRANARY',              'RS_PLAYER_NO_TECH_IRRIGATION'),
    ('GRANARY_ADJACENT_GRASS_FOOD_EXTRA',           'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_GRANARY',              'RS_PLAYER_HAS_TECH_IRRIGATION'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD_EXTRA',     'MODIFIER_PLAYER_CITIES_FEATURE_ADJACENCY',                     'RS_CITY_HAS_BUILDING_GRANARY',              'RS_PLAYER_HAS_TECH_IRRIGATION'),
    ('GRANARY_ADJACENT_PLAINS_FOOD_EXTRA',          'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_GRANARY',              'RS_PLAYER_HAS_TECH_IRRIGATION'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON',                'RS_PLAYER_NO_TECH_MASONRY'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON',                'RS_PLAYER_NO_TECH_MASONRY'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON',                'RS_PLAYER_NO_TECH_MASONRY'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON',                'RS_PLAYER_NO_TECH_MASONRY'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION_EXTRA',  'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON',                'RS_PLAYER_HAS_TECH_MASONRY'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION_EXTRA', 'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON',                'RS_PLAYER_HAS_TECH_MASONRY'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION_EXTRA','MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON',                'RS_PLAYER_HAS_TECH_MASONRY'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION_EXTRA','MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON',                'RS_PLAYER_HAS_TECH_MASONRY'),


    ('WIND_MILL_WIND_DISTRICT_PRODUCTION',          'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',                      'RS_IS_SPECIALITY_DISTRICT',                NULL),
    ('WIND_MILL_WIND_DISTRICT_PRODUCTION_MOD',      'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_CHANGE',                 'RS_WIND_DISTRICT',                         NULL),
    ('WIND_MILL_WIND_DISTRICT_PRODUCTION_EX',       'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',                      'RS_IS_SPECIALITY_DISTRICT',                'RS_PLAYER_HAS_TECH_APPRENTICESHIP'),
    ('WIND_MILL_WIND_DISTRICT_PRODUCTION_EX_MOD',   'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_CHANGE',                 'RS_WIND_DISTRICT',                         NULL),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION',      'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',                      'RS_IS_SPECIALITY_DISTRICT',                NULL),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_MOD',  'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_CHANGE',                 'RS_IS_RIVER',                              NULL),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_EX',   'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',                      'RS_IS_SPECIALITY_DISTRICT',                'RS_PLAYER_HAS_TECH_APPRENTICESHIP'),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_EX_MOD','MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_CHANGE',                'RS_IS_RIVER',                              NULL),

    ('WATER_MILL_SP_DISTRICTS_PRODUCTION',          'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',                  'RS_IS_SPECIALITY_DISTRICT',                'RS_PLAYER_HAS_TECH_ENGINEERING'),

    --('UNIVERSITY_DISTRICT_SCIENCE_FROM_DISTRICT',   'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',                      'RS_IS_SPECIALITY_DISTRICT',                'RS_PLAYER_HAS_TECH_EDUCATION'),
    ('RESEARCH_LAB_DISTRICT_SCIENCE_FROM_DISTRICT',  'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',                     'RS_IS_SPECIALITY_DISTRICT',                'RS_PLAYER_HAS_TECH_RADIO'),

    ('FACTORY_DISTRICT_PRODUCTION_FROM_DISTRICT',    'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',                     'RS_IS_SPECIALITY_DISTRICT',                'RS_PLAYER_HAS_TECH_ECONOMICS'),
    ('FOSSIL_FUEL_POWER_PLANT_DISTRICT_PRODUCTION_FROM_DISTRICT',  'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',       'RS_IS_SPECIALITY_DISTRICT',                'RS_PLAYER_HAS_TECH_REFINING'),


    ('GRANARY_PLANTATION_FOOD',                     'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_PLANTATION',       NULL),
    ('MASON_QUARRY_PRODUCTION',                     'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_QUARRY',           'RS_PLAYER_HAS_TECH_MASONRY');
  
insert or replace into Modifiers(ModifierId,    ModifierType) select
    BuildingType||'_FAITH_PURCHASE',    'MODIFIER_PLAYER_CITIES_ENABLE_SPECIFIC_BUILDING_FAITH_PURCHASE'
    from Buildings
    where PrereqDistrict = 'DISTRICT_HOLY_SITE' 
    and BuildingType not like '%CITY_POLICY%'
    and BuildingType not like '%CTZY%'
    and BuildingType not like '%FLAG%';




insert or replace into ModifierArguments
    (ModifierId,                                    Name,                       Value)
values

    ('SHRINE_BUILDER_PURCHASE',                     'Tag',                      'CLASS_BUILDER'),
    ('SHRINE_TRADER_PURCHASE',                      'Tag',                      'CLASS_TRADER'),
    ('TEMPLE_POP_FAITH_AFTER_PAPER',                'YieldType',                'YIELD_FAITH'),
    ('TEMPLE_POP_FAITH_AFTER_PAPER',                'Amount',                   '1'),
	('TEMPLE_POP_FAITH_BASE',                       'YieldType',                'YIELD_FAITH'),
    ('TEMPLE_POP_FAITH_BASE',                       'Amount',                   '1'),
    ('TEMPLE_SETTLER_PURCHASE',                     'Tag',                      'CLASS_SETTLER'),
    
    ('BARRACKS_UNIT_PRODUCTION',                    'Amount',                   '4'),
    ('STABLE_UNIT_PRODUCTION',                      'Amount',                   '4'),
    ('STABLE_PASTURE_FOOD',                         'Amount',                   '1'),
    ('STABLE_PASTURE_FOOD',                         'YieldType',                'YIELD_FOOD'),
    ('STABLE_PASTURE_PRODUCTION',                   'Amount',                   '1'),
    ('STABLE_PASTURE_PRODUCTION',                   'YieldType',                'YIELD_PRODUCTION'),
    
    ('MARKET_TRADE_ROUTE_CAPACITY',                 'Amount',                   '1'),
    ('MARKET_POP_GOLD',                             'YieldType',                'YIELD_GOLD'),
    ('MARKET_POP_GOLD',                             'Amount',                   '2'),
    ('LIGHTHOUSE_TRADE_ROUTE_CAPACITY',             'Amount',                   '1'),
    ('LIGHTHOUSE_FOOD_FOR_FISHING_BOATS',           'YieldType',                'YIELD_FOOD'),
    ('LIGHTHOUSE_FOOD_FOR_FISHING_BOATS',           'Amount',                   '1'),
    ('LIGHTHOUSE_PRODUCTION_FOR_FISHING_BOATS',     'YieldType',                'YIELD_PRODUCTION'),
    ('LIGHTHOUSE_PRODUCTION_FOR_FISHING_BOATS',     'Amount',                   '1'),

    ('MONUMENT_CULTURE_WITH_WONDER',                'YieldType',                'YIELD_CULTURE'),
    ('MONUMENT_CULTURE_WITH_WONDER',                'Amount',                   2),
    ('MONUMENT_CULTURE_WITH_WONDER',                'BuildingType',             'BUILDING_MONUMENT'),
    ('BUILDING_OBSERVATORY_FAITH_PURCHASE',         'BuildingType',             'BUILDING_OBSERVATORY'),

    ('OBSERVATORY_SCIENCE_WITH_NATURAL_WONDER',     'YieldType',                'YIELD_SCIENCE'),
    ('OBSERVATORY_SCIENCE_WITH_NATURAL_WONDER',     'Amount',                   2),
    ('OBSERVATORY_SCIENCE_WITH_NATURAL_WONDER',     'BuildingType',             'BUILDING_OBSERVATORY'),
    ('OBSERVATORY_SCIENCE_ADJACENT_TO_WATER',       'YieldType',                'YIELD_SCIENCE'),
    ('OBSERVATORY_SCIENCE_ADJACENT_TO_WATER',       'Amount',                   2),
    ('OBSERVATORY_SCIENCE_ADJACENT_TO_WATER',       'BuildingType',             'BUILDING_OBSERVATORY'),
    ('OBSERVATORY_SCIENCE_ADJACENT_TO_MOUNTAIN',    'YieldType',                'YIELD_SCIENCE'),
    ('OBSERVATORY_SCIENCE_ADJACENT_TO_MOUNTAIN',    'Amount',                   2),
    ('OBSERVATORY_SCIENCE_ADJACENT_TO_MOUNTAIN',    'BuildingType',             'BUILDING_OBSERVATORY'),
    -- ('MONUMENT_SCIENCE_WITHOUT_CAMPUS',             'YieldType',                'YIELD_SCIENCE'),
    -- ('MONUMENT_SCIENCE_WITHOUT_CAMPUS',             'Amount',                   1),
    -- ('MONUMENT_SCIENCE_WITHOUT_CAMPUS',             'BuildingType',             'BUILDING_MONUMENT'),
    -- ('MONUMENT_CULTURE_WITHOUT_THEATER',            'YieldType',                'YIELD_CULTURE'),
    -- ('MONUMENT_CULTURE_WITHOUT_THEATER',            'Amount',                   1),
    -- ('MONUMENT_CULTURE_WITHOUT_THEATER',            'BuildingType',             'BUILDING_MONUMENT'),
    -- ('MONUMENT_FAITH_WITHOUT_HOLY_SITE',            'YieldType',                'YIELD_FAITH'),
    -- ('MONUMENT_FAITH_WITHOUT_HOLY_SITE',            'Amount',                   1),
    -- ('MONUMENT_FAITH_WITHOUT_HOLY_SITE',            'BuildingType',             'BUILDING_MONUMENT'),
    -- ('MONUMENT_LOYALTY_WITH_CAMPUS',                'Amount',                   2),
    -- ('MONUMENT_LOYALTY_WITH_THEATER',               'Amount',                   2),
    -- ('MONUMENT_LOYALTY_WITH_HOLY_SITE',             'Amount',                   2),

    ('TRIUMPHAL_ENABLE_TRIUMPH',                    'Key',                      'PROP_ENABLE_TRIUMPH'),
    ('TRIUMPHAL_ENABLE_TRIUMPH',                    'Amount',                   '1'),

    ('LIBRARY_POP_SCIENCE_AFTER_PAPER',             'YieldType',                'YIELD_SCIENCE'),
    ('LIBRARY_POP_SCIENCE_AFTER_PAPER',             'Amount',                   '0.5'),
	
	('LIBRARY_POP_SCIENCE_BASE',             		'YieldType',                'YIELD_SCIENCE'),
    ('LIBRARY_POP_SCIENCE_BASE',             		'Amount',                   '0.5'),

    ('SISHU_CAMPUS_DISTRICT_ADJACENCY',             'Amount',                   1),
    ('SISHU_CAMPUS_DISTRICT_ADJACENCY',             'Description',              'LOC_DISTRICT_SCIENCE_ADJACENCY'),
    ('SISHU_CAMPUS_DISTRICT_ADJACENCY',             'DistrictType',             'DISTRICT_CAMPUS'),
    ('SISHU_CAMPUS_DISTRICT_ADJACENCY',             'YieldType',                'YIELD_SCIENCE'),

    ('CITY_SCHOOL_POP_SCIENCE',                     'YieldType',                'YIELD_SCIENCE'),
    ('CITY_SCHOOL_POP_SCIENCE',                     'Amount',                   '1'),
    
    ('CITY_SCHOOL_POP_SCIENCE_3_DIS',               'YieldType',                'YIELD_SCIENCE'),
    ('CITY_SCHOOL_POP_SCIENCE_3_DIS',               'Amount',                   '1'),

    --('UNIVERSITY_DISTRICT_SCIENCE',                 'YieldType',                'YIELD_SCIENCE'),
    --('UNIVERSITY_DISTRICT_SCIENCE',                 'Amount',                   '1'),

    --('UNIVERSITY_DISTRICT_SCIENCE_FROM_DISTRICT',   'ModifierId',               'UNIVERSITY_DISTRICT_SCIENCE'),

    ('RESEARCH_LAB_DISTRICT_SCIENCE',               'YieldType',                'YIELD_SCIENCE'),
    ('RESEARCH_LAB_DISTRICT_SCIENCE',               'Amount',                   '2'),

    ('RESEARCH_LAB_DISTRICT_SCIENCE_FROM_DISTRICT', 'ModifierId',               'RESEARCH_LAB_DISTRICT_SCIENCE'),

    ('RESEARCH_LAB_POP_SCIENCE_AFTER_CIVIC',        'YieldType',                'YIELD_SCIENCE'),
    ('RESEARCH_LAB_POP_SCIENCE_AFTER_CIVIC',        'Amount',                   '1'),

    ('RESEARCH_LAB_SCIENCE_MOD_WITH_POWER',         'YieldType',                'YIELD_SCIENCE'),
    ('RESEARCH_LAB_SCIENCE_MOD_WITH_POWER',         'Amount',                   '20'),
	
	('ZHISUO_ADJUST_UNITY',							'Key',						'PROP_UNITY_SOURCE_ZHISUO'),
	('ZHISUO_ADJUST_UNITY',							'Amount',					5),

    ('WIND_MILL_WIND_DISTRICT_PRODUCTION',          'ModifierId',               'WIND_MILL_WIND_DISTRICT_PRODUCTION_MOD'),
    ('WIND_MILL_WIND_DISTRICT_PRODUCTION_MOD',      'YieldType',                'YIELD_PRODUCTION'),
    ('WIND_MILL_WIND_DISTRICT_PRODUCTION_MOD',      'Amount',                   '3'),
    ('WIND_MILL_WIND_DISTRICT_PRODUCTION_EX',       'ModifierId',               'WIND_MILL_WIND_DISTRICT_PRODUCTION_EX_MOD'),
    ('WIND_MILL_WIND_DISTRICT_PRODUCTION_EX_MOD',   'YieldType',                'YIELD_PRODUCTION'),
    ('WIND_MILL_WIND_DISTRICT_PRODUCTION_EX_MOD',   'Amount',                   '3'),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION',      'ModifierId',               'IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_MOD'),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_MOD',  'YieldType',                'YIELD_PRODUCTION'),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_MOD',  'Amount',                   '3'),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_EX',   'ModifierId',               'IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_EX_MOD'),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_EX_MOD','YieldType',               'YIELD_PRODUCTION'),
    ('IZ_WATERMILL_WATER_DISTRICT_PRODUCTION_EX_MOD','Amount',                  '3'),

    ('WORKSHOP_POP_PRODUCTION_AFTER_CIVIC',         'YieldType',                'YIELD_PRODUCTION'),
    ('WORKSHOP_POP_PRODUCTION_AFTER_CIVIC',         'Amount',                   '1'),
    ('FACTORY_DISTRICT_PRODUCTION_FROM_DISTRICT',   'ModifierId',               'FACTORY_DISTRICT_PRODUCTION'),
    ('FACTORY_DISTRICT_PRODUCTION',                 'YieldType',                'YIELD_PRODUCTION'),
    ('FACTORY_DISTRICT_PRODUCTION',                 'Amount',                   '1'),
    ('FOSSIL_FUEL_POWER_PLANT_DISTRICT_PRODUCTION_FROM_DISTRICT', 'ModifierId', 'FOSSIL_FUEL_POWER_PLANT_DISTRICT_PRODUCTION'),
    ('FOSSIL_FUEL_POWER_PLANT_DISTRICT_PRODUCTION',               'YieldType',  'YIELD_PRODUCTION'),
    ('FOSSIL_FUEL_POWER_PLANT_DISTRICT_PRODUCTION',               'Amount',     '1'),
    ('COAL_POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER',         'YieldType',   'YIELD_PRODUCTION'),
    ('COAL_POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER',         'Amount',      '20'),
    ('FOSSIL_FUEL_POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER', 'YieldType',    'YIELD_PRODUCTION'),
    ('FOSSIL_FUEL_POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER', 'Amount',       '20'),
    ('COAL_POWER_PLANT_POP_PRODUCTION_AFTER_CIVIC', 'YieldType',                'YIELD_PRODUCTION'),
    ('COAL_POWER_PLANT_POP_PRODUCTION_AFTER_CIVIC', 'Amount',                   '2'),
    ('POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER', 'YieldType',                'YIELD_PRODUCTION'),
    ('POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER', 'Amount',                   '15'),
    ('POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER', 'YieldType',                'YIELD_SCIENCE'),
    ('POWER_PLANT_YIELD_PRODUCTION_MOD_WITH_POWER', 'Amount',                   '15'),


    ('GOV_WIDE_CITY_UNITY',                         'Key',                      'PROP_UNITY_SOURCE_GOVERNMENT_BUILDING'),
    ('GOV_WIDE_CITY_UNITY',                         'Amount',                   1),
    ('GOV_WIDE_CITY_UNITY_GOVERNOR',                'Key',                      'PROP_UNITY_SOURCE_GOVERNMENT_BUILDING'),
    ('GOV_WIDE_CITY_UNITY_GOVERNOR',                'Amount',                   1),
    ('GOV_CONQUEST_CITY_UNITY',                     'Key',                      'PROP_UNITY_SOURCE_GOVERNMENT_BUILDING'),
    ('GOV_CONQUEST_CITY_UNITY',                     'Amount',                   1),

    ('AMPHITHEATER_POP_CULTURE_AFTER_PAPER',        'YieldType',                'YIELD_CULTURE'),
    ('AMPHITHEATER_POP_CULTURE_AFTER_PAPER',        'Amount',                   '0.5'),
	
	('AMPHITHEATER_POP_CULTURE_BASE',               'YieldType',                'YIELD_CULTURE'),
    ('AMPHITHEATER_POP_CULTURE_BASE',               'Amount',                   '0.5'),

    ('ARENA_GIFT_CIRCUS',                           'ResourceType',             'RESOURCE_CIRCUS'),
    ('ARENA_GIFT_CIRCUS',                           'Amount',                   '1'),
    ('ARENA_GIFT_OLYMPIC',                          'ResourceType',             'RESOURCE_OLYMPIC'),
    ('ARENA_GIFT_OLYMPIC',                          'Amount',                   '1'),
    ('ARENA_GIFT_WRESTLE',                          'ResourceType',             'RESOURCE_WRESTLE'),
    ('ARENA_GIFT_WRESTLE',                          'Amount',                   '1'),

    ('PLAYERS_HOLY_SITE_FAITH_PURCHASE',            'DistrictType',             'DISTRICT_HOLY_SITE'),
    --('WATER_MILL_DISTRICTS_PRODUCTION',             'ModifierId',               'WATER_MILL_DISTRICTS_PRODUCTION_MOD'),
    ('WATER_MILL_SP_DISTRICTS_PRODUCTION',          'Amount',                   '1'),
    ('WATER_MILL_SP_DISTRICTS_PRODUCTION',          'YieldType',                'YIELD_PRODUCTION'),
    ('WATER_MILL_SP_DISTRICTS_FOOD',                'Amount',                   '1'),
    ('WATER_MILL_SP_DISTRICTS_FOOD',                'YieldType',                'YIELD_FOOD'),
    -- ('WATER_MILL_NOT_SP_DISTRICTS_PRODUCTION',      'Amount',                   '1'),
    -- ('WATER_MILL_NOT_SP_DISTRICTS_PRODUCTION',      'YieldType',                'YIELD_FOOD'),

    ('FORGING_IMPROVED_RESOURCE_PRODUCTION',         'Amount',                   '1'),
    ('FORGING_IMPROVED_RESOURCE_PRODUCTION',         'YieldType',                'YIELD_PRODUCTION'),
    ('FORGING_IMPROVED_NO_RESOURCE_PRODUCTION',      'Amount',                   '1'),
    ('FORGING_IMPROVED_NO_RESOURCE_PRODUCTION',      'YieldType',                'YIELD_PRODUCTION'),

    ('PAPER_MAKER_CAMPUS_ADJACENCY',                 'YieldType',                'YIELD_SCIENCE'),
    ('PAPER_MAKER_CAMPUS_ADJACENCY',                 'Amount',                   '1'),
    -- ('PAPER_MAKER_COMMERCIAL_HUB_ADJACENCY',                      'YieldType',                'YIELD_GOLD'),
    -- ('PAPER_MAKER_COMMERCIAL_HUB_ADJACENCY',                      'Amount',                   '1'),
    ('PAPER_MAKER_HOLY_SITE_ADJACENCY',              'YieldType',                'YIELD_FAITH'),
    ('PAPER_MAKER_HOLY_SITE_ADJACENCY',              'Amount',                   '1'),
    ('PAPER_MAKER_THERTER_ADJACENCY',                'YieldType',                'YIELD_CULTURE'),
    ('PAPER_MAKER_THERTER_ADJACENCY',                'Amount',                   '1'),

    ('TINGTAI_APPEAL_HOUSING',                       'Amount',                   '1'),
    ('TINGTAI_APPEAL_AMENITY',                       'Amount',                   '1'),
    ('TINGTAI_APPEAL_TINGTAI_CULTURE_MOD',               'Amount',                   '1'),
    ('TINGTAI_APPEAL_TINGTAI_CULTURE_MOD',               'YieldType',                'YIELD_CULTURE'),
    ('TINGTAI_APPEAL_TINGTAI_CULTURE_MOD',               'BuildingType',             'BUILDING_TINGTAI'),
    ('TINGTAI_APPEAL_TINGTAI_SCIENCE_MOD',              'Amount',                   '1'),
    ('TINGTAI_APPEAL_TINGTAI_SCIENCE_MOD',              'YieldType',                'YIELD_SCIENCE'),
    ('TINGTAI_APPEAL_TINGTAI_SCIENCE_MOD',              'BuildingType',             'BUILDING_TINGTAI'),
    ('TINGTAI_APPEAL_TINGTAI_CULTURE',                'ModifierId',                   'TINGTAI_APPEAL_TINGTAI_CULTURE_MOD'),
    ('TINGTAI_APPEAL_TINGTAI_SCIENCE',               'ModifierId',                   'TINGTAI_APPEAL_TINGTAI_SCIENCE_MOD'),

    ('GRANARY_ADJACENT_GRASS_FOOD',                 'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'Amount',                   1),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'TerrainType',              'TERRAIN_GRASS'),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'YieldType',                'YIELD_FOOD'),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'Description',              'LOC_BUILDING_GRANARY_GRASS_FOOD'),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'TilesRequired',            2),

    ('GRANARY_ADJACENT_PLAINS_FOOD',                'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'Amount',                   1),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'TerrainType',              'TERRAIN_PLAINS'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'YieldType',                'YIELD_FOOD'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'Description',              'LOC_BUILDING_GRANARY_PLAINS_FOOD'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'TilesRequired',            2),

    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'Amount',                   1),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'FeatureType',              'FEATURE_FLOODPLAINS'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'YieldType',                'YIELD_FOOD'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'Description',              'LOC_BUILDING_GRANARY_FLOODPLAINS_FOOD'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'TilesRequired',            2),

    ('GRANARY_ADJACENT_GRASS_FOOD_EXTRA',                'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('GRANARY_ADJACENT_GRASS_FOOD_EXTRA',                'Amount',                   1),
    ('GRANARY_ADJACENT_GRASS_FOOD_EXTRA',                'TerrainType',              'TERRAIN_GRASS'),
    ('GRANARY_ADJACENT_GRASS_FOOD_EXTRA',                'YieldType',                'YIELD_FOOD'),
    ('GRANARY_ADJACENT_GRASS_FOOD_EXTRA',                'Description',              'LOC_BUILDING_GRANARY_GRASS_FOOD'),
    ('GRANARY_ADJACENT_GRASS_FOOD_EXTRA',                'TilesRequired',            1),

    ('GRANARY_ADJACENT_PLAINS_FOOD_EXTRA',               'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('GRANARY_ADJACENT_PLAINS_FOOD_EXTRA',               'Amount',                   1),
    ('GRANARY_ADJACENT_PLAINS_FOOD_EXTRA',               'TerrainType',              'TERRAIN_PLAINS'),
    ('GRANARY_ADJACENT_PLAINS_FOOD_EXTRA',               'YieldType',                'YIELD_FOOD'),
    ('GRANARY_ADJACENT_PLAINS_FOOD_EXTRA',               'Description',              'LOC_BUILDING_GRANARY_PLAINS_FOOD'),
    ('GRANARY_ADJACENT_PLAINS_FOOD_EXTRA',               'TilesRequired',            1),

    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD_EXTRA',          'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD_EXTRA',          'Amount',                   1),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD_EXTRA',          'FeatureType',              'FEATURE_FLOODPLAINS'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD_EXTRA',          'YieldType',                'YIELD_FOOD'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD_EXTRA',          'Description',              'LOC_BUILDING_GRANARY_FLOODPLAINS_FOOD'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD_EXTRA',          'TilesRequired',            1),


    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'Amount',                   '1'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'TerrainType',              'TERRAIN_GRASS_HILLS'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'Description',              'LOC_BUILDING_MASON_GRASS_HILLS_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'TilesRequired',            2),

    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'Amount',                   '1'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'TerrainType',              'TERRAIN_PLAINS_HILLS'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'Description',              'LOC_BUILDING_MASON_PLAINS_HILLS_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'TilesRequired',            2),

    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'Amount',                   '1'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'TerrainType',              'TERRAIN_GRASS_MOUNTAIN'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'Description',              'LOC_BUILDING_MASON_GRASS_MOUNTAIN_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'TilesRequired',            2),

    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'Amount',                   '1'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'TerrainType',              'TERRAIN_PLAINS_MOUNTAIN'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'Description',              'LOC_BUILDING_MASON_PLAINS_MOUNTAIN_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'TilesRequired',            2),

    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION_EXTRA',        'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION_EXTRA',        'Amount',                   '1'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION_EXTRA',        'TerrainType',              'TERRAIN_GRASS_HILLS'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION_EXTRA',        'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION_EXTRA',        'Description',              'LOC_BUILDING_MASON_GRASS_HILLS_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION_EXTRA',        'TilesRequired',            1),

    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION_EXTRA',       'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION_EXTRA',       'Amount',                   '1'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION_EXTRA',       'TerrainType',              'TERRAIN_PLAINS_HILLS'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION_EXTRA',       'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION_EXTRA',       'Description',              'LOC_BUILDING_MASON_PLAINS_HILLS_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION_EXTRA',       'TilesRequired',            1),

    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION_EXTRA',    'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION_EXTRA',    'Amount',                   '1'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION_EXTRA',    'TerrainType',              'TERRAIN_GRASS_MOUNTAIN'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION_EXTRA',    'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION_EXTRA',    'Description',              'LOC_BUILDING_MASON_GRASS_MOUNTAIN_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION_EXTRA',    'TilesRequired',            1),

    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION_EXTRA',   'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION_EXTRA',   'Amount',                   '1'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION_EXTRA',   'TerrainType',              'TERRAIN_PLAINS_MOUNTAIN'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION_EXTRA',   'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION_EXTRA',   'Description',              'LOC_BUILDING_MASON_PLAINS_MOUNTAIN_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION_EXTRA',   'TilesRequired',            1),


    -- ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'DistrictType',             'DISTRICT_CITY_CENTER'),
    -- ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'Amount',                   '1'),
    -- ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'TerrainType',              'TERRAIN_GRASS_MOUNTAIN'),
    -- ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'YieldType',                'YIELD_PRODUCTION'),
    -- ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'Description',              'LOC_BUILDING_MASON_GRASS_MOUNTAIN_PRODUCTION'),
    -- ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'TilesRequired',            '1'),
    
    -- ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'DistrictType',             'DISTRICT_CITY_CENTER'),
    -- ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'Amount',                   '1'),
    -- ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'TerrainType',              'TERRAIN_PLAINS_MOUNTAIN'),
    -- ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'YieldType',                'YIELD_PRODUCTION'),
    -- ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'Description',              'LOC_BUILDING_MASON_PLAINS_MOUNTAIN_PRODUCTION'),
    -- ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'TilesRequired',            '1'),

    ('GRANARY_PLANTATION_FOOD',                     'Amount',                   '1'),
    ('GRANARY_PLANTATION_FOOD',                     'YieldType',                'YIELD_FOOD'),
    ('MASON_QUARRY_PRODUCTION',                     'Amount',                   '1'),
    ('MASON_QUARRY_PRODUCTION',                     'YieldType',                'YIELD_PRODUCTION');


--兵营相邻转单位锤
insert or replace into BuildingModifiers(BuildingType, ModifierId) select
    'BUILDING_BARRACKS', 'BARRACK_UNIT_PRODUCTION_ADJACENCY_'||numbers
    from counter where numbers > 0 and numbers < 21;

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
    'BARRACK_UNIT_PRODUCTION_ADJACENCY_'||numbers, 'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PRODUCTION_CHANGE', 'RS_IS_'||numbers||'_ADJACENCY_DISTRICT_ENCAMPMENT_FIX'
    from counter where numbers > 0 and numbers < 21;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
    'BARRACK_UNIT_PRODUCTION_ADJACENCY_'||numbers, 'Amount', 1
    from counter where numbers > 0 and numbers < 21;

--凯旋门 单位等级加凯旋门文化值
insert or replace into BuildingModifiers(BuildingType, ModifierId) select
    'BUILDING_TRIUMPHAL', 'TRIUMPHAL_GARRISON_CULTURE_'||numbers
    from counter where numbers > 0 and numbers < 8;

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) select
    'TRIUMPHAL_GARRISON_CULTURE_'||numbers, 'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD', 'RS_GARRISON_LEVEL_IS_'||numbers, 'RS_PLOT_HAS_DISTRICT_CITY_CENTER'
    from counter where numbers > 0 and numbers < 8;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
    'TRIUMPHAL_GARRISON_CULTURE_'||numbers, 'YieldType', 'YIELD_CULTURE'
    from counter where numbers > 0 and numbers < 8;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
    'TRIUMPHAL_GARRISON_CULTURE_'||numbers, 'Amount', numbers
    from counter where numbers > 0 and numbers < 8;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
    'TRIUMPHAL_GARRISON_CULTURE_'||numbers, 'BuildingType', 'BUILDING_TRIUMPHAL'
    from counter where numbers > 0 and numbers < 8;

--王座厅加凝聚力
insert or replace into BuildingModifiers(BuildingType, ModifierId) select
    'BUILDING_GOV_TALL', 'GOV_TALL_UNITY_'||numbers
    from counter where numbers > 0 and numbers < 9;

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
    'GOV_TALL_UNITY_'||numbers, 'MODIFIER_PLAYER_ADJUST_PROPERTY', 'RS_'||numbers||'_GOVERNOR_TITLES'
    from counter where numbers > 0 and numbers < 9;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
    'GOV_TALL_UNITY_'||numbers, 'Amount', 2
    from counter where numbers > 0 and numbers < 9;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
    'GOV_TALL_UNITY_'||numbers, 'Key', 'PROP_UNITY_SOURCE_GOVERNMENT_BUILDING'
    from counter where numbers > 0 and numbers < 9;

--圣地建筑可信仰值购买
insert or replace into ModifierArguments(ModifierId,    Name,   Value) select
    BuildingType||'_FAITH_PURCHASE',    'BuildingType',     BuildingType
    from Buildings
    where PrereqDistrict = 'DISTRICT_HOLY_SITE' 
    and BuildingType not like '%CITY_POLICY%'
    and BuildingType not like '%CTZY%'
    and BuildingType not like '%FLAG%';

--军营和马厩加经验值比例
update ModifierArguments set Value = 50 where ModifierId in ('BARRACKS_TRAINED_UNIT_XP', 'STABLE_TRAINED_UNIT_XP'); --25


--杂项Requirements
insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
values
    ('RS_CITY_HAS_MONUMENT_DISTRICTS',                  'REQUIREMENTSET_TEST_ALL'),
    ('CITY_ADJACENT_TO_RIVER_AND_HAS_WATER_MILL',       'REQUIREMENTSET_TEST_ALL'),
    ('RS_RIVER_FARM',                                   'REQUIREMENTSET_TEST_ALL'),
    ('RS_RIVER_PLANTATION',                             'REQUIREMENTSET_TEST_ALL'),
    ('RS_RIVER_LUMBER_MILL',                            'REQUIREMENTSET_TEST_ALL'),
    ('RS_AT_LEAST_4_AMENITIES_AND_HAS_AMPHITHEATER',    'REQUIREMENTSET_TEST_ALL'),
    ('RS_WIND_DISTRICT',                                'REQUIREMENTSET_TEST_ANY');


insert or ignore into Requirements
    (RequirementId,                                     RequirementType)
values
    ('REQ_RIVER_PLOT',                                  'REQUIREMENT_PLOT_ADJACENT_TO_RIVER'),
    ('HD_REQUIRES_DISTRICT_IS_NOT_DISTRICT_WONDER','REQUIREMENT_DISTRICT_TYPE_MATCHES');
--update Requirements set Inverse = 1 where RequirementId = 'HD_REQUIRES_DISTRICT_IS_NOT_DISTRICT_WONDER';

/*insert or ignore into RequirementArguments
    (RequirementId,                                     Name,                   Value)
values
    ('HD_REQUIRES_DISTRICT_IS_NOT_DISTRICT_WONDER','DistrictType',  'DISTRICT_WONDER');

   */

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
values
    ('CITY_ADJACENT_TO_RIVER_AND_HAS_WATER_MILL',       'REQ_RIVER_PLOT'),
    ('CITY_ADJACENT_TO_RIVER_AND_HAS_WATER_MILL',       'REQ_CITY_HAS_BUILDING_WATER_MILL'),

    ('RS_CITY_HAS_MONUMENT_DISTRICTS',                  'REQ_CITY_HAS_DISTRICT_CAMPUS'),
    ('RS_CITY_HAS_MONUMENT_DISTRICTS',                  'REQ_CITY_HAS_DISTRICT_THEATER'),
    ('RS_CITY_HAS_MONUMENT_DISTRICTS',                  'REQ_CITY_HAS_DISTRICT_HOLY_SITE'),

    ('RS_RIVER_FARM',                                   'REQ_PLOT_HAS_IMPROVEMENT_FARM'),
    ('RS_RIVER_FARM',                                   'REQ_RIVER_PLOT'),
    ('RS_RIVER_PLANTATION',                             'REQ_PLOT_HAS_IMPROVEMENT_PLANTATION'),
    ('RS_RIVER_PLANTATION',                             'REQ_RIVER_PLOT'),
    ('RS_RIVER_LUMBER_MILL',                            'REQ_PLOT_HAS_IMPROVEMENT_LUMBER_MILL'),
    ('RS_RIVER_LUMBER_MILL',                            'REQ_RIVER_PLOT'),
    ('RS_AT_LEAST_4_AMENITIES_AND_HAS_AMPHITHEATER',    'REQ_AT_LEAST_4_AMENITIES'),
    ('RS_AT_LEAST_4_AMENITIES_AND_HAS_AMPHITHEATER',    'REQ_CITY_HAS_BUILDING_AMPHITHEATER'),
    ('RS_WIND_DISTRICT',                                'REQ_IS_COAST'),
    ('RS_WIND_DISTRICT',                                'REQ_IS_COASTAL_LAND'),
    ('RS_WIND_DISTRICT',                                'REQ_PLOT_IS_TERRAIN_CLASS_HILLS');



--伟人点数
update Building_GreatPersonPoints set PointsPerTurn = 2 where BuildingType in ('BUILDING_UNIVERSITY', 'BUILDING_TEMPLE');
update Building_GreatPersonPoints set PointsPerTurn = 4 where BuildingType = 'BUILDING_RESEARCH_LAB';

update Building_GreatPersonPoints set PointsPerTurn = 2 where BuildingType = 'BUILDING_FACTORY';
update Building_GreatPersonPoints set PointsPerTurn = 4 where BuildingType = 'BUILDING_COAL_POWER_PLANT';
update Building_GreatPersonPoints set PointsPerTurn = 4 where BuildingType = 'BUILDING_FOSSIL_FUEL_POWER_PLANT';
update Building_GreatPersonPoints set PointsPerTurn = 4 where BuildingType = 'BUILDING_POWER_PLANT';

insert or replace into Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn) values
    ('BUILDING_MASON',                      'GREAT_PERSON_CLASS_ENGINEER',          1),
    ('BUILDING_FORGING',                    'GREAT_PERSON_CLASS_ENGINEER',          1),
    ('BUILDING_OBSERVATORY',                'GREAT_PERSON_CLASS_SCIENTIST',         1),
    ('BUILDING_JNR_ACADEMY',                'GREAT_PERSON_CLASS_SCIENTIST',         1),
    ('BUILDING_JNR_SCHOOL',                 'GREAT_PERSON_CLASS_SCIENTIST',         2),
    ('BUILDING_JNR_IZ_WATER_MILL',          'GREAT_PERSON_CLASS_ENGINEER',          1),
    ('BUILDING_JNR_WIND_MILL',              'GREAT_PERSON_CLASS_ENGINEER',          1);

CREATE TABLE "Building_Citizen_GreatPersonPoints" (
        "BuildingType" TEXT NOT NULL,
        "GreatPersonClassType" TEXT NOT NULL,
        "PointsPerTurn" INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY(BuildingType, GreatPersonClassType)
);


-------------------以下这些移动至post process-------------------
-- --这些建筑给的专家伟人点和建筑产伟人点对齐
-- insert or replace into Building_Citizen_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn) select
--     BuildingType, GreatPersonClassType, PointsPerTurn
--     from Building_GreatPersonPoints where BuildingType in ('BUILDING_LIBRARY', 'BUILDING_SHRINE', 'BUILDING_STABLE', 'BUILDING_BARRACKS', 'BUILDING_MARKET', 'BUILDING_AMPHITHEATER',
--         'BUILDING_LIGHTHOUSE', 'BUILDING_WORKSHOP', 'BUILDING_UNIVERSITY', 'BUILDING_RESEARCH_LAB')
--         or BuildingType in (select CivUniqueBuildingType from BuildingReplaces where ReplacesBuildingType in 
--             ('BUILDING_LIBRARY', 'BUILDING_SHRINE', 'BUILDING_STABLE', 'BUILDING_BARRACKS', 'BUILDING_MARKET', 'BUILDING_AMPHITHEATER',
--         'BUILDING_LIGHTHOUSE', 'BUILDING_WORKSHOP', 'BUILDING_UNIVERSITY', 'BUILDING_RESEARCH_LAB'));


-- --建筑提升专家的伟人点产出
-- insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) select
--     BuildingType||'_CITIZEN_'||GreatPersonClassType||'_'||numbers, 'MODIFIER_PLAYER_DISTRICT_ADJUST_GREAT_PERSON_POINTS', 'RS_PLOT_HAS_'||numbers||'_WORKERS'
--     from Building_Citizen_GreatPersonPoints, counter_m where numbers > 0 and numbers < 6;

-- insert or replace into BuildingModifiers(BuildingType, ModifierId) select
--     BuildingType, BuildingType||'_CITIZEN_'||GreatPersonClassType||'_'||numbers
--     from Building_Citizen_GreatPersonPoints, counter_m where numbers > 0 and numbers < 6;

-- insert or replace into ModifierArguments(ModifierId, Name, Value) select
--     BuildingType||'_CITIZEN_'||GreatPersonClassType||'_'||numbers, 'GreatPersonClassType', GreatPersonClassType
--     from Building_Citizen_GreatPersonPoints, counter_m where numbers > 0 and numbers < 6;

-- insert or replace into ModifierArguments(ModifierId, Name, Value) select
--     BuildingType||'_CITIZEN_'||GreatPersonClassType||'_'||numbers, 'Amount', PointsPerTurn
--     from Building_Citizen_GreatPersonPoints, counter_m where numbers > 0 and numbers < 6;

-- --提供给toolTipHelper使用  建筑给专家带来的更多伟人点数
-- insert or replace into CitizenBonus(ItemType,       BonusType,      Amount) select
--     BuildingType, GreatPersonClassType, PointsPerTurn
--     from Building_Citizen_GreatPersonPoints;
-------------------以上这些移动至post process-------------------




--提供给toolTipHelper使用  某些建筑给专家扣宜居度
insert or replace into CitizenBonus(ItemType,       BonusType,      Amount) values
    ('BUILDING_COAL_POWER_PLANT',   'CITIZEN_AMENITY',      -1),
    ('BUILDING_FOSSIL_FUEL_POWER_PLANT',   'CITIZEN_AMENITY',      -1),
    ('BUILDING_POWER_PLANT',   'CITIZEN_AMENITY',      -1),
    ('BUILDING_RESEARCH_LAB',       'CITIZEN_AMENITY',      -1);

--某些建筑给专家扣宜居度
insert or replace into BuildingModifiers(BuildingType,  ModifierId) select
    ItemType,     ItemType||'_'||numbers||'_WORKER_CONSUME_AMENITY'
    from CitizenBonus,counter where BonusType = 'CITIZEN_AMENITY' and numbers >= 1 and numbers <= 20;

insert or replace into Modifiers(ModifierId,    ModifierType, SubjectRequirementSetId) select
    ItemType||'_'||numbers||'_WORKER_CONSUME_AMENITY',    'MODIFIER_PLAYER_DISTRICT_ADJUST_DISTRICT_AMENITY',  'RS_PLOT_HAS_'||numbers||'_WORKERS'
    from CitizenBonus,counter where BonusType = 'CITIZEN_AMENITY' and numbers >= 1 and numbers <= 20;

insert or replace into ModifierArguments(ModifierId,    Name, Value) select
    ItemType||'_'||numbers||'_WORKER_CONSUME_AMENITY',    'Amount',   Amount
    from CitizenBonus,counter where BonusType = 'CITIZEN_AMENITY' and numbers >= 1 and numbers <= 20;



--电力相关
--update Buildings_XP2 set RequiredPower = 4 where BuildingType = 'BUILDING_RESEARCH_LAB';
update Building_YieldChangesBonusWithPower set YieldChange = 0 where BuildingType = 'BUILDING_RESEARCH_LAB';

update Building_YieldChangesBonusWithPower set YieldChange = 0 where BuildingType = 'BUILDING_FACTORY';
update Building_YieldChangesBonusWithPower set YieldChange = 0 where BuildingType = 'BUILDING_ELECTRONICS_FACTORY';
