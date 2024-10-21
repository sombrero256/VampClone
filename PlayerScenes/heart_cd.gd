extends Timer

@onready var heart_ = preload("res://WeaponScenes/BaseWeapon/weapon.tscn")
var num_hearts_: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	num_hearts_ = 6
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout() -> void:
	if num_hearts_ == 0:
		return
	var degrees = 360 / num_hearts_
	for i in num_hearts_:
		var heart_inst = heart_.instantiate() as Node2D
		heart_inst.global_position = get_parent().global_position
		heart_inst.set_start_offset(degrees * i)
		get_node("/root/Main/%GameWorld").add_child(heart_inst)
