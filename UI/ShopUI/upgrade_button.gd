extends TextureRect

@export var CorrespondingWeapon: BaseWeapon.WeaponType
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_upgrade_button_button_up() -> void:
	Globalstats._weapon_stats[CorrespondingWeapon].area_ += 1
	pass # Replace with function body.


func _on_damage_upgrade_button_button_up() -> void:
	Globalstats._weapon_stats[CorrespondingWeapon].damage_ += 1
	pass # Replace with function body.


func _on_speed_upgrade_button_button_up() -> void:
	Globalstats._weapon_stats[CorrespondingWeapon].speed_ += 1
	pass # Replace with function body.
