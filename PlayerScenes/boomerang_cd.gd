extends Timer

@onready var boomerang_ = preload("res://WeaponScenes/Boomerang/Boomerang.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout() -> void:
	var b_inst = boomerang_.instantiate() as Node2D
	b_inst.global_position = get_parent().global_position
	get_node("/root/Main/%GameWorld").add_child(b_inst)
