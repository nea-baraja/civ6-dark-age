



insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename, Baseline)
values
    ('ICON_ATLAS_FONTICON_ENLIGHTMENT',                 22,         1,               1,                 'Enlightment_22.dds', 4);

insert or replace into IconDefinitions
    (Name,                                              Atlas,                                              'Index')
values
    ('ENLIGHTMENT',                             	   'ICON_ATLAS_FONTICON_ENLIGHTMENT',                  0);
