extends Enemy

const RAGE_MAX = 10
const RAGE_THRESHOLD = .4

var rage_counter_ = 0
var state_ = WALKING
enum {WALKING, RAGING, CHARGING}

@onready var rage_ani_ = $AnimationPlayer
@onready var player_ = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	if state_ != WALKING:
		sprite_.play("mad")
		if !rage_ani_.is_playing():
			state_ = CHARGING
	elif health_.value/float(health_.max_value) < RAGE_THRESHOLD:
		state_ = RAGING
		rage_ani_.play("RAGING")
		stats_.Speed += 120

func _physics_process(delta: float) -> void:
	if frozen_: return
	if state_ == RAGING: return
	var dir = position.direction_to(player_.position)
	velocity = dir * stats_.Speed
	move_and_slide()
