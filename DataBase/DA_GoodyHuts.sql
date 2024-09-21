
delete from GoodyHuts where ImprovementType = 'IMPROVEMENT_GOODY_HUT';
delete from GoodyHutSubtypes where GoodyHut like 'GOODYHUT_%';

insert or replace into GoodyHuts(GoodyHutType,	ImprovementType,	Weight, ShowMoment) values
	('GOODYHUT_EVENT',	'IMPROVEMENT_GOODY_HUT',		100,	1);
	--('BARB_GOODIES',	'IMPROVEMENT_BARBARIAN_CAMP',	100,	1);


insert or replace into GoodyHutSubtypes(GoodyHut,	SubTypeGoodyHut,	Weight, ModifierID) values
	('GOODYHUT_EVENT',	'GOODYHUT_EVENT',		100,		'DO_NOTHING');
	--('BARB_GOODIES',	'BARB_GOODIES',			100,		'DO_NOTHING');

--update Improvements set Goody = 1  where ImprovementType = 'IMPROVEMENT_BARBARIAN_CAMP';




--清理野蛮人寨子触发指定村庄类型 村庄类型指向寨子事件
insert or replace into Types (Type, Kind) values ('IMPROVEMENT_GOODY_BARB', 'KIND_IMPROVEMENT');
insert or replace into Improvements
	(ImprovementType,				Name,									Icon,							PlunderType,	RemoveOnEntry,	Goody,	GoodyNotify)
values
	('IMPROVEMENT_GOODY_BARB',	'LOC_IMPROVEMENT_GOODY_BARB_NAME',	'ICON_IMPROVEMENT_GOODY_BARB',	'NO_PLUNDER',	1,				1,		0);

insert or replace into GoodyHuts
	(GoodyHutType,				ImprovementType,				Weight,	ShowMoment)
values
	('GOODY_BARB_EVENT',		'IMPROVEMENT_GOODY_BARB',	100,	0);

insert or replace into GoodyHutSubTypes
	(GoodyHut,					SubTypeGoodyHut,		Description,										Weight, ModifierID)
values
	('GOODY_BARB_EVENT',		'GOODY_SUB_BARB_EVENT',		'LOC_GOODY_BARB_EVENT_DESCRIPTION',	100,	'DO_NOTHING');


insert or replace into TraitModifiers
	(TraitType,								ModifierId)
values
	('TRAIT_LEADER_MAJOR_CIV',	'TRAIT_BARBARIAN_CAMP_TRIGGER_EVENT_GOODYHUT');

insert or replace into Modifiers
	(ModifierId,							ModifierType,											SubjectRequirementSetId)
values
	('TRAIT_BARBARIAN_CAMP_TRIGGER_EVENT_GOODYHUT',		'MODIFIER_PLAYER_ADJUST_IMPROVEMENT_GOODY_HUT',			NULL);

insert or replace into ModifierArguments
	(ModifierId,							Name,						Value) values
	('TRAIT_BARBARIAN_CAMP_TRIGGER_EVENT_GOODYHUT',		'ImprovementType',			'IMPROVEMENT_BARBARIAN_CAMP'),
	('TRAIT_BARBARIAN_CAMP_TRIGGER_EVENT_GOODYHUT',		'GoodyHutImprovementType',	'IMPROVEMENT_GOODY_BARB');

