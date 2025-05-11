@tool
extends Node2D
class_name Fan
@export var spinning : bool = false
@onready var spinny: Node2D = $Spinny/Blades
@export var top_speed : float = 10.0
@export var speed : float = 0.0
@onready var toggle: SpringyScale = $DangleToggle/Toggle

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
	spinning = !spinning
	toggle.scale_speed -= 50.0
	%ArtistGameLogic.distract()
	pass # Replace with function body.
