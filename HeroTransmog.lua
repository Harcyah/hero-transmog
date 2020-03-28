local match = string.match
local strsplit = strsplit

local function GameTooltip_OnTooltipSetItem(tooltip)
	local _, link = tooltip:GetItem()
	if (not link) then 
		return; 
	end	
	
	local itemString = match(link, "item[%-?%d:]+")
	local _, itemId = strsplit(":", itemString)
	local _, _, _, _, _, itemClassId = GetItemInfoInstant(itemId)
	if (itemClassId ~= LE_ITEM_CLASS_WEAPON and itemClassId ~= LE_ITEM_CLASS_ARMOR) then
		return;
	end
		
	local appearanceId = C_TransmogCollection.GetItemInfo(itemId)
	if (not appearanceId) then
		return;
	end
	
	tooltip:AddLine(" ")
	local playerHasTransmog = C_TransmogCollection.PlayerHasTransmog(itemId)
	if (playerHasTransmog) then
		tooltip:AddLine("Transmog: OK!")
	else 
		tooltip:AddLine("Transmog: Unknown!")
	end	

end

GameTooltip:HookScript("OnTooltipSetItem", GameTooltip_OnTooltipSetItem)
