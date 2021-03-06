local CF = CreateFrame("Frame")
CF:RegisterEvent("ADDON_LOADED")

local U=UnitIsUnit
local select = select
local strstr = string.find
local function NameToArenaNumber(frame, unit)
	if select(1, IsActiveBattlefieldArena()) and UnitIsEnemy("player", unit) and UnitPlayerControlled(unit) then
		for i=1,5 do 
			if U(unit, "arena"..i) then
				local unitClass = UnitClass(unit)
				if strstr(frame.unit, "nameplate") then
					frame.name:SetText(unitClass)
					frame.name:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
					frame.name:SetTextColor(0,1,1)
				else
					frame.name:SetText(unitClass)
				end
				break
			end
		end
	end
	CF:UnregisterEvent("ADDON_LOADED")
end

CF:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		hooksecurefunc("CompactUnitFrame_UpdateName",function(frame)
			local unit = frame.unit
	
			if not select(1, IsActiveBattlefieldArena()) and strstr(frame.unit, "nameplate") and not frame:IsForbidden() then
				frame.name:SetFont("Fonts\\FRIZQT__.TTF", 12)
			end

			NameToArenaNumber(frame, unit)
		end)
	end
end);

hooksecurefunc("TargetFrame_Update", function(self)
	local unit = self.unit
	
	NameToArenaNumber(self, unit)
end);

local ANAN_UpdateInterval = 0.1;
local ANAN_TimeSinceLastUpdate = 0;
TargetFrameToT:HookScript("OnUpdate", function(self, elapsed)
	ANAN_TimeSinceLastUpdate = ANAN_TimeSinceLastUpdate + elapsed;
	if (ANAN_TimeSinceLastUpdate > ANAN_UpdateInterval) then
		local unit = self.unit
		
		NameToArenaNumber(self, unit)
	end
end);
