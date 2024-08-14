function IsAdmin(frameworkObj, source)
    if Framework == "ESX" then
        local group = frameworkObj.GetPlayerFromId(source).getGroup()
        return DelGun.groups[group], group or false
    elseif Framework == "QBCORE" then
        for group, _ in pairs(DelGun.groups) do
            if frameworkObj.Functions.HasPermission(source, group) then
                return DelGun.groups[group], group
            end
        end
    end
    return false
end