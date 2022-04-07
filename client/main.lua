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
local wait = (1000 * 60) * CONFIG.Option.Update.Time

local function setRichPresence()
    SetDiscordAppId(CONFIG.Discord.Application.ID)
    SetDiscordRichPresenceAsset(CONFIG.Discord.Asset.Logo.Name)
    SetDiscordRichPresenceAssetText(CONFIG.Discord.Asset.Logo.Text)
    SetDiscordRichPresenceAssetSmall(CONFIG.Discord.Asset.Icon.Name)
    SetDiscordRichPresenceAssetSmallText(CONFIG.Discord.Asset.Icon.Text)
    SetDiscordRichPresenceAction(0, CONFIG.Discord.Button[1].Text, CONFIG.Discord.Button[1].URL)
    SetDiscordRichPresenceAction(1, CONFIG.Discord.Button[2].Text, CONFIG.Discord.Button[2].URL)
end

Citizen.CreateThread(function()
    local id = (CONFIG.Option.Display.ID.Enable and string.format('[%s] ', GetPlayerServerId(PlayerId())) or '')
    local name = (CONFIG.Option.Display.Name.Enable and string.format('%s | ', GetPlayerName(PlayerId()))  or '')

    setRichPresence()
    
    while true do
        local state = GlobalState[resource]
        local player = (state and (CONFIG.Option.Display.Online.Enable and string.format('%d/%d Players', state.players, state.maxclients) or string.format('%d Slots', state.maxclients)) or 'Loading...')
        local text = string.format('%s%s%s', id, name, player)
        
        SetRichPresence(text)

        Citizen.Wait(wait)
	end
end)
