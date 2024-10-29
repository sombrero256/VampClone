class_name BaseWeapon extends CharacterBody2D

enum WeaponType {HEART, BOOMERANG, BUBBLE}

@export var type_: WeaponType

func stats() -> WeaponStats:
	return Globalstats.GetWeaponStats(type_)

func _ready() -> void:
	scale *= stats().area_
