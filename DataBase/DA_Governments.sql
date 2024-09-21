

insert or replace into Modifiers(ModifierId, ModifierType) values
	('ADD_Military',		'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER'),
	('ADD_Economic',		'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER'),
	('ADD_Diplomatic',		'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER'),
	('ADD_Wildcard',		'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER'),
	('LOS_Military',		'MODIFIER_PLAYER_CULTURE_REPLACE_GOVERNMENT_SLOTS'),
	('LOS_Economic',		'MODIFIER_PLAYER_CULTURE_REPLACE_GOVERNMENT_SLOTS'),
	('LOS_Diplomatic',		'MODIFIER_PLAYER_CULTURE_REPLACE_GOVERNMENT_SLOTS'),
	('LOS_Wildcard',		'MODIFIER_PLAYER_CULTURE_REPLACE_GOVERNMENT_SLOTS');


insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('ADD_Military',		'GovernmentSlotType',			'SLOT_MILITARY'),
	('ADD_Economic',		'GovernmentSlotType',			'SLOT_ECONOMIC'),
	('ADD_Diplomatic',		'GovernmentSlotType',			'SLOT_DIPLOMATIC'),
	('ADD_Wildcard',		'GovernmentSlotType',			'SLOT_WILDCARD'),
	('LOS_Military',		'ReplacedGovernmentSlotType',	'SLOT_MILITARY'),
	('LOS_Economic',		'ReplacedGovernmentSlotType',	'SLOT_ECONOMIC'),
	('LOS_Diplomatic',		'ReplacedGovernmentSlotType',	'SLOT_DIPLOMATIC'),
	('LOS_Wildcard',		'ReplacedGovernmentSlotType',	'SLOT_WILDCARD');

update Governments set InherentBonusDesc  = 'LOC_DA_'||GovernmentType||'_INHERENT_BONUS', AccumulatedBonusShortDesc = 'LOC_DA_'||GovernmentType||'_BONUS',  AccumulatedBonusDesc = 'LOC_DA_'||GovernmentType||'_BONUS'
    where GovernmentType in ('GOVERNMENT_CHIEFDOM');



insert or replace into GovernmentModifiers(GovernmentType,	ModifierId) values
	('GOVERNMENT_CHIEFDOM',			'CHIEFDOM_BARBARIAN_COMBAT');

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('CHIEFDOM_BARBARIAN_COMBAT',				'MODIFIER_PLAYER_UNITS_ADJUST_BARBARIAN_COMBAT');

insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('CHIEFDOM_BARBARIAN_COMBAT',				'Amount',	4);




