extends Node2D

enum {DOG, CAT, RAT}

@export var enabled_: bool = true
@export var num_enemies_ = {DOG: 1, CAT: 1, RAT: 1}
@export var spawn_rate_inc_ = {DOG: 3, CAT: 2, RAT: 0} 
# Timer speeds up by this amount each hour
@export var speed_up_rate_: float = .95

@onready var dog_enemy = preload("res://EnemyScenes/dog_enemy.tscn")
@onready var cat_enemy = preload("res://EnemyScenes/cat_enemy.tscn")
@onready var rat_swarm = preload("res://EnemyScenes/rat_swarm.tscn")

var prev_hour_: int = 0
@onready var EnemySpawner = get_node("%EnemySpawner") as Timer

##Creates new enemy object along the MonsterSpawnPath outside the camera position
##If we make new enemy types, we'll have to duplicate this for each type, or randomize it
func spawn_enemy(type, amount: int):
	if not enabled_:
		return
	var new_enemy: Node
	for i in amount:
		if type == DOG:
			new_enemy = dog_enemy.instantiate()
		elif type == CAT:
			new_enemy = cat_enemy.instantiate()
		elif type == RAT:
			new_enemy = rat_swarm.instantiate()
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

##Spawns enemies on timer.  Can adjust how many enemies.  Might be best to change to a loop at some point.
func _on_timer_timeout():
	for type in num_enemies_:
		spawn_enemy(type, num_enemies_[type])

func _on_ui_time_changed(hour: int, minute: int) -> void:
	_increaseSpawnRate(hour, minute)
