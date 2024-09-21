include("SupportFunctions")

GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils

function AmenityPropertyManager(playerID, cityID)
	local player = Players[playerID]
    local pCity = CityManager.GetCity(playerID, cityID)
    if pCity == nil then 
    	return 
    end
    local cityX = pCity:GetX()
    local cityY = pCity:GetY()
    local CityPlot = Map.GetPlot(cityX, cityY)
    local plotID = CityPlot:GetIndex()
    local pCityGrowth = pCity:GetGrowth()
    local pAmenity = pCityGrowth:GetAmenities() - pCityGrowth:GetAmenitiesNeeded()
    local PROP_AMENITY = 'CITY_AMENITY'

    if pAmenity ~= nil then 
    	GameEvents.SetPlotProperty.Call(plotID, PROP_AMENITY, pAmenity)
    --	print(playerID..':'..cityID..':amenity is '..Utils.GetPlotProperty(CityPlot, PROP_AMENITY))
    end
end

function SpecialistManager(playerID)
    local player = Players[playerID]
    for _, district in player:GetDistricts():Members() do
    	local districtPlot:table = Map.GetPlot(district:GetX(), district:GetY())
    	local plotID = districtPlot:GetIndex()
    	local citizens = districtPlot:GetWorkerCount()
    	local PROP_WORKER_COUNT = 'WORKER_COUNT'
        --市中心那个工人不能算进去
        if GameInfo.Districts[district:GetType()].DistrictType ~= 'DISTRICT_CITY_CENTER' then 
    	   GameEvents.SetPlotProperty.Call(plotID, PROP_WORKER_COUNT, citizens); 
            --print(playerID..' district worker count is '..Utils.GetPlotProperty(districtPlot, PROP_WORKER_COUNT))
        end
    end
end

function AdjacencyManager(playerID)
    local player = Players[playerID]
    local pCityDistricts = player:GetDistricts()
    local kTempDistrictYields :table = {}
    local PROP_ADJANCENCY = 'ADJACENCY_'
    for yield in GameInfo.Yields() do
        kTempDistrictYields[yield.Index] = yield
    end
    for i, district in pCityDistricts:Members() do 
        local districtPlot:table = Map.GetPlot(district:GetX(), district:GetY())
        local plotID = districtPlot:GetIndex()	
        for j,yield in ipairs( kTempDistrictYields ) do

            GameEvents.SetPlotProperty.Call(plotID, PROP_ADJANCENCY..yield.YieldType , district:GetAdjacencyYield(j))
        end
    end
end

function GarrisonManager(playerID)
    local player = Players[playerID]
    local pCityDistricts = player:GetDistricts()

    for i, district in pCityDistricts:Members() do 
        local districtPlot:table = Map.GetPlot(district:GetX(), district:GetY())
        local plotID = districtPlot:GetIndex()  
        if Utils.IsDistrictOrUD(GameInfo.Districts[district:GetType()].DistrictType, 'DISTRICT_ENCAMPMENT') 
            or Utils.IsDistrictOrUD(GameInfo.Districts[district:GetType()].DistrictType, 'DISTRICT_CITY_CENTER') then
            local targetUnits :table = Map.GetUnitsAt(districtPlot);
            if targetUnits ~= nil then
                local iMaxLevel = 1;
                for pTargetUnit :object in targetUnits:Units() do
                    if(pTargetUnit:GetOwner() == playerID) then
                        local iLevel = pTargetUnit:GetExperience():GetLevel();
                        if iLevel > iMaxLevel then
                            iMaxLevel = iLevel;
                        end
                    end
                end

                GameEvents.SetPlotProperty.Call(plotID, 'GARRISON_LEVEL', iMaxLevel - 1)
            end
        end
    end
end

  
-- function GovernmentLegacyManager(playerID)
--     local player = Players[playerID]
--     local govID = player:GetCulture():GetCurrentGovernment()
--     -- print(govID)
--     if(govID == nil or govID == -1) then
--         return 
--     end
--     local govType = GameInfo.Governments[govID].GovernmentType 
--     --print(playerID..'gov:'..govType)
--     if govType == 'GOVERNMENT_OLIGARCHY' then
--         for _, city in player:GetCities():Members() do
--             local cityX = city:GetX()
--             local cityY = city:GetY()
--             local CityPlot = Map.GetPlot(cityX, cityY)
--             local plotID = CityPlot:GetIndex()
--             GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_OLIGARCHY_LEGACY', 1)
--             GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_AUTOCRACY_LEGACY', 0)
--             GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY', 0)
--         end
--     elseif govType == 'GOVERNMENT_AUTOCRACY' then
--         for _, city in player:GetCities():Members() do
--             local cityX = city:GetX()
--             local cityY = city:GetY()
--             local CityPlot = Map.GetPlot(cityX, cityY)
--             local plotID = CityPlot:GetIndex()
--             GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_OLIGARCHY_LEGACY', 0)
--             GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_AUTOCRACY_LEGACY', 1)
--             GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY', 0)
--         end
--     elseif govType == 'GOVERNMENT_CLASSICAL_REPUBLIC' then
--         for _, city in player:GetCities():Members() do
--             local cityX = city:GetX()
--             local cityY = city:GetY()
--             local CityPlot = Map.GetPlot(cityX, cityY)
--             local plotID = CityPlot:GetIndex()
--             GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_OLIGARCHY_LEGACY', 0)
--             GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_AUTOCRACY_LEGACY', 0)
--             GameEvents.SetPlotProperty.Call(plotID, 'PROP_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY', 1)
--         end     
--     end
-- end



function OnTurnBegin()
	local players = Game.GetPlayers{Alive = true};
	for _, player in ipairs(players) do
		SpecialistManager(player:GetID())
        AdjacencyManager(player:GetID())
        --GovernmentLegacyManager(player:GetID())
		for _, city in player:GetCities():Members() do
			AmenityPropertyManager(player:GetID(), city:GetID())
		end
	end
end



function OnTurnEnd()
    local players = Game.GetPlayers{Alive = true};
    for _, player in ipairs(players) do

        GarrisonManager(player:GetID())
        --GovernmentLegacyManager(player:GetID())
        -- for _, city in player:GetCities():Members() do
        --     AmenityPropertyManager(player:GetID(), city:GetID())
        -- end
    end
end


Events.TurnEnd.Add(OnTurnEnd);
Events.TurnBegin.Add(OnTurnBegin);
Events.CityAddedToMap.Add(AmenityPropertyManager)





    
function GovernmentChanged(playerID)
    local player = Players[playerID]
    local govID = player:GetCulture():GetCurrentGovernment()
    if govID ==nil or govID == -1 then return; end
    local govType = GameInfo.Governments[govID].GovernmentType
    --OligarchyCitizenFoodCostRefresh(playerID,   govType)
    --GovernmentLegacyManager(playerID)
end

Events.GovernmentChanged.Add(GovernmentChanged)

function OligarchyOnTurnBegin()
    -- local players = Game.GetPlayers{Alive = true};
    -- for _, player in ipairs(players) do
    --     local govID = player:GetCulture():GetCurrentGovernment()
    --     if(govID ~= -1 and govID ~= nil) then
    --         local govType = GameInfo.Governments[govID].GovernmentType
    --         for _, city in player:GetCities():Members() do
    --             OligarchyCitizenFoodCostRefresh(player:GetID(),   govType)
    --         end
    --     end
    -- end
end


Events.TurnBegin.Add(OligarchyOnTurnBegin);

--独裁为区域专家加2粮消耗   --现在改掉了 降人口增速就好
function OligarchyCitizenFoodCostRefresh(playerID,  govType)
    -- local pPlayer = Players[playerID]
    -- -- local bCaeserOligarchy = pPlayer:GetProperty('TRAIT_LEADER_CAESAR') and pPlayer:GetProperty("pPlayerAllGovernment") ~= nil and pPlayer:GetProperty("pPlayerAllGovernment")[-1]
    -- if govType == 'GOVERNMENT_OLIGARCHY' then
    --     for _, city in pPlayer:GetCities():Members() do
    --         local pBuildings = city:GetBuildings()
    --         local pDistricts = city:GetDistricts()
    --         for row in GameInfo.DistrictCitizenYields() do
    --             if(row.Id == 'OLIGARCHY_FOOD_COST') then
    --                 BuildingInfo = GameInfo.Buildings[row.BuildingType]
    --                 DistrictInfo = GameInfo.Districts[row.DistrictType]
    --                 if((not pBuildings:HasBuilding(BuildingInfo.Index)) and  pDistricts:HasDistrict(DistrictInfo.Index)) then
    --                     GameEvents.RequestCreateBuilding.Call(playerID,  city:GetID(),   BuildingInfo.Index)
    --                 end
    --             end
    --         end
    --     end
    -- else
    --     for _, city in pPlayer:GetCities():Members() do
    --         local pBuildings = city:GetBuildings()
    --         local pDistricts = city:GetDistricts()
    --         for row in GameInfo.DistrictCitizenYields() do
    --             if(row.Id == 'OLIGARCHY_FOOD_COST') then
    --                 BuildingInfo = GameInfo.Buildings[row.BuildingType]
    --                 DistrictInfo = GameInfo.Districts[row.DistrictType]
    --                 if pBuildings:HasBuilding(BuildingInfo.Index) then
    --                     GameEvents.RequestRemoveBuilding.Call(playerID,  city:GetID(),   BuildingInfo.Index)
    --                 end
    --             end
    --         end
    --     end
    -- end
end




-- function CivicCompletedInitialPolicy( player:number, civic:number, isCanceled:boolean)
--     local pPlayer = Players[player];
--     if pPlayer == nil then return; end
--     local sCivic = GameInfo.Civics[civic].CivicType;
--     -- print(sCivic)
--     if sCivic == 'CIVIC_CODE_OF_LAWS' or sCivic == 'CIVIC_NATIVE_LAND' or sCivic == 'CIVIC_SORCERY_AND_HERB' then
--         local iPolicy1, iPolicy2, iPolicy3, iPolicy4 =
--         GameInfo.Policies['POLICY_DISCIPLINE'].Index, GameInfo.Policies['POLICY_GOD_KING'].Index, 
--         GameInfo.Policies['POLICY_SURVEY'].Index, GameInfo.Policies['POLICY_URBAN_PLANNING'].Index;
--        -- GameEvents.UnlockPolicy.Call(iPolicy1);
--         GameEvents.UnlockPolicy.Call(iPolicy2);
--         GameEvents.UnlockPolicy.Call(iPolicy3);
--       --  GameEvents.UnlockPolicy.Call(iPolicy4);
--     end
-- end


-- Events.CivicCompleted.Add(CivicCompletedInitialPolicy);







