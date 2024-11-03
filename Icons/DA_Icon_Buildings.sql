insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_BUILDING_DA',                          256,        8,              8,                  'DA_Buildings_256.dds'),
    ('ICON_ATLAS_BUILDING_DA',                          128,        8,              8,                  'DA_Buildings_128.dds'),
    ('ICON_ATLAS_BUILDING_DA',                          80,         8,              8,                  'DA_Buildings_80.dds'),
    ('ICON_ATLAS_BUILDING_DA',                          50,         8,              8,                  'DA_Buildings_50.dds'),
    ('ICON_ATLAS_BUILDING_DA',                          38,         8,              8,                  'DA_Buildings_38.dds'),
    ('ICON_ATLAS_BUILDING_DA',                          32,         8,              8,                  'DA_Buildings_32.dds'),

    ('ICON_ATLAS_ZHISUO',                          256,        1,              1,                  'zhisuo_256.dds'),
    ('ICON_ATLAS_ZHISUO',                          128,        1,              1,                  'zhisuo_128.dds'),
    ('ICON_ATLAS_ZHISUO',                          80,         1,              1,                  'zhisuo_80.dds'),
    ('ICON_ATLAS_ZHISUO',                          50,         1,              1,                  'zhisuo_50.dds'),
    ('ICON_ATLAS_ZHISUO',                          38,         1,              1,                  'zhisuo_38.dds'),
    ('ICON_ATLAS_ZHISUO',                          32,         1,              1,                  'zhisuo_32.dds');


insert or replace into IconDefinitions
    (Name,                                              Atlas,                                              'Index')
values
    ('ICON_BUILDING_TRIUMPHAL',                         'ICON_ATLAS_BUILDING_DA',                           5),
    ('ICON_BUILDING_TINGTAI',                           'ICON_ATLAS_BUILDING_DA',                           4),
    ('ICON_BUILDING_MASON',                             'ICON_ATLAS_BUILDING_DA',                           1),
    ('ICON_BUILDING_PAPER_MAKER',                       'ICON_ATLAS_BUILDING_DA',                           3),
    ('ICON_BUILDING_FORGING',                           'ICON_ATLAS_BUILDING_DA',                           0),
    ('ICON_BUILDING_OBSERVATORY',                       'ICON_ATLAS_BUILDING_DA',                           2),    
    ('ICON_BUILDING_ZHISUO',                            'ICON_ATLAS_ZHISUO',                                0);



-- UC_CMP_Icons
-- Author: JNR
--------------------------------------------------------------

-- IconTextureAtlases
--------------------------------------------------------------
INSERT INTO IconTextureAtlases
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
VALUES	('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		32,			4,				4,				'UC_CMP_Buildings32.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		38,			4,				4,				'UC_CMP_Buildings38.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		50,			4,				4,				'UC_CMP_Buildings50.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		80,			4,				4,				'UC_CMP_Buildings80.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		128,		4,				4,				'UC_CMP_Buildings128.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		256,		4,				4,				'UC_CMP_Buildings256.dds');
--------------------------------------------------------------

-- IconDefinitions
--------------------------------------------------------------
INSERT OR REPLACE INTO IconDefinitions
		(Name,									Atlas,								'Index')
VALUES	('ICON_BUILDING_LIBRARY',				'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	1),
		('ICON_BUILDING_JNR_ACADEMY',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	0),
		('ICON_BUILDING_UNIVERSITY',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	2),
		('ICON_BUILDING_JNR_SCHOOL',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	3),
		('ICON_BUILDING_JNR_LABORATORY',		'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	4),
		('ICON_BUILDING_JNR_LIBERAL_ARTS',		'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	5),
		('ICON_BUILDING_RESEARCH_LAB',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	6),
		('ICON_BUILDING_JNR_EDUCATION',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	7),

		('ICON_BUILDING_LIBRARY_FOW',			'ICON_ATLAS_BUILDINGS_FOW',			4),
		('ICON_BUILDING_JNR_ACADEMY_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			4),
		('ICON_BUILDING_UNIVERSITY_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			18),
		('ICON_BUILDING_JNR_SCHOOL_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			18),
		('ICON_BUILDING_JNR_LABORATORY_FOW',	'ICON_ATLAS_BUILDINGS_FOW',			37),
		('ICON_BUILDING_JNR_LIBERAL_ARTS_FOW',	'ICON_ATLAS_BUILDINGS_FOW',			37),
		('ICON_BUILDING_RESEARCH_LAB_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			37),
		('ICON_BUILDING_JNR_EDUCATION_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			37);



-- UC_PRD_Icons
-- Author: JNR
--------------------------------------------------------------

-- IconTextureAtlases
--------------------------------------------------------------
INSERT INTO IconTextureAtlases
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
VALUES	('ICON_ATLAS_JNR_UC_PRD_BUILDINGS',		32,			4,				4,				'UC_PRD_Buildings32.dds'),
		('ICON_ATLAS_JNR_UC_PRD_BUILDINGS',		38,			4,				4,				'UC_PRD_Buildings38.dds'),
		('ICON_ATLAS_JNR_UC_PRD_BUILDINGS',		50,			4,				4,				'UC_PRD_Buildings50.dds'),
		('ICON_ATLAS_JNR_UC_PRD_BUILDINGS',		80,			4,				4,				'UC_PRD_Buildings80.dds'),
		('ICON_ATLAS_JNR_UC_PRD_BUILDINGS',		128,		4,				4,				'UC_PRD_Buildings128.dds'),
		('ICON_ATLAS_JNR_UC_PRD_BUILDINGS',		256,		4,				4,				'UC_PRD_Buildings256.dds');

		INSERT INTO IconTextureAtlases
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
VALUES	('ICON_ATLAS_JNR_UC_PRD_PROJECTS',		30,			1,				1,				'UC_PRD_Projects30.dds'),
		('ICON_ATLAS_JNR_UC_PRD_PROJECTS',		32,			1,				1,				'UC_PRD_Projects32.dds'),
		('ICON_ATLAS_JNR_UC_PRD_PROJECTS',		38,			1,				1,				'UC_PRD_Projects38.dds'),
		('ICON_ATLAS_JNR_UC_PRD_PROJECTS',		50,			1,				1,				'UC_PRD_Projects50.dds'),
		('ICON_ATLAS_JNR_UC_PRD_PROJECTS',		80,			1,				1,				'UC_PRD_Projects80.dds'),
		('ICON_ATLAS_JNR_UC_PRD_PROJECTS',		256,		1,				1,				'UC_PRD_Projects256.dds');
--------------------------------------------------------------

-- IconDefinitions
--------------------------------------------------------------
INSERT OR REPLACE INTO IconDefinitions
		(Name,											Atlas,								'Index')
VALUES	('ICON_BUILDING_JNR_MILL_RACE',					'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	7),
		('ICON_BUILDING_JNR_IZ_WATER_MILL',				'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	0),
		('ICON_BUILDING_JNR_WIND_MILL',					'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	1),
		('ICON_BUILDING_WORKSHOP',						'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	2),
		('ICON_BUILDING_JNR_MANUFACTURY',				'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	3),
		('ICON_BUILDING_FACTORY',						'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	4),
		('ICON_BUILDING_JNR_CHEMICAL',					'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	5),
		('ICON_BUILDING_JNR_FREIGHT_YARD',				'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	6),
		('ICON_BUILDING_JNR_MODE_MACHINES',				'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	8),
		('ICON_BUILDING_JNR_MODE_FERTILIZERS',			'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	9),
		('ICON_BUILDING_JNR_MODE_ELECTRONICS',			'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	10),
		('ICON_BUILDING_JNR_MODE_SOUVENIRS',			'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	11),
		('ICON_BUILDING_JNR_MODE_PHARMA',				'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	12),
		('ICON_BUILDING_JNR_MODE_PLASTICS',				'ICON_ATLAS_JNR_UC_PRD_BUILDINGS',	13),

		('ICON_BUILDING_JNR_MILL_RACE_FOW',				'ICON_ATLAS_BUILDINGS_FOW',			7),
		('ICON_BUILDING_JNR_IZ_WATER_MILL_FOW',			'ICON_ATLAS_BUILDINGS_FOW',			7),
		('ICON_BUILDING_JNR_WIND_MILL_FOW',				'ICON_ATLAS_BUILDINGS_FOW',			7),
		('ICON_BUILDING_JNR_MANUFACTURY_FOW',			'ICON_ATLAS_BUILDINGS_FOW',			20),
		('ICON_BUILDING_FACTORY_FOW',					'ICON_ATLAS_BUILDINGS_FOW',			26),
		('ICON_BUILDING_JNR_CHEMICAL_FOW',				'ICON_ATLAS_BUILDINGS_FOW',			26),
		('ICON_BUILDING_JNR_FREIGHT_YARD_FOW',			'ICON_ATLAS_BUILDINGS_FOW',			32),
		('ICON_BUILDING_JNR_MODE_MACHINES_FOW',			'ICON_ATLAS_BUILDINGS_FOW',			26),
		('ICON_BUILDING_JNR_MODE_FERTILIZERS_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			26),
		('ICON_BUILDING_JNR_MODE_ELECTRONICS_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			26),
		('ICON_BUILDING_JNR_MODE_SOUVENIRS_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			26),
		('ICON_BUILDING_JNR_MODE_PHARMA_FOW',			'ICON_ATLAS_BUILDINGS_FOW',			26),
		('ICON_BUILDING_JNR_MODE_PLASTICS_FOW',			'ICON_ATLAS_BUILDINGS_FOW',			26),

		('ICON_PROJECT_JNR_CONVERT_REACTOR_TO_FREIGHT',	'ICON_ATLAS_JNR_UC_PRD_PROJECTS',	0);
