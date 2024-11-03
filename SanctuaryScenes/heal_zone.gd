extends Area2D

var player_in = false
@export var cost: int
@export var animal: Enemy.EnemyType
@export var heal_amt: int
@export var heal_cost_scale: float
@export var heal_base_cost: int
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("chat") and player_in:
		if Globalstats.player_stats.Cur_Health != Globalstats.player_stats.Max_Health:
			if subtract_upgrade_cost(Globalstats.times_healed, heal_cost_scale, heal_base_cost, animal):
				Globalstats.player_stats.heal(heal_amt)
				Globalstats.times_healed += 1
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "JustAGuy":
		player_in = true
		body.show_space_prompt()
	pass # Replace with function body.

func _on_body_exited(body: Node2D) -> void:
	if body.name == "JustAGuy":
		player_in = false
		body.hide_space_prompt()

	pass # Replace with function body.

func subtract_upgrade_cost(levels: int, scale_factor: float, base_cost: int, animal_used: Enemy.EnemyType) -> bool:
	if Globalstats.GetSavedEnemies()[animal_used] >= int(base_cost + (levels * scale_factor)):
		Globalstats._enemy_saved[animal_used] -= int(base_cost + (levels * scale_factor))
		return true
	return false
