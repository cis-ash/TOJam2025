@tool
extends Node2D
class_name TimeLogic

@export var time : float = 0.0
@export var ticking : bool = false
@export var seconds_in_a_day : float = 30.0
@onready var timer_plate: Sprite2D = $"../CentreFrame/Background/Window/SubViewportContainer/TimerPlate"
@export var night_time : bool = false

@onready var day_night_mult: Sprite2D = $DayNightMult


@export var smoothstep_width : float = 0.1

func _process(delta: float) -> void:
	if (ticking):
		time += delta / seconds_in_a_day
	#else:
		#time = 0.0
	night_time = not (wrapf(time, 0.0, 1.0) > 0.75 or  wrapf(time, 0.0, 1.0) < 0.25)
	update_visuals()
	pass


func update_visuals():
	timer_plate.rotation = TAU * time
	var day_shifted : float = wrapf(time - 0.0, 0.0, 1.0)
	day_night_mult.material.set_shader_parameter("day", smoothstep(0.25 - smoothstep_width, 0.25 + smoothstep_width, day_shifted) * (1.0 - smoothstep(0.75 - smoothstep_width, 0.75 + smoothstep_width, day_shifted)));
	pass
