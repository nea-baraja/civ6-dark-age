
include( "PopupDialog" );
include("DA_Utils_UI")
Utils = ExposedMembers.DA.Utils;
GameEvents = ExposedMembers.GameEvents

function AttachButtonToCityPanel()
	-- if (m_IsLoading) then
	-- 	return;
	-- end
	if (not m_IsAttached) then
		local CityPanel:table = ContextPtr:LookUpControl("/InGame/CityPanel/ActionStack");
		if (CityPanel ~= nil) then
			Controls.CitizenRushUnitsButton:ChangeParent(CityPanel);
			CityPanel:AddChildAtIndex(Controls.CitizenRushUnitsButton, 6);

			Controls.ProductionToFoodCheck:ChangeParent(CityPanel);
			CityPanel:AddChildAtIndex(Controls.ProductionToFoodCheck, 7);

			CityPanel:CalculateSize();
			CityPanel:ReprocessAnchoring();
			m_IsAttached = true;
		end
	end
end

function OnLoadGameViewStateDone()
	AttachButtonToCityPanel();
	Events.DistrictAddedToMap.Add(DA_CityAction_OnDistrictAddedToMap);
end

function DA_CityAction_OnDistrictAddedToMap(playerID,districtID,cityID,districtX,districtY,districtType,percentComplete)
	ShowCitizenRushUnitsButton(playerID, cityID, 0, 0, 0, true, true);
end

function ShowCitizenRushUnitsButton(ownerPlayerID:number, cityID:number, i:number, j:number, k:number, isSelected:boolean, isEditable:boolean)
	if ownerPlayerID == Game.GetLocalPlayer() then
		local pPlayer = Players[ownerPlayerID];
		if (isSelected) then
			local currentBuilding = Utils.GetCurrentlyBuildingType(ownerPlayerID, cityID);
			if currentBuilding == 3 then
				-- local pCity = CityManager.GetCity(ownerPlayerID, cityID);
				-- local pDistricts = pCity:GetDistricts();
				if Utils.PlayerHasCivic(ownerPlayerID, 'CIVIC_STATE_WORKFORCE') then
					Controls.CitizenRushUnitsButton:SetHide(false);
					local pCity = CityManager.GetCity(ownerPlayerID, cityID);
					local iPop = pCity:GetPopulation();
					local iUnity = Utils.GetTotalUnity(ownerPlayerID);
					local iUnityCost = 0;
					if not Utils.CityHasDistrictOrUD(ownerPlayerID, cityID, 'DISTRICT_ENCAMPMENT') then
						iUnityCost = iPop * 3;
					end
					local sToolTip = '';
					Controls.CitizenRushUnitsButton:SetDisabled(false);
					sToolTip = sToolTip..Locale.Lookup('LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_TOOLTIP');
					if pCity:GetPopulation() < 2 then
						Controls.CitizenRushUnitsButton:SetDisabled(true);
						sToolTip = sToolTip..'[NEWLINE]'..Locale.Lookup('LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_DISABLED_POP');
					end
					if iUnity < iUnityCost then
						Controls.CitizenRushUnitsButton:SetDisabled(true);
						sToolTip = sToolTip..'[NEWLINE]'..Locale.Lookup('LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_DISABLED_UNITY');
					end
					Controls.CitizenRushUnitsButton:SetToolTipString(sToolTip);
				else
					Controls.CitizenRushUnitsButton:SetHide(true);
				end
			else
				Controls.CitizenRushUnitsButton:SetHide(true);
			end
		end
	end
end


function ShowProductionToFoodCheck(ownerPlayerID:number, cityID:number, i:number, j:number, k:number, isSelected:boolean, isEditable:boolean)
	if ownerPlayerID == Game.GetLocalPlayer() then
		if (isSelected) then
			if Utils.CityHasDistrictOrUD(ownerPlayerID, cityID, 'DISTRICT_AQUEDUCT') then
				Controls.ProductionToFoodCheck:SetHide(false);

				local pCity = CityManager.GetCity(ownerPlayerID, cityID);
				local iEnabled = pCity:GetProperty('PROP_CITY_PRODUCTION_TO_FOOD');
				if iEnabled ~= nil and iEnabled == 1 then
					Controls.ProductionToFoodCheck:SetCheck(true);
					Controls.ProductionToFoodCheck:SetToolTipString(Locale.Lookup('LOC_PRODUCTION_TO_FOOD_ENABLED'));
				else
					Controls.ProductionToFoodCheck:SetCheck(false);
					Controls.ProductionToFoodCheck:SetToolTipString(Locale.Lookup('LOC_PRODUCTION_TO_FOOD_DISABLED'));
				end
			else
				Controls.ProductionToFoodCheck:SetHide(true);
			end
		end
	end
end



function OnCityProductionChanged(ownerPlayerID:number, cityID:number)
	ShowCitizenRushUnitsButton(ownerPlayerID, cityID, 0, 0, 0, true, true);
end



function OnClickCitizenRushUnitsButton()
	local pCity = UI.GetHeadSelectedCity();
	local iPop = pCity:GetPopulation();
	local production = 8 + 8 * iPop;
	local iUnityCost = 0;
	if not Utils.CityHasDistrictOrUD(ownerPlayerID, cityID, 'DISTRICT_ENCAMPMENT') then
		iUnityCost = iPop * 3;
	end
	local pPopupDialog :table = PopupDialogInGame:new("CitizenRushUnits"); -- unique identifier
	pPopupDialog:AddTitle(Locale.Lookup('LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_TITLE'));
	pPopupDialog:AddText(Locale.Lookup('LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_DESCRIPTION', iUnityCost, 1, production));
	pPopupDialog:AddConfirmButton(Locale.Lookup("LOC_YES"), CitizenRushUnits);
	pPopupDialog:AddCancelButton(Locale.Lookup("LOC_NO"), nil);
	pPopupDialog:Open();
end

function OnToggleProductionToFood()
	local pCity = UI.GetHeadSelectedCity();
	if pCity ~= nil then
		if Controls.ProductionToFoodCheck:IsChecked() then
			local kParameters:table = {};
			kParameters.playerID = pCity:GetOwner();
			kParameters.iCity = pCity:GetID();
			kParameters.sPropertyName = 'PROP_CITY_PRODUCTION_TO_FOOD';
			kParameters.Value = 1;
			kParameters.OnStart = "OP_SetCityProperty";
			UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters);

			local kParameters2:table = {};
			local iX, iY = pCity:GetX(), pCity:GetY();
    		local plotID = Map.GetPlotIndex(iX, iY);
			kParameters2.plotID = plotID
			kParameters2.sPropertyName = 'PROP_CITY_PRODUCTION_TO_FOOD';
			kParameters2.Value = 1;
			kParameters2.OnStart = "OP_SetPlotProperty";
			UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters2);
			Controls.ProductionToFoodCheck:SetToolTipString(Locale.Lookup('LOC_PRODUCTION_TO_FOOD_ENABLED'));
			LuaEvents.Tutorial_CityPanelOpen();
		else
			local kParameters:table = {};
			kParameters.playerID = pCity:GetOwner();
			kParameters.iCity = pCity:GetID();
			kParameters.sPropertyName = 'PROP_CITY_PRODUCTION_TO_FOOD';
			kParameters.Value = 0;
			kParameters.OnStart = "OP_SetCityProperty";
			UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters);

			local kParameters2:table = {};
			local iX, iY = pCity:GetX(), pCity:GetY();
    		local plotID = Map.GetPlotIndex(iX, iY);
			kParameters2.plotID = plotID
			kParameters2.sPropertyName = 'PROP_CITY_PRODUCTION_TO_FOOD';
			kParameters2.Value = 0;
			kParameters2.OnStart = "OP_SetPlotProperty";
			UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters2);
			Controls.ProductionToFoodCheck:SetToolTipString(Locale.Lookup('LOC_PRODUCTION_TO_FOOD_DISABLED'));
			LuaEvents.Tutorial_CityPanelOpen();
		end
	end
end


function CitizenRushUnits()
	local iPlayer = Game.GetLocalPlayer();
	local pCity = UI.GetHeadSelectedCity();
	local iUnityCost = 0;
	if pCity ~= nil then
		local iPop = pCity:GetPopulation();
		if not Utils.CityHasDistrictOrUD(ownerPlayerID, cityID, 'DISTRICT_ENCAMPMENT') then
			iUnityCost = iPop * 3;
			GameEvents.CostUnity.Call(iPlayer, iUnityCost);
		end
		local kParameters:table = {};
		--ChangePopulation.Add( function(playerID, iCity,  pNewPopulation))
		kParameters.playerID = pCity:GetOwner();
		kParameters.iCity = pCity:GetID();
		kParameters.pNewPopulation = -1;
		-- Send this GameEvent when processing the operation
		kParameters.OnStart = "OP_ChangePopulation";
		UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters);
		local kParameters2:table = {};
		--GameEvents.RequestAddProgress.Add(function(playerID, cityID,produnction)   
		kParameters2.playerID = pCity:GetOwner();
		kParameters2.cityID = pCity:GetID();
		kParameters2.produnction = 8 + 8 * iPop;
		-- Send this GameEvent when processing the operation
		kParameters2.OnStart = "OP_RequestAddProgress";
		UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters2);
		--LuaEvents.Tutorial_CityPanelOpen();
		if iPop == 2 or iUnityCost -3 > Utils.GetTotalUnity(iPlayer) then
			Controls.CitizenRushUnitsButton:SetDisabled(true);
		end
	end
end

function Initialize()
	Events.LoadGameViewStateDone.Add(OnLoadGameViewStateDone);
	Events.CitySelectionChanged.Add(ShowCitizenRushUnitsButton);
	Events.CitySelectionChanged.Add(ShowProductionToFoodCheck);

	Controls.CitizenRushUnitsButton:RegisterCallback(Mouse.eLClick,	OnClickCitizenRushUnitsButton);
	Events.CityProductionChanged.Add(	OnCityProductionChanged );

	Controls.ProductionToFoodCheck:RegisterCheckHandler( OnToggleProductionToFood );
	Controls.ProductionToFoodCheck:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

end

Initialize();


