-- CityPanelOverview_DA
-- Author: 皮皮凯
-- Time: 2023-07-06T14:20:30.000Z
------------------------------------------
--[[离谱了，大水冲了龙王庙
local files = {
    "CityPanelOverview_Expansion2.lua",
    "CityPanelOverview_Expansion1.lua",
	"CityPanelOverview.lua"
}

for _, file in ipairs(files) do
    include(file)
	print("ppk" ..file);
    if Initialize then break end
end
]]
include("DA_CityPanelOverview.lua") -- 之前已经在DA_CityPanelOverview文件修改了CityPanelOverview.lua
-- ====================================
-- 缓存的基础函数
PPK_HideAll = HideAll;
PPK_View = View;
PPK_LateInitialize = LateInitialize;
-- ====================================
-- 添加新的按钮
-- ====================================
local m_PKDACityPoliciesUI = nil;
local m_uiPKDATabInstance = nil;
local m_PKDA_CP_ToolTip = "城市政策选择";
-- ====================================
function HideAll()
	PPK_HideAll();
	if m_uiPKDATabInstance then
		m_uiPKDATabInstance.Button:SetSelected(false);
		m_uiPKDATabInstance.Icon:SetColorByName("White");
		if m_PKDACityPoliciesUI then
			m_PKDACityPoliciesUI:SetHide(true);
		end
	end
end

-- ===========================================================================
function View(data)
	PPK_View(data);
	if GetSelectedTabButton() == m_uiPKDATabInstance.Button then
		RefreshPKDACityPoliciesUI();
	end
end

-- ===========================================================================
function RefreshPKDACityPoliciesUI()
	UILens.SetActive("Loyalty");
	LuaEvents.CityPanelTabRefresh();
	--LuaEvents.PPK_CityPoliciesUI();
end

-- ===========================================================================
function OnTogglePKDACityPoliciesTab()
	if m_uiPKDATabInstance then
		ToggleOverviewTab(m_uiPKDATabInstance.Button);
	end
end

-- ===========================================================================
function OnSelectPKDACityPoliciesUITab()
	HideAll();
	-- 必须在执行 CityPanelTabRefresh 之前显示上下文，以确保正确的刷新
	-- Context has to be shown before CityPanelTabRefresh to ensure a proper Refresh
	m_PKDACityPoliciesUI:SetHide(false);

	m_uiPKDATabInstance.Button:SetSelected(true);
	m_uiPKDATabInstance.Icon:SetColorByName("DarkBlue");
	UI.PlaySound("UI_CityPanel_ButtonClick");
	Controls.PanelDynamicTab:SetHide(false);
			
	RefreshPKDACityPoliciesUI();
end

-- ===========================================================================
function LateInitialize()
	PPK_LateInitialize();
	
	-- m_PKDACityPoliciesUI = ContextPtr:LoadNewContext("DA_CityPoliciesUI", Controls.PanelDynamicTab);
	-- print( "m_PKDACityPoliciesUI: " ..type(m_PKDACityPoliciesUI))
	-- m_PKDACityPoliciesUI:SetSize( Controls.PanelDynamicTab:GetSize() );
	LuaEvents.CityPanel_TogglePKDACityPolicies.Add( OnTogglePKDACityPoliciesTab );

	m_uiPKDATabInstance = GetTabButtonInstance();
	m_uiPKDATabInstance.Icon:SetIcon("ICON_QUEUE");
	m_uiPKDATabInstance.Button:SetToolTipString(Locale.Lookup(m_PKDA_CP_ToolTip));

	AddTab(m_uiPKDATabInstance.Button, OnSelectPKDACityPoliciesUITab );
end