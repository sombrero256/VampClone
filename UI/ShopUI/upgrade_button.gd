extends TextureRect

@export var CorrespondingWeapon: BaseWeapon.WeaponType

@export var AreaLvlUpAmt: float = 1.05
@export var SpeedLvlUpAmt: float = 1.05
@export var DamageLvlUpAmt: float = 1.05

@export var SpeedCostScaling: float
@export var AreaCostScaling: float
@export var DamageCostScaling: float

@export var SpeedBaseCost : int
@export var AreaBaseCost: int
@export var DamageBaseCost: int

@export var SpeedUpgradeAnimal : Enemy.EnemyType
@export var AreaUpgradeAnimal : Enemy.EnemyType
@export var DamageUpgradeAnimal : Enemy.EnemyType

func _ready() -> void:
	update_weapon_icon()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_upgrade_button_button_up() -> void:
	if subtract_upgrade_cost(Globalstats._weapon_stats[CorrespondingWeapon].area_levels,  AreaCostScaling, AreaBaseCost, AreaUpgradeAnimal):
		Globalstats._weapon_stats[CorrespondingWeapon].lvl_up(1, 1, AreaLvlUpAmt, [])
		Globalstats._weapon_stats[CorrespondingWeapon].area_levels += 1
		update_labels()
	pass # Replace with function body.

func _on_damage_upgrade_button_button_up() -> void:
	if subtract_upgrade_cost(Globalstats._weapon_stats[CorrespondingWeapon].damage_levels,  DamageCostScaling, DamageBaseCost, DamageUpgradeAnimal):
		Globalstats._weapon_stats[CorrespondingWeapon].lvl_up(DamageLvlUpAmt, 1, 1, [])
		Globalstats._weapon_stats[CorrespondingWeapon].damage_levels += 1
		update_labels()
	pass # Replace with function body.

func _on_speed_upgrade_button_button_up() -> void:
	if subtract_upgrade_cost(Globalstats._weapon_stats[CorrespondingWeapon].speed_levels,  SpeedCostScaling, SpeedBaseCost, SpeedUpgradeAnimal):
		Globalstats._weapon_stats[CorrespondingWeapon].lvl_up(1, SpeedLvlUpAmt, 1, [])
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

func update_weapon_icon() -> void:
	var weapon_icon_dict = {}
	weapon_icon_dict[BaseWeapon.WeaponType.HEART] = "res://WeaponScenes/Heart/heart.png"
	weapon_icon_dict[BaseWeapon.WeaponType.BOOMERANG] = "res://WeaponScenes/Boomerang/boom2.png"
	weapon_icon_dict[BaseWeapon.WeaponType.BUBBLE] = "res://WeaponScenes/StarBomb/assets/Bubble 1.png"
	%WeaponIcon.texture = load(weapon_icon_dict[CorrespondingWeapon])
	pass

func subtract_upgrade_cost(levels: int, scale_factor: float, base_cost: int, animal_used: Enemy.EnemyType) -> bool:
	if Globalstats.GetSavedEnemies()[animal_used] >= int(base_cost + (levels * scale_factor)):
		Globalstats._enemy_saved[animal_used] -= int(base_cost + (levels * scale_factor))
		return true
	return false
