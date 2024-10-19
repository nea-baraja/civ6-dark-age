

ExposedMembers.GameEvents = GameEvents
Utils = ExposedMembers.DA.Utils;



--建造者建造区域的区域表
--DistrictID:string-区域的typename,必填
--DistrictToolTipString:string-ui按钮上的显示文本，可不填，默认为区域的name文本
--DistrictDisabled:function-按钮禁用的条件，可不填,（玩家id,单位id,单位坐标）均为数字型,
--PrereqTech:function-区域有所需科技,PrereqCivic-区域有所需市政,返回nil为无科技限制，true为数据库定义的区域所需科技，可不填
--DistrictEffect:function-按钮的额外自定义效果,默认效果会建造此区域,可不填,（玩家id,单位id,单位坐标）均为数字型
--DistrictIcon:string-按钮的图标,可不填,默认为区域原始图标
--CanRepeatBuild:function-可以重复建造，默认为false，可不填，isDistrict为true才会生效
--BuildCharge:function-需要的建造者劳动力次数,返回为大于零整数,默认为零,可不填
--isDistrict:bool-默认为true，false将不会执行建造区域的效果，可不填
--isHide:function-判断是否显示在ui里，默认为false,
--MutuallyExclusiveDistricts:function-互斥区域，isDistrict为true才会生效，可不填，需返回table,返回nil为无互斥区域，true为数据库定义的互斥区域，
--PlaceOnWater:bool-默认为false,判断区域是否放置于水上
------------------------------------------------------------------
--
Utils.CanBuildDistricts = {
	{
		DistrictID = "DISTRICT_REPAIR",
		DistrictToolTipString = "LOC_UNITOPERATION_REPAIR_DESCRIPTION",
		DistrictDisabled = function(playerID,unitID,iX,iY)
			if Utils.DistrictIsPillaged(iX, iY) then
				return false
			end
			local buildingsAtPlot = Utils.GetBuildingsAtPlot(iX, iY)
			for _, building in ipairs(buildingsAtPlot) do
				if building.isPillaged then
					return false
				end
			end
			return true
		end,
		DistrictEffect = function(playerID,unitID,iX,iY)
			local pPlot = Map.GetPlot(iX, iY)
			local pCity = Cities.GetPlotPurchaseCity(pPlot)
			local pBuildings = pCity:GetBuildings()
			local pDistrict = pCity:GetDistricts():GetDistrictAtLocation(iX,iY)
			pDistrict:SetPillaged(false)
			local buildingsAtPlot = Utils.GetBuildingsAtPlot(iX, iY)
			for _, building in ipairs(buildingsAtPlot) do
				if building.isPillaged then
					pBuildings:SetPillaged(building.type, false)
				end
			end
		end,
		DistrictIcon = "ICON_UNITOPERATION_REPAIR",
		isDistrict = false,
		BuildCharge = function(playerID,unitID,iX,iY)
			return 1
		end,
		
	},
	{
		DistrictID = "DISTRICT_AQUEDUCT",
		DistrictDisabled = function(playerID,unitID,iX,iY)
			local pPlot = Map.GetPlot(iX, iY)
			if pPlot:IsRiver() then
				return false
			end
			for direction = 1, 6, 1 do
				local pPlot = Map.GetAdjacentPlot(iX, iY, direction)
				if pPlot:IsLake() or pPlot:IsMountain() then
					return false
				end
				local pPlotFeatureType = pPlot:GetFeatureType()
				if(pPlotFeatureType == GameInfo.Features["FEATURE_OASIS"].Index) then
					return false
			    end
			end
			return true 
		end,
		PrereqTech = function(playerID,unitID,iX,iY)
			return true
		end,
		BuildCharge = function(playerID,unitID,iX,iY)
			local pPlayer = Players[playerID]
			local iCharge = 0;
			if pPlayer ~= nil and pPlayer:GetProperty('ZHENGGUO_SALE_AQUEDUCT') == 1 then
				iCharge = 2;
			else
				iCharge = 3;
			end
			if pPlayer:GetProperty('PROP_ABILITY_CHINA') == 1 then
				iCharge = 1;
			end
			return iCharge;
		end,
	},
	{
		DistrictID = "DISTRICT_BATH",
		DistrictDisabled = function(playerID,unitID,iX,iY)
			local CIVIC_GAMES_RECREATION_INDEX = GameInfo.Civics['CIVIC_GAMES_RECREATION'].Index 
			local TECH_ENGINEERING_INDEX = GameInfo.Technologies['TECH_ENGINEERING'].Index 

			if (not Players[playerID]:GetCulture():HasCivic(CIVIC_GAMES_RECREATION_INDEX))
				and (not Players[playerID]:GetTechs():HasTech(TECH_ENGINEERING_INDEX)) then
				return true;
			end
			local pPlot = Map.GetPlot(iX, iY)
			if pPlot:IsRiver() then
				return false
			end
			for direction = 1, 6, 1 do
				local pPlot = Map.GetAdjacentPlot(iX, iY, direction)
				if pPlot:IsLake() or pPlot:IsMountain() then
					return false
				end
				local pPlotFeatureType = pPlot:GetFeatureType()
				if(pPlotFeatureType == GameInfo.Features["FEATURE_OASIS"].Index) then
					return false
			    end
			end
			return true 
		end,
		-- PrereqTech = function(playerID,unitID,iX,iY)
		-- 	return true
		-- end,
		BuildCharge = function(playerID,unitID,iX,iY)
			local pPlayer = Players[playerID]
			if pPlayer ~= nil and pPlayer:GetProperty('ZHENGGUO_SALE_AQUEDUCT') == 1 then
				return 1;
			else
				return 2;
			end
		end,
	},
	--堤坝
	{
		DistrictID = "DISTRICT_DAM",
		DistrictDisabled = function(playerID,unitID,iX,iY)
			local pPlot = Map.GetPlot(iX, iY);
			if pPlot:GetRiverCrossingCount() < 2 then
				return true;
			end
			return false;
		end,
		PrereqTech = function(playerID,unitID,iX,iY)
			return true
		end,
		BuildCharge = function(playerID,unitID,iX,iY)
			local pPlayer = Players[playerID]
			if pPlayer ~= nil and pPlayer:GetProperty('PROP_ABILITY_CHINA') == 1 then
				return 1;
			else
				return 4;
			end
		end,
	},
	--{
	-- 	DistrictID = "DISTRICT_WATER_ENTERTAINMENT_COMPLEX",
	-- 	MutuallyExclusiveDistricts = function(playerID,unitID,iX,iY)
	--		return true
	-- 	end,
	-- 	PlaceOnWater = true,
	--},
	--{
	-- 	DistrictID = "DISTRICT_ENTERTAINMENT_COMPLEX",
	-- 	MutuallyExclusiveDistricts = function(playerID,unitID,iX,iY)
	--		return true
	-- 	end,
	--},
	-- {
	-- 	DistrictID = "DISTRICT_CAMPUS",
	-- },
}


ExposedMembers.DA.Utils = Utils

-- function l(object) 
-- 	print("Attributes:") 
-- 	for k, v in pairs(getmetatable(object).__index) do 
-- 		print(k); 
-- 	end;
-- 	print("End attributes."); 
-- end

-- l() 

-- function p(table) 
-- 	for k, v in pairs(table) do 
-- 		print(k); 
-- 	end; 
-- end
