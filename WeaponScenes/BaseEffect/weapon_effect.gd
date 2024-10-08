extends Node2D

@onready var Area: Area2D = find_child("Area2D")
func _ready() -> void:
	pass
	

func fire() -> void:
	print(Area.get_overlapping_areas())
	pass
