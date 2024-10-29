extends WeaponTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource_ = preload("res://WeaponScenes/StarBomb/star_fire.tscn")

func _on_timeout() -> void:
	create_weapon()
