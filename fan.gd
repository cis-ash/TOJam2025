@tool
extends Node2D
@export var spinning : bool = false
@onready var spinny: Node2D = $Spinny/Blades
@export var top_speed : float = 10.0
@export var speed : float = 0.0

func _process(delta: float) -> void:
	if spinning:
		if speed < top_speed :
			speed += delta * top_speed / 2.0
	else:
		if speed > 0:
			speed -= delta * top_speed / 5.0
		if speed < 0:
			speed = 0.0
	
	spinny.rotate(speed * delta)
	pass


func _on_toggle_fan_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
