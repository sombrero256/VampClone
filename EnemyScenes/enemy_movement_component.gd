extends Node2D

@onready var parent = get_parent() as RigidBody2D
@onready var player = get_tree().get_first_node_in_group("Player")
# Called when the node enters the scene tree for the first time.

var velocity
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var dir = parent.position.direction_to(player.position)
	velocity = dir * 50
	parent.move_and_collide(velocity * delta)
	pass
