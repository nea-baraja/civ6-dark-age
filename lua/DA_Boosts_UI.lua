

function DA_Boost_Set_Count(playerID, ItemType, way, count)
	local pPlayer = Players[playerID];
	local BoostTriggerCount = pPlayer:GetProperty("DA_Boost_"..ItemType) or {};
	BoostTriggerCount[way] = count;
	kParameters.playerID = playerID
	kParameters.key = "DA_Boost_"..ItemType
	kParameters.value = BoostTriggerCount
	kParameters.OnStart = "OP_SetPlayerProperty";
	UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters);
	--pPlayer:SetProperty("DA_Boost_"..ItemType, BoostTriggerCount);
end

function DA_Boost_Adjust_Count(playerID, ItemType, way, count)
	local pPlayer = Players[playerID]
	local BoostTriggerCount = pPlayer:GetProperty("DA_Boost_"..ItemType) or {};
	BoostTriggerCount[way] = BoostTriggerCount[way] or 0;
	BoostTriggerCount[way] = BoostTriggerCount[way] + count;
	kParameters.playerID = playerID
	kParameters.key = "DA_Boost_"..ItemType
	kParameters.value = BoostTriggerCount
	kParameters.OnStart = "OP_SetPlayerProperty";
	UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters);
	--pPlayer:SetProperty("DA_Boost_"..ItemType, BoostTriggerCount);
end




