extends Node2D
class_name LightBulb

@export var lights_on : bool = false
@onready var on: Sprite2D = $"Bulb/On!"
@onready var toggle: SpringyScale = $CordWobble/Toggle

@onready var light_off: AudioStreamPlayer2D = $LightOff
@onready var light_on: AudioStreamPlayer2D = $LightOn


func _on_button_toggled(toggled_on: bool) -> void:
	lights_on = !lights_on
	on.visible = lights_on
	toggle.scale_speed -= 30.0
	%ArtistGameLogic.distract()
	if toggled_on:
		light_on.play()
	else:
		light_off.play()
	pass # Replace with function body.
