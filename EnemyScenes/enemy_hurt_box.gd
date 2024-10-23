extends Area2D

var touching_player = false
var player = null
@onready var stats = get_parent().find_child("EnemyStats") as EnemyStats

signal deal_damage_to_player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") as Player
	deal_damage_to_player.connect(player._on_dealt_damage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if touching_player:
		# damage
		deal_damage_to_player.emit(stats.DPS * delta)

	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		touching_player = true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		touching_player = false
	pass # Replace with function body.
