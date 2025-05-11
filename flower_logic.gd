@tool
extends Node2D
class_name Flower

@export_range(0.0, 1.0) var freshness = 1.0
@export var being_watered : bool = false
@export var sad : bool = false
@export var very_sad : bool = false

@export var time_to_hydrate : float = 2.0
@export var time_to_wilt : float = 30.0
@export_range(0.0, 1.0) var first_petal_threshold = 0.7
@export_range(0.0, 1.0) var second_petal_threshold = 0.9

@export var fresh_bend_curve : Curve

@onready var stem: WobblyLine = $"../Stem"
@onready var petal_1: Sprite2D = $"../Stem/FlowerTip/PetaloneFill"
@onready var petal_2: Sprite2D = $"../Stem/FlowerTip/PetaltwoFill"

func _physics_process(delta: float) -> void:
	if being_watered:
		freshness += delta / time_to_hydrate
	else:
		freshness -= delta / time_to_wilt
	freshness = clamp(freshness, 0.0, 1.0)
	update_flower_visual(delta)
	sad = freshness < first_petal_threshold
	very_sad = freshness < second_petal_threshold
	pass

func update_flower_visual(delta : float):
	stem.total_bend = Interpolator.good_lerp(stem.total_bend, fresh_bend_curve.sample(freshness) * 4.0, 0.05, delta)
	var target_sine_speed = (-3.0 if being_watered else -0.1)
	stem.sine_speed = Interpolator.good_lerp(stem.sine_speed, target_sine_speed, 0.1, delta)
	var target_scale_1 = (1.0 if freshness > first_petal_threshold else 0.0) * Vector2.ONE
	var target_scale_2 = (1.0 if freshness > second_petal_threshold else 0.0) * Vector2.ONE
	petal_1.scale = Interpolator.good_lerp_vector(petal_1.scale, target_scale_1, 0.3, delta)
	petal_2.scale = Interpolator.good_lerp_vector(petal_2.scale, target_scale_2, 0.3, delta)
	pass
