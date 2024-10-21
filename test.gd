extends Node2D

var num_enemies_: int = 6

##Creates new enemy object along the MonsterSpawnPath outside the camera position
##If we make new enemy types, we'll have to duplicate this for each type, or randomize it
func spawn_enemy():
	var new_enemy = preload("res://EnemyScenes/enemy.tscn").instantiate()
	%MonsterSpawnPath.progress_ratio = randf()
	new_enemy.global_position = %MonsterSpawnPath.global_position
	add_child(new_enemy)
	new_enemy.add_to_group("Enemy")
	
##Spawns enemies on timer.  Can adjust how many enemies.  Might be best to change to a loop at some point.
func _on_timer_timeout():
	for i in num_enemies_:
		spawn_enemy()
	
