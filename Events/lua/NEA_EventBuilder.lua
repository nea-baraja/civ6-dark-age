--include("EventPopup")
include( "InstanceManager" );
include( "Civ6Common" ); -- IsTutorialRunning, ToolTipHelper.GetToolTip
include( "TechAndCivicSupport" ); -- GetUnlockIcon
include( "SupportFunctions" ); -- DeepCopy

-- ===========================================================================
--	CONSTANTS
-- ===========================================================================
local IMAGE_SECTION_HEIGHT:number = 476;
local MIN_DESCRIPTION_HEIGHT:number = 0;


-- ===========================================================================
--	MEMBERS
-- ===========================================================================

local m_kUnlockIM			: table = InstanceManager:new( "UnlockInstance", "Top" );
local m_kPopupData			: table = nil;
local m_isWaitingToShowPopup: boolean = false;
local m_kQueuedPopups		: table = {};

-- ===========================================================================
--	FUNCTIONS
-- ===========================================================================


-- ===========================================================================
--	If the popup is for this player either immediately show or add it to
--	an internal queue of data to show once an existing event popup is closed.
-- ===========================================================================
function OnAddEventPopupRequest( kPopupData:table )

	-- If not a global popup, and not for this player ignore.
	local playerID:number = Game.GetLocalPlayer();
	if (kPopupData.ForPlayer ~= nil and kPopupData.ForPlayer ~= playerID) then
		return;
	end

	-- Show immediately if no event popups are up, otherwise save data in
	-- an internal queue to pull from later.
	if not m_isWaitingToShowPopup then
		ShowCompletedPopup(kPopupData);
	else
		local kQueuedPopupData = DeepCopy(kPopupData);
		table.insert(m_kQueuedPopups, kQueuedPopupData);
	end
end

-- ===========================================================================
function ShowNextQueuedPopup()
	-- Find first entry in table, display that, then remove it from the internal queue
	for i, kEntry in ipairs(m_kQueuedPopups) do
		ShowCompletedPopup(kEntry);
		table.remove(m_kQueuedPopups, i);
		break;
	end

	-- If no more popups are in the queue, close the whole context down.
	if table.count(m_kQueuedPopups) == 0 then
		m_isWaitingToShowPopup = false;
	end
end

-- ===========================================================================
function ShowCompletedPopup(kPopupData:table)

	-- This is cached to support hot reload
	m_kPopupData = kPopupData;

	-- Does our data specify a target player?  If so, check to see if it is for us.
	local playerID:number = Game.GetLocalPlayer();
	if (kPopupData.ForPlayer ~= nil and kPopupData.ForPlayer ~= playerID) then
		UI.DataError("Attempt to show a popup for '"..tostring(playerID).."' but the popup data is for player '"..tostring(kPopupData.ForPlayer));
		return;
	end

	local kEventData = GameInfo.EventPopupData[kPopupData.EventKey];
	if not kEventData then
		UI.DataError("Missing event popup data for event:" .. kPopupData.EventKey);
		return;
	end
	if not kPopupData.EventEffect and not kEventData.Effects then
		UI.DataError("Missing effects text for event:" .. kPopupData.EventKey);
		return;
	end

	m_kUnlockIM:ResetInstances();

	Controls.Title:SetText(Locale.ToUpper(Locale.Lookup(kEventData.Title)));

	local sDescription : string = kPopupData.EventDescription or Locale.Lookup(kEventData.Description);

	if (sDescription ~= nil and sDescription ~= "") then
		Controls.Description:SetHide(false);
		Controls.Description:SetText(sDescription);
	else
		Controls.Description:SetHide(true);
	end

	Controls.Effects:SetText(kPopupData.EventEffect or Locale.Lookup(kEventData.Effects));

	if kEventData.ImageText then
		Controls.ImageText:SetText(Locale.Lookup(kEventData.ImageText));
		Controls.ImageText:SetHide(false);
	else
		Controls.ImageText:SetHide(true);
	end

	if kEventData.BackgroundImage then
		Controls.BackgroundImage:SetTexture(kEventData.BackgroundImage);
		Controls.BackgroundImage:SetHide(false);
	else
		Controls.BackgroundImage:SetHide(true);
	end

	if kEventData.ForegroundImage then
		Controls.ForegroundImage:SetTexture(kEventData.ForegroundImage);
		Controls.ForegroundImage:SetHide(false);
	else
		Controls.ForegroundImage:SetHide(true);
	end


	if kPopupData.BackgroundImage then
		Controls.BackgroundImage:SetTexture(kEventData.BackgroundImage);
		Controls.BackgroundImage:SetHide(false);
	end

	if kPopupData.ForegroundImage then
		Controls.ForegroundImage:SetTexture(kEventData.ForegroundImage);
		Controls.ForegroundImage:SetHide(false);
	end


	if kPopupData.ForegroundImageSizeX ~= nil and kPopupData.ForegroundImageSizeY ~= nil then
		Controls.ForegroundImage:SetSizeX(kPopupData.ForegroundImageSizeX);
		Controls.ForegroundImage:SetSizeY(kPopupData.ForegroundImageSizeY);
	else
		Controls.ForegroundImage:SetSizeX(552);
		Controls.ForegroundImage:SetSizeY(476);
	end


	-- Handle one-shot vs A/B choice modes
	if kPopupData.ChoiceAText ~= nil and kPopupData.ChoiceBText ~= nil then
		Controls.Continue:SetHide(true);
		Controls.ChoiceA:SetHide(false);
		Controls.ChoiceB:SetHide(false);
		Controls.UnlocksTitle:SetHide(true);
		Controls.UnlocksStack:SetHide(true);
		Controls.UnlocksSpacer1:SetHide(false);
		Controls.UnlocksSpacer2:SetHide(false);
		Controls.MultipleChoiceUnlocks:SetHide(false);
		
		Controls.ChoiceA:SetText(Locale.Lookup(kPopupData.ChoiceAText));
		Controls.ChoiceB:SetText(Locale.Lookup(kPopupData.ChoiceBText));

		-- Handle Tooltips for Button
		Controls.ChoiceA:SetToolTipString(GetToolTipsForButton(kPopupData.ChoiceAUnlocks))
		Controls.ChoiceB:SetToolTipString(GetToolTipsForButton(kPopupData.ChoiceBUnlocks))

	  Controls.ChoiceA:SetDisabled(kPopupData.ChoiceAUnlocks.Disabled)
	  Controls.ChoiceB:SetDisabled(kPopupData.ChoiceBUnlocks.Disabled)


		local createCallback = function(responseIndex)
			return function()
				kPopupData.ResponseIndex = responseIndex;
				ReportingEvents.Send("EVENT_POPUP_RESPONSE", kPopupData);
				ResetChoiceControls();
				OnClose();
			end
		end

		Controls.ChoiceA:RegisterCallback(Mouse.eLClick, createCallback(0));
		Controls.ChoiceB:RegisterCallback(Mouse.eLClick, createCallback(1));

		if kPopupData.ChoiceAUnlocks then
			Controls.ChoiceAEffects.UnlocksTitle:SetText(Locale.Lookup(kPopupData.ChoiceAText));
			PopulateUnlocks(Controls.ChoiceAEffects.UnlocksStack, kPopupData.ChoiceAUnlocks);
		end
		if kPopupData.ChoiceBUnlocks then
			Controls.ChoiceBEffects.UnlocksTitle:SetText(Locale.Lookup(kPopupData.ChoiceBText));
			PopulateUnlocks(Controls.ChoiceBEffects.UnlocksStack, kPopupData.ChoiceBUnlocks);
		end
		Controls.ChoiceA:SetSizeX(268);
		Controls.ChoiceB:SetSizeX(268);
		--Controls.ChoiceB:SetAnchor("R,T");
		Controls.ChoiceAUnlocks:SetSizeX(240);
		Controls.ChoiceBUnlocks:SetSizeX(240);
		Controls.ChoiceBUnlocks:SetAnchor("R,T");
		Controls.ChoiceC:SetHide(true);
		Controls.ChoiceCUnlocks:SetHide(true);

		Controls.EffectsSpacer:SetShow(m_kUnlockIM.m_iAllocatedInstances > 0);
		if kPopupData.ChoiceCText ~= nil then
			Controls.ChoiceC:SetHide(false);
			Controls.ChoiceC:SetText(Locale.Lookup(kPopupData.ChoiceCText));
			Controls.ChoiceC:SetToolTipString(GetToolTipsForButton(kPopupData.ChoiceCUnlocks));
			Controls.ChoiceC:SetDisabled(kPopupData.ChoiceCUnlocks.Disabled);
			Controls.ChoiceC:RegisterCallback(Mouse.eLClick, createCallback(2));
			if kPopupData.ChoiceCUnlocks then
				Controls.ChoiceCEffects.UnlocksTitle:SetText(Locale.Lookup(kPopupData.ChoiceCText));
				PopulateUnlocks(Controls.ChoiceCEffects.UnlocksStack, kPopupData.ChoiceCUnlocks);
			end
			Controls.ChoiceA:SetSizeX(178);
			Controls.ChoiceB:SetSizeX(178);
			--Controls.ChoiceB:SetAnchor("C,T");
			Controls.ChoiceAUnlocks:SetSizeX(160);
			Controls.ChoiceBUnlocks:SetSizeX(160);
			Controls.ChoiceBUnlocks:SetAnchor("C,T");
			Controls.ChoiceCUnlocks:SetHide(false);
		end
	else
		PopulateUnlocks(Controls.UnlocksStack, kPopupData.Unlocks);
		
		local hasUnlocks:boolean = m_kUnlockIM.m_iAllocatedInstances > 0;

		Controls.UnlocksTitle:SetShow(hasUnlocks);
		Controls.UnlocksStack:SetShow(hasUnlocks);
		Controls.EffectsSpacer:SetShow(hasUnlocks);
		Controls.UnlocksSpacer1:SetShow(hasUnlocks);
		Controls.UnlocksSpacer2:SetShow(hasUnlocks);

		if kPopupData.ContinueText ~= nil then
			Controls.UnlocksTitle:SetText(Locale.Lookup(kPopupData.ContinueText));
			Controls.Continue:SetText(Locale.Lookup(kPopupData.ContinueText));
		end

		Controls.ChoiceA:SetHide(true);
		Controls.ChoiceB:SetHide(true);
		Controls.Continue:SetHide(false);
		Controls.MultipleChoiceUnlocks:SetHide(true);
		Controls.Continue:SetToolTipString(GetToolTipsForButton(kPopupData.Unlocks))
		Controls.ChoiceC:SetHide(true);
		Controls.ChoiceCUnlocks:SetHide(true);
	end

	UIManager:QueuePopup(ContextPtr, PopupPriority.Medium);
	Resize();

	m_isWaitingToShowPopup = true;
end


function GetToolTipsForButton(kUnlockData:table)
	if not kUnlockData then return end;
	local tooltip = '';
	if kUnlockData.Policies then
		for k, v in pairs(kUnlockData.Policies) do
			tooltip = tooltip..ToolTipHelper.GetToolTip(GameInfo.Policies[v].PolicyType, Game.GetLocalPlayer())..'[NEWLINE]';
		end
	end
	if kUnlockData.Buildings then
		for k, v in pairs(kUnlockData.Buildings) do
			tooltip = tooltip..ToolTipHelper.GetToolTip(GameInfo.Buildings[v].BuildingType, Game.GetLocalPlayer())..'[NEWLINE]';
		end
	end
	if kUnlockData.Units then
		for k, v in pairs(kUnlockData.Units) do
			tooltip = tooltip..ToolTipHelper.GetToolTip(GameInfo.Units[v].UnitType, Game.GetLocalPlayer())..'[NEWLINE]';
		end
	end
	if kUnlockData.Effects then
		for k, v in pairs(kUnlockData.Effects) do
			tooltip = tooltip..v..'[NEWLINE]';
		end
	end
	if kUnlockData.DisabledReasons then
		for k, v in pairs(kUnlockData.DisabledReasons) do
			tooltip = tooltip..v..'[NEWLINE]';
		end
	end
	return string.sub(tooltip,1,string.len(tooltip)-9);
end	



function PopulateUnlocks(uiUnlockStack:table, kUnlockData:table)
	if not kUnlockData then return end;

	if kUnlockData.Policies then
		for k, v in pairs(kUnlockData.Policies) do
			AddUnlockIconByType(uiUnlockStack, GameInfo.Policies[v].PolicyType);
		end
	end
	if kUnlockData.Buildings then
		for k, v in pairs(kUnlockData.Buildings) do
			AddUnlockIconByType(uiUnlockStack, GameInfo.Buildings[v].BuildingType);
		end
	end
	if kUnlockData.Units then
		for k, v in pairs(kUnlockData.Units) do
			AddUnlockIconByType(uiUnlockStack, GameInfo.Units[v].UnitType);
		end
	end
	if kUnlockData.Effects then
		for k, v in pairs(kUnlockData.Effects) do

			AddUnlockIconEffect(uiUnlockStack, kUnlockData.EffectIcons[k], v);
		end
	end
end

function AddUnlockIconEffect(uiParent:table, icon:table, effect:string)


	if icon ~= nil and icon[2] ~= nil then
		local instance:table = AddUnlockIcon(uiParent, icon[2], effect);
		instance.Icon:SetIcon(icon[1]);
		instance.Icon:SetHide(false);
		return instance;
	else
		local instance:table = AddUnlockIcon(uiParent, 'ICON_TECHUNLOCK_4', effect);
		instance.Icon:SetIcon(icon[1]);
		instance.Icon:SetHide(false);
		return instance;
	end
end

-- ===========================================================================
function AddUnlockIcon(uiParent:table, icon:string, tooltip:string)
	local instance:table = m_kUnlockIM:GetInstance(uiParent);
	instance.Icon:SetHide(true);

	local textureOffsetX, textureOffsetY, textureSheet = IconManager:FindIconAtlas(icon, 38);
	if textureSheet ~= nil then
		instance.UnlockIcon:SetTexture(textureOffsetX, textureOffsetY, textureSheet);
	end

	instance.UnlockIcon:LocalizeAndSetToolTip(tooltip);
	return instance;
end

-- ===========================================================================
function AddUnlockIconByType(uiParent:table, typeName:string)
	local instance:table = AddUnlockIcon(uiParent, GetUnlockIcon(typeName), ToolTipHelper.GetToolTip(typeName, Game.GetLocalPlayer()));

	instance.Icon:SetIcon("ICON_" .. typeName);
	instance.Icon:SetHide(false);

	if(not IsTutorialRunning()) then
		instance.UnlockIcon:RegisterCallback(Mouse.eRClick, function() 
			LuaEvents.OpenCivilopedia(typeName);
		end);
	end
	return instance;
end

-- ===========================================================================
function ResetChoiceControls()
	Controls.ChoiceA:SetText(Locale.Lookup("LOC_YES"));
	Controls.ChoiceB:SetText(Locale.Lookup("LOC_NO"));
	Controls.ChoiceA:ClearCallback(Mouse.eLClick);
	Controls.ChoiceB:ClearCallback(Mouse.eLClick);
end

-- ===========================================================================
function OnEscapeKey()
	-- TTP 43191: Prevent closing the popup via escape key if there are choices to be made
	if not m_kPopupData or (not m_kPopupData.ChoiceAText and not m_kPopupData.ChoiceBText) then
		OnClose();
	end
end

-- ===========================================================================
function OnClose()
	UIManager:DequeuePopup(ContextPtr);
	ShowNextQueuedPopup();
end

-- ===========================================================================
--	Handle screen resize/ dynamic popup height
function Resize()
	Controls.DescriptionContainer:SetSizeY(math.max(MIN_DESCRIPTION_HEIGHT, Controls.Description:GetSizeY()));
	Controls.ImageContainer:SetOffsetY(Controls.DescriptionContainer:GetOffsetY() + Controls.DescriptionContainer:GetSizeY());
	Controls.ImageContainer:SetSizeY(IMAGE_SECTION_HEIGHT);
	--Controls.DropShadow:SetSizeY(IMAGE_SECTION_HEIGHT + Controls.DescriptionContainer:GetSizeY()+EventPopupEffectsDeco:GetSizeY());

	Controls.EffectsScrollPanel:CalculateSize();
	if Controls.EffectsScrollPanel:GetScrollBar():IsVisible() then
		Controls.EffectsStack:SetAnchor("C,T");
	else
		Controls.EffectsStack:SetAnchor("C,C");
	end
	Controls.EffectsScrollPanel:ReprocessAnchoring();
end

-- ===========================================================================
function OnUpdateUI( type:number, tag:string, iData1:number, iData2:number, strData1:string )   
  if type == SystemUpdateUI.ScreenResize then
    Resize();
  end
end

-- ===========================================================================
--	Input
--	UI Event Handler
-- ===========================================================================
function KeyHandler( key:number )
	if key == Keys.VK_ESCAPE or key == Keys.VK_RETURN then
		OnEscapeKey();
		return true;
	end

	return false;
end
function OnInputHandler( pInputStruct:table )
	local uiMsg = pInputStruct:GetMessageType();
	if uiMsg == KeyEvents.KeyUp then return KeyHandler( pInputStruct:GetKey() ); end;
	return false;
end

-- ===========================================================================
--	LUA Event
--	Set cached values back after a hotload.
-- ===========================================================================
function OnUIIdle()
	if UI.CanShowPopup(PopupPriority.Medium) then
		ShowNextQueuedPopup();
	end
end

-- ===========================================================================
function OnGameDebugReturn( context:string, contextTable:table )
	if context == "EventPopup" and contextTable then
		m_kQueuedPopups = contextTable["m_kQueuedPopups"];
		if contextTable["IsVisible"] and contextTable["m_kPopupData"] then
			ShowCompletedPopup(contextTable["m_kPopupData"]);
		end
	end
end

-- ===========================================================================
function OnShutdown()
	LuaEvents.GameDebug_AddValue("EventPopup", "m_kPopupData", m_kPopupData);
	LuaEvents.GameDebug_AddValue("EventPopup", "m_kQueuedPopups", m_kQueuedPopups);
	LuaEvents.GameDebug_AddValue("EventPopup", "IsVisible", ContextPtr:IsVisible());	
end

-- ===========================================================================
function OnContextInitialize( isHotload:boolean )
	if isHotload then
		LuaEvents.GameDebug_GetValues("EventPopup");
	end
end

-- ===========================================================================
--  EventPopupResponse Handler
-- ===========================================================================


function OnEventPopupResponse(pPopupData : table)
	print("OnEventPopupResponse: Event Received: " .. pPopupData.EventKey);

	-- Verify data
	if (Game.GetLocalPlayer() ~= pPopupData.ForPlayer) then
		print("OnEventPopup: " .. pPopupData.EventKey .. "not for local player, discarding");
		return;
	end

	-- Network choice as a player operation.
	local kParameters:table = {};
	kParameters.EventKey = pPopupData.EventKey;
	kParameters.ResponseIndex = pPopupData.ResponseIndex or -1;
	kParameters.ForPlayer = pPopupData.ForPlayer;
	-- Send this GameEvent when processing the operation
	kParameters.OnStart = "EventPopupChoice";
	UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters);
end




-- ===========================================================================
--	Initialize
-- ===========================================================================
function Initialize()
	ContextPtr:SetInitHandler(OnContextInitialize);
	ContextPtr:SetInputHandler(OnInputHandler, true);
	ContextPtr:SetShutdown(OnShutdown);

	Controls.Continue:RegisterCallback(Mouse.eLClick, OnClose);

	LuaEvents.GameDebug_Return.Add( OnGameDebugReturn );

	-- Handle open events
	Events.EventPopupRequest.Add( OnAddEventPopupRequest );
	-- This is an alternate way where a script can pass in the request.
	LuaEvents.EventPopupRequest.Add( OnAddEventPopupRequest );

	Events.SystemUpdateUI.Add( OnUpdateUI );
	Events.UIIdle.Add( OnUIIdle );
	Events.EventPopupResponse.Add(OnEventPopupResponse);

end
Initialize();





