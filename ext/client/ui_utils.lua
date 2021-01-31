local M = {}

function M.refresh_esp_markers()
    print("Refreshing markers!")
end

function M.update_ui()
if last_known_enemy_locations ~= nil then
        for i, player_xyz_location in pairs(last_known_enemy_locations) do
            local player_screen_coords = ClientUtils:WorldToScreen(player_xyz_location)

            if player_screen_coords ~= nil then
                -- Get current opcity of marker
                local opacity = 1 - (time_since_last_ping/MARKER_FADE_OUT_TIME)
                if opacity < 0 then
                    opacity = 0
                end

                WebUI:ExecuteJS('update_player_markers('.. player_screen_coords.x ..','.. player_screen_coords.y..','.. i ..',' .. opacity .. ')')
            end

            -- If player is dead make opacity 0
            if last_known_enemy_ids[k] ~= nil then
                enemy_player = PlayerManager:GetPlayerById(last_known_enemy_ids[k])
                if enemy_player.soldier == nil or not enemy_player.soldier.alive then
                    WebUI:ExecuteJS('update_player_markers('.. 0 ..','.. 0 ..','.. i ..',' .. 0 .. ')')
                end
            end

        end
    end
end

return M