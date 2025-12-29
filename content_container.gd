extends Node
class_name ContentContainer

static var custom_enemies : Dictionary

static var vanilla_enum_limit
static var custom_enemy_enum

static var instance

signal initialize

func _init():
	instance = self
	initialize.connect(cc_initialize)

func call_initialize_signal():
	initialize.emit()

func cc_initialize():
	vanilla_enum_limit = GameManager.enemy_scenes.size()
	custom_enemy_enum = vanilla_enum_limit + 1;


static func add_enemydef(enemyDef):
	enemyDef.index = custom_enemy_enum
	custom_enemy_enum += 1
	custom_enemies[enemyDef.index] = enemyDef
	return enemyDef.index

static func add_enemies_to_game():
	for enemy in custom_enemies.values():
		validate_enemy(enemy)
		# GameManager.enemy_scenes[enemy.index] = enemy.scene

static func validate_enemy(enemy):
		if enemy.scene == null:
			enemy.scene = load(enemy.scene_path)
