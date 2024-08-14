Framework = DelGun.Framework

function Trace(text, ...)
    if not DelGun.enableTrace then return end
    local formattedText = string.format(text, ...)
    Citizen.Trace(formattedText .. "\n")
end

function GetFramework()
    if Framework == "ESX" then
        return exports['es_extended']:getSharedObject()
    elseif Framework == "QBCORE" then
        return exports['qb-core']:GetCoreobject()
    end
end