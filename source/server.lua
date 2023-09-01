ESX.RegisterServerCallback('Stash:GetInventory', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.getInventory()
    cb(items)
end)

ESX.RegisterServerCallback("Stash:GetChestInventory", function(source, cb, Society)
    TriggerEvent('esx_addoninventory:getSharedInventory', Society, function(inventory)
        cb(inventory.items)
    end)
end)

RegisterNetEvent('Stash:InventoryDepo')
AddEventHandler("Stash:InventoryDepo", function(Society, QuantityDepo, name)
    local source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addoninventory:getSharedInventory', Society, function(inventory)
        local item = inventory.getItem()
        local PlayerItemCount = xPlayer.getInventoryItem(name).count
        if item.count >= 0 and QuantityDepo <= PlayerItemCount then
            xPlayer.removeInventoryItem(name, QuantityDepo)
            inventory.addItem(name, QuantityDepo)
            xPlayer.showNotification(Translation.DepositNotify .. QuantityDepo .. " " .. name)
        else
            xPlayer.showNotification('Invalid input')
        end
    end)
end)

RegisterNetEvent('Stash:TakeObject')
AddEventHandler('Stash:TakeObject', function(Society, QuantityTake, name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addoninventory:getSharedInventory', Society, function(inventory)
        local item = inventory.getItem(name)
        if item.count >= QuantityTake then 
            inventory.removeItem(name, QuantityTake)
            xPlayer.addInventoryItem(name, QuantityTake)
            xPlayer.showNotification(Translation.WithdrawNotify .. QuantityTake .. " " .. name)
        else 
            xPlayer.showHelpNotification("Invalid input")
        end
    end)
end)