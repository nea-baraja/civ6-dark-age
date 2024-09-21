
--改营地和种植园的前置科技
update Improvements set PrereqTech = null 
	where ImprovementType = 'IMPROVEMENT_CAMP';

update Improvements set PrereqTech = 'TECH_POTTERY' 
	where ImprovementType = 'IMPROVEMENT_PLANTATION';

update Improvements set PrereqTech = 'TECH_SAILING' 
	where ImprovementType = 'IMPROVEMENT_FISHERY';


--仅改良资源的设施+1住房
UPDATE Improvements SET Housing = 2 
WHERE ImprovementType IN 
('IMPROVEMENT_PASTURE','IMPROVEMENT_PLANTATION','IMPROVEMENT_FISHING_BOATS');
--种植园和营地 初始产出改为1粮
UPDATE Improvement_YieldChanges SET YieldChange = 0 
WHERE (ImprovementType = 'IMPROVEMENT_PLANTATION' OR ImprovementType = 'IMPROVEMENT_CAMP') AND YieldType = 'YIELD_GOLD';

insert or replace into Improvement_YieldChanges(ImprovementType,	YieldType,	YieldChange) values
	('IMPROVEMENT_PLANTATION',	'YIELD_FOOD',	1),
	('IMPROVEMENT_CAMP',		'YIELD_FOOD',	1);

--改良产出随科技增长
delete from Improvement_BonusYieldChanges where ImprovementType in (
	--'IMPROVEMENT_FARM',
	--'IMPROVEMENT_PLANTATION',
	--'IMPROVEMENT_CAMP',
	'IMPROVEMENT_PASTURE'
	--'IMPROVEMENT_QUARRY',
	--'IMPROVEMENT_MINE',
	--'IMPROVEMENT_LUMBER_MILL',
	--'IMPROVEMENT_FISHING_BOATS'
	);

-- insert or replace into Improvement_BonusYieldChanges
-- 	(Id,	ImprovementType,						YieldType,				BonusYieldChange,	PrereqCivic,					PrereqTech)
-- values
-- 	(600,	'IMPROVEMENT_PASTURE',					'YIELD_PRODUCTION',			1,					null,						'TECH_HORSEBACK_RIDING');
--改农场和矿山的无资源建造到指定科技
update Improvement_ValidTerrains set PrereqTech = 'TECH_POTTERY' 
	where ImprovementType = 'IMPROVEMENT_FARM' and TerrainType in ('TERRAIN_PLAINS', 'TERRAIN_GRASS');

update Improvement_ValidFeatures set PrereqTech = 'TECH_POTTERY' 
	where ImprovementType = 'IMPROVEMENT_FARM' and FeatureType in ('FEATURE_FLOODPLAINS', 'FEATURE_FLOODPLAINS_PLAINS', 'FEATURE_FLOODPLAINS_GRASSLAND');

update Improvement_ValidTerrains set PrereqTech = 'TECH_IRRIGATION', PrereqCivic = NULL
	where ImprovementType = 'IMPROVEMENT_FARM' and TerrainType in ('TERRAIN_PLAINS_HILLS', 'TERRAIN_GRASS_HILLS');

delete from Improvement_ValidTerrains 
	where ImprovementType = 'IMPROVEMENT_MINE' and TerrainType not in ('TERRAIN_GRASS_HILLS', 'TERRAIN_PLAINS_HILLS'); 

update Improvement_ValidTerrains set PrereqTech = 'TECH_BRONZE_WORKING' 
	where ImprovementType = 'IMPROVEMENT_MINE' and TerrainType in ('TERRAIN_GRASS_HILLS', 'TERRAIN_PLAINS_HILLS');

insert or replace into Improvement_ValidTerrains(ImprovementType, TerrainType, PrereqTech) values
	('IMPROVEMENT_MINE',		'TERRAIN_PLAINS',		'TECH_IRON_WORKING'),
	('IMPROVEMENT_MINE',		'TERRAIN_GRASS',		'TECH_IRON_WORKING');


update Improvement_ValidResources set MustRemoveFeature = 0 where ImprovementType = 'IMPROVEMENT_FARM';
insert or replace into Improvement_ValidResources(ImprovementType, ResourceType, MustRemoveFeature) values
	('IMPROVEMENT_PLANTATION', 'RESOURCE_HERB', 0);

insert or replace into Improvement_ValidResources
    (ImprovementType,      ResourceType,           MustRemoveFeature)
values
    ('IMPROVEMENT_CAMP',   		'RESOURCE_CRABS',       0),
    ('IMPROVEMENT_FISHERY',   	'RESOURCE_CRABS',       0),
    ('IMPROVEMENT_FISHERY',   	'RESOURCE_FISH',       	0),
    ('IMPROVEMENT_QUARRY',   	'RESOURCE_JADE',       	0);
  

delete from Improvement_ValidResources 
	where ImprovementType = 'IMPROVEMENT_MINE' and ResourceType = 'RESOURCE_JADE';

--部分渔船资源改为渔场改良
delete from Improvement_ValidResources 
	where ImprovementType = 'IMPROVEMENT_FISHING_BOATS' and ResourceType in ('RESOURCE_CRABS', 'RESOURCE_FISH');
--删除渔场的相邻资源加食物
delete from Improvement_Adjacencies where YieldChangeId = 'Fishery_SeaResourceAdjacency';

update Improvements set TraitType = null where ImprovementType = 'IMPROVEMENT_FISHERY';


--营地建在无资源上
insert or replace into Improvement_ValidFeatures	
	(ImprovementType,				FeatureType,					PrereqTech,			PrereqCivic)
values

	('IMPROVEMENT_CAMP',		'FEATURE_FLOODPLAINS_PLAINS',		'TECH_ARCHERY',		null),
	('IMPROVEMENT_CAMP',		'FEATURE_FLOODPLAINS_GRASSLAND',	'TECH_ARCHERY',		null),
	('IMPROVEMENT_CAMP',		'FEATURE_FOREST',					'TECH_ARCHERY',		null),
	('IMPROVEMENT_CAMP',		'FEATURE_JUNGLE',					'TECH_ARCHERY',		null),
	('IMPROVEMENT_CAMP',		'FEATURE_MARSH',					'TECH_ARCHERY',		null);





--新改良辐射 辐射资源产出
insert into ImprovementModifiers(ImprovementType, ModifierId) select
	'IMPROVEMENT_FARM', 'FARM_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_FARM' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');

insert into ImprovementModifiers(ImprovementType, ModifierId) select
	'IMPROVEMENT_MINE', 'MINE_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_MINE' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY', 'RESOURCECLASS_STRATEGIC');

insert into ImprovementModifiers(ImprovementType, ModifierId) select
	'IMPROVEMENT_CAMP', 'CAMP_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_CAMP' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');

insert into ImprovementModifiers(ImprovementType, ModifierId) select
	'IMPROVEMENT_FISHERY', 'FISHERY_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_FISHERY' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');





insert into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) select  --rs 写在下面了
	'FARM_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',  'RS_PLOT_HAS_'||a.ResourceType ,'RS_FARM_ADJACENT_TO_OWNER'
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_FARM' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) select
	'MINE_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',  'RS_PLOT_HAS_'||a.ResourceType ,'RS_MINE_ADJACENT_TO_OWNER'
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_MINE' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY', 'RESOURCECLASS_STRATEGIC');

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) select
	'CAMP_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',  'RS_PLOT_HAS_'||a.ResourceType ,'RS_CAMP_ADJACENT_TO_OWNER'
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_CAMP' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) select
	'FISHERY_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',  'RS_PLOT_HAS_'||a.ResourceType ,'RS_FISHERY_ADJACENT_TO_OWNER'
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_FISHERY' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');




--假设资源只有一种产出
insert into ModifierArguments(ModifierId, Name, Value) select 
	'FARM_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'YieldType', YieldType
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_FARM' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');

insert into ModifierArguments(ModifierId, Name, Value) select 
	'MINE_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'YieldType', YieldType
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_MINE' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY', 'RESOURCECLASS_STRATEGIC');

insert into ModifierArguments(ModifierId, Name, Value) select 
	'CAMP_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'YieldType', YieldType
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_CAMP' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');

insert into ModifierArguments(ModifierId, Name, Value) select 
	'FISHERY_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'YieldType', YieldType
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_FISHERY' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');



insert into ModifierArguments(ModifierId, Name, Value) select 
	'FARM_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'Amount', YieldChange
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_FARM' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');

insert into ModifierArguments(ModifierId, Name, Value) select 
	'MINE_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'Amount', YieldChange
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_MINE' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY', 'RESOURCECLASS_STRATEGIC');

insert into ModifierArguments(ModifierId, Name, Value) select 
	'CAMP_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'Amount', YieldChange
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_CAMP' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');

insert into ModifierArguments(ModifierId, Name, Value) select 
	'FISHERY_SPREAD_'||a.ResourceType||'_BONUS_'||YieldType, 'Amount', YieldChange
	from Improvement_ValidResources a, Resource_YieldChanges b , Resources c where ImprovementType = 'IMPROVEMENT_FISHERY' and a.ResourceType = b.ResourceType
	and a.ResourceType = c.ResourceType and ResourceClassType in ('RESOURCECLASS_BONUS', 'RESOURCECLASS_LUXURY');








INSERT OR REPLACE INTO DistrictModifiers (DistrictType, ModifierId) VALUES 
--('DISTRICT_CITY_CENTER', 'DA_FARM_ADJACENT_FOOD'),
--('DISTRICT_CITY_CENTER', 'DA_MINE_ADJACENT_PRODUCTION'),
('DISTRICT_CITY_CENTER', 'DA_FISHING_BOATS_ADJACENT_FOOD'),
('DISTRICT_CITY_CENTER', 'DA_LUMBER_MILL_ADJACENT_PRODUCTION');

-- INSERT INTO ImprovementModifiers (ImprovementType, ModifierId) VALUES 
-- -- ('IMPROVEMENT_FARM', 			'DA_FARM_ADJACENT_FOOD'),  --旧改良辐射  辐射固定产出 因为有新的了所以注释掉了
-- -- ('IMPROVEMENT_MINE',			'DA_MINE_ADJACENT_PRODUCTION'),
-- -- ('IMPROVEMENT_CAMP',			'DA_CAMP_ADJACENT_GOLD'),

-- --('IMPROVEMENT_PLANTATION', 		'PLANTATION_HOUSE_FROM_GRANARY'),
-- --('IMPROVEMENT_CAMP', 			'CAMP_HOUSE_FROM_GRANARY'),
-- --('IMPROVEMENT_PASTURE', 		'PASTURE_HOUSE_FROM_GRANARY');
-- --('IMPROVEMENT_FISHING_BOATS', 		'FISHING_BOATS_HOUSE_FROM_LIGHTHOUSE');



INSERT OR REPLACE INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId,	SubjectStackLimit) VALUES 
('DA_FARM_ADJACENT_FOOD', 		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, 'RS_FARM_WITH_RESOURCE', 'RS_FARM_ADJACENT_TO_OWNER', 1),
('DA_MINE_ADJACENT_PRODUCTION', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, 'RS_MINE_WITH_RESOURCE', 'RS_MINE_ADJACENT_TO_OWNER', 1),
('DA_CAMP_ADJACENT_GOLD', 		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, 'RS_CAMP_WITH_RESOURCE', 'RS_CAMP_ADJACENT_TO_OWNER', 1);

INSERT OR REPLACE INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('DA_FISHING_BOATS_ADJACENT_FOOD', 	'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'RS_COAST_ADJACENT_TO_FISHING_BOATS'),
('DA_LUMBER_MILL_ADJACENT_PRODUCTION', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'RS_FOREST_ADJACENT_TO_LUMBER_MILL'),
('FARM_HOUSE_FROM_GRANARY', 	'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 0, 0, 0, NULL, 'RS_CITY_HAS_GRANARY'),
('PLANTATION_HOUSE_FROM_GRANARY','MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 0, 0, 0, NULL, 'RS_CITY_HAS_GRANARY'),
('CAMP_HOUSE_FROM_GRANARY', 	'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 0, 0, 0, NULL, 'RS_CITY_HAS_GRANARY'),
('PASTURE_HOUSE_FROM_GRANARY', 	'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 0, 0, 0, NULL, 'RS_CITY_HAS_GRANARY'),
('FISHING_BOATS_HOUSE_FROM_LIGHTHOUSE', 'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 0, 0, 0, NULL, 'RS_CITY_HAS_LIGHTHOUSE');

INSERT OR REPLACE INTO ModifierArguments (ModifierId, Name, Value) VALUES 
('DA_FARM_ADJACENT_FOOD', 		'Amount', '1'), 
('DA_FARM_ADJACENT_FOOD', 		'YieldType', 'YIELD_FOOD'),
('DA_MINE_ADJACENT_PRODUCTION', 'Amount', '1'), 
('DA_MINE_ADJACENT_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION'),
('DA_CAMP_ADJACENT_GOLD', 		'Amount', '3'), 
('DA_CAMP_ADJACENT_GOLD', 		'YieldType', 'YIELD_GOLD'),
('DA_FISHING_BOATS_ADJACENT_FOOD', 		'Amount', '1'), 
('DA_FISHING_BOATS_ADJACENT_FOOD', 		'YieldType', 'YIELD_FOOD'),
('DA_LUMBER_MILL_ADJACENT_PRODUCTION', 'Amount', '1'), 
('DA_LUMBER_MILL_ADJACENT_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION'),
('FARM_HOUSE_FROM_GRANARY', 	'Amount', 	'1'),
('PLANTATION_HOUSE_FROM_GRANARY', 'Amount', '1'),
('CAMP_HOUSE_FROM_GRANARY', 	'Amount', 	'1'),
('PASTURE_HOUSE_FROM_GRANARY', 	'Amount', 	'1'),
('FISHING_BOATS_HOUSE_FROM_LIGHTHOUSE', 'Amount', 	'2');


-- RequirementSets

INSERT OR REPLACE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
('RS_FARM_WITH_RESOURCE',		'REQUIREMENTSET_TEST_ALL'),
('RS_MINE_WITH_RESOURCE',		'REQUIREMENTSET_TEST_ALL'),
('RS_CAMP_WITH_RESOURCE',		'REQUIREMENTSET_TEST_ALL'),

('RS_FARM_ADJACENT_TO_OWNER',	'REQUIREMENTSET_TEST_ALL'),
('RS_MINE_ADJACENT_TO_OWNER',	'REQUIREMENTSET_TEST_ALL'),
('RS_CAMP_ADJACENT_TO_OWNER',	'REQUIREMENTSET_TEST_ALL'),
('RS_FISHERY_ADJACENT_TO_OWNER','REQUIREMENTSET_TEST_ALL'),

('RS_PLAIN_ADJACENT_TO_FARM', 	'REQUIREMENTSET_TEST_ALL'),
('RS_HILL_ADJACENT_TO_MINE',  	'REQUIREMENTSET_TEST_ALL'),
('RS_CITY_HAS_GRANARY', 		'REQUIREMENTSET_TEST_ALL'),
('RS_CITY_HAS_LIGHTHOUSE', 		'REQUIREMENTSET_TEST_ALL'),
('RS_COAST_ADJACENT_TO_FISHING_BOATS', 	'REQUIREMENTSET_TEST_ALL'),
('RS_FOREST_ADJACENT_TO_LUMBER_MILL',  	'REQUIREMENTSET_TEST_ALL');

INSERT OR REPLACE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
('RS_FARM_WITH_RESOURCE', 		'REQ_PLOT_HAS_IMPROVEMENT_FARM'), 
('RS_FARM_WITH_RESOURCE', 		'REQ_PLOT_HAS_RESOURCE'), 
('RS_MINE_WITH_RESOURCE', 		'REQ_PLOT_HAS_IMPROVEMENT_MINE'), 
('RS_MINE_WITH_RESOURCE', 		'REQ_PLOT_HAS_RESOURCE'),
('RS_CAMP_WITH_RESOURCE', 		'REQ_PLOT_HAS_IMPROVEMENT_CAMP'), 
('RS_CAMP_WITH_RESOURCE', 		'REQ_PLOT_HAS_RESOURCE'), 
('RS_FARM_ADJACENT_TO_OWNER', 	'REQ_PLOT_HAS_IMPROVEMENT_FARM'), 
('RS_FARM_ADJACENT_TO_OWNER', 	'REQ_OBJECT_AWAY_1_TILES'), 
('RS_MINE_ADJACENT_TO_OWNER', 	'REQ_PLOT_HAS_IMPROVEMENT_MINE'), 
('RS_MINE_ADJACENT_TO_OWNER', 	'REQ_OBJECT_AWAY_1_TILES'), 
('RS_CAMP_ADJACENT_TO_OWNER', 	'REQ_PLOT_HAS_IMPROVEMENT_CAMP'), 
('RS_CAMP_ADJACENT_TO_OWNER', 	'REQ_OBJECT_AWAY_1_TILES'), 
('RS_FISHERY_ADJACENT_TO_OWNER', 	'REQ_PLOT_HAS_IMPROVEMENT_FISHERY'), 
('RS_FISHERY_ADJACENT_TO_OWNER', 	'REQ_OBJECT_AWAY_1_TILES'), 

('RS_PLAIN_ADJACENT_TO_FARM', 	'REQ_ADJACENT_TO_FARM'), 
('RS_PLAIN_ADJACENT_TO_FARM', 	'REQ_IS_FOOD_PLAIN'),
('RS_HILL_ADJACENT_TO_MINE', 	'REQ_ADJACENT_TO_MINE'), 
('RS_HILL_ADJACENT_TO_MINE', 	'REQ_IS_MINE_HILL'),
('RS_CITY_HAS_GRANARY', 		'REQ_CITY_HAS_GRANARY'),
('RS_CITY_HAS_LIGHTHOUSE', 		'REQ_CITY_HAS_LIGHTHOUSE'),
('RS_COAST_ADJACENT_TO_FISHING_BOATS', 	'REQ_ADJACENT_TO_FISHING_BOATS'), 
('RS_COAST_ADJACENT_TO_FISHING_BOATS', 	'REQ_IS_TERRAIN_COAST'),
('RS_FOREST_ADJACENT_TO_LUMBER_MILL', 	'REQ_ADJACENT_TO_LUMBER_MILL'), 
('RS_FOREST_ADJACENT_TO_LUMBER_MILL', 	'REQ_IS_FEATURE_FOREST');

-- Requirements

INSERT OR REPLACE INTO Requirements (RequirementId, RequirementType) VALUES 
('REQ_ADJACENT_TO_FARM', 	'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES'), 
('REQ_IS_FOOD_PLAIN', 		'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES'),
('REQ_ADJACENT_TO_MINE', 	'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES'), 
('REQ_IS_MINE_HILL', 		'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES'),
('REQ_CITY_HAS_GRANARY', 	'REQUIREMENT_CITY_HAS_BUILDING'),
('REQ_ADJACENT_TO_FISHING_BOATS', 	'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES'), 
('REQ_ADJACENT_TO_LUMBER_MILL', 	'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES'), 
('REQ_CITY_HAS_LIGHTHOUSE', 'REQUIREMENT_CITY_HAS_BUILDING');

INSERT OR REPLACE INTO RequirementArguments (RequirementId, Name, Value) VALUES 
('REQ_ADJACENT_TO_FARM', 	'ImprovementType', 	'IMPROVEMENT_FARM'), 
('REQ_IS_FOOD_PLAIN', 		'TerrainClass', 	'TERRAIN_CLASS_FOOD_PLAINS'),
('REQ_ADJACENT_TO_MINE', 	'ImprovementType', 	'IMPROVEMENT_MINE'), 
('REQ_IS_MINE_HILL', 		'TerrainClass', 	'TERRAIN_CLASS_MINE_HILLS'),
('REQ_CITY_HAS_GRANARY', 	'BuildingType', 	'BUILDING_GRANARY'),
('REQ_ADJACENT_TO_FISHING_BOATS', 	'ImprovementType', 	'IMPROVEMENT_FISHING_BOATS'), 
('REQ_ADJACENT_TO_LUMBER_MILL', 	'ImprovementType', 	'IMPROVEMENT_LUMBER_MILL'), 
('REQ_CITY_HAS_LIGHTHOUSE', 'BuildingType', 	'BUILDING_LIGHTHOUSE');
