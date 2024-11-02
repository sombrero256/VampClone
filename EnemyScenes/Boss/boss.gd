extends Enemy

const MAX_BULLETS = 75
const MAX_CONSEC_CHARGES = 2
const PHASE_TWO_RATIO = .4

enum State {CHARGE, GUN1, GUN2, WALKIN}

enum Phase {ONE, TWO}

@onready var bullet_ = preload("res://EnemyScenes/Boss/boss_bullet.tscn")
@onready var player_ = get_tree().get_first_node_in_group("Player")
@onready var charge_ani_ = $ChargeUp

var charge_ani_started_:bool = false
var consec_charge_count: int
var bullet_count_: int
var state_: State
var phase_: Phase
var dest_: Vector2
var leveled_up_: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	phase_ = Phase.ONE
	_reset_with_state(State.WALKIN)

func _pick_random_next_state() -> State:
	var new_state = state_
	while state_ == new_state:
		new_state = State.values().pick_random()
	return new_state

func _reset_with_state(new_state: State) -> void:
# force_state is of type Nullablle<State>
	charge_ani_.play("RESET")
	dest_ = Vector2.ZERO
	velocity = Vector2.ZERO
	charge_ani_started_ = false
	bullet_count_ = 0
	state_ = new_state
	# Give a little time for a breather
	await get_tree().create_timer(0.5).timeout

func _reset_with_random_state() -> void:
	_reset_with_state(_pick_random_next_state())

func _get_walk_dest() -> Vector2:
	var choose = randi_range(0,2)
	if choose == 0:
		# Walk towards the player
		return player_.position
	elif choose == 1:
		# Walk along the x axis to the player
		return Vector2(player_.position.x, position.y)
	else:
		# Walk along the y axis to the player
		return Vector2(position.x, player_.position.y)

func _walk_towards(speed: int) -> void:
	velocity = position.direction_to(dest_) * speed
	move_and_slide()

func _play_charge_ani(ani_name: String) -> void:
	if not charge_ani_started_:
		charge_ani_started_ = true
		charge_ani_.play(ani_name)

func _charge() -> void:
	if dest_ == Vector2.ZERO:
		# Aim for a little past the opponent to increase chance of hit.
		var x_over = 30
		var y_over = 30
		if position.x >= player_.position.x:
			x_over *= -1
		if position.y >= player_.position.y:
			y_over *= -1
		dest_ = Vector2(
			player_.position.x + x_over,
			player_.position.y + y_over)
		_play_charge_ani("Charge")
	if charge_ani_.is_playing(): return
	sprite_.play("Charge")
	_walk_towards(500)
	if Globalstats.CloseEnough(position, dest_):
		if phase_ == Phase.TWO \
		&& consec_charge_count < MAX_CONSEC_CHARGES:
			consec_charge_count += 1
			await _reset_with_state(State.CHARGE)
		else:
			consec_charge_count = 0
			await _reset_with_random_state()

func _gun() -> void:
	if state_ == State.GUN1 or phase_ == Phase.TWO:
		_play_charge_ani("Gun")
	else: # Gun2
		_play_charge_ani("Gun2")
	if Engine.get_process_frames() % 8 == 0:
		if bullet_count_ == MAX_BULLETS:
			await _reset_with_random_state()
		else:
			if state_ == State.GUN1 or phase_ == Phase.TWO:
				var w_inst = bullet_.instantiate() as BossBullet
				w_inst.global_position = position
				w_inst.set_start_offset(10 * bullet_count_)
				get_node("/root/Base").add_child(w_inst)
			if state_ ==  State.GUN2 or phase_ == Phase.TWO:
				var w_inst = bullet_.instantiate() as BossBullet
				w_inst.global_position = position
				var target = player_.position
				# Calculating launch angle
				var hypotenuse = position.distance_to(player_.position)
				# No divide by zeros in this house!
				if hypotenuse == 0:
					hypotenuse = 1
				# TODO: Add some wiggle
				var adjacent = abs(position.x - player_.position.x)
				var angle = rad_to_deg(acos(adjacent/hypotenuse) + randf_range(0.0,0.5))
				if position.x > player_.position.x:
					angle = 180 - angle
				if position.y > player_.position.y:
					angle = 360 - angle
				w_inst.set_start_offset(angle)
				get_node("/root").add_child(w_inst)
			bullet_count_ += 1
			dest_ = player_.position
			_walk_towards(stats_.Speed)


func _physics_process(delta: float) -> void:
	if frozen_: return
	if charge_ani_.is_playing(): return
	if (phase_ == Phase.ONE && \
		health_.value/float(health_.max_value) < PHASE_TWO_RATIO):
		phase_ = Phase.TWO
		charge_ani_.play("Phase_Two")
	#if phase_ == Phase.TWO && not leveled_up_:
		#stats_.Speed += 30
		#scale *= 1.2
		#leveled_up_ = true
	elif state_ == State.WALKIN:
		sprite_.play("Walking")
		if dest_ == Vector2.ZERO:
			dest_ = _get_walk_dest()
		_walk_towards(stats_.Speed)
		if Globalstats.CloseEnough(position, dest_):
			await _reset_with_random_state()
	elif state_ == State.CHARGE:
		_charge()
	elif state_ == State.GUN1 || state_== State.GUN2:
		_gun()
		
