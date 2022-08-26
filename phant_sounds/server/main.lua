RegisterServerEvent("phant_sounds:server:PlayOnOne")
AddEventHandler(
  "phant_sounds:server:PlayOnOne",
  function(clientNetId, soundFile, soundVolume)
    if maxDistance > 1000 or soundVolue > 1000 then
      DropPlayer(source, "nigger")
      return
    end
    if clientNetId ~= nil then
      local _source = clientNetId
      TriggerClientEvent("phant_sounds:client:PlayOnOne", _source, soundFile, soundVolume)
    end
  end
)

RegisterServerEvent("phant_sounds:server:PlayOnSource")
AddEventHandler(
  "phant_sounds:server:PlayOnSource",
  function(soundFile, soundVolume)
    if maxDistance > 1000 or soundVolue > 1000 then
      DropPlayer(source, "nigger")
      return
    end
    local _source = source
    TriggerClientEvent("phant_sounds:client:PlayOnOne", _source, soundFile, soundVolume)
  end
)

RegisterServerEvent("phant_sounds:server:PlayOnAll")
AddEventHandler(
  "phant_sounds:server:PlayOnAll",
  function(soundFile, soundVolume)
    if soundVolume > 1000 then
      DropPlayer(source, "nigger")
      return
    end
    TriggerClientEvent("phant_sounds:client:PlayOnAll", -1, soundFile, soundVolume)
  end
)

--[[RegisterServerEvent('phant_sounds:server:PlayWithinDistance')
AddEventHandler('phant_sounds:server:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)
	local _source = source
    TriggerClientEvent('phant_sounds:client:PlayWithinDistance', -1, _source, maxDistance, soundFile, soundVolume)
end)]]
RegisterServerEvent("phant_sounds:server:PlayWithinDistance")
AddEventHandler(
  "phant_sounds:server:PlayWithinDistance",
  function(maxDistance, soundFile, soundVolume)
    if maxDistance > 1000 or soundVolume > 1000 then
      DropPlayer(source, "nigger")
      return
    end
    if GetConvar("onesync_enableInfinity", "false") == "true" then
      TriggerClientEvent(
        "phant_sounds:client:PlayWithinDistanceOS",
        -1,
        GetEntityCoords(GetPlayerPed(source)),
        maxDistance,
        soundFile,
        soundVolume
      )
    else
      TriggerClientEvent("phant_sounds:client:PlayWithinDistance", -1, source, maxDistance, soundFile, soundVolume)
    end
  end
)
