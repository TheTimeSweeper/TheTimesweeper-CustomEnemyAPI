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

func create_new_enemyDef():
	return CustomEnemyDef.new()

func add_enemyDef(enemyDef):
	enemyDef.index = custom_enemy_enum
	custom_enemy_enum += 1
	custom_enemies[enemyDef.index] = enemyDef
	return enemyDef.index

func add_enemyDefs_to_game():
	for enemy in custom_enemies.values():
		validate_enemyDef(enemy)
		# GameManager.enemy_scenes[enemy.index] = enemy.scene

func validate_enemyDef(enemy):
		if enemy.scene == null:
			enemy.scene = load(enemy.scene_path)
		# todo do the math
		enemy.spawn_chance = enemy.spawn_weight/5.0

func get_enemyDefs_by_level(level):

	var enemyDefs = []
	for enemyDef in custom_enemies.values():
		if enemyDef.spawn_level == level:
			enemyDefs.append(enemyDef)

	return enemyDefs

class CustomEnemyDef:

	var index

	var name
	var scene = null
	var scene_path
	var default_skin_path
	var fitness_score
	# 1-3. 0 means we will not try to replace this bot into levels
	var spawn_level
	# weight distgributed among bots of same tier for how often this bot will spawn. used to calculate spawn_chance
	var spawn_weight = 1
	# don't set this manually, set spawn_weight instead. Chance this enemy randomly replaces an enemy of its level tier on spawn
	var spawn_chance = 0
