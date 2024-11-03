class_name EnemyWaves extends Node

const EnemyType = preload("res://EnemyScenes/enemy.gd").EnemyType
# how much to adjust each hour
const hour_adjust_val: Array = [0, 0, 1, 1, 2, 2, 3]
# how much to adjust each night
const night_adjust_val: Array = [0, 1, 2, 1, 4, 7, 10, 5]

var waves_: Array
var boss_summoned_: bool

func _init() -> void:
	boss_summoned_ = false
	# Normal 1
	_create_wave(3, 2, 2, 0)
	# Normal 2
	_create_wave(2, 3, 2, 0)
	# Normal 3
	_create_wave(4, 2, 1, 1)
	# Normal 4
	_create_wave(1, 2, 1, 1)
	# Normal 5
	_create_wave(1, 2, 2, 1)
	# DOGS DOGS DOGS
	_create_wave(6, 0, 0, 0)
	# A smattering of rats
	_create_wave(0, 0, 3, 0)
	# Cats and rats for days
	_create_wave(0, 2, 2, 0)
	if Globalstats.night >= 2:
		# Horse of course
		_create_wave(0, 0, 0, 4)
	waves_.make_read_only()

func _create_wave(
	dog_amt:int,
	cat_amt:int,
	rat_amt: int,
	horse_amt:int) -> void:
	waves_.append({
		EnemyType.DOG: dog_amt,
		EnemyType.CAT: cat_amt,
		EnemyType.RAT: rat_amt,
		EnemyType.HORSE : horse_amt
	})

func get_enemy_wave(hour: int) -> Dictionary:
	var wave: Dictionary = waves_[randi_range(0, len(waves_) - 1)].duplicate()
	for type in wave.keys():
		if wave[type] != 0 and hour < 7:
			# Horses are elites and should spawn rarely
			if type != EnemyType.HORSE:
				wave[type] += hour_adjust_val[hour]
			wave[type] += night_adjust_val[Globalstats.night]
	return wave
	
	
