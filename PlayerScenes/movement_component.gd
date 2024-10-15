extends Node2D

var parent: Node2D
var player_stats: PlayerStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	if parent.has_node('Stats'):
		player_stats = parent.find_child('Stats')
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var dir = Vector2()
	if Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("up"):
		dir.y -= 1
	if Input.is_action_pressed("right"):
		dir.x += 1
	if Input.is_action_pressed("left"):
		dir.x -= 1
	# normalize direction
	dir = dir.normalized()
	
	if parent is CharacterBody2D:
		parent.velocity = dir * player_stats.Speed
		parent.move_and_slide()
