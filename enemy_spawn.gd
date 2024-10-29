extends Node2D

enum {DOG, CAT, RAT}
const Modifier = preload("res://WeaponScenes/Base/weapon_stats_component.gd").Modifier
const WeaponType = preload("res://WeaponScenes/Base/base_weapon.gd").WeaponType

@export var enabled_: bool = true
@export var num_enemies_ = {DOG: 1, CAT: 1, RAT: 1}
@export var spawn_rate_inc_ = {DOG: 3, CAT: 2, RAT: 1} 
# Timer speeds up by this amount each hour
@export var speed_up_rate_: float = .95

@onready var player_ = get_tree().get_first_node_in_group("Player")
@onready var dog_enemy_ = preload("res://EnemyScenes/dog_enemy.tscn")
@onready var cat_enemy_ = preload("res://EnemyScenes/cat_enemy.tscn")
@onready var rat_swarm_ = preload("res://EnemyScenes/rat_swarm.tscn")

var prev_hour_: int = 0
@onready var EnemySpawner = get_node("%EnemySpawner") as Timer
var weapons_: Array[WeaponType]
	
##Creates new enemy object along the MonsterSpawnPath outside the camera position
##If we make new enemy types, we'll have to duplicate this for each type, or randomize it
func spawn_enemy(type, amount: int):
	if not enabled_:
		return
	var new_enemy: Node
	for i in amount:
		if type == DOG:
			new_enemy = dog_enemy_.instantiate()
		elif type == CAT:
			new_enemy = cat_enemy_.instantiate()
		elif type == RAT:
			new_enemy = rat_swarm_.instantiate()
		%MonsterSpawnPath.progress_ratio = randf()
		new_enemy.global_position = %MonsterSpawnPath.global_position
		add_child(new_enemy)

func _increaseSpawnRate(hour: int, minute: int) -> void:
	if hour != prev_hour_:
		prev_hour_ = hour
		for type in num_enemies_:
			num_enemies_[type] += spawn_rate_inc_[type]
		EnemySpawner.wait_time *= speed_up_rate_
		print("HOUR CHANGING, MORE ENEMIES ARE COMING!")
		print(num_enemies_)
		
		print("REMOVE ME! POWERING UP EXAMPLE")
		var player_stats = Globalstats.player_stats
		var before = player_stats.Cur_Health
		player_stats.heal(10)
		player_stats.speed_up(15)
		for type in WeaponType.values():
			Globalstats.GetWeaponStats(type).lvl_up(1.10, 1.10, 1.10, 
			[Modifier.FIRE, Modifier.ICE, Modifier.CRIT])
			
##Spawns enemies on timer.  Can adjust how many enemies.  Might be best to change to a loop at some point.
func _on_timer_timeout():
	for type in num_enemies_:
		spawn_enemy(type, num_enemies_[type])

func _on_ui_time_changed(hour: int, minute: int) -> void:
	_increaseSpawnRate(hour, minute)
