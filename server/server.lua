local ESX = exports.es_extended:getSharedObject()

RegisterNetEvent("not_a_script:delgun:deleteEntity", function(networkedEntity)
    local source = source
    local player = ESX.GetPlayerFromId(source)
    local playerPed <const> = GetPlayerPed(source)
    if not DoesEntityExist(playerPed) then
        Trace("The playerPed doesn't exist source: %s", source)
        return
    end
    if not player then
        Trace("The ESX player doesn't exist source: %s", source)
    end
    if not IsAdmin(player.getGroup()) then
        Trace("Someone is trying to execute the delgun event without having the good group, source: %s", source)
        return
    end
    if not GetSelectedPedWeapon(GetPlayerPed(source)) == `WEAPON_PISTOL` then
        Trace("Someone is trying to execute the delgun event without having the good weapon, source: %s", source)
        return
    end
    local entity = NetworkGetEntityFromNetworkId(networkedEntity)
    if not DoesEntityExist(entity) then
        return
    end
    DeleteEntity(entity)
end)

ESX.RegisterCommand('giveDelgun', 'admin', function(xPlayer, _, _)
    xPlayer.triggerEvent("not_a_script:delgun:giveWeapon")
end, true, {help = 'Give Delgun', validate = true})
