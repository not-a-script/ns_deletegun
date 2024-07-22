local ESX = exports.es_extended:getSharedObject()

local function trace(text, ...)
    if not DelGun.enableTrace then return end
    local formatedText = string.format(text, ...)
    Citizen.Trace(formatedText)
end

RegisterNetEvent("not_a_script:delgun:deleteEntity", function(networkedEntity)
    local source = source
    local player = ESX.GetPlayerFromId(source)
    if not (player) then return end
    if not DelGun.groups[player.getGroup()] then
        trace("Someone is trying to execute the delgun event without having the good group, source : %s", source)
        return
    end
    if not GetSelectedPedWeapon(GetPlayerPed(source)) == `WEAPON_PISTOL` then
        trace("Someone is trying to execute the delgun event without having the good weapon, source : %s", source)
        return
    end
    local entity = NetworkGetEntityFromNetworkId(networkedEntity)
    if not (DoesEntityExist(entity)) then
        return
    end
    DeleteEntity(entity)
end)