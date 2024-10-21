extends Timer

@onready var star_ = preload("res://WeaponScenes/StarBomb/star_fire.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout() -> void:
	var star_inst = star_.instantiate() as Node2D
	star_inst.global_position = get_parent().global_position
	get_node("/root").add_child(star_inst)
