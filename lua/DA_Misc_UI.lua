GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;

local AQUEDUCT_INDEX = GameInfo.Districts["DISTRICT_AQUEDUCT"].Index;

local ZHENG_GUO_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_ZHENG_GUO"].Index;
local WIDOW_QING_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_WIDOW_QING"].Index;
local SERGIUS_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_SERGIUS"].Index;
local RAMSES_II_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_RAMSES_II"].Index;



-- 获得伟人激活所在单元格
function DAGreatPersonGetActivationPlots(playerID, greatPersonIndividualID, unitID)
    local player = Players[playerID];
    local unit = UnitManager.GetUnit(playerID, unitID)
    local activationPlots = {};
    --    郑国因为水渠改成建造者造，所以不再在建造中的水渠激活
    -- if greatPersonIndividualID == ZHENG_GUO_INDEX then
    --     for _, district in player:GetDistricts():Members() do
    --         if (district ~= nil and district:GetType() == AQUEDUCT_INDEX) then
    --             local isValid = false;
    --             if district:IsComplete() then
    --                 isValid = true;
    --             else
    --                 local districtCity = district:GetCity();
    --                 if districtCity ~= nil then
    --                     local buildQueue = districtCity:GetBuildQueue();
    --                     local currentlyBuilding = buildQueue:GetCurrentProductionTypeHash(); -- CurrentlyBuilding();
    --                     local districtType = GameInfo.Districts[district:GetType()].DistrictType;
    --                     -- local districtHash = GameInfo.Types[district:GetType()].Hash;
    --                     local currentlyBuildingType = GameInfo.Types[currentlyBuilding].Type
    --                     -- print('DA_DEBUG aaa ', GameInfo.Types[currentlyBuilding].Type);
    --                     -- print('DA_DEBUG', currentlyBuilding, currentlyBuildingType, districtType)
    --                     if districtType == currentlyBuildingType then
    --                         isValid = true;
    --                     end
    --                 end
    --             end
    --             if isValid then
    --                 local districtPlot:table = Map.GetPlot(district:GetX(), district:GetY());
    --                 -- print('DA_DEBUG plot', district:GetX(), district:GetY(), districtPlot)
    --                 if districtPlot ~= nil then
    --                     table.insert(activationPlots, districtPlot:GetIndex());
    --                 end
    --             end
    --         end
    --     end
    --     return activationPlots;
    if greatPersonIndividualID == WIDOW_QING_INDEX then
        local pCity = Cities.GetPlotPurchaseCity(Map.GetPlotByIndex(unit:GetPlotId()));
        if pCity == nil then return activationPlots; end
        if pCity:GetOwner() ~= playerID then
            return activationPlots;
        end
        local plots = Map.GetCityPlots():GetPurchasedPlots(pCity);
        for _, plotID in pairs(plots) do
            if Utils.CanBuildResource(plotID, 'RESOURCE_MERCURY', playerID) then
                table.insert(activationPlots, plotID);
            end
        end
        return activationPlots;
    elseif greatPersonIndividualID == SERGIUS_INDEX then
        local pCity = Cities.GetPlotPurchaseCity(Map.GetPlotByIndex(unit:GetPlotId()));
        if pCity == nil then return activationPlots; end
        if pCity:GetOwner() ~= playerID then
            return activationPlots;
        end
        local plots = Map.GetCityPlots():GetPurchasedPlots(pCity);
        for _, plotID in pairs(plots) do
            if Utils.CanBuildResource(plotID, 'RESOURCE_PEARLS', playerID) then
                table.insert(activationPlots, plotID);
            end
        end
        return activationPlots;
    end
    return nil;
end

Utils.DAGreatPersonGetActivationPlots = DAGreatPersonGetActivationPlots

--巴寡妇清
Utils.GreatPersonHandleActivation = (function(unitOwner, unitID, greatPersonIndividualID)
    if greatPersonIndividualID == WIDOW_QING_INDEX then
        local owner = Players[unitOwner];
        local unit = UnitManager.GetUnit(unitOwner, unitID);
        local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
        GameEvents.PlayerAttachModifierByID.Call(unitOwner, 'GREATPERSON_WIDOW_QING_WONDER_PRODUCTION');
        local pCity = Cities.GetPlotPurchaseCity(unit:GetPlotId());
        if Utils.IsPlotResourceUnrevealed(unitPlot:GetIndex(), unitOwner) then
            local sStrategicResource = GameInfo.Resources[unitPlot:GetResourceType()].ResourceType;
            GameEvents.CityAttachModifierByID.Call(unitOwner, pCity:GetID(), 'GIFT_'..sStrategicResource..'_AFTER_UNLOCK');
        end
        GameEvents.BuildResource.Call('RESOURCE_MERCURY', unitPlot:GetIndex());
        GameEvents.SetPlotOwner.Call(unitOwner, unitPlot:GetIndex(), -1);
        local tParameters = {};
        tParameters[CityCommandTypes.PARAM_PLOT_PURCHASE] = UI.GetInterfaceModeParameter(CityCommandTypes.PARAM_PLOT_PURCHASE);
        tParameters[CityCommandTypes.PARAM_X] = unit:GetX();
        tParameters[CityCommandTypes.PARAM_Y] = unit:GetY();
        if CityManager.CanStartCommand(pCity, CityCommandTypes.PURCHASE, tParameters) then
            local pCityGold = pCity:GetGold();
            local iCost = pCityGold:GetPlotPurchaseCost(unitPlot:GetIndex());
            -- local iGold = owner:GetTreasury():GetGoldBalance();
            GameEvents.RequestChangeGoldBalance.Call(unitOwner, iCost);
            CityManager.RequestCommand(pCity, CityCommandTypes.PURCHASE, tParameters);
            -- UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            --     OnStart = 'RecoverPlantPlotOwner',
            --     playerID = unitOwner,
            --     amount = iGold
            --     })          
            -- GameEvents.SetGoldBalance.Call(unitOwner, iGold);
        else
            GameEvents.SetPlotOwner.Call(unitOwner, unitPlot:GetIndex(), pCity:GetID());
        end
    elseif greatPersonIndividualID == SERGIUS_INDEX then
        local owner = Players[unitOwner];
        local unit = UnitManager.GetUnit(unitOwner, unitID);
        local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
        GameEvents.PlayerAttachModifierByID.Call(unitOwner, 'GREATPERSON_SERGIUS_TRADE_ROUTE_CAPACITY');
        local pCity = Cities.GetPlotPurchaseCity(unit:GetPlotId());
        if Utils.IsPlotResourceUnrevealed(unitPlot:GetIndex(), unitOwner) then
            local sStrategicResource = GameInfo.Resources[unitPlot:GetResourceType()].ResourceType;
            GameEvents.CityAttachModifierByID.Call(unitOwner, pCity:GetID(), 'GIFT_'..sStrategicResource..'_AFTER_UNLOCK');
        end
        GameEvents.BuildResource.Call('RESOURCE_PEARLS', unitPlot:GetIndex());
        GameEvents.SetPlotOwner.Call(unitOwner, unitPlot:GetIndex(), -1);
        local tParameters = {};
        tParameters[CityCommandTypes.PARAM_PLOT_PURCHASE] = UI.GetInterfaceModeParameter(CityCommandTypes.PARAM_PLOT_PURCHASE);
        tParameters[CityCommandTypes.PARAM_X] = unit:GetX();
        tParameters[CityCommandTypes.PARAM_Y] = unit:GetY();
        if CityManager.CanStartCommand(pCity, CityCommandTypes.PURCHASE, tParameters) then
            local pCityGold = pCity:GetGold();
            local iCost = pCityGold:GetPlotPurchaseCost(unitPlot:GetIndex());
            -- local iGold = owner:GetTreasury():GetGoldBalance();
            GameEvents.RequestChangeGoldBalance.Call(unitOwner, iCost);
            CityManager.RequestCommand(pCity, CityCommandTypes.PURCHASE, tParameters);
            -- UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            --     OnStart = 'RecoverPlantPlotOwner',
            --     playerID = unitOwner,
            --     amount = iGold
            --     })          
            -- GameEvents.SetGoldBalance.Call(unitOwner, iGold);
        else
            GameEvents.SetPlotOwner.Call(unitOwner, unitPlot:GetIndex(), pCity:GetID());
        end
    end
end)

--拉美西斯
function RamsesIIFaithBuyWonder(unitOwner, unitID,greatPersonClassID, greatPersonIndividualID)
   if greatPersonIndividualID ~= RAMSES_II_INDEX then
      return;
   end
   
   local owner = Players[unitOwner];

   local unit = UnitManager.GetUnit(unitOwner, unitID);
   local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
   --local districtAtPlot = CityManager.GetDistrictAt(unitPlot);
   local city = Cities.GetPlotPurchaseCity(unitPlot);
   --print(city)
   local current = Utils.GetCurrentlyBuilding(unitOwner, city:GetID());
   print(current)
   if not current then
      return;
   end
   local buildingInfo = GameInfo.Buildings[current];
   if not buildingInfo.IsWonder then
      return;
   end
   local cost = buildingInfo.Cost;
   local iProductionProgress = city:GetBuildQueue():GetBuildingProgress( buildingInfo.Index );
   local productionNeeded = cost - iProductionProgress;
   local faithBalance = owner:GetReligion():GetFaithBalance();
   if(faithBalance > productionNeeded) then
      --Utils.RequestAddWorldView(0, "+" .. productionNeeded .. " [ICON_PRODUCTION]", unit:GetX(), unit:GetY());
      GameEvents.RequestChangeFaithBalance.Call(unitOwner,  -productionNeeded);
      GameEvents.RequestFinishProgress.Call(unitOwner, city:GetID());
   else
     -- Utils.RequestAddWorldView(0, "+" .. faithBalance .. " [ICON_PRODUCTION][NEWLINE]".."-" .. faithBalance .. " [ICON_FAITH]", unit:GetX(), unit:GetY());
      GameEvents.RequestChangeFaithBalance.Call(unitOwner,  -faithBalance);
      GameEvents.RequestAddProgress.Call(unitOwner, city:GetID(), faithBalance);
   end
   GreatEngineerSpeedUpNoPoints(unitOwner, unitID,greatPersonClassID, greatPersonIndividualID)
   print('LA II ACTIVATED')
end

Events.UnitGreatPersonActivated.Add( RamsesIIFaithBuyWonder );



function pass()
    print('pass')
end


--伯里克利   伟人在城邦旁
---希腊，伯利克里，提洛同盟
local table_great_person_and_modifier = { 
    ["GREAT_PERSON_CLASS_GENERAL"] = "LEADER_MINOR_CIV_MILITARISTIC",
    ["GREAT_PERSON_CLASS_ENGINEER"] = "LEADER_MINOR_CIV_INDUSTRIAL",
    ["GREAT_PERSON_CLASS_MERCHANT"] = "LEADER_MINOR_CIV_TRADE", 
    ["GREAT_PERSON_CLASS_PROPHET"] = "LEADER_MINOR_CIV_RELIGIOUS", 
    ["GREAT_PERSON_CLASS_SCIENTIST"] = "LEADER_MINOR_CIV_SCIENTIFIC", 
    ["GREAT_PERSON_CLASS_WRITER"] = "LEADER_MINOR_CIV_CULTURAL", 
    ["GREAT_PERSON_CLASS_MUSICIAN"] = "LEADER_MINOR_CIV_CULTURAL", 
    ["GREAT_PERSON_CLASS_ARTIST"] = "LEADER_MINOR_CIV_CULTURAL",  
}
--local HEX_COLORING_MOVEMENT = UILens.CreateLensLayerHash("Hex_Coloring_Movement");
--local HEX_COLORING_ATTACK = UILens.CreateLensLayerHash("Hex_Coloring_Attack");
--local CanSelectPlot = {}
--local IsSameTypePlot = {}
GameEvents.DA_GreatPersonGetEnvoys.Add(function(playerID : number, unitID : number)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    --print(iX,iY)
    local pPlot = Map.GetPlot(iX,iY)
    local pPlotOwnerID = pPlot:GetOwner()
    local pPlotOwnerTypeName = PlayerConfigurations[pPlotOwnerID]:GetLeaderTypeName()
    local pPlotOwnerTypeNameInfo = GameInfo.Leaders[pPlotOwnerTypeName]
    local greatPersonID = pUnit:GetGreatPerson():GetIndividual()
    local greatPersonDetails = GameInfo.GreatPersonIndividuals[greatPersonID]
    local greatPersonType = greatPersonDetails.GreatPersonClassType
    local SendEnvoyNumber = 2
    for k,v in pairs(table_great_person_and_modifier) do
        if pPlotOwnerTypeNameInfo.InheritFrom == v and greatPersonType == k then
            SendEnvoyNumber = SendEnvoyNumber + 1
        end
    end
    
    for i=1,SendEnvoyNumber,1 do
        GameEvents.SendEnvoytoCityState.Call(playerID,pPlotOwnerID)
    end

    GameEvents.KillUint.Call(playerID,unitID)
    --伟人胜利计数
    GameEvents.DA_UnitGreatPersonActivated.Add(playerID,unitID)
    local pPlotOwnerName = PlayerConfigurations[pPlotOwnerID]:GetLeaderName()
    local message = Locale.Lookup('LOC_GIVE_TWO_FREETOKEN',pPlotOwnerName,SendEnvoyNumber)
    GameEvents.RequestAddWorldView.Call(message, iX, iY)
    --[[
    for direction = 0, 5, 1 do
        local plot = Map.GetAdjacentPlot(iX, iY, direction)
        print(plot:GetX(),plot:GetY(),direction)
        local pPlotOwnerID = plot:GetOwner()
        if pPlotOwnerID ~= -1 then
            local plotOwner = Players[pPlotOwnerID]
            local pPlotOwnerTypeName = PlayerConfigurations[pPlotOwnerID]:GetLeaderTypeName()
            local pPlotOwnerTypeNameInfo = GameInfo.Leaders[pPlotOwnerTypeName]
            local greatPersonID = pUnit:GetGreatPerson():GetIndividual()
            local greatPersonDetails = GameInfo.GreatPersonIndividuals[greatPersonID]
            local greatPersonType = greatPersonDetails.GreatPersonClassType
            for k,v in pairs(table_great_person_and_modifier) do
                if pPlotOwnerTypeNameInfo.InheritFrom == v then
                    local plotindex = plot:GetIndex()
                    table.insert(CanSelectPlot, plotindex)
                    if k == greatPersonType then
                        table.insert(IsSameTypePlot, plotindex)
                    end
                end
            end
        end
    end
    if #CanSelectPlot > 0 then
        UI.SetInterfaceMode(InterfaceModeTypes.WB_SELECT_PLOT)
        UILens.SetLayerHexesArea(HEX_COLORING_MOVEMENT, playerID, CanSelectPlot)
        UILens.ToggleLayerOn(HEX_COLORING_MOVEMENT)
    end
    ]]--
end)
--[[
function isInArray(table, value)
    for _, v in ipairs(table) do
        if value == v then
            return true
        end
    end
    return false
end

function DA_OnPlotSelected(plotID, edge, lbutton, rbutton)
    --print(plotID, edge, lbutton, rbutton)
    --for i=1,  #CanSelectPlot do
        --print("CanSelectPlot",i,CanSelectPlot[i])
    --end
    --print("被选中",plotID)
    local pUnit = UI.GetHeadSelectedUnit()
    if not pUnit:GetGreatPerson():IsGreatPerson() then
        return
    end
    if not lbutton then
        if rbutton then
            UI.SetInterfaceMode( InterfaceModeTypes.SELECTION )
            UILens.ClearLayerHexes(HEX_COLORING_MOVEMENT)
            UILens.ToggleLayerOff(HEX_COLORING_MOVEMENT)
        else
            local iX = pUnit:GetX()
            -- local iY = pUnit:GetY()
            if isInArray(CanSelectPlot,plotID) then
                local pUnitID = pUnit:GetID()
                local pUnitOwnerID = pUnit:GetOwner()
                local pPlot = Map.GetPlotByIndex(plotID)
                local pPlotOwnerID = pPlot:GetOwner()
                local SendEnvoyNumber = 2
                if isInArray(IsSameTypePlot,plotID) then
                    SendEnvoyNumber = SendEnvoyNumber + 1
                end
                for i=1,SendEnvoyNumber,1 do
                    GameEvents.SendEnvoytoCityState.Call(pUnitOwnerID,pPlotOwnerID)
                end
                GameEvents.KillUint.Call(pUnitOwnerID,pUnitID)
                
                local plotOwner = Players[pPlotOwnerID]
                local pPlotOwnerName = PlayerConfigurations[pPlotOwnerID]:GetLeaderName()
                local message = Locale.Lookup('LOC_GIVE_TWO_FREETOKEN',pPlotOwnerName,SendEnvoyNumber)
                GameEvents.RequestAddWorldView.Call(message, iX, iY)
            else    
                local message = Locale.Lookup('LOC_CLICK_INVALID_PLOT')
                GameEvents.RequestAddWorldView.Call(message, iX, iY)
            end
            UI.SetInterfaceMode(InterfaceModeTypes.SELECTION)
            UILens.ClearLayerHexes(HEX_COLORING_MOVEMENT)
            UILens.ToggleLayerOff(HEX_COLORING_MOVEMENT)
        end
        CanSelectPlot = {}
        IsSameTypePlot = {}
    end
end
LuaEvents.WorldInput_WBSelectPlot.Add(DA_OnPlotSelected)
]]--

--牺牲开拓者，换区域位，单元格
GameEvents.DA_SettlerGetPlot.Add(function(playerID : number, unitID : number)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    local pCity = Cities.GetCityInPlot(iX, iY)
    if pCity == nil then
        print("DA_SettlerGetPlot:pCity:nil")
        return
    end
    GameEvents.CityAttachModifierByID.Call(playerID, pCity:GetID(), 'GREATPERSON_EXTRA_DISTRICT_CAPACITY')
    GameEvents.CityAttachModifierByID.Call(playerID, pCity:GetID(), 'FRONTIER_GRANT_EXPANSION')
    GameEvents.ChangePopulation.Call(playerID, pCity:GetID(), 1)
    --local NextPlotID = pCity:GetCulture():GetNextPlot()
    --GameEvents.ChangePlotOwner.Call(playerID,NextPlotID)
    
    GameEvents.KillUint.Call(playerID,unitID)
end)


-- function SpyDestroyWall(playerID, missionID)
--     local pPlayer:table = Players[playerID];

--     local pPlayerDiplomacy:table = pPlayer:GetDiplomacy();
--     if pPlayerDiplomacy then
--         local mission = pPlayerDiplomacy:GetMission(playerID, missionID);
--         local m_missionHistory = mission;
--         if m_missionHistory then
--             -- if mission.InitialResult == EspionageResultTypes.SUCCESS_UNDETECTED or 
--             --    mission.InitialResult == EspionageResultTypes.SUCCESS_MUST_ESCAPE then
--                 local kOpDef:table = GameInfo.UnitOperations[m_missionHistory.Operation];
--                 if kOpDef ~= nil then
--                     if kOpDef.Hash ~= UnitOperationTypes.SPY_FOMENT_UNREST then 
--                         print('wrong operation')
--                         --return;
--                     end 
--                     -- for k, v in pairs(mission) do
--                     --     print(k)
--                     --     print(v)
--                     -- end
--                     local pCity = Cities.GetPlotPurchaseCity(mission.PlotIndex);

--                     GameEvents.DestroyWall.Call(pCity:GetOwner(), pCity:GetID())
--                     --SetBuildingPillaged
--                     --GameEvents.DestroyWall.Call()
--                 end
--             -- end
--         end
--     end
-- end


-- Events.SpyMissionCompleted.Add(SpyDestroyWall)


--DA_Boost
g_TERRAIN_TYPE_COAST = GameInfo.Terrains["TERRAIN_COAST"].Index
function IsAdjacentToShallowWater(iX, iY)
    local adjacentPlot; 

    for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
        adjacentPlot = Map.GetAdjacentPlot(iX, iY, direction);
        if adjacentPlot ~= nil and adjacentPlot:GetTerrainType() == g_TERRAIN_TYPE_COAST then
            return true
        end
    end
    return false;
end
Utils.DA_Boost_Tech_GetImprovements = function(playerID,DA_Boost_Tech)
    local pPlayer = Players[playerID]
    local pPlayerImprovements = pPlayer:GetImprovements()
    if (pPlayerImprovements == nil) then
        return DA_Boost_Tech
    end
    local pPlayerImprovementsPlots:table = pPlayerImprovements:GetImprovementPlots()
    if (pPlayerImprovementsPlots == nil) then
        return DA_Boost_Tech
    end
    
    local tPlayerImprovements = {};
    local tPlayerImprovementsCount = {};

    for k,plotID in pairs(pPlayerImprovementsPlots) do
        local pPlot = Map.GetPlotByIndex(plotID)
        local ImprovementID = pPlot:GetImprovementType()
        local ImprovementType = GameInfo.Improvements[ImprovementID].ImprovementType
        tPlayerImprovements[plotID] = ImprovementID;
        tPlayerImprovementsCount[ImprovementID] = tPlayerImprovementsCount[ImprovementID] or 0;
        tPlayerImprovementsCount[ImprovementID] = tPlayerImprovementsCount[ImprovementID] + 1;
        --航海术
        if IsAdjacentToShallowWater(pPlot:GetX(),pPlot:GetY()) then
            DA_Boost_Tech["TECH_SAILING"] = DA_Boost_Tech["TECH_SAILING"] + 1
        end
        
        --灌溉
        if ImprovementType == "IMPROVEMENT_FARM" or ImprovementType == "IMPROVEMENT_PLANTATION" then
            DA_Boost_Tech["TECH_IRRIGATION"] = DA_Boost_Tech["TECH_IRRIGATION"] + 1
        --箭术
        elseif ImprovementType == "IMPROVEMENT_CAMP" or ImprovementType == "IMPROVEMENT_PASTURE" then
            DA_Boost_Tech["TECH_ARCHERY"] = DA_Boost_Tech["TECH_ARCHERY"] + 1
        --铸铜术
        elseif ImprovementType == "IMPROVEMENT_MINE" then
            DA_Boost_Tech["TECH_BRONZE_WORKING"] = DA_Boost_Tech["TECH_BRONZE_WORKING"] + 1
        --砌砖
        elseif ImprovementType == "IMPROVEMENT_QUARRY" then
            DA_Boost_Tech["TECH_MASONRY"] = DA_Boost_Tech["TECH_MASONRY"] + 1
        end
    end
    return DA_Boost_Tech, tPlayerImprovements, tPlayerImprovementsCount
end

Utils.DA_Boost_Tech_GetDistricts = function(playerID,DA_Boost_Tech)
    local pPlayerDistricts = Players[playerID]:GetDistricts();
    if pPlayerDistricts == nil then
        return DA_Boost_Tech
    end
    for k, district in pPlayerDistricts:Members() do
        --航海术
        if district:IsComplete() then
            if IsAdjacentToShallowWater(district:GetX(),district:GetY()) then
                DA_Boost_Tech["TECH_SAILING"] = DA_Boost_Tech["TECH_SAILING"] + 1
            end
        end
    end
    return DA_Boost_Tech
end


--通往城市的内商计数 用于马格努斯的仓储管理
function TradeRouteChangedWarehouseManagement(playerID, iOriPlayerID, iOriCityID, iTarPlayerID, iTarCityID)
    if playerID ~= iOriPlayerID or playerID ~= iTarPlayerID then
        return
    end
    local pTarCity = CityManager.GetCity(iTarPlayerID, iTarCityID);
    local pTrade = pTarCity:GetTrade();
    local iDomesticIncoming = 0;
    for _,route in ipairs(pTrade:GetIncomingRoutes()) do
        if route.OriginCityPlayer == route.DestinationCityPlayer then
            iDomesticIncoming = iDomesticIncoming + 1;
        end
    end
    local iX, iY = pTarCity:GetX(), pTarCity:GetY();
    local plotID = Map.GetPlot(iX, iY):GetIndex();
    GameEvents.SetPlotProperty.Call(plotID, 'PROP_DOMESTIC_INCOMING', iDomesticIncoming);
end
        
Events.TradeRouteActivityChanged.Add(   TradeRouteChangedWarehouseManagement   );



