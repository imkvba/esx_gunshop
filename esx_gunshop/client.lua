ESX = nil

-- a tu se z edytuj to gdzie chcesz zeby blip ci sie pokazwyał
local gunShopCoords = vector3(362.55, -2466.25, 6.40)

Citizen.CreateThread(function()
    -- tu ci kurwa blipa tworzy jak coś
    local blip = AddBlipForCoord(gunShopCoords)
    SetBlipSprite(blip, 110)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gun Shop")
    EndTextCommandSetBlipName(blip)

    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if #(playerCoords - gunShopCoords) < 3.0 then
            ESX.ShowHelpNotification("Naciśnij ~INPUT_CONTEXT~ aby otworzyć menu zakupu")

            if IsControlJustReleased(0, 38) then -- E
                OpenGunShopMenu()
            end
        end
    end
end)

function OpenGunShopMenu()
    local elements = {
        {label = 'Vintage Pistol', value = 'weapon_vintagepistol'},
        {label = 'Pistol', value = 'weapon_pistol'},
        {label = 'Pistol MK2', value = 'weapon_pistol_mk2'},
        {label = 'Combat Pistol', value = 'weapon_combatpistol'},
        {label = 'Pukawka', value = 'weapon_pistol'},
        {label = 'Pukawka MK2', value = 'weapon_pistol_mk2'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gunshop_menu', {
        title    = "Wybierz pistolet (100000$ za zestaw)",
        align    = 'top',
        elements = elements
    }, function(data, menu)
        if data.current.value then
            TriggerServerEvent('esx_gunshop:buyFullKit', data.current.value)
        end
    end, function(data, menu)
        menu.close()
    end)
end
