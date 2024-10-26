extends Control


@export_file("*.json") var dialogue_file

var dialogue = []
var current_dialogue_id = 0
var dialogue_active = false

func _ready():
	$ColorRect.visible = false

##Disables player movement and initializes all dialog box elements, then loads first line of dialogue
func start(speaker):
	if !dialogue_active:
		%JustAGuy.speed = 0
		dialogue_active = true
		$ColorRect.visible = true
		dialogue = load_dialogue(speaker)
		current_dialogue_id = -1
		next_script()
	
##Selects the dialogue file based on the npc speaker name and sets it to a string array for use with the dialog box
func load_dialogue(speaker_select):
	var file
	if speaker_select == "MrDog":
		print ("talking to dog")
		file = FileAccess.open("res://SanctuaryScenes/MrDog_dialogue.json", FileAccess.READ)
	elif speaker_select == "MrsCat":
		print ("talking to cat")
		file = FileAccess.open("res://SanctuaryScenes/MrsCat_dialogue.json", FileAccess.READ)
	else:
		file = FileAccess.open("res://SanctuaryScenes/default_dialogue.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
##Checks to see if there's an active dialogue box
##If no, ignores player input
##If yes allows the chat input to access the next line of dialogue
func _input(event: InputEvent):
	if !dialogue_active:
		return
	if event.is_action_pressed("chat"):
		next_script()

##Updates the dialogue array position, then checks to see if there's more dialogue to post
##If no, it hides the dialogue box and allows the player to move again
##If yes, it updates the text in the dialog box to the next line of dialogue
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		dialogue_active = false
		$ColorRect.visible = false
		%JustAGuy.speed = 300
		return
	else:
		$ColorRect/SpeakerName.text = dialogue[current_dialogue_id]['name']
		$ColorRect/Text.text = dialogue[current_dialogue_id]['text']
	
