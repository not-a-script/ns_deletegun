function Trace(text, ...)
    if not DelGun.enableTrace then return end
    local formattedText = string.format(text, ...)
    Citizen.Trace(formattedText .. "\n")
end


function IsAdmin(playerGroup)
    return DelGun.groups[playerGroup]
end