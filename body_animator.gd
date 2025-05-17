extends Node2D
class_name BodyAnimator

@export var floor : Node2D
@export var body : SpringyScale
@export var arm_l : SpringyRotate
@export var arm_r : SpringyRotate
@export var legs : Node2D
@export var head : SpringyScale

static var instance : BodyAnimator

var leg_to_floor : Vector2
func _ready() -> void:
	instance = self
	leg_to_floor = floor.global_position - legs.global_position
	arm_target_neutral()
	blink_loop()
	pass


@onready var l_eye: Eye = $Head/IdleHeadMotion/LEye
@onready var r_eye: Eye = $Head/IdleHeadMotion/REye

var tiredness : float = 0.0

func blink_loop():
	while true:
		await get_tree().create_timer(randf_range(3.0, 7.0)).timeout
		var left = randf() > 0.5
		if left:
			l_eye.blinking = true
		else:
			r_eye.blinking = true
		await get_tree().create_timer(randf_range(0.05, 0.2) * tiredness).timeout
		if not left:
			l_eye.blinking = true
		else:
			r_eye.blinking = true
		
		await get_tree().create_timer(0.15).timeout
		l_eye.blinking = false
		r_eye.blinking = false
	pass

var time : float = 0.0

var breathing : float = 0.0
var breathing_speed = 0.2

var leg_bop : float = 0.0
var leg_spd : float = 0.0

@onready var l_arm: WobblyLine = $LArm/IdleArmWiggle/LArm
@onready var r_arm: WobblyLine = $RArm/IdleArmWiggle/RArm
@onready var body_start_pos : Vector2 = body.global_position

@export var shivering = false
@onready var start_pos : Vector2 = global_position
@onready var body_wiggle: WobblyLine = $"Shirt-Body/BodyWiggle"
@onready var teeth_chatter: AudioStreamPlayer2D = $Head/TeethChatter

func _process(delta: float) -> void:
	var shiver_offset = Vector2.ZERO
	if shivering:
		shiver_offset = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) 
		shiver_offset *= 2.0
	
	global_position = start_pos + shiver_offset
	time += delta
	
	teeth_chatter.volume_linear = lerp(teeth_chatter.volume_linear, 1.0 if shivering else 0.0, delta * 5.0)
	
	# breathing
	breathing = sin(time * breathing_speed * TAU)
	body.target_scale = breathing
	#var breathing_scale : Vector2 = Vector2(pow(body_scale_pow, -breathing), pow(body_scale_pow, breathing))
	#body.scale = breathing_scale
	
	# swaying
	var body_sway_position = body_start_pos + Vector2(sin(time * 0.1 * TAU), cos(time * 0.07 * TAU) * 0.7) * 7.0
	
	# body squats when legs react
	leg_spd = Interpolator.spring_speed(
		leg_spd,
		leg_bop,
		0.0,
		10.0,
		0.02,
		delta)
	leg_spd = Interpolator.good_lerp(leg_spd, 0.0, 0.2, delta)
	leg_bop += leg_spd * delta
	
	# apply to body
	body.global_position = body_sway_position + Vector2.DOWN * leg_bop + shiver_offset
	
	# legs stay put after body moves
	var current_leg_to_floor = floor.global_position - legs.global_position
	legs.scale.y = current_leg_to_floor.length() / leg_to_floor.length()
	legs.scale.x = leg_to_floor.length() / current_leg_to_floor.length()
	legs.rotation = current_leg_to_floor.angle() - leg_to_floor.angle()
	
	
	
	# distraction
	
	
	# left arm
	l_arm.line_length = Interpolator.good_lerp(l_arm.line_length, l_target_length, 0.01, delta)
	l_arm.total_bend = Interpolator.good_lerp(l_arm.total_bend, l_target_bend, 0.005, delta)
	
	if not distracted:
		drawing_speed += delta / 5.0
		drawing_speed = clamp(drawing_speed, 0.0, 4.0)
	else:
		drawing_speed = 0.0
	
	
	r_arm.sine_speed = Interpolator.good_lerp(r_arm.sine_speed, -drawing_speed, 0.1, delta)
	r_arm.total_bend = Interpolator.good_lerp(r_arm.total_bend, r_target_bend, 0.2, delta)
	r_arm.sine_bend = Interpolator.good_lerp(r_arm.sine_bend, r_sine_bend, 0.1, delta)
	r_arm.arm_sine_bend = r_arm.sine_bend * 0.25
	
	body_wiggle.total_bend = Interpolator.good_lerp(body_wiggle.total_bend, tiredness * 1.5, 0.2, delta)
	l_eye.tiredness = tiredness
	r_eye.tiredness = tiredness
	pass

var drawing_speed = 0.5
#func bop_head():
	#head.scale_speed += 10.0
	#pass
#
#func bop_body():
	#body.scale_speed += 15.0
	#pass
#
#func bop_l():
	#arm_l.rotation_speed += 2.0
	#pass
#
#func bop_r():
	#arm_r.rotation_speed += 2.0
	#pass
#
#func bop_legs():
	#leg_spd += 50.0
	#pass

var l_target_length : float = 326.0
var l_target_bend : float = 2.0

var r_target_bend : float = -1.0
var r_sine_bend : float = 2.0

func arm_target_drink():
	l_target_length = 600.0
	l_target_bend = 0.8
	pass

func arm_target_snack():
	l_target_length = 450.0
	l_target_bend = 1
	pass

func arm_target_neutral():
	l_target_length = 326.0
	l_target_bend = 1.5
	pass

var distracted = false;

func distact():
	distracted = true;
	leg_spd += 50.0
	arm_r.rotation_speed += 5.0
	arm_l.rotation_speed += 5.0
	body.scale_speed += 15.0
	head.scale_speed -= 10.0
	r_target_bend = -0.5
	r_sine_bend = 0.0
	pass

func refocus():
	distracted = false
	leg_spd -= 50.0
	#arm_r.rotation_speed -= 5.0
	#arm_l.rotation_speed -= 5.0
	body.scale_speed -= 15.0
	head.scale_speed += 10.0
	r_target_bend = -1.0
	r_sine_bend = 2.0
	pass
