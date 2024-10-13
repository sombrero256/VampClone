class_name Player extends CharacterBody2D

@onready var stats = $Stats as PlayerStats

func _on_dealt_damage(dmg):
	stats.Cur_Health = stats.Cur_Health - dmg
	if stats.Cur_Health <= 0: 
		print('death')
	pass
