create table "counter" (
'numbers' INTEGER NOT NULL,
PRIMARY KEY(numbers)
);

WITH RECURSIVE
  Indices(i) AS (SELECT -50 UNION ALL SELECT (i + 1) FROM Indices LIMIT 100)
  insert into counter(numbers) select i from Indices;

create table "counter_m" (
'numbers' INTEGER NOT NULL,
PRIMARY KEY(numbers)
);

WITH RECURSIVE
  Indices(i) AS (SELECT 0 UNION ALL SELECT (i + 1) FROM Indices LIMIT 8)
  insert into counter_m(numbers) select i from Indices;

create table "GreatpeopleYields"(
'GreatPersonClassType' TEXT NOT NULL,
'YieldType' TEXT NOT NULL,
'Amount' INTEGER NOT NULL,
PRIMARY KEY(GreatPersonClassType, YieldType)
);

insert or replace into GreatpeopleYields(GreatPersonClassType,  YieldType,  Amount) values
  ('GREAT_PERSON_CLASS_GENERAL',          'YIELD_PRODUCTION',         1),
  ('GREAT_PERSON_CLASS_ADMIRAL',          'YIELD_FOOD',               1),
  ('GREAT_PERSON_CLASS_ENGINEER',         'YIELD_PRODUCTION',         1),
  ('GREAT_PERSON_CLASS_MERCHANT',         'YIELD_GOLD',               3),
  ('GREAT_PERSON_CLASS_PROPHET',          'YIELD_FAITH',              2),
  ('GREAT_PERSON_CLASS_SCIENTIST',        'YIELD_SCIENCE',            1),
  ('GREAT_PERSON_CLASS_WRITER',           'YIELD_CULTURE',            1),
  ('GREAT_PERSON_CLASS_ARTIST',           'YIELD_CULTURE',            1),
  ('GREAT_PERSON_CLASS_MUSICIAN',         'YIELD_CULTURE',            1),
  ('GREAT_PERSON_CLASS_WRITER',           'YIELD_CULTURE',            1);

create table "ConfigValues" (
'ConfigId' TEXT NOT NULL,
'ConfigVal' INT NOT NULL,
PRIMARY KEY(ConfigId)
);

insert or replace into ConfigValues(ConfigId,   ConfigVal) values
  ('CONFIG_BELIEF',         0),
  ('CONFIG_GOODY_EVENT',    0);
 
create table "CitizenBonus" (
  "ItemType" TEXT NOT NULL,
  "BonusType" TEXT NOT NULL,
  "Amount" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY(ItemType, BonusType)
);


create table "DA_District_Yields" (
'DistrictType' TEXT NOT NULL,
'YieldType' TEXT NOT NULL,
'Amount' INTEGER NOT NULL,
PRIMARY KEY(DistrictType, YieldType)
);

insert into DA_District_Yields
  (DistrictType,              YieldType,          Amount) values 
  ('DISTRICT_CAMPUS',         'YIELD_SCIENCE',        1),
  ('DISTRICT_COMMERCIAL_HUB',     'YIELD_GOLD',         3),
  ('DISTRICT_ENCAMPMENT',       'YIELD_PRODUCTION',       1),

  ('DISTRICT_HOLY_SITE',        'YIELD_FAITH',            2),
  ('DISTRICT_THEATER',        'YIELD_CULTURE',        1),
  ('DISTRICT_ACROPOLIS',        'YIELD_CULTURE',        1),
  -- ('DISTRICT_CITY_CENTER',      'YIELD_PRODUCTION',       1),
  -- ('DISTRICT_CITY_CENTER',      'YIELD_FOOD',         1),
  -- ('DISTRICT_CITY_CENTER',      'YIELD_GOLD',         1),

  ('DISTRICT_INDUSTRIAL_ZONE',    'YIELD_PRODUCTION',       1),
  ('DISTRICT_HARBOR',         'YIELD_GOLD',         3);

create table "PropertyRequirements" (
 "PropertyType" TEXT NOT NULL,
 "Threshold" INTEGER NOT NULL DEFAULT 1,
 "Match" BOOLEAN NOT NULL DEFAULT 0,
 PRIMARY KEY(PropertyType)
); 


