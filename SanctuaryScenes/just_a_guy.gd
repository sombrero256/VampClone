extends CharacterBody2D

var speed = 300

##Let's you move Just A Guy
func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()

func show_space_prompt():
	$SpacePrompt.visible = true
	
func hide_space_prompt():
	$SpacePrompt.visible = false
