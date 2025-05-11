extends Node2D
class_name GameLogic

@onready var artist: BodyAnimator = $"../Artist" # need to animate and react
@onready var tea_logic: Tea = %TeaLogic # need to sippy
@onready var apple_plate_logic: ApplePlate = %ApplePlateLogic # need to snack
@onready var fan_logic: Fan = %FanLogic # used
@onready var light_bulb_logic: LightBulb = %LightBulbLogic # used
@onready var flower_logic: Flower = %FlowerLogic # used
@onready var painting_tip: Sprite2D = %PaintingTip # should be affected by state
@onready var thought_palete_logic: ThoughtPalete = %ThoughtPaleteLogic # used
@onready var wobble_manager: Node2D = %WobbleManager # should be affected by state
@onready var time_logic: TimeLogic = %TimeLogic # used
@onready var sweat: Sweat = $"../Artist/Head/IdleHeadMotion/Sweat" # used

@export_category("Stats")
@export_range(0.0, 1.0) var body_stat : float = 1.0
@export_range(0.0, 1.0) var mind_stat : float = 0.0
@export_range(0.0, 1.0) var enviornment_stat : float = 0.0
@export_range(0.0, 1.0) var painting_progress : float = 0.0

@export_category("Needs")
@export var wants_fan : bool = false
@export var wants_light : bool = false

@export_category("Satisfaction")
@export var comfy_temperature : bool = false
@export var hungry : bool = false
@export var thirsty : bool = false
@export var flower_ok : bool = true
@export var flower_alive : bool = true
@export var subject_well_lit : bool = true
@export var distracted : bool = false

@export var time_to_refocus : float = 2.0
@export var time_since_distraction : float = 0.0

var playing = true

func _ready() -> void:
	# body loop
	snack_and_sip()
	randomize_temperature()
	pass

func snack_and_sip():
	while playing:
		await get_tree().create_timer(1.0 if hungry or thirsty else randf_range(10.0, 20.0)).timeout
		if hungry or (not thirsty): await try_to_snack()
		await get_tree().create_timer(1.0 if hungry or thirsty else randf_range(10.0, 20.0)).timeout
		if thirsty or (not hungry): await try_to_drink()
		pass
	pass

func randomize_temperature():
	while playing:
		await get_tree().create_timer(randf_range(10.0, 20.0)).timeout
		wants_fan = bool(randi() % 2)
		pass
	pass

var _was_distracted : bool = false
func _process(delta: float) -> void:
	
	thought_palete_logic.body_meter = body_stat
	thought_palete_logic.environment_meter = enviornment_stat
	thought_palete_logic.mind_meter = mind_stat
	
	time_since_distraction += delta
	update_needs()
	
	if !distracted:
		painting_progress += delta / 60.0
	
	if !_was_distracted and distracted:
		artist.distact()
	elif _was_distracted and !distracted:
		artist.refocus()
	
	_was_distracted = distracted
	pass

func update_needs():
	comfy_temperature = wants_fan == fan_logic.spinning
	sweat.sweating = wants_fan and (not fan_logic.spinning)
	artist.shivering = (not wants_fan) and fan_logic.spinning
	wants_light = time_logic.night_time
	
	flower_ok = !flower_logic.sad
	flower_alive = !flower_logic.very_sad
	subject_well_lit = wants_light == light_bulb_logic.lights_on
	
	distracted = time_since_distraction < time_to_refocus
	pass

var sippy_size = 0.3
func try_to_drink():
	artist.arm_target_drink()
	await get_tree().create_timer(0.5).timeout
	if tea_logic.fullness > sippy_size * 0.5:
		thirsty = false
		tea_logic.fullness = max(tea_logic.fullness - sippy_size, 0.0)
		tea_logic.scale = 0.8 * Vector2.ONE
		# gulp
	else:
		thirsty = true
		# aww
	await get_tree().create_timer(0.5).timeout
	artist.arm_target_neutral()
	pass

func try_to_snack():
	artist.arm_target_snack()
	await get_tree().create_timer(0.5).timeout
	if apple_plate_logic.apple_count > 0:
		apple_plate_logic.apple_count -= 1
		apple_plate_logic.bop_plate()
		hungry = false
		# nom
	else:
		hungry = true
		# tummy rumble
	await get_tree().create_timer(0.5).timeout
	artist.arm_target_neutral()
	pass

func distract():
	time_since_distraction = 0.0
	pass
