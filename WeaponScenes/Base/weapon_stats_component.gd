class_name WeaponStats

enum Modifier {FIRE, ICE, CRIT}
# How likely a modifier will proc
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

var damage_levels = 0
var speed_levels = 0
var area_levels = 0

func lvl_up(dmg_up: float, speed_up: float, area_up: float, modifiers: Array):
	damage_ *= dmg_up
	speed_ *= speed_up
	area_ *= area_up
	modifiers_ += modifiers

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
