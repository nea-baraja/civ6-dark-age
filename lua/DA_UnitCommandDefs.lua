
GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;


----CivilizationandLeaderHasTrait
function CivilizationHasTrait(sCiv, sTrait)
	for tRow in GameInfo.CivilizationTraits() do
		if (tRow.CivilizationType == sCiv and tRow.TraitType == sTrait) then
			return true
		end
	end
	return false
end

function LeaderHasTrait(sLeader, sTrait)
	for tRow in GameInfo.LeaderTraits() do
		if (tRow.LeaderType == sLeader and tRow.TraitType == sTrait) then return true end
	end
	return false
end


m_DAUnitCommands = {};
--[[ =======================================================================
	BUILDROAD

	Usable by Builders to Build road.
-- =========================================================================]]
m_DAUnitCommands.BUILDROAD = {};
m_DAUnitCommands.BUILDROAD.Properties = {};

-- UI Data
m_DAUnitCommands.BUILDROAD.EventName		= "DA_BuildRoads";
m_DAUnitCommands.BUILDROAD.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.BUILDROAD.Icon				= "ICON_UNITOPERATION_BUILD_ROUTE";
m_DAUnitCommands.BUILDROAD.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_BUILDROAD_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_BUILDROAD_DESCRIPTION");
m_DAUnitCommands.BUILDROAD.DisabledToolTipString = Locale.Lookup("LOC_UNITCOMMAND_BUILDROAD_DISABLED_TT");
m_DAUnitCommands.BUILDROAD.VisibleInUI	= true;


-- ===========================================================================
function m_DAUnitCommands.BUILDROAD.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	return GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_BUILDER";
	-- or GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_MILITARY_ENGINEER";
end

-- ===========================================================================
function m_DAUnitCommands.BUILDROAD.IsVisible(pUnit : object)
	local playerID = pUnit:GetOwner();
	local player = Players[playerID];
	local bResearchedWheel = player:GetTechs():HasTech(GameInfo.Technologies['TECH_THE_WHEEL'].Index);
	local iBuildRoad = pUnit:GetProperty('PROP_BUILDROAD_MODE');
	local bBuildRoadEnabled = (iBuildRoad ~= nil and iBuildRoad == 1);
	if bResearchedWheel and not bBuildRoadEnabled then
		return true;
	end
	return false;
end

-- ===========================================================================
function m_DAUnitCommands.BUILDROAD.IsDisabled(pUnit : object)
	if pUnit == nil or pUnit:GetBuildCharges() < 2 then
		return true;
	end
	return false;
end

--[[ =======================================================================
	RAMSES II FAITH BUILD WONDER

	Usable by Builders to Build road.
-- =========================================================================]]
m_DAUnitCommands.FAITHWONDER = {};
m_DAUnitCommands.FAITHWONDER.Properties = {};

-- UI Data
m_DAUnitCommands.FAITHWONDER.EventName		= "DA_FaithBuildWonder";
m_DAUnitCommands.FAITHWONDER.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.FAITHWONDER.Icon				= "ICON_UNITCOMMAND_WONDER_PRODUCTION";
m_DAUnitCommands.FAITHWONDER.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_FAITHWONDER_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_FAITHWONDER_DESCRIPTION");
m_DAUnitCommands.FAITHWONDER.DisabledToolTipString = Locale.Lookup("LOC_UNITCOMMAND_FAITHWONDER_DISABLED_TT");
m_DAUnitCommands.FAITHWONDER.VisibleInUI	= true;

-- ===========================================================================
function m_DAUnitCommands.FAITHWONDER.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	return GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_BUILDER";
	-- or GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_MILITARY_ENGINEER";
end

-- ===========================================================================
function m_DAUnitCommands.FAITHWONDER.IsVisible(pUnit : object)
	local playerID = pUnit:GetOwner();
	local player = Players[playerID];
	local bRamses = Utils.PlayerHasTrait(playerID, 'TRAIT_LEADER_RAMSES');
	if not bRamses then return false; end
	local iX, iY = pUnit:GetX(), pUnit:GetY();
	local pPlot = Map.GetPlot(iX, iY);
	local iWonder = pPlot:GetWonderType();
		--print(iWonder)
	if iWonder == nil or iWonder == -1 then return false; end
	local sWonder = GameInfo.Buildings[iWonder].BuildingType;
   	local pCity = Cities.GetPlotPurchaseCity(pPlot);
   	local pBuildings = pCity:GetBuildings();
   	if pBuildings:HasBuilding(iWonder) then return false; end
   	local sCurrent = Utils.GetCurrentlyBuilding(playerID, pCity:GetID());
   	--print(sCurrent)
   	if not sCurrent or sCurrent ~= sWonder then return false; end
   	return true;
end

-- ===========================================================================
function m_DAUnitCommands.FAITHWONDER.IsDisabled(pUnit : object)
	local playerID = pUnit:GetOwner();
	local player = Players[playerID];
	local iX, iY = pUnit:GetX(), pUnit:GetY();
	local pPlot = Map.GetPlot(iX, iY);
   	local pCity = Cities.GetPlotPurchaseCity(pPlot);
   	local sCurrent = Utils.GetCurrentlyBuilding(playerID, pCity:GetID());
   	local iCost = GameInfo.Buildings[sCurrent].Cost;
   	local iProductionProgress = pCity:GetBuildQueue():GetBuildingProgress( GameInfo.Buildings[sCurrent].Index );
   	local iRiverCount = pPlot:GetProperty('PROP_RIVER_COUNT') or 0;
   	local iFaithNeeded = (iCost - iProductionProgress) * 2 / (1 + iRiverCount * 0.1);
   	local iFaithBalance = player:GetReligion():GetFaithBalance();
   	if iFaithBalance < iFaithNeeded then return true; end
   	return false;
end



--[[
-- =======================================================================
	ui
	希腊，伯利克里，提洛同盟，伟人换使者，
-- =========================================================================
]]--
m_DAUnitCommands.GreatPersonGetEnvoys = {};
m_DAUnitCommands.GreatPersonGetEnvoys.Properties = {};

-- UI Data
m_DAUnitCommands.GreatPersonGetEnvoys.EventName		= "DA_GreatPersonGetEnvoys";
m_DAUnitCommands.GreatPersonGetEnvoys.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.GreatPersonGetEnvoys.Icon				= "GRANT_INFLUENCE_TOKEN";
m_DAUnitCommands.GreatPersonGetEnvoys.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_GREATPERSON_GETENVOYS_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_GREATPERSON_GETENVOYS_DESCRIPTION");
m_DAUnitCommands.GreatPersonGetEnvoys.DisabledToolTipString = Locale.Lookup("LOC_HASNOT_ADJACENT_MINOR_CIV");
m_DAUnitCommands.GreatPersonGetEnvoys.VisibleInUI	= true;



function m_DAUnitCommands.GreatPersonGetEnvoys.CanUse(pUnit : object)
	return true;
end

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

function m_DAUnitCommands.GreatPersonGetEnvoys.IsVisible(pUnit : object)
	if pUnit:GetMovementMovesRemaining() > 0 and pUnit:GetGreatPerson():IsGreatPerson() and pUnit:GetProperty('CAN_GET_ENVOY') == nil then
		local pUnitOwnerID = pUnit:GetOwner()
		if Utils.PlayerHasTrait(pUnitOwnerID,"TRAIT_LEADER_SURROUNDED_BY_GLORY") then
			local greatPersonID = pUnit:GetGreatPerson():GetIndividual()
			local greatPersonDetails = GameInfo.GreatPersonIndividuals[greatPersonID]
			local greatPersonType = greatPersonDetails.GreatPersonClassType
			for k,v in pairs(table_great_person_and_modifier) do
				if greatPersonType == k then
					return true
				end
			end
		end
	end
	--[[
	if pUnit:GetGreatPerson():IsGreatPerson() and pUnit:GetProperty('CAN_GET_ENVOY') == nil then
		local pUnitOwnerID = pUnit:GetOwner()
		if Utils.PlayerHasTrait(pUnitOwnerID,"TRAIT_LEADER_SURROUNDED_BY_GLORY") then
			local iX = pUnit:GetX()
			local iY = pUnit:GetY()
			local pPlot = Map.GetPlot(iX,iY)
			local pPlotOwnerID = pPlot:GetOwner()
			if pPlotOwnerID ~= -1 then
				local pPlotOwner = Players[pPlotOwnerID]
				local suzerainID = pPlotOwner:GetInfluence():GetSuzerain()
				if suzerainID == pUnitOwnerID then
					local pPlotOwnerTypeName = PlayerConfigurations[pPlotOwnerID]:GetLeaderTypeName()
					local pPlotOwnerTypeNameInfo = GameInfo.Leaders[pPlotOwnerTypeName]
					local greatPersonID = pUnit:GetGreatPerson():GetIndividual()
					local greatPersonDetails = GameInfo.GreatPersonIndividuals[greatPersonID]
					local greatPersonType = greatPersonDetails.GreatPersonClassType
					for k,v in pairs(table_great_person_and_modifier) do
						if k == greatPersonType and pPlotOwnerTypeNameInfo.InheritFrom == v then
							print("test")
							return true;
						end
					end
				end
			end
		end
	end
	]]--
	return false
end

function m_DAUnitCommands.GreatPersonGetEnvoys.IsDisabled(pUnit : object)
	local iX = pUnit:GetX()
	local iY = pUnit:GetY()
	local pPlot = Map.GetPlot(iX,iY)
	local pPlotOwnerID = pPlot:GetOwner()
	if pPlotOwnerID ~= -1 then
		local plotOwner = Players[pPlotOwnerID]
		local pPlotOwnerTypeName = PlayerConfigurations[pPlotOwnerID]:GetLeaderTypeName()
		local pPlotOwnerTypeNameInfo = GameInfo.Leaders[pPlotOwnerTypeName]
		
		for k,v in pairs(table_great_person_and_modifier) do
			if pPlotOwnerTypeNameInfo.InheritFrom == v then
				return false
			end
		end	
	end
	--[[
	local CanSelectPlot = {}
	for direction = 0, 5, 1 do
		local plot = Map.GetAdjacentPlot(iX, iY, direction)
		local pPlotOwnerID = plot:GetOwner()
		if pPlotOwnerID ~= -1 then
			local plotOwner = Players[pPlotOwnerID]
			local pPlotOwnerTypeName = PlayerConfigurations[pPlotOwnerID]:GetLeaderTypeName()
			local pPlotOwnerTypeNameInfo = GameInfo.Leaders[pPlotOwnerTypeName]
			for k,v in pairs(table_great_person_and_modifier) do
				if pPlotOwnerTypeNameInfo.InheritFrom == v then
					local plotindex = plot:GetIndex()
					table.insert(CanSelectPlot, plotindex)
				end
			end
		end
	end
	if #CanSelectPlot > 0 then
		return false
	end
	]]--
	return true
end

--[[
-- =======================================================================
	ui
	牺牲开拓者，换区域位，单元格
-- =========================================================================
]]--
m_DAUnitCommands.SettlerGetPlot = {};
m_DAUnitCommands.SettlerGetPlot.Properties = {};

-- UI Data
m_DAUnitCommands.SettlerGetPlot.EventName		= "DA_SettlerGetPlot";
m_DAUnitCommands.SettlerGetPlot.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.SettlerGetPlot.Icon				= "District";
m_DAUnitCommands.SettlerGetPlot.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_SETTLER_GETPLOT_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_SETTLER_GETPLOT_DESCRIPTION");
m_DAUnitCommands.SettlerGetPlot.DisabledToolTipString = Locale.Lookup("LOC_UNITCOMMAND_SETTLER_GETPLOT_DESCRIPTION_DISABLED");
m_DAUnitCommands.SettlerGetPlot.VisibleInUI	= true;



function m_DAUnitCommands.SettlerGetPlot.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	if pUnit:GetProperty('PROP_FRONTIER_TOWN') ~= nil and pUnit:GetProperty('PROP_FRONTIER_TOWN') > 0 then
		return GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_SETTLER";
	end
	return false;
end

function m_DAUnitCommands.SettlerGetPlot.IsVisible(pUnit : object)
	if pUnit:GetMovementMovesRemaining() > 0 then
		return true
	end
	return false
end

function m_DAUnitCommands.SettlerGetPlot.IsDisabled(pUnit : object)
	local iX = pUnit:GetX()
	local iY = pUnit:GetY()
	local pPlot = Map.GetPlot(iX,iY)
	local pPlotOwnerID = pPlot:GetOwner()
	local pUnitOwnerID = pUnit:GetOwner()
	if pPlotOwnerID ~= pUnitOwnerID then
		return true
	end
	local eDistrictType :number = pPlot:GetDistrictType()
	if eDistrictType == -1 then
		return true
	elseif GameInfo.Districts[eDistrictType].DistrictType == "DISTRICT_CITY_CENTER" then
		return false
	end
	return true
end

--[[
-- =======================================================================
	ui
	传教士造区域
-- =========================================================================
]]--
m_DAUnitCommands.MissionaryBuildDistricts = {};
m_DAUnitCommands.MissionaryBuildDistricts.Properties = {};

-- UI Data
m_DAUnitCommands.MissionaryBuildDistricts.EventName		= "DA_MissionaryBuildDistricts";
m_DAUnitCommands.MissionaryBuildDistricts.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.MissionaryBuildDistricts.Icon				= "District";
m_DAUnitCommands.MissionaryBuildDistricts.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_MISSIONARY_BUILD_DISTRICT_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_MISSIONARY_BUILD_DISTRICT_DESCRIPTION");
m_DAUnitCommands.MissionaryBuildDistricts.DisabledToolTipString = Locale.Lookup("LOC_UNIT_FAITHBUILDER_NO_DISTRICTS");
m_DAUnitCommands.MissionaryBuildDistricts.VisibleInUI	= true;

g_districtDetails = {}

function m_DAUnitCommands.MissionaryBuildDistricts.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	local PROP_TEMPLE_PRECINCT = pUnit:GetProperty('PROP_TEMPLE_PRECINCT') or 0;
	return (PROP_TEMPLE_PRECINCT ~= 0)
end

function m_DAUnitCommands.MissionaryBuildDistricts.IsVisible(pUnit : object)
	if pUnit:GetMovementMovesRemaining() > 0 then
		return true
	end
	return false
end

function m_DAUnitCommands.MissionaryBuildDistricts.IsDisabled(pUnit : object)
--获取单元格
    local pPlot = Map.GetPlot(pUnit:GetX(), pUnit:GetY())
    if pPlot == nil then
        return true, Locale.Lookup('LOC_UNIT_FAITHBUILDER_NO_DISTRICTS');
    end
    --获得区域id和城市对象
    local districtID, pCity = pPlot:GetDistrictID(), Cities.GetPlotPurchaseCity(pPlot:GetIndex());
    if districtID > 0 and pCity and pCity:GetOwner() == pUnit:GetOwner() then
        --获取区域对象
        local pDistrict = pCity:GetDistricts():FindID(districtID);
        --对象不存在或者区域已经完成
        if pDistrict == nil or pDistrict:IsComplete() then
            return true, Locale.Lookup('LOC_UNIT_FAITHBUILDER_NO_DISTRICTS');
        end
        --获取区域名、区域类型和区域名
        local districtType     = pDistrict:GetType();
        local districtInfo     = GameInfo.Districts[pDistrict:GetType()];
        local districtTypeName = districtInfo.DistrictType;
        local districtName     = districtInfo.Name;
        --判断城市当前正在进行的生产
        if  Utils.GetCurrentlyBuilding(pCity:GetOwner(), pCity:GetID()) == districtTypeName then
            local pPlayer      = Players[pUnit:GetOwner()];
            --获取信仰值消耗
            local faithCost    = Utils.GetDistrictCost(pCity:GetOwner(), pCity:GetID(), districtType) * 2;
            local iPlayerFaith = pPlayer:GetReligion():GetFaithBalance() or 0;
            if iPlayerFaith >= faithCost then
                --变更全局变量
                g_districtDetails.cityID   = pCity:GetID();
                g_districtDetails.TypeName = districtTypeName;
                g_districtDetails.Cost     = faithCost;
                return false;
            else
                return true, Locale.Lookup('LOC_UNIT_FAITHBUILDER_NO_FAITH', faithCost);
            end
        else
            return true, Locale.Lookup('LOC_UNIT_FAITHBUILDER_NO_DISTRICTS');
        end
    else
        return true, Locale.Lookup('LOC_UNIT_FAITHBUILDER_NO_DISTRICTS');
    end
    --return true, Locale.Lookup('LOC_UNIT_FAITHBUILDER_DISABLE_NO_UNIT');
end


--[[
-- =======================================================================
	ui
	使徒给区域相邻转信仰值
-- =========================================================================
]]--
m_DAUnitCommands.ApostleFaith = {};
m_DAUnitCommands.ApostleFaith.Properties = {};

-- UI Data
m_DAUnitCommands.ApostleFaith.EventName		= "DA_ApostleFaith";
m_DAUnitCommands.ApostleFaith.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.ApostleFaith.Icon				= "District";
m_DAUnitCommands.ApostleFaith.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_APOSTLE_FAITH_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_APOSTLE_FAITH_DESCRIPTION");
m_DAUnitCommands.ApostleFaith.DisabledToolTipString = Locale.Lookup("LOC_UNITCOMMAND_APOSTLE_FAITH_DISABLED");
m_DAUnitCommands.ApostleFaith.VisibleInUI	= true;

g_districtDetails = {}

function m_DAUnitCommands.ApostleFaith.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	local PROP_CONSECRATION = pUnit:GetProperty('PROP_CONSECRATION') or 0;
	return (PROP_CONSECRATION ~= 0)
end

function m_DAUnitCommands.ApostleFaith.IsVisible(pUnit : object)
	if pUnit:GetMovementMovesRemaining() > 0 then
		return true
	end
	return false
end

function m_DAUnitCommands.ApostleFaith.IsDisabled(pUnit : object)
--获取单元格
    local pPlot = Map.GetPlot(pUnit:GetX(), pUnit:GetY())
    if pPlot == nil then
        return true
    end
    --获得区域id和城市对象
    local districtID, pCity = pPlot:GetDistrictID(), Cities.GetPlotPurchaseCity(pPlot:GetIndex());
    if districtID > 0 and pCity and pCity:GetOwner() == pUnit:GetOwner() then
        --获取区域对象
        local pDistrict = pCity:GetDistricts():FindID(districtID);
        --对象不存在或者区域没有完成
        if pDistrict == nil or (not pDistrict:IsComplete()) then
            return true
        end

        if GameInfo.Districts[pDistrict:GetType()].DistrictType == 'DISTRICT_WONDER' then
        	return true;
        end
        if pPlot:GetProperty('PROP_CONSECRATION') ~= nil and pPlot:GetProperty('PROP_CONSECRATION') == 1 then
        	return true, 'LOC_UNITCOMMAND_APOSTLE_FAITH_USED'
        end


        return false;

        --获取区域名、区域类型和区域名
    else
        return true
    end
    
end


--[[
-- =======================================================================
	ui
	牺牲建造者，阿兹特克献祭
-- =========================================================================
]]--
m_DAUnitCommands.BuilderSaciifice = {};
m_DAUnitCommands.BuilderSaciifice.Properties = {};

-- UI Data
m_DAUnitCommands.BuilderSaciifice.EventName		= "DA_BuilderSaciifice";
m_DAUnitCommands.BuilderSaciifice.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.BuilderSaciifice.Icon				= "ICON_UNITOPERATION_EVANGELIZE_BELIEF";
m_DAUnitCommands.BuilderSaciifice.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_BUILDER_SACRIFICE_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_BUILDER_SACRIFICE_DESCRIPTION");
m_DAUnitCommands.BuilderSaciifice.DisabledToolTipString = Locale.Lookup("LOC_UNITCOMMAND_BUILDER_SACRIFICE_DISABLED");
m_DAUnitCommands.BuilderSaciifice.VisibleInUI	= true;



function m_DAUnitCommands.BuilderSaciifice.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	local pPlayer = Players[pUnit:GetOwner()];
	if pPlayer:GetProperty('BUILDER_SACRIFICE') ~= nil and pPlayer:GetProperty('BUILDER_SACRIFICE') > 0 then
		return GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_BUILDER";
	end
	return false;
end

function m_DAUnitCommands.BuilderSaciifice.IsVisible(pUnit : object)
	if pUnit:GetMovementMovesRemaining() > 0 then
		return true
	end
	return false
end

function m_DAUnitCommands.BuilderSaciifice.IsDisabled(pUnit : object)
	local iX = pUnit:GetX()
	local iY = pUnit:GetY()
	local pPlot = Map.GetPlot(iX,iY)
	local pPlotOwnerID = pPlot:GetOwner()
	local pUnitOwnerID = pUnit:GetOwner()
	if pPlotOwnerID ~= pUnitOwnerID then
		return true
	end
	local eDistrictType :number = pPlot:GetDistrictType()
	if eDistrictType == -1 then
		return true
	elseif GameInfo.Districts[eDistrictType].DistrictType == "DISTRICT_CITY_CENTER" then
		return false
	end
	return true
end

--[[
-- =======================================================================
	ui
	梁 基础设施 建造者花劳动力给地块加产出 食物
-- =========================================================================
]]--
m_DAUnitCommands.BuilderAddFood = {};
m_DAUnitCommands.BuilderAddFood.Properties = {};

-- UI Data
m_DAUnitCommands.BuilderAddFood.EventName		= "DA_BuilderAddFood";
m_DAUnitCommands.BuilderAddFood.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.BuilderAddFood.Icon				= "food";
m_DAUnitCommands.BuilderAddFood.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_BUILDER_ADDFOOD_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_BUILDER_ADDFOOD_DESCRIPTION");
m_DAUnitCommands.BuilderAddFood.DisabledToolTipString = Locale.Lookup("LOC_UNITCOMMAND_BUILDER_ADDFOOD_DISABLED_NOT_HOME");
m_DAUnitCommands.BuilderAddFood.VisibleInUI	= true;



function m_DAUnitCommands.BuilderAddFood.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	local pPlayer = Players[pUnit:GetOwner()];
	if pUnit:GetProperty('PROP_INFRASTRUCTURE') ~= nil and pUnit:GetProperty('PROP_INFRASTRUCTURE') > 0 then
		return GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_BUILDER";
	end
	return false;
end

function m_DAUnitCommands.BuilderAddFood.IsVisible(pUnit : object)
	if pUnit:GetMovementMovesRemaining() > 0 then
		return true
	end
	return false
end

function m_DAUnitCommands.BuilderAddFood.IsDisabled(pUnit : object)
	local iX = pUnit:GetX()
	local iY = pUnit:GetY()
	local pPlot = Map.GetPlot(iX,iY)
	local pPlotOwnerID = pPlot:GetOwner()
	local pUnitOwnerID = pUnit:GetOwner()
	if pPlotOwnerID ~= pUnitOwnerID then
		return true, Locale.Lookup('LOC_UNITCOMMAND_BUILDER_ADDFOOD_DISABLED_NOT_HOME')
	end
	local PROP_INFRASTRUCTURE = pPlot:GetProperty('PROP_INFRASTRUCTURE') or 0;
	if PROP_INFRASTRUCTURE == 1 then
		return true, Locale.Lookup('LOC_UNITCOMMAND_BUILDER_ADDFOOD_DISABLED_ENABLED')
	end
	return false;
end


--[[
-- =======================================================================
	ui
	梁 基础设施 建造者花劳动力给地块加产出 生产力
-- =========================================================================
]]--
m_DAUnitCommands.BuilderAddProd = {};
m_DAUnitCommands.BuilderAddProd.Properties = {};

-- UI Data
m_DAUnitCommands.BuilderAddProd.EventName		= "DA_BuilderAddProd";
m_DAUnitCommands.BuilderAddProd.CategoryInUI		= "SPECIFIC";
m_DAUnitCommands.BuilderAddProd.Icon				= "production";
m_DAUnitCommands.BuilderAddProd.ToolTipString	= Locale.Lookup("LOC_UNITCOMMAND_BUILDER_ADDPROD_NAME") .. "[NEWLINE][NEWLINE]" .. 
												Locale.Lookup("LOC_UNITCOMMAND_BUILDER_ADDPROD_DESCRIPTION");
m_DAUnitCommands.BuilderAddProd.DisabledToolTipString = Locale.Lookup("LOC_UNITCOMMAND_BUILDER_ADDPROD_DISABLED_NOT_HOME");
m_DAUnitCommands.BuilderAddProd.VisibleInUI	= true;



function m_DAUnitCommands.BuilderAddProd.CanUse(pUnit : object)
	if pUnit == nil then
		return false;
	end
	local pPlayer = Players[pUnit:GetOwner()];
	if pUnit:GetProperty('PROP_INFRASTRUCTURE') ~= nil and pUnit:GetProperty('PROP_INFRASTRUCTURE') > 0 then
		return GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_BUILDER";
	end
	return false;
end

function m_DAUnitCommands.BuilderAddProd.IsVisible(pUnit : object)
	if pUnit:GetMovementMovesRemaining() > 0 then
		return true
	end
	return false
end

function m_DAUnitCommands.BuilderAddProd.IsDisabled(pUnit : object)
	local iX = pUnit:GetX()
	local iY = pUnit:GetY()
	local pPlot = Map.GetPlot(iX,iY)
	local pPlotOwnerID = pPlot:GetOwner()
	local pUnitOwnerID = pUnit:GetOwner()
	if pPlotOwnerID ~= pUnitOwnerID then
		return true, Locale.Lookup('LOC_UNITCOMMAND_BUILDER_ADDPROD_DISABLED_NOT_HOME')
	end
	local PROP_INFRASTRUCTURE = pPlot:GetProperty('PROP_INFRASTRUCTURE') or 0;
	if PROP_INFRASTRUCTURE == 2 then
		return true, Locale.Lookup('LOC_UNITCOMMAND_BUILDER_ADDPROD_DISABLED_ENABLED')
	end
	return false;
end


