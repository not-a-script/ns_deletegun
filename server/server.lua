local framework = GetFramework()

RegisterNetEvent("not_a_script:delgun:deleteEntity", function(networkedEntity)
    local source = source
    local isAdmin, playerGroup = IsAdmin(framework, source)
    local playerPed <const> = GetPlayerPed(source)

    if not DoesEntityExist(playerPed) then
        Trace("The playerPed doesn't exist source: %s", source)
        return
    end
    if not player then
        Trace("The ESX player doesn't exist source: %s", source)
        return
    end
    if not isAdmin then
        Trace("Someone is trying to execute the delgun event without the correct group, source: %s", source)
        return
    end
    if GetSelectedPedWeapon(playerPed) ~= DelGun.weaponModel then
        Trace("Someone is trying to execute the delgun event without having the correct weapon, source: %s", source)
        return
    end

    local entity = NetworkGetEntityFromNetworkId(networkedEntity)
    if not DoesEntityExist(entity) then return end

    local entityType = GetEntityType(entity)
    local permissions = DelGun.groups
    local canDelete = false

    if entityType == 1 and permissions[playerGroup].canDeletePeds then
        canDelete = true
    elseif entityType == 2 and permissions[playerGroup].canDeleteVehicle then
        canDelete = true
    elseif entityType == 3 and permissions[playerGroup].canDeleteObject then
        canDelete = true
    end

    if canDelete then
        DeleteEntity(entity)
    else
        Trace("Player %s (group: %s) tried to delete an entity they don't have permission for.", source, playerGroup)
    end
end)

RegisterCommand(DelGun.commandName, function(source, _)
    local isAdmin, playerGroup = IsAdmin(framework, source)
    local playerPed = GetPlayerPed(source)
    
    if not DoesEntityExist(playerPed) then
        Trace("Player Ped don't exist inside the command.")
        return
    end
    if not isAdmin then
        Trace("Player %s (group: %s) tried to execute the command %s but don't have permission for.", source, playerGroup, DelGun.commandName)
        return
    end

    GiveWeaponToPed(playerPed, DelGun.weaponModel, 0, false, true)
    TriggerClientEvent('not_a_script:delgun:state', source)
    TriggerClientEvent('chat:addSuggestion', -1, '/' .. DelGun.commandName, "Enable the Delete Gun mode to delete entites (Admin only)")
end, false)