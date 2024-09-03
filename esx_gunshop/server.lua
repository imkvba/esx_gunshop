ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx_gunshop:buyFullKit')
AddEventHandler('esx_gunshop:buyFullKit', function(weapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    local price = 100000
    local playerMoney = xPlayer.getMoney()

    if playerMoney >= price then
        -- Dodaj wybrany pistolet do ekwipunku
        xPlayer.addWeapon(weapon, 250)

        -- Dodaj kajdanki, kawę i krótkofalówkę do ekwipunku
        xPlayer.addInventoryItem('handcuff', 1) -- to se tam edytujecie
        xPlayer.addInventoryItem('coffee', 1) -- to se tez edytuj paruwo
        xPlayer.addInventoryItem('radio', 1) -- i to też bo nie wiadomo jak masz to nazwane kondomie

        -- tu ci kurwa kasuje kase yo
        xPlayer.removeMoney(price)
        TriggerClientEvent('esx:showNotification', source, 'Zakupiłeś zestaw z ' .. weapon .. ' za 100000$')
    else
        TriggerClientEvent('esx:showNotification', source, 'Nie masz wystarczająco pieniędzy')
    end
end)
