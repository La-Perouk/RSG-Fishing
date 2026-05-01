local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

local webhook = Config.DiscordWebhook or 'YOUR_DISCORD_WEBHOOK_URL'

local function ParseIdentifiers(src)
    local identifiers = GetPlayerIdentifiers(src)
    local discordId, discordName = 'N/A', 'N/A'
    local steamId, steamName, steamProfile = 'N/A', GetPlayerName(src), 'N/A'

    for i = 1, #identifiers do
        local id = identifiers[i]
        if string.find(id, 'discord:') then
            discordId = string.sub(id, 9)
            discordName = '<@' .. discordId .. '>'
        elseif string.find(id, 'steam:') then
            steamId = id
            local steamHex = tonumber(steamId:gsub("steam:", ""), 16) or 0
            steamProfile = steamHex ~= 0 and string.format("https://steamcommunity.com/profiles/%d", steamHex) or "N/A"
        end
    end

    return discordId, discordName, steamId, steamName, steamProfile
end

local function GetPlayerCoords(src)
    local ped = GetPlayerPed(src)
    if ped and ped ~= 0 then
        local coords = GetEntityCoords(ped)
        return string.format('%.1f, %.1f, %.1f', coords.x, coords.y, coords.z)
    end
    return 'Unknown'
end 

-- make bait useable
RSGCore.Functions.CreateUseableItem('p_baitbread01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_baitcorn01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_baitcheese01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_baitworm01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_baitcricket01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_crawdad01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_finishedragonfly01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_finisdfishlure01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_finishdcrawd01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_finishedragonflylegendary01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
    -- if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('rsg-fishing:client:usebait', source, item.name)
    -- end
end)

RSGCore.Functions.CreateUseableItem('p_finisdfishlurelegendary01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_finishdcrawdlegendary01x', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_lgoc_spinner_v4', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)

RSGCore.Functions.CreateUseableItem('p_lgoc_spinner_v6', function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent('rsg-fishing:client:usebait', src, item.name)
end)
-- end of make bait useable

-- remove bait when used on fishing rod
RegisterServerEvent('rsg-fishing:server:removeBaitItem')
AddEventHandler('rsg-fishing:server:removeBaitItem', function(item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, 1)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'remove', 1)
end)

local fishEntity = {
    [`A_C_FISHBLUEGIL_01_MS`]        = 'a_c_fishbluegil_01_ms',
    [`A_C_FISHBLUEGIL_01_SM`]        = 'a_c_fishbluegil_01_sm',
    [`A_C_FISHBULLHEADCAT_01_MS`]    = 'a_c_fishbullheadcat_01_ms',
    [`A_C_FISHBULLHEADCAT_01_SM`]    = 'a_c_fishbullheadcat_01_sm',
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = 'a_c_fishchainpickerel_01_ms',
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = 'a_c_fishchainpickerel_01_sm',
    [`A_C_FISHCHANNELCATFISH_01_LG`] = 'a_c_fishchannelcatfish_01_lg',
    [`A_C_FISHCHANNELCATFISH_01_XL`] = 'a_c_fishchannelcatfish_01_xl',
    [`A_C_FISHLAKESTURGEON_01_LG`]   = 'a_c_fishlakesturgeon_01_lg',
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = 'a_c_fishlargemouthbass_01_lg',
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = 'a_c_fishlargemouthbass_01_ms',
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = 'a_c_fishlongnosegar_01_lg',
    [`A_C_FISHMUSKIE_01_LG`]         = 'a_c_fishmuskie_01_lg',
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = 'a_c_fishnorthernpike_01_lg',
    [`A_C_FISHPERCH_01_MS`]          = 'a_c_fishperch_01_ms',
    [`A_C_FISHPERCH_01_SM`]          = 'a_c_fishperch_01_sm',
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = 'a_c_fishrainbowtrout_01_lg',
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = 'a_c_fishrainbowtrout_01_ms',
    [`A_C_FISHREDFINPICKEREL_01_MS`] = 'a_c_fishredfinpickerel_01_ms',
    [`A_C_FISHREDFINPICKEREL_01_SM`] = 'a_c_fishredfinpickerel_01_sm',
    [`A_C_FISHROCKBASS_01_MS`]       = 'a_c_fishrockbass_01_ms',
    [`A_C_FISHROCKBASS_01_SM`]       = 'a_c_fishrockbass_01_sm',
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = 'a_c_fishsalmonsockeye_01_lg',
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = 'a_c_fishsalmonsockeye_01_ml',
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = 'a_c_fishsalmonsockeye_01_ms',
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = 'a_c_fishsmallmouthbass_01_lg',
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = 'a_c_fishsmallmouthbass_01_ms',
}

local fishNames = {
    [`A_C_FISHBLUEGIL_01_MS`]        = Config.fishData.A_C_FISHBLUEGIL_01_MS[1],
    [`A_C_FISHBLUEGIL_01_SM`]        = Config.fishData.A_C_FISHBLUEGIL_01_SM[1],
    [`A_C_FISHBULLHEADCAT_01_MS`]    = Config.fishData.A_C_FISHBULLHEADCAT_01_MS[1],
    [`A_C_FISHBULLHEADCAT_01_SM`]    = Config.fishData.A_C_FISHBULLHEADCAT_01_SM[1],
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = Config.fishData.A_C_FISHCHAINPICKEREL_01_MS[1],
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = Config.fishData.A_C_FISHCHAINPICKEREL_01_SM[1],
    [`A_C_FISHCHANNELCATFISH_01_LG`] = Config.fishData.A_C_FISHCHANNELCATFISH_01_LG[1],
    [`A_C_FISHCHANNELCATFISH_01_XL`] = Config.fishData.A_C_FISHCHANNELCATFISH_01_XL[1],
    [`A_C_FISHLAKESTURGEON_01_LG`]   = Config.fishData.A_C_FISHLAKESTURGEON_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = Config.fishData.A_C_FISHLARGEMOUTHBASS_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = Config.fishData.A_C_FISHLARGEMOUTHBASS_01_MS[1],
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = Config.fishData.A_C_FISHLONGNOSEGAR_01_LG[1],
    [`A_C_FISHMUSKIE_01_LG`]         = Config.fishData.A_C_FISHMUSKIE_01_LG[1],
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = Config.fishData.A_C_FISHNORTHERNPIKE_01_LG[1],
    [`A_C_FISHPERCH_01_MS`]          = Config.fishData.A_C_FISHPERCH_01_MS[1],
    [`A_C_FISHPERCH_01_SM`]          = Config.fishData.A_C_FISHPERCH_01_SM[1],
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = Config.fishData.A_C_FISHRAINBOWTROUT_01_LG[1],
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = Config.fishData.A_C_FISHRAINBOWTROUT_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_MS`] = Config.fishData.A_C_FISHREDFINPICKEREL_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_SM`] = Config.fishData.A_C_FISHREDFINPICKEREL_01_SM[1],
    [`A_C_FISHROCKBASS_01_MS`]       = Config.fishData.A_C_FISHROCKBASS_01_MS[1],
    [`A_C_FISHROCKBASS_01_SM`]       = Config.fishData.A_C_FISHROCKBASS_01_SM[1],
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_LG[1],
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_ML[1],
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_MS[1],
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = Config.fishData.A_C_FISHSMALLMOUTHBASS_01_LG[1],
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = Config.fishData.A_C_FISHSMALLMOUTHBASS_01_MS[1],
}

-- add fish caught to inventory with discord logs
RegisterServerEvent('rsg-fishing:FishToInventory')
AddEventHandler('rsg-fishing:FishToInventory', function(fishModel, weight)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local fish = fishEntity[fishModel]
    local fish_name = fishNames[fishModel] or fishModel
    local fish_weight = string.format('%.2f%%', (weight * 54.25)):gsub('%%', '')
    
    -- Add fish to inventory
    Player.Functions.AddItem(fish, 1, nil, {weight = fish_weight})
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[fish], 'add', 1)
    TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_you_got_fish_name')..' '..fish_name, type = 'success', duration = 5000 })
    
    -- Adding discord logs
    local discordId, discordName, steamId, steamName, steamProfile = ParseIdentifiers(src)
    local coords = GetPlayerCoords(src)

    local playerName = 'Unknown'
    if Player.PlayerData and Player.PlayerData.charinfo then
        local f = Player.PlayerData.charinfo.firstname or ''
        local l = Player.PlayerData.charinfo.lastname or ''
        playerName = (f .. ' ' .. l):gsub(' $', '')
    end
    if playerName == '' then playerName = 'No Character' end

    local jobLabel = "Unknown"
    if Player.PlayerData and Player.PlayerData.job and Player.PlayerData.job.name then
        jobLabel = Player.PlayerData.job.label
    end

    local citizenId = Player.PlayerData.citizenid or 'N/A'
    local serverId = tostring(src)
    local profileLink = steamProfile ~= 'N/A'
        and ('[Click Here To View](' .. steamProfile .. ')')
        or 'N/A'
    
    local embed = {
        title = "🎣 Fish Caught",
        color = 3447003, 
        fields = {
            { name = "Player ID", value = serverId, inline = true },
            { name = "Player Name", value=playerName, inline=true},
            { name = "CitizenID", value = citizenId, inline = true },
            { name = 'Job', value = jobLabel, inline = true },
            { name = 'Discord Name', value = discordName, inline = true },
            { name = "Discord ID", value = discordId, inline = true },
            { name = 'Steam Name', value = steamName, inline = true },
            { name = "Steam ID", value = steamId, inline = true },
            { name = 'Steam Profile', value = profileLink, inline = false },
            { name = "Species", value = fish_name, inline = true },
            { name = "Weight", value = fish_weight .. ' kgs', inline = true },
            { name = "Location", value = coords, inline = true },
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }
    
    PerformHttpRequest(webhook, function(err, text, headers)
        if err ~= 0 then print('❌ Fishing Discord ERROR:', err) end
    end, 'POST', json.encode({embeds = {embed}}), {['Content-Type'] = 'application/json'})
end)
