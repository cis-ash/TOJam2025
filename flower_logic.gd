@tool
extends Node2D
class_name Flower

@export_range(0.0, 1.0) var freshness = 1.0

@export_range(0.0, 1.0) var first_petal_threshold = 0.7
@export_range(0.0, 1.0) var second_petal_threshold = 0.9

@export var fresh_bend_curve : Curve

@onready var stem: WobblyLine = $"../Stem"
@onready var petal_1: Sprite2D = $"../Stem/FlowerTip/PetaloneFill"
@onready var petal_2: Sprite2D = $"../Stem/FlowerTip/PetaltwoFill"

func _physics_process(delta: float) -> void:
	update_flower_visual(delta)
	pass

func update_flower_visual(delta : float):
	stem.total_bend = Interpolator.good_lerp(stem.total_bend, fresh_bend_curve.sample(freshness) * 4.0, 0.05, delta)
	var target_scale_1 = (1.0 if freshness > first_petal_threshold else 0.0) * Vector2.ONE
	var target_scale_2 = (1.0 if freshness > second_petal_threshold else 0.0) * Vector2.ONE
	petal_1.scale = Interpolator.good_lerp_vector(petal_1.scale, target_scale_1, 0.3, delta)
	petal_2.scale = Interpolator.good_lerp_vector(petal_2.scale, target_scale_2, 0.3, delta)
	pass
