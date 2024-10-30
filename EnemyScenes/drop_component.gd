extends Node2D

@export var drop_chance = .1
@export var drop: PackedScene

func on_drop() -> void:
	if randf_range(0, 1) <= drop_chance:
		var _inst = drop.instantiate() as Node2D
		_inst.global_position = position
		get_node("%Player").add_sibling(_inst)
