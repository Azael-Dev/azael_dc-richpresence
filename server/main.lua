--===== FiveM Script =========================================
--= DC - Rich Presence
--===== Developed By: ========================================
--= Azael Dev
--===== Website: =============================================
--= https://www.azael.dev
--===== License: =============================================
--= Copyright (C) Azael Dev - All Rights Reserved
--= You are not allowed to sell this script
--============================================================ 

local resource = GetCurrentResourceName()
local timeout = (1000 * 60) * CONFIG.Option.Update.Time
local players = 0

local function setRichPresence()
    local active = GetNumPlayerIndices()

    if active > 0 and active ~= players then
        GlobalState[resource] = {
            players = active,
            maxclients = GetConvar('sv_maxclients')
        }

        players = active
    end

    Citizen.SetTimeout(timeout, function()
        setRichPresence()
    end)
end

setRichPresence()
