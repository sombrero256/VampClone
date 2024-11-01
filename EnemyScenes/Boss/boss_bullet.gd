class_name BossBullet extends CharacterBody2D

func set_start_offset(offset_by) -> void:
	rotate(deg_to_rad(offset_by))

func _physics_process(delta) -> void:
	#y = mx + b
	move_local_x(3)

func _on_timer_timeout() -> void:
	queue_free()
