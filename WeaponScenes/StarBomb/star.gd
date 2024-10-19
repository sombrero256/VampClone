extends CharacterBody2D

@onready var star_explode_ = preload("res://WeaponScenes/StarBomb/star_explode.tscn")
const Direction = preload("res://PlayerScenes/player.gd").Direction

var y_boost_ = -55.0
var x_velocity_ = 15.0
var x_drag_ = -1.45
var direction_: Direction

func _ready() -> void:
	#for child in get_node("/root").get_children():
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	velocity = player.velocity
	direction_ = player.get_direction()
# TODO: Set direction based on input direction 
#func set_direction(direction: )

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if direction_ == Direction.LEFT:
		velocity.x -= max(x_velocity_, 0)
	else:
		velocity.x += max(x_velocity_, 0)
	velocity.y += min(y_boost_, 0)

	if y_boost_ < 0: y_boost_ += 2.65
	if abs(velocity.x) > 0: x_velocity_ += x_drag_
	velocity += get_gravity() * (delta * 1.375)
	move_and_slide()


func _on_explode_timeout() -> void:
	var explode_inst = star_explode_.instantiate() as Node2D
	explode_inst.global_position = global_position
	get_node("/root").add_child(explode_inst)	
	get_parent().queue_free()
