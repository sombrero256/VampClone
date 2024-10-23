extends Enemy

@onready var player_ = get_tree().get_first_node_in_group("Player")
@onready var stats_ = get_node("EnemyStats") as EnemyStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set stats here
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var dir = position.direction_to(player_.position)
	velocity = dir * stats_.Speed
	move_and_slide()
