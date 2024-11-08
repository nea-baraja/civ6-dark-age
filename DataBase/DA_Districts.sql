
/*
insert or replace into Types(Type, Kind) values
	('DISTRICT_TEST',	'KIND_DISTRICT');

insert or replace into Districts(DistrictType, Name, Description, Cost,
 RequiresPlacement, RequiresPopulation, NoAdjacentCity, Aqueduct, InternalOnly, CaptureRemovesBuildings, CaptureRemovesCityDefenses, PlunderType, 
 PlunderAmount, MilitaryDomain, Appeal, Housing, Entertainment, OnePerCity, Maintenance, AirSlots, CitizenSlots, MaxPerPlayer,
 PrereqTech) values
('DISTRICT_TEST', 'LOC_DISTRICT_TEST_NAME', 'LOC_DISTRICT_TEST_DESCRIPTION', 1,
1, 0, 0, 0, 0, 0, 0, 'YIELD_GOLD',
1, 'NO_DOMAIN', 0, 0, 0, 1, 0, 0, 0, 1,
'TECH_FUTURE_TECH');  

insert or replace into MutuallyExclusiveDistricts(District, MutuallyExclusiveDistrict) values
	('DISTRICT_HOLY_SITE', 'DISTRICT_TEST'),
	('DISTRICT_TEST', 'DISTRICT_HOLY_SITE');  */


--水利区域由工人建造 而非城市
insert or replace into MutuallyExclusiveDistricts(District, MutuallyExclusiveDistrict) values
	('DISTRICT_AQUEDUCT',		'DISTRICT_CITY_CENTER'),
	('DISTRICT_BATH',			'DISTRICT_CITY_CENTER'),
	('DISTRICT_DAM',			'DISTRICT_CITY_CENTER');



-- 统一描述tag
update Districts set Description = 'LOC_DA_'||DistrictType||'_DESCRIPTION'
 WHERE DistrictType = 'DISTRICT_HOLY_SITE'				--圣地
	OR DistrictType = 'DISTRICT_CAMPUS'					--学院
	OR DistrictType = 'DISTRICT_ENCAMPMENT'				--军营
	OR DistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
	OR DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
	OR DistrictType = 'DISTRICT_THEATER'				--剧院
	OR DistrictType = 'DISTRICT_AQUEDUCT'				--水渠
	OR DistrictType = 'DISTRICT_DAM'					--堤坝	
	-- OR DistrictType = 'DISTRICT_BATH'					--罗马浴场 --不要改了 前端也要用这个tag
	--OR DistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
	--OR DistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
;

--统一涨价模型
UPDATE Districts SET CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 20, Cost = 40 
 WHERE DistrictType = 'DISTRICT_HOLY_SITE'				--圣地
	OR DistrictType = 'DISTRICT_CAMPUS'					--学院
	OR DistrictType = 'DISTRICT_ENCAMPMENT'				--军营
	OR DistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
	OR DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
	OR DistrictType = 'DISTRICT_THEATER'				--剧院
	OR DistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
	OR DistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
;

-- unique districts --统一涨价模型
UPDATE Districts SET CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 10, Cost = 40 WHERE DistrictType in 
(SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE
	ReplacesDistrictType = 'DISTRICT_HOLY_SITE'					--圣地
	OR ReplacesDistrictType = 'DISTRICT_CAMPUS'					--学院
	OR ReplacesDistrictType = 'DISTRICT_ENCAMPMENT'				--军营
	OR ReplacesDistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
	OR ReplacesDistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
	OR ReplacesDistrictType = 'DISTRICT_THEATER'				--剧院
	OR ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
	OR ReplacesDistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
);


-- UPDATE Districts SET CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 30, Cost = 60 
--  WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE' or DistrictType in 
-- (SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE');

-- --测试免费区域
-- --统一涨价模型
-- UPDATE Districts SET CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 0, Cost = 0 
--  WHERE DistrictType = 'DISTRICT_HOLY_SITE'				--圣地
-- 	OR DistrictType = 'DISTRICT_CAMPUS'					--学院
-- 	OR DistrictType = 'DISTRICT_ENCAMPMENT'				--军营
-- 	OR DistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
-- 	OR DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
-- 	OR DistrictType = 'DISTRICT_THEATER'				--剧院
-- 	OR DistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
-- 	OR DistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
-- ;

-- -- unique districts --统一涨价模型
-- UPDATE Districts SET CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 0, Cost = 0 WHERE DistrictType in 
-- (SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE
-- 	ReplacesDistrictType = 'DISTRICT_HOLY_SITE'					--圣地
-- 	OR ReplacesDistrictType = 'DISTRICT_CAMPUS'					--学院
-- 	OR ReplacesDistrictType = 'DISTRICT_ENCAMPMENT'				--军营
-- 	OR ReplacesDistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
-- 	OR ReplacesDistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
-- 	OR ReplacesDistrictType = 'DISTRICT_THEATER'				--剧院
-- 	OR ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
-- 	OR ReplacesDistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
-- );


-- UPDATE Districts SET CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 0, Cost = 0 
--  WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE' or DistrictType in 
-- (SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE');




--统一涨价模型
update Districts set CostProgressionModel = 'NO_COST_PROGRESSION', CostProgressionParam1 = 0
 where DistrictType = 'DISTRICT_GOVERNMENT'				--政府区
	or DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER'		--外交区
	or DistrictType = 'DISTRICT_AERODROME'				--空港
	or DistrictType = 'DISTRICT_HARBOR'					--港口
	or DistrictType = 'DISTRICT_AQUEDUCT'				--水渠
	or DistrictType = 'DISTRICT_NEIGHBORHOOD'			--社区
	or DistrictType = 'DISTRICT_CANAL'					--运河
	or DistrictType = 'DISTRICT_DAM'					--大坝
	or DistrictType = 'DISTRICT_THANH'					--城池（越南）
	or DistrictType = 'DISTRICT_PRESERVE'				--保护区
--	or DistrictType = 'DISTRICT_HIPPODROME'				--跑马场(拜占庭)
;

update Districts set Cost = 60 where DistrictType = 'DISTRICT_GOVERNMENT';
update Districts set Cost = 60 where DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER';
update Districts set Cost = 50 where DistrictType = 'DISTRICT_HARBOR';
update Districts set Cost = 90 where DistrictType = 'DISTRICT_AQUEDUCT';
update Districts set Cost = 75 where DistrictType = 'DISTRICT_PRESERVE';
update Districts set CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 0, Cost = 40 where DistrictType in 
(select CivUniqueDistrictType from DistrictReplaces where
	ReplacesDistrictType = 'DISTRICT_AQUEDUCT'
	or ReplacesDistrictType = 'DISTRICT_HARBOR'
	or ReplacesDistrictType = 'DISTRICT_PRESERVE'
	or ReplacesDistrictType = 'DISTRICT_GOVERNMENT'
	or ReplacesDistrictType = 'DISTRICT_DIPLOMATIC_QUARTER'
);
--统一涨价模型
update Districts set CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 0, Cost = 90 where DistrictType in 
(select CivUniqueDistrictType from DistrictReplaces where ReplacesDistrictType = 'DISTRICT_NEIGHBORHOOD');

update Districts set Cost = 60 where DistrictType = 'DISTRICT_THANH';

update Districts set Cost = 150 where DistrictType = 'DISTRICT_AERODROME';
update Districts set Cost = 200 where DistrictType = 'DISTRICT_CANAL';
update Districts set Cost = 200 where DistrictType = 'DISTRICT_DAM';


update Districts set PrereqTech = 'TECH_SAILING' where DistrictType = 'DISTRICT_HARBOR' or DistrictType in 
(select CivUniqueDistrictType from DistrictReplaces where
 ReplacesDistrictType = 'DISTRICT_HARBOR');

update Districts set PrereqTech = 'TECH_CONSTRUCTION' where DistrictType = 'DISTRICT_INDUSTRIAL_ZONE' or DistrictType in 
(select CivUniqueDistrictType from DistrictReplaces where
 ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE');
-- Happiness adjust
update Districts set Entertainment = 3 where DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX' or DistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX';
update Districts set Entertainment = 4 where DistrictType in (select CivUniqueDistrictType from DistrictReplaces
		where ReplacesDistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX' or ReplacesDistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX');

update Districts set Entertainment = 3 where DistrictType = 'DISTRICT_BATH';


insert or replace into District_CitizenGreatPersonPoints
	(DistrictType,						GreatPersonClassType,				PointsPerTurn)
values
	("DISTRICT_CAMPUS",					"GREAT_PERSON_CLASS_SCIENTIST",		1),
	("DISTRICT_COMMERCIAL_HUB",			"GREAT_PERSON_CLASS_MERCHANT",		1),
	("DISTRICT_ENCAMPMENT",				"GREAT_PERSON_CLASS_GENERAL",		1),
	("DISTRICT_HARBOR",					"GREAT_PERSON_CLASS_ADMIRAL",		1),
	("DISTRICT_HOLY_SITE",				"GREAT_PERSON_CLASS_PROPHET",		1),
	("DISTRICT_INDUSTRIAL_ZONE",		"GREAT_PERSON_CLASS_ENGINEER",		1),
	("DISTRICT_THEATER",				"GREAT_PERSON_CLASS_WRITER",		1),
	("DISTRICT_THEATER",				"GREAT_PERSON_CLASS_ARTIST",		1),
	("DISTRICT_THEATER",				"GREAT_PERSON_CLASS_MUSICIAN",		1);
	-- ("DISTRICT_AQUEDUCT",				"GREAT_PERSON_CLASS_ENGINEER",		1);

-- UD support
insert or ignore into District_CitizenGreatPersonPoints (DistrictType, GreatPersonClassType, PointsPerTurn)
select b.CivUniqueDistrictType,	a.GreatPersonClassType,	a.PointsPerTurn
from District_CitizenGreatPersonPoints a, DistrictReplaces b where a.DistrictType = b.ReplacesDistrictType;

update Districts set CitizenSlots = 1, Housing = 1 
 where DistrictType = 'DISTRICT_CAMPUS'
 	or DistrictType = 'DISTRICT_COMMERCIAL_HUB'
 	or DistrictType = 'DISTRICT_ENCAMPMENT'
 	or DistrictType = 'DISTRICT_HARBOR'
 	or DistrictType = 'DISTRICT_HOLY_SITE'
 	or DistrictType = 'DISTRICT_INDUSTRIAL_ZONE'
 	or DistrictType = 'DISTRICT_THEATER'
 	or DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX';
 	-- or DistrictType = 'DISTRICT_AQUEDUCT';

update Districts set CitizenSlots = 1, Housing = 1  where DistrictType in 
(select CivUniqueDistrictType from DistrictReplaces 
 where ReplacesDistrictType = 'DISTRICT_CAMPUS'
 	or ReplacesDistrictType = 'DISTRICT_COMMERCIAL_HUB'
 	or ReplacesDistrictType = 'DISTRICT_ENCAMPMENT'
 	or ReplacesDistrictType = 'DISTRICT_HARBOR'
 	or ReplacesDistrictType = 'DISTRICT_HOLY_SITE'
 	or ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE'
 	or ReplacesDistrictType = 'DISTRICT_THEATER'
 	or ReplacesDistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX');
 	--or ReplacesDistrictType = 'DISTRICT_AQUEDUCT');

DELETE FROM District_CitizenYieldChanges 
WHERE DistrictType IN ('DISTRICT_CAMPUS', 'DISTRICT_COMMERCIAL_HUB', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR', 'DISTRICT_HOLY_SITE', 'DISTRICT_THEATER', 'DISTRICT_INDUSTRIAL_ZONE');

insert or replace into District_CitizenYieldChanges
	(DistrictType,				YieldType,			YieldChange)
values
	('DISTRICT_ENTERTAINMENT_COMPLEX',		'YIELD_CULTURE',	1),
	('DISTRICT_ENTERTAINMENT_COMPLEX',		'YIELD_GOLD',		3),

	('DISTRICT_CAMPUS',			'YIELD_SCIENCE',	2),
	('DISTRICT_COMMERCIAL_HUB',	'YIELD_GOLD',		6),
	('DISTRICT_ENCAMPMENT',		'YIELD_FOOD',		1),
	('DISTRICT_ENCAMPMENT',		'YIELD_PRODUCTION', 1),
	('DISTRICT_HARBOR',			'YIELD_GOLD',		3),
	('DISTRICT_HARBOR',			'YIELD_FOOD',		1),
	('DISTRICT_HOLY_SITE',		'YIELD_FAITH',		4),
	('DISTRICT_THEATER',		'YIELD_CULTURE',	2),
	('DISTRICT_INDUSTRIAL_ZONE','YIELD_PRODUCTION', 3);
	-- ('DISTRICT_AQUEDUCT',		'YIELD_FOOD', 		2),
	-- ('DISTRICT_AQUEDUCT',		'YIELD_PRODUCTION', 2);

update Districts set RequiresPopulation = 0 where DistrictType = 'DISTRICT_GOVERNMENT'
	or DistrictType in (select CivUniqueDistrictType from DistrictReplaces where ReplacesDistrictType = 'DISTRICT_GOVERNMENT');

--骑马也解锁军营  同时在DA_Techs.sql也有AdditionalUnlockables表
insert or replace into TechnologyModifiers(TechnologyType, ModifierId) select
	'TECH_HORSEBACK_RIDING', 'UNLOCK_'||DistrictType
	from Districts where DistrictType = 'DISTRICT_ENCAMPMENT' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_ENCAMPMENT');

insert or replace into Modifiers(ModifierId, ModifierType) select
	'UNLOCK_'||DistrictType, 'MODIFIER_PLAYER_ADJUST_DISTRICT_UNLOCK'
from Districts where DistrictType = 'DISTRICT_ENCAMPMENT' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_ENCAMPMENT');

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'UNLOCK_'||DistrictType, 'DistrictType', 	DistrictType
from Districts where DistrictType = 'DISTRICT_ENCAMPMENT' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_ENCAMPMENT');

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'UNLOCK_'||DistrictType, 'TechType', 	'TECH_HORSEBACK_RIDING'
from Districts where DistrictType = 'DISTRICT_ENCAMPMENT' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_ENCAMPMENT');

--工程也解锁工业区（原来是建造）  同时在DA_Techs.sql也有AdditionalUnlockables表
insert or replace into TechnologyModifiers(TechnologyType, ModifierId) select
	'TECH_ENGINEERING', 'UNLOCK_'||DistrictType
	from Districts where DistrictType = 'DISTRICT_INDUSTRIAL_ZONE' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE');

insert or replace into Modifiers(ModifierId, ModifierType) select
	'UNLOCK_'||DistrictType, 'MODIFIER_PLAYER_ADJUST_DISTRICT_UNLOCK'
from Districts where DistrictType = 'DISTRICT_INDUSTRIAL_ZONE' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE');

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'UNLOCK_'||DistrictType, 'DistrictType', 	DistrictType
from Districts where DistrictType = 'DISTRICT_INDUSTRIAL_ZONE' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE');

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'UNLOCK_'||DistrictType, 'TechType', 	'TECH_ENGINEERING'
from Districts where DistrictType = 'DISTRICT_INDUSTRIAL_ZONE' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE');


--帝国初期也解锁市政广场  同时在DA_Techs.sql也有AdditionalUnlockables表
insert or replace into CivicModifiers(CivicType, ModifierId) select
	'CIVIC_EARLY_EMPIRE', 'UNLOCK_'||DistrictType
	from Districts where DistrictType = 'DISTRICT_GOVERNMENT' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_GOVERNMENT');

insert or replace into Modifiers(ModifierId, ModifierType) select
	'UNLOCK_'||DistrictType, 'MODIFIER_PLAYER_ADJUST_DISTRICT_UNLOCK'
from Districts where DistrictType = 'DISTRICT_GOVERNMENT' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_GOVERNMENT');

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'UNLOCK_'||DistrictType, 'DistrictType', 	DistrictType
from Districts where DistrictType = 'DISTRICT_GOVERNMENT' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_GOVERNMENT');

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'UNLOCK_'||DistrictType, 'CivicType', 	'CIVIC_EARLY_EMPIRE'
from Districts where DistrictType = 'DISTRICT_GOVERNMENT' 
	or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_GOVERNMENT');


insert or replace into DistrictModifiers(DistrictType,				ModifierId) values
	('DISTRICT_AQUEDUCT',	'AQUEDUCT_CITY_GROWTH'),
	('DISTRICT_DAM',		'DAM_RIVER_GOLD'),
	('DISTRICT_DAM',		'DAM_RIVER_DISTRICT_FASTER');

insert or replace into Modifiers(ModifierId,		ModifierType,									SubjectRequirementSetId) values
	('AQUEDUCT_CITY_GROWTH',				'MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH',							null),
	('DAM_RIVER_GOLD',						'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',						'RS_IS_RIVER'),
	('DAM_RIVER_DISTRICT_FASTER',			'MODIFIER_SINGLE_CITY_ADJUST_RIVER_DISTRICT_PRODUCTION',			null);

insert or replace into ModifierArguments(ModifierId,			Name,			Value) values
	('AQUEDUCT_CITY_GROWTH',			'Amount',		20),
	('DAM_RIVER_GOLD',					'YieldType',	'YIELD_GOLD'),
	('DAM_RIVER_GOLD',					'Amount',		2),
	('DAM_RIVER_DISTRICT_FASTER',		'Amount',		30);



insert or replace into DistrictModifiers(DistrictType,				ModifierId) values
	('DISTRICT_CITY_CENTER',	'AQUEDUCT_FOOD_TO_PRODUCTION_COST_PRODUCTION'),
	('DISTRICT_CITY_CENTER',	'AQUEDUCT_FOOD_TO_PRODUCTION_ADD_FOOD'),
	('DISTRICT_CITY_CENTER',	'AQUEDUCT_FOOD_TO_PRODUCTION_COST_PRODUCTION_2'),
	('DISTRICT_CITY_CENTER',	'AQUEDUCT_FOOD_TO_PRODUCTION_ADD_FOOD_2'),

	('DISTRICT_CITY_CENTER',	'DAM_RIVER_FOOD'),
	('DISTRICT_CITY_CENTER',	'DAM_RIVER_DISTRICT_PRODUCTION'),
	('DISTRICT_CITY_CENTER',	'DAM_RIVER_FOOD_2'),
	('DISTRICT_CITY_CENTER',	'DAM_RIVER_DISTRICT_PRODUCTION_2');



insert or replace into Modifiers(ModifierId,		ModifierType,									SubjectRequirementSetId,	OwnerRequirementSetId) values
	('AQUEDUCT_FOOD_TO_PRODUCTION_COST_PRODUCTION',		'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',			'RS_CITY_HAS_DISTRICT_AQUEDUCT',	'RS_PROP_CITY_PRODUCTION_TO_FOOD_1'),
	('AQUEDUCT_FOOD_TO_PRODUCTION_ADD_FOOD',			'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',			'RS_CITY_HAS_DISTRICT_AQUEDUCT',	'RS_PROP_CITY_PRODUCTION_TO_FOOD_1'),
	('AQUEDUCT_FOOD_TO_PRODUCTION_COST_PRODUCTION_2',	'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',			'RS_CITY_HAS_DISTRICT_AQUEDUCT',	'RS_PROP_CITY_PRODUCTION_TO_FOOD_2'),
	('AQUEDUCT_FOOD_TO_PRODUCTION_ADD_FOOD_2',			'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',			'RS_CITY_HAS_DISTRICT_AQUEDUCT',	'RS_PROP_CITY_PRODUCTION_TO_FOOD_2'),
	('DAM_RIVER_FOOD',									'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_IS_RIVER',						'RS_PROP_DAM_FOOD_1'),
	('DAM_RIVER_DISTRICT_PRODUCTION',					'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',	'RS_RIVER_DISTRICT',				'RS_PROP_DAM_PRODUCTION_1'),
	('DAM_RIVER_FOOD_2',								'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_IS_RIVER',						'RS_PROP_DAM_FOOD_2'),
	('DAM_RIVER_DISTRICT_PRODUCTION_2',					'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',	'RS_RIVER_DISTRICT',				'RS_PROP_DAM_PRODUCTION_2'),

	('AQUEDUCT_CLEAR_FRESH_HOUSING',					'MODIFIER_PLAYER_CITY_ADJUST_NO_FRESH_WATER_HOUSING',			NULL, NULL),
	('AQUEDUCT_ADD_FRESH_HOUSING',						'MODIFIER_PLAYER_CITY_ADJUST_WATER_HOUSING',					NULL, NULL);



insert or replace into ModifierArguments(ModifierId,			Name,			Value) values
	('AQUEDUCT_CLEAR_FRESH_HOUSING',						'NoHousing',			1),
	('AQUEDUCT_ADD_FRESH_HOUSING',							'Amount',				4),


	('AQUEDUCT_FOOD_TO_PRODUCTION_COST_PRODUCTION',			'Amount',			-1),
	('AQUEDUCT_FOOD_TO_PRODUCTION_COST_PRODUCTION',			'YieldType',		'YIELD_PRODUCTION'),
	('AQUEDUCT_FOOD_TO_PRODUCTION_ADD_FOOD',				'Amount',			1),
	('AQUEDUCT_FOOD_TO_PRODUCTION_ADD_FOOD',				'YieldType',		'YIELD_FOOD'),
	('AQUEDUCT_FOOD_TO_PRODUCTION_COST_PRODUCTION_2',		'Amount',			-1),
	('AQUEDUCT_FOOD_TO_PRODUCTION_COST_PRODUCTION_2',		'YieldType',		'YIELD_PRODUCTION'),
	('AQUEDUCT_FOOD_TO_PRODUCTION_ADD_FOOD_2',				'Amount',			1),
	('AQUEDUCT_FOOD_TO_PRODUCTION_ADD_FOOD_2',				'YieldType',		'YIELD_FOOD'),
	('DAM_RIVER_FOOD',										'YieldType',		'YIELD_FOOD'),
	('DAM_RIVER_FOOD',										'Amount',			1),
	('DAM_RIVER_DISTRICT_PRODUCTION',						'YieldType',		'YIELD_PRODUCTION'),
	('DAM_RIVER_DISTRICT_PRODUCTION',						'Amount',			1),
	('DAM_RIVER_FOOD_2',									'YieldType',		'YIELD_FOOD'),
	('DAM_RIVER_FOOD_2',									'Amount',			1),
	('DAM_RIVER_DISTRICT_PRODUCTION_2',						'YieldType',		'YIELD_PRODUCTION'),
	('DAM_RIVER_DISTRICT_PRODUCTION_2',						'Amount',			1);


insert or replace into DistrictModifiers(DistrictType, ModifierId) select
	DistrictType, 'AQUEDUCT_CLEAR_FRESH_HOUSING'
	from Districts where Aqueduct = 1;

insert or replace into DistrictModifiers(DistrictType, ModifierId) select
	DistrictType, 'AQUEDUCT_ADD_FRESH_HOUSING'
	from Districts where Aqueduct = 1;

update Districts set Aqueduct = 0 where Aqueduct = 1;


--区域人口吃宜居度
-- insert or replace into DistrictModifiers(DistrictType,	ModifierId) select
-- 	'DISTRICT_CITY_CENTER',		'DISTRICT_'||numbers||'_WORKER_CONSUME_AMENITY'
-- 	from counter where numbers >= 1 and numbers <= 8;

-- insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
-- 	'DISTRICT_'||numbers||'_WORKER_CONSUME_AMENITY',	'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_AMENITY',	'RS_PLOT_HAS_'||numbers||'_WORKERS'
-- 	from counter where numbers >= 1 and numbers <= 8;

-- insert or replace into ModifierArguments(ModifierId,	Name, Value) select
-- 	'DISTRICT_'||numbers||'_WORKER_CONSUME_AMENITY',	'Amount',	-1
-- 	from counter where numbers >= 1 and numbers <= 8;




--提供给toolTipHelper使用  区域专家带来的减宜居度
insert or ignore into CitizenBonus(ItemType,		BonusType, 		Amount) select
	DistrictType,		'CITIZEN_AMENITY',		-1
	from Districts where RequiresPopulation = 1 and CitizenSlots > 0 and Entertainment < 1;

insert or ignore into CitizenBonus(ItemType,		BonusType, 		Amount) select
	DistrictType,		'CITIZEN_AMENITY',		1
	from Districts where RequiresPopulation = 1 and 
	(DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX' 
		or DistrictType in 
	(select CivUniqueDistrictType from DistrictReplaces 
	 where ReplacesDistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'));



insert or ignore into DistrictModifiers(DistrictType,	ModifierId) select
	ItemType,		'DISTRICT_'||numbers||'_WORKER_AMENITY'
	from counter, CitizenBonus where numbers >= 1 and numbers <= 8 and BonusType = 'CITIZEN_AMENITY'
	and ItemType in (select DistrictType from Districts);

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	'DISTRICT_'||numbers||'_WORKER_AMENITY',	'MODIFIER_PLAYER_DISTRICT_ADJUST_DISTRICT_AMENITY',	'RS_PLOT_HAS_'||numbers||'_WORKERS'
	from counter, CitizenBonus where numbers >= 1 and numbers <= 8 and BonusType = 'CITIZEN_AMENITY'
	and ItemType in (select DistrictType from Districts);

insert or ignore into ModifierArguments(ModifierId,	Name, Value) select
	'DISTRICT_'||numbers||'_WORKER_AMENITY',	'Amount',	Amount
	from counter, CitizenBonus where numbers >= 1 and numbers <= 8 and BonusType = 'CITIZEN_AMENITY'
	and ItemType in (select DistrictType from Districts);



