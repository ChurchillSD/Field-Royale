spawn_utils = require('spawn_utils')

print("AHH")

NetEvents:Subscribe('player_joined', function(player)
    print('Got NetEvent from player:')
    print(player.name)
    transform = LinearTransform(
        Vec3(-0.976942, 0.000000, -0.213504),
        Vec3(0.000000, 1.000000, 0.000000),
        Vec3(0.213504, 0.000000, -0.976942),
        Vec3(-336.465790, 149.263489, 547.196411)
    )
    
    spawn_utils.spawn_soldier(player, transform)
end)