class_name Player extends CharacterBody2D

@onready var stats = $Stats as PlayerStats
const BASE_SPEED = 3
const BASE_HEALTH = 100
const BASE_DMG_BOOST = 0
const BASE_MONEY = 0

var cur_speed
var cur_dmg_boost
var curr_health

func _process(delta: float) -> void:
	pass

func _on_dealt_damage(dmg):
	stats.Cur_Health = stats.Cur_Health - dmg
	if stats.Cur_Health <= 0: 
		print('death')
	pass
