insert or replace into Types(Type,			Kind) values
	('HAPPINESS_FURIOUS',		'KIND_HAPPINESS'),
	('HAPPINESS_JOYOUS',		'KIND_HAPPINESS'),
	('HAPPINESS_ELATED',		'KIND_HAPPINESS'),
	('HAPPINESS_UTOPIA',		'KIND_HAPPINESS');

insert or replace into Happinesses(HappinessType,		Name,  			MinimumAmenityScore,	MaximumAmenityScore,	GrowthModifier, NonFoodYieldModifier, RebellionPoints)
values	('HAPPINESS_REVOLT',	'LOC_HAPPINESS_REVOLT_NAME',	null,	-9,		-60,	-60,	5),
		('HAPPINESS_UNREST',	'LOC_HAPPINESS_UNREST_NAME',	-8,		-7,		-48,	-48,	3),
		('HAPPINESS_FURIOUS',	'LOC_HAPPINESS_FURIOUS_NAME',	-6,		-5,		-36,	-36,	1),
		('HAPPINESS_UNHAPPY',	'LOC_HAPPINESS_UNHAPPY_NAME',	-4,		-3,		-24,	-24,	0),
		('HAPPINESS_DISPLEASED','LOC_HAPPINESS_DISPLEASED_NAME',-2,		-1,		-12,	-12,	0),
		('HAPPINESS_CONTENT',	'LOC_HAPPINESS_CONTENT_NAME',	0,		1,		0,		0,	0),
		('HAPPINESS_HAPPY',		'LOC_HAPPINESS_HAPPY_NAME',		2,		3,		12,		6,	-1),
		('HAPPINESS_JOYOUS',	'LOC_HAPPINESS_JOYOUS_NAME',	4,		5,		24,		12,	-1),
		('HAPPINESS_ELATED',	'LOC_HAPPINESS_ELATED_NAME',	6,		7,		36,		18,	-2),
		('HAPPINESS_ECSTATIC',	'LOC_HAPPINESS_ECSTATIC_NAME',	8,		9,		48,		24,	-2),
		('HAPPINESS_UTOPIA',	'LOC_HAPPINESS_UTOPIA_NAME',	10,		null,	60,		30,	-3);

insert or replace into Happinesses_XP1(HappinessType,	IdentityPerTurnChange) values
	('HAPPINESS_REVOLT',	-20),
	('HAPPINESS_UNREST',	-16),
	('HAPPINESS_FURIOUS',	-12),
	('HAPPINESS_UNHAPPY',	-8),
	('HAPPINESS_DISPLEASED',-4),
	('HAPPINESS_CONTENT',	0),
	('HAPPINESS_HAPPY',		4),
	('HAPPINESS_JOYOUS',	8),
	('HAPPINESS_ELATED',	12),
	('HAPPINESS_ECSTATIC',	16),
	('HAPPINESS_UTOPIA',	20);


