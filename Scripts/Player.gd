extends RigidBody2D

@onready var fsm = $StateMachine

const SPEED = 45.0
const RUN_VELOCITY = Vector2(60, 40)
const JUMP_VELOCITY = -400.0

const MAX_SPEED = 200
const ENGINE_FORCE = 400
const FRICTION_FORCE = 150
var friction_force = FRICTION_FORCE

var is_in_grass = false
@export var is_in_grass_velocity_scaler:float = 0.6

var is_flipped = false
var direction = Vector2.ZERO

var color_on_hand : Color

var original_sprite_colors = []

var previous_frame_position : Vector2 = Vector2.ZERO
var current_direction : Vector2 = Vector2.ZERO
var current_speed : float = 0.0
var average_speed : float = 0.0
var shader_accum_time : float = 0.0

var previous_speed_array : Array = [0.0, 0.0, 0.0, 0.0]
var previous_speed_array_loop_variable : int = 0

func _ready():
	$Ball.add_to_group("has_outline")
	$Ball.add_to_group("has_palette_swapper")
	$CollisionShape2D.add_to_group("is_collider")
	
	for i in range(8):
		var c = $Ball.material.get_shader_parameter("C" + str(i+1))
		if c != null:
			original_sprite_colors.append(c)
		else:
			original_sprite_colors.append(Color.BLACK)

func _physics_process(_delta):
	pass

func _integrate_forces(state):
	var input_direction = Input.get_vector("key_left", "key_right", "key_up", "key_down")

	var move_direction = input_direction.normalized() * Vector2(1.0, 1.0)
	if is_in_grass == true:
		friction_force = FRICTION_FORCE * (1/is_in_grass_velocity_scaler)
	else:
		friction_force = FRICTION_FORCE

	apply_force(move_direction*ENGINE_FORCE + current_direction.normalized()*-friction_force)	

	if state.linear_velocity.length() > MAX_SPEED:
		state.linear_velocity = state.linear_velocity.normalized()*MAX_SPEED

	var position_difference = global_position - previous_frame_position
	current_speed = position_difference.length()
	current_direction = position_difference.normalized()
	
	previous_speed_array_loop_variable += 1
	if previous_speed_array_loop_variable == previous_speed_array.size():
		previous_speed_array_loop_variable = 0
	
	previous_speed_array[previous_speed_array_loop_variable] = current_speed

	if linear_velocity.length() > 5:
		$SubViewport2/Sphere.rotate_z(-linear_velocity.x *  0.001)
		$SubViewport2/Sphere.rotate_x(linear_velocity.y *  0.001)


func _process(delta):
	var av_spd = 0
	for i in previous_speed_array.size():
		av_spd += previous_speed_array[i]
	av_spd = av_spd/previous_speed_array.size()

	previous_frame_position = global_position
	
	if shader_accum_time < 3600.0:
		shader_accum_time += delta
	else:
		shader_accum_time = 0.0

	pass

func handle_input():
	pass


func apply_behaviour():
	fsm.current_state = fsm.states.front()
	if fsm.current_state != null:
		if fsm.current_state.has_method("handle_input"):
			fsm.current_state.handle_input()
		if fsm.current_state.has_method("apply_behaviour"):
			fsm.current_state.apply_behaviour()
