extends Node2D

const stage_music_1_ = preload("res://Music/stage theme 1.wav")
const stage_music_2_ = preload("res://Music/stage theme 2.wav")
const boss_music_ = preload("res://Music/boss theme.wav")
const final_boss_music_ = preload("res://Music/boss reprise.wav")

const EnemyType = preload("res://EnemyScenes/enemy.gd").EnemyType
const Modifier = preload("res://WeaponScenes/Base/weapon_stats_component.gd").Modifier
const WeaponType = preload("res://WeaponScenes/Base/base_weapon.gd").WeaponType

@export var enabled_: bool = true
# Timer speeds up by this amount each hour
@export var speed_up_rate_: float = .95

var audio_player_ 
@onready var player_ = get_tree().get_first_node_in_group("Player")
@onready var dog_enemy_ = preload("res://EnemyScenes/dog_enemy.tscn")
@onready var cat_enemy_ = preload("res://EnemyScenes/cat_enemy.tscn")
@onready var rat_swarm_ = preload("res://EnemyScenes/rat_swarm.tscn")
@onready var horse_enemy_ = preload("res://EnemyScenes/horse_enemy.tscn")
@onready var boss_one_ = preload("res://EnemyScenes/Boss/boss.tscn")
@onready var final_boss_ = preload("res://EnemyScenes/Boss/finalboss.tscn")

var prev_hour_: int = 0
var boss_summoned_: bool
var wave_: Dictionary
@onready var EnemySpawner = get_node("%EnemySpawner") as Timer
var weapons_: Array[WeaponType]
var enemyWaves_: EnemyWaves

func _ready() -> void:
	audio_player_ = $Player/AudioPlayer as AudioStreamPlayer
	enemyWaves_ = EnemyWaves.new()
	boss_summoned_ = false
	wave_ = enemyWaves_.get_enemy_wave(prev_hour_)
	if Globalstats.IsBossNight():
		if Globalstats.night == 6:
			audio_player_.stream = final_boss_music_
		else:
			audio_player_.stream = boss_music_
	else:
		audio_player_.stream = [stage_music_1_, stage_music_2_].pick_random()
	audio_player_.play()

func _process(delta: float) -> void:
	if not audio_player_.playing:
		print("Audio player finished")
		audio_player_.play()

##Creates new enemy object along the MonsterSpawnPath outside the camera position
##If we make new enemy types, we'll have to duplicate this for each type, or randomize it
func spawn_enemy(type, amount: int):
	if not enabled_:
		return
	var new_enemy: Node
	for i in amount:
		if type == EnemyType.DOG:
			new_enemy = dog_enemy_.instantiate()
		elif type == EnemyType.CAT:
			new_enemy = cat_enemy_.instantiate()
		elif type == EnemyType.RAT:
			new_enemy = rat_swarm_.instantiate()
		elif type == EnemyType.HORSE:
			new_enemy = horse_enemy_.instantiate()
		elif type == EnemyType.BOSS:
			if Globalstats.night == 6:
				new_enemy = final_boss_.instantiate()
			else:
				new_enemy = boss_one_.instantiate()
		%MonsterSpawnPath.progress_ratio = randf()
		new_enemy.global_position = %MonsterSpawnPath.global_position
		add_child(new_enemy)

func _increaseSpawnRate(hour: int, minute: int) -> void:
	if hour != prev_hour_:
		prev_hour_ = hour
		EnemySpawner.wait_time *= speed_up_rate_
		wave_ = enemyWaves_.get_enemy_wave(prev_hour_)

##Spawns enemies on timer.  Can adjust how many enemies.  Might be best to change to a loop at some point.
func _on_timer_timeout():
	if Globalstats.IsBossNight():
		if not boss_summoned_:
			Globalstats.need_to_defeat_boss = true
			boss_summoned_ = true
			spawn_enemy(EnemyType.BOSS, 1)
	else:
		for type in wave_:
			spawn_enemy(type, wave_[type])

func _on_ui_time_changed(hour: int, minute: int) -> void:
	_increaseSpawnRate(hour, minute)
