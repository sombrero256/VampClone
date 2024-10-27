extends WeaponTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource_ = preload("res://WeaponScenes/StarBomb/star_fire.tscn")
	base_stats_ = WeaponStats.new(2, 1)

func lvl_up(dmg_up: float,
			speed_up: float,
			area_up: float,
			modifiers: Array) -> void:
	super.lvl_up(dmg_up, speed_up, area_up, modifiers)
	wait_time /= base_stats_.speed_

func _on_timeout() -> void:
	#lvl_up(1.01, 1.01, 1.01 , [])
	create_weapon()
