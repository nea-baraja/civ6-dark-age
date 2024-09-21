ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
GameEvents = ExposedMembers.GameEvents;
----------------------------------------------------------
--戈尔戈,塞莫皮莱
--每个军事槽，在城邦放置使者时赠送该城邦一个军事单位
--local unit_promotion_class_table = {"ANTI_CAVALRY","MELEE","RANGED","LIGHT_CAVALRY","HEAVY_CAVALRY"}

TECH_HORSEBACK_RIDING = GameInfo.Technologies["TECH_HORSEBACK_RIDING"].Index
TECH_BRONZE_WORKING = GameInfo.Technologies["TECH_BRONZE_WORKING"].Index
TECH_THE_WHEEL = GameInfo.Technologies["TECH_THE_WHEEL"].Index
local unit_promotion_class_table = {{"ANTI_CAVALRY",TECH_BRONZE_WORKING},{"MELEE",nil},{"RANGED",nil},{"LIGHT_CAVALRY",TECH_HORSEBACK_RIDING},{"HEAVY_CAVALRY",TECH_THE_WHEEL}}
function DA_OnPlayerGaveInfluenceToken(majorId, minorId, iAmount)
	--print(iAmount)
	--排除减使者
	if iAmount<0 then
		return
	end
    --排除阿玛尼的总督能力
    local MajorPlayer = Players[majorId]
    if MajorPlayer:GetProperty("AMBASSADOR_CITY") ~= nil then
		MajorPlayer:SetProperty("AMBASSADOR_ADD_INFLUENCETOKEN",nil)
		return
    end
	if Utils.PlayerHasTrait(majorId,"CULTURE_KILLS_TRAIT") then
		local MajorPlayerMilitaryPolicySlotNum = Utils.GetNumPolicySlot(majorId,"SLOT_MILITARY")
		if MajorPlayerMilitaryPolicySlotNum > 0 then
			local MinorPlayer = Players[minorId]
			local MinorPlayerCities = MinorPlayer:GetCities()
			local MinorPlayerCapital = MinorPlayerCities:GetCapitalCity()
			if MinorPlayerCapital then
				if MinorPlayer:GetProperty("unit_promotion_class_id") == nil then
					MinorPlayer:SetProperty("unit_promotion_class_id",1)
				end
				for i=1,MajorPlayerMilitaryPolicySlotNum,1 do
					local unit_promotion_class_id = MinorPlayer:GetProperty("unit_promotion_class_id")
					if unit_promotion_class_id > #unit_promotion_class_table then
						unit_promotion_class_id = 1
						local VisableUnitID = SelectedKeyCycle(unit_promotion_class_id,MinorPlayer)
						MinorPlayer:AttachModifierByID("DA_MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS_IN_CAPITAL_"..unit_promotion_class_table[VisableUnitID][1])
						MinorPlayer:SetProperty("unit_promotion_class_id",VisableUnitID+1)
					else
						local VisableUnitID = SelectedKeyCycle(unit_promotion_class_id,MinorPlayer)
						MinorPlayer:AttachModifierByID("DA_MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS_IN_CAPITAL_"..unit_promotion_class_table[VisableUnitID][1])
						MinorPlayer:SetProperty("unit_promotion_class_id",VisableUnitID+1)
					end
				end
			end
		end
	end
end

function SelectedKeyCycle(key,pPlayer)
	if key > #unit_promotion_class_table then
		key = 1
	end
	if unit_promotion_class_table[key][2] == nil or pPlayer:GetTechs():HasTech(unit_promotion_class_table[key][2]) then
		return key
	else
		return SelectedKeyCycle(key+1,pPlayer)
	end
end

GameEvents.OnPlayerGaveInfluenceToken.Add(DA_OnPlayerGaveInfluenceToken);

---------------------------------------------------------------------
--戈尔戈,塞莫皮莱
--每个军事槽，雇佣单位+2力
function SetPropertyOnCapitalPlot(playerID,key,value)
	local pPlayer = Players[playerID]
	local pPlayerCapital = pPlayer:GetCities():GetCapitalCity()
	if pPlayerCapital == nil then
		return
	end
	local iX, iY = pPlayerCapital:GetX(), pPlayerCapital:GetY()
    local pPlayerCapitalPlot = Map.GetPlot(iX,iY)
	pPlayerCapitalPlot:SetProperty(key,value)
	pPlayer:SetProperty(key,{iX,iY})
end

--[[
function DA_OnLevyCounterChanged(originalOwnerID)
	local OriginalOwner = Players[originalOwnerID]
	local suzerainID = OriginalOwner:GetInfluence():GetSuzerain()
	if suzerainID < 0 then
		return
	end
	if Utils.PlayerHasTrait(suzerainID,"CULTURE_KILLS_TRAIT") then
		local MajorPlayerMilitaryPolicySlotNum = Utils.GetNumPolicySlot(suzerainID,"SLOT_MILITARY")
		SetPropertyOnCapitalPlot(suzerainID,"MilitaryPolicySlotNum",MajorPlayerMilitaryPolicySlotNum)
	end
end
Events.LevyCounterChanged.Add(DA_OnLevyCounterChanged)
--]]

function OnPlayerTurn(playerID)
	if Utils.PlayerHasTrait(playerID,"CULTURE_KILLS_TRAIT") then
		local MajorPlayerMilitaryPolicySlotNum = Utils.GetNumPolicySlot(playerID,"SLOT_MILITARY")
		SetPropertyOnCapitalPlot(playerID,"MilitaryPolicySlotNum",MajorPlayerMilitaryPolicySlotNum)
	end
end

Events.PlayerTurnActivated.Add(OnPlayerTurn)

function DA_OnGovernmentPolicyChanged(playerID)
	if Utils.PlayerHasTrait(playerID,"CULTURE_KILLS_TRAIT") then
		local MajorPlayerMilitaryPolicySlotNum = Utils.GetNumPolicySlot(playerID,"SLOT_MILITARY")
		SetPropertyOnCapitalPlot(playerID,"MilitaryPolicySlotNum",MajorPlayerMilitaryPolicySlotNum)
	end
end
Events.GovernmentPolicyChanged.Add(DA_OnGovernmentPolicyChanged)

function DA_OnCapitalCityChanged(playerID,cityID)
	if Utils.PlayerHasTrait(playerID,"CULTURE_KILLS_TRAIT") then
		local pPlayer = Players[playerID]
		if pPlayer:GetProperty("MilitaryPolicySlotNum") == nil then
			return
		end
		local iX, iY = pPlayer:GetProperty("MilitaryPolicySlotNum")[1],	pPlayer:GetProperty("MilitaryPolicySlotNum")[2]
		local plot = Map.GetPlot(iX,iY)
		if plot:GetProperty("MilitaryPolicySlotNum") ~= nil then
			plot:SetProperty("MilitaryPolicySlotNum",nil)
		end
		local MajorPlayerMilitaryPolicySlotNum = Utils.GetNumPolicySlot(playerID,"SLOT_MILITARY")
		SetPropertyOnCapitalPlot(playerID,"MilitaryPolicySlotNum",MajorPlayerMilitaryPolicySlotNum)
	end
end
Events.CapitalCityChanged.Add(DA_OnCapitalCityChanged)

function DA_GovernorEstablished(CityOwnerID,CityID,GovernorOwnerID,GovernorType: number)
	if Utils.PlayerHasTrait(GovernorOwnerID,"CULTURE_KILLS_TRAIT") then 
		local GovernorTypeName = GameInfo.Governors[GovernorType].GovernorType
	    if GovernorTypeName == "GOVERNOR_THE_AMBASSADOR" then
			local GovernorOwner = Players[GovernorOwnerID]
			GovernorOwner:SetProperty("AMBASSADOR_ADD_INFLUENCETOKEN",CityOwnerID)
	    end
	end
end

Events.GovernorEstablished.Add(DA_GovernorEstablished)