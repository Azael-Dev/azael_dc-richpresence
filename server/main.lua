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
local timeout = (1000 * CONFIG.Option.Update.Time)
local players, details = 0

local function setRichPresence()
    local active = GetNumPlayerIndices()

    if active > 0 and active ~= players then
        GlobalState[resource] = {
            players = active,
            maxclients = GetConvar('sv_maxclients'),
            details = details
        }

        players = active
    end

    Citizen.SetTimeout(timeout, function()
        setRichPresence()
    end)
end

Citizen.CreateThread(function()
    local continue = false

    Citizen.SetTimeout(10000, function()
        continue = true
    end)
    
    while not GetConvar('sv_projectDesc') and not continue do
        Citizen.Wait(1000)
    end

    details = string.gsub(GetConvar('sv_projectDesc', 'Need to set sv_projectDesc'), '[%^0%^1%^2%^3%^4%^5%^6%^7%^8%^9]', '')

    setRichPresence()
end)
