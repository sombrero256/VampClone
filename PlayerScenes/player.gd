class_name Player extends CharacterBody2D

enum Direction {LEFT, RIGHT}
var direction_: Direction
@onready var sprite_: = $AnimatedSprite2D

func stats() -> PlayerStats:
	return Globalstats.player_stats

func get_direction() -> Direction:
	return direction_	

func _physics_process(delta: float) -> void:
	var dir = Vector2()
	var play_sprite = false
	if Input.is_action_pressed("down"):
		dir.y += 1
		play_sprite = true
	if Input.is_action_pressed("up"):
		dir.y -= 1
		play_sprite = true
	if Input.is_action_pressed("right"):
		dir.x += 1
		sprite_.flip_h = false
		play_sprite = true
		direction_ = Direction.RIGHT
	if Input.is_action_pressed("left"):
		dir.x -= 1
		sprite_.flip_h = true
		play_sprite = true
		direction_ = Direction.LEFT
	if play_sprite:
		sprite_.play()
	else:
		sprite_.stop()
	# normalize direction
	dir = dir.normalized()
	
	velocity = dir * stats().Speed
	move_and_slide()

func _process(delta: float) -> void:
	pass

func _on_dealt_damage(dmg):
	stats().Cur_Health = stats().Cur_Health - dmg
	if stats().Cur_Health <= 0: 
		print('death')
	pass
