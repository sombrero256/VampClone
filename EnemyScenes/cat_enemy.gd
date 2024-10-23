extends Enemy

@onready var stats_ = get_node("EnemyStats") as EnemyStats
const CLOSE_ENOUGH = 5.0

var state_ : State
var initial_collision_mask_
var dest_: Vector2
enum State {SLEEPING, AWAKE}

func _ready():
	state_ = State.SLEEPING

func _physics_process(delta: float) -> void:
	if state_ == State.SLEEPING:
		return
	if position.distance_to(dest_) < CLOSE_ENOUGH:
		state_ = State.SLEEPING
	var dir = position.direction_to(dest_)
	velocity = dir * stats_.Speed
	move_and_slide()

func _on_wake_area_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	state_ = State.AWAKE
	dest_ = body.position
	pass # Replace with function body.
