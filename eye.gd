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
@onready var pos: Node2D = $Pos

func look_at_global(global : Vector2):
	var _to_target = (global - pos.global_position) * 0.002
	_to_target = _to_target.normalized() * min(_to_target.length(), 1.0)
	_to_target *= Vector2(15.0, 5.0)
	_to_target += Vector2(-10.0, 0.0)
	eyeball_offset = _to_target
	#print(name, eyeball_offset)

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
