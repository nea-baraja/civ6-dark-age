
ExposedMembers.GameEvents = GameEvents
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
GameEvents.SetPlotProperty.Add(function(plotID, key, value)
    local plot = Map.GetPlotByIndex(plotID)
  --  print(plot:GetX(), plot:GetY(), plot)
    plot:SetProperty(key, value)
end)

GameEvents.GetGameProperty.Add(function(key)
    return Game.GetProperty(key)
end)

GameEvents.SetGameProperty.Add(function(key, value)
    Game.SetProperty(key, value)
end)

-- GameEvents.GetPlayerProperty.Add(function(playerID, key)
--     local player = Players[playerID]
--     return player:GetProperty(key)
-- end)

GameEvents.SetPlayerProperty.Add(function(playerID, key, value)
    local player = Players[playerID]
    player:SetProperty(key, value)
end)

GameEvents.OP_SetPlayerProperty.Add(function(playerID, params)   
    local player = Players[params.playerID]
    player:SetProperty(params.key, params.value)
end)



GameEvents.SetUnitProperty.Add(function(playerID, unitID, key, value)
    local player = Players[playerID]
    local pUnits = player:GetUnits()
    local pUnit = pUnits:FindID(unitID)
    if pUnit ~= nil then
        pUnit:SetProperty(key, value)
    end
end)

--[[GameEvents.GetPlotWonderType.Add(function(plotID)
    local plot = Map.GetPlotByIndex(plotID)
    print(plot:GetWonderType())
    return plot:GetWonderType()
end)
--]] --GameEvents是不能返回值的

Utils.SetPlayerProperty = function(playerID, key, value)
    local player = Players[playerID]
    player:SetProperty(key, value)
end

Utils.SetGameProperty = function(key, value)
    Game.SetProperty(key, value)
end

Utils.GetGameProperty = function(key)
    return Game.GetProperty(key)
end

Utils.GetPlotProperty = function(plot, key)
    return plot:GetProperty(key)
end

Utils.GetPlayerProperty = function(playerID, key)
    local pPlayer = Players[playerID]
    if pPlayer ~= nil then
        return pPlayer:GetProperty(key)
    end
end

--创建区域
--playerID-区域所在城市拥有者id,cityID-区域所在城市id,DistrictsIndex-区域的index:numbeur,num-进度？100,iX,iY创建的单元格坐标
Utils.CreateDistrict = function(playerID,cityID,DistrictsIndex,num,iX,iY)
    local pCity = CityManager.GetCity(playerID, cityID)
    local pBuildQueue = pCity:GetBuildQueue()
    local pPlot = Map.GetPlot(iX,iY)
    pBuildQueue:CreateIncompleteDistrict(DistrictsIndex, pPlot:GetIndex(), 100)
end

--城市setProperty
Utils.SetCityProperty = function(playerID, cityID, key, value)
    local pCity = CityManager.GetCity(playerID, cityID)
    pCity:SetProperty(key, value)
end

GameEvents.OP_SetCityProperty.Add( function(playerID, params)
    local pPlayer = Players[params.playerID]   
    local pCity = pPlayer:GetCities():FindID(params.iCity) 
    if pCity ~= nil then
        pCity:SetProperty(params.sPropertyName, params.Value);
    end
end)


--Utils.SetPlotProperty.Add(function(plotID, key, value)
--    local plot = Map.GetPlotByIndex(plotID)
--    print(plot:GetX(), plot:GetY(), plot)
--    plot:SetProperty(key, value)
--end)

GameEvents.OP_SetPlotProperty.Add( function(playerID, params)
    local plot = Map.GetPlotByIndex(params.plotID);
    plot:SetProperty(params.sPropertyName, params.Value);
end)

function ChangeFaithBalance(playerID, amount)
    local player = Players[playerID]
    if player ~= nil then
        player:GetReligion():ChangeFaithBalance(amount)
    end
end
GameEvents.RequestChangeFaithBalance.Add(ChangeFaithBalance)

function ChangeGoldBalance(playerID, amount)
    local player = Players[playerID]
    if player ~= nil then
        player:GetTreasury():ChangeGoldBalance(amount)
    end
end
GameEvents.RequestChangeGoldBalance.Add(ChangeGoldBalance)

function SetGoldBalance(playerID, amount)
    local player = Players[playerID]
    if player ~= nil then
        player:GetTreasury():SetGoldBalance(amount)
    end
end
GameEvents.SetGoldBalance.Add(SetGoldBalance)


function GetCurrentlyBuilding(playerID, cityID)
    local city = CityManager.GetCity(playerID, cityID);
    return city:GetBuildQueue():CurrentlyBuilding();
end

Utils.GetCurrentlyBuilding = GetCurrentlyBuilding;
--GameEvents.GetCurrentlyBuilding.Add(Get_CurrentlyBuilding)


GameEvents.RequestFinishProgress.Add(function(playerID, cityID)
    local city = CityManager.GetCity(playerID,    cityID);    
    city:GetBuildQueue():FinishProgress();
end)

GameEvents.RequestAddProgress.Add(function(playerID, cityID,produnction)   
    local city = CityManager.GetCity(playerID,    cityID);
    city:GetBuildQueue():AddProgress(produnction);
end)

GameEvents.OP_RequestAddProgress.Add(function(playerID, params)   
    local city = CityManager.GetCity(params.playerID,    params.cityID);
    city:GetBuildQueue():AddProgress(params.produnction);
end)

GameEvents.AddGreatPeoplePoints.Add(function(playerID, gppID, amount)
    local player = Players[playerID]
    if player ~= nil then
        --print('DA DEBUG add great people point', playerID, gppID, amount)
        player:GetGreatPeoplePoints():ChangePointsTotal(gppID, amount)
    end
end)

GameEvents.RequestCreateBuilding.Add(function (playerID, cityID, buildingID)
    local city = CityManager.GetCity(playerID, cityID)
    --print('DA DEBUG create building requested', playerID, cityID, buildingID)
    if city then
        local buildingQueue = city:GetBuildQueue()
        -- print(city, buildingQueue)
        buildingQueue:CreateBuilding(buildingID) 
    end
end)

GameEvents.RequestRemoveBuilding.Add(function (playerID, cityID, buildingID)
    local city = CityManager.GetCity(playerID, cityID)
    --print('DA DEBUG remove building requested', playerID, cityID, buildingID)
    if city ~= nil then
        local buildings = city:GetBuildings()
        buildings:RemoveBuilding(buildingID)
    end
end)

GameEvents.StrategicResourcesChange.Add(function(playerID, ResourceType, amount)
    local player = Players[playerID]
    local playerResources = Players[playerID]:GetResources()
    local resource_id = GameInfo.Resources[ResourceType].Index
    playerResources:ChangeResourceAmount(resource_id, amount)
end)

GameEvents.SetAbilityCount.Add(function(playerID, unitID, sAbility, count)
    local player = Players[playerID]
    local pUnits = player:GetUnits()
    local pUnit = pUnits:FindID(unitID)
    local pUnitAbility = pUnit:GetAbility()
    local oldCount = pUnitAbility:GetAbilityCount(sAbility)
    pUnitAbility:ChangeAbilityCount(sAbility, count - oldCount)
end)

Utils.SetAbilityCount = function(playerID, unitID, sAbility, count)
    local player = Players[playerID]
    local pUnits = player:GetUnits()
    local pUnit = pUnits:FindID(unitID)
    local pUnitAbility = pUnit:GetAbility()
    local oldCount = pUnitAbility:GetAbilityCount(sAbility)
    pUnitAbility:ChangeAbilityCount(sAbility, count - oldCount)
end



GameEvents.RestoreUnitMovement.Add(function(playerID, unitID)
    local player = Players[playerID]
    local pUnits = player:GetUnits()
    local pUnit = pUnits:FindID(unitID)
    if pUnit ~= nil then
        UnitManager.RestoreMovement(pUnit)
    end
end)

GameEvents.ChangeUnitMovesRemaining.Add(function(playerID, unitID, amount)
    local player = Players[playerID]
    local pUnits = player:GetUnits()
    local pUnit = pUnits:FindID(unitID)
    if pUnit ~= nil then
        UnitManager.ChangeMovesRemaining(pUnit, amount);
    end
end)

GameEvents.SendEnvoytoCityState.Add(function(playerID, citystateID)
    -- Need to make sure the second is citystate
    local player = Players[playerID]
    if player ~= nil then
        player:GetInfluence():GiveFreeTokenToPlayer(citystateID)
    end
end)


GameEvents.UnlockPolicy.Add(function(playerID, policyID)
    -- Need to make sure the second is citystate
    local player = Players[playerID]
    if player ~= nil then
        local pCulture = player:GetCulture();
        pCulture:UnlockPolicy(policyID);
    end
end)

GameEvents.PlayerAttachModifierByID.Add( function(playerID, sModifierID)
    local player = Players[playerID]
    if player ~= nil then
        player:AttachModifierByID(sModifierID)
    end
end)

GameEvents.CityAttachModifierByID.Add(function(playerID,   cityID, sModifierID)
    local city = CityManager.GetCity(playerID, cityID)
    if city ~= nil then
        --print(sModifierID)
        city:AttachModifierByID(sModifierID)
    end
end)



GameEvents.SetPlotImprovement.Add(function(plotID, iImprovement, iPlayer)
    local plot = Map.GetPlotByIndex(plotID);
    iPlayer = iPlayer or -1;
    ImprovementBuilder.SetImprovementType(plot, iImprovement, iPlayer);
end)

GameEvents.ReduceBuildCharge.Add(function(playerID, unitID)
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    if pUnit ~= nil then
        local ReduceProperty = pUnit:GetProperty('PROP_REDUCE_BUILD_CHARGE') or 0;
        ReduceProperty = ReduceProperty + 1;
        GameEvents.SetAbilityCount.Call(playerID, unitID, 'ABILITY_LOSE_'..ReduceProperty..'_BUILD_CHARGES', 1);
        pUnit:SetProperty('PROP_REDUCE_BUILD_CHARGE', ReduceProperty);
    end
end)

GameEvents.AddBuildCharge.Add(function(playerID, unitID)
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    if pUnit ~= nil then
        local AddProperty = pUnit:GetProperty('PROP_ADD_BUILD_CHARGE') or 0;
        AddProperty = AddProperty + 1;
        GameEvents.SetAbilityCount.Call(playerID, unitID, 'ABILITY_ADD_'..AddProperty..'_BUILD_CHARGES', 1);
        pUnit:SetProperty('PROP_ADD_BUILD_CHARGE', AddProperty);
    end
end)

GameEvents.GetRandNum.Add(function(iMax, sSeed)
    local iRand = Game.GetRandNum(iMax, sSeed);
    Game.SetProperty(sSeed, iRand);
end)

GameEvents.SetPlotOwner.Add(function(playerID, plotID, cityID)
    local pPlayer = Players[playerID];
    if pPlayer == nil then return; end
    local pPlot = Map.GetPlotByIndex(plotID);
    if pPlot == nil then return; end
    if cityID == -1 then
        WorldBuilder.CityManager():SetPlotOwner(pPlot, false);
    else
        local pCity = pPlayer:GetCities():FindID(cityID);
        if pCity == nil then return; end
        WorldBuilder.CityManager():SetPlotOwner(pPlot, pCity);
    end
end)

GameEvents.BuildResource.Add(function(sResource, plotID)
    local pPlot = Map.GetPlotByIndex(plotID);
    ResourceBuilder.SetResourceType(pPlot, GameInfo.Resources[sResource].Index, 1);
end)


GameEvents.ChangePopulation.Add( function(playerID, iCity,  pNewPopulation)
    local pPlayer = Players[playerID]   
    local pCity = pPlayer:GetCities():FindID(iCity) 
    if pCity ~= nil then
        pCity:ChangePopulation(pNewPopulation);
    end
end)

GameEvents.OP_ChangePopulation.Add( function(playerID, params)
    local pPlayer = Players[params.playerID]   
    local pCity = pPlayer:GetCities():FindID(params.iCity) 
    if pCity ~= nil then
        pCity:ChangePopulation(params.pNewPopulation);
    end
end)


Utils.RequestAddWorldView = function (text, iX, iY)
    Game.AddWorldViewText(0,text,iX,iY);
end

GameEvents.RequestAddWorldView.Add(function(text, iX, iY)
    Game.AddWorldViewText(0,text,iX,iY);
end)

--杀死伟人,传入单位所有者id,单位id
GameEvents.KillUint.Add(function(pUnitOwnerID,pUnitID)
    if pUnitOwnerID and pUnitID then
        local pUnit = UnitManager.GetUnit(pUnitOwnerID, pUnitID)
        UnitManager.Kill(pUnit)
    end
end)

GameEvents.SetBuildingPillaged.Add(function(PlayerID, CityID, BuildingID, bIsPillaged)
    local pCity = CityManager.GetCity(playerID, cityID)
    if pCity ~= nil then
       pCity:GetBuildings():SetPillaged(BuildingID, bIsPillaged);
   end
end)

GameEvents.DestroyWall.Add(function(PlayerID, CityID)
    local pCity = CityManager.GetCity(playerID, cityID)
    if pCity ~= nil then
        local pCityDistricts = pCity:GetDistricts();
        if (pCityDistricts ~= nil) then
            local pCityCenter = pCityDistricts:GetDistrictAtLocation(pCity:GetX(), pCity:GetY());
            if (pCityCenter ~= nil) then
                pCityCenter:SetDamage(DefenseTypes.DISTRICT_GARRISON, 50);
                pCityCenter:SetDamage(DefenseTypes.DISTRICT_OUTER, 100);
            end
        end
    end
end)




Utils.PlayerAttachModifierByID = function(playerID, sModifierID)
    local player = Players[playerID]
    if player ~= nil then
        player:AttachModifierByID(sModifierID)
    end
end

Utils.CityAttachModifierByID = function(playerID,   cityID, sModifierID)
    local city = CityManager.GetCity(playerID, cityID)

    if city ~= nil then
        --print(sModifierID)
        city:AttachModifierByID(sModifierID)
    end
end

Utils.ChangePopulation = function(playerID, iCity,  pNewPopulation)
    local pPlayer = Players[playerID]   
    local pCity = pPlayer:GetCities():FindID(iCity) 
    if pCity ~= nil then
        pCity:ChangePopulation(pNewPopulation);
    end
end

Utils.GetUnitType = function(unitID,    playerID)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    --print(pUnit)
    --print(pUnit:GetID())
    return pUnit:GetType()
end

Utils.GetBuildingLocation = function (playerId, cityId, buildingId)
    local city = CityManager.GetCity(playerId, cityId);
    if city ~= nil then
        return city:GetBuildings():GetBuildingLocation(buildingId);
    end
end

Utils.PlayerHasWonder = function(playerId, wonderId)
    local player = Players[playerId];
    if player == nil then return false; end
    for _, city in player:GetCities():Members() do
        if city:GetBuildings():HasBuilding(wonderId) then
            return true;
        end
    end
    return false;
end


Utils.PlayerHasTrait = function(playerID, sTrait)
    local playerConfig = PlayerConfigurations[playerID];
    local sCiv = playerConfig:GetCivilizationTypeName();
    for tRow in GameInfo.CivilizationTraits() do
        if (tRow.CivilizationType == sCiv and tRow.TraitType == sTrait) then
            return true;
        end
    end
    local sLeader = playerConfig:GetLeaderTypeName();
    for tRow in GameInfo.LeaderTraits() do
        if (tRow.LeaderType == sLeader and tRow.TraitType == sTrait) then
            return true;
        end
    end
    return false;
end

Utils.GameHasTrait = function(sTrait)
    for i, player in ipairs(Players) do
        if Utils.PlayerHasTrait(i, sTrait) then 
            return true;
        end
    end
    return false;
end

Utils.GetEnlightmentModifier = function(sGreatpersonType)
    local modifier = 1;
    local iEra = Game.GetEras():GetCurrentEra();


    if iEra ~= nil then 
        eraName = GameInfo.Eras[iEra].EraType;
    else
        eraName = 'ERA_ANCIENT';
    end

    if eraName == 'ERA_ANCIENT' then
        modifier = 1;
    elseif eraName == 'ERA_CLASSICAL' then
        modifier = modifier * 2;
    end
    return modifier;
end


function RecordUnitMove(playerID,unitID,x,y)
    local pUnit :object = Players[playerID]:GetUnits():FindID(unitID)
    --print(" unit type"..UnitManager.GetTypeName(pUnit))
    local pPlayer = Players[playerID]
    local plotID = Map.GetPlotIndex(x,y)
    pPlayer:SetProperty('UNIT_'..unitID..'_POSITION',   plotID)
end


Events.UnitMoveComplete.Add(RecordUnitMove)


-- pPlayer = Players[0]
-- pCity= pPlayer:GetCities():GetCapitalCity()
-- pCity:GetBuildQueue():AddProgress(10)


Utils.PlayerHasCivic = function(playerID, civicType)
    local pPlayer = Players[playerID];
    local pPlayerCulture = pPlayer:GetCulture();
    local iCivic = GameInfo.Civics[civicType].Index;
    return pPlayerCulture:HasCivic(iCivic);
end


function CostUnity(playerID, iCost)
    local pPlayer = Players[playerID];
    local unityBalance = pPlayer:GetProperty('PROP_UNITY_BALANCE') or 0;
    local unityThreshold = pPlayer:GetProperty('PROP_UNITY_THRESHOLD') or 200;
    local hidedGovernors = pPlayer:GetProperty('PROP_HIDE_GOVERNOR') or 0;
    if iCost <= unityBalance then
        pPlayer:SetProperty('PROP_UNITY_BALANCE', unityBalance - iCost);
    else
        iCostGovernor = math.ceil((iCost - unityBalance) / unityThreshold);
        iCostUnity = iCost - iCostGovernor * unityThreshold;
        pPlayer:SetProperty('PROP_UNITY_BALANCE', unityBalance - iCostUnity);
        pPlayer:SetProperty('PROP_HIDE_GOVERNOR', hidedGovernors + iCostGovernor);
    end
end

GameEvents.CostUnity.Add(CostUnity);
Utils.CostUnity = CostUnity;

Utils.FindClosestCity = function(player, iStartX, iStartY)

    local pCity = nullptr;
    local iShortestDistance = 10000;
	local pPlayer = Players[player];
   
	local pPlayerCities:table = pPlayer:GetCities();
	for i, pLoopCity in pPlayerCities:Members() do
		local iDistance = Map.GetPlotDistance(iStartX, iStartY, pLoopCity:GetX(), pLoopCity:GetY());
		if (iDistance < iShortestDistance) then
			pCity = pLoopCity;
			iShortestDistance = iDistance;
		end
	end

	if (pCity == nullptr) then
		print ("No closest city found of player " .. tostring(player) .. " from " .. tostring(iStartX) .. ", " .. tostring(iStartX));
	end
   
    return pCity;
end

Utils.GetPlayerCitiesSortedByDistance = function(player, iStartX, iStartY)
    local pPlayer = Players[player]
    local pPlayerCities = pPlayer:GetCities()
    local cityDistances = {}

    -- 遍历玩家城市，计算每个城市到起始位置的距离
    for i, pLoopCity in pPlayerCities:Members() do
        local iDistance = Map.GetPlotDistance(iStartX, iStartY, pLoopCity:GetX(), pLoopCity:GetY())
        table.insert(cityDistances, {city = pLoopCity, distance = iDistance})
    end

    -- 按照距离进行排序
    table.sort(cityDistances, function(a, b) return a.distance < b.distance end)

    -- 提取排序后的城市列表
    local sortedCities = {}
    for _, cityData in ipairs(cityDistances) do
        table.insert(sortedCities, cityData.city)
    end

    return sortedCities
end


