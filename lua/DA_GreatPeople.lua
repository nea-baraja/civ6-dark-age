GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;

local AQUEDUCT_INDEX = GameInfo.Districts["DISTRICT_AQUEDUCT"].Index;
local MERCURY_INDEX = GameInfo.Resources[  'RESOURCE_MERCURY'].Index;

local ZHENG_GUO_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_ZHENG_GUO"].Index;
local FAN_LI_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_FAN_LI"].Index;
local WIDOW_QING_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_WIDOW_QING"].Index;
local COLAEUS_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_COLAEUS"].Index;
local ZI_GONG_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_ZI_GONG"].Index;
local ARCHIMEDES_INDEX = GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_ARCHIMEDES"].Index;


--郑国
GameEvents.GreatPersonHandleActivation.Add(function(unitOwner, unitID, greatPersonIndividualID)
    local owner = Players[unitOwner];
    if greatPersonIndividualID == ZHENG_GUO_INDEX then
        owner:SetProperty('ZHENGGUO_SALE_AQUEDUCT', 1);

        -- local unit = UnitManager.GetUnit(unitOwner, unitID);
        -- local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
        -- local districtAtPlot = CityManager.GetDistrictAt(unitPlot);
        -- if districtAtPlot ~= nil then
        --     local districtIndex = districtAtPlot:GetType();
        --     local districtType = GameInfo.Districts[districtIndex].DistrictType;
        --     -- owner:AttachModifierByID("CULTURE_BOMB_TRIGGER_" .. districtType);
        --     -- Complete district at plot if not completed.
        --     local districtCity = districtAtPlot:GetCity();
        --     if districtCity ~= nil then
        --         districtCity:AttachModifierByID('GREATPERSON_ZHENG_GUO_AQUEDUCT_FOOD');
        --     end
        --     if not districtAtPlot:IsComplete() then
        --         if districtCity ~= nil then
        --             -- The activatable plot's district must be building the district. (Checked in GetActivationPlots call).
        --             districtCity:GetBuildQueue():FinishProgress();
        --         end
        --     end
        -- end
    end
end)

--范蠡  deserted
-- GameEvents.GreatPersonHandleActivation.Add(function(unitOwner, unitID, greatPersonIndividualID)
--     local owner = Players[unitOwner];
--     if greatPersonIndividualID == FAN_LI_INDEX then
--         local pPlayerTreasury = owner:GetTreasury();
--         local iGoldBonus = pPlayerTreasury:GetGoldYield() - pPlayerTreasury:GetTotalMaintenance();
--         if GameInfo.Eras[Game.GetEras():GetCurrentEra()].EraType == 'ERA_CLASSICAL' then
--             iGoldBonus = iGoldBonus * 2;
--         end
--         pPlayerTreasury:ChangeGoldBalance(iGoldBonus * 4);
--     end
-- end)

--科莱欧司
GameEvents.GreatPersonHandleActivation.Add(function(unitOwner, unitID, greatPersonIndividualID)
    local owner = Players[unitOwner];
    if greatPersonIndividualID == COLAEUS_INDEX then
        local unit = UnitManager.GetUnit(unitOwner, unitID);
        local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
        local sResource = GameInfo.Resources[unitPlot:GetResourceType()].ResourceType;
        owner:AttachModifierByID('NO_CAP_'..sResource);
    end
end)

GameEvents.GreatPersonHandleActivation.Add(function(unitOwner, unitID, greatPersonIndividualID)
    local owner = Players[unitOwner];
    if greatPersonIndividualID == ZI_GONG_INDEX then
        local unit = UnitManager.GetUnit(unitOwner, unitID);
        if unit:GetX() < 0 then return end
        local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
        local pCity = Cities.GetPlotPurchaseCity(unitPlot);
        local pCityState = Players[pCity:GetOwner()];
        local iSuzerain = pCityState:GetInfluence():GetSuzerain()
        if iSuzerain ~= nil and Players[iSuzerain] ~= nil and Utils.IsAtWarWith(unitOwner, iSuzerain) then
            local iCount = pCityState:GetInfluence():GetTokensReceived(iSuzerain);
            while ((iCount ~= -1) and (pCityState:GetInfluence():GetSuzerain() ~= unitOwner)) do
                owner:GetInfluence():GiveFreeTokenToPlayer(pCity:GetOwner());
                iCount = iCount - 1;
            end
        else
            owner:GetInfluence():GiveFreeTokenToPlayer(pCity:GetOwner());
        end
    end
end)


function pass()
end

--张衡
GameEvents.GreatPersonHandleActivation.Add(function(unitOwner, unitID, greatPersonIndividualID)
    local UnitOwner = Players[unitOwner];
    if greatPersonIndividualID == GameInfo.GreatPersonIndividuals["GREAT_PERSON_INDIVIDUAL_ZHANG_HENG"].Index then
        local pUnit = UnitManager.GetUnit(unitOwner, unitID)
        local iX,iY = pUnit:GetX(),pUnit:GetY()
        Game:SetProperty("GREAT_PERSON_INDIVIDUAL_ZHANG_HENG",{iX,iY})
    end
end)

function OnNaturalCalamityEventOccurred(type:number, severity:number, plotx:number, ploty:number, mitigationLevel:number, randomEventID:number, gameCorePlaybackEventID:number)
    
    if Game:GetProperty("GREAT_PERSON_INDIVIDUAL_ZHANG_HENG") == nil then
        return
    end
    local Event = GameInfo.RandomEvents[type]
    if Event.EffectOperatorType == "NUCLEAR_ACCIDENT" or Event.EffectOperatorType == "SEA_LEVEL" or Event.EffectOperatorType == "FIRE" then
        return
    end
    local iX,iY = Game:GetProperty("GREAT_PERSON_INDIVIDUAL_ZHANG_HENG")[1],Game:GetProperty("GREAT_PERSON_INDIVIDUAL_ZHANG_HENG")[2] 
    local iDistance = Map.GetPlotDistance(iX,iY,plotx,ploty)
    if iDistance < 6 then
        local pPlot = Map.GetPlot(iX,iY)
        local pDistrict = CityManager.GetDistrictAt(pPlot)
        local pCity = pDistrict:GetCity()
        if pCity ~= nil then
            pCity:AttachModifierByID("DA_GREAT_PERSON_MODIFIER_ZHANG_HENG")
        end
    end
end
Events.RandomEventOccurred.Add(OnNaturalCalamityEventOccurred)

--阿基米德
-- GameEvents.GreatPersonHandleActivation.Add(function(unitOwner, unitID, greatPersonIndividualID)
--     local owner = Players[unitOwner];
--     if greatPersonIndividualID == ARCHIMEDES_INDEX then
--         local unit = UnitManager.GetUnit(unitOwner, unitID);
--         local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
--         local pDistrict = CityManager.GetDistrictAt(unitPlot);
--         local pCity = pDistrict:GetCity();
--         for i = 1, 7, 1 do 
--             pCity:AttachModifierByID('DA_ARCHIMEDES_EURAKE_FROM_ADJACENCY_'..i);
--         end
--     end
-- end)

