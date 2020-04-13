
local function Debug(tooltip, key, value)
	if (value == nil) then
		tooltip:AddLine(key .. " : nil", 0.0, 0.5, 0.3)
	else
		tooltip:AddLine(key .. " : " ..  tostring(value), 0.0, 0.5, 0.3)
	end
end

local function IsAppearanceKnown(appearanceID)
	local sources = C_TransmogCollection.GetAllAppearanceSources(appearanceID)
	if sources then
		for i, sourceID in pairs(sources) do
			if sourceID and sourceID ~= NO_TRANSMOG_SOURCE_ID then
				local _, _, _, _, isCollected = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)
				if isCollected then
					return true
				end
			end
		end
	end
	return false
end

local function GameTooltip_OnTooltipSetItem(tooltip)
	local _, link = tooltip:GetItem()
	if (not link) then
		return;
	end

	local itemString = string.match(link, "item[%-?%d:]+")
	local _, itemId = strsplit(":", itemString)
	if (not itemId) then
		return;
	end

	local _, _, _, _, _, itemClassId = GetItemInfoInstant(itemId)
	if (itemClassId ~= LE_ITEM_CLASS_WEAPON and itemClassId ~= LE_ITEM_CLASS_ARMOR) then
		return;
	end

	local appearanceId, sourceId = C_TransmogCollection.GetItemInfo(itemId)
	if (not appearanceId) then
		return;
	end

	-- See https://wow.gamepedia.com/API_C_TransmogCollection.GetSourceInfo
	local sourceInfo = C_TransmogCollection.GetSourceInfo(sourceId)
	-- Debug(tooltip, "sourceInfo/isCollected", sourceInfo.isCollected)

	local playerHasTransmog = C_TransmogCollection.PlayerHasTransmog(itemId)
	-- Debug(tooltip,"playerHasTransmog", playerHasTransmog)

	local isAppearanceKnown = IsAppearanceKnown(appearanceId)
	-- Debug(tooltip,"isAppearanceKnown", isAppearanceKnown)
end

GameTooltip:HookScript("OnTooltipSetItem", GameTooltip_OnTooltipSetItem)
