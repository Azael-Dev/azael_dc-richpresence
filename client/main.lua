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

local activity = string.format('%s', (CONFIG.Option.Display.Activity.Enable and ' | ' .. CONFIG.Translate.General.Loading or ''))

local function formatInt(int)
    return tostring(int):reverse():gsub('%d%d%d', '%1,'):reverse():gsub('^,', '')
end

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
    local resource = GetCurrentResourceName()
    local wait = (1000 * CONFIG.Option.Update.Time)
    local id = (CONFIG.Option.Display.ID.Enable and string.format('[%s] ', GetPlayerServerId(PlayerId())) or '')
    local name = (CONFIG.Option.Display.Name.Enable and string.format('%s', GetPlayerName(PlayerId()))  or '')

    setRichPresence()
    
    while true do
        local state = GlobalState[resource]
        local active = (state and (CONFIG.Option.Display.Online.Enable and string.format('%s/%s %s | %s', formatInt(state.players), formatInt(state.maxclients), CONFIG.Translate.General.Player, state.details) or string.format('%s %s | %s', formatInt(state.maxclients), CONFIG.Translate.General.Slot, state.details)) or CONFIG.Translate.General.Loading)
        local detail = string.format('%s%s%s\n%s', id, name, activity, active)
        
        SetRichPresence(detail)

        Citizen.Wait(wait)
	end
end)

local function getPlayerActivities(ped, zone)
    local zone = (zone or CONFIG.Translate.Unknown.Zone)
    local dead = IsEntityDead(ped)
    local water = IsEntityInWater(ped)

    if IsPedOnFoot(ped) and not water then
        if dead then
            return string.format(CONFIG.Translate.Activity.Dead.Ground, zone)
        elseif IsPedStill(ped) then
            return string.format(CONFIG.Translate.Activity.Ground.Standing, zone)
        elseif IsPedWalking(ped) then
            return string.format(CONFIG.Translate.Activity.Ground.Walking, zone)
        elseif IsPedRunning(ped) then
            return string.format(CONFIG.Translate.Activity.Ground.Running, zone)
        elseif IsPedSprinting(ped) then
            return string.format(CONFIG.Translate.Activity.Ground.Sprinting, zone)
        end
    elseif water then
        if dead then
            return string.format(CONFIG.Translate.Activity.Dead.Water, zone)
        else
            return string.format(CONFIG.Translate.Activity.Water.Swimming, zone)
        end
    end

    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle ~= 0 then
        local label = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
        local plate = (CONFIG.Option.Display.Activity.Plate.Enable and string.format('(%s)', GetVehicleNumberPlateText(vehicle)) or '')

        if dead then
            return string.format(CONFIG.Translate.Activity.Dead.Vehicle, zone, label, plate)
        elseif IsPedInAnyBoat(ped) or IsPedInAnySub(ped) then
            return string.format(CONFIG.Translate.Activity.Vehicle.Sailing, zone, label, plate)
        elseif IsEntityInWater(vehicle) then
            return string.format(CONFIG.Translate.Activity.Vehicle.Drowning, zone, label, plate)
        elseif IsPedInAnyHeli(ped) or IsPedInAnyPlane(ped) then
            if IsEntityInAir(vehicle) then
                return string.format(CONFIG.Translate.Activity.Vehicle.Flying, zone, label, plate)
            else
                return string.format(CONFIG.Translate.Activity.Vehicle.Landed, zone, label, plate)
            end
        else
            local meters = GetEntitySpeed(vehicle)
            local speed = math.ceil(meters * 3.6)   -- KMH = * 3.6 | MPH = * 2.236936 (Source: https://docs.fivem.net/natives/?_0xD5037BA82E12416F)

            if speed == 0 then
                return string.format(CONFIG.Translate.Activity.Vehicle.Parked, zone, label, plate)
            elseif speed <= 60 then -- KMH = 60 | MPH = 50
                return string.format(CONFIG.Translate.Activity.Vehicle.Cruising, zone, label, plate)
            else
                return string.format(CONFIG.Translate.Activity.Vehicle.Speeding, zone, label, plate)
            end
        end
    end

    if dead then
        return string.format(CONFIG.Translate.Activity.Dead.Ground, zone)
    end

    return string.format(' | %s', CONFIG.Translate.Unknown.Activity)
end

Citizen.CreateThread(function()
    local wait = 1000 * (CONFIG.Option.Update.Time - 2)
		
    while CONFIG.Option.Display.Activity.Enable do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped, true)
		local zone = CONFIG.Zone[GetNameOfZone(coords.x, coords.y, coords.z)]
        local state = getPlayerActivities(ped, zone)

        activity = string.format(' | %s', state)

        Citizen.Wait(wait)
    end
end)
