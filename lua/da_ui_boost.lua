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
Utils.DA_GetImprovements_Plots = function(playerID)
    local pPlayer = Players[playerID]
    local pPlayerImprovements = pPlayer:GetImprovements()
    if (pPlayerImprovements == nil) then
        return nil;
    end
    local pPlayerImprovementsPlots:table = pPlayerImprovements:GetImprovementPlots()
    if (pPlayerImprovementsPlots == nil) then
        return nil;
    end
    return pPlayerImprovementsPlots;
    
end
Utils.DA_GetDistricts = function(playerID)
    local pPlayerDistricts = Players[playerID]:GetDistricts();
    if pPlayerDistricts == nil then
        return nil;
    end
    return pPlayerDistricts;
end


Utils.DA_Boost_Improvement = function(playerID, plotID, ImprovementType)
    local pPlot = Map.GetPlotByIndex(plotID);
    local tBoostByImprovement = {}
    --航海术
    if pPlot:IsAdjacentToShallowWater() then
        tBoostByImprovement["TECH_SAILING"] = 1
    end
    --灌溉
    if ImprovementType == "IMPROVEMENT_FARM" or ImprovementType == "IMPROVEMENT_PLANTATION" then
        tBoostByImprovement["TECH_IRRIGATION"] = 1
    --箭术
    elseif ImprovementType == "IMPROVEMENT_CAMP" or ImprovementType == "IMPROVEMENT_PASTURE" then
        tBoostByImprovement["TECH_ARCHERY"] = 1
    --铸铜术
    elseif ImprovementType == "IMPROVEMENT_MINE" then
        tBoostByImprovement["TECH_BRONZE_WORKING"] = 1
    --砌砖
    elseif ImprovementType == "IMPROVEMENT_QUARRY" then
        tBoostByImprovement["TECH_MASONRY"] = 1
    end
    return tBoostByImprovement;
end


Utils.DA_Boost_District = function(playerID, iX, iY, districtID)
    local pPlot = Map.GetPlot(iX, iY);
    local tBoostByDistrict = {}
    --航海术
    if pPlot:IsAdjacentToShallowWater() then
        tBoostByDistrict["TECH_SAILING"] = 1
    end

    if pPlot:GetDistrictType() ~= nil and pPlot:GetDistrictType() == districtID then

    end
    return tBoostByDistrict;
end





