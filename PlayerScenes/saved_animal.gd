extends Control

const EnemyType = preload("res://EnemyScenes/enemy.gd").EnemyType

@export var animal_type: EnemyType
@export var animal_texture: Texture2D

@onready var label_: = $Label
@onready var sprite_: = $Sprite2D

var amt_saved_ = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_.texture = animal_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	amt_saved_ = Globalstats.GetSavedEnemies()[animal_type]
	label_.text = "%d Saved" % amt_saved_
