class_name Weapon extends Node2D

var Weapon_Stats: WeaponStats
var Cooldown: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Weapon_Stats = find_child('WeaponStats')
	Cooldown = find_child('Cooldown')
	Cooldown.wait_time = Weapon_Stats.cooldown
	Cooldown.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cooldown_timeout() -> void:
	print('timeout')
	pass # Replace with function body.
