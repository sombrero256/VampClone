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

@export var FreezeCost: int = 50
@export var FireCost: int = 50
@export var CritCost: int = 50

@export var FreezeUpgradeAnimal : Enemy.EnemyType
@export var FireUpgradeAnimal: Enemy.EnemyType
@export var CritUpgradeAnimal: Enemy.EnemyType

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
	%AreaUpgradeLabel.text = str(calc_upgrade_cost(Globalstats._weapon_stats[CorrespondingWeapon].area_levels, AreaCostScaling, AreaBaseCost))
	%DamageUpgradeLabel.text = str(calc_upgrade_cost(Globalstats._weapon_stats[CorrespondingWeapon].damage_levels, DamageCostScaling, DamageBaseCost))
	%SpeedUpgradeLabel.text = str(calc_upgrade_cost(Globalstats._weapon_stats[CorrespondingWeapon].speed_levels, SpeedCostScaling, SpeedBaseCost))
	%FireUpgradeLabel.text = str(FireCost)
	%CritUpgradeLabel.text = str(CritCost)
	%FreezeUpgradeLabel.text = str(FreezeCost)
	
	for modifier in Globalstats._weapon_stats[CorrespondingWeapon].modifiers_:
		match modifier:
			WeaponStats.Modifier.ICE:
				%FreezeContainer.visible = false
			WeaponStats.Modifier.FIRE:
				%FireContainer.visible = false
			WeaponStats.Modifier.CRIT:
				%CritContainer.visible = false
			_: pass
	pass

func update_weapon_icon() -> void:
	var weapon_icon_dict = {}
	weapon_icon_dict[BaseWeapon.WeaponType.HEART] = "res://WeaponScenes/Heart/heart.png"
	weapon_icon_dict[BaseWeapon.WeaponType.BOOMERANG] = "res://WeaponScenes/Boomerang/boomerang_icon.png"
	weapon_icon_dict[BaseWeapon.WeaponType.BUBBLE] = "res://WeaponScenes/StarBomb/assets/Bubble 1.png"
	%WeaponIcon.texture = load(weapon_icon_dict[CorrespondingWeapon])
	pass

func _on_freeze_upgrade_button_button_up() -> void:
	if Globalstats.GetSavedEnemies()[FreezeUpgradeAnimal] >= FreezeCost:
		Globalstats._enemy_saved[FreezeUpgradeAnimal] -= FreezeCost
		Globalstats._weapon_stats[CorrespondingWeapon].lvl_up(1, 1, 1, [WeaponStats.Modifier.ICE])

		update_labels()

func _on_crit_upgrade_button_button_up() -> void:
	if Globalstats.GetSavedEnemies()[CritUpgradeAnimal] >= CritCost:
		Globalstats._enemy_saved[CritUpgradeAnimal] -= CritCost
		Globalstats._weapon_stats[CorrespondingWeapon].lvl_up(1, 1, 1, [WeaponStats.Modifier.CRIT])
		update_labels()

func _on_fire_upgrade_button_button_up() -> void:
	if Globalstats.GetSavedEnemies()[FireUpgradeAnimal] >= FireCost:
		Globalstats._enemy_saved[FireUpgradeAnimal] -= FireCost
		Globalstats._weapon_stats[CorrespondingWeapon].lvl_up(1, 1, 1, [WeaponStats.Modifier.FIRE])
		update_labels()

func subtract_upgrade_cost(levels: int, scale_factor: float, base_cost: int, animal_used: Enemy.EnemyType) -> bool:
	if Globalstats.GetSavedEnemies()[animal_used] >= calc_upgrade_cost(levels, scale_factor, base_cost):
		Globalstats._enemy_saved[animal_used] -= calc_upgrade_cost(levels, scale_factor, base_cost)
		return true
	return false

func calc_upgrade_cost(levels: int, scale_factor: float, base_cost: int) -> int:
	return int(base_cost + (levels * scale_factor))
