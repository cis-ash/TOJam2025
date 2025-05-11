@tool
extends Sprite2D
@onready var sub_viewport_container: SubViewportContainer = $"../.."
@onready var brush_tip: Node2D = $"../../../../../../../Artist/RArm/IdleArmWiggle/RArm/ArmTip/Brushtip/BrushTip"

func _process(delta: float) -> void:
	position = brush_tip.global_position - sub_viewport_container.global_position
