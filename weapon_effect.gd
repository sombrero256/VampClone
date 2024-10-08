class_name WeaponEffect extends Node2D
# to create a new effect for a weapon all that should need to be done is extending
# this class and overriding the fire() function
# i.e. class_name Heart_Beam extends WeaponEffect
# 		func fire()->void:
#			weapon logic here

# then we can add it the the cooldown of the weapon that we are adding, and it should
# get called every time the cooldown expires. We can speed up the cooldown in Weapon stats

func fire() -> void:
	print('firing')
	pass
