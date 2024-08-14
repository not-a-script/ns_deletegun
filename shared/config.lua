DelGun = {
    Framework = 'ESX', -- ESX | QBCORE
    enableTrace = false, -- Enable Trace (Debug) messages
    weaponModel = `WEAPON_PISTOL`,
    commandName = 'giveDelgun',
    groups = {
        ["superadmin"] = {
            canDeletePeds = true, -- (Player/Peds)
            canDeleteVehicle = true, -- All vehicles
            canDeleteObject = true -- Objects, Doors, Pickup
        },
        ["admin"] = {
            canDeletePeds = true, -- (Player/Peds)
            canDeleteVehicle = true, -- All vehicles
            canDeleteObject = false -- Objects, Doors, Pickup
        }
    },
}