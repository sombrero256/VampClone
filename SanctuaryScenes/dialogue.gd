extends Control


@export_file("*.json") var dialogue_file

var dialogue = []
var current_dialogue_id = -1
var dialogue_active = false

func _ready():
	$ColorRect.visible = false

func start():
	if dialogue_active:
		return
	dialogue_active = true
	$ColorRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	
func load_dialogue():
	var file = FileAccess.open("res://SanctuaryScenes/Dialogue/Shopkeeper1_dialogue.json", FileAccess.READ)
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
		
	$ColorRect/Name.text = dialogue[current_dialogue_id]['name']
	$ColorRect/Text.text = dialogue[current_dialogue_id]['text']
	
