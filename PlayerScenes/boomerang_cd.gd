extends WeaponTimer

var boomerang_: Boomerang
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource_ = preload("res://WeaponScenes/Boomerang/Boomerang.tscn")
	base_stats_ = WeaponStats.new(25, 250)

func lvl_up(dmg_up: float,
			speed_up: float,
			area_up: float,
			modifiers: Array) -> void:
	boomerang_.lvl_up(dmg_up, speed_up, area_up, modifiers)

func _on_timeout() -> void:
	boomerang_ = create_weapon()
