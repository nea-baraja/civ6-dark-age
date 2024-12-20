


delete from GovernorPromotionSets where GovernorType = 'GOVERNOR_THE_CARDINAL';
delete from GovernorPromotionSets where GovernorType = 'GOVERNOR_THE_BUILDER';
delete from GovernorPromotionSets where GovernorType = 'GOVERNOR_THE_RESOURCE_MANAGER';
delete from GovernorPromotionSets where GovernorType = 'GOVERNOR_THE_EDUCATOR';


insert or replace into Types
	(Type, Kind)
values
	('GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_CARDINAL_MENTOR', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_CARDINAL_TEMPLE_PRECINCT', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_CARDINAL_CONSECRATION', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_CARDINAL_FINAL', 'KIND_GOVERNOR_PROMOTION'),

	('GOVERNOR_PROMOTION_BUILDER_LEADER', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_BUILDER_ZONER', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_BUILDER_INFRASTRUCTURE', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_BUILDER_VOLUNTARY_LABOR', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_BUILDER_MASTER', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_BUILDER_FINAL', 'KIND_GOVERNOR_PROMOTION'),

	('GOVERNOR_PROMOTION_MANAGER_EXPEDITION', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_MANAGER_METROPOLIS', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_MANAGER_SURPLUS', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_MANAGER_FRONTIER_TOWN', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_MANAGER_WAREHOUSE', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_MANAGER_FINAL', 'KIND_GOVERNOR_PROMOTION'),

	('GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_EDUCATOR_RESEARCHERS', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_EDUCATOR_CONNOISSEURS', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_EDUCATOR_PIONEER', 'KIND_GOVERNOR_PROMOTION'),
	('GOVERNOR_PROMOTION_EDUCATOR_FINAL', 'KIND_GOVERNOR_PROMOTION');



insert or replace into GovernorPromotionSets(GovernorType, GovernorPromotion) values
	('GOVERNOR_THE_CARDINAL', 			'GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP'),   --翻译作教父 Doctor Ecclesiae
	('GOVERNOR_THE_CARDINAL', 			'GOVERNOR_PROMOTION_CARDINAL_MENTOR'),
	('GOVERNOR_THE_CARDINAL', 			'GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER'),
	('GOVERNOR_THE_CARDINAL', 			'GOVERNOR_PROMOTION_CARDINAL_TEMPLE_PRECINCT'),
	('GOVERNOR_THE_CARDINAL', 			'GOVERNOR_PROMOTION_CARDINAL_CONSECRATION'),
	('GOVERNOR_THE_CARDINAL', 			'GOVERNOR_PROMOTION_CARDINAL_FINAL'),

	('GOVERNOR_THE_BUILDER', 			'GOVERNOR_PROMOTION_BUILDER_LEADER'),   
	('GOVERNOR_THE_BUILDER', 			'GOVERNOR_PROMOTION_BUILDER_ZONER'),
	('GOVERNOR_THE_BUILDER', 			'GOVERNOR_PROMOTION_BUILDER_INFRASTRUCTURE'),
	('GOVERNOR_THE_BUILDER', 			'GOVERNOR_PROMOTION_BUILDER_VOLUNTARY_LABOR'),
	('GOVERNOR_THE_BUILDER', 			'GOVERNOR_PROMOTION_BUILDER_MASTER'),
	('GOVERNOR_THE_BUILDER', 			'GOVERNOR_PROMOTION_BUILDER_FINAL'),

	('GOVERNOR_THE_RESOURCE_MANAGER', 	'GOVERNOR_PROMOTION_MANAGER_EXPEDITION'),
	('GOVERNOR_THE_RESOURCE_MANAGER', 	'GOVERNOR_PROMOTION_MANAGER_METROPOLIS'),
	('GOVERNOR_THE_RESOURCE_MANAGER', 	'GOVERNOR_PROMOTION_MANAGER_SURPLUS'),
	('GOVERNOR_THE_RESOURCE_MANAGER', 	'GOVERNOR_PROMOTION_MANAGER_FRONTIER_TOWN'),
	('GOVERNOR_THE_RESOURCE_MANAGER', 	'GOVERNOR_PROMOTION_MANAGER_WAREHOUSE'),
	('GOVERNOR_THE_RESOURCE_MANAGER', 	'GOVERNOR_PROMOTION_MANAGER_FINAL'),

	('GOVERNOR_THE_EDUCATOR', 			'GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS'),
	('GOVERNOR_THE_EDUCATOR', 			'GOVERNOR_PROMOTION_EDUCATOR_RESEARCHERS'),
	('GOVERNOR_THE_EDUCATOR', 			'GOVERNOR_PROMOTION_EDUCATOR_CONNOISSEURS'),
	('GOVERNOR_THE_EDUCATOR', 			'GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR'),
	('GOVERNOR_THE_EDUCATOR', 			'GOVERNOR_PROMOTION_EDUCATOR_PIONEER'),
	('GOVERNOR_THE_EDUCATOR', 			'GOVERNOR_PROMOTION_EDUCATOR_FINAL');



insert or replace into GovernorPromotions
	(GovernorPromotionType, Name, Description, Level, Column, BaseAbility)
values
	('GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP', 'LOC_GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP_NAME', 'LOC_GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP_DESCRIPTION', 1, 0, 0),
	('GOVERNOR_PROMOTION_CARDINAL_MENTOR', 'LOC_GOVERNOR_PROMOTION_CARDINAL_MENTOR_NAME', 'LOC_GOVERNOR_PROMOTION_CARDINAL_MENTOR_DESCRIPTION', 0, 1, 1),
	('GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER', 'LOC_GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER_NAME', 'LOC_GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER_DESCRIPTION', 1, 2, 0),
	('GOVERNOR_PROMOTION_CARDINAL_TEMPLE_PRECINCT', 'LOC_GOVERNOR_PROMOTION_CARDINAL_TEMPLE_PRECINCT_NAME', 'LOC_GOVERNOR_PROMOTION_CARDINAL_TEMPLE_PRECINCT_DESCRIPTION', 2, 0, 0),
	('GOVERNOR_PROMOTION_CARDINAL_CONSECRATION', 'LOC_GOVERNOR_PROMOTION_CARDINAL_CONSECRATION_NAME', 'LOC_GOVERNOR_PROMOTION_CARDINAL_CONSECRATION_DESCRIPTION', 2, 2, 0),
	('GOVERNOR_PROMOTION_CARDINAL_FINAL', 'LOC_GOVERNOR_PROMOTION_CARDINAL_FINAL_NAME', 'LOC_GOVERNOR_PROMOTION_CARDINAL_FINAL_DESCRIPTION', 3, 1, 0),

	('GOVERNOR_PROMOTION_BUILDER_LEADER', 'LOC_GOVERNOR_PROMOTION_BUILDER_LEADER_NAME', 'LOC_GOVERNOR_PROMOTION_BUILDER_LEADER_DESCRIPTION', 0, 1, 1),
	('GOVERNOR_PROMOTION_BUILDER_ZONER', 'LOC_GOVERNOR_PROMOTION_BUILDER_ZONER_NAME', 'LOC_GOVERNOR_PROMOTION_BUILDER_ZONER_DESCRIPTION', 1, 2, 0),
	('GOVERNOR_PROMOTION_BUILDER_INFRASTRUCTURE', 'LOC_GOVERNOR_PROMOTION_BUILDER_INFRASTRUCTURE_NAME', 'LOC_GOVERNOR_PROMOTION_BUILDER_INFRASTRUCTURE_DESCRIPTION', 1, 0, 0),
	('GOVERNOR_PROMOTION_BUILDER_VOLUNTARY_LABOR', 'LOC_GOVERNOR_PROMOTION_BUILDER_VOLUNTARY_LABOR_NAME', 'LOC_GOVERNOR_PROMOTION_BUILDER_VOLUNTARY_LABOR_DESCRIPTION', 2, 0, 0),
	('GOVERNOR_PROMOTION_BUILDER_MASTER', 'LOC_GOVERNOR_PROMOTION_BUILDER_MASTER_NAME', 'LOC_GOVERNOR_PROMOTION_BUILDER_MASTER_DESCRIPTION', 2, 2, 0),
	('GOVERNOR_PROMOTION_BUILDER_FINAL', 'LOC_GOVERNOR_PROMOTION_BUILDER_FINAL_NAME', 'LOC_GOVERNOR_PROMOTION_BUILDER_FINAL_DESCRIPTION', 3, 1, 0),

	('GOVERNOR_PROMOTION_MANAGER_EXPEDITION', 'LOC_GOVERNOR_PROMOTION_MANAGER_EXPEDITION_NAME', 'LOC_GOVERNOR_PROMOTION_MANAGER_EXPEDITION_DESCRIPTION', 0, 1, 1),
	('GOVERNOR_PROMOTION_MANAGER_METROPOLIS', 'LOC_GOVERNOR_PROMOTION_MANAGER_METROPOLIS_NAME', 'LOC_GOVERNOR_PROMOTION_MANAGER_METROPOLIS_DESCRIPTION', 1, 0, 0),
	('GOVERNOR_PROMOTION_MANAGER_SURPLUS', 'LOC_GOVERNOR_PROMOTION_MANAGER_SURPLUS_NAME', 'LOC_GOVERNOR_PROMOTION_MANAGER_SURPLUS_DESCRIPTION', 1, 2, 0),
	('GOVERNOR_PROMOTION_MANAGER_FRONTIER_TOWN', 'LOC_GOVERNOR_PROMOTION_MANAGER_FRONTIER_TOWN_NAME', 'LOC_GOVERNOR_PROMOTION_MANAGER_FRONTIER_TOWN_DESCRIPTION', 2, 0, 0),
	('GOVERNOR_PROMOTION_MANAGER_WAREHOUSE', 'LOC_GOVERNOR_PROMOTION_MANAGER_WAREHOUSE_NAME', 'LOC_GOVERNOR_PROMOTION_MANAGER_WAREHOUSE_DESCRIPTION', 2, 2, 0),
	('GOVERNOR_PROMOTION_MANAGER_FINAL', 'LOC_GOVERNOR_PROMOTION_MANAGER_FINAL_NAME', 'LOC_GOVERNOR_PROMOTION_MANAGER_FINAL_DESCRIPTION', 3, 1, 0),

	('GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS_NAME', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS_DESCRIPTION', 0, 1, 1),
	('GOVERNOR_PROMOTION_EDUCATOR_RESEARCHERS', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_RESEARCHERS_NAME', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_RESEARCHERS_DESCRIPTION', 1, 0, 0),
	('GOVERNOR_PROMOTION_EDUCATOR_CONNOISSEURS', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_CONNOISSEURS_NAME', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_CONNOISSEURS_DESCRIPTION', 1, 2, 0),
	('GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR_NAME', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR_DESCRIPTION', 2, 0, 0),
	('GOVERNOR_PROMOTION_EDUCATOR_PIONEER', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_PIONEER_NAME', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_PIONEER_DESCRIPTION', 2, 2, 0),
	('GOVERNOR_PROMOTION_EDUCATOR_FINAL', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_FINAL_NAME', 'LOC_GOVERNOR_PROMOTION_EDUCATOR_FINAL_DESCRIPTION', 3, 1, 0);



insert or replace into GovernorPromotionPrereqs
	(GovernorPromotionType, PrereqGovernorPromotion)
values
	('GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP', 'GOVERNOR_PROMOTION_CARDINAL_MENTOR'),
	('GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER', 'GOVERNOR_PROMOTION_CARDINAL_MENTOR'),
	('GOVERNOR_PROMOTION_CARDINAL_TEMPLE_PRECINCT', 'GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP'),
	('GOVERNOR_PROMOTION_CARDINAL_TEMPLE_PRECINCT', 'GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER'),
	('GOVERNOR_PROMOTION_CARDINAL_CONSECRATION', 'GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP'),
	('GOVERNOR_PROMOTION_CARDINAL_CONSECRATION', 'GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER'),
	('GOVERNOR_PROMOTION_CARDINAL_FINAL', 'GOVERNOR_PROMOTION_CARDINAL_TEMPLE_PRECINCT'),
	('GOVERNOR_PROMOTION_CARDINAL_FINAL', 'GOVERNOR_PROMOTION_CARDINAL_CONSECRATION'),

	('GOVERNOR_PROMOTION_BUILDER_INFRASTRUCTURE', 'GOVERNOR_PROMOTION_BUILDER_LEADER'),
	('GOVERNOR_PROMOTION_BUILDER_ZONER', 'GOVERNOR_PROMOTION_BUILDER_LEADER'),
	('GOVERNOR_PROMOTION_BUILDER_VOLUNTARY_LABOR', 'GOVERNOR_PROMOTION_BUILDER_INFRASTRUCTURE'),
	('GOVERNOR_PROMOTION_BUILDER_VOLUNTARY_LABOR', 'GOVERNOR_PROMOTION_BUILDER_ZONER'),
	('GOVERNOR_PROMOTION_BUILDER_MASTER', 'GOVERNOR_PROMOTION_BUILDER_INFRASTRUCTURE'),
	('GOVERNOR_PROMOTION_BUILDER_MASTER', 'GOVERNOR_PROMOTION_BUILDER_ZONER'),
	('GOVERNOR_PROMOTION_BUILDER_FINAL', 'GOVERNOR_PROMOTION_BUILDER_MASTER'),
	('GOVERNOR_PROMOTION_BUILDER_FINAL', 'GOVERNOR_PROMOTION_BUILDER_VOLUNTARY_LABOR'),

	('GOVERNOR_PROMOTION_MANAGER_SURPLUS', 'GOVERNOR_PROMOTION_MANAGER_EXPEDITION'),
	('GOVERNOR_PROMOTION_MANAGER_METROPOLIS', 'GOVERNOR_PROMOTION_MANAGER_EXPEDITION'),
	('GOVERNOR_PROMOTION_MANAGER_FRONTIER_TOWN', 'GOVERNOR_PROMOTION_MANAGER_SURPLUS'),
	('GOVERNOR_PROMOTION_MANAGER_FRONTIER_TOWN', 'GOVERNOR_PROMOTION_MANAGER_METROPOLIS'),
	('GOVERNOR_PROMOTION_MANAGER_WAREHOUSE', 'GOVERNOR_PROMOTION_MANAGER_SURPLUS'),
	('GOVERNOR_PROMOTION_MANAGER_WAREHOUSE', 'GOVERNOR_PROMOTION_MANAGER_METROPOLIS'),
	('GOVERNOR_PROMOTION_MANAGER_FINAL', 'GOVERNOR_PROMOTION_MANAGER_WAREHOUSE'),
	('GOVERNOR_PROMOTION_MANAGER_FINAL', 'GOVERNOR_PROMOTION_MANAGER_FRONTIER_TOWN'),

	('GOVERNOR_PROMOTION_EDUCATOR_RESEARCHERS', 'GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS'),
	('GOVERNOR_PROMOTION_EDUCATOR_CONNOISSEURS', 'GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS'),
	('GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR', 'GOVERNOR_PROMOTION_EDUCATOR_CONNOISSEURS'),
	('GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR', 'GOVERNOR_PROMOTION_EDUCATOR_RESEARCHERS'),
	('GOVERNOR_PROMOTION_EDUCATOR_PIONEER', 'GOVERNOR_PROMOTION_EDUCATOR_CONNOISSEURS'),
	('GOVERNOR_PROMOTION_EDUCATOR_PIONEER', 'GOVERNOR_PROMOTION_EDUCATOR_RESEARCHERS'),
	('GOVERNOR_PROMOTION_EDUCATOR_FINAL', 'GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR'),
	('GOVERNOR_PROMOTION_EDUCATOR_FINAL', 'GOVERNOR_PROMOTION_EDUCATOR_PIONEER');

	


insert or replace into GovernorPromotionModifiers
	(GovernorPromotionType, ModifierId)
values
	('GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP',		'THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_MOVEMENT'),
	('GOVERNOR_PROMOTION_CARDINAL_THE_BISHOP',		'THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_CHARGES'),
	('GOVERNOR_PROMOTION_CARDINAL_MENTOR',			'MENTOR_POP_FAITH'),
	('GOVERNOR_PROMOTION_CARDINAL_MENTOR',			'MENTOR_PROPHET_POINT'),
	('GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER',		'CARDINAL_BISHOP_PRESSURE'), --复制粘贴自原版
	('GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER',		'HOLY_ORDER_APOSTLE_DISCOUNT'),
	('GOVERNOR_PROMOTION_CARDINAL_HOLY_ORDER',		'HOLY_ORDER_MISSIONARY_DISCOUNT'),
	('GOVERNOR_PROMOTION_CARDINAL_TEMPLE_PRECINCT',	'TEMPLE_PRECINCT_ADJUST_PROPERTY'),
	('GOVERNOR_PROMOTION_CARDINAL_CONSECRATION',	'CONSECRATION_ADJUST_PROPERTY'),

	('GOVERNOR_PROMOTION_BUILDER_LEADER',			'GUILDMASTER_ADDITIONAL_BUILDER_CHARGES'), --复制粘贴自原版
	('GOVERNOR_PROMOTION_BUILDER_LEADER',			'BUILDER_LEADER_BUIDER_EXTRA_MOVEMENT'),
	('GOVERNOR_PROMOTION_BUILDER_ZONER',			'ZONER_EXTRA_DISTRICT'),
	('GOVERNOR_PROMOTION_BUILDER_ZONER',			'ZONER_FASTER_DISTRICT_BUILD'), 
	('GOVERNOR_PROMOTION_BUILDER_INFRASTRUCTURE',	'BUILDER_INFRASTRUCTURE_ADJUST_PROPERTY'),
	('GOVERNOR_PROMOTION_BUILDER_MASTER',			'BUILDER_MASTER_WONDER_PRODUCTION'),

	('GOVERNOR_PROMOTION_MANAGER_EXPEDITION',		'EXPEDITION_ADJUST_SETTLERS_CONSUME_POPULATION'), --复制粘贴自原版
	('GOVERNOR_PROMOTION_MANAGER_METROPOLIS',		'METROPOLIS_ADJUST_PROPERTY'),
	('GOVERNOR_PROMOTION_MANAGER_EXPEDITION',		'EXPEDITION_SETTLER_EXTRA_MOVEMENT'),                ---//--盈余物流 转到 DA_PostProcess.sql  
	('GOVERNOR_PROMOTION_MANAGER_SURPLUS',			'SURPLUS_TRADE_FOOD'),
	('GOVERNOR_PROMOTION_MANAGER_SURPLUS',			'SURPLUS_TRADE_PRODUCTION'),
	('GOVERNOR_PROMOTION_MANAGER_FRONTIER_TOWN',	'FRONTIER_TOWN_ADJUST_PROPERTY'),

	('GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS',		'LIBRARIAN_POP_SCIENCE'),
	('GOVERNOR_PROMOTION_EDUCATOR_LIBRARIANS',		'LIBRARIAN_POP_CULTURE'),
	('GOVERNOR_PROMOTION_EDUCATOR_CONNOISSEURS',	'CONNOISSEURS_BUFF_CULTURE'),
	('GOVERNOR_PROMOTION_EDUCATOR_RESEARCHERS',		'RESEARCHERS_BUFF_SCIENCE'),
	('GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR',		'PROFESSOR_ADJUST_PROPERTY'),
	('GOVERNOR_PROMOTION_EDUCATOR_PROFESSOR',		'PROFESSOR_BUFF_GREAT_PEOPLE'),
	('GOVERNOR_PROMOTION_EDUCATOR_PIONEER',			'PIONEER_ADJUST_PROPERTY');






insert or replace into TraitModifiers(TraitType, ModifierId) values
	('TRAIT_LEADER_MAJOR_CIV',		'CONSECRATION_SCIENCE_TO_FAITH'),
	('TRAIT_LEADER_MAJOR_CIV',		'CONSECRATION_FAITH_TO_FAITH'),
	('TRAIT_LEADER_MAJOR_CIV',		'CONSECRATION_CULTURE_TO_FAITH'),
	-- ('TRAIT_LEADER_MAJOR_CIV',		'CONSECRATION_FOOD_TO_FAITH'),
	-- ('TRAIT_LEADER_MAJOR_CIV',		'CONSECRATION_PRODUCTION_TO_FAITH'),
	-- ('TRAIT_LEADER_MAJOR_CIV',		'CONSECRATION_GOLD_TO_FAITH'),

	('TRAIT_LEADER_MAJOR_CIV',		'BUILDER_INFRASTRUCTURE_ADD_FOOD'),
	('TRAIT_LEADER_MAJOR_CIV',		'BUILDER_INFRASTRUCTURE_ADD_PRODUCTION');


insert or replace into Modifiers	
	(ModifierId,												ModifierType,																Permanent,	SubjectRequirementSetId)
values
	('THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_CHARGES',				'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',									0,	NULL),
	('THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_CHARGES_MODIFIER',	'MODIFIER_SINGLE_CITY_RELIGIOUS_SPREADS',								1,	'RS_UNIT_IS_RELIGOUS_ALL'),
	('THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_MOVEMENT',			'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',									0,	NULL),
	('THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_MOVEMENT_MODIFIER',	'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS',					1,	'RS_UNIT_IS_RELIGOUS_ALL'),
	('MENTOR_POP_FAITH',											'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',									0,	NULL),
	('MENTOR_PROPHET_POINT',										'MODIFIER_SINGLE_CITY_ADJUST_GREAT_PERSON_POINT',						0,	NULL),
	('HOLY_ORDER_APOSTLE_DISCOUNT',									'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST',						0,	NULL),
	('HOLY_ORDER_MISSIONARY_DISCOUNT',								'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST',						0,	NULL),
	--('HOLY_ORDER_INQUISTOR_DISCOUNT',								'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST',						0,	NULL),
	('TEMPLE_PRECINCT_ADJUST_PROPERTY',								'MODIFIER_CITY_TRAINED_UNITS_ADJUST_PROPERTY',							1,	'RS_IS_UNIT_MISSIONARY'),
	('CONSECRATION_ADJUST_PROPERTY',								'MODIFIER_CITY_TRAINED_UNITS_ADJUST_PROPERTY',							1,	'RS_IS_UNIT_APOSTLE'),
	('CONSECRATION_SCIENCE_TO_FAITH',								'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		0,	'RS_PROP_CONSECRATION_1'),
	('CONSECRATION_FAITH_TO_FAITH',									'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		0,	'RS_PROP_CONSECRATION_1'),
	('CONSECRATION_CULTURE_TO_FAITH',								'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		0,	'RS_PROP_CONSECRATION_1'),
	('CONSECRATION_FOOD_TO_FAITH',									'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		0,	'RS_PROP_CONSECRATION_1'),
	('CONSECRATION_PRODUCTION_TO_FAITH',							'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		0,	'RS_PROP_CONSECRATION_1'),
	('CONSECRATION_GOLD_TO_FAITH',									'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',		0,	'RS_PROP_CONSECRATION_1'),
	
	('BUILDER_LEADER_BUIDER_EXTRA_MOVEMENT',						'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',									0,	NULL),
	('BUILDER_LEADER_BUIDER_EXTRA_MOVEMENT_MODIFIER',				'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS',					1,	'RS_IS_UNIT_BUILDER'),
	('ZONER_EXTRA_DISTRICT',										'MODIFIER_SINGLE_CITY_EXTRA_DISTRICT',									0,	NULL),
	('ZONER_FASTER_DISTRICT_BUILD',									'MODIFIER_CITY_INCREASE_DISTRICT_PRODUCTION_RATE',						0,	NULL),
	('BUILDER_INFRASTRUCTURE_ADJUST_PROPERTY',						'MODIFIER_CITY_TRAINED_UNITS_ADJUST_PROPERTY',							1,	'RS_IS_UNIT_BUILDER'),
	('BUILDER_INFRASTRUCTURE_ADD_FOOD',								'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',									0,	'RS_PROP_INFRASTRUCTURE_IS_1'),
	('BUILDER_INFRASTRUCTURE_ADD_PRODUCTION',						'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',									0,	'RS_PROP_INFRASTRUCTURE_IS_2'),
	('BUILDER_MASTER_WONDER_PRODUCTION',							'MODIFIER_SINGLE_CITY_ADJUST_WONDER_PRODUCTION',						0,	NULL),

	('EXPEDITION_SETTLER_EXTRA_MOVEMENT',							'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER',									0,	NULL),
	('EXPEDITION_SETTLER_EXTRA_MOVEMENT_MODIFIER',					'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS',					0,	'RS_IS_UNIT_SETTLER'),
	('SURPLUS_TRADE_FOOD',											'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',								0,	'RS_NOT_SPECIALITY_DISTRICT'),
	('SURPLUS_TRADE_FOOD_MOD',										'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS',				0,	NULL),
	('SURPLUS_TRADE_PRODUCTION',									'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',								0,	'RS_IS_SPECIALITY_DISTRICT'),
	('SURPLUS_TRADE_PRODUCTION_MOD',								'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS',				0,	NULL),
	('METROPOLIS_GRANT_HOUSING',									'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_HOUSING',							0,	NULL),
	('METROPOLIS_GRANT_AMENITY',									'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_AMENITY',						0,	NULL),
	('METROPOLIS_GRANT_EXPANSION',									'MODIFIER_SINGLE_CITY_CULTURE_BORDER_EXPANSION',						0,	NULL),
	('FRONTIER_GRANT_EXPANSION',									'MODIFIER_SINGLE_CITY_CULTURE_BORDER_EXPANSION',						0,	NULL),
	('METROPOLIS_ADJUST_PROPERTY',									'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY',									0,	NULL),
	('FRONTIER_TOWN_ADJUST_PROPERTY',								'MODIFIER_CITY_TRAINED_UNITS_ADJUST_PROPERTY',							1,	'RS_IS_UNIT_SETTLER'),

	('LIBRARIAN_POP_SCIENCE',										'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',									0,	NULL),
	('LIBRARIAN_POP_CULTURE',										'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD',									0,	NULL),
	('CONNOISSEURS_BUFF_CULTURE',									'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',						0,	NULL),
	('RESEARCHERS_BUFF_SCIENCE',									'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',						0,	NULL),
	('PROFESSOR_BUFF_GREAT_PEOPLE',									'MODIFIER_CITY_INCREASE_GREAT_PERSON_POINT_BONUS',						0,	NULL),
	('PROFESSOR_ADJUST_PROPERTY',									'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY',									0,	NULL),
	('PIONEER_ADJUST_PROPERTY',										'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY',									0,	NULL);
	
	
	

	


-- insert or replace into Modifiers	
-- 	(ModifierId,												ModifierType,																Permanent,	SubjectRequirementSetId, OwnerRequirementSetId)
-- values
-- 	('METROPOLIS_GRANT_HOUSING',									'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_HOUSING',							1,	null, 'RS_GOVERNOR_PROMOTION_MANAGER_METROPOLIS'),
-- 	('METROPOLIS_GRANT_AMENITY',									'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_AMENITY',						1,	null, 'RS_GOVERNOR_PROMOTION_MANAGER_METROPOLIS'),
-- 	('METROPOLIS_GRANT_EXPANSION',									'MODIFIER_SINGLE_CITY_CULTURE_BORDER_EXPANSION',						1,	null, 'RS_GOVERNOR_PROMOTION_MANAGER_METROPOLIS');




insert or replace into ModifierArguments
	(ModifierId,											Name,					Value)
values
	('THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_CHARGES',					'ModifierId',			'THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_CHARGES_MODIFIER'),
	('THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_CHARGES_MODIFIER',		'Amount',				1),
	('THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_MOVEMENT',				'ModifierId',			'THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_MOVEMENT_MODIFIER'),
	('THE_BISHOP_TRAINED_RELIGIOUS_UNIT_EXTRA_MOVEMENT_MODIFIER',		'AbilityType',			'ABILITY_BISHOP_EXTRA_MOVEMENT'),	
	('MENTOR_POP_FAITH',												'YieldType',			'YIELD_FAITH'),
	('MENTOR_POP_FAITH',												'Amount',				'2'),
	('MENTOR_PROPHET_POINT',											'Amount',				'4'),
	('MENTOR_PROPHET_POINT',											'GreatPersonClassType',	'GREAT_PERSON_CLASS_PROPHET'),
	('HOLY_ORDER_APOSTLE_DISCOUNT',										'Amount',				'25'),
	('HOLY_ORDER_APOSTLE_DISCOUNT',										'UnitType',				'UNIT_APOSTLE'),
	('HOLY_ORDER_MISSIONARY_DISCOUNT',									'Amount',				'25'),
	('HOLY_ORDER_MISSIONARY_DISCOUNT',									'UnitType',				'UNIT_MISSIONARY'),
	('TEMPLE_PRECINCT_ADJUST_PROPERTY',									'Key',					'PROP_TEMPLE_PRECINCT'),
	('TEMPLE_PRECINCT_ADJUST_PROPERTY',									'Amount',				1),
	('CONSECRATION_ADJUST_PROPERTY',									'Key',					'PROP_CONSECRATION'),
	('CONSECRATION_ADJUST_PROPERTY',									'Amount',				1),
	('CONSECRATION_SCIENCE_TO_FAITH',									'YieldTypeToGrant',		'YIELD_FAITH'),
	('CONSECRATION_SCIENCE_TO_FAITH',									'YieldTypeToMirror',	'YIELD_SCIENCE'),
	('CONSECRATION_FAITH_TO_FAITH',										'YieldTypeToGrant',		'YIELD_FAITH'),
	('CONSECRATION_FAITH_TO_FAITH',										'YieldTypeToMirror',	'YIELD_FAITH'),
	('CONSECRATION_CULTURE_TO_FAITH',									'YieldTypeToGrant',		'YIELD_FAITH'),
	('CONSECRATION_CULTURE_TO_FAITH',									'YieldTypeToMirror',	'YIELD_CULTURE'),
	('CONSECRATION_FOOD_TO_FAITH',										'YieldTypeToGrant',		'YIELD_FAITH'),
	('CONSECRATION_FOOD_TO_FAITH',										'YieldTypeToMirror',	'YIELD_FOOD'),
	('CONSECRATION_PRODUCTION_TO_FAITH',								'YieldTypeToGrant',		'YIELD_FAITH'),
	('CONSECRATION_PRODUCTION_TO_FAITH',								'YieldTypeToMirror',	'YIELD_PRODUCTION'),
	('CONSECRATION_GOLD_TO_FAITH',										'YieldTypeToGrant',		'YIELD_FAITH'),
	('CONSECRATION_GOLD_TO_FAITH',										'YieldTypeToMirror',	'YIELD_GOLD'),
	
	('BUILDER_LEADER_BUIDER_EXTRA_MOVEMENT',							'ModifierId',			'BUILDER_LEADER_BUIDER_EXTRA_MOVEMENT_MODIFIER'),
	('BUILDER_LEADER_BUIDER_EXTRA_MOVEMENT_MODIFIER',					'AbilityType',			'ABILITY_GUILDMASTER_TRAINED_BUILDER_MOVEMENT'),
	('ZONER_EXTRA_DISTRICT',											'Amount',				1),
	('ZONER_FASTER_DISTRICT_BUILD',										'Amount',				50),
	('BUILDER_INFRASTRUCTURE_ADJUST_PROPERTY',							'Key',					'PROP_INFRASTRUCTURE'),
	('BUILDER_INFRASTRUCTURE_ADJUST_PROPERTY',							'Amount',				1),
	('BUILDER_INFRASTRUCTURE_ADD_FOOD',									'YieldType',			'YIELD_FOOD'),
	('BUILDER_INFRASTRUCTURE_ADD_FOOD',									'Amount',				1),
	('BUILDER_INFRASTRUCTURE_ADD_PRODUCTION',							'YieldType',			'YIELD_PRODUCTION'),
	('BUILDER_INFRASTRUCTURE_ADD_PRODUCTION',							'Amount',				1),
	('BUILDER_MASTER_WONDER_PRODUCTION',								'Amount',				20),

	('EXPEDITION_SETTLER_EXTRA_MOVEMENT',								'ModifierId',			'EXPEDITION_SETTLER_EXTRA_MOVEMENT_MODIFIER'),
	('EXPEDITION_SETTLER_EXTRA_MOVEMENT_MODIFIER',						'AbilityType',			'ABILITY_EXPEDITION_TRAINED_SETTLER_MOVEMENT'),
	('SURPLUS_TRADE_FOOD',												'ModifierId',			'SURPLUS_TRADE_FOOD_MOD'),
	('SURPLUS_TRADE_FOOD_MOD',											'YieldType',			'YIELD_FOOD'),
	('SURPLUS_TRADE_FOOD_MOD',											'Amount',				'1'),
	('SURPLUS_TRADE_FOOD_MOD',											'Domestic',				1),
	('SURPLUS_TRADE_PRODUCTION',										'ModifierId',			'SURPLUS_TRADE_PRODUCTION_MOD'),
	('SURPLUS_TRADE_PRODUCTION_MOD',									'YieldType',			'YIELD_PRODUCTION'),
	('SURPLUS_TRADE_PRODUCTION_MOD',									'Amount',				'1'),
	('SURPLUS_TRADE_PRODUCTION_MOD',									'Domestic',				1),		

	('METROPOLIS_GRANT_HOUSING',										'Amount',				'2'),
	('METROPOLIS_GRANT_AMENITY',										'Amount',				'1'),
	('METROPOLIS_GRANT_EXPANSION',										'Amount',				'50'),
	('FRONTIER_GRANT_EXPANSION',										'Amount',				'50'),
	('METROPOLIS_ADJUST_PROPERTY',										'Key',					'PROP_METROPOLIS'),
	('METROPOLIS_ADJUST_PROPERTY',										'Amount',				1),
	('FRONTIER_TOWN_ADJUST_PROPERTY',									'Key',					'PROP_FRONTIER_TOWN'),
	('FRONTIER_TOWN_ADJUST_PROPERTY',									'Amount',				1),

	('LIBRARIAN_POP_CULTURE',											'YieldType',			'YIELD_CULTURE'),
	('LIBRARIAN_POP_CULTURE',											'Amount',				0.5),
	('LIBRARIAN_POP_SCIENCE',											'YieldType',			'YIELD_SCIENCE'),
	('LIBRARIAN_POP_SCIENCE',											'Amount',				0.5),
	('RESEARCHERS_BUFF_SCIENCE',										'YieldType',			'YIELD_SCIENCE'),
	('RESEARCHERS_BUFF_SCIENCE',										'Amount',				50),
	('CONNOISSEURS_BUFF_CULTURE',										'YieldType',			'YIELD_CULTURE'),
	('CONNOISSEURS_BUFF_CULTURE',										'Amount',				50),
	('PROFESSOR_BUFF_GREAT_PEOPLE',										'Amount',				100),
	('PROFESSOR_ADJUST_PROPERTY',										'Key',					'PROP_PROFESSOR'),
	('PROFESSOR_ADJUST_PROPERTY',										'Amount',				1),
	('PIONEER_ADJUST_PROPERTY',											'Key',					'PROP_PIONEER'),
	('PIONEER_ADJUST_PROPERTY',											'Amount',				1);


insert or replace into GovernorPromotionModifiers(GovernorPromotionType, ModifierId) select
	'GOVERNOR_PROMOTION_BUILDER_VOLUNTARY_LABOR', 'VOLUNTARY_LABOR_POP_PRODUCTION_'||numbers
	from counter where numbers > 0 and numbers < 10;

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'VOLUNTARY_LABOR_POP_PRODUCTION_'||numbers, 'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD', 'RS_CITY_HAS_'||numbers||'_DISTRICTS'
	from counter where numbers > 0 and numbers < 10;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'VOLUNTARY_LABOR_POP_PRODUCTION_'||numbers, 'YieldType', 'YIELD_PRODUCTION'
	from counter where numbers > 0 and numbers < 10;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'VOLUNTARY_LABOR_POP_PRODUCTION_'||numbers, 'Amount', 0.5
	from counter where numbers > 0 and numbers < 10;


insert or replace into GovernorPromotionModifiers(GovernorPromotionType, ModifierId) select
	'GOVERNOR_PROMOTION_BUILDER_MASTER', 'MASTER_PRODUCTION_FROM_'||BuildingType
	from Buildings where IsWonder = 1;

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) select
	'MASTER_PRODUCTION_FROM_'||BuildingType, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION_MODIFIER', 'RS_CITY_HAS_'||BuildingType
	from Buildings where IsWonder = 1;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MASTER_PRODUCTION_FROM_'||BuildingType, 'Amount', 5
	from Buildings where IsWonder = 1;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MASTER_PRODUCTION_FROM_'||BuildingType, 'IsWonder', 0
	from Buildings where IsWonder = 1;


insert or replace into GovernorPromotionModifiers(GovernorPromotionType, ModifierId) select
	'GOVERNOR_PROMOTION_MANAGER_WAREHOUSE',	'MANAGER_WAREHOUSE_ROUTE_'||(numbers * 2)
	from counter where numbers > 0 and numbers < 11;

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) select
	'MANAGER_WAREHOUSE_ROUTE_'||(numbers * 2), 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', 'RS_PROP_DOMESTIC_INCOMING_'||(numbers * 2)
	from counter where numbers > 0 and numbers < 11;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MANAGER_WAREHOUSE_ROUTE_'||(numbers * 2), 'Amount', 1
	from counter where numbers > 0 and numbers < 11;

insert or replace into GovernorPromotionModifiers(GovernorPromotionType, ModifierId) select
	'GOVERNOR_PROMOTION_MANAGER_WAREHOUSE',	'MANAGER_WAREHOUSE_FOOD_'||numbers
	from counter where numbers > 0 and numbers < 21;

insert or replace into Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) select
	'MANAGER_WAREHOUSE_FOOD_'||numbers, 'MODIFIER_CITY_OWNER_ADJUST_POP_YIELD', 'RS_PROP_DOMESTIC_INCOMING_'||numbers
	from counter where numbers > 0 and numbers < 21;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MANAGER_WAREHOUSE_FOOD_'||numbers, 'Amount', 0.5
	from counter where numbers > 0 and numbers < 21;

insert or replace into ModifierArguments(ModifierId, Name, Value) select
	'MANAGER_WAREHOUSE_FOOD_'||numbers, 'YieldType', 'YIELD_FOOD'
	from counter where numbers > 0 and numbers < 21;
