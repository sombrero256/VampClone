extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.name == "JustAGuy":
		print("guy is near")
		$ColorRect.visible = true
	
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body.name == "JustAGuy":
		$ColorRect.visible = false
	pass # Replace with function body.
