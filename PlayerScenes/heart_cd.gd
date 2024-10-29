extends WeaponTimer

var num_hearts_: int = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource_ = preload("res://WeaponScenes/Heart/weapon.tscn")
	pass # Replace with function body.

func _on_timeout() -> void:
	if num_hearts_ == 0:
		return
	var degrees = 360 / num_hearts_
	for i in num_hearts_:
		var heart_inst = create_weapon()
		heart_inst.set_start_offset(degrees * i)
