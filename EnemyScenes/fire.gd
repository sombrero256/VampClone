class_name Fire extends Node2D

const MAX_TICKS: int = 10
const DAMAGE: int = 20
@onready var anim = $AnimatedSprite2D
var ticks_ = 0
@onready var enemy_ = get_parent() as Enemy
@onready var timer_ = $FireTimer
# Called when the node enters the scene tree for the first time.
func Start() -> void:
	ticks_ = 0
	timer_.start(1)
	anim.modulate = Color.LIGHT_PINK
	anim.play()
	anim.visible = true

func Stop() -> void:
	ticks_ = 0
	timer_.stop()
	anim.visible = false

func _on_fire_timer_timeout() -> void:
	enemy_.process_hit(DAMAGE, Color.LIGHT_PINK)
	ticks_ += 1
	if ticks_ >= MAX_TICKS:
		Stop()
	await get_tree().create_timer(0.25).timeout
	enemy_.reset()
