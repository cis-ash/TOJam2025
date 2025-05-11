@tool
extends Node2D
class_name ThoughtPalete

@onready var blue_paint: Sprite2D = $"../ThoughtPalette/ThoughtPalette2/BluePaint"
@onready var red_paint: Sprite2D = $"../ThoughtPalette/ThoughtPalette2/RedPaint"
@onready var yellow_paint: Sprite2D = $"../ThoughtPalette/ThoughtPalette2/YellowPaint"

@export_range(0.0, 1.0) var body_meter : float = 1.0 # blue
@export_range(0.0, 1.0) var mind_meter : float = 1.0 # red
@export_range(0.0, 1.0) var environment_meter : float = 1.0 # yellow


func _process(delta: float) -> void:
	update_meters()
	update_bubbles(delta)
	pass

func update_meters() -> void:
	blue_paint.material.set_shader_parameter("fraction", body_meter)
	red_paint.material.set_shader_parameter("fraction", mind_meter)
	yellow_paint.material.set_shader_parameter("fraction", environment_meter)
	pass

@onready var big : Sprite2D = $"../ThoughtPalette/ThoughtPalette2"
@onready var mid : Sprite2D = $"../BubBig/BubBig2"
@onready var small : Sprite2D = $"../BubSmall/BubSmall2"

func update_bubbles(delta : float):
	print(%ArtistGameLogic.time_since_distraction)
	var big_target_scale = 1.0 if %ArtistGameLogic.time_since_distraction > 6.0 else 0.0
	var mid_target_scale = 1.0 if %ArtistGameLogic.time_since_distraction > 4.0 else 0.0
	var small_target_scale = 1.0 if %ArtistGameLogic.time_since_distraction > 2.0 else 0.0
	
	big.scale = Interpolator.good_lerp_vector(big.scale, Vector2.ONE * big_target_scale, 0.05, delta)
	mid.scale = Interpolator.good_lerp_vector(mid.scale, Vector2.ONE * mid_target_scale, 0.05, delta)
	small.scale = Interpolator.good_lerp_vector(small.scale, Vector2.ONE * small_target_scale, 0.05, delta)
	pass
