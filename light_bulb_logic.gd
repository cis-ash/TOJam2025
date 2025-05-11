extends Node2D
class_name LightBulb

@export var lights_on : bool = false
@onready var on: Sprite2D = $"Bulb/On!"
@onready var toggle: SpringyScale = $CordWobble/Toggle



func _on_button_toggled(toggled_on: bool) -> void:
	lights_on = !lights_on
	on.visible = lights_on
	toggle.scale_speed -= 30.0
	pass # Replace with function body.
