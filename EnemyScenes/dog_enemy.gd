extends Enemy

@onready var player_ = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	if frozen_: return
	var dir = position.direction_to(player_.position)
	velocity = dir * stats_.Speed
	move_and_slide()
