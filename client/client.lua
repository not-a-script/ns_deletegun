local DELGUN_WEAPON = `WEAPON_PISTOL` -- You can change the model if you want too
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

    if not (NetworkGetEntityIsNetworked(entity)) then return end

    local netId = NetworkGetNetworkIdFromEntity(entity)
    
    if (NetworkDoesEntityExistWithNetworkId(netId)) then
        TriggerServerEvent('not_a_script:delgun:deleteEntity', netId)
    end
end

local function handleDelgunShot()
    local _, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())

    if (entity) and (DoesEntityExist(entity)) then
        removeEntity(entity)
    end
end

CreateThread(function()
    local playerPed
    while true do
        Wait(0)
        if (isDelgunMode) then
            playerPed = PlayerPedId()
            if (GetSelectedPedWeapon(playerPed) == DELGUN_WEAPON) then
                handleDelgunShot()
            else
                isDelgunMode = false -- Disable delgun mode
            end
        end
    end
end)

RegisterCommand('giveDelgun', function()
    local playerPed = PlayerPedId()
    GiveWeaponToPed(playerPed, DELGUN_WEAPON, 0, false, true)
    isDelgunMode = true
end, false)