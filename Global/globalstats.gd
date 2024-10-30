extends Node

##This is a player stat tracker for all stats we want to track across scenes
##Please do not try to reset or destroy this, or it will crash the game!

const EnemyType = preload("res://EnemyScenes/enemy.gd").EnemyType
const WeaponType = preload("res://WeaponScenes/Base/base_weapon.gd").WeaponType

static var player_stats: PlayerStats
static var night: int = 0

static var _enemy_saved: Dictionary = {}
static var _weapon_stats: Dictionary = {}

func _ready() -> void:
	player_stats = PlayerStats.new()
	_weapon_stats = {
		WeaponType.HEART: WeaponStats.new(30, 1),
		WeaponType.BOOMERANG: WeaponStats.new(40, 250),
		WeaponType.BUBBLE: WeaponStats.new(3, 1)
	}

static func CloseEnough(pos1: Vector2 , pos2: Vector2) -> bool:
	return pos1.distance_to(pos2) < 5.0

static func SavedEnemy(type: EnemyType, amt: int) -> void:
	if !_enemy_saved.has(type):
		_enemy_saved[type] = 0
	_enemy_saved[type] += amt

static func GetSavedEnemies() -> Dictionary:
	for type in _enemy_saved.keys():
		print("Saved: %d amount of %ss" % [_enemy_saved[type], str(EnemyType.keys()[type])])
	return _enemy_saved

static func GetWeaponStats(type_: WeaponType) -> WeaponStats:
	return _weapon_stats[type_]
