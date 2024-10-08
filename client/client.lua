local DELGUN_WEAPON = DelGun.weaponModel -- You can change the model in the config.
local isDelgunMode = false

local function removeEntity(entity)
    if not DoesEntityExist(entity) then
        print("Entity doesn't exist")
        return
    end

    local entityType = GetEntityType(entity)

    if entityType == 0 then
        print("Unknown entity type: " .. entityType)
        return
    end

    if not NetworkGetEntityIsNetworked(entity) then return end

    local netId = NetworkGetNetworkIdFromEntity(entity)
    
    if NetworkDoesEntityExistWithNetworkId(netId) then
        TriggerServerEvent('not_a_script:delgun:deleteEntity', netId)
    end
end

local function handleDelgunShot()
    local _, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())

    if not DoesEntityExist(entity) then return end
    removeEntity(entity)
end

CreateThread(function()
    local playerPed
    while true do
        Wait(0)
        if isDelgunMode then
            playerPed = PlayerPedId()
            if GetSelectedPedWeapon(playerPed) == DELGUN_WEAPON then
                handleDelgunShot()
            else
                isDelgunMode = false
            end
        end
    end
end)

RegisterNetEvent('not_a_script:delgun:state', function()
    local playerGroup <const> = LocalPlayer.state.group -- This thing is exploitable beaware, i'm pretty sure you can rewrite the statebag and change the group of the player?
    if not IsAdmin(playerGroup) then
        Trace("You can't use the event not_a_script:delgun:giveWeapon without having the admin group.")
        return
    end
    isDelgunMode = true
end)
