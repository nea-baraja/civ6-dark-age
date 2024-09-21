
include( "CivicsTree_Expansion2" );
include("SupportFunctions");


-- ===========================================================================
--	Now its own function so Mods / Expansions can modify the nodes
-- ===========================================================================
function PopulateNode(uiNode, playerTechData)

	local item		:table = g_kItemDefaults[uiNode.Type];						-- static item data
	local live		:table = playerTechData[DATA_FIELD_LIVEDATA][uiNode.Type];	-- live (changing) data
	local status	:number = live.IsRevealed and live.Status or ITEM_STATUS.UNREVEALED;

	-- Check if a node just changed status to reveled and needs to be reallocated to a different shape.	
	if (status ~= ITEM_STATUS.UNREVEALED) and item.wasForcedSmall then		
		uiNode = GetLargeNodeFromSmall( item, uiNode );
	end

	local artInfo	:table = (uiNode.IsLarge) and STATUS_ART_LARGE[status] or STATUS_ART[status];

	if(status == ITEM_STATUS.RESEARCHED) then
		for _,prereqId in pairs(item.Prereqs) do
			if(prereqId ~= PREREQ_ID_TREE_START) then
				local prereq		:table = g_kItemDefaults[prereqId];
				if prereq ~= nil then
					local previousRow	:number = prereq.UITreeRow;
					local previousColumn:number = g_kEras[prereq.EraType].PriorColumns;

					for lineNum,line in pairs(g_uiConnectorSets[item.Type..","..prereqId]) do
						if(lineNum == 1 or lineNum == 5) then
							line:SetTexture("Controls_TreePathEW");
						end
						if( lineNum == 3) then
							line:SetTexture("Controls_TreePathNS");
						end
	
						if(lineNum==2)then
							if previousRow < item.UITreeRow  then
								line:SetTexture("Controls_TreePathSE");
							else
								line:SetTexture("Controls_TreePathNE");
							end
						end

						if(lineNum==4)then
							if previousRow < item.UITreeRow  then
								line:SetTexture("Controls_TreePathES");
							else
								line:SetTexture("Controls_TreePathEN");
							end
						end
					end
				end
			end
		end
	end

	uiNode.NodeName:SetColor( artInfo.TextColor0, 0 );
	uiNode.NodeName:SetColor( artInfo.TextColor1, 1 );

	uiNode.UnlockStack:SetHide( status==ITEM_STATUS.UNREVEALED );	-- Show/hide unlockables based on revealed status.

	local techName :string = (status==ITEM_STATUS.UNREVEALED) and Locale.Lookup("LOC_CIVICS_TREE_NOT_REVEALED_CIVIC") or Locale.Lookup(item.Name);
	if debugShowIDWithName then
		uiNode.NodeName:SetText( tostring(item.Index).."  ".. techName);	-- Debug output
	else
		uiNode.NodeName:SetText( Locale.ToUpper( techName ));				-- Normal output
	end

	if live.Turns > 0 then
		uiNode.Turns:SetHide( false );
		uiNode.Turns:SetColor( artInfo.TextColor0, 0 );
		uiNode.Turns:SetColor( artInfo.TextColor1, 1 );
		--DA----------------------------------------
		TurnsText = Locale.Lookup("LOC_TECH_TREE_TURNS",live.Turns);
		if GameInfo.DA_Boosts[uiNode.Type] ~= nil then
			local pPlayer = Players[playerTechData[DATA_FIELD_PLAYERINFO].Player]
			local CurrentCivicYield = pPlayer:GetCulture():GetCultureYield()
			local CivicID = GameInfo.Civics[uiNode.Type].Index
			local CivicBoostTriggerByOther = (pPlayer:GetProperty("DA_Boost_"..uiNode.Type) or {})['ByOther'] or 0
			local CivicBoostTriggerByEureka = (pPlayer:GetProperty("DA_Boost_"..uiNode.Type) or {})['ByEureka'] or 0;		
			local CivicBoostTriggerByTask = (pPlayer:GetProperty("DA_Boost_"..uiNode.Type) or {})['ByTask'] or 0
			local Turns = (pPlayer:GetCulture():GetCultureCost(CivicID) - pPlayer:GetCulture():GetCulturalProgress(CivicID)) / (CurrentCivicYield * (1 + CivicBoostTriggerByOther + CivicBoostTriggerByEureka + CivicBoostTriggerByTask))
			Turns = math.ceil(Turns)
			if Turns < 1 then
				Turns = 1
			end
			TurnsText = Locale.Lookup("LOC_TECH_TREE_TURNS",Turns)
		
		
			if CivicBoostTriggerByOther ~= 0 or CivicBoostTriggerByTask ~= 0 or CivicBoostTriggerByEureka ~= 0 then
				TurnsText = Locale.Lookup("LOC_DA_BOOST_ADD",Round((CivicBoostTriggerByOther + CivicBoostTriggerByEureka + CivicBoostTriggerByTask) * 100))..TurnsText
			end
		end
		uiNode.Turns:SetText( TurnsText );
		-----------------------------------------------------
	else
		uiNode.Turns:SetHide( true );
	end

	if item.IsBoostable and status ~= ITEM_STATUS.RESEARCHED and status ~= ITEM_STATUS.UNREVEALED then
		uiNode.BoostIcon:SetHide( false );
		uiNode.BoostText:SetHide( false );
		uiNode.BoostText:SetColor( artInfo.TextColor0, 0 );
		uiNode.BoostText:SetColor( artInfo.TextColor1, 1 );

		local boostText:string;
		if live.IsBoosted then
			boostText = TXT_BOOSTED.." "..item.BoostText;
			uiNode.BoostIcon:SetTexture( PIC_BOOST_ON );
			uiNode.BoostMeter:SetHide( false );
			uiNode.BoostedBack:SetHide( false );
		else
			--DA----------------------------------------
			boostText = TXT_TO_BOOST.." "..item.BoostText;
			if GameInfo.DA_Boosts[uiNode.Type] ~= nil then
				boostText = Locale.Lookup("LOC_DA_BOOST_ADD_REP")..Locale.Lookup(GameInfo.DA_Boosts[uiNode.Type].Text);
			end
			----------------------------------------------
			uiNode.BoostedBack:SetHide( true );
			uiNode.BoostIcon:SetTexture( PIC_BOOST_OFF );
			uiNode.BoostMeter:SetHide( false );
			local boostAmount = (item.BoostAmount*.01) + (live.Progress/ live.Cost);
			uiNode.BoostMeter:SetPercent( boostAmount );
		end
		TruncateStringWithTooltip(uiNode.BoostText, MAX_BEFORE_TRUNC_TO_BOOST, boostText);
	else
		uiNode.BoostIcon:SetHide( true );
		uiNode.BoostText:SetHide( true );
		uiNode.BoostedBack:SetHide( true );
		uiNode.BoostMeter:SetHide( true );
	end

	if status == ITEM_STATUS.CURRENT then
		uiNode.GearAnim:SetHide( false );
	else
		uiNode.GearAnim:SetHide( true );
	end

	if live.Progress > 0 and status ~= ITEM_STATUS.RESEARCHED then
		uiNode.ProgressMeter:SetHide( false );
		uiNode.ProgressMeter:SetPercent(live.Progress / live.Cost);
	else
		uiNode.ProgressMeter:SetHide( true );
	end

	-- Set art for icon area
	-- Set art and tool tip for icon area
	if status == ITEM_STATUS.UNREVEALED then
		uiNode.NodeButton:SetToolTipString(Locale.Lookup("LOC_CIVICS_TREE_NOT_REVEALED_TOOLTIP"));
		uiNode.Icon:SetIcon("ICON_TECH_UNREVEALED");
		uiNode.IconBacking:SetHide(true);
		uiNode.BoostMeter:SetColor(UI.GetColorValueFromHexLiteral(0x66ffffff));
		uiNode.BoostIcon:SetColor(UI.GetColorValueFromHexLiteral(0x66000000));
	else
		uiNode.NodeButton:SetToolTipString(ToolTipHelper.GetToolTip(item.Type, Game.GetLocalPlayer()));

		if(item.Type ~= nil) then
			local iconName :string = DATA_ICON_PREFIX .. item.Type;
			if (artInfo.Name == "BLOCKED" or artInfo.Name == "LARGEBLOCKED") then
				uiNode.IconBacking:SetHide(true);
				iconName = iconName .. "_FOW";
				uiNode.BoostMeter:SetColor(UI.GetColorValueFromHexLiteral(0x66ffffff));
				uiNode.BoostIcon:SetColor(UI.GetColorValueFromHexLiteral(0x66000000));
			else
				uiNode.IconBacking:SetHide(false);
				iconName = iconName;
				uiNode.BoostMeter:SetColor(UI.GetColorValue("COLOR_WHITE"));
				uiNode.BoostIcon:SetColor(UI.GetColorValue("COLOR_WHITE"));
			end
			local textureOffsetX, textureOffsetY, textureSheet = IconManager:FindIconAtlas(iconName,42);
			if (textureOffsetX ~= nil) then
				uiNode.Icon:SetTexture( textureOffsetX, textureOffsetY, textureSheet );
			end
		end
	end

	if artInfo.IsButton then
		uiNode.OtherStates:SetHide( true );
		uiNode.NodeButton:SetTextureOffsetVal( artInfo.BGU, artInfo.BGV );
	else
		uiNode.OtherStates:SetHide( false );
		uiNode.OtherStates:SetTextureOffsetVal( artInfo.BGU, artInfo.BGV );
	end

	if artInfo.FillTexture ~= nil then
		uiNode.FillTexture:SetHide( false );
		uiNode.FillTexture:SetTexture( artInfo.FillTexture );
	else
		uiNode.FillTexture:SetHide( true );
	end

	if artInfo.BoltOn then
		uiNode.Bolt:SetTexture(PIC_BOLT_ON);
	else
		uiNode.Bolt:SetTexture(PIC_BOLT_OFF);
	end

	uiNode.IconBacking:SetTexture(artInfo.IconBacking);

	-- Darken items not making it past filter.
	local currentFilter:table = playerTechData[DATA_FIELD_UIOPTIONS].filter;
	if currentFilter == nil or currentFilter.Func == nil or currentFilter.Func( item.Type ) then
		uiNode.FilteredOut:SetHide( true );
	else
		uiNode.FilteredOut:SetHide( false );
	end

	-- Civilopedia: Only show if revealed civic; only wire up handlers if not in an on-rails tutorial.
	function OpenPedia()
		if live.IsRevealed then
			LuaEvents.OpenCivilopedia(uiNode.Type);
		end
	end
	if IsTutorialRunning()==false then
		uiNode.NodeButton:RegisterCallback( Mouse.eRClick, OpenPedia);
		uiNode.OtherStates:RegisterCallback( Mouse.eRClick,OpenPedia);
	end

	-- Show/Hide Recommended Icon
	if live.IsRecommended and live.AdvisorType ~= nil then
		uiNode.RecommendedIcon:SetIcon(live.AdvisorType);
		uiNode.RecommendedIcon:SetHide(false);
	else
		uiNode.RecommendedIcon:SetHide(true);
	end
end