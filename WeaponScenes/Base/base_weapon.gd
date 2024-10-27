class_name BaseWeapon extends CharacterBody2D

var stats_: WeaponStats

func create_weapon(weapon_stats):
	stats_ = weapon_stats
	scale *= stats_.area_
