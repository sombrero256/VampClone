extends Control

var new_game_: PackedScene

func _ready() -> void:
	print("Stats reset!")
	new_game_ = load("res://Test.tscn")
	Globalstats.ResetGlobalState()

func _on_try_again_pressed() -> void:
	print("try again pressed")
	get_tree().change_scene_to_packed(new_game_)
