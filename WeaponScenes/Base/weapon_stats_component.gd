class_name WeaponStats

enum Modifier {FIRE, ICE, CRIT, EXPLODE}
# How likely 
const ModifierChance = {
	Modifier.FIRE: .1,
	Modifier.ICE: .1,
	Modifier.CRIT: .1
}

@export
var damage_: float
@export
var speed_: float
@export
var area_: float = 1.0
@export
var modifiers_: Array = []

# Get whether or not to activate the given modifier
func try_apply_modifiers(enemy: Enemy) -> void:
	for modifier in modifiers_:
		var dice_roll = randf()
		if dice_roll <= ModifierChance[modifier]:
			if modifier == Modifier.FIRE:
				enemy.SetOnFire()
			elif modifier == Modifier.ICE:
				enemy.Freeze()
			elif modifier == Modifier.CRIT:
				enemy.Crit()

func _init (dmg: float, speed: float):
	damage_ = dmg
	speed_ = speed
