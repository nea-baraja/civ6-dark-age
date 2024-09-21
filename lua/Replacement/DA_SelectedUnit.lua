-- =================================================================================
-- Import base file
-- =================================================================================
local files = {
    -- "SelectedUnit_Expansion2.lua",
    "SelectedUnit.lua",
}

for _, file in ipairs(files) do
    include(file)
    if Initialize then
        print("DA Loading " .. file .. " as base file");
        break
    end
end

include("AnimeDiversity_GreatPeople_Common");
-- local CITY_CENTER_INDEX = GameInfo.Districts["DISTRICT_CITY_CENTER"].Index;
-- local SPACE_PORT_INDEX = GameInfo.Districts["DISTRICT_SPACEPORT"].Index;
-- local DISTRICT_WONDER_INDEX = GameInfo.Districts["DISTRICT_WONDER"].Index;
GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;


-- SelectedUnit_Expansion2.lua
-- ===========================================================================
-- OVERRIDE BASE FUNCTIONS
-- ===========================================================================
function RealizeGreatPersonLens(kUnit:table )
    UILens.ClearLayerHexes(m_HexColoringGreatPeople);
    if UILens.IsLayerOn( m_HexColoringGreatPeople ) then
        UILens.ToggleLayerOff(m_HexColoringGreatPeople);
    end
    if kUnit ~= nil and ( not UI.IsGameCoreBusy() ) then
        local playerID:number = kUnit:GetOwner();
        if playerID == Game.GetLocalPlayer() then
            local kUnitArchaeology:table = kUnit:GetArchaeology();
            local kUnitGreatPerson:table = kUnit:GetGreatPerson();
            local kUnitRockBand:table = kUnit:GetRockBand();
            local bCanCauseDisasters:boolean = false;
            local sUnitType = GameInfo.Units[kUnit:GetUnitType()].UnitType;
            if (sUnitType ~= nil and GameInfo.Units_XP2[sUnitType] ~= nil and GameInfo.Units_XP2[sUnitType].CanCauseDisasters ~= nil) then
                bCanCauseDisasters = GameInfo.Units_XP2[sUnitType].CanCauseDisasters;
            end
            if kUnitGreatPerson ~= nil and kUnitGreatPerson:IsGreatPerson() then
                local greatPersonInfo:table = GameInfo.GreatPersonIndividuals[kUnitGreatPerson:GetIndividual()];
                -- Highlight an area around the Great Person (if they have an area of effect trait)
                local areaHighlightPlots:table = {};
                if (greatPersonInfo ~= nil and greatPersonInfo.AreaHighlightRadius ~= nil) then
                    areaHighlightPlots = kUnitGreatPerson:GetAreaHighlightPlots();
                end
                -- Highlight the plots the Great Person could use its action on
                local activationPlots:table = {};
                if (greatPersonInfo ~= nil and greatPersonInfo.ActionEffectTileHighlighting ~= nil and greatPersonInfo.ActionEffectTileHighlighting) then
                    local rawActivationPlots:table = kUnitGreatPerson:GetActivationHighlightPlots();
                    for _,plotIndex:number in ipairs(rawActivationPlots) do
                        table.insert(activationPlots, {"Great_People", plotIndex});
                    end
                end
                UILens.SetLayerHexesArea(m_HexColoringGreatPeople, playerID, areaHighlightPlots, activationPlots);
                UILens.ToggleLayerOn(m_HexColoringGreatPeople);
            elseif( kUnitArchaeology ~= nil and GameInfo.Units[kUnit:GetUnitType()].ExtractsArtifacts == true) then 
                -- Highlight plots that can activated by Archaeologists
                local activationPlots:table = {};
                local rawActivationPlots:table = kUnitArchaeology:GetActivationHighlightPlots();
                for _,plotIndex:number in ipairs(rawActivationPlots) do
                    table.insert(activationPlots, {"Great_People", plotIndex});
                end
                    
                UILens.SetLayerHexesArea(m_HexColoringGreatPeople, playerID, {}, activationPlots);
                UILens.ToggleLayerOn(m_HexColoringGreatPeople);
            elseif GameInfo.Units[kUnit:GetUnitType()].ParkCharges > 0 and kUnit:GetParkCharges() > 0 then -- Highlight plots that can activated by Naturalists
                local parkPlots:table = {};
                local rawParkPlots:table = Game.GetNationalParks():GetPossibleParkTiles(playerID);
                for _,plotIndex:number in ipairs(rawParkPlots) do
                    table.insert(parkPlots, {"Great_People", plotIndex});
                end
                UILens.SetLayerHexesArea(m_HexColoringGreatPeople, playerID, {}, parkPlots);
                UILens.ToggleLayerOn(m_HexColoringGreatPeople);
            elseif kUnitRockBand ~= nil and GameInfo.Units[kUnit:GetUnitType()].UnitType == "UNIT_ROCK_BAND" then -- Highlight plots that can activated by RockBands
                -- Highlight the plots the RockBand could use its action on
                local activationPlots:table = {};
                local rawActivationPlots:table = kUnitRockBand:GetActivationHighlightPlots();
                for _,plotIndex:number in ipairs(rawActivationPlots) do
                    table.insert(activationPlots, {"Great_People", plotIndex});
                end
                    
                UILens.SetLayerHexesArea(m_HexColoringGreatPeople, playerID, {}, activationPlots);
                UILens.ToggleLayerOn(m_HexColoringGreatPeople);
            elseif bCanCauseDisasters then -- Highlight plots that this unit can trigger disasters on
                local activationPlots:table = {};
                local rawActivationPlots:table = GameClimate.GetLocationsForPossibleTriggerableEvents(playerID);
                for _,plotIndex:number in ipairs(rawActivationPlots) do
                    table.insert(activationPlots, {"Great_People", plotIndex});
                end
                    
                UILens.SetLayerHexesArea(m_HexColoringGreatPeople, playerID, {}, activationPlots);
                UILens.ToggleLayerOn(m_HexColoringGreatPeople);
            end
        end
    end
end

-- =================================================================================
-- Cache base functions
-- =================================================================================
BASE_RealizeGreatPersonLens = RealizeGreatPersonLens;

-- =================================================================================
-- Overrides
-- =================================================================================
function RealizeGreatPersonLens(kUnit:table)
    UILens.ClearLayerHexes(m_HexColoringGreatPeople);
    if UILens.IsLayerOn( m_HexColoringGreatPeople ) then
        UILens.ToggleLayerOff(m_HexColoringGreatPeople);
    end
    if kUnit ~= nil and ( not UI.IsGameCoreBusy() ) then
        local playerID:number = kUnit:GetOwner();
        if playerID == Game.GetLocalPlayer() then
            local kUnitGreatPerson:table = kUnit:GetGreatPerson();
            if kUnitGreatPerson ~= nil and kUnitGreatPerson:IsGreatPerson() then
                local rawActivationPlots = Utils.DAGreatPersonGetActivationPlots(playerID, kUnitGreatPerson:GetIndividual(), kUnit:GetID());
                if rawActivationPlots ~= nil then
                    local areaHighlightPlots:table = {};
                    local activationPlots:table = {};
                    for _, plotIndex in ipairs(rawActivationPlots) do
                        table.insert(activationPlots, {"Great_People", plotIndex});
                    end
                    UILens.SetLayerHexesArea(m_HexColoringGreatPeople, playerID, areaHighlightPlots, activationPlots);
                    UILens.ToggleLayerOn(m_HexColoringGreatPeople);
                    return;
                end
            end
        end
    end
    BASE_RealizeGreatPersonLens(kUnit);
end
