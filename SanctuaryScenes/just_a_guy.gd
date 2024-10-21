extends CharacterBody2D

##Let's you move Just A Guy
func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 300
	move_and_slide()
