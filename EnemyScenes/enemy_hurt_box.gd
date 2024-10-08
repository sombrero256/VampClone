extends Area2D

var touching_player = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if touching_player:
		# damage
		print('touching')
	else: 
		print('not touching')
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		touching_player = true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		touching_player = false
	pass # Replace with function body.
