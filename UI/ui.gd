extends Node2D

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const END_MIN = 7 * MINUTES_PER_HOUR # 7am
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY
const INGAME_SPEED = .84 # Normal speed .84

signal night_ends

@onready var night_end_ = %NightEnd
@onready var time_label_ = %TimeLabel
@onready var dial_ = %Dial

var time_:float = 0
var past_min_:float = -1.0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_ = 0 # MIDNIGHT
	
func set_time(hour: int, minute: int):
	time_label_.text = _amfm_hour(hour) + ":" + _minute(minute) + " " + _am_pm(hour)
	
func _amfm_hour(hour:int) -> String:
	if hour == 0:
		return str(12)
	if hour > 12:
		return str(hour - 12)
	return str(hour)

func _minute(minute:int) -> String:
	if minute < 10:
		return "0" + str(minute)
	return str(minute)

func _am_pm(hour:int) -> String:
	if hour < 12:
		return "am"
	else:
		return "pm"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_ += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	_recalculate_time()

func _recalculate_time() -> void:
	var total_min = int(time_ / INGAME_TO_REAL_MINUTE_DURATION)
	var cur_day_min = total_min % MINUTES_PER_DAY
	var hour = int(cur_day_min / MINUTES_PER_HOUR)
	var minute = int(cur_day_min % MINUTES_PER_HOUR)
	var rotate_amt = deg_to_rad(90.0/END_MIN)
	if past_min_ != minute:
		past_min_ = minute
		dial_.rotate(rotate_amt)
		set_time(hour, minute)
	if total_min >= END_MIN:
		night_end_.OnNightEnd()
