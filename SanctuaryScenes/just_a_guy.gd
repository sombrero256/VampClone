extends CharacterBody2D

var speed = 300
@onready var sprite_: = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var dir = Vector2()
	var play_sprite = false
	move_and_slide()
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
	if Input.is_action_pressed("left"):
		dir.x -= 1
		sprite_.flip_h = true
		play_sprite = true
	if play_sprite:
		sprite_.play()
	else:
		sprite_.stop()
	# normalize direction
	dir = dir.normalized()
	
	velocity = dir * speed
	move_and_slide()

func show_space_prompt():
	$SpacePrompt.visible = true
	
func hide_space_prompt():
	$SpacePrompt.visible = false
