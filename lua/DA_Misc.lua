GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;

local bLoadScreenFinished = false;
--[[
function EagleWarriorCaptureVuilderBonus( currentUnitOwner, unitID, owningPlayer, capturingPlayer )
    local pPlayer = Players[capturingPlayer]
    local pPlayerConfig = PlayerConfigurations[capturingPlayer]
    local sCiv = pPlayerConfig:GetCivilizationTypeName()

    --See if already have captical city--
    local pUnit = pPlayer:GetUnits():FindID(unitID)
    print(pUnit:GetType())
    local unitType = GameInfo.Units[pUnit:GetType()]
    print(unitType.UnitType)
    if unitType.UnitType == "UNIT_BUILDER" then
        print(234)
        local unitX = pUnit:GetX()
        local unitY = pUnit:GetY()
        local unitList = Units.GetUnitsInPlot(iX, iY)
        if unitList ~= nil then 
            for i, rUnit in ipairs(unitList) do
                print(345)
                local unitType1 = GameInfo.Units[rUnit:GetType()]
                if unitType1.UnitType == "UNIT_AZTEC_EAGLE_WARRIOR" then
                    print(456)
                    UnitManager.RestoreMovement(rUnit)
                    rUnit:ChangeDamage(-20)
                end
            end
        end
    end
end

Events.UnitCaptured.Add(EagleWarriorCaptureVuilderBonus)


]]
-- ===========================================================================
-- ===========================================================================
--铺路 game play部分
m_BuildModeEnabled = {};

GameEvents.DA_BuildRoads.Add(function(playerID : number, unitID : number)
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    GameEvents.SetAbilityCount.Call(playerID, unitID, 'ABILITY_BUILDROAD_MODE', 1);
    GameEvents.RestoreUnitMovement.Call(playerID, unitID);
    GameEvents.ChangeUnitMovesRemaining.Call(playerID, unitID, 4);  
    GameEvents.SetUnitProperty.Call(playerID, unitID, 'PROP_BUILDROAD_MODE', 1);
    GameEvents.ReduceBuildCharge.Call(playerID, unitID);
    m_BuildModeEnabled[playerID] = m_BuildModeEnabled[playerID] or {};
    m_BuildModeEnabled[playerID][unitID] = 1;
end)
-- ===========================================================================
function OnUnitMoved(playerId:number, unitId:number, tileX, tileY)
    local pUnit = UnitManager.GetUnit(playerId, unitId);
    if pUnit == nil then return end  --有反映pUnit可能为nil 原因不明 暂时没有铺路失败的反馈 如果有的话可能是这里的问题
    local player = Players[playerId];
    if pUnit:GetProperty('PROP_BUILDROAD_MODE') ~= nil and pUnit:GetProperty('PROP_BUILDROAD_MODE') == 1 then
        local plot = Map.GetPlot(tileX, tileY);
        if not plot:IsWater() then
            local buildingRouteType = GetPlayerRouteType(player);
            local currentRouteType = plot:GetRouteType();
            if currentRouteType == -1 or buildingRouteType.PlacementValue > GameInfo.Routes[currentRouteType].PlacementValue then
                RouteBuilder.SetRouteType(plot, buildingRouteType.Index);
            end
        end
    end
end
Events.UnitMoved.Add(OnUnitMoved);

function GetPlayerRouteType(player)
    local route = nil;
    local playerEra = GameInfo.Eras[player:GetEra()];
    
    for routeType in GameInfo.Routes() do 
        if route == nil then
            route = routeType;
        else
            if (route.PlacementValue < routeType.PlacementValue) then
                local canBuild = true;
                
                -- Era requirement
                local prereq_era = GameInfo.Eras[routeType.PrereqEra];
                if prereq_era and playerEra.ChronologyIndex < prereq_era.ChronologyIndex  then
                    canBuild = false;
                end
                
                -- Tech requirement
                if canBuild and GameInfo.Routes_XP2 then
                    local routeXp2 = GameInfo.Routes_XP2[routeType.RouteType];
                    
                    if (routeXp2 and routeXp2.PrereqTech) then
                        local playerTech = player:GetTechs();
                        local requiredTech = GameInfo.Technologies[routeXp2.PrereqTech];
                        
                        if not (playerTech:HasTech(requiredTech.Index) and routeType.PlacementValue~=5) then
                            canBuild = false;
                        end
                    end
                end
                
                if (canBuild) then
                    route = routeType;
                end
            end
        end
    end
    
    -- See if player has TRAIT_CIVILIZATION_SATRAPIES trait
    local playerId = player:GetID();
    
    
    if Utils.PlayerHasTrait(playerId, 'TRAIT_CIVILIZATION_SATRAPIES') then
        -- See if there is a road with higher placement value
        for routeType in GameInfo.Routes() do
            if (routeType.PlacementValue == route.PlacementValue + 1) then
                route = routeType;
                break;
            end
        end
    end
    return route;
end

function OnTurnBeginBuildMode()
    for playerID, playerUnits in pairs(m_BuildModeEnabled) do
        for unitID, value in pairs(playerUnits) do
            if value == 1 then
                local pUnit = UnitManager.GetUnit(playerID, unitID);
                if pUnit == nil then 
                    m_BuildModeEnabled[playerID][unitID] = 0;
                    return; 
                end
                pUnit:SetProperty('PROP_BUILDROAD_MODE', 0);
                GameEvents.SetAbilityCount.Call(playerID, unitID, 'ABILITY_BUILDROAD_MODE', 0);
                m_BuildModeEnabled[playerID][unitID] = 0;
            end
        end
    end
end


function OnLoadScreenCloseBuildMode()
    local players = Game.GetPlayers{Alive = true};
    for _, player in ipairs(players) do
        for _, unit in player:GetUnits():Members() do
            if unit:GetProperty('ABILITY_BUILDROAD_MODE') ~= nil and unit:GetProperty('ABILITY_BUILDROAD_MODE') == 1 then
                local playerID = player:GetID();
                local unitID = unit:GetID();
                m_BuildModeEnabled[playerID] = m_BuildModeEnabled[playerID] or {};
                m_BuildModeEnabled[playerID][unitID] = 1;
            end
        end
    end
end



Events.TurnBegin.Add(OnTurnBeginBuildMode);
Events.LoadScreenClose.Add(OnLoadScreenCloseBuildMode);

--GameEvents.RequestChangeFaithBalance.Call(2,21)
----------------------------------------------------------------

--信仰造奇观 game play部分
GameEvents.DA_FaithBuildWonder.Add(function(playerID : number, unitID : number)
    --local playerID = pUnit:GetOwner();
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local player = Players[playerID];
    local iX, iY = pUnit:GetX(), pUnit:GetY();
    local pPlot = Map.GetPlot(iX, iY);
    local pCity = Cities.GetPlotPurchaseCity(pPlot);
    local sCurrent = Utils.GetCurrentlyBuilding(playerID, pCity:GetID());
    local iCost = GameInfo.Buildings[sCurrent].Cost;
    local iProductionProgress = Utils.GetCurrentlyBuildingProgress(playerID, pCity:GetID(), GameInfo.Buildings[sCurrent].Index);
    local iRiverCount = pPlot:GetProperty('PROP_RIVER_COUNT') or 0;
    local iFaithNeeded = (iCost - iProductionProgress) * 2 / (1 + iRiverCount * 0.1);
    local iFaithBalance = player:GetReligion():GetFaithBalance();
    player:GetReligion():ChangeFaithBalance(-iFaithNeeded);
    GameEvents.RequestAddProgress.Call(playerID, pCity:GetID(), iFaithNeeded+1);
    --SimUnitSystem.SetAnimationState(pUnit, "ACTION_1", "IDLE");
    GameEvents.ReduceBuildCharge.Call(playerID, unitID);
end)


--信仰造区域 game play部分
GameEvents.DA_MissionaryBuildDistricts.Add(function(playerID : number, unitID : number)
    --local playerID = pUnit:GetOwner();
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local player = Players[playerID];
    local iX, iY = pUnit:GetX(), pUnit:GetY();
    local pPlot = Map.GetPlot(iX, iY);
    local pCity = Cities.GetPlotPurchaseCity(pPlot);
    local sCurrent = Utils.GetCurrentlyBuilding(playerID, pCity:GetID());
    local iDistrict = GameInfo.Districts[sCurrent].Index
    local iCost = Utils.GetDistrictCost(pCity:GetOwner(), pCity:GetID(), iDistrict) * 2;  

    player:GetReligion():ChangeFaithBalance(-iCost);
    pCity:GetBuildQueue():FinishProgress();
    --SimUnitSystem.SetAnimationState(pUnit, "ACTION_1", "IDLE");
    if pUnit:GetReligion():GetSpreadCharges() == 1 then
        UnitManager.Kill(pUnit)
    else
        pUnit:GetReligion():ChangeSpreadCharges(-1);
    end
end)

--祝圣 game play部分
GameEvents.DA_ApostleFaith.Add(function(playerID : number, unitID : number)
    --local playerID = pUnit:GetOwner();
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local player = Players[playerID];
    local iX, iY = pUnit:GetX(), pUnit:GetY();
    local pPlot = Map.GetPlot(iX, iY);
    pPlot:SetProperty('PROP_CONSECRATION', 1);
    --SimUnitSystem.SetAnimationState(pUnit, "ACTION_1", "IDLE");
    if pUnit:GetReligion():GetSpreadCharges() == 1 then
        UnitManager.Kill(pUnit)
    else
        pUnit:GetReligion():ChangeSpreadCharges(-1);
    end
end)


--阿兹特克献祭 game play部分
GameEvents.DA_BuilderSaciifice.Add(function(playerID : number, unitID : number)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    local pCity = Cities.GetCityInPlot(iX, iY)
    local iCharges = pUnit:GetBuildCharges();
    if pCity == nil then
        return
    end
    for i = 1, iCharges do
        pCity:AttachModifierByID('DA_AZTEC_CITY_CENTER_FAITH');
    end
    pCity:AttachModifierByID('DA_AZTEC_TLACHTLI_AMENITY');
    --local NextPlotID = pCity:GetCulture():GetNextPlot()
    --GameEvents.ChangePlotOwner.Call(playerID,NextPlotID)
    UnitManager.Kill(pUnit);
    
end)


--建造者花劳动力给地块加产出 game play部分 食物
GameEvents.DA_BuilderAddFood.Add(function(playerID : number, unitID : number)
    --local playerID = pUnit:GetOwner();
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local player = Players[playerID];
    local iX, iY = pUnit:GetX(), pUnit:GetY();
    local pPlot = Map.GetPlot(iX, iY);
    pPlot:SetProperty('PROP_INFRASTRUCTURE', 1);
    --SimUnitSystem.SetAnimationState(pUnit, "ACTION_1", "IDLE");
    GameEvents.ReduceBuildCharge.Call(playerID, unitID);
end)

--建造者花劳动力给地块加产出 game play部分 生产力
GameEvents.DA_BuilderAddProd.Add(function(playerID : number, unitID : number)
    --local playerID = pUnit:GetOwner();
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local player = Players[playerID];
    local iX, iY = pUnit:GetX(), pUnit:GetY();
    local pPlot = Map.GetPlot(iX, iY);
    pPlot:SetProperty('PROP_INFRASTRUCTURE', 2);
    --SimUnitSystem.SetAnimationState(pUnit, "ACTION_1", "IDLE");
    GameEvents.ReduceBuildCharge.Call(playerID, unitID);
end)

--凯旋门 建筑效果 game play部分 仅限一次，允许军事单位使用“凯旋”行动，立刻回到最近的未使用过该行动的凯旋门，并获得一项升级。
GameEvents.DA_TriumphToTriumphalArch.Add(function(playerID : number, unitID : number)
    local pPlayer = Players[playerID];
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local PROP_ENABLE_TRIUMPH = pPlayer:GetProperty('PROP_ENABLE_TRIUMPH') or 0;
    local iXP = pUnit:GetExperience():GetExperienceForNextLevel();
	pUnit:GetExperience():ChangeExperience(iXP);
	local cityList = Utils.GetPlayerCitiesSortedByDistance(playerID, pUnit:GetX(), pUnit:GetY());
	for i, city in ipairs(cityList) do
		local PROP_USED_TRIUMPH = city:GetProperty('PROP_USED_TRIUMPH') or 0;
		if PROP_USED_TRIUMPH == 0 and city:GetBuildings():HasBuilding(GameInfo.Buildings["BUILDING_TRIUMPHAL"].Index) then
            city:SetProperty('PROP_USED_TRIUMPH', 1);
            pPlayer:SetProperty('PROP_ENABLE_TRIUMPH', PROP_ENABLE_TRIUMPH - 1);
            UnitManager.PlaceUnit(pUnit, city:GetX(), city:GetY());
            break;
        end
    end
end)






-- function CityStateClearBarbCamp(playerID,unitID,x,y)
--     local pPlayer = Players[playerID];
--     if Utils.IsMinor(playerID) then
--         local pUnit :object = Players[playerID]:GetUnits():FindID(unitID)
--         local pPlayer = Players[playerID]
--         local plotID = Map.GetPlotIndex(x,y)
--         local pPlot = Map.GetPlot(x,y);
--         local eImprovement = pPlot:GetImprovementType();
--         print('reach'..x..'  '..y..'  '..eImprovement)
--         if eImprovement ~= nil and eImprovement ~= -1 then--and GameInfo.Improvements[eImprovement].ImprovementType == 'IMPROVEMENT_BARBARIAN_CAMP' then
--            ImprovementBuilder.SetImprovementType(pPlot, -1);
--         end
--     end
-- end


-- Events.UnitMoveComplete.Add(CityStateClearBarbCamp)


--希腊，伯利克里，提洛同盟

--伟人主动能力激活后标记
function DA_UnitGreatPersonActivated(unitOwner,unitID,greatPersonClassID,greatPersonIndividualID)
    local pUnit = UnitManager.GetUnit(unitOwner, unitID)
    local pPlayer = Players[unitOwner]
    if Utils.PlayerHasTrait(unitOwner,"TRAIT_LEADER_SURROUNDED_BY_GLORY") then
        --实际检测该Property是否为nil
        pUnit:SetProperty('CAN_GET_ENVOY', false)
    end
end
Events.UnitGreatPersonActivated.Add(DA_UnitGreatPersonActivated)






--by 枫叶  阿尔特弥斯送超级远程单位

local DA_Artmeis_Grant_Unit_Key             = "DA_ARTEMIS_GRANT_UNIT";
local DA_Artmeis_Unit_Strength_Bonus_Key    = "DA_ARTEMIS_UNIT_STRENGTH_BONUS";
local DA_Artmeis_Unit_Strength_Ability      = "ABILITY_DA_ARTEMIS_CAMP_STRENGTH";
local DA_Artmeis_Unit_Strength_Ability_Key  = "COMBAT_STRENGTH_FOR_RANGED_FROM_ARTEMIS";

function CivilizationHasTrait(sCiv, sTrait)
    for tRow in GameInfo.CivilizationTraits() do
        if (tRow.CivilizationType == sCiv and tRow.TraitType == sTrait) then
            return true;
        end
    end
    return false;
end

function LeaderHasTrait(sLeader, sTrait)
    for tRow in GameInfo.LeaderTraits() do
        if (tRow.LeaderType == sLeader and tRow.TraitType == sTrait) then return
            true;
        end
    end
    return false;
end

function findValidRangedUnit(playerID)
    local pPlayer = Players[playerID]   
    local playerTechs = pPlayer:GetTechs()
    local playerCulture = pPlayer:GetCulture()
    local playerConfig = PlayerConfigurations[playerID];
    local leader = playerConfig:GetLeaderTypeName() 
    local civ = playerConfig:GetCivilizationTypeName();
    local tempUnitTypeStr = "UNIT_SLINGER"
    local tempUnitRangedStrength = 0


    for row in GameInfo.Units() do
        local unitTypeStr = row.UnitType
        local preTech = row.PrereqTech 
        local preCivic = row.PrereqCivic
            
        local preTRequire = false
        local preCRequire = false
        if preTech ~= nil then
            local preTechInfo = GameInfo.Technologies[preTech]
            preTRequire = playerTechs:HasTech(preTechInfo.Index)
        end
        if preCivic ~= nil then
            local preCivicInfo = GameInfo.Civics[preCivic]
            preCRequire = playerCulture:HasCivic(preCivicInfo.Index)
        end

        local traitType = row.TraitType
        local traitMatch_1 = false
        local traitMatch_2 = false
        if traitType == nil then
            traitMatch_1 = true
        else
            if LeaderHasTrait(leader, traitType) or CivilizationHasTrait(civ, traitType) then
                traitMatch_2 = true
            end
        end

        if (preCRequire or preTRequire) and (traitMatch_1 or traitMatch_2) and row.CanTrain and row.PromotionClass == "PROMOTION_CLASS_RANGED" then
            if traitMatch_2 then
                local unitReplaceInfo = GameInfo.UnitReplaces[unitTypeStr]
                if unitReplaceInfo ~= nil then
                    if unitReplaceInfo.ReplacesUnitType == unitTypeStr then
                        tempUnitRangedStrength = row.RangedCombat
                        tempUnitTypeStr = unitTypeStr
                    end
                else
                    if tempUnitRangedStrength < row.RangedCombat then
                        tempUnitRangedStrength = row.RangedCombat
                        tempUnitTypeStr = unitTypeStr
                    end
                end
            else
                if tempUnitRangedStrength < row.RangedCombat then
                    tempUnitRangedStrength = row.RangedCombat
                    tempUnitTypeStr = unitTypeStr
                end
            end
        end

    end

    print("valid unitType = "..tempUnitTypeStr)

    return tempUnitTypeStr

end

function DA_Artemis_Grant_Unit(playerID:number, params:table)
    local pPlayer = Players[playerID]
    if pPlayer == nil then
        print("error: player nil")
        return
    end
    print("666")

    pPlayer:SetProperty(DA_Artmeis_Grant_Unit_Key, 1)
    pPlayer:SetProperty(DA_Artmeis_Unit_Strength_Bonus_Key, params.Strength)
    

    local giftUnitTypeStr = findValidRangedUnit(playerID)

    UnitManager.InitUnitValidAdjacentHex(playerID, giftUnitTypeStr, params.X, params.Y, 1)

    print("give unit success!")
end

function On_UnitAddedToMap_DA_Artemis(playerID, unitID)
    local pPlayer = Players[playerID]

    local p_Artemis_Property = pPlayer:GetProperty(DA_Artmeis_Grant_Unit_Key)

    if p_Artemis_Property == nil or p_Artemis_Property ~= 1 then
        return
    end

    local pUnit = UnitManager.GetUnit(playerID, unitID)
    local pUnitPropertyNum = pPlayer:GetProperty(DA_Artmeis_Unit_Strength_Bonus_Key)

    pUnit:SetProperty(DA_Artmeis_Unit_Strength_Ability_Key, pUnitPropertyNum)

    local unitABCount = pUnit:GetAbility():GetAbilityCount(DA_Artmeis_Unit_Strength_Ability)
    if unitABCount < 1 then
        pUnit:GetAbility():ChangeAbilityCount(DA_Artmeis_Unit_Strength_Ability, 1 - unitABCount)
    end

    pPlayer:SetProperty(DA_Artmeis_Grant_Unit_Key, 0)
    print("unit add property and ability success")

end

function Initialize_Fy()
    GameEvents.DA_Artemis_Grant_Unit.Add(DA_Artemis_Grant_Unit);

    Events.UnitAddedToMap.Add(On_UnitAddedToMap_DA_Artemis);
    
end
Events.LoadGameViewStateDone.Add(Initialize_Fy)
print("DA artemis gameplay script activated!");







-- function  onSuppressing( pCombatResult)
--     local attacker = pCombatResult[CombatResultParameters.ATTACKER];
--     local attInfo = attacker[CombatResultParameters.ID];
--     local pPlayerConfig = PlayerConfigurations[attInfo.player];
--     local attUnit = UnitManager.GetUnit(attInfo.player, attInfo.id);

--     local defender = pCombatResult[CombatResultParameters.DEFENDER];
--     local defInfo = defender[CombatResultParameters.ID];
--     local pDefUnit = UnitManager.GetUnit(defInfo.player, defInfo.id);

--     if attUnit ==nil or pDefUnit == nil then return end
--     if GameInfo.Units[attUnit:GetType()].UnitType == 'UNIT_SLINGER' then
--         Utils.SetAbilityCount(defInfo.player, defInfo.id, 'ABILITY_SUPPRESSED', 1);
--     end

--     -- local location = pCombatResult[CombatResultParameters.LOCATION];
--     -- local damage = defender[CombatResultParameters.FINAL_DAMAGE_TO];     


-- end

--Events.Combat.Add(onSuppressing);




-- expanded initial vision    from hd
local PROP_KEY_EXPANDED_INIT_VISION = "ExpandedInitVision";

function RevealArea()
    -- Only done once.
    if Game.GetProperty(PROP_KEY_EXPANDED_INIT_VISION) == 1 then
        return;
    end
    Game.SetProperty(PROP_KEY_EXPANDED_INIT_VISION, 1);

    --Set desired sight radius using GlobalParameters
    local base_rad = GlobalParameters.EXPANDED_INIT_VISION_RANGE;
    
    local majors = PlayerManager.GetAliveMajorIDs();
    for _, player_id in ipairs(majors) do
        local player = Players[player_id];
        local pVis = PlayersVisibility[player_id];
        local playerConfig = PlayerConfigurations[player_id];
        local sLeader = playerConfig:GetLeaderTypeName();
        local rad = base_rad;
        for tRow in GameInfo.LeaderTraits() do
            -- Maya with 3 more vision
            if (tRow.LeaderType == sLeader and tRow.TraitType == 'TRAIT_LEADER_MUTAL') then
                rad = rad + 3;
            end
        end
        local pPlot = player:GetStartingPlot();
        local tPlots = GetValidPlotsInRadiusR(pPlot, rad);
        
        for k, pPickPlot in ipairs(tPlots) do
            
            --If there is a natural wonder on the tile, do not reveal. Any amount of revealing this tile will not allow the wonder discovery eureka during game.
            if(pPickPlot:IsNaturalWonder()) then
                print("wonder on tile - not revealing tile");

            --If there is a unit on the tile, do not remove FOW. This avoids the diplomatic meet event.
            elseif(pPickPlot:GetUnitCount() > 0 or pPickPlot:IsCity()) then
                pVis:ChangeVisibilityCount(pPickPlot:GetIndex(), 0);
                print("unit or city on tile - revealing tile, not removing FOW");

            --If there is no unit or wonder, temporarily remove FOW so that the resouce icon will show.
            else
                pVis:ChangeVisibilityCount(pPickPlot:GetIndex(), 1);
                pVis:ChangeVisibilityCount(pPickPlot:GetIndex(), -1);
                -- print("no unit or wonder on tile - revealing tile, temporarily removing FOW");
            end
        end
    end
end

function GetValidPlotsInRadiusR(pPlot, iRadius)
    local tTempTable = {}
    if pPlot ~= nil then
        local iPlotX, iPlotY = pPlot:GetX(), pPlot:GetY()
        for dx = (iRadius * -1), iRadius do
            for dy = (iRadius * -1), iRadius do
                local pNearPlot = Map.GetPlotXYWithRangeCheck(iPlotX, iPlotY, dx, dy, iRadius);
                if pNearPlot then
                    table.insert(tTempTable, pNearPlot)
                end
            end
        end
    end
    return tTempTable;
end

RevealArea();

--
function OnGameEraChanged(prevEraIndex:number, newEraIndex:number)
    print(prevEraIndex)
    local majors = PlayerManager.GetAliveMajorIDs();
    for _, player_id in ipairs(majors) do
        if newEraIndex == 0 then
            GameEvents.TriggerCommonEvent.Call(player_id, 'EVENT_COMMON_ENTER_ERA_ANCIENT');
        end
        if newEraIndex == 1 then
            GameEvents.TriggerCommonEvent.Call(player_id, 'EVENT_COMMON_ENTER_ERA_CLASSICAL');
        end
    end
end

Events.GameEraChanged.Add(OnGameEraChanged);







-- Horses and Iron within 6 tiles
local PALACE_INDEX = GameInfo.Buildings['BUILDING_PALACE'].Index;
function StrategicCityAddedToMap (playerId, cityId, x, y)
    local player = Players[playerId];
    if not player:IsMajor() then
        return;
    end
    local city = CityManager.GetCity(playerId, cityId);
    if city:GetBuildings():HasBuilding(PALACE_INDEX) then
        for row in GameInfo.DA_GuaranteedStrategicResources() do
            local resourceInfo = GameInfo.Resources[row.ResourceType];
            local plots = Map.GetNeighborPlots(x, y, row.Distance);
            local hasResource = false;
            local availablePlots = {};
            for _, plot in ipairs(plots) do
                if plot:GetResourceType() == resourceInfo.Index then
                    hasResource = true;
                    break;
                end
                if ResourceBuilder.CanHaveResource(plot, resourceInfo.Index) then
                    local distance = Map.GetPlotDistance(x, y, plot:GetX(), plot:GetY());
                    local adjResources = ResourceBuilder.GetAdjacentResourceCount(pPlot);
                    local s = distance * 60 - adjResources * 10 + TerrainBuilder.GetRandomNumber(10, "Guaranteed Strategic Resource Adjust")
                    table.insert(availablePlots, {plotId = plot:GetIndex(), score = s});
                end
            end
            if (not hasResource) and (#availablePlots > 0) then
                table.sort(availablePlots, function(a, b) return a.score > b.score; end);
                local plotId = availablePlots[1].plotId;
                local plot = Map.GetPlotByIndex(plotId);
                ResourceBuilder.SetResourceType(plot, resourceInfo.Index, 1);
            end
        end
    end
end
Events.CityAddedToMap.Add(StrategicCityAddedToMap);

--马格努斯 母城
-- function MetropolisBuff(playerID, unitID)
--     if bLoadScreenFinished == false then return; end
--     local pUnit = UnitManager.GetUnit(playerID, unitID);
--     local pPlayer = Players[playerId];
--     if GameInfo.Units[pUnit:GetType()].UnitType ~= 'UNIT_SETTLER' then return end
--     local pPlot = Map.GetPlot(pUnit:GetX(), pUnit:GetY());
--     local pCity = Cities.GetPlotPurchaseCity(pPlot);
--     if pCity == nil then return; end
--     local iProperty = pCity:GetProperty('PROP_METROPOLIS') or 0;
--     if iProperty == 0 then return end
--     -- local pGovernorMagnus = pPlayer:GetGovernors():GetGovernor(GameInfo.Governors['GOVERNOR_THE_RESOURCE_MANAGER'].Hash);
--     -- if pGovernorMagnus then
--     --     local currentCity:table = governor:GetAssignedCity();
--     --     if currentCity == nil then return end
--     --     if pCity:GetID() == currentCity:GetID() and pGovernorMagnus:HasPromotion(GameInfo.GovernorPromotions['GOVERNOR_THE_RESOURCE_MANAGER'].Hash)
--     -- print('ok')
--     pCity:AttachModifierByID('METROPOLIS_GRANT_HOUSING');
--     pCity:AttachModifierByID('METROPOLIS_GRANT_AMENITY');
--     pCity:AttachModifierByID('METROPOLIS_GRANT_EXPANSION');
-- end

function MetropolisBuff(playerID, cityID)
    if bLoadScreenFinished == false then return; end
    local pCity = CityManager.GetCity(playerID, cityID);
    if pCity == nil then return; end
    local pPlayer = Players[playerID];
	local pPlayerCities:table = pPlayer:GetCities();
	for i, pLoopCity in pPlayerCities:Members() do
		local iProperty = pLoopCity:GetProperty('PROP_METROPOLIS') or 0;
        if iProperty > 0 then
            pLoopCity:AttachModifierByID('METROPOLIS_GRANT_HOUSING');
            pLoopCity:AttachModifierByID('METROPOLIS_GRANT_AMENITY');
            pLoopCity:ChangePopulation(1);
        end
	end 
end



function OnLoadScreenClose_All()
    bLoadScreenFinished = true;
end


--Events.UnitAddedToMap.Add(MetropolisBuff);
Events.CityAddedToMap.Add(MetropolisBuff);
Events.LoadScreenClose.Add(OnLoadScreenClose_All)


--凝聚力给点数
function OnTurnBeginUnity()
    local players = PlayerManager.GetAliveMajors();
    for _, player in ipairs(players) do
        local unityBalance = player:GetProperty('PROP_UNITY_BALANCE') or 0;
        local unityRateFromDoublePolicy = player:GetProperty('PROP_UNITY_RATE_FROM_DOUBLE_POLICY') or 0;
        local UnityIncome = 0;
        for row in GameInfo.Unity_Sources() do
            local propertyName = row.SourceProperty;
            local propertyValue = player:GetProperty(propertyName) or 0;
            UnityIncome = UnityIncome + propertyValue;
        end

        local unityThreshold = player:GetProperty('PROP_UNITY_THRESHOLD') or 200;
        local newBalance = (unityBalance + UnityIncome - unityRateFromDoublePolicy) % unityThreshold;
        local gainGovernors = math.floor((unityBalance + UnityIncome - unityRateFromDoublePolicy) / unityThreshold);
        if gainGovernors >= 0 then
            local playerGovernors = player:GetGovernors();
            playerGovernors:ChangeGovernorPoints(gainGovernors);
        else
            newBalance = 0;
        end
        player:SetProperty('PROP_UNITY_BALANCE', newBalance);
    end
end

Events.TurnBegin.Add(OnTurnBeginUnity);

--换政府返还政策卡总督点数
function GovernmentChanged(playerID)
    local pPlayer = Players[playerID]
    local hidedGovernors = pPlayer:GetProperty('PROP_HIDE_GOVERNOR') or 0;
    local policyGovernors = pPlayer:GetProperty('PROP_POLICY_GOVERNOR') or 0;
    local m_GovernorExchangePolicy = Players[playerID]:GetProperty('PROP_EXCHANGE_POLICY');
    if m_GovernorExchangePolicy == nil then
      m_GovernorExchangePolicy = {
        Military = 0,
        Economic = 0,
        Diplomatic = 0,
        Wildcard = 0,
      }
    end
    while m_GovernorExchangePolicy['Military'] > 0 do
        m_GovernorExchangePolicy['Military'] = m_GovernorExchangePolicy['Military'] - 1;
        pPlayer:AttachModifierByID('LOS_Military');
    end
    while m_GovernorExchangePolicy['Economic'] > 0 do
        m_GovernorExchangePolicy['Economic'] = m_GovernorExchangePolicy['Economic'] - 1;
        pPlayer:AttachModifierByID('LOS_Economic');
    end
    while m_GovernorExchangePolicy['Diplomatic'] > 0 do
        m_GovernorExchangePolicy['Diplomatic'] = m_GovernorExchangePolicy['Diplomatic'] - 1;
        pPlayer:AttachModifierByID('LOS_Diplomatic');
    end
    while m_GovernorExchangePolicy['Wildcard'] > 0 do
        m_GovernorExchangePolicy['Wildcard'] = m_GovernorExchangePolicy['Wildcard'] - 1;
        pPlayer:AttachModifierByID('LOS_Wildcard');
    end
    hidedGovernors = hidedGovernors - policyGovernors;
    policyGovernors = 0;
    pPlayer:SetProperty('PROP_HIDE_GOVERNOR', hidedGovernors);
    pPlayer:SetProperty('PROP_POLICY_GOVERNOR', policyGovernors);
    pPlayer:SetProperty('PROP_EXCHANGE_POLICY', m_GovernorExchangePolicy);
end

Events.GovernmentChanged.Add(GovernmentChanged)





