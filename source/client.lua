local IsMenuOpen = false

CreateThread(function()
    while true do
        local sleep = 500
        local PlayerPos = GetEntityCoords(PlayerPedId())

        if ESX and ESX.PlayerData then
            for i = 1, #Config do
                local v = Config[i]
                local Marker = v.Point
                local Dist = #(PlayerPos - Marker)
                if Dist <= 5 then
                    sleep = 0
                    for _, gradejob in pairs(v.GradeJob) do
                        if ESX.PlayerData.job.name == v.NameJob and ESX.PlayerData.job.grade_name == gradejob then
                            Config.Marker(Marker)
                            if Dist <= 3 then
                                if not IsMenuOpen then
                                    ESX.ShowHelpNotification(Translation.ShowHelpNotification)
                                    if IsControlJustPressed(1, 51) then
                                        OpenMenuStash(v)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        Wait(sleep)
    end
end)

local Inventory = {}
local Stash = {}
local OpenStash = false
MenuStash = RageUI.CreateMenu(Translation.Banner, Translation.SubTitle)
DepositMenu = RageUI.CreateSubMenu(MenuStash, Translation.Banner, " ")
WithdrawMenu = RageUI.CreateSubMenu(MenuStash, Translation.Banner, " ")
MenuStash.Closed = function()
    OpenStash = false
    IsMenuOpen = false
end

OpenMenuStash = function(info)
    if OpenStash then
        OpenStash = false
        IsMenuOpen = false
        RageUI.Visible(MenuStash, false)
        return
    else
        OpenStash = true
        IsMenuOpen = true
        RageUI.Visible(MenuStash, true)
        CreateThread(function()
            while OpenStash do
                RageUI.IsVisible(MenuStash, function()
                    RageUI.Separator((Translation.JobLabel):format(info.LabelJob))
                    RageUI.Line()
                    RageUI.Button(Translation.DepositObjects, nil, {}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('Stash:GetInventory', function(items)
                                Inventory = {}
                                Inventory = items
                            end)
                        end
                    }, DepositMenu)
                    RageUI.Button(Translation.WithdrawObjects, nil, {}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('Stash:GetChestInventory', function(items)
                                Stash = {}
                                Stash = items
                            end, info.Society)
                        end
                    }, WithdrawMenu)
                end)
                RageUI.IsVisible(DepositMenu, function()
                    for k, v in pairs(Inventory) do
                        if v.count > 0 then
                            RageUI.Button("" .. v.count .. " " .. v.label, nil, {
                                RightLabel = "x" .. v.count
                            }, true, {
                                onSelected = function()
                                    local QuantityDepo = Visual.KeyboardNumber(Translation.Input, "", 5)
                                    if type(QuantityDepo) == "number" then
                                        TriggerServerEvent("Stash:InventoryDepo", info.Society, QuantityDepo, v.name)
                                        ESX.TriggerServerCallback('Stash:GetInventory', function(items)
                                            Inventory = {}
                                            Inventory = items
                                        end)
                                    else
                                        ESX.ShowNotification("Invalid input")
                                    end
                                end
                            })
                        end
                    end
                end)
                RageUI.IsVisible(WithdrawMenu, function()
                    for k, v in pairs(Stash) do
                        if v.count > 0 then
                            RageUI.Button("" .. v.count .. " " .. v.label, nil, {}, true, {
                                onSelected = function()
                                    local InputNumber = Visual.KeyboardNumber(Translation.Input, "", 5)
                                    if type(InputNumber) == "number" then
                                        TriggerServerEvent("Stash:TakeObject", info.Society, InputNumber, v.name)
                                        ESX.TriggerServerCallback('Stash:GetChestInventory', function(items)
                                            Stash = {}
                                            Stash = items
                                        end, info.Society)
                                    else
                                        ESX.ShowNotification("Invalid input")
                                    end
                                end
                            })
                        end
                    end
                end)
                Wait(0)
            end
        end)
    end
end
