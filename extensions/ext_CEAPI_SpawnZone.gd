extends "res://Scripts/LevelMetadata/Zones/SpawnZone.gd"

func set_sprite(enemy_type_: Enemy.EnemyType, sprite_scale := Vector2(1, 1)):
	if(not enemy_type_ in Enemy.EnemyType):
		enemy_type_ = Enemy.EnemyType.SHOTGUN
		
	return super.set_sprite(enemy_type_, sprite_scale)
