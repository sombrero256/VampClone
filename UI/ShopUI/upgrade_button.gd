extends TextureRect

@export var CorrespondingWeapon: BaseWeapon.WeaponType
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_upgrade_button_button_up() -> void:
	Globalstats._weapon_stats[CorrespondingWeapon].area_ += .1
	Globalstats._weapon_stats[CorrespondingWeapon].area_levels += 1
	update_labels()
	pass # Replace with function body.

func _on_damage_upgrade_button_button_up() -> void:
	Globalstats._weapon_stats[CorrespondingWeapon].damage_ += 1
	Globalstats._weapon_stats[CorrespondingWeapon].damage_levels += 1
	update_labels()
	pass # Replace with function body.

func _on_speed_upgrade_button_button_up() -> void:
	Globalstats._weapon_stats[CorrespondingWeapon].speed_ += 1
	Globalstats._weapon_stats[CorrespondingWeapon].speed_levels += 1
	update_labels()
	pass # Replace with function body.

func _on_visibility_changed() -> void:
	update_labels()
	pass # Replace with function body.

func update_labels() -> void:
	%AreaUpgradeLabel.text = str(Globalstats._weapon_stats[CorrespondingWeapon].area_levels)
	%DamageUpgradeLabel.text = str(Globalstats._weapon_stats[CorrespondingWeapon].damage_levels)
	%SpeedUpgradeLabel.text = str(Globalstats._weapon_stats[CorrespondingWeapon].speed_levels)
	pass
