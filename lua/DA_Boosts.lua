include("SupportFunctions");

GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
--DA_Boost
--对外贸易
function DA_Boost_OnUnitTriggerGoodyHut(playerID,unitID,goodyHutType)
	-- if goodyHutType ~= goodyHutType then
	-- 	return
	-- end
	local pPlayer = Players[playerID]
	DA_Boost_Adjust_Count(playerID, "CIVIC_FOREIGN_TRADE", "ByTask", 1);
end
GameEvents.UnitTriggerGoodyHut.Add(DA_Boost_OnUnitTriggerGoodyHut)
--写作 --轮子 --政治哲学
function DA_Boost_OnDiplomacyMeet(playerID1,playerID2)
	local pPlayer1 = Players[playerID1];
	local pPlayer2 = Players[playerID2];
	if pPlayer1:IsMajor() == true and pPlayer2:IsMajor() == true then	
		DA_Boost_Adjust_Count(playerID1, "TECH_WRITING", "ByTask", 1);
		DA_Boost_Adjust_Count(playerID2, "TECH_WRITING", "ByTask", 1);
	end
	if pPlayer1:IsMajor() == true then
		if playerID2 ~= 63 then
			DA_Boost_Adjust_Count(playerID1, "TECH_THE_WHEEL", "ByTask", 1);
		end
		if Utils.IsMinor(playerID2) == true then
			DA_Boost_Adjust_Count(playerID1, "CIVIC_POLITICAL_PHILOSOPHY", "ByTask", 1);
		end
	end	
	if pPlayer2:IsMajor() == true then
		if playerID1 ~= 63 then
			DA_Boost_Adjust_Count(playerID2, "TECH_THE_WHEEL", "ByTask", 1);
		end
		if Utils.IsMinor(playerID1) then
			DA_Boost_Adjust_Count(playerID2, "CIVIC_POLITICAL_PHILOSOPHY", "ByTask", 1);
		end
	end			
end
Events.DiplomacyMeet.Add(DA_Boost_OnDiplomacyMeet)
--占星术
function DA_Boost_OnNotificationAdded(playerID,NotificationID)
	local pNotification = NotificationManager.Find(playerID,NotificationID);
	if pNotification:GetType() ==nil or GameInfo.Notifications[pNotification:GetType()].NotificationType ~= "NOTIFICATION_DISCOVER_NATURAL_WONDER" then
		return
	end
	local pPlayer = Players[playerID];
	DA_Boost_Adjust_Count(playerID, "TECH_ASTROLOGY", "ByTask", 1);
end
Events.NotificationAdded.Add(DA_Boost_OnNotificationAdded);

-- function DA_Boost_OnNaturalWonderRevealed( plotx, ploty, eFeature, isFirstToFind )
-- 	local localPlayerID:number = Game.GetLocalPlayer();
-- 	DA_Boost_Adjust_Count(localPlayerID, "TECH_ASTROLOGY", "ByTask", 1);
-- end
-- Events.NaturalWonderRevealed.Add(Find_Natural_Wonder);


--军事传统
function DA_Boost_UnitKilledInCombat(killedPlayerID, killedUnitID, playerID, unitID )
	local killedPlayer = Players[killedPlayerID];
	local pPlayer = Players[playerID];
	if killedPlayerID == 63 and pPlayer:IsMajor() then
		DA_Boost_Adjust_Count(playerID, "CIVIC_MILITARY_TRADITION", "ByTask", 1);
	end
end
Events.UnitKilledInCombat.Add(DA_Boost_UnitKilledInCombat);

--军事训练
function DA_Boost_UnitPromoted(playerID, unitID)
	DA_Boost_Adjust_Count(playerID, "CIVIC_MILITARY_TRAINING", "ByTask", 1);
end
Events.UnitPromoted.Add( DA_Boost_UnitPromoted );

----------------------------------------------------------------------------
function DA_Boost_OnCivicBoostTriggered(playerID,iBoostedCivic)
	if GameInfo.DA_Boosts[GameInfo.Civics[iBoostedCivic].CivicType] == nil then
		return
	end
	local CivicType = GameInfo.Civics[iBoostedCivic].CivicType;
	local pPlayer = Players[playerID];
	
	local CivicCurrentResearchProgress = Utils.DA_GetCulturalProgress(playerID,iBoostedCivic);
	pPlayer:GetCulture():ReverseBoost(iBoostedCivic);
	pPlayer:GetCulture():SetCulturalProgress(iBoostedCivic,CivicCurrentResearchProgress);
	

	local BoostTriggerCount = (pPlayer:GetProperty("DA_Boost_"..CivicType) or {})['ByEureka'] or 0;
	DA_Boost_Set_Count(playerID, CivicType, "ByEureka", BoostTriggerCount + 1);
end
Events.CivicBoostTriggered.Add(DA_Boost_OnCivicBoostTriggered);

function DA_Boost_OnTechBoostTriggered(playerID,iBoostedTech)
	if GameInfo.DA_Boosts[GameInfo.Technologies[iBoostedTech].TechnologyType] == nil then
		return
	end
	local TechnologyType = GameInfo.Technologies[iBoostedTech].TechnologyType;
	local pPlayer = Players[playerID];
	
	local TechCurrentResearchProgress = pPlayer:GetTechs():GetResearchProgress(iBoostedTech);
	pPlayer:GetTechs():ReverseBoost(iBoostedTech);
	pPlayer:GetTechs():SetResearchProgress(iBoostedTech,TechCurrentResearchProgress);
	
	local BoostTriggerCount = (pPlayer:GetProperty("DA_Boost_"..TechnologyType) or {})['ByEureka'] or 0;
	DA_Boost_Set_Count(playerID, TechnologyType, "ByEureka", BoostTriggerCount + 1);
end
Events.TechBoostTriggered.Add(DA_Boost_OnTechBoostTriggered);

----------------------------------------------------------------------------


function DA_Boost_OnImprovementRemovedFromMap(iX,iY,playerID)
	DA_Boost_RefreshImprovements(playerID);
end
function DA_Boost_OnImprovementAddedToMap(iX, iY, ImprovementID, playerID)
	DA_Boost_RefreshImprovements(playerID);
end
function DA_Boost_OnDistrictAddedToMap(playerID,districtID,cityID,districtX,districtY,districtType,percentComplete)
	DA_Boost_RefreshDistricts(playerID);
end
function DA_Boost_OnDistrictRemovedFromMap(playerID,districtID,cityID,districtX,districtY)
	DA_Boost_RefreshDistricts(playerID);
end
function DA_Boost_DistrictBuildProgressChanged(playerID, districtID, cityID, iX, iY,  districtType, era, civilization, percentComplete, iAppeal, isPillaged)
	if percentComplete ~= 100 then
		return
	end
	DA_Boost_RefreshDistricts(playerID);
end
function DA_Boost_OnBuildingAddedtoMap( iX, iY, buildingID, playerID, bPillaged, pctComplete )
	DA_Boost_RefreshBuildings(playerID);
end
--scraped from the game’s binaries, arguments copied from DistrictBuildProgressChanged
function DA_Boost_BuildingBuildProgressChanged(playerID, buildingID, cityID, iX, iY,  buildingType, era, civilization, percentComplete, iAppeal, isPillaged)
	if percentComplete ~= 100 then
		return
	end
	DA_Boost_RefreshBuildings(playerID);
end
--scraped from the game’s binaries, arguments copied from ImprovementRemovedFromMap. Mod GreatestCities only used iX,iY. 
function DA_Boost_OnBuildingRemovedFromMap(iX,iY)
	local pPlot = Map.GetPlot(iX,iY);
	local pCity = Cities.GetPlotPurchaseCity(pPlot);
	if pCity ~= nil then
		DA_Boost_RefreshBuildings(pCity:GetOwner());
	end
	--DA_Boost_RefreshBuildings(playerID);
end

function DA_Boost_UnitAddedToMap(playerID, unitID)
	DA_Boost_RefreshUnits(playerID);
end



function OnLoadScreenClose_DA_Boost()
	Events.ImprovementRemovedFromMap.Add(DA_Boost_OnImprovementRemovedFromMap);
	Events.ImprovementAddedToMap.Add(DA_Boost_OnImprovementAddedToMap);
	Events.DistrictRemovedFromMap.Add(DA_Boost_OnDistrictRemovedFromMap);
	Events.DistrictBuildProgressChanged.Add(DA_Boost_DistrictBuildProgressChanged);
	Events.DistrictAddedToMap.Add(DA_Boost_OnDistrictAddedToMap);
	Events.BuildingAddedToMap.Add(DA_Boost_OnBuildingAddedtoMap);
	Events.UnitAddedToMap.Add(DA_Boost_UnitAddedToMap);
	GameEvents.BuildingBuildProgressChanged.Add(DA_Boost_BuildingBuildProgressChanged);
	Events.BuildingRemovedFromMap.Add(DA_Boost_OnBuildingRemovedFromMap);
end


Events.LoadScreenClose.Add(OnLoadScreenClose_DA_Boost);

----------------------------------------------------------------------------

function DA_Boost_AddProgressByBoost(playerID, bIsFirstTime)
	local pPlayer = Players[playerID]
	if pPlayer:IsMajor() ~= true then
		return
	end
	DA_Boost_RefreshImprovements(playerID);
	DA_Boost_RefreshDistricts(playerID);
	DA_Boost_RefreshBuildings(playerID);
	DA_Boost_RefreshUnits(playerID);
	DA_Boost_RefreshEveryTurn(playerID);
	local TechID = pPlayer:GetTechs():GetResearchingTech();
	local CivicID = pPlayer:GetCulture():GetProgressingCivic();
	if TechID ~= -1 and GameInfo.DA_Boosts[GameInfo.Technologies[TechID].TechnologyType] ~= nil then
		local TechType = GameInfo.Technologies[TechID].TechnologyType;
		local CurrentTechYield = pPlayer:GetTechs():GetScienceYield();
		local TechBoostTriggerByOther = (pPlayer:GetProperty("DA_Boost_"..TechType) or {})['ByOther'] or 0;
		local TechBoostTriggerByEureka = (pPlayer:GetProperty("DA_Boost_"..TechType) or {})['ByEureka'] or 0;		
		local TechBoostTriggerByTask = (pPlayer:GetProperty("DA_Boost_"..TechType) or {})['ByTask'] or 0;
		pPlayer:GetTechs():ChangeCurrentResearchProgress(CurrentTechYield * (TechBoostTriggerByOther + TechBoostTriggerByEureka + TechBoostTriggerByTask));
	end
	if CivicID ~= -1 and GameInfo.DA_Boosts[GameInfo.Civics[CivicID].CivicType] ~= nil then
		local CivicType = GameInfo.Civics[CivicID].CivicType;
		local CurrentCivicYield = pPlayer:GetCulture():GetCultureYield();
		local CivicBoostTriggerByOther = (pPlayer:GetProperty("DA_Boost_"..CivicType) or {})['ByOther'] or 0;
		local CivicBoostTriggerByEureka = (pPlayer:GetProperty("DA_Boost_"..CivicType) or {})['ByEureka'] or 0;		
		local CivicBoostTriggerByTask = (pPlayer:GetProperty("DA_Boost_"..CivicType) or {})['ByTask'] or 0;
		pPlayer:GetCulture():ChangeCurrentCulturalProgress(CurrentCivicYield * (CivicBoostTriggerByOther + CivicBoostTriggerByEureka + CivicBoostTriggerByTask));
	end
	
end
Events.PlayerTurnActivated.Add(DA_Boost_AddProgressByBoost)


function DA_Boost_Set_Count(playerID, ItemType, way, count, ModifierValue)
	local pPlayer = Players[playerID];
	local BoostTriggerCount = pPlayer:GetProperty("DA_Boost_"..ItemType) or {};
	if ModifierValue == nil then
		if way == 'ByTask' then
			ModifierValue = GameInfo.DA_Boosts[ItemType].ModifierValue;
		elseif way == 'ByEureka' then
			ModifierValue = 1;
		elseif way == 'ByOther' then
			ModifierValue = 1;
		else
			ModifierValue = 1;
		end
	end
	count = count * ModifierValue;
	BoostTriggerCount[way] = count;
	pPlayer:SetProperty("DA_Boost_"..ItemType, BoostTriggerCount);
end

function DA_Boost_Adjust_Count(playerID, ItemType, way, count, ModifierValue)
	local pPlayer = Players[playerID]
	local BoostTriggerCount = pPlayer:GetProperty("DA_Boost_"..ItemType) or {};
	if ModifierValue == nil then
		if way == 'ByTask' then
			ModifierValue = GameInfo.DA_Boosts[ItemType].ModifierValue;
		elseif way == 'ByEureka' then
			ModifierValue = 1;
		elseif way == 'ByOther' then
			ModifierValue = 1;
		else
			ModifierValue = 1;
		end
	end
	count = count * ModifierValue;
	BoostTriggerCount[way] = BoostTriggerCount[way] or 0;
	BoostTriggerCount[way] = BoostTriggerCount[way] + count;
	pPlayer:SetProperty("DA_Boost_"..ItemType, BoostTriggerCount);
end

----------------------------------------------------------------------------

BoostImprovrments = {'IMPROVEMENT_FARM', 'IMPROVEMENT_CAMP', 'IMPROVEMENT_MINE', 'IMPROVEMENT_PLANTATION', 'IMPROVEMENT_QUARRY',
	'IMPROVEMENT_PASTURE', 'BY_SEA_DIS_OR_IMP', 'ALL_IMPROVEMENT', 'IMPROVED_HORSE', 'IMPROVED_IRON', 'IMPROVEMENT_FISHING_BOATS',
	'FISHERY_WITH_RESOURCE', 'FARM_WITH_RESOURCE'};

function DA_Boost_RefreshImprovements(playerID)
	if playerID < 0 then
		return
	end

	local pPlayer = Players[playerID]
	if pPlayer:IsMajor() ~= true then
		return
	end
	local DA_Boost = {}
	for k, sImprovement in pairs(BoostImprovrments) do
		 DA_Boost[sImprovement] = pPlayer:GetProperty(sImprovement..'_COUNT') or 0;
	end
	DA_Boost_Set_Count(playerID, 'TECH_IRRIGATION', "ByTask", DA_Boost['FARM_WITH_RESOURCE'] + DA_Boost['IMPROVEMENT_PLANTATION']);
	DA_Boost_Set_Count(playerID, 'TECH_ARCHERY', "ByTask", DA_Boost['IMPROVEMENT_CAMP'] + DA_Boost['IMPROVEMENT_PASTURE']);
	DA_Boost_Set_Count(playerID, 'TECH_BRONZE_WORKING', "ByTask", DA_Boost['IMPROVEMENT_MINE']);
	DA_Boost_Set_Count(playerID, 'TECH_MASONRY', "ByTask", DA_Boost['IMPROVEMENT_QUARRY']);
	DA_Boost_Set_Count(playerID, 'TECH_SAILING', "ByTask", DA_Boost['BY_SEA_DIS_OR_IMP']);
	DA_Boost_Set_Count(playerID, 'CIVIC_CRAFTSMANSHIP', "ByTask", DA_Boost['ALL_IMPROVEMENT']);
	DA_Boost_Set_Count(playerID, 'TECH_HORSEBACK_RIDING', "ByTask", DA_Boost['IMPROVED_HORSE']);
	DA_Boost_Set_Count(playerID, 'TECH_IRON_WORKING', "ByTask", DA_Boost['IMPROVED_IRON']);
	DA_Boost_Set_Count(playerID, 'TECH_SHIPBUILDING', "ByTask", DA_Boost['IMPROVEMENT_FISHING_BOATS'] + DA_Boost['FISHERY_WITH_RESOURCE']);

end

BoostDistricts = {'BY_SEA_DIS_OR_IMP', 'SP_DISTRICT', 'DISTRICT_CITY_CENTER'};
Boost_SP_Districts = {};
for row in GameInfo.Districts() do
	if row.RequiresPopulation then
		local replaceDistrict = GameInfo.DistrictReplaces[row.DistrictType];
    	if replaceDistrict == nil then
        	table.insert(BoostDistricts, row.DistrictType);
        	table.insert(Boost_SP_Districts, row.DistrictType);
        end
    end
end


function DA_Boost_RefreshDistricts(playerID)
	if playerID < 0 then
		return
	end

	local pPlayer = Players[playerID]
	if pPlayer:IsMajor() ~= true then
		return
	end
	local DA_Boost = {}
	for k, sDistrict in pairs(BoostDistricts) do
		 DA_Boost[sDistrict] = pPlayer:GetProperty(sDistrict..'_COUNT') or 0;
	end
	DA_Boost_Set_Count(playerID, 'TECH_SAILING', "ByTask", DA_Boost['BY_SEA_DIS_OR_IMP']);
	DA_Boost_Set_Count(playerID, 'TECH_ENGINEERING', "ByTask", DA_Boost['SP_DISTRICT']);
	DA_Boost_Set_Count(playerID, 'CIVIC_DEFENSIVE_TACTICS', "ByTask", DA_Boost['DISTRICT_CITY_CENTER']);

	--历史记录和造纸术
	local iSP_District_Types = 0;
	local iMost_SP_District_Type = 0;
	for k, sDistrict in pairs(Boost_SP_Districts) do
		if DA_Boost[sDistrict] ~= 0 then
			iSP_District_Types = iSP_District_Types + 1;
			if DA_Boost[sDistrict] > iMost_SP_District_Type then
				iMost_SP_District_Type = DA_Boost[sDistrict];
			end
		end
	end
	DA_Boost_Set_Count(playerID, 'TECH_PAPER_MAKING_DA', "ByTask", iSP_District_Types);
	DA_Boost_Set_Count(playerID, 'CIVIC_RECORDED_HISTORY', "ByTask", iMost_SP_District_Type);


end



BoostBuildings = {'BUILDING_MONUMENT', 'BUILDING_GRANARY', 'BUILDING_MASON', 'BUILDING_OBSERVATORY', 'BUILDING_WATER_MILL', 'BUILDING_TRIUMPHAL' ,'ALL_WONDER'};

function DA_Boost_RefreshBuildings(playerID)
	if playerID < 0 then
		return
	end

	local pPlayer = Players[playerID]
	if pPlayer:IsMajor() ~= true then
		return
	end
	local DA_Boost = {}
	for k, sBuilding in pairs(BoostBuildings) do
		 DA_Boost[sBuilding] = pPlayer:GetProperty(sBuilding..'_COUNT') or 0;
	end
	DA_Boost_Set_Count(playerID, 'CIVIC_STATE_WORKFORCE', "ByTask", DA_Boost['BUILDING_MONUMENT'] + DA_Boost['BUILDING_GRANARY'] + DA_Boost['BUILDING_MASON']);
	DA_Boost_Set_Count(playerID, 'TECH_CONSTRUCTION', "ByTask", DA_Boost['BUILDING_OBSERVATORY'] + DA_Boost['BUILDING_WATER_MILL'] + DA_Boost['BUILDING_TRIUMPHAL']);
	DA_Boost_Set_Count(playerID, 'CIVIC_DRAMA_POETRY', "ByTask", DA_Boost['ALL_WONDER']);

end

BoostUnits = {'LAND_COMBAT', 'NAVAL'};

function DA_Boost_RefreshUnits(playerID)
	if playerID < 0 then
		return
	end

	local pPlayer = Players[playerID]
	if pPlayer:IsMajor() ~= true then
		return
	end
	local DA_Boost = {}
	for k, sUnit in pairs(BoostUnits) do
		 DA_Boost[sUnit] = pPlayer:GetProperty(sUnit..'_COUNT') or 0;
	end
	DA_Boost_Set_Count(playerID, 'TECH_SHIPBUILDING', "ByTask", DA_Boost['NAVAL']);
	--DA_Boost_Set_Count(playerID, 'CIVIC_DEFENSIVE_TACTICS', "ByTask", DA_Boost['LAND_COMBAT']);
end

BoostsOthers = {'ALL_POP'};

function DA_Boost_RefreshEveryTurn(playerID)
	if playerID < 0 then
		return
	end

	local pPlayer = Players[playerID]
	if pPlayer:IsMajor() ~= true then
		return
	end
	local DA_Boost = {}
	for k, sOther in pairs(BoostsOthers) do
		 DA_Boost[sOther] = pPlayer:GetProperty(sOther..'_COUNT') or 0;
	end
	DA_Boost_Set_Count(playerID, 'CIVIC_EARLY_EMPIRE', "ByTask", DA_Boost['ALL_POP']);

	local pReligion = pPlayer:GetReligion();
	local iFaithBalance = pReligion:GetFaithBalance();
	local belief = pReligion:GetPantheon();
    if belief ~= nil and belief ~= -1 then
    	iFaithBalance = iFaithBalance + tonumber(GameInfo.GlobalParameters['RELIGION_PANTHEON_MIN_FAITH'].Value);
    end
    DA_Boost_Set_Count(playerID, 'CIVIC_MYSTICISM', "ByTask", iFaithBalance);

    local iFaithYield = pReligion:GetFaithYield();
    DA_Boost_Set_Count(playerID, 'CIVIC_THEOLOGY', "ByTask", iFaithYield);
    local pTreasury = pPlayer:GetTreasury();
    local iGoldYield = pTreasury:GetGoldYield();
    DA_Boost_Set_Count(playerID, 'TECH_CURRENCY', "ByTask", iGoldYield);


    local pTech = pPlayer:GetTechs();
    local iScienceYield = pTech:GetScienceYield();
    DA_Boost_Set_Count(playerID, 'TECH_MATHEMATICS', "ByTask", iScienceYield);

    local maxAmenity = 0;
	for _, pCity in pPlayer:GetCities():Members() do
		local cityID = pCity:GetID();
		local iAmenity = Utils.GetCityAmenity(playerID, cityID);
		if iAmenity > maxAmenity then
			maxAmenity = iAmenity;
		end
	end
	DA_Boost_Set_Count(playerID, 'CIVIC_GAMES_RECREATION', "ByTask", maxAmenity);

	local pPlayerVisibility = PlayersVisibility[playerID];
	local curExploredCount:number = pPlayerVisibility:GetNumRevealedHexes();
	DA_Boost_Set_Count(playerID, 'TECH_CELESTIAL_NAVIGATION', "ByTask", curExploredCount/10);

end







