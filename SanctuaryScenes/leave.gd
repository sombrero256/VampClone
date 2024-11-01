extends Area2D

var player_in = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("chat")  && player_in == true:
		get_tree().change_scene_to_file("res://Test.tscn")
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
