extends Node2D

const EnemyType = preload("res://EnemyScenes/enemy.gd").EnemyType
const Modifier = preload("res://WeaponScenes/Base/weapon_stats_component.gd").Modifier
const WeaponType = preload("res://WeaponScenes/Base/base_weapon.gd").WeaponType

@export var enabled_: bool = false
# Timer speeds up by this amount each hour
@export var speed_up_rate_: float = .95

@onready var player_ = get_tree().get_first_node_in_group("Player")
@onready var dog_enemy_ = preload("res://EnemyScenes/dog_enemy.tscn")
@onready var cat_enemy_ = preload("res://EnemyScenes/cat_enemy.tscn")
@onready var rat_swarm_ = preload("res://EnemyScenes/rat_swarm.tscn")
@onready var horse_enemy_ = preload("res://EnemyScenes/horse_enemy.tscn")

var prev_hour_: int = 0
var wave_: Dictionary
@onready var EnemySpawner = get_node("%EnemySpawner") as Timer
var weapons_: Array[WeaponType]
var enemyWaves_: EnemyWaves = EnemyWaves.new()

func _ready() -> void:
	wave_ = enemyWaves_.get_enemy_wave(prev_hour_)

##Creates new enemy object along the MonsterSpawnPath outside the camera position
##If we make new enemy types, we'll have to duplicate this for each type, or randomize it
func spawn_enemy(type, amount: int):
	if not enabled_:
		return
	var new_enemy: Node
	for i in amount:
		if type == EnemyType.DOG:
			new_enemy = dog_enemy_.instantiate()
		elif type == EnemyType.CAT:
			new_enemy = cat_enemy_.instantiate()
		elif type == EnemyType.RAT:
			new_enemy = rat_swarm_.instantiate()
		elif type == EnemyType.HORSE:
			new_enemy = horse_enemy_.instantiate()
		%MonsterSpawnPath.progress_ratio = randf()
		new_enemy.global_position = %MonsterSpawnPath.global_position
		add_child(new_enemy)

func _increaseSpawnRate(hour: int, minute: int) -> void:
	if hour != prev_hour_:
		prev_hour_ = hour
		EnemySpawner.wait_time *= speed_up_rate_
		wave_ = enemyWaves_.get_enemy_wave(prev_hour_)

##Spawns enemies on timer.  Can adjust how many enemies.  Might be best to change to a loop at some point.
func _on_timer_timeout():
	for type in wave_:
		spawn_enemy(type, wave_[type])

func _on_ui_time_changed(hour: int, minute: int) -> void:
	_increaseSpawnRate(hour, minute)
