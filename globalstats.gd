class_name PlayerUnlocks extends Node

##This is a player stat tracker for all stats we want to track across scenes
##Please do not try to reset or destroy this, or it will crash the game!

const EnemyType = preload("res://EnemyScenes/enemy.gd").EnemyType

static var _enemy_saved: Dictionary = {}

static func SavedEnemy(type: EnemyType):
	if !_enemy_saved.has(type):
		_enemy_saved[type] = 0
	_enemy_saved[type] += 1

static func GetSavedEnemies() -> Dictionary:
	for type in _enemy_saved.keys():
		print("Saved: %d amount of %ss" % [_enemy_saved[type], str(EnemyType.keys()[type])])
	return _enemy_saved
