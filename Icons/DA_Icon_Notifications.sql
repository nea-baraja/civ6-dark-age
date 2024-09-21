
insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_NOTIFICATIONS_ENLIGHTMENT',            40,        1,              1,                  'notification_enlightment_40.dds'),
    ('ICON_ATLAS_NOTIFICATIONS_ENLIGHTMENT',            100,       1,              1,                  'notification_enlightment_100.dds');

insert into IconDefinitions
    (Name,                                                          Atlas,                                  'Index')
values
    ('ICON_NOTIFICATION_COMPETITION_GREATPERSON',                   'ICON_ATLAS_NOTIFICATIONS_ENLIGHTMENT',         0),
    ('ICON_NOTIFICATION_PURCHASE_PANTHEON',                         'ICON_ATLAS_NOTIFICATIONS',                     6),
    ('ICON_NOTIFICATION_CHINA_DYNASTY',                             'ICON_ATLAS_NOTIFICATIONS',                     15);  --105