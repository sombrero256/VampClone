extends AudioStreamPlayer2D

var fade_out = false
@export var fade_speed = .01
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fade_out:
		attenuation += fade_speed
	pass


func _on_texture_button_pressed() -> void:
	fade_out = true
	pass # Replace with function body.
