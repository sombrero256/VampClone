extends Node2D

@export var spawn_rate_: int = 2 
# Timer speeds up by this amount each hour
@export var speed_up_rate_: float = .90 

var num_enemies_: int = 5
var prev_hour_: int = 0
@onready var EnemySpawner = get_node("%EnemySpawner") as Timer

##Creates new enemy object along the MonsterSpawnPath outside the camera position
##If we make new enemy types, we'll have to duplicate this for each type, or randomize it
func spawn_enemy():
	var new_enemy = preload("res://EnemyScenes/enemy.tscn").instantiate()
	%MonsterSpawnPath.progress_ratio = randf()
	new_enemy.global_position = %MonsterSpawnPath.global_position
	add_child(new_enemy)
	new_enemy.add_to_group("Enemy")

func _increaseSpawnRate(hour: int, minute: int) -> void:
	if hour != prev_hour_:
		prev_hour_ = hour
		num_enemies_ += spawn_rate_
		EnemySpawner.wait_time *= .90
		print("HOUR CHANGING, ENEMIES ARE COMING! num_enemies %d %f" % 
			[num_enemies_, EnemySpawner.wait_time])

##Spawns enemies on timer.  Can adjust how many enemies.  Might be best to change to a loop at some point.
func _on_timer_timeout():
	for i in num_enemies_:
		spawn_enemy()


func _on_ui_time_changed(hour: int, minute: int) -> void:
	_increaseSpawnRate(hour, minute)
