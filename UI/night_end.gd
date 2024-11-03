extends Panel

const WeaponType = preload("res://WeaponScenes/Base/base_weapon.gd").WeaponType
const Modifier = preload("res://WeaponScenes/Base/weapon_stats_component.gd").Modifier

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_tree().paused = false
	pass # Replace with function body.

func OnNightEnd() -> void:
	var saved = Globalstats.GetSavedEnemies()
	get_tree().paused = true
	if Globalstats.night == 7:
		# TODO replace with Good ending!
		pass
	Globalstats.night += 1

	print("REMOVE ME! POWERING UP EXAMPLE")
	##var player_stats = Globalstats.player_stats
	##player_stats.heal(25)
	##player_stats.speed_up(15)
	##for type in WeaponType.values():
		# This levels up damage, speed, and AOE by 10%
		# while also adding or increasing modifier chance
	##	Globalstats.GetWeaponStats(type).lvl_up(1.10, 1.10, 1.10, 
	##	[Modifier.FIRE, Modifier.ICE, Modifier.CRIT])
			
	visible = true


func _on_go_to_sanctuary_pressed() -> void:
	print("pressed")
	get_tree().paused = false
	visible = false
	# TEMPORARY, REPLACE WITH SCENE TRANSITION
	get_tree().change_scene_to_file("res://SanctuaryScenes/Sanctuary.tscn")
