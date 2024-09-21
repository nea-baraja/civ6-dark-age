
insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_DA_CIVIC',                             38,         8,              8,                  'Civics_mn_38'),
    ('ICON_ATLAS_DA_CIVIC',                             42,         8,              8,                  'Civics_mn_42'),
    ('ICON_ATLAS_DA_CIVIC',                             128,        8,              8,                  'Civics_mn_128'),
    ('ICON_ATLAS_DA_CIVIC',                            160,         8,              8,                  'Civics_mn_160'),

    ('ICON_ATLAS_DA_TECH_CIVIC',                     30,         8,              8,                     'TechCivicDA_30.dds'),
    ('ICON_ATLAS_DA_TECH_CIVIC',                     38,         8,              8,                     'TechCivicDA_38.dds'),
    ('ICON_ATLAS_DA_TECH_CIVIC',                     42,         8,              8,                     'TechCivicDA_42.dds'),
    ('ICON_ATLAS_DA_TECH_CIVIC',                     128,         8,              8,                  'TechCivicDA_128.dds'),
    ('ICON_ATLAS_DA_TECH_CIVIC',                     160,         8,              8,                  'TechCivicDA_160.dds');

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index') values
    ('ICON_CIVIC_NATIVE_LAND',                                      'ICON_ATLAS_DA_CIVIC',           3),
    ('ICON_CIVIC_SORCERY_AND_HERB',                                 'ICON_ATLAS_DA_CIVIC',           4),
    ('ICON_CIVIC_DEFENSIVE_TACTICS',                                'ICON_ATLAS_DA_TECH_CIVIC',      0),
    ('ICON_CIVIC_DEFENSIVE_TACTICS_FOW',                            'ICON_ATLAS_DA_TECH_CIVIC',      8),    
    ('ICON_TECH_PAPER_MAKING_DA',                                   'ICON_ATLAS_DA_TECH_CIVIC',      1),
    ('ICON_TECH_PAPER_MAKING_DA_FOW',                               'ICON_ATLAS_DA_TECH_CIVIC',      9),

    ('ICON_GOVERNMENT_PRIEST_COUNCIL',                              'ICON_ATLAS_GOVERNMENTS',        0),
    ('ICON_GOVERNMENT_CITY_STATE_ALLIANCE',                         'ICON_ATLAS_GOVERNMENTS',        0),
    ('ICON_GOVERNMENT_TRIBE_UNITY',                                 'ICON_ATLAS_GOVERNMENTS',        0),
    ('ICON_GOVERNMENT_PRIEST_COUNCIL_FOW',                          'ICON_ATLAS_GOVERNMENTS_FOW',    0),
    ('ICON_GOVERNMENT_CITY_STATE_ALLIANCE_FOW',                     'ICON_ATLAS_GOVERNMENTS_FOW',    0),
    ('ICON_GOVERNMENT_TRIBE_UNITY_FOW',                             'ICON_ATLAS_GOVERNMENTS_FOW',    0);


insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_SR_RESOURCE_HERB_FOW',                 256,        1,              1,                  'RESOURCE_HERB_256_FOW'),

    ('ICON_ATLAS_SR_RESOURCE_HERB',                     32,         1,              1,                  'RESOURCE_HERB_32'),
    ('ICON_ATLAS_SR_RESOURCE_HERB',                     38,         1,              1,                  'RESOURCE_HERB_38'),
    ('ICON_ATLAS_SR_RESOURCE_HERB',                     50,         1,              1,                  'RESOURCE_HERB_50'),
    ('ICON_ATLAS_SR_RESOURCE_HERB',                     64,         1,              1,                  'RESOURCE_HERB_64'),
    ('ICON_ATLAS_SR_RESOURCE_HERB',                     256,        1,              1,                  'RESOURCE_HERB_256');

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index') values
    ('ICON_RESOURCE_HERB',                                          'ICON_ATLAS_SR_RESOURCE_HERB',           0),
    ('ICON_RESOURCE_HERB_FOW',                                      'ICON_ATLAS_SR_RESOURCE_HERB_FOW',       0),

    ('ICON_RESOURCE_HERB',                                          'ICON_ATLAS_SR_RESOURCE_HERB',           0),
    ('ICON_RESOURCE_CIRCUS',                                        'ICON_ATLAS_DISTRICTS',                  7),
    ('ICON_RESOURCE_OLYMPIC',                                       'ICON_ATLAS_DISTRICTS',                  1),
    ('ICON_RESOURCE_WRESTLE',                                       'ICON_ATLAS_DISTRICTS',                  3),

    ('RESOURCE_CIRCUS',                                        'ICON_ATLAS_FONT_ICON_BASELINE_4',                  188),
    ('RESOURCE_OLYMPIC',                                       'ICON_ATLAS_FONT_ICON_BASELINE_4',                  180),
    ('RESOURCE_WRESTLE',                                       'ICON_ATLAS_FONT_ICON_BASELINE_4',                  179);

   

