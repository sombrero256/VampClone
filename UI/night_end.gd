extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_tree().paused = false
	pass # Replace with function body.

func OnNightEnd() -> void:
	get_tree().paused = true
	visible = true


func _on_go_to_sanctuary_pressed() -> void:
	print("pressed")
	get_tree().paused = false
	visible = false
	# TEMPORARY, REPLACE WITH SCENE TRANSITION
	get_tree().reload_current_scene()
