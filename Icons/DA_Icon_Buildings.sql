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