class_name EndingControl extends Control

@onready var file = FileAccess.open("res://UI/ending_dialogue.json", FileAccess.READ)
@onready var credits_ = $"../../Credits"

var dialogue = []
var current_dialogue_id = -1
var dialogue_active = false

func _ready():
	$ColorRect.visible = false
	#start()

func start():
	if !dialogue_active:
		dialogue_active = true
		$ColorRect.visible = true
		dialogue = load_dialogue()
		next_script()
	
##Selects the dialogue file based on the npc speaker name and sets it to a string array for use with the dialog box
##Also loads relevant audio file for speaker
func load_dialogue():
	var content = JSON.parse_string(file.get_as_text())
	print(content)
	return content

###Simple function to load correct sound fx and play it
#func load_audio(sfx):
	#%ChatSound.stream = load(sfx)
	#%ChatSound.play()
	
##Checks to see if there's an active dialogue box
##If no, ignores player input
##If yes allows the chat input to access the next line of dialogue
func _input(event: InputEvent):
	if event.is_action_pressed("chat"):
		next_script()

##Updates the dialogue array position, then checks to see if there's more dialogue to post
##If no, it hides the dialogue box and allows the player to move again
##If yes, it updates the text in the dialog box to the next line of dialogue
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		credits_.visible=true
		get_parent().queue_free()
	else:
		$ColorRect/SpeakerName.text = dialogue[current_dialogue_id]['name']
		$ColorRect/Text.text = dialogue[current_dialogue_id]['text']
