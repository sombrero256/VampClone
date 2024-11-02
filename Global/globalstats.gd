extends Node

##This is a player stat tracker for all stats we want to track across scenes
##Please do not try to reset or destroy this, or it will crash the game!

const EnemyType = preload("res://EnemyScenes/enemy.gd").EnemyType
const WeaponType = preload("res://WeaponScenes/Base/base_weapon.gd").WeaponType

static var need_to_defeat_boss: bool = false
static var player_stats: PlayerStats = PlayerStats.new()
static var night: int = 0
static var times_healed: int = 0

# Which night has bosses
const boss_nights = [2, 6]

static var _enemy_saved: Dictionary = {
	EnemyType.DOG: 0,
	EnemyType.CAT: 0,
	EnemyType.RAT: 0,
	EnemyType.HORSE: 0,
	EnemyType.BOSS: 0,
}
static var _weapon_stats: Dictionary = {
		WeaponType.HEART: WeaponStats.new(30, 1),
		WeaponType.BOOMERANG: WeaponStats.new(50, 250),
		WeaponType.BUBBLE: WeaponStats.new(2.5, 1)
	}

static func IsBossNight() -> bool:
	return night in boss_nights
	
static func NeedToDefeatBoss() -> bool:
	return IsBossNight() && need_to_defeat_boss

static func CloseEnough(pos1: Vector2 , pos2: Vector2) -> bool:
	return pos1.distance_to(pos2) < 5.0

static func SavedEnemy(type: EnemyType, amt: int) -> void:
	if type == EnemyType.BOSS:
		need_to_defeat_boss = false
		_enemy_saved[EnemyType.DOG] += 100
		_enemy_saved[EnemyType.CAT] += 100
		_enemy_saved[EnemyType.RAT] += 200
		_enemy_saved[EnemyType.HORSE] += 50
	_enemy_saved[type] += amt

static func GetSavedEnemies() -> Dictionary:
	return _enemy_saved

static func GetWeaponStats(type_: WeaponType) -> WeaponStats:
	return _weapon_stats[type_]
