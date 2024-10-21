extends ColorRect

var stats: PlayerStats
@onready var starting_size = size.x
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_tree().get_first_node_in_group('Player')
	stats = player.find_child('Stats')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	size.x = starting_size * (stats.Cur_Health / stats.Max_Health) 
	pass
