class_name Enemy extends CharacterBody2D

@export var sprite_: AnimatedSprite2D
@export var stats_: EnemyStats
@export var health_: ProgressBar
@export var status_: RichTextLabel

@export var Fire: Fire

@onready var death_particle = preload("res://EnemyScenes/DeathParticle/EnemyDeathParticle.tscn")
var frozen_: bool = false
const CRIT_AMOUNT = 50

# Eventually this returns rewards if killed
func process_hit(damages, color: Color = Color("a356ff")) -> void:
	health_.value -= damages
	sprite_.modulate = color
	if health_.value == 0:
		var _inst = death_particle.instantiate() as Node2D
		_inst.global_position = position
		get_node("/root").add_child(_inst)
		queue_free()

func reset() -> void:
	if frozen_:
		return
	sprite_.modulate = Color(1, 1, 1, 1)
	status_.text = ""

func _ready() -> void:
	health_.max_value = stats_.Max_Health
	health_.value = stats_.Max_Health
	
func SetOnFire() -> void:
	Fire.Start()

func Freeze() -> void:
	var original_speed = stats_.Speed
	sprite_.modulate = Color.DEEP_SKY_BLUE
	frozen_ = true 
	await get_tree().create_timer(2).timeout
	frozen_ = false
	stats_.Speed = original_speed
	reset()

func Crit() -> void:
	process_hit(CRIT_AMOUNT, Color.GOLD)
	status_.text = "CRIT!"
	await get_tree().create_timer(1).timeout
	reset()
