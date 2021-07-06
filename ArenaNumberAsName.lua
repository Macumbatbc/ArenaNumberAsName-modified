local U=UnitIsUnit
local function NameToArenaNumber(frame, unit)
	if select(1, IsActiveBattlefieldArena()) and UnitIsEnemy("player", unit) and UnitPlayerControlled(unit) then
		for i=1,5 do 
			if U(unit,"arena"..i) then
				local unitClass = UnitClass(unit)
				if string.find(frame.unit, "nameplate") then
					frame.name:SetText(unitClass)
					frame.name:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
					frame.name:SetTextColor(255,255,255)
				else
					frame.name:SetText(unitClass)
				end
			end
		end
	end
end

hooksecurefunc("ArenaEnemyFrame_UpdatePlayer", function(self)
	local unit = self.unit
	
	if self.name then
		NameToArenaNumber(self, unit)
	end
end)

hooksecurefunc("CompactUnitFrame_UpdateName",function(frame)
	local unit = frame.unit
	
	if not select(1, IsActiveBattlefieldArena()) then
		frame.name:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end

	NameToArenaNumber(frame, unit)
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

GameTooltip:HookScript("OnTooltipSetUnit", function(GameTooltip)
	local _, unit = GameTooltip:GetUnit()
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		local color = class and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		if color then
			local text = GameTooltipTextLeft1:GetText()
			if select(1, IsActiveBattlefieldArena()) and UnitIsEnemy("player", unit) and UnitPlayerControlled(unit) then
				for i=1,5 do 
					if U(unit,"arena"..i) then
						text = "Arena: " .. i;
					end
				end
			end
			GameTooltipTextLeft1:SetFormattedText("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, text:match("|cff\x\x\x\x\x\x(.+)|r") or text)
		end
	end
end)