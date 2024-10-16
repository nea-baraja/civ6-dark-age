GameEvents = ExposedMembers.GameEvents;
Utils = ExposedMembers.DA.Utils;

GameEvents.GetDistrictCount.Add(function(playerID,	cityID)
	local pCity = CityManager:GetCity(playerID, cityID)
	if pCity == nil then
		return
	end
	local amount = pCity:GetDistricts():GetCount()
	--print(amount)
	GameEvents.UpdateDistrictCount.Call(playerID,	cityID, amount)
end)

function CallQuestFinished( CityStateID, CompletedQuestPlayerID)
    local pCityState = Players[CityStateID]
    local pPlayer = Players[CompletedQuestPlayerID]
    if(pCityState == nil or pPlayer == nil) then return end

    local iFirstMeet = Utils.GetPlayerProperty(CompletedQuestPlayerID, 'FIRST_MEET_CITYSTATE_'..CityStateID)
    if iFirstMeet == nil then
     	GameEvents.SetPlayerProperty.Call(CompletedQuestPlayerID, 'FIRST_MEET_CITYSTATE_'..CityStateID, 0)
        return
    end
    local era = Game.GetEras():GetCurrentEra()
    local iFinishedThisEra = Utils.GetPlayerProperty(CompletedQuestPlayerID, era..'ERA_FINISHED_CITYSTATE_'..CityStateID)
    if iFinishedThisEra == 1 then
        print('just era change')
        return
    end
    GameEvents.QuestFinished.Call(CompletedQuestPlayerID, CityStateID)
    GameEvents.SetPlayerProperty.Call(CompletedQuestPlayerID, era..'ERA_FINISHED_CITYSTATE_'..CityStateID, 1)
    --GameEvents.SendEnvoytoCityState.Call(CompletedQuestPlayerID, CityStateID)
    print('double envoy')

end

Events.QuestChanged.Add( CallQuestFinished );

Utils.GetDiplomaticAI = function(playerID)
    local player= Players[playerID];
    return player:GetDiplomaticAI()
end

Utils.HasEmbassyAt = function(iPlayer1, iPlayer2)
    local player= Players[iPlayer1];
    return player:GetDiplomacy():HasEmbassyAt(iPlayer2)
end

Utils.HasDelegationAt = function(iPlayer1, iPlayer2)
    local player= Players[iPlayer1];
    return player:GetDiplomacy():HasDelegationAt(iPlayer2)
end
--[[
for _, player in ipairs(PlayerManager.GetAliveMajors()) do
        local iRelation = Utils.GetDiplomaticAI(player:GetID()):GetDiplomaticStateIndex(0);
        if iRelation ~= nil and iRelation ~= -1 then
            local sRelation = GameInfo.DiplomaticStates[iRelation].StateType;
            if (sRelation ~= 'DIPLO_STATE_ALLIED' or sRelation == 'DIPLO_STATE_DECLARED_FRIEND') and player:GetID() ~= 0 then
                local PurchasePantheonNotificationHash = DB.MakeHash("NOTIFICATION_PURCHASE_PANTHEON");
                local sTitle = Locale.Lookup('LOC_PURCHASE_PANTHEON_TITLE');
                local sDesc = Locale.Lookup('LOC_PURCHASE_PANTHEON_DESCRIPTION', GameInfo.Civilizations[PlayerConfigurations[player:GetID()]:GetCivilizationTypeName()].Name);
                local notificationData = {};
                notificationData[ParameterTypes.MESSAGE] = sTitle;
                notificationData[ParameterTypes.SUMMARY] = sDesc
                notificationData.AlwaysUnique = true; 
                notificationData.SellPlayer = player:GetID();
                NotificationManager.SendNotification(0, PurchasePantheonNotificationHash, notificationData);
            end
        end
    end
]]

Utils.IsAI = function(playerID)
    local player= Players[playerID];
    return player:IsAI()
end

Utils.GetCurrentGovernments = function(playerID)
    local player= Players[playerID];
    return player:GetCulture():GetCurrentGovernment();
end


Utils.GetCurrentlyBuildingProgress = function(playerID, cityID, buildingID)
    local pCity = CityManager.GetCity(playerID,    cityID);
    return pCity:GetBuildQueue():GetBuildingProgress(buildingID);
end

--获得城市建造进度
Utils.GetCurrentlyBuildProgress = function(playerID, cityID)
    local pCity = CityManager.GetCity(playerID,    cityID);
    local pBuildQueue = pCity:GetBuildQueue();
    local iBuildHash = pBuildQueue:GetCurrentProductionTypeHash();
    local buildingDef   :table = GameInfo.Buildings[iBuildHash];
    local districtDef   :table = GameInfo.Districts[iBuildHash];
    local unitDef       :table = GameInfo.Units[iBuildHash];
    local projectDef    :table = GameInfo.Projects[iBuildHash];

    if( buildingDef ~= nil ) then
        return pBuildQueue:GetBuildingProgress(buildingDef.Index);
    elseif( districtDef ~= nil ) then
        return pBuildQueue:GetDistrictProgress(districtDef.Index);
    elseif( unitDef ~= nil ) then
        return pBuildQueue:GetUnitProgress(unitDef.Index);
    elseif (projectDef ~= nil) then
        return pBuildQueue:GetProjectProgress(projectDef.Index);
    else
        return 0;
    end
end


Utils.IsMajor = function(playerID)
    local pPlayer = Players[playerID];
    return pPlayer:IsMajor();
end

Utils.IsMinor = function(playerID)
    local pPlayer = Players[playerID];
    return pPlayer:IsMinor();
end

Utils.IsAtWarWith = function(playerID1, playerID2)
    local pPlayer1 = Players[playerID1];
    return pPlayer1:GetDiplomacy():IsAtWarWith(playerID2);
end

--是否可建资源在此单元格
Utils.CanBuildResource = function(plotID, sResourceType, PlayerID)
    local bValidTerrainOrFeature = false;
    local pPlot = Map.GetPlotByIndex(plotID);
    if pPlot:GetDistrictType() ~= -1 then
        return false;
    end
    if pPlot:GetResourceType() ~= -1 and not Utils.IsPlotResourceUnrevealed(plotID, PlayerID) then
        return false;
    end
    local eImprovement = pPlot:GetImprovementType();
    if eImprovement ~= -1 then
        local sImprovementType = GameInfo.Improvements[eImprovement].ImprovementType;
        local bValidImprovement = false;
        for row in GameInfo.Improvement_ValidResources() do
            if sResourceType == row.ResourceType and sImprovementType == row.ImprovementType then
                bValidImprovement = true;
            end
        end
        if not bValidImprovement then return false; end
    end
    local eFeature = pPlot:GetFeatureType();
    if eFeature ~= -1 then 
        local sFeatureType = GameInfo.Features[eFeature].FeatureType;
        for row in GameInfo.Resource_ValidFeatures() do
            if sResourceType == row.ResourceType and IsFeatureOnTerrain(row.FeatureType, sTerrainType) then
                return true;
            end
        end
        return false;
    end
    local eTerrain = pPlot:GetTerrainType();
    if eTerrain == -1 then return false; end
    local sTerrainType = GameInfo.Terrains[eTerrain].TerrainType;
    -- if the resource has any valid terrain, return true once terrain matches
    for row in GameInfo.Resource_ValidTerrains() do
        if sResourceType == row.ResourceType and sTerrainType == row.TerrainType then
            return true;
        end
    end

end


--资源是否可见
Utils.IsPlotResourceUnrevealed = function(plotID, PlayerID)
    local pPlot = Map.GetPlotByIndex(plotID);
    local eResource = pPlot:GetResourceType();
    if eResource == -1 then return false; end
    local pPlayer = Players[PlayerID];
    local pPlayerResources = pPlayer:GetResources();
    return not pPlayerResources:IsResourceVisible(eResource);
    -- local sPrereqTech = GameInfo.Resources[eResource].PrereqTech;
    -- local sPrereqCivic = GameInfo.Resources[eResource].PrereqCivic;
    -- local pPlayer = Players[PlayerID];
    -- local tPlayerTechs = pPlayer:GetTechs();
    -- local tPlayerCulture = pPlayer:GetCulture();
    -- if sPrereqTech ~= nil then
    --     local ePrereqTech = GameInfo.Technologies[sPrereqTech].Index;
    --     if not tPlayerTechs:HasTech(ePrereqTech) then
    --         return true;
    --     end
    -- end
    -- if sPrereqCivic ~= nil then
    --     local ePrereqCivic = GameInfo.Civics[sPrereqCivic].Index;
    --     if not tPlayerCulture:HasCivic(ePrereqTech) then
    --         return true;
    --     end
    -- end
    -- return false;
end


--获取指定类型的政策槽位数
--playerID，数字，
--SlotType，字符串，槽位的类型"SLOT_"
Utils.GetNumPolicySlot = function(playerID, SlotType: string)
    local pPlayer = Players[playerID]
    local pPlayerCulture = pPlayer:GetCulture()
    local NumAllPolicySlots:number = pPlayerCulture:GetNumPolicySlots()
    local NumSlotType = 0
    if NumAllPolicySlots > 0 then
        for i = 0, NumAllPolicySlots-1, 1 do
            local iSlotType :number = pPlayerCulture:GetSlotType(i);
            local rowSlotType   :string = GameInfo.GovernmentSlots[iSlotType].GovernmentSlotType
            if rowSlotType == SlotType then
                NumSlotType = NumSlotType+1
            end
        end
    end
    return NumSlotType
end

-- Utils.PlayerHasTrait = function(playerID, sTrait)
--     local playerConfig = PlayerConfigurations[playerID];
--     local sCiv = playerConfig:GetCivilizationTypeName();
--     for tRow in GameInfo.CivilizationTraits() do
--         if (tRow.CivilizationType == sCiv and tRow.TraitType == sTrait) then
--             return true;
--         end
--     end
--     local sLeader = playerConfig:GetLeaderTypeName();
--     for tRow in GameInfo.LeaderTraits() do
--         if (tRow.LeaderType == sLeader and tRow.TraitType == sTrait) then
--             return true;
--         end
--     end
--     return false;
-- end

Utils.PlayerHasTrait = function(playerID, sTrait)
    local playerConfig = PlayerConfigurations[playerID];
    local sCiv = playerConfig:GetCivilizationTypeName();
    local sLeader = playerConfig:GetLeaderTypeName();
    for _, row in pairs(GameInfo.Civilizations[sCiv].TraitCollection) do
        if row.TraitType == sTrait then
            return true;
        end
    end
    if GameInfo.Leaders[sLeader] ~= nil then
        for _, row in pairs(GameInfo.Leaders[sLeader].TraitCollection) do
            if row.TraitType == sTrait then
                return true;
            end
        end
    end
    return false;
end

Utils.__PlayerHasTrait = function(playerID, sTrait)
    local playerConfig = PlayerConfigurations[playerID];
    local sCiv = playerConfig:GetCivilizationTypeName();
    local sLeader = playerConfig:GetLeaderTypeName();
    for _, row in pairs(GameInfo.Civilizations[sCiv].TraitCollection) do
        if row.TraitType == sTrait then
            return true;
        end
    end
    if GameInfo.Leaders[sLeader] ~= nil then
        for _, row in pairs(GameInfo.Leaders[sLeader].TraitCollection) do
            if row.TraitType == sTrait then
                return true;
            end
        end
    end
    return false;
end

--判断区域被掠夺
Utils.DistrictIsPillaged = function(iX,iY)
    local pPlot = Map.GetPlot(iX, iY)
    local pCity = Cities.GetPlotPurchaseCity(pPlot)
    local eDistrictType = pPlot:GetDistrictType()
    local DistrictPillaged = pCity:GetDistricts():IsPillaged(eDistrictType, pPlot:GetIndex())
    if DistrictPillaged then
        return true
    else
        return false
    end
end

Utils.GetCurrentlyBuildingType = function(playerID, cityID)
    local pCity = CityManager.GetCity(playerID, cityID);
    local pBuildQueue = pCity:GetBuildQueue();
    if pBuildQueue == nil then return 0, 0 end
    local hash = pBuildQueue:GetCurrentProductionTypeHash();
    if hash == 0 then return 0, 0 end
    local buildingDef   :table = GameInfo.Buildings[hash];
    local districtDef   :table = GameInfo.Districts[hash];
    local unitDef       :table = GameInfo.Units[hash];
    local projectDef    :table = GameInfo.Projects[hash];
    if( buildingDef ~= nil ) then
        return 1, hash;
    elseif( districtDef ~= nil ) then
        return 2, hash;
    elseif( unitDef ~= nil ) then
        return 3, hash;
    elseif( projectDef ~= nil ) then
        return 4, hash;
    end
end

Utils.CityHasDistrictOrUD = function(playerID, cityID, districtType)
    local pCity = CityManager.GetCity(playerID, cityID);
    local pCityDistricts = pCity:GetDistricts();
    if pCityDistricts:HasDistrict(GameInfo.Districts[districtType].Index) then
        return true;
    end
    local UDs = GameInfo.Districts[districtType].ReplacedByCollection;
    for _,row in pairs(UDs) do
        --print(row.CivUniqueDistrictType)
        if pCityDistricts:HasDistrict(GameInfo.Districts[row.CivUniqueDistrictType].Index) then
            return true;
        end
    end
    return false;
end

Utils.IsDistrictOrUD = function(districtType, targetDistrictType)
	if districtType == targetDistrictType then
		return true;
	end
	local UDs = GameInfo.Districts[targetDistrictType].ReplacedByCollection;
	for _,row in pairs(UDs) do
		if row.CivUniqueDistrictType == districtType then
			return true;
		end
	end
	return false;
end


Utils.DA_GetCulturalProgress = function(playerID,CivicID)
    local pPlayer = Players[playerID]
    return pPlayer:GetCulture():GetCulturalProgress(CivicID)
end

Utils.GetCityAmenity = function(playerID, cityID)
    local pCity = CityManager.GetCity(playerID, cityID);
    if pCity == nil then 
        --print('error in player '..playerID..' city '..cityID)
        return 0; 
    end
    local pCityGrowth = pCity:GetGrowth();
    local iAmenity = pCityGrowth:GetAmenities() - pCityGrowth:GetAmenitiesNeeded();
    return iAmenity;
end


-- local playerConfig = PlayerConfigurations[0];
-- local sCiv = playerConfig:GetCivilizationTypeName();
-- print(sCiv)
-- local traits = GameInfo.Civilizations[sCiv].TraitCollection
-- print(traits)
-- for _,row in pairs(traits) do
--     print(row.TraitType)
-- end

Utils.GetDistrictCost = function (playerID, cityID, districtType)
    local pCity = CityManager.GetCity(playerID, cityID);
    --获取城市生产队列、区域造价和区域进度
    local cityBuildQueue = pCity:GetBuildQueue()
    local cost           = cityBuildQueue:GetDistrictCost(districtType)
    local progress       = cityBuildQueue:GetDistrictProgress(districtType)
    --返回信仰值消耗
    return (cost - progress)
end

Utils.GetGovernorPoints = function(playerID)
    local pPlayer = Players[playerID];
    if pPlayer ~= nil then
        local playerGovernors = pPlayer:GetGovernors();
        local governorPointsObtained = playerGovernors:GetGovernorPoints();
        local governorPointsSpent = playerGovernors:GetGovernorPointsSpent();
        local hidedGovernors = pPlayer:GetProperty('PROP_HIDE_GOVERNOR') or 0;
        return (governorPointsObtained - governorPointsSpent - hidedGovernors);
    end
end

Utils.GetTotalUnity = function(playerID)
    local pPlayer = Players[playerID];
    if pPlayer ~= nil then
        local unityBalance = pPlayer:GetProperty('PROP_UNITY_BALANCE') or 0;
        local unityThreshold = pPlayer:GetProperty('PROP_UNITY_THRESHOLD') or 200;
        local totalUnity = unityBalance + unityThreshold * Utils.GetGovernorPoints(playerID);
        return totalUnity;
    end
end

Utils.GetItemBoost = function(playerID, itemID)
    if Players == nil then return 0 end
    local pPlayer = Players[playerID];
    local totalBoostValue = 0;
    local boost = pPlayer:GetProperty("DA_Boost_"..itemID) or {};
    for _, boostValue in pairs(boost) do
        totalBoostValue = totalBoostValue + boostValue;
    end
    
    --MANNUAL
    local boostByPioneer = Utils.GetBoostByPioneer(playerID, itemID);
    totalBoostValue = totalBoostValue + boostByPioneer;
    
    return totalBoostValue;
end

Utils.GetItemEra = function(itemID)
    local itemInfo = GameInfo.Technologies[itemID] or GameInfo.Civics[itemID];
    return itemInfo.EraType;
end

Utils.GetBoostByPioneer = function(playerID, itemID)
    if playerID == nil or playerID == -1 then
        return 0;
    end
    if Players == nil then return 0 end
    local pPlayer = Players[playerID];
    local boostByPioneer = 0;
    if GameInfo.Technologies[itemID] ~= nil then
        boostByPioneer = pPlayer:GetProperty('DA_Boost_By_Pioneer_Tech') or 0;
    elseif GameInfo.Civics[itemID] ~= nil then
        boostByPioneer = pPlayer:GetProperty('DA_Boost_By_Pioneer_Civic') or 0;
    end
    if boostByPioneer > 0 then
        local iEra = GameInfo.Eras[Utils.GetItemEra(itemID)].ChronologyIndex;
        if iEra <= 2 then
            return boostByPioneer;
        elseif iEra <= 4 then
            return boostByPioneer / 2;
        elseif iEra <= 6 then
            return boostByPioneer / 4;
        elseif iEra <= 8 then
            return boostByPioneer / 8;
        else
            return boostByPioneer / 16;
        end
    end
    return 0;
end
    

