GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;



--建造者建造区域的ui函数
--ui初始化
include( "InstanceManager" )
include("SupportFunctions")
local m_BuilderBuildDistrictsIM			:table	= InstanceManager:new( "BuilderBuildDistrictsColumnInstance",	"Top",					Controls.BuilderBuildDistrictsStack )
function OnLoadGameViewStateDone_test_gg()
    local ctrl = ContextPtr:LookUpControl("/InGame/HUD/UnitPanel/UnitPanelAlpha/UnitPanelSlide")
    Controls.BuilderBuildDistrictsGrid:ChangeParent(ctrl)
    Controls.BuilderBuildDistrictsGrid:SetHide(true)
end
Events.LoadGameViewStateDone.Add(OnLoadGameViewStateDone_test_gg)
--判断ui显示
function OnUnitSelectionChanged(playerID, unitID, locationX, locationY, locationZ, isSelected, isEditable)
	if isSelected and not Hide(playerID,unitID,locationX,locationY) then
		Refresh(playerID,unitID,locationX,locationY)
	end
end
Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)
function OnUnitMoveComplete(playerID,unitID,iX,iY)
	if not Hide(playerID,unitID,iX,iY) then
		Refresh(playerID,unitID,iX,iY)
	end
end
Events.UnitMoveComplete.Add(OnUnitMoveComplete)
--隐藏ui函数
function Hide(playerID,unitID,iX,iY)
	local pUnit = UnitManager.GetUnit(playerID, unitID)
	if pUnit == nil then return end
	--判断单位类型，以及移动力剩余
	if GameInfo.Units[pUnit:GetType()].UnitType ~= "UNIT_BUILDER" or pUnit:GetMovementMovesRemaining() <= 0 then
		Controls.BuilderBuildDistrictsGrid:SetHide(true)
		return true
	end
	--判断单位所占地块是否为单位拥有者
	local pPlot = Map.GetPlot(iX,iY)
	local pPlotOwnerID = pPlot:GetOwner()
	if pPlotOwnerID ~= playerID then
		Controls.BuilderBuildDistrictsGrid:SetHide(true)
		return true
	end
	return false
end
--刷新并显示ui
function Refresh(playerID,unitID,iX,iY) 
	--重置Instances
	m_BuilderBuildDistrictsIM:DestroyInstances()
	m_BuilderBuildDistrictsIM:ResetInstances()
	--判断ui距离
	local BuildActionsPanel = ContextPtr:LookUpControl("/InGame/HUD/UnitPanel/UnitPanelAlpha/UnitPanelSlide/BuildActionsPanel")
	local UnitPanelBaseContainer = ContextPtr:LookUpControl("/InGame/HUD/UnitPanel/UnitPanelAlpha/UnitPanelSlide/UnitPanelBaseContainer")
	local BuildActionsPanelSizeX = BuildActionsPanel:GetSizeX()
	local UnitPanelBaseContainerSizeX = UnitPanelBaseContainer:GetSizeX()
	Controls.BuilderBuildDistrictsGrid:SetOffsetX(UnitPanelBaseContainerSizeX + BuildActionsPanelSizeX + 162)
	Controls.BuilderBuildDistrictsGrid:SetHide(false)
	--增加Instances
	local instance	= {}
	local CanBuildDistricts = DeepCopy(Utils.CanBuildDistricts)
	local HideKey = {}
	--判断按钮的显示
	for i=1,#CanBuildDistricts,1 do
		local DistrictID = CanBuildDistricts[i].DistrictID
		local isDistrict = true
		if CanBuildDistricts[i].isDistrict ~= nil then
			isDistrict = CanBuildDistricts[i].isDistrict
		end
		--拥有特色区域时原始区域不显示
		if DistrictID ~= nil and isDistrict then
			for _, row in pairs(GameInfo.Districts[DistrictID].ReplacedByCollection) do
				local Trait = GameInfo.Districts[row.CivUniqueDistrictType].TraitType
				if Utils.PlayerHasTrait(playerID,Trait) then
					table.insert(HideKey,i)
					break
				end
			end
		end
		--没有特质，特色区域不显示
		if GameInfo.DistrictReplaces[DistrictID] ~= nil then
			local Trait = GameInfo.Districts[DistrictID].TraitType
			if not Utils.PlayerHasTrait(playerID,Trait) then
				table.insert(HideKey,i)
			end
		end
		--isHide判断显示
		local isHide = false
		if CanBuildDistricts[i].isHide ~= nil then
			isHide = CanBuildDistricts[i].isHide(playerID,unitID,iX,iY)
		end
		if isHide then
			table.insert(HideKey,i)
		end
	end
	for i=1,#HideKey,1 do
		table.remove(CanBuildDistricts,HideKey[i])
	end
	Controls.BuilderBuildDistrictsGrid:SetSizeX(51)
	--一层循环,以列为单位,三个Instances为一列
	for i=1,#CanBuildDistricts,3 do
		local buildColumnInstance = m_BuilderBuildDistrictsIM:GetInstance()
		--超过一列扩展ui的x轴长度,
		if i ~= 1 then
			Controls.BuilderBuildDistrictsStack:CalculateSize()
			local BuilderBuildDistrictsStackSizeX = Controls.BuilderBuildDistrictsStack:GetSizeX()
			Controls.BuilderBuildDistrictsGrid:SetSizeX( BuilderBuildDistrictsStackSizeX + 24)
		end
		--二层循环,以Instances为单位，每一列三个Instances
		for iRow=1,3,1 do
			if (i+iRow)-1 <= #CanBuildDistricts then
				local DistrictID = CanBuildDistricts[(i+iRow)-1].DistrictID
				if DistrictID ~= nil then
					local RowSlot = "Row"..tostring(iRow)
					local instance	= {}
					ContextPtr:BuildInstanceForControl("BuilderBuildDistrictsInstance", instance, buildColumnInstance[RowSlot])
					--文本
					if CanBuildDistricts[(i+iRow)-1].DistrictToolTipString ~= nil then
						DistrictToolTipString = Locale.Lookup(CanBuildDistricts[(i+iRow)-1].DistrictToolTipString)
					else
						local sName = GameInfo.Districts[DistrictID].Name
						local sDescription = GameInfo.Districts[DistrictID].Description
						DistrictToolTipString = Locale.Lookup(sName).."[NEWLINE]"..Locale.Lookup(sDescription)
					end

					-- local DistrictToolTipString = CanBuildDistricts[(i+iRow)-1].DistrictToolTipString or "LOC_"..DistrictID.."_NAME"
					instance.BuilderBuildDistrictsButton:SetToolTipString(DistrictToolTipString)
					--图标
					local DistrictIcon = CanBuildDistricts[(i+iRow)-1].DistrictIcon or "ICON_"..DistrictID
					--instance.BuilderBuildDistrictsIcon:SetTexture(IconManager:FindIconAtlas(DistrictIcon, 38))
					instance.BuilderBuildDistrictsIcon:SetIcon(DistrictIcon)
					--按钮初始禁用
					instance.BuilderBuildDistrictsButton:SetDisabled(true)
					instance.BuilderBuildDistrictsButton:SetAlpha(0.5)
					--判断按钮可用
					if BuildDistrictsButtonabled(playerID,unitID,iX,iY,CanBuildDistricts,i,iRow) then
						--使按钮可用
						instance.BuilderBuildDistrictsButton:SetDisabled(false)
						instance.BuilderBuildDistrictsButton:SetAlpha(1)
						--效果函数
						instance.BuilderBuildDistrictsButton:RegisterCallback(Mouse.eLClick,function()
							local isDistrict = true
							if CanBuildDistricts[(i+iRow)-1].isDistrict ~= nil then
								isDistrict = CanBuildDistricts[i+iRow].isDistrict
							end
							if isDistrict then
								--默认效果，建造区域
								local pPlot = Map.GetPlot(iX,iY)
								local pCity = Cities.GetPlotPurchaseCity(pPlot)
								local DistrictsIndex = GameInfo.Districts[DistrictID].Index
								Utils.CreateDistrict(playerID,pCity:GetID(),DistrictsIndex,100,iX,iY)
								--标记Property,避免重复建造
								local CanRepeatBuild = false
								if CanBuildDistricts[(i+iRow)-1].CanRepeatBuild ~= nil then
									CanRepeatBuild = CanBuildDistricts[(i+iRow)-1].CanRepeatBuild
								end
								if not CanRepeatBuild then
									Utils.SetCityProperty(playerID,pCity:GetID(),"BuilderBuildDistricts_"..DistrictID,true)
								end
							end
							--减建造者的劳动力
							if CanBuildDistricts[(i+iRow)-1].BuildCharge ~= nil then
								local BuildCharge = CanBuildDistricts[(i+iRow)-1].BuildCharge(playerID,unitID,iX,iY)
								if type(BuildCharge) == "number" and BuildCharge > 0 then
									for i=1,BuildCharge,1 do
										GameEvents.ReduceBuildCharge.Call(playerID,unitID)
									end
								end
							end
							--自定义效果
							if CanBuildDistricts[(i+iRow)-1].DistrictEffect ~= nil then
								CanBuildDistricts[(i+iRow)-1].DistrictEffect(playerID,unitID,iX,iY)
							end
							GameEvents.OnBuilderBuildDistrict.Call(playerID,unitID,iX,iY,i+iRow-1)
							--再次刷新
							--Refresh(playerID,unitID,iX,iY)
							Controls.BuilderBuildDistrictsGrid:SetHide(true)
						end)
					end
				end
			end
		end
		
	end		
	
end
--
function BuildDistrictsButtonabled(playerID,unitID,iX,iY,CanBuildDistricts,i,iRow)
	local DistrictID = CanBuildDistricts[(i+iRow)-1].DistrictID
	--判断是否有已建造的Property
	local pPlot = Map.GetPlot(iX,iY)
	local pCity = Cities.GetPlotPurchaseCity(pPlot)
	if pCity:GetProperty("BuilderBuildDistricts_"..DistrictID) then
		--print("built")
		return false
	end
	--判断地块上是否已有区域
	local isDistrict = true
	if  CanBuildDistricts[(i+iRow)-1].isDistrict ~= nil then
		isDistrict = CanBuildDistricts[(i+iRow)-1].isDistrict
	end
	local districtID = pPlot:GetDistrictID()
	if districtID ~= -1 and isDistrict then
		--print("hasdistrict")
		return false
	end
	--判断是否放置于水上
	local PlaceOnWater = false
	if CanBuildDistricts[(i+iRow)-1].PlaceOnWater ~= nil then
		PlaceOnWater = CanBuildDistricts[(i+iRow)-1].PlaceOnWater
	end
	local pPlot = Map.GetPlot(iX,iY)
	if pPlot:IsWater() and not PlaceOnWater then
		return false
	elseif not pPlot:IsWater() and PlaceOnWater then
		return false
	end
	--判断单位劳动力要求
	if CanBuildDistricts[(i+iRow)-1].BuildCharge ~= nil then
		local BuildCharge = CanBuildDistricts[(i+iRow)-1].BuildCharge(playerID,unitID,iX,iY)
		if type(BuildCharge) == "number" and BuildCharge > 0 then
			local pUnit = UnitManager.GetUnit(playerID, unitID)
			if pUnit:GetBuildCharges() < BuildCharge then
				--print("BuildCharge")
				return false
			end
		end
	end
	--互斥区域判断
	if CanBuildDistricts[(i+iRow)-1].MutuallyExclusiveDistricts ~= nil and isDistrict then
		local MutuallyExclusiveDistricts = CanBuildDistricts[(i+iRow)-1].MutuallyExclusiveDistricts(playerID,unitID,iX,iY)
		if MutuallyExclusiveDistricts == true then
			local MutuallyExclusiveDistrictsTable = {}
			for row in GameInfo.MutuallyExclusiveDistricts() do
				if row.District == DistrictID then
					table.insert(MutuallyExclusiveDistrictsTable,row.MutuallyExclusiveDistrict)
				end
			end
			MutuallyExclusiveDistricts = MutuallyExclusiveDistrictsTable
		end
		if type(MutuallyExclusiveDistricts) == "table" then
			local pPlot = Map.GetPlot(iX,iY)
			local pCity = Cities.GetPlotPurchaseCity(pPlot)
			local pCityDistricts = pCity:GetDistricts()
			for i=1,#MutuallyExclusiveDistricts,1 do
				if MutuallyExclusiveDistricts[i] ~= "DISTRICT_CITY_CENTER" and pCityDistricts:HasDistrict(GameInfo.Districts[MutuallyExclusiveDistricts[i]].Index) then
					print("MutuallyExclusiveDistricts")
					return fasle
				end
			end
		end
	end
	--所需科技判断
	if CanBuildDistricts[(i+iRow)-1].PrereqTech ~= nil then
		local PrereqTech = CanBuildDistricts[(i+iRow)-1].PrereqTech(playerID,unitID,iX,iY)
		if PrereqTech == true then
			PrereqTech = GameInfo.Districts[DistrictID].PrereqTech
		end
		if type(PrereqTech) == "string" then
			local DistrictPrereqTechTypeIndex = GameInfo.Technologies[PrereqTech].Index 
			if not Players[playerID]:GetTechs():HasTech(DistrictPrereqTechTypeIndex) then
				--print("PrereqTech")
				return false
			end
		end
		
	end
	--所需市政判断
	if CanBuildDistricts[(i+iRow)-1].PrereqCivic ~= nil then
		local PrereqCivic = CanBuildDistricts[(i+iRow)-1].PrereqCivic(playerID,unitID,iX,iY)
		if PrereqCivic == true then
			PrereqCivic = GameInfo.Districts[DistrictID].PrereqCivic
		end
		if type(PrereqCivic) == "string" then
			local DistrictPrereqCivicTypeIndex = GameInfo.Civics[PrereqCivic].Index 
			if not Players[playerID]:GetCulture():HasCivic(DistrictPrereqCivicTypeIndex) then
				--print("PrereqTech")
				return false
			end
		end
		
	end
	--自定义条件函数判断
	local DistrictDisabled = false
	if CanBuildDistricts[(i+iRow)-1].DistrictDisabled ~= nil then
		DistrictDisabled = CanBuildDistricts[(i+iRow)-1].DistrictDisabled(playerID,unitID,iX,iY)
	end
	if DistrictDisabled then
		--print("DistrictDisabled")
		return false
	end
	return true
end
function OnBuilderBuildDistrict(playerID,unitID,iX,iY,key)
	--print(playerID,unitID,iX,iY,key)
end
GameEvents.OnBuilderBuildDistrict.Add(OnBuilderBuildDistrict)