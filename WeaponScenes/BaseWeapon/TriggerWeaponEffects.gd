extends Timer

@onready var heart = preload("res://WeaponScenes/BaseWeapon/weapon.tscn")
var num_hearts = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout() -> void:
	for i in num_hearts:
		var heart_inst = heart.instantiate() as Node2D
		heart_inst.global_position = get_parent().global_position
		heart_inst.set_start_offset(i)
		get_node("/root").add_child(heart_inst)
	pass # Replace with function body.
