extends Node2D

var damage_ = 20
var is_flashing_ = false
var enemies_hit_: Dictionary

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.process_hit(damage_)
		enemies_hit_[body.name] = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.reset()
		enemies_hit_.erase(body.name)

func _process(delta: float) -> void:
	var sprite = get_node("explode") as Sprite2D
	if Engine.get_process_frames() % 12 == 0:
		if not is_flashing_:
			sprite.modulate = Color(2,2,2,2)
			is_flashing_ = true
			for enemy in enemies_hit_.values():
				enemy.process_hit(damage_)
				
		else:
			sprite.modulate = Color(1,1,1,1)
			is_flashing_ = false

func _on_timer_timeout() -> void:
	queue_free()
