extends "res://Globals/GameManager.gd"

var contentContainer

func spawn_enemy(type: Enemy.EnemyType):
	if type <= contentContainer.vanilla_enum_limit:
		return super.spawn_enemy(type)
		
	var new_enemy = contentContainer.custom_enemies[type].scene.instantiate()
	new_enemy.add_to_group("enemy")	
	enemy_count += 1
	hosts.append(new_enemy)
	return new_enemy

func _ready():

	super._ready()

	contentContainer = get_node("/root/ModLoader/TheTimesweeper-CustomEnemyAPI/ContentContainer")
	
	ModLoaderLog.error("ready gamemanager", "CEAPI")

	contentContainer.call_initialize_signal()

	contentContainer.add_enemies_to_game()
		
#func get_player_skin_paths_for_enemy_type(enemy_type):
	#
	#if enemy_type > ContentContainer.vanilla_enum_limit:
		#return ContentContainer.custom_enemies[enemy_type].default_skin_path
#
	#return super.get_player_skin_paths_for_enemy_type(enemy_type)
