include "SupportFunctions"
GameEvents = ExposedMembers.GameEvents
Utils = ExposedMembers.DA.Utils


--------------------by 枫叶&nea_baraja---------------------

function GetValidPlotsInRadiusR(iPlotX, iPlotY, iRadius)
	local tTempTable = {}
	for dx = (iRadius * -1), iRadius do
		for dy = (iRadius * -1), iRadius do
			local pNearPlot = Map.GetPlotXYWithRangeCheck(iPlotX, iPlotY, dx, dy, iRadius)
			if pNearPlot then
				table.insert(tTempTable, pNearPlot)
			end
		end
	end
	return tTempTable;
end

--阿尔特密斯神庙给6环送营地
function OnCityProdComp_ArtemisBuildCamps(playerID, cityID, iConstructionType, itemID, bCancelled)
	
	if iConstructionType ~= 1 then return; end
	if itemID ~= GameInfo.Buildings['BUILDING_TEMPLE_ARTEMIS'].Index then return; end

	local pCity = CityManager.GetCity(playerID, cityID);
	local pPlayer = Players[playerID];

	--local pCityBuildings = pCity:GetBuildings()

	local iX = pCity:GetX();
	local iY = pCity:GetY();
	local tPlots = GetValidPlotsInRadiusR(iX, iY, 6);
	-- local iForest = GameInfo.Features['FEATURE_FOREST'].Index;
	-- local iJungle = GameInfo.Features['FEATURE_JUNGLE'].Index;
	local iCamp = GameInfo.Improvements["IMPROVEMENT_CAMP"].Index;
	local campCount = 0;
	
	for k, pPickPlot in ipairs(tPlots) do
		local bValid = false
		local iResource = pPickPlot:GetResourceType();
		if pPickPlot:GetOwner() == playerID and pPickPlot:GetImprovementType() == -1 and pPickPlot:GetDistrictType() == -1 then
			if iResource ~= -1 and pPlayer:GetResources():IsResourceVisible(iResource) then
				for row in GameInfo.Improvement_ValidResources() do
					if row.ImprovementType == 'IMPROVEMENT_CAMP' and row.ResourceType == GameInfo.Resources[iResource].ResourceType then
						bValid = true;
						break;
					end
				end
			else
				local iFeature = pPickPlot:GetFeatureType();
				if iFeature ~= -1 then
					for row in GameInfo.Improvement_ValidFeatures() do
						if row.ImprovementType == 'IMPROVEMENT_CAMP' and row.FeatureType == GameInfo.Features[iFeature].FeatureType then
							bValid = true;
							break;
						end
					end
				else
					local iTerrain = pPickPlot:GetTerrainType();
					for row in GameInfo.Improvement_ValidTerrains() do
						if row.ImprovementType == 'IMPROVEMENT_CAMP' and row.TerrainType == GameInfo.Terrains[iTerrain].TerrainType then
							bValid = true;
							break;
						end
					end
				end
			end

			if bValid then
				campCount = campCount + 1
				--因为不在da里所以暂时不设置改良  --现在在了
				GameEvents.SetPlotImprovement.Call(pPickPlot:GetIndex(), iCamp, playerID);
			end
		end
		if pPickPlot:GetImprovementType() == iCamp then
			campCount = campCount + 1
		end
	end

	print("campCount=" .. campCount)

	local strengthBuffCount = 0
	if campCount <= 3 then
		strengthBuffCount = 1
	else
		strengthBuffCount = math.floor(campCount/3.0)
	end
	print("strengthBuffCount=" .. strengthBuffCount)


	--print("001")

	--执行送单位  见Misc.lua
	UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, {
		OnStart = 'DA_Artemis_Grant_Unit',
		X = iX,
		Y = iY,
		Strength = strengthBuffCount
	})
	--print("002")
	Events.ImprovementAddedToMap.Add( OnImprovementAddedToMap );
end


--阿尔特密斯神庙建造营地返还劳动力
function OnImprovementAddedToMap( iX, iY, eImprovement, playerID )
	local iCamp = GameInfo.Improvements["IMPROVEMENT_CAMP"].Index;
	if playerID == nil then return end
	local pPlayer = Players[playerID];
	if pPlayer == nil then return end
	local bArtemis = pPlayer:GetProperty('PROP_ARTEMIS') or 0;
	if bArtemis == 0 then return end
	local pPlot = Map.GetPlot(iX, iY);
	if pPlot == 0 then return end


	if eImprovement == iCamp then
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


function OnLoadScreenClose_Artemis()
	for _, player in ipairs(PlayerManager.GetAliveMajors()) do
		local bArtemis = player:GetProperty('PROP_ARTEMIS') or 0;
		if bArtemis ~= 0 then
			Events.ImprovementAddedToMap.Add( OnImprovementAddedToMap );
			break
		end
	end
end

Events.LoadScreenClose.Add(OnLoadScreenClose_Artemis)


--神谕返还伟人点数50%的信仰值  --copied from hd
function UnitGreatPersonCreatedWatOracle(playerId, unitId, greatPersonClassId, greatPersonIndividualId)
	local iOracle = GameInfo.Buildings['BUILDING_ORACLE'].Index;
	local player = Players[playerId];
    if Utils.PlayerHasWonder (playerId, iOracle) then
        local greatPerson = GameInfo.GreatPersonIndividuals[greatPersonIndividualId];
        local era = GameInfo.Eras[greatPerson.EraType];
        local cost = era.GreatPersonBaseCost;
        local percent = 100 / 100; --变现比例
        GameEvents.RequestChangeFaithBalance.Call(playerId, cost * percent);
    end
end

Events.UnitGreatPersonCreated.Add(UnitGreatPersonCreatedWatOracle);

--金字塔让工人永不安息
function BuilderResumeWithPryamid(playerID, unitID, newCharges, oldCharges)
	local iPryamid = GameInfo.Buildings['BUILDING_PYRAMIDS'].Index;
	if not Utils.PlayerHasWonder (playerID, iPryamid) then return; end
	local player = Players[playerID];
	local unit = player:GetUnits():FindID(unitID)
	if unit ~= nil and unit:GetType() == GameInfo.Units['UNIT_BUILDER'].Index and newCharges + 1 == oldCharges then
		GameEvents.RestoreUnitMovement.Call(playerID, unitID);
	end
end

Events.LoadGameViewStateDone.Add(function()
	Events.UnitChargesChanged.Add(BuilderResumeWithPryamid);
end)

--艾特曼安吉神庙 遇见主要文明+2科技 遇到城邦+1科技
function DA_EtemenankiMeet(playerID1, playerID2)
	print(playerID1..'met'..playerID2)
	local pPlayer1 = Players[playerID1];
	local pPlayer2 = Players[playerID2];
	local iEtemenanki = GameInfo.Buildings['BUILDING_ETEMENANKI'].Index;
	if not (Utils.PlayerHasWonder (playerID1, iEtemenanki) or Utils.PlayerHasWonder (playerID2, iEtemenanki)) then return; end
	if pPlayer1:IsMajor() == true and pPlayer2:IsMajor() == true then	
		for _, city in pPlayer1:GetCities():Members() do
			if city:GetBuildings():HasBuilding(iEtemenanki) then
				GameEvents.CityAttachModifierByID.Call(playerID1, city:GetID(), 'ETEMENANKI_CAMP_MAIN_CIV_TECH');
			end
		end
		for _, city in pPlayer2:GetCities():Members() do
			if city:GetBuildings():HasBuilding(iEtemenanki) then
				GameEvents.CityAttachModifierByID.Call(playerID2, city:GetID(), 'ETEMENANKI_CAMP_MAIN_CIV_TECH');
			end
		end
	end
	if pPlayer1:IsMajor() == true then
		if Utils.IsMinor(playerID2) == true then
			for _, city in pPlayer1:GetCities():Members() do
				if city:GetBuildings():HasBuilding(iEtemenanki) then
					GameEvents.CityAttachModifierByID.Call(playerID1, city:GetID(), 'ETEMENANKI_CAMP_CITYSTATE_TECH');
				end
			end
		end
	end	
	if pPlayer2:IsMajor() == true then
		if Utils.IsMinor(playerID1) then
			for _, city in pPlayer2:GetCities():Members() do
				if city:GetBuildings():HasBuilding(iEtemenanki) then
					GameEvents.CityAttachModifierByID.Call(playerID2, city:GetID(), 'ETEMENANKI_CAMP_CITYSTATE_TECH');
				end
			end
		end
	end			
end
Events.DiplomacyMeet.Add(DA_EtemenankiMeet)

function OnCityProdComp_Etemanki(playerID, cityID, iConstructionType, itemID, bCancelled)
	if iConstructionType ~= 1 then return; end
	if itemID ~= GameInfo.Buildings['BUILDING_ETEMENANKI'].Index then return; end

	local pCity = CityManager.GetCity(playerID, cityID);
	local pPlayer = Players[playerID];
	for _, player in ipairs(PlayerManager.GetAliveMajors()) do
		if playerID ~= player:GetID() then
			if player:GetDiplomacy():HasMet(playerID) then
				GameEvents.CityAttachModifierByID.Call(playerID, cityID, 'ETEMENANKI_CAMP_MAIN_CIV_TECH');
				print(playerID..'met'..player:GetID())
			end
		end
	end
	for _, player in ipairs(PlayerManager.GetAliveMinors()) do
		if playerID ~= player:GetID() and player:GetID() ~= 62 then
			if player:GetDiplomacy():HasMet(playerID) then
				GameEvents.CityAttachModifierByID.Call(playerID, cityID, 'ETEMENANKI_CAMP_CITYSTATE_TECH');
				print(playerID..'met'..player:GetID())
			end
		end
	end
end




--大浴场触发事件
function GreatBathEventOccurred(type:number, severity:number, plotx:number, ploty:number, mitigationLevel:number, randomEventID:number, gameCorePlaybackEventID:number) 
	local sEvent = GameInfo.RandomEvents[type].RandomEventType;
	local iGreatBath = GameInfo.Buildings['BUILDING_GREAT_BATH'].Index;
	if string.find(sEvent, 'FLOOD') ==nil then return; end
	--if type ~= 34 then return; end
	for i, PlayerID in ipairs(PlayerManager.GetWasEverAliveMajorIDs()) do
		if Utils.PlayerHasWonder (PlayerID, iGreatBath) then
			local dist = 4
			local pPlayerCities = Players[PlayerID]:GetCities()
			for i, pCity in pPlayerCities:Members() do
            	local CityHasBath = pCity:GetBuildings():HasBuilding(iGreatBath);
            	if CityHasBath then
            		local location = Map.GetPlotByIndex(Utils.GetBuildingLocation(PlayerID, pCity:GetID(), iGreatBath));
					local iDistance = Map.GetPlotDistance(location:GetX(), location:GetY(), pCity:GetX(), pCity:GetY());
					if (iDistance < dist) then
    					GameEvents.TriggerCommonEvent.Call(PlayerID, 'EVENT_COMMON_GREAT_BATH_FLOOD', {CityId = pCity:GetID()});
					end
					break;
				end
			end
			break;
		end
	end
end

Events.RandomEventOccurred.Add(GreatBathEventOccurred)

--兵马俑
function OnCityProdComp_TerraCotta(playerID, cityID, iConstructionType, itemID, bCancelled)
	if iConstructionType ~= 1 then return; end
	if itemID ~= GameInfo.Buildings['BUILDING_TERRACOTTA_ARMY'].Index then return; end

	local pCity = CityManager.GetCity(playerID, cityID);
	local pPlayer = Players[playerID];
	local iLandUnitCount = 0;
	for i, pUnit in pPlayer:GetUnits():Members() do
		local iCombat = GameInfo.Units[pUnit:GetType()].Combat;
		local sDomain = GameInfo.Units[pUnit:GetType()].Domain;	
		if iCombat > 0 and sDomain == 'DOMAIN_LAND' then
			iLandUnitCount = iLandUnitCount + 1;
		end
	end
	for i=1,iLandUnitCount do
		GameEvents.CityAttachModifierByID.Call(playerID, cityID, 'TERRACOTTA_ARMY_ADD_CULTURE');
	end
end

--宙斯像
function OnCityProdComp_StatueOfZeus(playerID, cityID, iConstructionType, itemID, bCancelled)
	if iConstructionType ~= 1 then return; end
	if itemID ~= GameInfo.Buildings['BUILDING_STATUE_OF_ZEUS'].Index then return; end

	local pCity = CityManager.GetCity(playerID, cityID);
	local pPlayer = Players[playerID];
	local iLandExpCount = 0;
	for i, pUnit in pPlayer:GetUnits():Members() do
		local iCombat = GameInfo.Units[pUnit:GetType()].Combat;
		local sDomain = GameInfo.Units[pUnit:GetType()].Domain;	
		if iCombat > 0 and sDomain == 'DOMAIN_LAND' then
			local pExperience = pUnit:GetExperience();
    		if (pExperience ~= nil) then
        		local promotionList :table = pExperience:GetPromotions();
				iLandExpCount = iLandExpCount + #promotionList;
			end
		end
	end
	for i=1,iLandExpCount do
		GameEvents.CityAttachModifierByID.Call(playerID, cityID, 'STATUE_OF_ZEUS_ADD_SCIENCE');
	end
end

--大图书馆 招募大科学家触发对应时代鼓舞  感谢hd开源
local SCIENTIST_INDEX = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_SCIENTIST"].Index;
function GreatLibraryUnitGreatPersonCreated(playerId, unitId, greatPersonClassId, greatPersonIndividualId)
	local player = Players[playerId];
    if (greatPersonClassId == SCIENTIST_INDEX) and (player:GetProperty('PROP_GREAT_LIBRARY') ~= nil) then
        local greatPerson = GameInfo.GreatPersonIndividuals[greatPersonIndividualId];
		GameEvents.PlayerAttachModifierByID.Call(playerId, 'GRANT_TECH_' .. greatPerson.EraType .. '_BOOST');
    end
end




function Initialize()
	Events.CityProductionCompleted.Add( OnCityProdComp_ArtemisBuildCamps );
	Events.CityProductionCompleted.Add( OnCityProdComp_TerraCotta );
	Events.CityProductionCompleted.Add( OnCityProdComp_StatueOfZeus );
	Events.CityProductionCompleted.Add(OnCityProdComp_Etemanki)
	Events.UnitGreatPersonCreated.Add(GreatLibraryUnitGreatPersonCreated);
end
Events.LoadGameViewStateDone.Add(Initialize)
--print("DA artemis ui script activated!");
