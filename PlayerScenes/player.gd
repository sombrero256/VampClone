class_name Player extends CharacterBody2D

@onready var stats = $Stats as PlayerStats
const BASE_SPEED = 3
const BASE_HEALTH = 100
const BASE_DMG_BOOST = 0
const BASE_MONEY = 0

var cur_speed
var cur_dmg_boost
var curr_health

enum Direction {LEFT, RIGHT}
var direction_: Direction

func get_direction() -> Direction:
	return direction_	

func _physics_process(delta: float) -> void:
	var dir = Vector2()
	if Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("up"):
		dir.y -= 1
	if Input.is_action_pressed("right"):
		dir.x += 1
		direction_ = Direction.RIGHT
	if Input.is_action_pressed("left"):
		direction_ = Direction.LEFT
		dir.x -= 1
	# normalize direction
	dir = dir.normalized()
	
	velocity = dir * 100
	move_and_slide()

func _process(delta: float) -> void:
	pass

func _on_dealt_damage(dmg):
	stats.Cur_Health = stats.Cur_Health - dmg
	if stats.Cur_Health <= 0: 
		print('death')
	pass
