create table 'DistrictCitizenYields'(
	'Id' TEXT NOT NULL,
	'YieldType'	TEXT,
	'BuildingType' TEXT,
	'Amount'	INT,
	'DistrictType'	TEXT,
	'CitizenSlots'	INT,
	PRIMARY KEY('Id','DistrictType', 'YieldType')	
);

insert or replace into DistrictCitizenYields
(Id,						YieldType,				Amount,		    DistrictType,			CitizenSlots) select
'UNIVERSITY_BONUS',			'YIELD_SCIENCE',		6,				DistrictType,			0
from Districts where RequiresPopulation = 1 and DistrictType not in (select CivUniqueDistrictType from DistrictReplaces);

insert or replace into DistrictCitizenYields
(Id,						YieldType,				Amount,		    DistrictType,			CitizenSlots) select
'UNIVERSITY_BONUS',			'YIELD_FOOD',			-1,				DistrictType,			0
from Districts where RequiresPopulation = 1 and DistrictType not in (select CivUniqueDistrictType from DistrictReplaces);



update DistrictCitizenYields set BuildingType = 'BUILDING_CTZY_'||Id||'_IN_'||DistrictType;

--百科不显示虚拟建筑
insert or replace into CivilopediaPageExcludes(SectionId,	PageId)	select
'BUILDINGS',	BuildingType from DistrictCitizenYields;




insert or ignore into Types (Type, Kind) 
	select BuildingType,	'KIND_BUILDING' from DistrictCitizenYields;

insert or ignore into Buildings (BuildingType,	Name,	Cost,	Description,	PrereqDistrict,	MustPurchase,	CitizenSlots)
select BuildingType, 'LOC_'||Id||'_NAME',		1, 		NULL,	DistrictType,	1,	CitizenSlots
from DistrictCitizenYields;

insert or ignore into Buildings_XP2 (BuildingType, Pillage)
select BuildingType, 0 from DistrictCitizenYields;

insert or ignore into Building_CitizenYieldChanges(BuildingType,		YieldType,		YieldChange)
select BuildingType,	YieldType,		Amount from DistrictCitizenYields;



--大学给全专家加产出
insert or ignore into BuildingModifiers(BuildingType, ModifierId) select
    'BUILDING_UNIVERSITY',      'UNIVERSITY_GIFT_'||BuildingType
    from DistrictCitizenYields where Id = 'UNIVERSITY_BONUS';

insert or ignore into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'UNIVERSITY_GIFT_'||BuildingType, 'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE', 'RS_CITY_HAS_'||DistrictType
    from DistrictCitizenYields where Id = 'UNIVERSITY_BONUS';

insert or ignore into ModifierArguments(ModifierId, Name, Value) select
	'UNIVERSITY_GIFT_'||BuildingType, 'BuildingType', BuildingType
    from DistrictCitizenYields where Id = 'UNIVERSITY_BONUS';


