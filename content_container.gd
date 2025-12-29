extends Node
class_name ContentContainer
var custom_enemies : Dictionary

var vanilla_enum_limit
var custom_enemy_enum

var instance

signal initialize

func _init():
	initialize.connect(cc_initialize)

func call_initialize_signal():
	initialize.emit()

func cc_initialize():
	vanilla_enum_limit = GameManager.enemy_scenes.size()
	custom_enemy_enum = vanilla_enum_limit + 1;

func create_new_enemydef():
	return CustomEnemyDef.new()

func add_enemydef(enemyDef):
	enemyDef.index = custom_enemy_enum
	custom_enemy_enum += 1
	custom_enemies[enemyDef.index] = enemyDef
	return enemyDef.index

func add_enemies_to_game():
	for enemy in custom_enemies.values():
		validate_enemy(enemy)
		# GameManager.enemy_scenes[enemy.index] = enemy.scene

func validate_enemy(enemy):
		if enemy.scene == null:
			enemy.scene = load(enemy.scene_path)

class CustomEnemyDef:

	var index

	var name
	var scene = null
	var scene_path
	var default_skin_path
