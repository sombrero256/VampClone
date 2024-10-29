class_name StarExplode extends Area2D

const WeaponType = preload("res://WeaponScenes/Base/base_weapon.gd").WeaponType

var is_flashing_ = false
var enemies_hit_: Dictionary

func _ready() -> void:
	scale  *= _stats().area_

func _stats() -> WeaponStats:
	return Globalstats.GetWeaponStats(WeaponType.BUBBLE)

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.process_hit(_stats().damage_)
		enemies_hit_[body.name] = body

func _on_body_exited(body: Node2D) -> void:
	if body is Enemy:
		body.reset()
		enemies_hit_.erase(body.name)

func _process(delta: float) -> void:
	var sprite = get_node("explode") as AnimatedSprite2D
	sprite.speed_scale = .55
	sprite.play()
	if Engine.get_process_frames() % 12 == 0:
		if not is_flashing_:
			is_flashing_ = true
			for enemy in enemies_hit_.values():
				enemy.process_hit(_stats().damage_)
				_stats().try_apply_modifiers(enemy)
		else:
			is_flashing_ = false

func _on_flames_timeout() -> void:
	queue_free()
