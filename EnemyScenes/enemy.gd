class_name Enemy extends CharacterBody2D

const ELITE_CHANCE:float = 0.03
enum EnemyType {RAT, CAT, DOG, HORSE, BOSS}

@export var type_: EnemyType
@export var sprite_: AnimatedSprite2D
@export var stats_: EnemyStats
@export var health_: ProgressBar
@export var status_: RichTextLabel

@export var Fire: Fire

@onready var death_particle = preload("res://EnemyScenes/DeathParticle/EnemyDeathParticle.tscn")
var frozen_: bool = false
var is_elite_: bool = false 
const CRIT_AMOUNT = 50

func _ready() -> void:
	# Determine if they are an elite
	if type_ != EnemyType.BOSS and randf() <= ELITE_CHANCE * Globalstats.night:
		is_elite_ = true
		scale *= 1.5
		stats_.Max_Health *= 3
		stats_.DPS *= 2

	health_.max_value = stats_.Max_Health
	health_.value = stats_.Max_Health

# Eventually this returns rewards if killed
func process_hit(damages, color: Color = Color("a356ff")) -> void:
	health_.value -= damages
	sprite_.modulate = color
	sprite_.frame = 1
	if health_.value == 0:
		var _inst = death_particle.instantiate() as Node2D
		_inst.global_position = position
		get_node("/root").add_child(_inst)
		# Elites are worth more!
		var saved_amt = 5 if is_elite_ else 1
		Globalstats.SavedEnemy(type_, saved_amt)
		queue_free()

func reset() -> void:
	if frozen_:
		return
	sprite_.frame = 0
	sprite_.modulate = Color(1, 1, 1, 1)
	status_.text = ""
	
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
