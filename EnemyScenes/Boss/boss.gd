extends Enemy

const MAX_BULLETS = 50

enum State {CHARGE, BOMBS, GUN, WALKIN}

enum Phase {ONE, TWO}

@onready var bullet_ = preload("res://EnemyScenes/Boss/boss_bullet.tscn")
@onready var player_ = get_tree().get_first_node_in_group("Player")
@onready var charge_ani_ = $ChargeUp

var _remove_me_possible_states = [State.CHARGE, State.GUN, State.WALKIN]

var bullet_count_: int
var state_: State
var dest_: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	state_ = State.GUN
	_reset_and_get_new_state()

func _reset_and_get_new_state() -> void:
	charge_ani_.play("RESET")
	dest_ = Vector2.ZERO
	velocity = Vector2.ZERO
	bullet_count_ = -1
	if state_ != State.WALKIN:
		state_ = State.WALKIN
	else:
		state_ = _remove_me_possible_states.pick_random()
	# Give a little time for a breather
	await get_tree().create_timer(0.5).timeout

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
		charge_ani_.play("Charge")
	if charge_ani_.is_playing(): return
	sprite_.play("Charge")
	velocity = position.direction_to(dest_) * 400
	move_and_slide()
	if Globalstats.CloseEnough(position, dest_):
		await _reset_and_get_new_state()

func _gun() -> void:
	if bullet_count_ == -1:
		charge_ani_.play("Gun")
		bullet_count_ = 0
	if Engine.get_process_frames() % 5 == 0:
		if bullet_count_ == MAX_BULLETS:
			await _reset_and_get_new_state()
		else:
			var w_inst = bullet_.instantiate() as BossBullet
			w_inst.global_position = position
			w_inst.set_start_offset(10 * bullet_count_)
			bullet_count_ += 1
			get_node("/root").add_child(w_inst)

func _physics_process(delta: float) -> void:
	if frozen_: return
	if charge_ani_.is_playing(): return
	if state_ == State.WALKIN:
		sprite_.play("Walking")
		if dest_ == Vector2.ZERO:
			dest_ = _get_walk_dest()
		velocity = position.direction_to(dest_) * stats_.Speed
		move_and_slide()
		if Globalstats.CloseEnough(position, dest_):
			await _reset_and_get_new_state()
	elif state_ == State.CHARGE:
		_charge()
	elif state_ == State.GUN:
		_gun()
		
