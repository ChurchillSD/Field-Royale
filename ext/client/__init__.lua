ui_utils = require('ui_utils')

-- Constants
MARKER_FADE_OUT_TIME = 10
TIME_BETWEEN_PINGS = 20

-- Globals
time_to_next_ping = TIME_BETWEEN_PINGS
time_since_last_ui_update = 0
ui_update_rate_fps = 60

last_known_enemy_locations = nil
last_known_enemy_ids = nil

Events:Subscribe('Extension:Loaded', function()
    print("Init UI")
    WebUI:Init()
end)

Events:Subscribe('Engine:Update', function(deltaTime, simulationDeltaTime)
    -- Update ESP 3d locations
    time_to_next_ping = time_to_next_ping - simulationDeltaTime
    if time_to_next_ping < 0 then
        update_enemy_locations()
        time_to_next_ping = TIME_BETWEEN_PINGS
        ui_utils.refresh_esp_markers()
    end

    -- Update UI
    time_since_last_ui_update = time_since_last_ui_update + simulationDeltaTime
    if time_since_last_ui_update > 1/ui_update_rate_fps then
        ui_utils.update_ui()
        time_since_last_ui_update = 0
    end
end)

Events:Subscribe('Level:Loaded', function(levelName, gameMode)
    print("SENT")
    NetEvents:Send('player_joined', local_player)
end)

function update_enemy_locations()
    -- last_known_enemy_locations = {Vec3(-63.848698, 144.868973, 735.747803)}
    last_known_enemy_locations = {}
    last_known_enemy_ids = {}
    

    -- Get local player
    local local_player = PlayerManager:GetLocalPlayer()

    -- Get all players
    local all_players = PlayerManager:GetPlayers()

    -- Return if player does not have soldier
    if local_player == nil or local_player.soldier == nil then
        return 
    end

    -- For each player on the server
    for k, player in pairs(all_players) do
        if player ~= nil and player ~= local_player and player.soldier ~= nil then
            if player.teamId ~= local_player.teamId then
                if player.soldier.alive then
                    local transform = player.soldier.transform.trans:Clone()
                    transform.y = transform.y + 2
                    last_known_enemy_locations[k] = transform
                    last_known_enemy_ids[k] = player.id
                end                                         
            end
        end
    end
end