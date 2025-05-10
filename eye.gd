@tool
extends Node2D
class_name Eye

enum EYE_TYPE {CALM, CRAZY, TIRED}

@export var blinking : bool = false
@export_range(0.0, 1.0) var tiredness : float = 0.0
@export var eye_state : EYE_TYPE
@export var eyebrow_angle : float
@export var eyeball_offset : Vector2

@export var open_eye : Node2D
@export var closed_eye : Node2D
@export var eyebag : Node2D
@export var calm_eye : Node2D
@export var crazy_eye : Node2D
@export var tired_eye : Node2D
@export var eyebrow : Node2D
@export var eyeball : Node2D
@export var flip_eyebrow : bool

func _process(delta: float) -> void:
	update_eye()
	pass

func update_eye():
	open_eye.visible = not blinking
	closed_eye.visible = blinking
	calm_eye.visible = eye_state == EYE_TYPE.CALM
	crazy_eye.visible = eye_state == EYE_TYPE.CRAZY
	tired_eye.visible = eye_state == EYE_TYPE.TIRED
	eyebag.modulate.a = tiredness
	eyebrow.rotation = eyebrow_angle * (-1.0 if flip_eyebrow else 1.0)
	eyeball.position = eyeball_offset
	pass
