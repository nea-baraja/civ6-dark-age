insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_PANTHEON_DA',                          256,        8,              8,                  'DA_Pantheons256'),
    ('ICON_ATLAS_PANTHEON_DA',                          64,         8,              8,                  'DA_Pantheons64'),   
    ('ICON_ATLAS_PANTHEON_DA',                          50,         8,              8,                  'DA_Pantheons50'),
    ('ICON_ATLAS_PANTHEON_DA',                          32,         8,              8,                  'DA_Pantheons32');



insert or replace into IconDefinitions
    (Name,                                              Atlas,                                              'Index')
values

    ('ICON_BELIEF_TRANSLATION_MOVEMENT',                'ICON_ATLAS_BELIEFS_PATHEON',                       23),


    ('ICON_BELIEF_GOD_OF_BEAUTY',                       'ICON_ATLAS_PANTHEON_DA',                           7),

    ('ICON_BELIEF_GOD_OF_WINE',                         'ICON_ATLAS_PANTHEON_DA',                           0),
    ('ICON_BELIEF_GGV',                                 'ICON_ATLAS_PANTHEON_DA',                           2),
    ('ICON_BELIEF_SHENNONG',                            'ICON_ATLAS_PANTHEON_DA',                           6);


drop table if exists counter;

create table "counter" (
'numbers' INTEGER NOT NULL,
PRIMARY KEY(numbers)
);

WITH RECURSIVE
  Indices(i) AS (SELECT -50 UNION ALL SELECT (i + 1) FROM Indices LIMIT 100)
  insert into counter(numbers) select i from Indices;

insert or replace into IconDefinitions
    (Name,                                              Atlas,                                              'Index')
select 'ICON_BELIEF_EMPTY_PANTHEON_'||numbers, 'ICON_ATLAS_BELIEFS_PATHEON', 0
from counter where numbers > 0 and numbers < 50;


