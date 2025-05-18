extends Node2D
class_name Mouth

enum MOUTHSHAPE {PENSIVE, CRAZY, NORMAL, SAD}
@onready var pensive_mouth: Sprite2D = $PensiveMouth
@onready var crazymouth: Sprite2D = $Crazymouth
@onready var mouth: Sprite2D = $Mouth2
var state : MOUTHSHAPE = MOUTHSHAPE.NORMAL

func set_mouth(type : MOUTHSHAPE):
	pensive_mouth.visible = type == MOUTHSHAPE.PENSIVE
	crazymouth.visible = type == MOUTHSHAPE.CRAZY
	mouth.visible = (type == MOUTHSHAPE.SAD) or (type == MOUTHSHAPE.NORMAL)
	state = type
	pass

func _process(delta: float) -> void:
	if mouth.visible:
		mouth.rotation = Interpolator.good_lerp(mouth.rotation, (0.0 if state == MOUTHSHAPE.NORMAL else (TAU * 0.5)), 0.001, delta)
	pass
