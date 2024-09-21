-- ===========================================================================
--
--	City Support
--	Civilization VI, Firaxis Games

-- DA IA, nea_baraja
-- This file should be included in CitySupport.lua(Darkage)

-- ===========================================================================

-- ===========================================================================
--	Update the yield data for a city.
-- ===========================================================================
-- UpdateYieldData_BASE_IA = UpdateYieldData;

-- function UpdateYieldData( pCity:table, data:table )
--     data = UpdateYieldData_BASE_IA(pCity, data);
--     data = UpdateCityYieldData(pCity, data);
--     return data;
-- end

-- ===========================================================================
--	For a given city, return a table o' data for it and the surrounding
--	districts.
--	RETURNS:	table of data
-- ===========================================================================
GetCityData_BASE_IA = GetCityData;

function GetCityData( pCity:table )
    data = GetCityData_BASE_IA(pCity);
    data.HappinessYieldForDA = {};
    data.HappinessYieldForDA[YieldTypes.CULTURE]   = GetHappinessYieldForDA_data(YieldTypes.CULTURE, data.AmenitiesNetAmount, pCity, Players[pCity:GetOwner()]);
    data.HappinessYieldForDA[YieldTypes.FAITH]     = GetHappinessYieldForDA_data(YieldTypes.FAITH, data.AmenitiesNetAmount, pCity, Players[pCity:GetOwner()]);
    data.HappinessYieldForDA[YieldTypes.GOLD]      = GetHappinessYieldForDA_data(YieldTypes.GOLD, data.AmenitiesNetAmount, pCity, Players[pCity:GetOwner()]);
    data.HappinessYieldForDA[YieldTypes.PRODUCTION]= GetHappinessYieldForDA_data(YieldTypes.PRODUCTION, data.AmenitiesNetAmount, pCity, Players[pCity:GetOwner()]);
    data.HappinessYieldForDA[YieldTypes.SCIENCE]   = GetHappinessYieldForDA_data(YieldTypes.SCIENCE, data.AmenitiesNetAmount, pCity, Players[pCity:GetOwner()]);
    return data;
end

--DA Happiness
function GetHappinessYieldForDA_data( yieldEnum:number , amenity:number, pCity, pPlayer)
    local pBuildings = pCity:GetBuildings();
    local bOlympic = pBuildings:HasBuilding(GameInfo.Buildings['BUILDING_CITY_POLICY_OLYMPIC'].Index);
    local bSlave = pBuildings:HasBuilding(GameInfo.Buildings['BUILDING_CITY_POLICY_SLAVE_GLADIATUS'].Index);
    local iGov = pPlayer:GetCulture():GetCurrentGovernment();
    local bRepublic = false;        
    if iGov ~= nil and iGov ~= -1 then
        bRepublic = GameInfo.Governments[iGov].GovernmentType == 'GOVERNMENT_CLASSICAL_REPUBLIC';
    end


    local iBuff = 0;
    local iDebuff = 0;
    if amenity > 9 then 
        iBuff = 30;
    elseif amenity > -9 then 
        iBuff = math.floor(amenity / 2) * 6;
    else
        iBuff = -30;
    end
    if (bRepublic == true) then iBuff = iBuff * 2; end


    if yieldEnum == YieldTypes.CULTURE or yieldEnum == YieldTypes.SCIENCE then 
        if (amenity < 0 and bSlave == true) then
            return 0;
        else
            return iBuff;
        end
    elseif yieldEnum == YieldTypes.GOLD or yieldEnum == YieldTypes.PRODUCTION then 
        if (amenity > 1 and bOlympic == true) then
            return 0;
        else
            return - iBuff;
        end
    elseif yieldEnum == YieldTypes.FAITH then
        if (amenity > 1 and bOlympic == true) then
            return iBuff;
        else
            return 0;
        end
    else
        return 0;
    end

end


-- ===========================================================================
-- Start DA_logic:
-- ===========================================================================
-- CityYield = ExposedMembers.DA.CityYield;
-- function UpdateCityYieldData( pCity:table, data:table )
--     local fromModifierTemp = Locale.Lookup("LOC_CITY_YIELD_FROM_GAMEEFFECTS_TOOLTIP", 0)
--     local fromModifierSuffix = fromModifierTemp:gsub("+0", "");

--     local playerID = pCity:GetOwner();
--     local cityID = pCity:GetID();

--     data.CulturePerTurnToolTip = UpdateCityYieldToolTip(playerID, cityID, data.CulturePerTurnToolTip, "YIELD_CULTURE", fromModifierSuffix);
--     data.FaithPerTurnToolTip = UpdateCityYieldToolTip(playerID, cityID, data.FaithPerTurnToolTip, "YIELD_FAITH", fromModifierSuffix);
--     data.FoodPerTurnToolTip = UpdateCityYieldToolTip(playerID, cityID, data.FoodPerTurnToolTip, "YIELD_FOOD", fromModifierSuffix);
--     data.GoldPerTurnToolTip = UpdateCityYieldToolTip(playerID, cityID, data.GoldPerTurnToolTip, "YIELD_GOLD", fromModifierSuffix);
--     data.ProductionPerTurnToolTip = UpdateCityYieldToolTip(playerID, cityID, data.ProductionPerTurnToolTip, "YIELD_PRODUCTION", fromModifierSuffix);
--     data.SciencePerTurnToolTip = UpdateCityYieldToolTip(playerID, cityID, data.SciencePerTurnToolTip, "YIELD_SCIENCE", fromModifierSuffix);
--     --print(data.CulturePerTurnToolTip)
--     return data;
-- end


function GetHappinessYieldForDA( yieldType:string , amenity:number, playerID:number, cityID:number)
    local pCity = CityManager.GetCity(playerID, cityID);
    local pBuildings = pCity:GetBuildings();
    local bOlympic = pBuildings:HasBuilding(GameInfo.Buildings['BUILDING_CITY_POLICY_OLYMPIC'].Index);
    local bSlave = pBuildings:HasBuilding(GameInfo.Buildings['BUILDING_CITY_POLICY_SLAVE_GLADIATUS'].Index);
    local pPlayer = Players[playerID];
    local iGov = pPlayer:GetCulture():GetCurrentGovernment();
    local bRepublic = false;        
    if iGov ~= nil and iGov ~= -1 then
        bRepublic = GameInfo.Governments[iGov].GovernmentType == 'GOVERNMENT_CLASSICAL_REPUBLIC';
    end
    local iBuff = 0;
    local iDebuff = 0;
    if amenity > 9 then 
        iBuff = 30;
    elseif amenity > -9 then 
        iBuff = math.floor(amenity / 2) * 6;
    else
        iBuff = -30;
    end
    if (bRepublic == true) then iBuff = iBuff * 2; end
    if yieldType == 'YIELD_CULTURE' or yieldType == 'YIELD_SCIENCE' then 
        if (amenity < 0 and bSlave == true) then
            return 0;
        else
            return iBuff;
        end
    elseif yieldType == 'YIELD_GOLD' or yieldType == 'YIELD_PRODUCTION' then 
        if (amenity > 1 and bOlympic == true) then
            return 0;
        else
            return - iBuff;
        end
    elseif yieldType == 'YIELD_FAITH' then
        if (amenity > 1 and bOlympic == true) then
            return iBuff;
        else
            return 0;
        end
    else
        return 0;
    end  
end


UpdateCityYieldToolTip_BASE_IA = UpdateCityYieldToolTip;

function UpdateCityYieldToolTip(playerID, cityID, tooltip, yieldType, fromModifierSuffix)
    tooltip = UpdateCityYieldToolTip_BASE_IA(playerID, cityID, tooltip, yieldType, fromModifierSuffix);

    local tooltipLines = {};
    local modifierPattern = "(%+*%-*%d*%.?%d+)" .. fromModifierSuffix;
    local modifierPattern2 = "(%+*%-*%d*)%%（(%+*%-*%d*%.?%d+)）" .. fromModifierSuffix;
    local pCity = CityManager.GetCity(playerID, cityID);
    -- Separate the tooltips into lines.
    -- Replace "[NEWLINE]" with ";" assuming there's no ";" in the tooltip.
    local newTooltip = string.gsub(tooltip, "%[NEWLINE%]", ";");

    for line in string.gmatch(newTooltip, "([^;]+)") do
        local fromModifierAmountStr = line:match(modifierPattern);
        local _, _, d1, d2 = line:find(modifierPattern2);

        if d1 and d1 ~= 0 then
            local pCityGrowth = pCity:GetGrowth();
            local iAmenity = pCityGrowth:GetAmenities() - pCityGrowth:GetAmenitiesNeeded();
            local amenityFix = GetHappinessYieldForDA(yieldType, iAmenity, playerID, cityID);
            local amount1 = tonumber(d1);
            local amount2 = tonumber(d2);
            local amenityFixAmount = amenityFix * amount2 / amount1;
            amount1 = amount1 - amenityFix;
            amount2 = amount2 - amenityFixAmount;
            local newLine_amenity = Locale.Lookup('LOC_CITY_YIELD_FROM_AMENITY_TOOLTIP', amenityFix, amenityFixAmount);
            table.insert(tooltipLines, newLine_amenity);
            if amount1 ~= 0 then
                local newLine_fromModifier = Locale.Lookup('LOC_CITY_YIELD_FROM_GAMEEFFECTS_MOD_TOOLTIP', amount1, amount2);
                table.insert(tooltipLines, newLine_fromModifier);
            end
        elseif fromModifierAmountStr then
            -- It's the "from modifier" line, edit it and add new lines.
            fromModifierAmount = tonumber(fromModifierAmountStr);

            -- Loop through each city yield type and add new lines.
            for typeKey, typeName in pairs(CityYield.Type) do
                local yield = CityYield.GetYield(playerID, cityID, yieldType, typeName);
                if yield ~= 0 then
                    -- Has yield for the given source type, add a new line.
                    local lineTextKey = "LOC_CITY_YIELD_FROM_" .. typeName .. "_TOOLTIP";
                    local newLine = Locale.Lookup(lineTextKey, yield);
                    table.insert(tooltipLines, newLine);
                    -- Update amount for "from modifier"
                    fromModifierAmount = fromModifierAmount - yield;
                end
            end

            -- Add the "from modifier" line with updated amount if not 0.
            if fromModifierAmount ~= 0 then
                local fromModifierLine = Locale.Lookup("LOC_CITY_YIELD_FROM_GAMEEFFECTS_TOOLTIP", fromModifierAmount);
                table.insert(tooltipLines, fromModifierLine);
            end
        else
            table.insert(tooltipLines, line);
        end
    end

    -- Convert the tooltip lines back to single string.
    return table.concat(tooltipLines, "[NEWLINE]");
end


-- ===========================================================================
-- End DA_logic:
-- ===========================================================================
