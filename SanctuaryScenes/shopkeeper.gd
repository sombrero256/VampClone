extends CharacterBody2D

var player_chatting = false

func _ready():	
	##tried to make chatting work and I can't.  Tutorial for it was bad.
	if Input.is_action_just_pressed("chat")  && player_chatting == true:
		print("chatting is working")
		$Dialogue/Dialogue.start()


func _on_chat_zone_body_entered(body):
		print("guy is near")
		player_chatting = true


func _on_chat_zone_body_exited(body):
		print("guy left")
		player_chatting = false
