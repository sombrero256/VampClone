extends Node2D

@onready var transform_ani_ = $EndScene/AnimationPlayer
@onready var dialogue_control_: EndingControl = $EndScene/Control
@onready var ending_ = $EndScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_instance_valid(transform_ani_): return
	if transform_ani_.is_playing(): return
	if dialogue_control_.dialogue_active == false:
		dialogue_control_.start()
