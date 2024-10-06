

insert or replace into GlobalParameters(Name,					Value) values
	('TRADE_ROUTE_GOLD_PER_DESTINATION_DISTRICT',				'0'),
	('TRADE_ROUTE_GOLD_PER_ORIGIN_DISTRICT',					'0'),
	('TRADE_ROUTE_TRANSPORTATION_EFFICIENCY_MAX_RATIO',			'0');



delete from District_TradeRouteYields where 
	 DistrictType = 'DISTRICT_HOLY_SITE'				--圣地
	or DistrictType = 'DISTRICT_CAMPUS'					--学院
	or DistrictType = 'DISTRICT_ENCAMPMENT'				--军营
	or DistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
	or DistrictType = 'DISTRICT_HARBOR'					--港口
	or DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
	or DistrictType = 'DISTRICT_THEATER'				--剧院
	or DistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
	or DistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
	or DistrictType = 'DISTRICT_GOVERNMENT'				--政府区
	or DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER'		--外交区
;


insert or replace into District_TradeRouteYields(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination, YieldChangeAsInternationalDestination) values
	('DISTRICT_CITY_CENTER',				'YIELD_FOOD', 					0, 1, 0),
	('DISTRICT_CITY_CENTER',				'YIELD_PRODUCTION', 			0, 1, 0),
	('DISTRICT_CITY_CENTER',				'YIELD_GOLD', 					3, 0, 3),

	-- ('DISTRICT_GOVERNMENT',					'YIELD_FOOD', 					0, 1, 0),
	-- --('DISTRICT_GOVERNMENT',					'YIELD_PRODUCTION', 			0, 1, 0),
	-- ('DISTRICT_GOVERNMENT',					'YIELD_GOLD', 					3, 0, 3),

	-- --('DISTRICT_DIPLOMATIC_QUARTER',			'YIELD_FOOD', 					0, 1, 0),
	-- ('DISTRICT_DIPLOMATIC_QUARTER',			'YIELD_PRODUCTION', 			0, 1, 0),
	-- ('DISTRICT_DIPLOMATIC_QUARTER',			'YIELD_GOLD', 					3, 0, 3),

	('DISTRICT_CAMPUS',						'YIELD_FOOD', 					0, 1, 0),
	('DISTRICT_CAMPUS',						'YIELD_GOLD', 					3, 0, 3),

	('DISTRICT_THEATER',					'YIELD_FOOD', 					0, 1, 0),
	('DISTRICT_THEATER',					'YIELD_GOLD', 					3, 0, 3),

	('DISTRICT_HOLY_SITE',					'YIELD_FOOD', 					0, 1, 0),
	('DISTRICT_HOLY_SITE',					'YIELD_GOLD', 					3, 0, 3),

	('DISTRICT_ENTERTAINMENT_COMPLEX',		'YIELD_FOOD', 					0, 1, 0),
	('DISTRICT_ENTERTAINMENT_COMPLEX',		'YIELD_GOLD', 					3, 0, 3),

	('DISTRICT_WATER_ENTERTAINMENT_COMPLEX','YIELD_FOOD', 					0, 1, 0),
	('DISTRICT_WATER_ENTERTAINMENT_COMPLEX','YIELD_GOLD', 					3, 0, 3),

	('DISTRICT_ENCAMPMENT',					'YIELD_PRODUCTION', 			0, 1, 0),
	('DISTRICT_ENCAMPMENT',					'YIELD_GOLD', 					3, 0, 3),

	('DISTRICT_INDUSTRIAL_ZONE',			'YIELD_PRODUCTION', 			0, 1, 0),
	('DISTRICT_INDUSTRIAL_ZONE',			'YIELD_GOLD', 					3, 0, 3),

	('DISTRICT_COMMERCIAL_HUB',				'YIELD_FOOD', 					0, 1, 0),
	('DISTRICT_COMMERCIAL_HUB',				'YIELD_PRODUCTION', 			0, 1, 0),
	('DISTRICT_COMMERCIAL_HUB',				'YIELD_GOLD', 					6, 0, 6),

	('DISTRICT_HARBOR',						'YIELD_FOOD', 					0, 1, 0),
	('DISTRICT_HARBOR',						'YIELD_PRODUCTION', 			0, 1, 0),
	('DISTRICT_HARBOR',						'YIELD_GOLD', 					6, 0, 6);






