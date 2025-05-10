@tool
extends Node2D

@export var first : Node2D
@export var second : Node2D
@export_range(0.0, 1.0) var blend : float

func _process(delta: float) -> void:
	if is_instance_valid(first) and is_instance_valid(second):
		var sum = Vector2.RIGHT.rotated(first.global_rotation) * (1.0 - blend) + Vector2.RIGHT.rotated(second.global_rotation) * (blend)
		global_rotation = sum.angle()
		pass
	pass
