extends CharacterBody2D

const MAX_HEALTH = 300
@onready var rect = get_node("ColorRect") as ColorRect
@onready var health = get_node("ProgressBar") as ProgressBar

# Eventually this returns rewards if killed
func process_hit(damages) -> void:
	health.value -= damages
	rect.color = "a356ff"
	if health.value == 0:
		queue_free()
	#print(health)

func reset() -> void:
	rect.color = "fc0000"

func _ready() -> void:
	health.max_value = 300
	health.value = 300
