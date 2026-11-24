extends Object

func start_wave(chain: ModLoaderHookChain, wave_number):
	
	chain.reference_object.wave_spawn_zones = chain.reference_object.get_spawn_zones_from_wave_number(wave_number)
	
	for spawn_zone in chain.reference_object.wave_spawn_zones:
		
		if spawn_zone.enemy_type in UpgradeManager.LV1_ENEMY_TYPES:
			var lv1_enemydefs = GameManager.contentContainer.get_enemyDefs_by_level(1)
			for enemyDef in lv1_enemydefs:
				if randf() < enemyDef.spawn_chance:
					set_spawn_zone_enemy(spawn_zone, enemyDef)

	chain.execute_next([wave_number])

func set_spawn_zone_enemy(spawn_zone, enemyDef):

	spawn_zone.enemy_type = enemyDef.index
	spawn_zone.enemy_ai = enemyDef.ai_type.new()

	# redo just this part of of the enemy_type set property with our enemy type, as it will fail in the vanilla property.
	if spawn_zone.enemy_ai != null:
		var states_string_array = PackedStringArray()
		for state in spawn_zone.enemy_ai.INITIAL_STATES:
			states_string_array.append(spawn_zone.enemy_ai.States.keys()[state])
		states_string_array.append("DEFAULT")
		spawn_zone.enemy_state_hints = ",".join(states_string_array)
	else:
		spawn_zone.enemy_state_hints = ""


