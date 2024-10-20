extends CharacterBody2D

@onready var sprite = get_node("%sprite") as Sprite2D
@onready var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
const Direction = preload("res://PlayerScenes/player.gd").Direction


@onready var RETURN_TIME = Engine.get_frames_per_second() * 2

const CLOSE_ENOUGH = 5.0
const DISTANCE = 400

var damage_ = 50
var dest_: Vector2
var status_ = GOING 
var direction_: Direction

enum {GOING, RETURN}

func _ready() -> void:
	_reset()

func _reset() -> void:
	dest_ = position
	direction_ = player.get_direction()
	if direction_ == Direction.LEFT:
		# Reverse fire
		dest_.x += DISTANCE
	else:
		dest_.x -= DISTANCE
	if player.velocity.y > 0:
		dest_.y -= DISTANCE
	elif player.velocity.y == 0:
		pass
	else:
		dest_.y += DISTANCE 
	status_ =  GOING

func _pretty_close() -> bool:
	var dist = position.distance_to(dest_)
	return dist < CLOSE_ENOUGH

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if direction_ == Direction.LEFT:
		#velocity.x -= max(x_velocity_, 0)
	#else:
	if status_ == GOING and _pretty_close():
		status_ = RETURN
	if status_ == RETURN:
		dest_ = player.position
		if _pretty_close():
			_reset()
	var dir = position.direction_to(dest_)
	velocity = dir * 250
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite.rotate(deg_to_rad(3))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.process_hit(damage_)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.reset()
