extends TextureRect

@export var SpeedCostScaling: float
@export var HealthCostScaling: float

@export var SpeedBaseCost : int
@export var HealthBaseCost: int

@export var SpeedUpAmt: float
@export var HealtUpAmt: float

@export var SpeedUpgradeAnimal : Enemy.EnemyType
@export var HealthUpgradeAnimal : Enemy.EnemyType


func _on_speed_upgrade_button_button_up() -> void:
	if subtract_upgrade_cost(Globalstats.speed_levels,  SpeedCostScaling, SpeedBaseCost, SpeedUpgradeAnimal):
		Globalstats.speed_levels+=1
		Globalstats.player_stats.speed_up(SpeedUpAmt)
		update_labels()
	pass # Replace with function body.

func _on_health_upgrade_button_button_up() -> void:
	if subtract_upgrade_cost(Globalstats.health_levels,  HealthCostScaling, HealthBaseCost, HealthUpgradeAnimal):
		Globalstats.health_levels+=1
		Globalstats.player_stats.health_up(HealtUpAmt)
		update_labels()
	pass # Replace with function body.

func _on_visibility_changed() -> void:
	update_labels()
	pass # Replace with function body.

func update_labels() -> void:
	%HealthUpgradeCostLabel.text = str(calc_upgrade_cost(Globalstats.health_levels, HealthCostScaling, HealthBaseCost))
	%HealthUpgradeCostLabel.text = str(calc_upgrade_cost(Globalstats.speed_levels, SpeedCostScaling, SpeedBaseCost))
	
	%HealthUpgradeLevelLabel.text = str(Globalstats.health_levels)
	%SpeedUpgradeLevelLabel.text = str(Globalstats.speed_levels)
	
func subtract_upgrade_cost(levels: int, scale_factor: float, base_cost: int, animal_used: Enemy.EnemyType) -> bool:
	if Globalstats.GetSavedEnemies()[animal_used] >= calc_upgrade_cost(levels, scale_factor, base_cost):
		Globalstats._enemy_saved[animal_used] -= calc_upgrade_cost(levels, scale_factor, base_cost)
		return true
	return false

func calc_upgrade_cost(levels: int, scale_factor: float, base_cost: int) -> int:
	return int(base_cost + (levels * scale_factor))
