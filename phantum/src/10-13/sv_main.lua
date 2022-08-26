local ESX = exports['es_extended']:getSharedObject();


ESX.RegisterServerCallback('phantum:server:checkJob', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source);

    if xPlayer.job and xPlayer.job.name and xPlayer.job.name == 'police' then
        cb(true);
        return;
    end


    cb(false);
end)

ESX.RegisterServerCallback('phantum:server:checkItems', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source);

    if xPlayer.getInventoryItem('panic').count ~= 0 or xPlayer.getInventoryItem('panic').count ~= 0 or xPlayer.getInventoryItem('gps').count ~= 0 or xPlayer.getInventoryItem('bodycam').count ~= 0 then
        cb(true);
    end


    cb(false);
end)




RegisterNetEvent('phantum:server:callBackup', function(text, alert)

    if not string.find(text, '%s') then
        DropPlayer('zajebisty exec, ale dzis nic nie wyslesz :P');
        return;
    end
    local xPlayer = ESX.GetPlayerFromId(source);

    if not xPlayer.job or xPlayer.job.name ~= 'police' then
        DropPlayer(source, 'fajny exec, wez podeslij Phantum#8802')
        return
    end


    local Players = exports['esx_scoreboard']:MisiaczekPlayers();
    local badge = json.decode(xPlayer.character.job_id)

    for _, v in pairs(Players) do
        if v.job == 'police' or v.job == 'ambulance' then
            TriggerClientEvent('phantum:client:sendBackup', v.id, text, xPlayer.getCoords(true), string.format('[%s] %s', badge.id, xPlayer.character.firstname .. ' ' .. xPlayer.character.lastname), alert)
        end
    end

end)