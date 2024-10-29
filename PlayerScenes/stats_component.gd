class_name PlayerStats extends Node2D

@export
var Speed:float = 100.0
@export
var Max_Health:float = 100.0
var Cur_Health:float = Max_Health

func speed_up(speed_up_amt: float) -> void:
	Speed += speed_up_amt

func health_up(health_up_amt: float) -> void:
	Max_Health += health_up_amt

func heal(heal_amt: float) -> void:
	Cur_Health = min(Cur_Health + heal_amt, Max_Health)
