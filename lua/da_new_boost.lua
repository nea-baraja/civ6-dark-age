GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
--DA_Boost
--轮子
function DA_Boost_OnUnitTriggerGoodyHut(playerID,unitID,goodyHutType)
	-- if goodyHutType ~= goodyHutType then
	-- 	return
	-- end
	local pPlayer = Players[playerID]
	local BoostTriggerCount = (pPlayer:GetProperty("DA_Boost_TECH_THE_WHEEL") or {})['ByTask'] or 0;
	DA_Boost_Set_Count(playerID, "TECH_THE_WHEEL", "ByTask", BoostTriggerCount + 1);
end
GameEvents.UnitTriggerGoodyHut.Add(DA_Boost_OnUnitTriggerGoodyHut)
--写作
function DA_Boost_OnDiplomacyMeet(playerID1,playerID2)
	local pPlayer1 = Players[playerID1];
	local pPlayer2 = Players[playerID2];
	if pPlayer1:IsMajor() ~= true or pPlayer2:IsMajor() ~= true then
		return
	end
	local BoostTriggerCount1 = (pPlayer1:GetProperty("DA_Boost_TECH_WRITING") or {})['ByTask'] or 0;
	local BoostTriggerCount2 = (pPlayer2:GetProperty("DA_Boost_TECH_WRITING") or {})['ByTask'] or 0;
	DA_Boost_Set_Count(playerID1, "TECH_WRITING", "ByTask", BoostTriggerCount1 + 1);
	DA_Boost_Set_Count(playerID2, "TECH_WRITING", "ByTask", BoostTriggerCount2 + 1);
end
Events.DiplomacyMeet.Add(DA_Boost_OnDiplomacyMeet)
--占星术
function DA_Boost_OnNotificationAdded(playerID,NotificationID)
	local pNotification = NotificationManager.Find(playerID,NotificationID);
	if GameInfo.Notifications[pNotification:GetType()].NotificationType ~= "NOTIFICATION_DISCOVER_NATURAL_WONDER" then
		return
	end
	local pPlayer = Players[playerID];
	local BoostTriggerCount = (pPlayer:GetProperty("DA_Boost_TECH_ASTROLOGY") or {})['ByTask'] or 0;
	DA_Boost_Set_Count(playerID, "TECH_ASTROLOGY", "ByTask", BoostTriggerCount + 1);
end
Events.NotificationAdded.Add(DA_Boost_OnNotificationAdded);


----------------------------------------------------------------------------
function DA_Boost_OnCivicBoostTriggered(playerID,iBoostedCivic)
	if GameInfo.DA_Boost_Civic[GameInfo.Civics[iBoostedCivic].CivicType] == nil then
		return
	end
	local CivicType = GameInfo.Civics[iBoostedCivic].CivicType;
	local pPlayer = Players[playerID];
	
	local CivicCurrentResearchProgress = Utils.DA_GetCulturalProgress(playerID,iBoostedCivic);
	pPlayer:GetCulture():ReverseBoost(iBoostedCivic);
	pPlayer:GetCulture():SetCulturalProgress(iBoostedCivic,CivicCurrentResearchProgress);
	

	local BoostTriggerCount = (pPlayer:GetProperty("DA_Boost_"..CivicType) or {})['ByOther'];
	DA_Boost_Set_Count(playerID, CivicType, "ByOther", BoostTriggerCount + 1);
end
Events.CivicBoostTriggered.Add(DA_Boost_OnCivicBoostTriggered);

function DA_Boost_OnTechBoostTriggered(playerID,iBoostedTech)
	if GameInfo.DA_Boost_Tech[GameInfo.Technologies[iBoostedTech].TechnologyType] == nil then
		return
	end
	local TechnologyType = GameInfo.Technologies[iBoostedTech].TechnologyType;
	local pPlayer = Players[playerID];
	
	local TechCurrentResearchProgress = pPlayer:GetTechs():GetResearchProgress(iBoostedTech);
	pPlayer:GetTechs():ReverseBoost(iBoostedTech);
	pPlayer:GetTechs():SetResearchProgress(iBoostedTech,TechCurrentResearchProgress);
	
	local BoostTriggerCount = (pPlayer:GetProperty("DA_Boost_"..TechnologyType) or {})['ByOther'];
	DA_Boost_Set_Count(playerID, TechnologyType, "ByOther", BoostTriggerCount + 1);
end
Events.TechBoostTriggered.Add(DA_Boost_OnTechBoostTriggered);

----------------------------------------------------------------------------


function DA_Boost_OnImprovementRemovedFromMap(iX,iY,playerID)
	DA_Boost_RefreshImprovements(playerID)
end
Events.ImprovementRemovedFromMap.Add(DA_Boost_OnImprovementRemovedFromMap)
function DA_Boost_OnImprovementAddedToMap(iX, iY, ImprovementID, playerID)
	DA_Boost_RefreshImprovements(playerID)
end
Events.ImprovementAddedToMap.Add(DA_Boost_OnImprovementAddedToMap)
function DA_Boost_OnDistrictAddedToMap(playerID,districtID,cityID,districtX,districtY,districtType,percentComplete)
	DA_Boost_RefreshDistricts(playerID)
end
Events.DistrictAddedToMap.Add(DA_Boost_OnDistrictAddedToMap)
function DA_Boost_OnDistrictRemovedFromMap(playerID,districtID,cityID,districtX,districtY)
	DA_Boost_Tech_RefreshImprovementsOrDistricts(playerID)
end
Events.DistrictRemovedFromMap.Add(DA_Boost_OnDistrictRemovedFromMap)
function DA_Boost_DistrictBuildProgressChanged(playerID, districtID, cityID, iX, iY,  districtType, era, civilization, percentComplete, iAppeal, isPillaged)
	if percentComplete ~= 100 then
		return
	end
	DA_Boost_Tech_RefreshDistricts(playerID)
end
Events.DistrictBuildProgressChanged.Add(DA_Boost_DistrictBuildProgressChanged)


----------------------------------------------------------------------------

function DA_Boost_AddProgressByBoost(playerID, bIsFirstTime)
	if blsFirstTime == true then
		return
	end
	local pPlayer = Players[playerID]
	if pPlayer:IsMajor() ~= true then
		return
	end
	DA_Boost_Tech_RefreshImprovementsOrDistricts(playerID);
	local TechID = pPlayer:GetTechs():GetResearchingTech();
	local CivicID = pPlayer:GetCulture():GetProgressingCivic();
	local ModifierValueByOther = 1
	if TechID ~= -1 and GameInfo.DA_Boost_Tech[GameInfo.Technologies[TechID].TechnologyType] ~= nil then
		local TechType = GameInfo.Technologies[TechID].TechnologyType;
		local CurrentTechYield = pPlayer:GetTechs():GetScienceYield();
		local TechBoostTriggerByOther = (pPlayer:GetProperty("DA_Boost_"..TechType) or {})['ByOther'] or 0;
		local TechBoostTriggerByTask = (pPlayer:GetProperty("DA_Boost_"..TechType) or {})['ByTask'] or 0;
		local ModifierValue = GameInfo.DA_Boost_Tech[TechType].ModifierValue;
		pPlayer:GetTechs():ChangeCurrentResearchProgress(CurrentTechYield*TechBoostTriggerByTask*ModifierValue+CurrentTechYield*TechBoostTriggerByOther*ModifierValueByOther)
	end
	if CivicID ~= -1 and GameInfo.DA_Boost_Civic[GameInfo.Civics[CivicID].CivicType] ~= nil then
		local CivicType = GameInfo.Civics[CivicID].CivicType;
		local CurrentCivicYield = pPlayer:GetCulture():GetCultureYield();
		local CivicBoostTriggerByOther = (pPlayer:GetProperty("DA_Boost_"..CivicType) or {})['ByOther'] or 0;
		local CivicBoostTriggerByTask = (pPlayer:GetProperty("DA_Boost_"..CivicType) or {})['ByTask'] or 0;
		local ModifierValue = GameInfo.DA_Boost_Civic[CivicType].ModifierValue;
		pPlayer:GetCulture():ChangeCurrentCulturalProgress(CurrentCivicYield*CivicBoostTriggerByTask*ModifierValue+CurrentCivicYield*CivicBoostTriggerByOther*ModifierValueByOther)
	end
	
end
Events.PlayerTurnActivated.Add(DA_Boost_AddProgressByBoost)


function DA_Boost_Set_Count(playerID, ItemType, way, count)
	local pPlayer = Players[playerID]
	local BoostTriggerCount = pPlayer:GetProperty("DA_Boost_"..ItemType) or {}
	BoostTriggerCount[way] = count;
	
	pPlayer:SetProperty("DA_Boost_"..ItemType, BoostTriggerCount)
end

----------------------------------------------------------------------------

tImprovementPlot = {};
tDistrictPlot = {};


function DA_Boost_Tech_RefreshImprovementsOrDistricts(playerID)
	if playerID < 0 then
		return
	end
	local pPlayer = Players[playerID]
	if pPlayer:IsMajor() ~= true then
		return
	end
	local BoostCount = {};

	local pPlayerImprovementsPlots = Utils.DA_GetImprovements_Plots(playerID);
 	for k,plotID in pairs(pPlayerImprovementsPlots) do
        local pPlot = Map.GetPlotByIndex(plotID);
        local ImprovementID = pPlot:GetImprovementType();
        local ImprovementType = GameInfo.Improvements[ImprovementID].ImprovementType;
        tImprovementPlot[plotID] = ImprovementType;
        local tBoostByImprovement = Utils.DA_Boost_Improvement(playerID, plotID, ImprovementType);
        for item, count in pairs(tBoostByImprovement) do
        	BoostCount[item] = BoostCount[item] or 0;
        	BoostCount[item] = BoostCount[item] + count;
        end
    end


	local pPlayerDistricts = Utils.DA_GetDistricts(playerID);
	 for k, district in pPlayerDistricts:Members() do
        if district:IsComplete() then
        	local iX, iY = district:GetLocation();
        	local districtID = district:GetType();
        	local tBoostByDistrict = Utils.DA_Boost_District(playerID, iX, iY, districtID);
        	local plotID = Map.GetPlot(iX, iY):GetIndex();
        	tDistrictPlot[plotID] = GameInfo.Districts[districtID].DistrictType;
        	for item, count in pairs(tBoostByDistrict) do
	        	BoostCount[item] = BoostCount[item] or 0;
	        	BoostCount[item] = BoostCount[item] + count;
	        end
        end
    end

	for item, count in pairs(BoostCount) do
		DA_Boost_Set_Count(playerID, item, "ByTask", count)
	end
end











