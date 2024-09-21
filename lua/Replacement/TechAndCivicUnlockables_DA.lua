



function GetUnlockablesForTech( techType, playerId, unlockables )

	-- Ensure a string civic type rather than hash or index.
	local techInfo = GameInfo.Technologies[techType];
	techType = techInfo.TechnologyType;

	function CanUnlockWithThisTech(item) 
		for row in GameInfo.AdditionalUnlockables() do
			if item[2] == row.ItemType and row.ResearchType == techType then
				return true
			end
		end

		return (item[1].PrereqTech == techType) or (item[1].InitiatorPrereqTech == techType);

	end
		
	if unlockables == nil then
		-- Support optionally passing in the unlockables table, which is expensive to calculate
		unlockables = GetFilteredUnlockableItems(playerId);
	end

	local results = {};
	for i, unlockable in ipairs(unlockables) do
		if(CanUnlockWithThisTech(unlockable)) then
			table.insert(results, {select(2,unpack(unlockable))});
		end
	end

	return results;
end

function GetUnlockablesForCivic(civicType, playerId)

	-- Treat -1 NO_PLAYER as nil.
	if(type(playerId) == "number" and playerId < 0) then
		playerId = nil;
	end
	
	-- Ensure a string civic type rather than hash or index.
	local civicInfo = GameInfo.Civics[civicType];
	civicType = civicInfo.CivicType;

	function CanUnlockWithCivic(item) 

		for row in GameInfo.AdditionalUnlockables() do
			if item[2] == row.ItemType and row.ResearchType == civicType then
				return true
			end
		end
		if string.find(item[2], 'DA_COPY_') ~= nil then
			return false
		end

		return item[1].PrereqCivic == civicType or item[1].InitiatorPrereqCivic == civicType;
	end
		
	-- Populate a complete list of unlockables.
	-- This must be a complete list because some replacement items exist with different prereqs than
	-- that which they replace.
	local unlockables = GetUnlockableItems(playerId);

	-- SHIMMY SHIM SHIM
	-- This is gifted via a modifier and we presently don't 
	-- support scrubbing modifiers to add to unlockables. 
	-- Maybe in a patch :)
	if(civicType == "CIVIC_DIPLOMATIC_SERVICE") then
		local spy = GameInfo.Units["UNIT_SPY"]
		if(spy) then
			table.insert(unlockables, {spy, spy.UnitType, spy.Name});
		end
	end

	-- Filter out replaced items. 
	-- (Only do this if we have a player specified, otherwise this would filter ALL replaced items).
	if(playerId ~= nil) then
		unlockables = RemoveReplacedUnlockables(unlockables, playerId)
	end

	local results = {};
	for i, unlockable in ipairs(unlockables) do
		if(CanUnlockWithCivic(unlockable)) then
			table.insert(results, {select(2,unpack(unlockable))});
		end
	end

	return results;
end


