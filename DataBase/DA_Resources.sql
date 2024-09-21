insert INTO Types(Type, Kind) values
	('RESOURCE_HERB', 		'KIND_RESOURCE'),

	('RESOURCE_CIRCUS', 	'KIND_RESOURCE'),
	('RESOURCE_OLYMPIC', 	'KIND_RESOURCE'),
	('RESOURCE_WRESTLE', 	'KIND_RESOURCE');


insert into Resources(ResourceType, Name, ResourceClassType, Frequency) values
	('RESOURCE_HERB', 'LOC_RESOURCE_HERB_NAME', 'RESOURCECLASS_BONUS', 10);

insert into Resources(ResourceType, Name, ResourceClassType, Frequency, Happiness) values
	('RESOURCE_CIRCUS', 	'LOC_RESOURCE_CIRCUS_NAME', 	'RESOURCECLASS_LUXURY', 0, 4),
	('RESOURCE_OLYMPIC', 	'LOC_RESOURCE_OLYMPIC_NAME', 	'RESOURCECLASS_LUXURY', 0, 4),
	('RESOURCE_WRESTLE', 	'LOC_RESOURCE_WRESTLE_NAME', 	'RESOURCECLASS_LUXURY', 0, 4);

insert or replace into Resource_ValidTerrains(ResourceType, TerrainType) values
	('RESOURCE_HERB', 'TERRAIN_TUNDRA'),
	('RESOURCE_HERB', 'TERRAIN_TUNDRA_HILLS');

insert or replace into Resource_ValidFeatures(ResourceType, FeatureType) values
	('RESOURCE_HERB', 	'FEATURE_JUNGLE'),
	('RESOURCE_HERB', 	'FEATURE_FOREST'),
	('RESOURCE_HERB', 	'FEATURE_MARSH'),
	('RESOURCE_CRABS', 	'FEATURE_FLOODPLAINS_GRASSLAND'),
	('RESOURCE_CRABS', 	'FEATURE_FLOODPLAINS_PLAINS');






UPDATE Resources SET SeaFrequency =5 WHERE ResourceType ='RESOURCE_CRABS';
UPDATE Resources SET SeaFrequency = 25 WHERE ResourceType ='RESOURCE_FISH';

update Resources set Frequency = 6 where ResourceType in ('RESOURCE_RICE',	'RESOURCE_MAIZE', 'RESOURCE_WHEAT');
UPDATE Resources SET Frequency = 16 WHERE ResourceType in ('RESOURCE_STONE','RESOURCE_COPPER', 'RESOURCE_CATTLE');
UPDATE Resources SET Frequency = 10 WHERE ResourceType in ('RESOURCE_DEER', 'RESOURCE_BANANAS');

update Resources set Frequency = 50 where ResourceType ='RESOURCE_CRABS';


-- UPDATE Resources SET SeaFrequency = SeaFrequency + 1 WHERE SeaFrequency <> 0 AND ResourceClassType = 'RESOURCECLASS_LUXURY';--bug
UPDATE Resources SET Frequency = Frequency + 1 WHERE Frequency <> 0 AND ResourceClassType = 'RESOURCECLASS_LUXURY';
-- UPDATE Resources SET SeaFrequency = SeaFrequency + 2 WHERE SeaFrequency <> 0 AND ResourceClassType = 'RESOURCECLASS_STRATEGIC';
UPDATE Resources SET Frequency = Frequency + 50 WHERE Frequency <> 0 AND ResourceClassType = 'RESOURCECLASS_STRATEGIC';

DELETE FROM Resource_YieldChanges WHERE ResourceType IN (SELECT ResourceType FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_LUXURY' or ResourceClassType = 'RESOURCECLASS_BONUS');
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType,				YieldType,					YieldChange)	VALUES

('RESOURCE_IRON',			'YIELD_PRODUCTION',			1),

('RESOURCE_BANANAS',		'YIELD_FOOD',				1),
('RESOURCE_CATTLE',			'YIELD_FOOD',				1),
('RESOURCE_COPPER',			'YIELD_PRODUCTION',			1),
('RESOURCE_CRABS',			'YIELD_GOLD',				3),
('RESOURCE_DEER',			'YIELD_PRODUCTION',			1),
('RESOURCE_FISH',			'YIELD_FOOD',				1),
('RESOURCE_RICE',			'YIELD_FOOD',				1),
('RESOURCE_SHEEP',			'YIELD_FOOD',				1),
('RESOURCE_STONE',			'YIELD_PRODUCTION',			1),
('RESOURCE_WHEAT',			'YIELD_FOOD',				1),

('RESOURCE_TEA',			'YIELD_SCIENCE',			1),
('RESOURCE_TURTLES',		'YIELD_SCIENCE',			1),
('RESOURCE_MERCURY',		'YIELD_SCIENCE',			1),
('RESOURCE_HERB',			'YIELD_SCIENCE',			1),


('RESOURCE_MARBLE',			'YIELD_CULTURE',			1),
('RESOURCE_COFFEE',			'YIELD_CULTURE',			1),
('RESOURCE_SILK',			'YIELD_CULTURE',			1),
('RESOURCE_JADE',			'YIELD_CULTURE',			1),
('RESOURCE_AMBER',			'YIELD_CULTURE',			1),

('RESOURCE_CITRUS',			'YIELD_FOOD',				1),
('RESOURCE_WINE',			'YIELD_FOOD',				1),
('RESOURCE_SUGAR',			'YIELD_FOOD',				1),
('RESOURCE_SPICES',			'YIELD_FOOD',				1),
('RESOURCE_SALT',			'YIELD_FOOD',				1),

('RESOURCE_GYPSUM',			'YIELD_PRODUCTION',			1),
('RESOURCE_IVORY',			'YIELD_PRODUCTION',			1),
('RESOURCE_OLIVES',			'YIELD_PRODUCTION',			1),

('RESOURCE_WHALES',			'YIELD_GOLD',				3),
('RESOURCE_COCOA',			'YIELD_GOLD',				3),
('RESOURCE_COTTON',			'YIELD_GOLD',				3),
('RESOURCE_FURS',			'YIELD_GOLD',				3),
('RESOURCE_TRUFFLES',		'YIELD_GOLD',				3),
('RESOURCE_SILVER',			'YIELD_GOLD',				3),
('RESOURCE_DIAMONDS',		'YIELD_GOLD',				3),

('RESOURCE_DYES',			'YIELD_FAITH',				2),
('RESOURCE_INCENSE',		'YIELD_FAITH',				2),
('RESOURCE_TOBACCO',		'YIELD_FAITH',				2),
('RESOURCE_PEARLS',			'YIELD_FAITH',				2);

insert into Resource_YieldChanges(ResourceType,	YieldType,	YieldChange) 
	select 'RESOURCE_HONEY',	'YIELD_FOOD', 1 
	where exists (select * from Resources where ResourceType == 'RESOURCE_HONEY');

insert into Resource_YieldChanges(ResourceType,	YieldType,	YieldChange) 
	select 'RESOURCE_MAIZE',	'YIELD_FOOD', 1
	where exists (select * from Resources where ResourceType == 'RESOURCE_MAIZE');


INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources  WHERE ResourceType ='RESOURCE_P0K_PENGUINS';--企鹅

INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_CVS_POMEGRANATES';--石榴

INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_CULTURE','1' FROM Resources WHERE ResourceType ='RESOURCE_P0K_PAPYRUS';--纸莎草

INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_SUK_CHEESE';--奶酪

INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_SUK_OBSIDIAN';--黑曜石
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_SUK_SHARK';--鲨鱼
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType ,'YIELD_GOLD','6'FROM Resources WHERE ResourceType ='RESOURCE_GOLD';--金砂
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_P0K_MAPLE';--枫糖
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_P0K_OPAL';--欧泊
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_P0K_PLUMS';--李子
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_LEU_P0K_CAPYBARAS';--水豚
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_LEU_P0K_COCA';--古柯
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_LEU_P0K_LLAMAS';--大羊驼
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_LEU_P0K_QUINOA';--藜麦
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_LEU_P0K_YERBAMATE';--耶巴马黛茶
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_SUK_CORAL';--珊瑚
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_SUK_LOBSTER';--龙虾
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','6' FROM Resources WHERE ResourceType ='RESOURCE_SUK_RAYS';--鱼子酱
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_SUK_ABALONE';--ABALONE
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_SUK_CAVIAR';--CAVIAR
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_LAPIS';--青金石
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_PLATINUM';--铂
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FAITH','2' FROM Resources WHERE ResourceType ='RESOURCE_SANDALWOOD';--檀香木
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_CULTURE','1' FROM Resources WHERE ResourceType ='RESOURCE_MAPLE';--糖槭
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_CULTURE','1' FROM Resources WHERE ResourceType ='RESOURCE_POPPIES';--罂粟
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_CAVIAR';--鲟鱼
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_CULTURE','1' FROM Resources WHERE ResourceType ='RESOURCE_CORAL';--珊瑚
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_BAMBOO';--竹
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FAITH','2' FROM Resources WHERE ResourceType ='RESOURCE_EBONY';--乌木
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_CULTURE','1' FROM Resources WHERE ResourceType ='RESOURCE_SAKURA';--樱花
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','6' FROM Resources WHERE ResourceType ='RESOURCE_CASHMERE';--山羊绒
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_TRAVERTINE';--洞石
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_ALABASTER';--汉白玉
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','6' FROM Resources WHERE ResourceType ='RESOURCE_GOLD2';--砂金
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_SCIENCE','1' FROM Resources WHERE ResourceType ='RESOURCE_SPONGE';--海绵
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_SEA_URCHIN';--海胆
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_ORCA';--虎鲸
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_CULTURE','1' FROM Resources WHERE ResourceType ='RESOURCE_WOLF';--狼
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_CULTURE','1' FROM Resources WHERE ResourceType ='RESOURCE_TIGER';--老虎
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_CULTURE','1' FROM Resources WHERE ResourceType ='RESOURCE_LION';--狮子
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_SCIENCE','1' FROM Resources WHERE ResourceType ='RESOURCE_TOXINS';--生物毒素
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','6' FROM Resources WHERE ResourceType ='RESOURCE_SAFFRON';--番红花
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_STRAWBERRY';--草莓
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_RUBY';--红宝石


INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_SUK_CAMEL';--骆驼
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_SUK_CAMEL';--骆驼
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_SUK_CAMEL';--骆驼
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_DLV_BISON';--野牛
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_JNR_PEAT';--泥炭
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_LEU_P0K_POTATOES';--马铃薯
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_LEAD';--铅锌矿
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_OAK';--橡木
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_LIMESTONE';--白云石
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_BERRIES';--浆果
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','3' FROM Resources WHERE ResourceType ='RESOURCE_PINE';--松木
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_TIN';--锡矿
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_RUBY';--橡胶
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_HAM';--火腿
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_PRODUCTION','1' FROM Resources WHERE ResourceType ='RESOURCE_MUSSELS';--青口贝
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FAITH','2' FROM Resources WHERE ResourceType ='RESOURCE_MUSHROOMS';--蘑菇
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','2' FROM Resources WHERE ResourceType ='RESOURCE_DATES';--椰枣
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_TOMATO';--番茄
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_FOOD','1' FROM Resources WHERE ResourceType ='RESOURCE_BARLEY';--青稞
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType  ,YieldType  ,YieldChange)
SELECT ResourceType,'YIELD_GOLD','3' FROM Resources WHERE ResourceType ='RESOURCE_BARLEY';--青稞










update Resource_Harvests set Amount = 40 where YieldType = 'YIELD_FOOD';
update Resource_Harvests set Amount = 40 where YieldType = 'YIELD_PRODUCTION';
update Resource_Harvests set Amount = 80 where YieldType = 'YIELD_GOLD';

update Resource_Consumption set ImprovedExtractionRate = 3 where ResourceType in ('RESOURCE_HORSES',	'RESOURCE_IRON');

insert or replace into Resource_Harvests (ResourceType, YieldType, Amount, PrereqTech) select
	ResourceType, 'YIELD_PRODUCTION', 40, PrereqTech from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or replace into Resource_Harvests (ResourceType, YieldType, Amount, PrereqTech) select
	ResourceType, 'YIELD_GOLD', 80, NULL from Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or replace into Resource_Harvests (ResourceType, YieldType, Amount, PrereqTech) values
	('RESOURCE_ANTIQUITY_SITE',	'YIELD_CULTURE',	40,		NULL),
	('RESOURCE_SHIPWRECK',		'YIELD_CULTURE',	40,		NULL);

update Resource_Harvests set PrereqTech = 'TECH_SAILING' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_FISHING_BOATS');
update Resource_Harvests set PrereqTech = 'TECH_IRRIGATION' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_PLANTATION');
update Resource_Harvests set PrereqTech = 'TECH_MASONRY' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_QUARRY');
update Resource_Harvests set PrereqTech = 'TECH_MINING' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_MINE');
update Resource_Harvests set PrereqTech = 'TECH_ANIMAL_HUSBANDRY' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_PASTURE');
update Resource_Harvests set PrereqTech = 'TECH_ANIMAL_HUSBANDRY' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_CAMP');
update Resource_Harvests set PrereqTech = 'TECH_POTTERY' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_FARM');
update Resource_Harvests set PrereqTech = 'TECH_BRONZE_WORKING' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_LUMBER_MILL');

delete from Resource_Harvests where
	   ResourceType = 'RESOURCE_CLOVES'
	or ResourceType = 'RESOURCE_CINNAMON'
	or ResourceType = 'RESOURCE_TOYS'
	or ResourceType = 'RESOURCE_COSMETICS'
	or ResourceType = 'RESOURCE_PERFUME'
	or ResourceType = 'RESOURCE_JEANS';


-- 刷战略
create table DA_GuaranteedStrategicResources (
	ResourceType text not null primary key,
	Distance int not null,
	foreign key (ResourceType) references Resources (ResourceType) on delete cascade on update cascade
);
insert or replace into DA_GuaranteedStrategicResources
	(ResourceType,			Distance)
values
	('RESOURCE_HORSES',		6),
	('RESOURCE_IRON',		6),
	('RESOURCE_NITER',		9),
	('RESOURCE_ALUMINUM',	12),
	('RESOURCE_COAL',		12),
	('RESOURCE_OIL',		12),
	('RESOURCE_URANIUM',	12);








