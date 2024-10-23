class_name Enemy extends CharacterBody2D

@export var sprite: AnimatedSprite2D
@export var stats: EnemyStats
@export var health: ProgressBar

@onready var death_particle = preload("res://EnemyScenes/DeathParticle/EnemyDeathParticle.tscn")

# Eventually this returns rewards if killed
func process_hit(damages) -> void:
	health.value -= damages
	sprite.modulate = Color("a356ff")
	if health.value == 0:
		var _inst = death_particle.instantiate() as Node2D
		_inst.global_position = position
		get_node("/root").add_child(_inst)
		queue_free()

func reset() -> void:
	sprite.modulate = Color(1, 1, 1, 1)

func _ready() -> void:
	health.max_value = stats.Max_Health
	health.value = stats.Max_Health
