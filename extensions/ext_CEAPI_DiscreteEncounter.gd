extends "res://Scripts/Discrete/DiscreteEncounter.gd"

func start_wave(wave_number):
	
	wave_spawn_zones = get_spawn_zones_from_wave_number(wave_number)
	
	for spawn_zone in wave_spawn_zones:
		
		if spawn_zone.enemy_type in UpgradeManager.LV1_ENEMY_TYPES:
			var lv1_enemydefs = GameManager.contentContainer.get_enemyDefs_by_level(1)
			for enemyDef in lv1_enemydefs:
				if randf() < enemyDef.spawn_chance:
					set_spawn_zone_enemy(spawn_zone, enemyDef.index)
		
		#if ((1 << spawn_zone.enemy_type) & Enemy.EnemyType.CHAIN | Enemy.EnemyType.FLAME | Enemy.EnemyType.WHEEL | Enemy.EnemyType.SHOTGUN) != 0 :
			#pass
			
	
	super.start_wave(wave_number)

func set_spawn_zone_enemy(spawn_zone, enemyIndex):
	spawn_zone.enemy_type = enemyIndex
	# we have just done some unholy stuff and a setter is about to try and fail to run. we basically have to do everything the setter was going to do I think
	# you know what let's just try it
	#todo set_sprite(enemy_type)

	# TODO: This will break get_all_AI_upgrades_for_enemy_type, I just learned.
	# enemy_ai = null

