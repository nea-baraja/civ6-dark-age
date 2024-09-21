GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils


ePyramid = GameInfo.Improvements['IMPROVEMENT_PYRAMID'].Index;
eCityCenter = GameInfo.Districts['DISTRICT_CITY_CENTER'].Index;

function OnImprovementAddedToMap( iX, iY, eImprovement, playerID )
	if playerID == nil then return end
	local pPlayer = Players[playerID];
	if pPlayer == nil then return end
	local bNubia = pPlayer:GetProperty('PROP_FREE_PYRAMID_CHARGES') or 0;
	if bNubia == 0 then return end
	local pPlot = Map.GetPlot(iX, iY);
	if pPlot == 0 then return end
	local adjPlots : table = Map.GetAdjacentPlots(iX, iY);
	local bFree = 0;
	for i = 1, 6, 1 do
		if adjPlots[i] ~= nil then
			local eImprovement = adjPlots[i]:GetImprovementType();
			if eImprovement == ePyramid then
				bFree = 1;
				break;
			end
			local eDistrictType = adjPlots[i]:GetDistrictType();
			if eDistrictType == eCityCenter then
				local pCity = Cities.GetPlotPurchaseCity(adjPlots[i]);
				if pCity:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_PALACE'].Index) then
					bFree = 1;
					break;
				end
			end
		end
	end
	if bFree == 1 then
		local unitList = Units.GetUnitsInPlot(iX, iY);
		for i, pUnit in ipairs(unitList) do
            local unitType = GameInfo.Units[pUnit:GetType()].UnitType
            if unitType == "UNIT_BUILDER" then
            	GameEvents.AddBuildCharge.Call(playerID, pUnit:GetID());
            	return
            end
        end
    end
end


function OnLoadScreenClose()
	for _, player in ipairs(PlayerManager.GetAliveMajors()) do
		local bNubia = player:GetProperty('PROP_FREE_PYRAMID_CHARGES') or 0;
		if bNubia ~= 0 then
			Events.ImprovementAddedToMap.Add( OnImprovementAddedToMap );
			break
		end
	end
end

Events.LoadScreenClose.Add(OnLoadScreenClose)
