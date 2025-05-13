@tool
extends Node2D
class_name TrackingEyes


@onready var eyeballs: Sprite2D = $Eyeballs

@export var width : float = 20.0
@export var height : float = 20.0
#@export var angle : float = 20.0
@export var mult : float = 20.0

func _process(delta: float) -> void:
	var to_mouse = (get_local_mouse_position() * mult)
	to_mouse = clamp(to_mouse.length(), 0.0, 1.0) * to_mouse.normalized()
	eyeballs.position = to_mouse * Vector2(width, height)
	eyeballs.global_rotation = 0.0
