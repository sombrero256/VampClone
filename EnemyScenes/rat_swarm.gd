extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")

var paths_: Array[Path2D]
var paths_follows_: Array[PathFollow2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	paths_.assign(find_children("*Path2D*", "Path2D", true))
	paths_follows_.assign(find_children("*PathFollow2D", "PathFollow2D", true))
	#for path in paths_:
		#path.rotate(deg_to_rad(45 * randi_range(0,3)))

func _process(delta: float) -> void:
	for pf in paths_follows_:
		pf.progress_ratio += delta * .05
