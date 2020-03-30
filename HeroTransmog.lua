
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
	if (sourceInfo.isCollected) then
		tooltip:AddLine("Transmog: OK", 0.0, 0.5, 0.3)
	else
		tooltip:AddLine("Transmog: Unknown", 0.7, 0.1, 0.0)
	end
end

GameTooltip:HookScript("OnTooltipSetItem", GameTooltip_OnTooltipSetItem)
