class_name Boomerang extends BaseWeapon

@onready var sprite = get_node("%sprite") as Sprite2D
@onready var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
const Direction = preload("res://PlayerScenes/player.gd").Direction

@onready var RETURN_TIME = Engine.get_frames_per_second() * 2

const DISTANCE = 400

var dest_: Vector2
var status_ = GOING 
var direction_: Direction
var base_scale_: Vector2

enum {GOING, RETURN}

func _ready() -> void:
	base_scale_ = scale
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

func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return
	if status_ == GOING and Globalstats.CloseEnough(position, dest_):
		status_ = RETURN
	if status_ == RETURN:
		dest_ = player.position
		if Globalstats.CloseEnough(position, dest_):
			_reset()
	var dir = position.direction_to(dest_)
	velocity = dir * stats().speed_
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale = base_scale_ * stats().area_
	sprite.rotate(deg_to_rad(3))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.process_hit(stats().damage_)
		stats().try_apply_modifiers(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy:
		body.reset()
