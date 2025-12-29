extends Object

func start_wave(chain: ModLoaderHookChain, wave_number):
	
	chain.reference_object.wave_spawn_zones = chain.reference_object.get_spawn_zones_from_wave_number(wave_number)
	
	for spawn_zone in chain.reference_object.wave_spawn_zones:
		
		if spawn_zone.enemy_type in UpgradeManager.LV1_ENEMY_TYPES:
			var lv1_enemydefs = GameManager.contentContainer.get_enemyDefs_by_level(1)
			for enemyDef in lv1_enemydefs:
				if randf() < enemyDef.spawn_chance:
					set_spawn_zone_enemy(spawn_zone, enemyDef.index)

	chain.execute_next([wave_number])


func set_spawn_zone_enemy(spawn_zone, enemyIndex):
	spawn_zone.enemy_type = enemyIndex
	
	# we have just done some unholy stuff and a setter is about to try and fail to run. we basically have to do everything the setter was going to do I think
	# we hook spawnzone.set_sprite(enemy_type) to fix it

	# TODO: This will break get_all_AI_upgrades_for_enemy_type, I just learned.
	# enemy_ai = null
		# guess we don't have to worry about it cause we aren't adding any bots to the golem fight :lul:
