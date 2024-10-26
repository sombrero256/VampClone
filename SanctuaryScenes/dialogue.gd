extends Control


@export_file("*.json") var dialogue_file

var dialogue = []
var current_dialogue_id = 0
var dialogue_active = false

func _ready():
	$ColorRect.visible = false

func start(speaker):
	if !dialogue_active:
		dialogue_active = true
		$ColorRect.visible = true
		dialogue = load_dialogue(speaker)
		current_dialogue_id = -1
		next_script()
	
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
	
func _input(event: InputEvent):
	if !dialogue_active:
		return
	if event.is_action_pressed("chat"):
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		dialogue_active = false
		$ColorRect.visible = false
		return
	else:
		$ColorRect/SpeakerName.text = dialogue[current_dialogue_id]['name']
		$ColorRect/Text.text = dialogue[current_dialogue_id]['text']
	
