local tCityBannerVersions = {
    "CityPanelOverview_CityPolicies_Suk.lua",
    "CityPanelOverview_CityPolicies.lua",
    "CityPanelOverview_Expansion2.lua",
    "CityPanelOverview_Expansion1.lua",
    "CityPanelOverview.lua",
}

for _, sVersion in ipairs(tCityBannerVersions) do
    include(sVersion)
    if Initialize then
        print("DA_CityPanelOverview loading " .. sVersion .. " as base file")
        break
    end
end


local m_kBuildingsIM        :table = InstanceManager:new( "BuildingInstance",           "Top");
local m_kDistrictsIM        :table = InstanceManager:new( "DistrictInstance",           "Top", Controls.BuildingAndDistrictsStack );
local m_kHousingIM          :table = InstanceManager:new( "HousingInstance",            "Top", Controls.HousingStack );
local m_kOtherReligionsIM   :table = InstanceManager:new( "OtherReligionInstance",      "Top", Controls.OtherReligions );
local m_kProductionIM       :table = InstanceManager:new( "ProductionInstance",         "Top", Controls.ProductionQueueStack );
local m_kReligionsBeliefsIM :table = InstanceManager:new( "ReligionBeliefsInstance",    "Top", Controls.ReligionBeliefsStack );
local m_kTradingPostsIM     :table = InstanceManager:new( "TradingPostInstance",        "Top", Controls.TradingPostsStack );
local m_kWondersIM          :table = InstanceManager:new( "WonderInstance",             "Top", Controls.WondersStack );
local m_kKeyStackIM         :table = InstanceManager:new( "KeyEntry",                   "KeyColorImage", Controls.KeyStack );


local UV_CITIZEN_GROWTH_STATUS        :table    = {};
        UV_CITIZEN_GROWTH_STATUS[0] = {u=0, v=0};        
        UV_CITIZEN_GROWTH_STATUS[1] = {u=0, v=0};        
        UV_CITIZEN_GROWTH_STATUS[2] = {u=0, v=0};        
        UV_CITIZEN_GROWTH_STATUS[3] = {u=0, v=0};        
        UV_CITIZEN_GROWTH_STATUS[4] = {u=0, v=50};        
        UV_CITIZEN_GROWTH_STATUS[5] = {u=0, v=100};        
        UV_CITIZEN_GROWTH_STATUS[6] = {u=0, v=150};       
        UV_CITIZEN_GROWTH_STATUS[7] = {u=0, v=200};        
        UV_CITIZEN_GROWTH_STATUS[8] = {u=0, v=250};  
        UV_CITIZEN_GROWTH_STATUS[9] = {u=0, v=300};     
        UV_CITIZEN_GROWTH_STATUS[10] = {u=0, v=350};    

local WorkerAmenityCostQuery = DB.Query("select ItemType, Amount from CitizenBonus where BonusType = 'CITIZEN_AMENITY'");
local WorkerAmenityCostTable = {};
for _, row in ipairs(WorkerAmenityCostQuery) do
    WorkerAmenityCostTable[row.ItemType] = row.Amount;
end

Base_ViewPanelAmenities = ViewPanelAmenities;
-- ===========================================================================
function ViewPanelAmenities( data:table )
    g_kAmenitiesIM:DestroyInstances();
    local isFinished, errMsg = pcall(Base_ViewPanelAmenities, data);

    -- No need to do extra processing if there's no error.
    if not isFinished then 
        if (IsHappinessOutOfBoundError(errMsg)) then
            -- If the error is Happiness out of bound (due to newly added happiness level), complete the rest of the UI rendering with new values.
            -- From Base CityPanelOverview
            local colorName:string = GetHappinessColor(data.Happiness);
            Controls.CitizenGrowthStatus:SetTextureOffsetVal( UV_CITIZEN_GROWTH_STATUS[data.Happiness].u, UV_CITIZEN_GROWTH_STATUS[data.Happiness].v );
            Controls.CitizenGrowthStatusIcon:SetColorByName( colorName );
            -- From CityPanelOverview_Expansion1
            -- kInstance = g_kAmenitiesIM:GetInstance();
            -- kInstance.Amenity:SetText( Locale.Lookup("LOC_HUD_CITY_AMENITIES_LOST_FROM_GOVERNORS") );
            -- kInstance.AmenityYield:SetText( Locale.ToNumber(data.AmenitiesFromGovernors) );
            --local iInstances = kInstance.m_iAllocatedInstances;

            -- Hide all 0 amenity sources
        else
            -- Otherwise throw out the error.
            error(errMsg);
        end
    end
    for i, pInstance in pairs(g_kAmenitiesIM.m_AllocatedInstances) do
        if pInstance.Amenity:GetText() == Locale.Lookup("LOC_HUD_CITY_AMENITIES_FROM_DISTRICTS") then
            local rawDisAmenity = tonumber(pInstance.AmenityYield:GetText());
            pInstance.AmenityYield:SetText(rawDisAmenity + data.DistrictCitizens - 1);
        end
        if pInstance.AmenityYield:GetText() == '0' then
            pInstance[g_kAmenitiesIM.m_RootControlName]:SetHide(true);
        else
            pInstance[g_kAmenitiesIM.m_RootControlName]:SetHide(false);
        end
    end 

    local WorkerAmenityCost = 0;
    local WorkerAmenityBonus = 0;

    for _, row in pairs(data.BuildingsAndDistricts) do
        if WorkerAmenityCostTable[row.Type] ~= nil and WorkerAmenityCostTable[row.Type] < 0 then
            WorkerAmenityCost = WorkerAmenityCost - WorkerAmenityCostTable[row.Type] * row.Citizens;
        elseif WorkerAmenityCostTable[row.Type] ~= nil and WorkerAmenityCostTable[row.Type] > 0 then
            WorkerAmenityBonus = WorkerAmenityBonus + WorkerAmenityCostTable[row.Type] * row.Citizens;
        end
        for _, row2 in pairs(row.Buildings) do
            if WorkerAmenityCostTable[row2.Type] ~= nil and WorkerAmenityCostTable[row2.Type] < 0 then
                WorkerAmenityCost = WorkerAmenityCost - WorkerAmenityCostTable[row2.Type] * row2.Citizens;
            elseif WorkerAmenityCostTable[row2.Type] ~= nil and WorkerAmenityCostTable[row2.Type] < 0 then
                WorkerAmenityBonus = WorkerAmenityBonus + WorkerAmenityCostTable[row2.Type] * row2.Citizens;
            end
        end
    end

    
    kInstance = g_kAmenitiesIM:GetInstance();
    kInstance.Amenity:LocalizeAndSetText( 'LOC_HUD_CITY_AMENITIES_FROM_SPECIALIST' );
    kInstance.AmenityYield:SetText( Locale.ToNumber(WorkerAmenityBonus) );
    if WorkerAmenityBonus == 0 then
        kInstance[g_kAmenitiesIM.m_RootControlName]:SetHide(true);
    end

    kInstance = g_kAmenitiesIM:GetInstance();
    kInstance.Amenity:LocalizeAndSetText( 'LOC_HUD_CITY_AMENITIES_COST_FROM_POP' );
    kInstance.AmenityYield:SetText( Locale.ToNumber(data.AmenitiesRequiredNum) );
    kInstance.AmenityYield:SetColorByName('StatBadCSGlow');
        
    kInstance = g_kAmenitiesIM:GetInstance();
    kInstance.Amenity:LocalizeAndSetText( 'LOC_HUD_CITY_AMENITIES_COST_FROM_SPECIALIST' );
    kInstance.AmenityYield:SetText( Locale.ToNumber(WorkerAmenityCost) );
    kInstance.AmenityYield:SetColorByName('StatBadCSGlow');

    --Controls.AmenitiesConstructedLabel:SetText( Locale.Lookup( "LOC_HUD_CITY_AMENITY", data.AmenitiesNum + data.DistrictCitizens - 1) );
    Controls.AmenityTotalNum:SetText(Locale.ToNumber(data.AmenitiesNetAmount) );
    Controls.AmenitiesConstructedNum:SetText(data.AmenitiesNum + WorkerAmenityCost);
    Controls.AmenitiesRequiredNum:SetText(data.AmenitiesRequiredNum + WorkerAmenityCost);
    Controls.AmenitiesConstructedNum:SetColorByName( 'StatNormalCSGlow' );



end

function IsHappinessOutOfBoundError(err)
    -- The error message looks like
    -- ".....\Base\Assets\UI\Panels\CityPanelOverview.lua:524: attempt to index a nil value"
    return err ~= nil and err:find("CityPanelOverview.lua:524: attempt to index a nil value");
end

function ViewPanelBreakdown( data:table )   
    Controls.DistrictsNum:SetText( data.DistrictsNum );
    Controls.DistrictsConstructed:SetText( Locale.Lookup("LOC_HUD_CITY_DISTRICTS_CONSTRUCTED", data.DistrictsNum) );    
    Controls.DistrictsPossibleNum:SetText( data.DistrictsPossibleNum );

    m_kBuildingsIM:ResetInstances();
    m_kDistrictsIM:ResetInstances();    
    m_kTradingPostsIM:ResetInstances();
    m_kWondersIM:ResetInstances();
    local playerID = Game.GetLocalPlayer();

    -- Add districts (and their buildings)
    for _, district in ipairs(data.BuildingsAndDistricts) do
        if district.isBuilt then
            local kInstanceDistrict:table = m_kDistrictsIM:GetInstance();
            local districtName = district.Name;
            if district.isPillaged then
                districtName = districtName .. "[ICON_Pillaged]";
            end
            kInstanceDistrict.DistrictName:SetText( districtName );
            local DistrictYieldText = "";
            if district.YieldBonus ~= "" and district.YieldAdjacencyBonus ~="" then
                DistrictYieldText = "其他加成"..district.YieldBonus.."[NEWLINE]相邻加成"..district.YieldAdjacencyBonus;
            elseif district.YieldBonus ~= "" then
                DistrictYieldText = "其他加成"..district.YieldBonus;
            elseif district.YieldAdjacencyBonus ~= "" then  
                DistrictYieldText = "相邻加成"..district.YieldAdjacencyBonus;
            end
            kInstanceDistrict.DistrictYield:SetText( DistrictYieldText );
            kInstanceDistrict.DistrictYield:SetWrapWidth(4000);

            kInstanceDistrict.Icon:SetIcon( district.Icon );
            local sToolTip = ToolTipHelper.GetToolTip(district.Type, playerID)
            kInstanceDistrict.Top:SetToolTipString( sToolTip);
            for _,building in ipairs(district.Buildings) do
                if building.isBuilt then
                    local kInstanceBuild:table = m_kBuildingsIM:GetInstance(kInstanceDistrict.BuildingStack);
                    local buildingName = building.Name;
                    if building.isPillaged then
                        buildingName = buildingName .. "[ICON_Pillaged]";
                    end
                    kInstanceBuild.BuildingName:SetText( buildingName );
                    kInstanceBuild.Icon:SetIcon( building.Icon );
                    local pRow = GameInfo.Buildings[building.Type];
                    local sToolTip = ToolTipHelper.GetBuildingToolTip( pRow.Hash, playerID, m_pCity );
                    kInstanceBuild.Top:SetToolTipString( sToolTip);
                    local yieldString:string = "";
                    for _,kYield in ipairs(building.Yields) do
                        yieldString = yieldString .. GetYieldString(kYield.YieldType,kYield.YieldChange);
                    end
                    kInstanceBuild.BuildingYield:SetText( yieldString );
                    kInstanceBuild.BuildingYield:SetTruncateWidth( kInstanceBuild.Top:GetSizeX() - kInstanceBuild.BuildingName:GetSizeX() - 10 );
                end
            end
            kInstanceDistrict.BuildingStack:CalculateSize();
        end
    end

    -- Add wonders
    local hideWondersInfo :boolean = not GameCapabilities.HasCapability("CAPABILITY_CITY_HUD_WONDERS");
    local isHasWonders :boolean = (table.count(data.Wonders) > 0)
    Controls.NoWondersArea:SetHide(hideWondersInfo or isHasWonders);
    Controls.WondersArea:SetHide(hideWondersInfo or not isHasWonders);
    Controls.WondersHeader:SetHide(hideWondersInfo);

    for _, wonder in ipairs(data.Wonders) do
        local kInstanceWonder:table = m_kWondersIM:GetInstance();
        kInstanceWonder.WonderName:SetText( wonder.Name );
        local pRow = GameInfo.Buildings[wonder.Type];
        local sToolTip = ToolTipHelper.GetBuildingToolTip( pRow.Hash, playerID, m_pCity );
        kInstanceWonder.Top:SetToolTipString( sToolTip );
        local yieldString:string = "";
        for _,kYield in ipairs(wonder.Yields) do
            yieldString = yieldString .. GetYieldString(kYield.YieldType,kYield.YieldChange);
        end
        kInstanceWonder.WonderYield:SetText( yieldString );
        kInstanceWonder.Icon:SetIcon( wonder.Icon );
    end

    -- Add trading posts
    local hideTradingPostsInfo :boolean = not GameCapabilities.HasCapability("CAPABILITY_CITY_HUD_TRADING_POSTS");
    local isHasTradingPosts :boolean = (table.count(data.TradingPosts) > 0);
    Controls.NoTradingPostsArea:SetHide(hideTradingPostsInfo or isHasTradingPosts);
    Controls.TradingPostsArea:SetHide(hideTradingPostsInfo or not isHasTradingPosts);
    Controls.TradingPostsHeader:SetHide(hideTradingPostsInfo);

    if isHasTradingPosts then
        for _, tradePostPlayerId in ipairs(data.TradingPosts) do
            local pTradePostPlayer:table = Players[tradePostPlayerId]
            local pTradePostPlayerConfig:table = PlayerConfigurations[tradePostPlayerId];
            local kInstanceTradingPost  :table = m_kTradingPostsIM:GetInstance();       
            local playerName            :string = Locale.Lookup( pTradePostPlayerConfig:GetPlayerName() );

            local iconName:string = "";
            local iconSize:number = SIZE_LEADER_ICON;
            local iconColor = UI.GetColorValue("COLOR_WHITE");
            if pTradePostPlayer:IsMinor() then
                -- If we're a city-state display our city-state icon instead of leader since we don't have one
                local civType:string = pTradePostPlayerConfig:GetCivilizationTypeName();
                local primaryColor, secondaryColor = UI.GetPlayerColors(tradePostPlayerId); 
                iconName = "ICON_"..civType;
                iconColor = secondaryColor;
                iconSize = SIZE_CITYSTATE_ICON;
            else
                iconName = "ICON_"..pTradePostPlayerConfig:GetLeaderTypeName();
            end
            
            local textureOffsetX :number, textureOffsetY:number, textureSheet:string = IconManager:FindIconAtlas(iconName, iconSize);
            kInstanceTradingPost.LeaderPortrait:SetTexture(textureOffsetX, textureOffsetY, textureSheet);
            kInstanceTradingPost.LeaderPortrait:SetColor(iconColor);
            kInstanceTradingPost.LeaderPortrait:SetHide(false);
                            
            if tradePostPlayerId == Game.GetLocalPlayer() then
                playerName = playerName .. " (" .. Locale.Lookup("LOC_HUD_CITY_YOU") .. ")";
            end
            kInstanceTradingPost.TradingPostName:SetText( playerName );
        end
    end
end

-- include fix from interesting amenity
include("DA_IA_CityPanelOverview")


