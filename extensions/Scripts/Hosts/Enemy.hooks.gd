extends Object

func calculate_score_value(chain: ModLoaderHookChain):
	# run as normal if we're normal
	if(chain.reference_object.enemy_type in Enemy.EnemyType || not chain.reference_object.enemy_type in GameManager.contentContainer.custom_enemies):
		chain.execute_next()
		return

	#if not, temporarily replace the enemy_type with a normal one, and do your calculation
	var orig_enemy_type = chain.reference_object.enemy_type
	chain.reference_object.enemy_type = Enemy.EnemyType.SHOTGUN

	#pretend we're normal and run
	chain.execute_next()
	
	#get the result from the normal calculation
	var shotgunResult = chain.reference_object.score
	
	#reverse engineer the multiplier based on the result we got from a shotgunbot
	#todo: factor in elite?
	var reverse_engineered_score_mult = shotgunResult/Fitness.enemy_score_values[Enemy.EnemyType.SHOTGUN]
	chain.reference_object.enemy_type = orig_enemy_type
	
	#multiply based on our funny score mult we devised
	chain.reference_object.score = reverse_engineered_score_mult * GameManager.contentContainer.custom_enemies[orig_enemy_type].fitness_score
