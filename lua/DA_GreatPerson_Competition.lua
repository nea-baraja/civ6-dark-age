include("SupportFunctions")

GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils

local RAMSES_II_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_RAMSES_II"].Index;

--判定是否是古典  古典启明效果翻倍
function IsClassical()
    local eraName = GameInfo.Eras[ Game.GetEras():GetCurrentEra() ].EraType;
    if eraName == 'ERA_CLASSICAL' then
        return true;
    else
        return false;
    end
end

--大工加速奇观后不给点数
function GreatEngineerSpeedUpNoPoints(unitOwner, unitID,greatPersonClassID, greatPersonIndividualID)
    local owner = Players[unitOwner];
 

    local unit = UnitManager.GetUnit(unitOwner, unitID);
    local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
    local pCity = Cities.GetPlotPurchaseCity(unitPlot);
    local sCurrent = Utils.GetCurrentlyBuilding(playerID, pCity:GetID());
    local iWonder = unitPlot:GetWonderType();
    if iWonder == nil or iWonder == -1 then return; end
    local sWonder = GameInfo.Buildings[iWonder].BuildingType;
    if not sCurrent or sCurrent ~= sWonder then return; end
    local PROP_NO_WONDER_BONUS = 'NO_BONUS'..sCurrent;
    GameEvents.SetPlayerProperty.Call(unitOwner,  PROP_NO_WONDER_BONUS ,  1);


end

Events.UnitGreatPersonActivated.Add( GreatEngineerSpeedUpNoPoints );


local GreatPersonNotificationHash = DB.MakeHash("NOTIFICATION_COMPETITION_GREATPERSON");
-- Great Engineer from wonders
function WonderToGreatEngineerPoints(iX, iY, buildingID, playerID, cityID, iPercentComplete, iUnknown)
    --print(iX, iY, buildingID, playerID, cityID, iPercentComplete, iUnknown)
    local Plot = Map.GetPlot(iX, iY)
    local gameSpeed = GameConfiguration.GetGameSpeedType()
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[gameSpeed].CostMultiplier * 0.01
    local player = Players[playerID]
    local pCity = CityManager.GetCity(playerID, cityID)
    local building = GameInfo.Buildings[buildingID]
    local sWonder = building.BuildingType;
    local PROP_NO_WONDER_BONUS = 'NO_BONUS'..sWonder;

    local iUnlockEra = 0;
    local sTech = building.PrereqTech;
    if sTech ~= nil then 
        local sUnlockEra = GameInfo.Technologies[sTech].EraType;
        local iUnlockEra = GameInfo.Eras[sUnlockEra].ChronologyIndex - 1;
    end
    local sCiv = building.PrereqCivic;
    if sCiv ~= nil then
        local sUnlockEra = GameInfo.Civics[sCiv].EraType;
        local iUnlockEra = GameInfo.Eras[sUnlockEra].ChronologyIndex - 1;
    end
    local iCurrentEra = Game.GetEras():GetCurrentEra();
    --过时的奇观不给伟人点
    if iCurrentEra > iUnlockEra then
        return;
    end


    if player:GetProperty(PROP_NO_WONDER_BONUS) == 1 then 
        --print(building.BuildingType..'was sped up. No bonus for GreatEngineerPoints.')
        return;
    end
    -- print(building.BuildingType)
    if player ~= nil and pCity ~= nil and building ~= nil then
        local greatEngID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_ENGINEER'].Index
        local amount = building.Cost * 15 * 0.01 * iSpeedCostMultiplier;
        if IsClassical() then
            amount = amount * 2;
        end
        amount = math.floor(amount);
        GameEvents.AddGreatPeoplePoints.Call(playerID, greatEngID, amount)
        local sCityName = Locale.Lookup(pCity:GetName())
        local sWonderName = Locale.Lookup(building.Name)
        local sTitle = Locale.Lookup('LOC_COMPETITION_GREAT_ENGINEER_TITLE')
        NotificationManager.SendNotification(playerID, GreatPersonNotificationHash, sTitle, Locale.Lookup('LOC_COMPETITION_WONDER_GREAT_ENGINEER_DESCRIPTION', sCityName, sWonderName, amount), pCity:GetX(), pCity:GetY())
    end
end

Events.WonderCompleted.Add(WonderToGreatEngineerPoints)


-- Great Engineer from first built buildings
-- function FirstBuildingToGreatEngineerPoints(playerID, cityID, buildingID)
--     local gameSpeed = GameConfiguration.GetGameSpeedType()
--     local iSpeedCostMultiplier = GameInfo.GameSpeeds[gameSpeed].CostMultiplier * 0.01
--     local player = Players[playerID]
--     local building = GameInfo.Buildings[buildingID]
--     local pCity = CityManager.GetCity(playerID, cityID)
--     local PROP_FIRST_BUILT = 'FIRST_'..building.BuildingType
--     print('is'..PROP_FIRST_BUILT..playerID)
--     local bFirstBuilt = player:GetProperty(PROP_FIRST_BUILT) or 0



--     local isWonder = building.IsWonder
--     --print('isWonder'..isWonder)
--     if player ~= nil and pCity ~= nil and bFirstBuilt ~= 1 and building ~= nil and (not isWonder)  and isValidBuilding(buildingID) then
--         local greatEngID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_ENGINEER'].Index
--         local amount = building.Cost * 10 * 0.01 * iSpeedCostMultiplier
--         if IsClassical() then
--             amount = amount * 2;
--         end
--         amount = math.floor(amount);
--         GameEvents.AddGreatPeoplePoints.Call(playerID, greatEngID, amount)
--         Utils.SetPlayerProperty(playerID, PROP_FIRST_BUILT, 1)
--         local sBuildingName = Locale.Lookup(building.Name)
--         local sTitle = Locale.Lookup('LOC_COMPETITION_GREAT_ENGINEER_TITLE')
--         NotificationManager.SendNotification(playerID, GreatPersonNotificationHash, sTitle, Locale.Lookup('LOC_COMPETITION_BUILDING_GREAT_ENGINEER_DESCRIPTION', sBuildingName, amount), pCity:GetX(), pCity:GetY())
--     end
-- end
-- GameEvents.BuildingConstructed.Add(FirstBuildingToGreatEngineerPoints)



function LeadTechnologyResearched(playerID, techID)
    local gameSpeed = GameConfiguration.GetGameSpeedType()
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[gameSpeed].CostMultiplier * 0.01
    local tech = GameInfo.Technologies[techID]
    local player = Players[playerID]

    local PROP_LEAD_RESEARCHED = 'LEAD_'..tech.TechnologyType
    local iFinished = Utils.GetGameProperty(PROP_LEAD_RESEARCHED) or 0

    local era = Game.GetEras():GetCurrentEra()
    -- local techEra = GameInfo.Eras[tech.EraType].ChronologyIndex
    -- if techEra > era + 2 then 
    --     --print(tech.TechnologyType..' finished too early. No bonus.')
    --     return 
    -- end

    local MajorPlayersNumber = 1
    for i,v in pairs(Players) do
        if(v:IsMajor()) then
            MajorPlayersNumber = i + 1
        else 
            break
        end
    end

    if iFinished < math.floor(MajorPlayersNumber / 2) and tech ~= nil and player ~= nil then 
        local greatSciID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_SCIENTIST'].Index
        local cost = tech.Cost
        local amount = cost * 5 * 0.01 * iSpeedCostMultiplier * (1 - 2 * iFinished / MajorPlayersNumber);
        if IsClassical() then
            amount = amount * 2;
        end
        amount = math.floor(amount);
        GameEvents.AddGreatPeoplePoints.Call(playerID, greatSciID, amount)
        Utils.SetGameProperty(PROP_LEAD_RESEARCHED, iFinished + 1)
        if amount > 0 then
            local sTechName = Locale.Lookup(tech.Name)
            local sTitle = Locale.Lookup('LOC_COMPETITION_GREAT_SCIENTIST_TITLE')
            local notificationData = {};
            notificationData[ParameterTypes.MESSAGE] = sTitle;
            notificationData[ParameterTypes.SUMMARY] = Locale.Lookup('LOC_COMPETITION_GREAT_SCIENTIST_DESCRIPTION', sTechName, amount)
            notificationData.AlwaysAutoActivate = true;
            notificationData.AlwaysUnique = true;        
            NotificationManager.SendNotification(playerID, GreatPersonNotificationHash, notificationData)
        end
    end
end

Events.ResearchCompleted.Add(LeadTechnologyResearched);


function OnUnitPromotionChanged(player, unitId)
    local pPlayer = Players[player];
    local pUnit = UnitManager.GetUnit(player, unitId);
    if pPlayer == nil or pUnit == nil then return; end
    local pExperience = pUnit:GetExperience();
    if (pExperience ~= nil) then
        local promotionList :table = pExperience:GetPromotions();
        --print(#promotionList)
        local greatGeneralID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_GENERAL'].Index
        local pGreatPeople  :table  = Game.GetGreatPeople();
        local pTimeline = pGreatPeople:GetTimeline();
        local recruitCost = 0;
        for _, tEntry in pairs(pTimeline) do
            if tEntry.Class == greatGeneralID then
                recruitCost = tEntry.Cost;
                --print(recruitCost)
            end
        end
       
        if recruitCost ~= nil and recruitCost > 0 then
            local sUnitName = pUnit:GetName();
            local iGpp = math.ceil(#promotionList * recruitCost * 0.03);
            if IsClassical() then
                iGpp = iGpp * 2;
            end            
            iGpp = math.floor(iGpp);
            GameEvents.AddGreatPeoplePoints.Call(player, greatGeneralID, iGpp);
            local sTitle = Locale.Lookup('LOC_COMPETITION_GREAT_GENERAL_TITLE')
            local notificationData = {};
            notificationData[ParameterTypes.MESSAGE] = sTitle;
            notificationData[ParameterTypes.SUMMARY] = Locale.Lookup('LOC_COMPETITION_GREAT_GENERAL_DESCRIPTION', sUnitName, #promotionList,iGpp);
            notificationData.AlwaysAutoActivate = true;
            notificationData.AlwaysUnique = true;


            NotificationManager.SendNotification(player, GreatPersonNotificationHash,notificationData);
        end
    end
end

Events.UnitPromoted.Add( OnUnitPromotionChanged );


--买东西送大商  --已废弃
-- function PurchaseBoostMerchant(playerId, cityId, x, y, purchaseType, objectType)
--     local iCost = 0;
--     local sName = '';
--     if purchaseType == EventSubTypes.UNIT then
--         iCost = GameInfo.Units[objectType].Cost;
--         sName = GameInfo.Units[objectType].Name;
--     elseif purchaseType == EventSubTypes.BUILDING then
--         iCost = GameInfo.Buildings[objectType].Cost;
--         sName = GameInfo.Buildings[objectType].Name;
--     elseif purchaseType == EventSubTypes.DISTRICT then
--         iCost = GameInfo.Districts[objectType].Cost;
--         sName = GameInfo.Districts[objectType].Name;
--     end
--     local pPlayer = Players[playerId];
--     local greatMerchantID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_MERCHANT'].Index;
--     if iCost > 0 then
--         GameEvents.AddGreatPeoplePoints.Call(playerId, greatMerchantID, iCost/5);
--         local sTitle = Locale.Lookup('LOC_COMPETITION_GREAT_MERCHANT_TITLE')
--         local notificationData = {};
--         notificationData[ParameterTypes.MESSAGE] = sTitle;
--         notificationData[ParameterTypes.SUMMARY] = Locale.Lookup('LOC_COMPETITION_GREAT_MERCHANT_DESCRIPTION', sName, iCost/5);
--         notificationData.AlwaysAutoActivate = true;
--         notificationData.AlwaysUnique = true;
--         NotificationManager.SendNotification(playerId, GreatPersonNotificationHash,notificationData);
--     end
-- end


--已废弃
-- Events.CityMadePurchase.Add(PurchaseBoostMerchant)



function isValidBuilding(buildingID)
    local building = GameInfo.Buildings[buildingID]
    if (building ~= nil) then
        local pType = building.BuildingType
        if(string.find(pType, 'CITY_POLICY') ~= nil) then
            return false
        elseif(string.find(pType, 'CTYZ') ~= nil) then
            return false
        elseif(string.find(pType, 'LEGACY') ~= nil) then
            return false
        elseif(string.find(pType, 'FLAG') ~= nil) then
            return false
        end
    else
        return false
    end
    return true
end