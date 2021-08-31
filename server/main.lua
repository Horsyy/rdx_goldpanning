RDX = nil
TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end) 

RDX.RegisterUsableItem('item_goldpan', function(source)
	local xPlayer = RDX.GetPlayerFromId(source)

	xPlayer.triggerEvent('rdx_goldpanning:StartPaning')
end)

RegisterNetEvent('rdx_goldpanning:FoundItem')
AddEventHandler('rdx_goldpanning:FoundItem', function(Location)
	local xPlayer = RDX.GetPlayerFromId(source)
	local roll = math.random(0,1000)/10
	local item = nil
	local chance = nil
	print(roll)

	if roll >= 95 then -- 5%
		chance = math.random(1,8)
		item = Config.FoundItems[tonumber(chance)]['item']

		xPlayer.addInventoryItem(item, 1)            
		xPlayer.triggerEvent('rdx_goldpanning:Notify', Location, 'You found a ~COLOR_GOLD~' .. Config.FoundItems[tonumber(chance)]['name'], 'INVENTORY_ITEMS', Config.FoundItems[tonumber(chance)]['icon'], 5000)
	elseif roll >= 85 then -- 15%
		chance = math.random(9,17)
		item = Config.FoundItems[tonumber(chance)]['item']

		xPlayer.addInventoryItem(item, 1)            
		xPlayer.triggerEvent('rdx_goldpanning:Notify', Location, 'You found a ~COLOR_GOLD~' .. Config.FoundItems[tonumber(chance)]['name'], 'INVENTORY_ITEMS', Config.FoundItems[tonumber(chance)]['icon'], 5000)
	elseif roll >= 75 then -- 25%
		chance = math.random(18,22)
		item = Config.FoundItems[tonumber(chance)]['item']

		xPlayer.addInventoryItem(item, 1)            
		xPlayer.triggerEvent('rdx_goldpanning:Notify', Location, 'You found a ~COLOR_GOLD~' .. Config.FoundItems[tonumber(chance)]['name'], 'INVENTORY_ITEMS', Config.FoundItems[tonumber(chance)]['icon'], 5000)
	elseif roll >= 65 then -- 35%
		chance = math.random(23,27)
		item = Config.FoundItems[tonumber(chance)]['item']

		xPlayer.addInventoryItem(item, 1)            
		xPlayer.triggerEvent('rdx_goldpanning:Notify', Location, 'You found a ~COLOR_GOLD~' .. Config.FoundItems[tonumber(chance)]['name'], 'INVENTORY_ITEMS', Config.FoundItems[tonumber(chance)]['icon'], 5000)
	else -- 64%
		xPlayer.triggerEvent('rdx_goldpanning:Notify', Location, 'You found Nothing!', 'INVENTORY_ITEMS', 'upgrade_fsh_bait_lure_none', 5000)
    end
end)