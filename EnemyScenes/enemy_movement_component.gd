extends Node2D

@onready var parent = get_parent() as CharacterBody2D
@onready var player = get_tree().get_first_node_in_group("Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = parent.position.direction_to(player.position)
	parent.velocity = dir * 50
	pass

func _physics_process(delta: float) -> void:
	parent.move_and_slide()
	pass
