local M = {}

function M.spawn_soldier(player, transform)
    -- Get m9 and knife data containers
    local m9_pistol_container = ResourceManager:SearchForDataContainer('Weapons/M9/U_M9')
    local knife_container = ResourceManager:SearchForDataContainer('Weapons/Knife/U_Knife')

    -- No attachemnts
    local attachmentContainers = {}

    -- Give Player an M9 and a knife
    player:SelectWeapon(WeaponSlot.WeaponSlot_1, m9_pistol_container, attachmentContainers)
    player:SelectWeapon(WeaponSlot.WeaponSlot_7, knife_container, attachmentContainers)

    -- Create soldier
    local soldierBlueprint = ResourceManager:SearchForDataContainer('Characters/Soldiers/MpSoldier')
    local soldier = player:CreateSoldier(soldierBlueprint, transform)

    -- Spawn player standing up.
    player:SpawnSoldierAt(soldier, transform, CharacterPoseType.CharacterPoseType_Stand)
end

return M


