

Base_IA_ViewPanelAmenities = ViewPanelAmenities;
-- ===========================================================================
function ViewPanelAmenities( data:table )
   Base_IA_ViewPanelAmenities(data);
    local iGrowthPercent = Round(1 + (data.HappinessGrowthModifier/100), 2);
    local newGrowthinfo = GetColorPercentString(iGrowthPercent) .. 
            " "..
            "人口增长" .. 
            "[NEWLINE]" ..
            GetColorPercentString(Round(1 + (data.HappinessYieldForDA[YieldTypes.CULTURE]/100), 2)) .. 
            " "..
            "文化值产出[NEWLINE]"..
            GetColorPercentString(Round(1 + (data.HappinessYieldForDA[YieldTypes.SCIENCE]/100), 2)) .. 
            " "..
            "科技值产出[NEWLINE]"..
            GetColorPercentString(Round(1 + (data.HappinessYieldForDA[YieldTypes.PRODUCTION]/100), 2)) .. 
            " "..
            "生产力产出[NEWLINE]"..
            GetColorPercentString(Round(1 + (data.HappinessYieldForDA[YieldTypes.GOLD]/100), 2)) .. 
            " "..
            "金币产出[NEWLINE]"..
            GetColorPercentString(Round(1 + (data.HappinessYieldForDA[YieldTypes.FAITH]/100), 2)) .. 
            " "..
            "信仰值产出";
    Controls.CitizenGrowth:SetText( newGrowthinfo );
    Controls.CitizenGrowth:GetParent():SetSizeY(110);
end

