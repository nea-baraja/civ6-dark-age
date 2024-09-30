
delete from TraitModifiers where TraitType = 'FIRST_EMPEROR_TRAIT';
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE';

insert into TraitModifiers (TraitType, ModifierId) 
values 
    ('FIRST_EMPEROR_TRAIT',                     'FREE_CITIZEN_RUSH'),
    ('TRAIT_CIVILIZATION_DYNASTIC_CYCLE',       'DOUBLE_WATER_DISTRICT'),
    ('TRAIT_CIVILIZATION_DYNASTIC_CYCLE',       'WATER_DISTRICT_UNITY');



insert into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) 
values 
('FREE_CITIZEN_RUSH',       'MODIFIER_PLAYER_ADJUST_PROPERTY',                              NULL),
('DOUBLE_WATER_DISTRICT',   'MODIFIER_PLAYER_ADJUST_PROPERTY',                              NULL),
('WATER_DISTRICT_UNITY',    'MODIFIER_PLAYER_DISTRICTS_ADJUST_PLAYER_PROPERTY',            'RS_IS_WATER_DISTRICT');

insert into ModifierArguments (ModifierId, Name, Value) 
values 
('FREE_CITIZEN_RUSH',               'Amount',       1),
('FREE_CITIZEN_RUSH',               'Key',          'PROP_ABILITY_QIN'),
('DOUBLE_WATER_DISTRICT',           'Amount',       1),
('DOUBLE_WATER_DISTRICT',           'Key',          'PROP_ABILITY_CHINA'),
('WATER_DISTRICT_UNITY',            'Amount',       1),
('WATER_DISTRICT_UNITY',            'Key',          'PROP_UNITY_SOURCE_QIN_WATER_DISTRICT');


