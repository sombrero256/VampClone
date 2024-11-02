class_name WeaponTimer extends Timer

@export var base_wait_: float
const WeaponType = preload("res://WeaponScenes/Base/base_weapon.gd").WeaponType

@export var type_: WeaponType
var resource_: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wait_time = base_wait_

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wait_time = base_wait_ / Globalstats.GetWeaponStats(type_).speed_

func create_weapon() -> Node2D:
	var w_inst = resource_.instantiate() as BaseWeapon
	w_inst.global_position = get_parent().global_position
	get_node("/root/Base").add_child(w_inst)
	return w_inst
