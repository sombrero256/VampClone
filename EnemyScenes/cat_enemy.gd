extends Enemy

var state_ : State
var initial_collision_mask_
var dest_: Vector2
enum State {SLEEPING, AWAKE}

func _ready():
	super._ready()
	state_ = State.SLEEPING

func _physics_process(delta: float) -> void:
	if frozen_: return
	if state_ == State.SLEEPING:
		return
	if Globalstats.CloseEnough(position, dest_):
		state_ = State.SLEEPING
	var dir = position.direction_to(dest_)
	velocity = dir * stats_.Speed
	move_and_slide()

func _on_wake_area_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	state_ = State.AWAKE
	sprite_.play("run")
	dest_ = body.position
