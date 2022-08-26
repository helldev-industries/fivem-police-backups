local ESX = exports['es_extended']:getSharedObject();
local LastBackup = nil;
local PanicSounds = true;


RegisterCommand('tooglepanicsound', function()
    PanicSounds = not PanicSounds;
end)

RegisterCommand('bk', function(src, args)
    ESX.TriggerServerCallback('phantum:server:checkJob', function(isAllowed)
        ESX.TriggerServerCallback('phantum:server:checkItems', function(haveItems) 
            if not isAllowed then
                ESX.ShowNotification('~r~Nie jestes w policji')
                return
            end

            if not haveItems then
                ESX.ShowNotification('~r~Nie masz czym wezwać wsparcia')
                return
            end
    
            if args[1] then
                CallBackup(args[1]);
            else 
                Menu();
            end
        end)
    end)
end)

exports('SetLastGPS', function(coords)
	LastBackup = { x = coords.x, y = coords.y };
end)

RegisterCommand('lastbackup', function()
    if LastBackup then
        SetWaypointOff();
        SetNewWaypoint(LastBackup.x, LastBackup.y); 
    end
end)

RegisterKeyMapping('lastbackup', 'Set waypoint to last call', 'keyboard', 'F4')




function Menu()
    local elements = {
        { label = '<span color=\'green\'>CODE 1</span> (/bk 1)', value = '1' },
        { label = '<span color=\'orange\'>CODE 2</span> (/bk 2)', value = '2' },
        { label = '<span color=\'red\'>CODE 3</span> (/bk 3)', value = '3' },
        { label = '<span color=\'red\'>CODE 0</span> (/bk 0)', value = '0' },
        { label = '<span color=\'red\'>SHOTS FIRED</span> (/bk shots)', value = 'shots' },
        { label = '<span color=\'red\'>10-13a</span> (/bk 13a)', value = '13a' },
        { label = '<span color=\'red\'>10-13b</span> (/bk 13b)', value = '13b' },
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'backup_menu', {
        title = 'Wybór - Backup',
        align = 'center',
        elements = elements,
    },
    function(data, menu)
        local called = CallBackup(data.current.value);

        if called then
            menu.close();
        end
    end, function(_, menu) menu.close() end)
end

RegisterNetEvent('phantum:client:callBackup', function()
    ESX.TriggerServerCallback('phantum:server:checkJob', function(isAllowed)
        ESX.TriggerServerCallback('phantum:server:checkItems', function(haveItems) 
            if not isAllowed then
                ESX.ShowNotification('~r~Nie jestes w policji')
                return
            end

            if not haveItems then
                ESX.ShowNotification('~r~Nie masz czym wezwać wsparcia')
                return
            end

            Menu();
        end)
    end)
end)

exports('CallBackup', function() 
    ESX.TriggerServerCallback('phantum:server:checkJob', function(isAllowed)
        ESX.TriggerServerCallback('phantum:server:checkItems', function(haveItems) 
            if not isAllowed then
                ESX.ShowNotification('~r~Nie jestes w policji')
                return
            end

            if not haveItems then
                ESX.ShowNotification('~r~Nie masz czym wezwać wsparcia')
                return
            end

            Menu();
        end)
    end)
end)

function CallBackup(t)
    local coords = GetEntityCoords(PlayerPedId(), true)

    if t == "0" or t == 0 then
        local text = "^*CODE 0:^*^7 %s";
        TriggerServerEvent('phantum:server:callBackup', text, 'bk');
        --ExecuteCommand('do Używa panic buttona');
        return true
    elseif t == "1" or t == 1 then
        local text = "^*CODE 1:^*^7 %s";
        TriggerServerEvent('phantum:server:callBackup', text, nil);
        --ExecuteCommand('do Używa panic buttona');
        return true
    elseif t == "2" or t == 2 then
        local text = "^*CODE 2:^*^7 %s";
        TriggerServerEvent('phantum:server:callBackup', text, 'bk');
        --ExecuteCommand('do Używa panic buttona');
        return true
    elseif t == "3" or t == 3 then
        local text = "^*CODE 3:^*^7 %s";
        TriggerServerEvent('phantum:server:callBackup', text, 'bk');
        --ExecuteCommand('do Używa panic buttona');
        return true
    elseif t == "shots" then
        local text = "^*SHOTS FIRED:^*^7 %s";
        TriggerServerEvent('phantum:server:callBackup', text, 'c0');
        --ExecuteCommand('do Używa panic buttona');
        return true
    elseif t == "13a" then
        local text = "^*10-13a:^*^7 %s";
        TriggerServerEvent('phantum:server:callBackup', text, '10-13');
        --ExecuteCommand('do Używa panic buttona');
        return true
    elseif t == "13b" then
        local text = "^*10-13b:^*^7 %s";
        TriggerServerEvent('phantum:server:callBackup', text, '10-13');
        --ExecuteCommand('do Używa panic buttona');
        return true
    else
        return false
    end
end


RegisterNetEvent('phantum:client:sendBackup', function(text, coords, badge, alert)
    local t = string.format(text, badge);

    TriggerEvent('chat:addMessage1', '^0[^3Centrala^0]', {0, 0, 0}, t, 'fas fa-laptop');

    LastBackup = { x = coords.x, y = coords.y };

    if PanicSounds and alert then
        TriggerServerEvent('phant_sounds:server:PlayWithinDistance', 1.0, alert, 0.1); 
    end

    ESX.ShowNotification('~r~Naciśnij F4 aby zaznaczyć GPS na backup');

    local escapedText = t:gsub('^*', ''):gsub('^7', '');

    local CurrentBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(CurrentBlip, 480)
    SetBlipDisplay(info.blip, 2)
    SetBlipScale(CurrentBlip, 0.9)
    SetBlipColour(CurrentBlip, 1)
    SetBlipAsShortRange(CurrentBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(escapedText)
    EndTextCommandSetBlipName(CurrentBlip)

    SetTimeout(1 * 60 * 1000, function()
        RemoveBlip(CurrentBlip)
    end)
end)