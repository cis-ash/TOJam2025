@tool
extends Node2D
class_name WobbleManager

@export var fill_material : ShaderMaterial
@export var line_material : ShaderMaterial
@export var fill_offset : float = 0.0
@export var fill_boil : float = 0.0
@export var line_boil : float = 0.0

func _process(delta: float) -> void:
	if is_instance_valid(fill_material):
		fill_material.set_shader_parameter("offset_amp", Vector2.ONE * fill_boil)
		fill_material.set_shader_parameter("offset", fill_offset)
		pass
	
	if is_instance_valid(line_material):
		line_material.set_shader_parameter("offset_amp", Vector2.ONE * line_boil)
		pass
	pass
