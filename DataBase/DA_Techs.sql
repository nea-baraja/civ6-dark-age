
insert or replace into Types
    (Type,                                      Kind)
values
    ('TECH_PAPER_MAKING_DA',                    'KIND_TECH');

insert or replace into Technologies
    (TechnologyType,                    Name,                                    Description,                                        Cost,   EraType,            UITreeRow,  AdvisorType)
values
    ('TECH_PAPER_MAKING_DA',            'LOC_TECH_PAPER_MAKING_DA_NAME',         null,             200,     'ERA_CLASSICAL',   0,         'ADVISOR_TECHNOLOGY');
 
insert or replace into TechnologyPrereqs
        (Technology, PrereqTech)
values
        ('TECH_PAPER_MAKING_DA',        'TECH_CURRENCY'),
        ('TECH_APPRENTICESHIP',         'TECH_PAPER_MAKING_DA'),
        ('TECH_MATHEMATICS',            'TECH_IRRIGATION');

delete from TechnologyPrereqs where Technology = 'TECH_APPRENTICESHIP' and PrereqTech = 'TECH_HORSEBACK_RIDING';
delete from TechnologyPrereqs where Technology = 'TECH_APPRENTICESHIP' and PrereqTech = 'TECH_CURRENCY';
delete from TechnologyPrereqs where Technology = 'TECH_CONSTRUCTION' and PrereqTech = 'TECH_HORSEBACK_RIDING';

update Technologies set Description = 'LOC_'||TechnologyType||'_DESCRIPTION' where Description is NULL;
	

insert or replace into Boosts
    (BoostID,   TechnologyType,                             Boost,  TriggerDescription,                                     TriggerLongDescription,                                             Unit1Type,                   BoostClass,                                         Unit2Type,      BuildingType,       ImprovementType,              BoostingTechType,        BoostingCivicType,          ResourceType,   NumItems,   DistrictType,           RequiresResource)
values
    (250,       'TECH_PAPER_MAKING_DA',                     0,     'LOC_BOOST_TRIGGER_PAPER_MAKING_DA',                       'LOC_BOOST_TRIGGER_LONGDESC_PAPER_MAKING_DA',                            NULL,                        'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH',                   NULL,           NULL, NULL,                         NULL,                    NULL,                       NULL,           1,          NULL,                   0);





insert or replace into TechnologyModifiers
        (TechnologyType,                                                        ModifierId)
values
        -- ('TECH_PAPER_MAKING_DA',                                                'CIVIC_GRANT_PLAYER_GOVERNOR_POINTS'),
        ('TECH_MATHEMATICS',                                                    'MATHEMATICS_BUY_PLOT_SALE');


insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
        ('MATHEMATICS_BUY_PLOT_SALE',                   'MODIFIER_PLAYER_CITIES_ADJUST_PLOT_PURCHASE_COST',             null);

insert or replace into ModifierArguments(ModifierId, Name, Value) values
        ('MATHEMATICS_BUY_PLOT_SALE',                   'Amount',               -50);


CREATE TABLE "AdditionalUnlockables" (
        "ResearchType" TEXT NOT NULL,
        "ItemType" TEXT NOT NULL,
        PRIMARY KEY(ResearchType, ItemType)
);

insert or replace into AdditionalUnlockables(ResearchType, ItemType) values
	('TECH_HORSEBACK_RIDING', 'DISTRICT_ENCAMPMENT'),
        ('CIVIC_GAMES_RECREATION', 'DISTRICT_BATH'),
        ('CIVIC_EARLY_EMPIRE', 'DISTRICT_GOVERNMENT');
       







-- insert or replace into Boosts(BoostID, TechnologyType, TriggerDescription, BoostClass, Boost, TriggerLongDescription) values
-- 	(601, 'TECH_MINING',			'LOC_BOOST_TRIGGER_OTHER',		'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', 40, ''),
-- 	(602, 'TECH_ANIMAL_HUSBANDRY',	'LOC_BOOST_TRIGGER_OTHER',		'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', 40, ''),
-- 	(603, 'TECH_POTTERY',			'LOC_BOOST_TRIGGER_OTHER',		'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', 40, '');