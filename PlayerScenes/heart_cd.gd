extends WeaponTimer

var num_hearts_: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	num_hearts_ = 6
	resource_ = preload("res://WeaponScenes/Heart/weapon.tscn")
	base_stats_ = WeaponStats.new(20, 3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timeout() -> void:
	if num_hearts_ == 0:
		return
	var degrees = 360 / num_hearts_
	for i in num_hearts_:
		var heart_inst = create_weapon()
		heart_inst.set_start_offset(degrees * i)
