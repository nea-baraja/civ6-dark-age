ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;
GameEvents = ExposedMembers.GameEvents;

----罗马，凯撒，凯撒
function OnGovernmentChanged(playerID,governmentID)
	if not Utils.PlayerHasTrait(playerID,"TRAIT_LEADER_CAESAR") then
		return
	end
	if governmentID == -1 then
		return
	end
	local pPlayer = Players[playerID]
	local pPlayerAllGovernment = pPlayer:GetProperty("pPlayerAllGovernment") or {}
	table.insert(pPlayerAllGovernment,governmentID)
	pPlayer:SetProperty("pPlayerAllGovernment",pPlayerAllGovernment)
	
	if pPlayer:GetProperty("TRAIT_LEADER_CAESAR") == true then
		GameEvents.TriggerCommonEvent.Call(playerID, 'EVENT_COMMON_CAESAR_CHANGE_GOVENRMENT')
		GetPrevGovernmentEffect(playerID)
	end
	
end

Events.GovernmentChanged.Add(OnGovernmentChanged)

function OnOriginalCapitalOwnerChange(playerID,cityID,iX,iY)
	if not Utils.PlayerHasTrait(playerID,"TRAIT_LEADER_CAESAR") then
		return
	end
	
	local pPlayer = Players[playerID]
	if pPlayer:GetProperty("TRAIT_LEADER_CAESAR") == true then
		return
	end
	
	local AllPlayers = Game.GetPlayers()
	local OriginalCapital = false
	local pCity = CityManager.GetCity(playerID,cityID)
    for i,player in pairs(AllPlayers) do
		if player:IsMajor() then
			if player:GetCities():GetOriginalCapitalCity() == pCity and player:GetID() ~= playerID then
				OriginalCapital = true
				break
			end
		end
    end
	if OriginalCapital == false then
		return
	end
	
	pPlayer:SetProperty("TRAIT_LEADER_CAESAR",true)
	GameEvents.TriggerCommonEvent.Call(playerID, 'EVENT_COMMON_CAESAR_WAKE')
	GetPrevGovernmentEffect(playerID)
	
end
GameEvents.CityBuilt.Add(OnOriginalCapitalOwnerChange)

function GetPrevGovernmentEffect(playerID)
	pPlayer = Players[playerID]
	local pPlayerCapital = pPlayer:GetCities():GetCapitalCity()
	if pPlayerCapital == nil then
		return
	end
	local pPlayerAllGovernment = pPlayer:GetProperty("pPlayerAllGovernment")
	if pPlayerAllGovernment == nil then
		return
	end
	local iX, iY = pPlayerCapital:GetX(), pPlayerCapital:GetY()
    local pPlayerCapitalPlot = Map.GetPlot(iX,iY)
    local pPlayerCapitalPlotID = pPlayerCapitalPlot:GetIndex()
	
	if #pPlayerAllGovernment > 1 then
		local PrveGovernmentId = pPlayerAllGovernment[#pPlayerAllGovernment-1]
		local PrveGovernmentType:string = GameInfo.Governments[PrveGovernmentId].GovernmentType
		GameEvents.SetPlotProperty.Call(pPlayerCapitalPlotID,"DA_CAESAR_PROPERTY_"..PrveGovernmentType,1)
		if #pPlayerAllGovernment > 2 then
			local PrvePropertyGovernmentId = pPlayerAllGovernment[#pPlayerAllGovernment-2]
			local PrvePropertyGovernmentType:string = GameInfo.Governments[PrvePropertyGovernmentId].GovernmentType
			GameEvents.SetPlotProperty.Call(pPlayerCapitalPlotID,"DA_CAESAR_PROPERTY_"..PrvePropertyGovernmentType,nil)
		end
	end
end