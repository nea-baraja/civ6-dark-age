local files = {
    -- "TopPanel.lua",
	-- "TopPanel_Expansion1.lua",
    "LaunchBar_Expansion2.lua"
}

for _, file in ipairs(files) do
    include(file)
end

BASE_RefreshGovernment = RefreshGovernment;
function RefreshGovernment()
    BASE_RefreshGovernment();
    local playerID:number = Game.GetLocalPlayer();
	if playerID == -1 then return; end
	local kCulture:table = Players[playerID]:GetCulture();
    if kCulture:HasCivic(GameInfo.Civics['CIVIC_CODE_OF_LAWS'].Index) then
        Controls.GovernmentBolt:SetHide(false);
    end
end

