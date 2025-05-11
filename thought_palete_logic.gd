@tool
extends Node2D
class_name ThoughtPalete

@onready var blue_paint: Sprite2D = $"../ThoughtPalette/BluePaint"
@onready var red_paint: Sprite2D = $"../ThoughtPalette/RedPaint"
@onready var yellow_paint: Sprite2D = $"../ThoughtPalette/YellowPaint"

@export_range(0.0, 1.0) var body_meter : float = 1.0 # blue
@export_range(0.0, 1.0) var mind_meter : float = 1.0 # red
@export_range(0.0, 1.0) var environment_meter : float = 1.0 # yellow

func _process(delta: float) -> void:
	update_meters()
	pass

func update_meters() -> void:
	blue_paint.material.set_shader_parameter("fraction", body_meter)
	red_paint.material.set_shader_parameter("fraction", mind_meter)
	yellow_paint.material.set_shader_parameter("fraction", environment_meter)
	pass
