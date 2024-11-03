class_name BossHoming extends CharacterBody2D

@onready var player_ = get_tree().get_first_node_in_group("Player")

var inc_ = 60
var ready_to_fire_ = false
var dest_

func _ready():
	var invert = [-50, 50]
	dest_ = Vector2(position.x + invert.pick_random(),
					position.y + invert.pick_random())

func _physics_process(delta) -> void:
	if not ready_to_fire_:
		if Globalstats.CloseEnough(position, dest_):
			ready_to_fire_ = true
	else:
		dest_ = player_.position
	var dir = position.direction_to(dest_)
	inc_ += 15 * delta
	velocity = dir * inc_
	move_and_slide()

func _on_timer_timeout() -> void:
	queue_free()
