extends CharacterBody2D

const MAX_HEALTH = 300
@onready var rect = get_node("ColorRect") as ColorRect
@onready var health = get_node("ProgressBar") as ProgressBar
@onready var death_particle = preload("res://EnemyScenes/DeathParticle/EnemyDeathParticle.tscn")

# Eventually this returns rewards if killed
func process_hit(damages) -> void:
	health.value -= damages
	rect.color = "a356ff"
	if health.value == 0:
		var _inst = death_particle.instantiate() as Node2D
		_inst.global_position = position
		get_node("/root").add_child(_inst)
		queue_free()

func reset() -> void:
	rect.color = "fc0000"

func _ready() -> void:
	health.max_value = 300
	health.value = 300
