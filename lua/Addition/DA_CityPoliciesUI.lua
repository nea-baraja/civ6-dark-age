-- DA_CityPoliciesUI
-- Author: 皮皮凯
-- Time: 2023-07-06T14:20:30.000Z
------------------------------------------
include("InstanceManager");
include("SupportFunctions");
include("EspionageViewManager");

include( "SupportFunctions" ); -- Round(必要)tostring(kEntry.Amount)
GameEvents = ExposedMembers.GameEvents;

local m_kPowerBreakdownIM:table = InstanceManager:new( "PowerLineInstance",	"Top");
local m_KeyStackIM:table = InstanceManager:new( "KeyEntry", "KeyColorImage", Controls.KeyStack );
local m_CityPolicies1IM:table = InstanceManager:new( "PKCityPoliciesLevel1", "Root", Controls.CityPolicies );
local m_CityPolicies2IM:table = InstanceManager:new( "PKCityPoliciesLevel2", "Root");
local m_CityPolicies3IM:table = InstanceManager:new( "PKCityPoliciesLevel3", "Level3");


local m_kEspionageViewManager = EspionageViewManager:CreateManager();

--CityPolicy：城市政策的名称，
--PolicyClass：城市政策的分类，
--BuildingType：城市送的建筑？。
--EnableProjectType：启用该政策的项目类型。
--DisableProjectType：禁用该政策的项目类型。
--EnableCivicType：该政策启用的前置公民政策
--EnableTechType：该政策启用的前置科技
--EnableCost：启用该政策的花费
--DisableCost：禁用该政策的花费。
--PreDistrict：启用该政策的前置区域。
--PreBuilding：启用该政策的前置建筑。

function CityPolicyCreateTable()
	local DACityPolicys = {};
	print("---+++++++++++++++++++---")
	for row in GameInfo.CityPolicies() do
		--皮凯：目前这个表还是杂乱的，因为我没有改动DA数据库
		local DACityPolicy = {
			Name = "LOC_" ..row.BuildingType .."_NAME",				-- 城市政策名称 ,注意目前城市政策是建筑名字
			Details = "LOC_" ..row.BuildingType .."_DESCRIPTION",	-- 城市政策详情
			MaintenanceCost = 0,									-- 城市政策每回合维护成本数值
			MaintenanceCostBaseUnit = "",							-- 城市政策每回合维护成本的基本单位（注意只用写单位，不是单位/时间，时间都是1回合）
			Cost = row.EnableCost,									-- 城市政策启用成本数值
			CostBaseUnit = "",										-- 城市政策启用成本的基本单位
			Class = row.PreDistrict,								-- 城市政策大类(所属区域)
			Kind = row.PreBuilding,									-- 城市政策类别(所属建筑)
			Icon = "ICON_BUILDING_CITY_POLICY_" ..row.CityPolicy,	-- 区域直属城市政策使用的图标，此时所属建筑为空
			NewName = "LOC_" ..row.CityPolicy .."_NAME",			-- 区域直属城市政策使用的政策类别名称，此时所属建筑为空
			Civic = row.EnableCivicType,							-- 城市政策前置市政
			Tech = row.EnableTechType,								-- 城市政策前置科技
			Activate = false,										-- 城市政策激活状态
			Usable = false,											-- 城市政策可用状态
		};
		
		local CP_B = "BUILDING_PK_DA_NULL";
		if row.PreBuilding == nil then -- 此时伟区域直属城市政策,中可是是暂时的，我们需要更好的分类，特别是区域直属城市政策
			-- 目前BUILDING_PK_DA_NULL是我为了UI测试，暂缓之计
			CP_B = "BUILDING_PK_DA_NULL";
			DACityPolicy.Kind = CP_B;
		else
			CP_B = row.PreBuilding
		end
		
		PreTechAndCivicComplete(DACityPolicy)

		if DACityPolicys[row.PreDistrict] == nil then DACityPolicys[row.PreDistrict] = {}; end
		if DACityPolicys[row.PreDistrict][CP_B] == nil then DACityPolicys[row.PreDistrict][CP_B] = {}; end
		DACityPolicys[row.PreDistrict][CP_B][row.CityPolicy] = DACityPolicy
		--table.insert(DACityPolicys[row.PreDistrict][CP_B], DACityPolicy);
	end
	return DACityPolicys;
end
function PreTechAndCivicComplete(CityPolicy)
	local pPlayer = Players[Game.GetLocalPlayer()];
	local playerCulture, playerScience = pPlayer:GetCulture(), pPlayer:GetTechs();
	local Civic, Tech = false, false;
	if CityPolicy.EnableCivicType then
		local cIndex = GameInfo.Civics[CityPolicy.EnableCivicType]
		if playerCulture:HasCivic(cIndex) then Civic = true; end
	else -- 此时CityPolicy.EnableCivicType为空，也就是没有Civic前置要求
		Civic = true;
	end
	if CityPolicy.EnableTechType then
		local tIndex = GameInfo.Technologies[CityPolicy.EnableTechType]
		if playerScience:HasTech(tIndex) then Tech = true; end
	else 
		Tech = true;
	end
	if Civic and Tech then CityPolicy.Usable = true; end -- 注意区域和建筑前置，直接后面进行UI显示时进行判别，我们这里只需要解决市政和科技前置判别
end
-- ===========================================================================
-- 皮凯：目前我只增加了黄金和信仰货币，可以修改这个函数增加对应支持
function GetPlayerCurrency(BaseUnit)
	local CurrencyValue, playerID = 0, Game.GetLocalPlayer()
	if		BaseUnit == "[ICON_Gold]" then
		local playerTreasury:table	= Players[playerID]:GetTreasury();
		local goldBalance	:number = math.floor(playerTreasury:GetGoldBalance());
		CurrencyValue = goldBalance;
	elseif	BaseUnit == "[ICON_Faith]" then
		local playerReligion :table	= Players[playerID]:GetReligion();
		local FaithBalance :number = Round( playerReligion:GetFaithBalance() );
		CurrencyValue = FaithBalance;
	else
		CurrencyValue = -1; -- 此时城市政策的成本单位设定UI不支持，需要来这里添加对应支持
	end
	return CurrencyValue;
end
-- ===========================================================================
function Level2InstanceCollapse(Level2Instance)
	Level2Instance.CPLevel2ListSlide:Reverse();
	Level2Instance.CPLevel2ListAlpha:Reverse();
	Level2Instance.CPLevel2ListSlide:SetSpeed(15.0);
	Level2Instance.CPLevel2ListAlpha:SetSpeed(15.0);
	Level2Instance.CPLevel2ListSlide:Play();
	Level2Instance.CPLevel2ListAlpha:Play();
	Level2Instance.CPLevel2ButtonContainer:SetShow(true)
	Level2Instance.CPLevel2ButtonContainerX:SetHide(true)
	Level2Instance.CityPoliciesStack:SetHide(true)
	Controls.PauseCollapseList:Play();
end
function Level2InstanceExpand(Level2Instance)
	Level2Instance.CPLevel2ListSlide:SetSpeed(2);
	Level2Instance.CPLevel2ListAlpha:SetSpeed(2);
	Level2Instance.CPLevel2ListSlide:SetSizeY(Level2Instance.CityPoliciesStack:GetSizeY());
	Level2Instance.CPLevel2ListAlpha:SetSizeY(Level2Instance.CityPoliciesStack:GetSizeY());
	Level2Instance.CPLevel2ListSlide:SetToBeginning();
	Level2Instance.CPLevel2ListAlpha:SetToBeginning();
	Level2Instance.CPLevel2ButtonContainer:SetHide(true)
	Level2Instance.CPLevel2ButtonContainerX:SetShow(true)
	Level2Instance.CityPoliciesStack:SetShow(true)
	Level2Instance.CPLevel2ListSlide:Play();
	Level2Instance.CPLevel2ListAlpha:Play();
end
function Level2InstancePMCAdjust(CPMcost, Level2Instance)
	if CPMcost == 0 then
		--Level2Instance.PMCStack:SetHide(true)
		--Level2Instance.PMCStackX:SetHide(true)
		--Level2Instance.PMCContainer:SetSizeX(50)
		--Level2Instance.PMCContainerX:SetSizeX(50)
		Level2Instance.PolicyMaintenanceCost:SetText("---")
		Level2Instance.PolicyMaintenanceCostX:SetText("---")
		Level2Instance.PolicyMaintenanceCost:SetOffsetX(0)
		Level2Instance.PolicyMaintenanceCostX:SetOffsetX(0)
	else
		Level2Instance.PolicyMaintenanceCost:SetText(CPMcost)
		Level2Instance.PolicyMaintenanceCostX:SetText(CPMcost)
		Level2Instance.PolicyMaintenanceCost:SetOffsetX(5)
		Level2Instance.PolicyMaintenanceCostX:SetOffsetX(5)
	end
end
function OnRefresh()
	if ContextPtr:IsHidden() then return; end
	
	local pCity = UI.GetHeadSelectedCity();
	if (pCity == nil) then
		pCity = m_kEspionageViewManager:GetEspionageViewCity();
		if pCity == nil then return; end
	else
		m_kEspionageViewManager:ClearEspionageViewCity();
	end

	local playerID = pCity:GetOwner();
	local pPlayer = Players[playerID];
	local playerCulture, playerScience = pPlayer:GetCulture(), pPlayer:GetTechs();
	if (pPlayer == nil) then return; end

	if pPlayer == nil or pCity == nil then return; end

	local pCityPower = pCity:GetPower();
	if pCityPower == nil then return; end
	
	m_CityPolicies1IM:ResetInstances();
	m_CityPolicies2IM:ResetInstances();
	m_CityPolicies3IM:ResetInstances();
	local pCityDistricts = pCity:GetDistricts();
    local iX, iY = pCity:GetX(), pCity:GetY();
    local plot, plotID = Map.GetPlot(iX, iY), Map.GetPlotIndex(iX, iY);
	local DACityPolicys = nil;
    DACityPolicys = plot:GetProperty('PKDACP');
    if DACityPolicys == nil then DACityPolicys = CityPolicyCreateTable() end
    
	print("-------------")
	local pCityBuildings	:table = pCity:GetBuildings();
	for i, district in pCityDistricts:Members() do
		local pDistrictDef : table = GameInfo.Districts[district:GetType()];
		print("赖赖的 " ..pDistrictDef.DistrictType)
		--print(pDistrictDef.DistrictType)
		if DACityPolicys[pDistrictDef.DistrictType] then
			local dPlotID = Map.GetPlotIndex(district:GetX(), district:GetY());
			print("Level1Instance" ..Locale.Lookup(pDistrictDef.Name))
			local DistrictName, DistrictTT = Locale.Lookup(pDistrictDef.Name), ""
			DistrictTT = DistrictName .."[NEWLINE]"
			local Level1Instance:table = m_CityPolicies1IM:GetInstance();
			Level1Instance.CPLevel1LabelText:SetText(DistrictName)
			Level1Instance.CPLevel1Icon:SetIcon("ICON_" ..pDistrictDef.DistrictType)
			
			local DistrictCPComplete,DCPCompleteNum, DCPIncompleteNum, DCPDText, DCPDTT, DCPNumSlots  = true, 0, 0, "", "", table.count(DACityPolicys[pDistrictDef.DistrictType]);
			
			local buildingTypes = pCityBuildings:GetBuildingsAtLocation(dPlotID);
			--for _, type in ipairs(buildingTypes) do
			--	local building	= GameInfo.Buildings[type];
			
			--print("Level1Instance数量:" ..#buildingTypes)
			--print("Level1Instance数量3:" ..table.count(DACityPolicys[pDistrictDef.DistrictType]))
			if #buildingTypes >= DCPNumSlots then
			end
			for j, building in pairs(DACityPolicys[pDistrictDef.DistrictType]) do
				local PolicySlotControls = {}
				local pBuildingDef : table = GameInfo.Buildings[j];
				--local BuildingName = Locale.Lookup(pBuildingDef.Name)
				local Level2CPName, CPMcost = "LOC_BUILDING_CITY_POLICY_EMPTY_NAME", 0;
				local Level2Instance:table = m_CityPolicies2IM:GetInstance(Level1Instance.BuildingStack);
				local cs = 0;
				for k, CityPolicy in pairs(building) do
					--if not CityPolicy.Usable then PreTechAndCivicComplete(CityPolicy); end -- 对不可用的城市政策刷新可用状态
					--if CityPolicy.Usable then
						cs = cs + 1
						CityPolicy.Activate = false
						if cs == 1 then CityPolicy.Activate = true; end
						local CPCost = CityPolicy.Cost;
						local Currency = GetPlayerCurrency(CityPolicy.CostBaseUnit);
						--CPCost = CPCost ..CityPolicy.CostBaseUnit
						--if Currency == -1 then  end
						local Level3Instance:table = m_CityPolicies3IM:GetInstance(Level2Instance.CityPoliciesStack);
						if CityPolicy.Activate then
							Level2InstanceCollapse(Level2Instance) -- 此时切换二级UI控件收起来
							Level2CPName = CityPolicy.Name;
							Level2Instance.SaveLevel2Key:SetText(k)
							if CityPolicy.MaintenanceCost ~= 0 then CPMcost = CPMcost ..CityPolicy.MaintenanceCostBaseUnit .."/[ICON_Turn]" end
							
							if j ~= "BUILDING_PK_DA_NULL" then  -- 此时伟区域直属城市政策,中可是是暂时的，我们需要更好的分类，特别是区域直属城市政策
								-- 目前BUILDING_PK_DA_NULL是我为了UI测试，暂缓之计
								Level2Instance.CPLevel2Icon:SetIcon("ICON_" ..j);
								Level2Instance.CPLevel2IconX:SetIcon("ICON_" ..j);
							else
								Level2Instance.CPLevel2Icon:SetIcon(CityPolicy.Icon);
								Level2Instance.CPLevel2IconX:SetIcon(CityPolicy.Icon);
							end
							Level3Instance.Level3:SetHide(true);
						end
						Level3Instance.CPLevel3LabelText:SetText(Locale.Lookup(CityPolicy.Name));
						Level3Instance.CPCostText:SetText(CPCost);
						Level3Instance.CPLevel3Button:RegisterCallback( Mouse.eLClick, function()
							Level2InstanceCollapse(Level2Instance)
							--ReplaceCityPolicy(k, building, Level2Instance, Level3Instance)
						end);
						--if Currency < CPCost then Level3Instance.CPLevel3Disabled:SetShow(true); end
					--end
				end
				Level2InstancePMCAdjust(CPMcost, Level2Instance)
				Level2Instance.CPLevel2LabelText:SetText(Locale.Lookup(Level2CPName))
				Level2Instance.CPLevel2LabelTextX:SetText(Locale.Lookup(Level2CPName))
				Level2Instance.CPLevel2Button:RegisterCallback( Mouse.eLClick, function()
					Level2InstanceExpand(Level2Instance)
				end);
				Level2Instance.CPLevel2ButtonX:RegisterCallback( Mouse.eLClick, function()
					Level2InstanceCollapse(Level2Instance)
				end);
				Level2Instance.CPLevel2ButtonX2:RegisterCallback( Mouse.eLClick, function()
					Level2InstanceCollapse(Level2Instance)
				end);
				--PolicySlotControls[] --标记明天在写
				print("building--j: " ..j)
			end
			
			Level1Instance.ButtonContainer:SetToolTipString(DistrictTT);
			DCPIncompleteNum = DCPNumSlots - DCPCompleteNum;
			if DCPCompleteNum == DCPNumSlots then
				DCPDText = "[ICON_Checkmark](DCPNumSlots)";
				DCPDTT = "当前该城市的"..DistrictName .."已经完成城市政策选择(共"..DCPNumSlots .."个)，当然你随时可用选择更改政策"
			else
				DCPDText = DCPIncompleteNum ..":" ..DCPCompleteNum .."|" ..DCPNumSlots;
				DCPDTT = "当前该城市的"..DistrictName .."待设定城市政策共"..DCPIncompleteNum .."个,已经完成设定共" ..DCPCompleteNum .."个，可同时共存" ..DCPNumSlots .."个城市政策"
			end
			Level1Instance.PolicySituation:SetText(DCPDText);
			Level1Instance.PolicySituationContainer:SetToolTipString(DCPDTT);
			Level1Instance.Button:RegisterCallback( Mouse.eLClick, function()
				if Level1Instance.BuildingDrawer:IsHidden() then
					Level1Instance.BuildingDrawer:SetShow(true);
					Level1Instance.ListSlide:SetSpeed(2);
					Level1Instance.ListAlpha:SetSpeed(2);
					Level1Instance.ListSlide:SetSizeY(Level1Instance.BuildingDrawer:GetSizeY());
					Level1Instance.ListAlpha:SetSizeY(Level1Instance.BuildingDrawer:GetSizeY());
					Level1Instance.ListSlide:SetToBeginning();
					Level1Instance.ListAlpha:SetToBeginning();
					Level1Instance.ListSlide:Play();				
					Level1Instance.ListAlpha:Play();
				else
					Level1Instance.ListSlide:Reverse();
					Level1Instance.ListAlpha:Reverse();
					Level1Instance.ListSlide:SetSpeed(15.0);
					Level1Instance.ListAlpha:SetSpeed(15.0);
					Level1Instance.ListSlide:Play();
					Level1Instance.ListAlpha:Play();
					Level1Instance.BuildingDrawer:SetHide(true);
					Controls.PauseCollapseList:Play();
				end
			end);
		end
	end
    GameEvents.SetPlotProperty.Call(plotID, DACityPolicys, 'PKDACP');
	Controls.CityPolicies:CalculateSize();
	
	-- 下面大部分代码全部要删除调整，--别动啊我后续会看
	-- Status
	local freePower:number = pCityPower:GetFreePower();
	local temporaryPower:number = pCityPower:GetTemporaryPower();
	local currentPower:number = freePower + temporaryPower;
	local requiredPower:number = pCityPower:GetRequiredPower();
	local powerStatusName:string = "LOC_POWER_STATUS_POWERED_NAME";
	local powerStatusDescription:string = "LOC_POWER_STATUS_POWERED_DESCRIPTION";
	if (requiredPower == 0) then
		powerStatusName = "LOC_POWER_STATUS_NO_POWER_NEEDED_NAME";
		powerStatusDescription = "LOC_POWER_STATUS_NO_POWER_NEEDED_DESCRIPTION";
	elseif (not pCityPower:IsFullyPowered()) then
		powerStatusName = "LOC_POWER_STATUS_UNPOWERED_NAME";
		powerStatusDescription = "LOC_POWER_STATUS_UNPOWERED_DESCRIPTION";
	elseif (pCityPower:IsFullyPoweredByActiveProject()) then
		currentPower = requiredPower;
	end
	Controls.ConsumingPowerLabel:SetText(Locale.Lookup("LOC_POWER_PANEL_CONSUMED", Round(currentPower, 1)));
	Controls.RequiredPowerLabel:SetText(Locale.Lookup("LOC_POWER_PANEL_REQUIRED", Round(requiredPower, 1)));
	Controls.PowerStatusNameLabel:SetText(Locale.Lookup(powerStatusName));

	-- Status Effects
	Controls.PowerStatusDescriptionLabel:SetText(Locale.Lookup(powerStatusDescription));
	Controls.PowerStatusDescriptionBox:SetSizeY(Controls.PowerStatusDescriptionLabel:GetSizeY() + 15);

	-- Breakdown
	m_kPowerBreakdownIM:ResetInstances();
	-----Consumed 
	local freePowerBreakdown:table = pCityPower:GetFreePowerSources();
	local temporaryPowerBreakdown:table = pCityPower:GetTemporaryPowerSources();
	local somethingToShow:boolean = false;
	for _,innerTable in ipairs(freePowerBreakdown) do
		somethingToShow = true;
		local scoreSource, scoreValue = next(innerTable);
		local lineInstance = m_kPowerBreakdownIM:GetInstance(Controls.ConsumedPowerBreakdownStack);
		lineInstance.LineTitle:SetText(scoreSource);
		lineInstance.LineValue:SetText("[ICON_Power]" .. Round(scoreValue, 1));
	end
	for _,innerTable in ipairs(temporaryPowerBreakdown) do
		somethingToShow = true;
		local scoreSource, scoreValue = next(innerTable);
		local lineInstance = m_kPowerBreakdownIM:GetInstance(Controls.ConsumedPowerBreakdownStack);
		lineInstance.LineTitle:SetText(scoreSource);
		lineInstance.LineValue:SetText("[ICON_Power]" .. Round(scoreValue, 1));
	end
	Controls.ConsumedPowerBreakdownStack:CalculateSize();
	Controls.ConsumedBreakdownBox:SetSizeY(Controls.ConsumedPowerBreakdownStack:GetSizeY() + 15);
	Controls.ConsumedBreakdownBox:SetHide(not somethingToShow);
	Controls.ConsumedTitle:SetHide(not somethingToShow);
	-----Required
	local requiredPowerBreakdown:table = pCityPower:GetRequiredPowerSources();
	local somethingToShow:boolean = false;
	for _,innerTable in ipairs(requiredPowerBreakdown) do
		somethingToShow = true;
		local scoreSource, scoreValue = next(innerTable);
		local lineInstance = m_kPowerBreakdownIM:GetInstance(Controls.RequiredPowerBreakdownStack);
		lineInstance.LineTitle:SetText(scoreSource);
		lineInstance.LineValue:SetText("[ICON_Power]" .. Round(scoreValue, 1));
	end
	Controls.RequiredPowerBreakdownStack:CalculateSize();
	Controls.RequiredBreakdownBox:SetSizeY(Controls.RequiredPowerBreakdownStack:GetSizeY() + 15);
	Controls.RequiredBreakdownBox:SetHide(not somethingToShow);
	Controls.RequiredTitle:SetHide(not somethingToShow);
	-----Generated
	local generatedPowerBreakdown:table = pCityPower:GetGeneratedPowerSources();
	local somethingToShow:boolean = false;
	for _,innerTable in ipairs(generatedPowerBreakdown) do
		somethingToShow = true;
		local scoreSource, scoreValue = next(innerTable);
		local lineInstance = m_kPowerBreakdownIM:GetInstance(Controls.GeneratedPowerBreakdownStack);
		lineInstance.LineTitle:SetText(scoreSource);
		lineInstance.LineValue:SetText("[ICON_Power]" .. Round(scoreValue, 1));
		lineInstance.LineValue:SetColorByName("White");
	end
	Controls.GeneratedPowerBreakdownStack:CalculateSize();
	Controls.GeneratedBreakdownBox:SetSizeY(Controls.GeneratedPowerBreakdownStack:GetSizeY() + 15);
	Controls.GeneratedBreakdownBox:SetHide(not somethingToShow);
	Controls.GeneratedTitle:SetHide(not somethingToShow);

	-- Advisor顾问
	if m_kEspionageViewManager:IsEspionageView() then
		Controls.PowerAdvisor:SetHide(true);
	else
		Controls.PowerAdvice:SetText(pCity:GetPowerAdvice());
		Controls.PowerAdvisor:SetHide(false);
	end

	m_KeyStackIM:ResetInstances();

	AddKeyEntry("LOC_POWER_LENS_KEY_POWER_SOURCE", UI.GetColorValue("COLOR_STANDARD_GREEN_MD"), true);
	AddKeyEntry("LOC_POWER_LENS_KEY_FULLY_POWERED", UI.GetColorValue("COLOR_STANDARD_GREEN_MD"));
	AddKeyEntry("LOC_POWER_LENS_KEY_UNDERPOWERED", UI.GetColorValue("COLOR_STANDARD_RED_MD"));
	AddKeyEntry("LOC_POWER_LENS_KEY_POWER_RANGE", UI.GetColorValue("COLOR_YELLOW"), true);

	Controls.TabStack:CalculateSize();
end --DACityPolicys[row.PreDistrict][CP_B][row.CityPolicy] = DACityPolicy
function ReplaceCityPolicy(k, CityPolicysLevel2, Level2Instance, Level3Instance)
	local CityPolicyL2In, CityPolicyL3In = CityPolicysLevel2[Level2Instance.SaveLevel2Key:GetText()], CityPolicysLevel2[k];
	
	--local NewName3, NewCPMcost3 = CityPolicyL2In.Name, ;
	if CityPolicyL3In == nil then end
	if k == -1 then -- 此时为Level2Instance的CPLevel2ButtonX按钮激活，将启用空白政策给予Level2Instance的CPLevel2Button
		
	else -- 此时Level2和Level3都有政策，需要将Level3政策作为新的当前政策换到Level2Instance控件上，而Level2政策反过来替换到Level3Instance控件上
		--if CityPolicy.MaintenanceCost ~= 0 then CPMcost = CPMcost ..CityPolicy.MaintenanceCostBaseUnit .."/[ICON_Turn]" end
		--Level2InstancePMCAdjust(CPMcost, Level2Instance)
		--local NewName2 = Level3Instance
		local NewL2CPName, NewL3CPName = CityPolicyL3In.Name, CityPolicyL2In.Name
		CityPolicyL2In.Activate, CityPolicyL3In.Activate = false, true;
		print("NewL2CPName: " ..Locale.Lookup(NewL2CPName))
		print("NewL3CPName: " ..Locale.Lookup(NewL3CPName))
		Level2Instance.SaveLevel2Key:SetText(NewL2CPName)
		Level2Instance.CPLevel2LabelText:SetText(Locale.Lookup(NewL2CPName))
		Level2Instance.CPLevel2LabelTextX:SetText(Locale.Lookup(NewL2CPName))
		Level3Instance.CPLevel3LabelText:SetText(Locale.Lookup(NewL3CPName))
		
	end
end
-- ===========================================================================
function AddKeyEntry(textString:string, colorValue:number, bUseEmptyTexture:boolean)
	local keyEntryInstance:table = m_KeyStackIM:GetInstance();

	-- Update key text
	keyEntryInstance.KeyLabel:SetText(Locale.Lookup(textString));

	-- Set the texture if we want to use the hollow, border only hex texture
	if bUseEmptyTexture == true then
		keyEntryInstance.KeyColorImage:SetTexture("Controls_KeySwatchHexEmpty");
	else
		keyEntryInstance.KeyColorImage:SetTexture("Controls_KeySwatchHex");
	end

	-- Update key color
	keyEntryInstance.KeyColorImage:SetColor(colorValue);
end

-- ===========================================================================
function OnShowEnemyCityOverview( ownerID:number, cityID:number)
	m_kEspionageViewManager:SetEspionageViewCity( ownerID, cityID );
	OnRefresh();
end

-- ===========================================================================
function OnTabStackSizeChanged()
	-- Manually resize the context to fit the child stack
	ContextPtr:SetSizeX(Controls.TabStack:GetSizeX());
	ContextPtr:SetSizeY(Controls.TabStack:GetSizeY());
end


function HideCityPoliciesUI()
	--Controls.TabStack:SetShow(Controls.TabStack:IsHidden());
	--Controls.DAPKButton:SetShow(Controls.DAPKButton:IsHidden());
	print("===================DA_CityPoliciesUI=====================");
	print("===================LuaEvents.PPK_CityPoliciesUI正常调用=====================");
end

function Initialize()
	LuaEvents.PPK_CityPoliciesUI.Add( HideCityPoliciesUI );
	LuaEvents.CityPanelTabRefresh.Add(OnRefresh);
	Events.CitySelectionChanged.Add( OnRefresh );

	LuaEvents.CityBannerManager_ShowEnemyCityOverview.Add( OnShowEnemyCityOverview );
	
	Events.LoadGameViewStateDone.Add(CityPolicyCreateTable);

	Controls.TabStack:RegisterSizeChanged( OnTabStackSizeChanged );
end
Initialize();
--[[
		local CityPolicy = {
			Name = "LOC_" ..row.EnableProjectType .."_NAME",		-- 城市政策名称
			Details = "LOC_" ..row.BuildingType .."_DESCRIPTION",	-- 城市政策详情
			Cost = row.EnableCost,									-- 成本数值
			CostBaseUnit = "",										-- 成本的基本单位
			Class = row.PreDistrict,								-- 城市政策大类(所属区域)
			Kind = row.PreBuilding,									-- 城市政策类别(所属建筑)
		};
		print('开始报点')
		print(row.EnableProjectType)
		print(row.BuildingType)
		print(row.EnableCost)
		print(row.PreDistrict)
		print(row.PreBuilding)
		local CP_B = nil;
		if DACityPolicys[row.PreDistrict] == nil then DACityPolicys[row.PreDistrict] = {DACityPolicy={}}; end
		
		if row.PreBuilding == nil then
			CityPolicy.Kind = "BUILDING_PK_NULL";
			CP_B = DACityPolicys[row.PreDistrict].DACityPolicy['BUILDING_PK_NULL']
		else
			CP_B = DACityPolicys[row.PreDistrict].DACityPolicy[row.PreBuilding]
		end
		if CP_B == nil then CP_B = {}; end
		table.insert(CP_B, CityPolicy);
]]