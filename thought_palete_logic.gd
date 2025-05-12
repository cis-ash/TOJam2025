@tool
extends Node2D
class_name ThoughtPaleteLogic

@onready var blue_paint: Sprite2D = $"../ThoughtPalette/ThoughtPalette2/BluePaint"
@onready var red_paint: Sprite2D = $"../ThoughtPalette/ThoughtPalette2/RedPaint"
@onready var yellow_paint: Sprite2D = $"../ThoughtPalette/ThoughtPalette2/YellowPaint"

@export_range(0.0, 1.0) var body_meter : float = 1.0 # blue
@export_range(0.0, 1.0) var mind_meter : float = 1.0 # red
@export_range(0.0, 1.0) var environment_meter : float = 1.0 # yellow


func _process(delta: float) -> void:
	update_meters()
	update_bubbles(delta)
	update_annoyances(delta)
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
	var big_target_scale = 1.0 if %ArtistGameLogic.time_since_distraction > 6.0 else 0.0
	var mid_target_scale = 1.0 if %ArtistGameLogic.time_since_distraction > 4.0 else 0.0
	var small_target_scale = 1.0 if %ArtistGameLogic.time_since_distraction > 2.0 else 0.0
	
	big.scale = Interpolator.good_lerp_vector(big.scale, Vector2.ONE * big_target_scale, 0.05, delta)
	mid.scale = Interpolator.good_lerp_vector(mid.scale, Vector2.ONE * mid_target_scale, 0.05, delta)
	small.scale = Interpolator.good_lerp_vector(small.scale, Vector2.ONE * small_target_scale, 0.05, delta)
	pass

@onready var hungry: Node2D = $"../ThoughtPalette/ThoughtPalette2/BluePaint/Hungry"
@onready var thirsty: Node2D = $"../ThoughtPalette/ThoughtPalette2/BluePaint/Thirsty"
@onready var cold: Node2D = $"../ThoughtPalette/ThoughtPalette2/BluePaint/Cold"
@onready var hot: Node2D = $"../ThoughtPalette/ThoughtPalette2/BluePaint/Hot"
@onready var too_dark: Node2D = $"../ThoughtPalette/ThoughtPalette2/YellowPaint/TooDark"
@onready var too_bright: Node2D = $"../ThoughtPalette/ThoughtPalette2/YellowPaint/TooBright"
@onready var flower_sad: Node2D = $"../ThoughtPalette/ThoughtPalette2/YellowPaint/FlowerSad"
@onready var flower_dead: Node2D = $"../ThoughtPalette/ThoughtPalette2/YellowPaint/FlowerDead"
@onready var logic : GameLogic = %ArtistGameLogic

func update_annoyances(delta : float):
	var hungry_on = logic.hungry
	var thirsty_on = logic.thirsty
	var cold_on = (not logic.comfy_temperature) and (not logic.wants_fan)
	var hot_on = (not logic.comfy_temperature) and (logic.wants_fan)
	var dark_on = (not logic.subject_well_lit) and (logic.wants_light)
	var bright_on = (not logic.subject_well_lit) and (not logic.wants_light)
	var sad_on = not logic.flower_ok
	var dead_on = not logic.flower_alive
	
	hungry.modulate.a = Interpolator.good_lerp(hungry.modulate.a, float(int(hungry_on)), 0.05, delta) 
	thirsty.modulate.a = Interpolator.good_lerp(thirsty.modulate.a, float(int(thirsty_on)), 0.05, delta) 
	cold.modulate.a = Interpolator.good_lerp(cold.modulate.a, float(int(cold_on)), 0.05, delta)
	hot.modulate.a = Interpolator.good_lerp(hot.modulate.a, float(int(hot_on)), 0.05, delta) 
	too_dark.modulate.a = Interpolator.good_lerp(too_dark.modulate.a, float(int(dark_on)), 0.05, delta) 
	too_bright.modulate.a = Interpolator.good_lerp(too_bright.modulate.a, float(int(bright_on)), 0.05, delta) 
	flower_sad.modulate.a = Interpolator.good_lerp(flower_sad.modulate.a, float(int(sad_on)), 0.05, delta) 
	flower_dead.modulate.a = Interpolator.good_lerp(flower_dead.modulate.a, float(int(dead_on)), 0.05, delta) 
	pass
