extends Object

func set_sprite(chain: ModLoaderHookChain, enemy_type_: Enemy.EnemyType, sprite_scale := Vector2(1, 1)):
	if(not enemy_type_ in Enemy.EnemyType):
		enemy_type_ = Enemy.EnemyType.SHOTGUN
		
	return chain.execute_next([enemy_type_, sprite_scale])
