extends Node2D

var Weapon_Stats: WeaponStats
var Cooldown: Timer

# if we want to get really advanced we could add an export list here
# which takes in the weapon effects as a list of scenes(?) and adds them as children
# of the cooldown component
# then we could use scene inheritence to add weapons very quickly

func _ready() -> void:
	Weapon_Stats = find_child('WeaponStats')
	Cooldown = find_child('Cooldown')
	
	Cooldown.wait_time = Weapon_Stats.cooldown
	Cooldown.start()
	pass # Replace with function body.

func _on_cooldown_timeout() -> void:
	print('timeout')
	pass # Replace with function body.
