@tool
extends Node2D
class_name TimeLogic

@export var time : float = 0.0
@export var ticking : bool = false
@export var seconds_in_a_day : float = 30.0
@onready var timer_plate: Sprite2D = $"../Window/SubViewportContainer/TimerPlate"
@export var night_time : bool = false

func _process(delta: float) -> void:
	if (ticking):
		time += delta / seconds_in_a_day
	else:
		time = 0.0
	night_time = wrapf(time, 0.0, 1.0) > 0.5
	update_visuals()
	pass


func update_visuals():
	timer_plate.rotation = TAU * time
	pass
