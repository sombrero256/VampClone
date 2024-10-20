extends TileMapLayer

@export var scroll_speed = 32
@export var grass_spawn_freq = .33
@export var cracked_path_freq = .5

@export var next_scene: PackedScene
# 	get_tree().change_scene_to_packed(next_scene)
var start_pressed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FullScroll.stop()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += scroll_speed * delta
	pass

func _on_button_pressed() -> void:
	$SpawnTimer.stop()
	$FullScroll.start()
	scroll_speed = scroll_speed * 8
	var pattern = tile_set.get_pattern(0)
	set_pattern(Vector2i(0, -offset - pattern.get_size().y), pattern)
	
	pass # Replace with function body.

var offset = 2
# I would love to be able to rotate the generated tiles randomly in code as well
# but support for that isn't super easy and it looks good enough as is.
func _on_spawn_timer_timeout() -> void:
	for i in range(get_used_rect().size.x):
		
		if i in range(0, 17) or i in range(19, get_used_rect().size.x):
			# draw blank / grass
			if randf_range(0, 1) <= grass_spawn_freq:
				#randi_range is magic number, corresponds to ground texture atlas + all except plain black
				set_cell(Vector2(i, -offset), 0, Vector2(randi_range(0, 4), 0))
			else:
				#add plain black
				set_cell(Vector2(i, -offset), 0, Vector2(5, 0))
		else:
			# draw path
			if randf_range(0, 1) <= cracked_path_freq:
				# add cracked path
				set_cell(Vector2(i, -offset), 1, Vector2(6, 0))
			else:
				# add normal path
				set_cell(Vector2(i, -offset), 1, Vector2(7, 0))
			pass
			
	offset += 1
	pass # Replace with function body.


func _on_full_scroll_timeout() -> void:
	scroll_speed = 0
	get_tree().change_scene_to_packed(next_scene)
	pass # Replace with function body.
