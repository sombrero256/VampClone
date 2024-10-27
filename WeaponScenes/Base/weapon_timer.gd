class_name WeaponTimer extends Timer

var resource_: Resource
var base_stats_: WeaponStats

func lvl_up(dmg_up: float, speed_up: float, area_up: float, modifiers: Array):
	base_stats_.damage_ *= dmg_up
	base_stats_.speed_ *= speed_up
	base_stats_.area_ *= area_up
	base_stats_.modifiers_ += modifiers

func create_weapon() -> Node2D:
	var w_inst = resource_.instantiate() as BaseWeapon
	w_inst.create_weapon(base_stats_)
	w_inst.global_position = get_parent().global_position
	get_node("/root").add_child(w_inst)
	return w_inst
