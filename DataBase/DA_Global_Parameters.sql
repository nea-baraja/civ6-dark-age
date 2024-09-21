

INSERT OR REPLACE INTO GlobalParameters
(Name,										Value) 	VALUES
('DISTRICT_POPULATION_REQUIRED_PER',		4),			--区域需求人口

('CITY_GROWTH_EXPONENT',					0),		--1.5	--人口价格系数
('CITY_GROWTH_MULTIPLIER',					7),		--8
('CITY_GROWTH_THRESHOLD',					16),	--15

('GAME_COST_ESCALATION',					100),		--通胀系数

('BARBARIAN_CAMP_MINIMUM_DISTANCE_CITY',	6),   --4
('BARBARIAN_BOLDNESS_PER_TURN',				2),	   -- 2         --野蛮人
('BARBARIAN_BOLDNESS_PER_UNIT_LOST',		0),	-- -10
('BARBARIAN_BOLDNESS_PER_SCOUT_LOST',		-100),	-- -5
('BARBARIAN_BOLDNESS_PER_KILL',				10),	-- 15
('BARBARIAN_BOLDNESS_PER_CAMP_ATTACK',		-40),	-- -30
('BARBARIAN_TECH_PERCENT',					75),	-- 50

('CITY_MAX_BUY_PLOT_RANGE',					99),	-- 50

('LOYALTY_PER_TURN_FROM_NEARBY_CITIZEN_PRESSURE_MAX_LOYALTY',				20),	-- 20
('LOYALTY_PER_TURN_FROM_NEARBY_CITIZEN_PRESSURE_MAX_RATIO',					3.0),	-- 3.0

('SCIENCE_PERCENTAGE_YIELD_PER_POP',		50),	--50
('CULTURE_PERCENTAGE_YIELD_PER_POP',		50), --30
('EXPERIENCE_MAXIMUM_ONE_COMBAT',           32), --10

('RELIGION_PANTHEON_MIN_FAITH',				30), --25

-- ('EXPERIENCE_PROMOTE_HEALED',               25), --50
-- ('EXPERIENCE_PROMOTE_HEALED',               25), --50
-- ('EXPERIENCE_PROMOTE_HEALED',               25), --50

('YIELD_PRODUCTION_CITY_TERRAIN_REPLACE',	2);

-- let the barbarian camp start raid with higher threshold (20 turns after the camp being created).
update BarbarianTribes set RaidingBoldness = 40 where RaidingBehaviorTree = 'Barbarian Attack';
update BarbarianTribes set CityAttackBoldness = 20 where RaidingBehaviorTree = 'Barbarian City Assault';


--custom GlobalParameters
insert or replace into GlobalParameters
    (Name,                                              Value)
values
    ('EXPANDED_INIT_VISION_RANGE',                      3);  -- from hd


-- INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES 
-- ('TRAIT_LEADER_MAJOR_CIV', 'DA_NO_PRIMARY_DISTRICT');

-- INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
-- ('DA_NO_PRIMARY_DISTRICT', 'MODIFIER_PLAYER_CITIES_EXTRA_DISTRICT', 0, 0, 0, NULL, 'RS_CITY_IS_NOT_CAPITAL');

-- INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
-- ('DA_NO_PRIMARY_DISTRICT', 'Amount', '-1');

-- RequirementSets

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
('RS_CITY_IS_NOT_CAPITAL', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
('RS_CITY_IS_NOT_CAPITAL', 'REQ_CITY_HAS_NO_PALACE');

-- Requirements

INSERT INTO Requirements (RequirementId, RequirementType, Inverse) VALUES 
('REQ_CITY_HAS_NO_PALACE', 'REQUIREMENT_CITY_HAS_BUILDING', 1);

INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES 
('REQ_CITY_HAS_NO_PALACE', 'BuildingType', 'BUILDING_PALACE');


UPDATE Eras_XP1 SET GameEraMaximumTurns = 60 	WHERE EraType = 'ERA_ANCIENT';			
UPDATE Eras_XP1 SET GameEraMaximumTurns = 60 	WHERE EraType = 'ERA_CLASSICAL';		
UPDATE Eras_XP1 SET GameEraMaximumTurns = 40 	WHERE EraType = 'ERA_MEDIEVAL';			
UPDATE Eras_XP1 SET GameEraMaximumTurns = 40 	WHERE EraType = 'ERA_RENAISSANCE';		
UPDATE Eras_XP1 SET GameEraMaximumTurns = 40 	WHERE EraType = 'ERA_INDUSTRIAL';		
UPDATE Eras_XP1 SET GameEraMaximumTurns = 40 	WHERE EraType = 'ERA_MODERN';			
UPDATE Eras_XP1 SET GameEraMaximumTurns = 40 	WHERE EraType = 'ERA_ATOMIC';			
UPDATE Eras_XP1 SET GameEraMaximumTurns = 40 	WHERE EraType = 'ERA_INFORMATION';
UPDATE Eras_XP1 SET GameEraMaximumTurns = 40 	WHERE EraType = 'ERA_FUTURE';		

UPDATE Eras_XP1 SET GameEraMinimumTurns = 35 	;	

update GlobalParameters set Value = 5 where Name = 'NEXT_ERA_TURN_COUNTDOWN';


--测试代码 记得删
-- update GlobalParameters set Value = 1 where Name = 'NEXT_ERA_TURN_COUNTDOWN';
-- update Eras_XP1 set GameEraMinimumTurns = 2;

insert or replace into TraitModifiers(TraitType, ModifierId) values
    ('TRAIT_LEADER_MAJOR_CIV', 'NO_XP_LIMIT');

insert or replace into Modifiers(ModifierId, ModifierType) values
    ('NO_XP_LIMIT', 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_NO_BARB_XP_LIMIT'),
    ('XP_LIMIT', 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_NO_BARB_XP_LIMIT');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
    ('NO_XP_LIMIT', 'NoLimit', 1),
    ('XP_LIMIT', 'NoLimit', 0);





