extends CharacterBody2D

var player_chatting = false

func _process(delta):	
	##Chatting works baby!  Turning player_chatting to false is so chat doesn't loop endlessly
	if Input.is_action_just_pressed("chat")  && player_chatting == true:
		print("chatting is working with")
		print(self.name)
		player_chatting = false
		$Dialogue.start(self.name)
		##$StatUpgrade.start(self.name) disabled until working

##Player enters chat zone with an npc
func _on_chat_zone_body_entered(body):
	if body.name == "JustAGuy":
		body.show_space_prompt()
		print("guy is near")
		player_chatting = true

##Player leaves chat zone with an npc
func _on_chat_zone_body_exited(body):
	if body.name == "JustAGuy":
		body.hide_space_prompt()
		print("guy left")
		player_chatting = false
