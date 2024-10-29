extends WeaponTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource_ = preload("res://WeaponScenes/Boomerang/Boomerang.tscn")

func _on_timeout() -> void:
	create_weapon()
