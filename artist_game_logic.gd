extends Node2D
class_name GameLogic

@onready var artist: BodyAnimator = $"../Artist" # need to animate and react
@onready var tea_logic: Tea = %TeaLogic # need to sippy
@onready var apple_plate_logic: ApplePlate = %ApplePlateLogic # need to snack
@onready var fan_logic: Fan = %FanLogic # used
@onready var light_bulb_logic: LightBulb = %LightBulbLogic # used
@onready var watering_can_logic: WateringCan = %WateringCanLogic # not needed
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

func _process(delta: float) -> void:
	
	thought_palete_logic.body_meter = body_stat
	thought_palete_logic.environment_meter = enviornment_stat
	thought_palete_logic.mind_meter = mind_stat
	
	update_needs()
	pass

func update_needs():
	comfy_temperature = wants_fan == fan_logic.spinning
	sweat.sweating = wants_fan && !fan_logic.spinning
	wants_light = time_logic.night_time
	
	flower_ok = !flower_logic.sad
	flower_alive = !flower_logic.very_sad
	subject_well_lit = wants_light == light_bulb_logic.lights_on
	pass

var sippy_size = 0.1
func try_to_drink():
	if tea_logic.fullness > sippy_size * 0.5:
		thirsty = false
		tea_logic.fullness = max(tea_logic.fullness - sippy_size, 0.0)
		# gulp
	else:
		thirsty = true
		# aww
	pass

func try_to_snack():
	if apple_plate_logic.apple_count > 0:
		apple_plate_logic.apple_count -= 1
		apple_plate_logic.bop_plate()
		hungry = false
		# nom
	else:
		hungry = true
		# tummy rumble
	pass
