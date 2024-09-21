
local files = {
    "TopPanel.lua",
	"TopPanel_Expansion1.lua",
    "TopPanel_Expansion2.lua"
}

for _, file in ipairs(files) do
    include(file)
end

include( "SupportFunctions" ); -- Round(必要调用)

GameEvents = ExposedMembers.GameEvents;
ExposedMembers.DA = ExposedMembers.DA or {};
ExposedMembers.DA.Utils = ExposedMembers.DA.Utils or {};
Utils = ExposedMembers.DA.Utils;

local greatMerID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_MERCHANT'].Index
local greatProID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_PROPHET'].Index


local ProphetBonus = 0;
local MerchantBonus = 0;

function DATurnActivated(playerID, bIsFirstTime)
    local pPlayer = Players[playerID];
    if playerID == nil then return end
    local iMerchantModifier = Utils.GetEnlightmentModifier('GREAT_PERSON_CLASS_MERCHANT');
    if iMerchantModifier ~= 0 then
        local pPlayerTreasury = pPlayer:GetTreasury();
        local iGoldYield = pPlayerTreasury:GetGoldYield();
        if iGoldYield > 0 then
            local iMerchantBonus = iGoldYield * 0.05 * iMerchantModifier;
            iMerchantBonus = math.floor(iMerchantBonus);
            if bIsFirstTime then
                GameEvents.AddGreatPeoplePoints.Call(playerID, greatMerID, iMerchantBonus);
            end
            MerchantBonus = iMerchantBonus;
        end
    end
    local iProphetModifier = Utils.GetEnlightmentModifier('GREAT_PERSON_CLASS_PROPHET');
    if iProphetModifier ~= nil then
        local pGreatPeople  :table  = Game.GetGreatPeople();
        local pTimeline:table = nil;
        local earnConditions        :string = nil;
        pTimeline = pGreatPeople:GetTimeline();
        for i,entry in ipairs(pTimeline) do
            if entry.Class == greatProID then
                if (entry.Individual ~= nil) then
                    earnConditions = pGreatPeople:GetEarnConditionsText(displayPlayerID, entry.Individual);
                end
            end
        end
        if earnConditions == nil or earnConditions == "" then
            local pPlayerReligion = pPlayer:GetReligion();
            local iFaithYield = pPlayerReligion:GetFaithYield();
            if iFaithYield > 0 then
                local iProphetBonus = iFaithYield * 0.1 * iProphetModifier;
                iProphetBonus = math.floor(iProphetBonus);
                if bIsFirstTime then
                    GameEvents.AddGreatPeoplePoints.Call(playerID, greatProID, iProphetBonus);
                end
                ProphetBonus = iProphetBonus;
            end
        else 
            ProphetBonus = 0;
        end
    end
end


function GetFaithTooltip()
    local szReturnValue = "";

    local localPlayerID = Game.GetLocalPlayer();
    if (localPlayerID ~= -1) then
        local playerReligion        :table  = Players[localPlayerID]:GetReligion();
        local faithYield            :number = playerReligion:GetFaithYield();
        local faithBalance          :number = playerReligion:GetFaithBalance();

        szReturnValue = Locale.Lookup("LOC_TOP_PANEL_FAITH_YIELD");
        local faith_tt_details = playerReligion:GetFaithYieldToolTip();
        if(#faith_tt_details > 0) then
            szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]" .. faith_tt_details;
        end
    end

    
    if ProphetBonus ~= 0 then
      szReturnValue = szReturnValue.."[NEWLINE]本回合获得"..ProphetBonus.." [ICON_GreatProphet] 大预言家点数来自 [icon_enlightment] 启明" end
    return szReturnValue;
end



function GetGoldTooltip()
    local szReturnValue = "";

    local localPlayerID = Game.GetLocalPlayer();
    if (localPlayerID ~= -1) then
        local playerTreasury:table  = Players[localPlayerID]:GetTreasury();

        local income_tt_details = playerTreasury:GetGoldYieldToolTip();
        local expense_tt_details = playerTreasury:GetTotalMaintenanceToolTip();

        szReturnValue = Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD");
        szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
        szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_INCOME", playerTreasury:GetGoldYield());
        if(#income_tt_details > 0) then
            szReturnValue = szReturnValue .. "[NEWLINE]" .. income_tt_details;
        end

        szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
        szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_EXPENSE", -playerTreasury:GetTotalMaintenance());
        if(#expense_tt_details > 0) then
            szReturnValue = szReturnValue .. "[NEWLINE]" .. expense_tt_details;
        end
    end

    if MerchantBonus ~= 0 then
      szReturnValue = szReturnValue.."[NEWLINE]本回合获得"..MerchantBonus.." [ICON_GreatMerchant] 大商人点数来自 [icon_enlightment] 启明";
    end
    return szReturnValue;
end


BASE_RefreshAll = RefreshAll;
function RefreshAll()
    BASE_RefreshAll();
    RefreshGovernors();
end


function RefreshGovernors(iUnkonwn, iRefresh)
    local localPlayer = Players[Game.GetLocalPlayer()];
    if (localPlayer == nil) then
        return;
    end
    local playerGovernors = localPlayer:GetGovernors();
    local governorPointsObtained = playerGovernors:GetGovernorPoints();
    local governorPointsSpent = playerGovernors:GetGovernorPointsSpent();
    local hidedGovernors = localPlayer:GetProperty('PROP_HIDE_GOVERNOR') or 0;
    local currentGovernors = governorPointsObtained - governorPointsSpent - hidedGovernors;

    local unityBalance = localPlayer:GetProperty('PROP_UNITY_BALANCE') or 0;
    local unityRateFromDoublePolicy = localPlayer:GetProperty('PROP_UNITY_RATE_FROM_DOUBLE_POLICY') or 0;
    local unityRate = localPlayer:GetProperty('PROP_UNITY_RATE_FROM_OTHERS') or 0;
    local unityThreshold = localPlayer:GetProperty('PROP_UNITY_THRESHOLD') or 200;
    if iRefresh ~= nil then
        currentGovernors = currentGovernors - iRefresh;
    end

    local sTooltip = "";

    if (currentGovernors > 0) then
        sTooltip = sTooltip .. Locale.Lookup("LOC_TOP_PANEL_UNITY_TOOLTIP_GOVERNORS", currentGovernors);
        sTooltip = sTooltip .. "[NEWLINE][NEWLINE]";
    end
    sTooltip = sTooltip .. Locale.Lookup("LOC_TOP_PANEL_UNITY_TOOLTIP_THRESHOLD", unityThreshold);
    sTooltip = sTooltip .. "[NEWLINE][NEWLINE]";
    sTooltip = sTooltip .. Locale.Lookup("LOC_TOP_PANEL_UNITY_TOOLTIP_BALANCE", unityBalance);
    sTooltip = sTooltip .. "[NEWLINE]";
    sTooltip = sTooltip .. Locale.Lookup("LOC_TOP_PANEL_UNITY_TOOLTIP_RATE", unityRate);
    sTooltip = sTooltip .. "[NEWLINE]";
    if unityRateFromDoublePolicy > 0 then
        sTooltip = sTooltip .. Locale.Lookup("LOC_TOP_PANEL_UNITY_TOOLTIP_RATE_FROM_DOUBLE_POLICY", unityRateFromDoublePolicy);
        sTooltip = sTooltip .. "[NEWLINE]";
    end
    sTooltip = sTooltip .. "[NEWLINE]";
    sTooltip = sTooltip .. Locale.Lookup("LOC_TOP_PANEL_UNITY_TOOLTIP_SOURCES_HELP");
    
    local meterRatio = unityBalance / unityThreshold;
    if (meterRatio < 0) then
        meterRatio = 0;
    elseif (meterRatio > 1) then
        meterRatio = 1;
    end
    Controls.GovernorsMeter:SetPercent(meterRatio);
    Controls.GovernorsNumber:SetText(tostring(currentGovernors));
    Controls.Governors:SetToolTipString(sTooltip);
    Controls.GovernorsStack:CalculateSize();
end





local function DAInitialize()
    Events.LoadGameViewStateDone.Add(function()
        Events.PlayerTurnActivated.Add(DATurnActivated);
    end)
    Events.GovernorPointsChanged.Add(RefreshGovernors);
    LuaEvents.GovernorPointsHided.Add(RefreshGovernors);
    DATurnActivated(Game.GetLocalPlayer(), false);
    Controls.Governors:RegisterCallback( Mouse.eMouseEnter, RefreshGovernors);

end

DAInitialize()



