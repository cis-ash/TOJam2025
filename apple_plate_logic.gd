@tool
extends Node2D
class_name ApplePlate

@export_range(0, 3, 1) var apple_count : int = 0

@onready var apple_1: Node2D = $WigglingApple1/AppleContainer1
@onready var apple_2: Node2D = $WigglingApple2/AppleContainer2
@onready var apple_3: Node2D = $WigglingApple3/AppleContainer3
@onready var plate: Sprite2D = $Plate

func _process(delta: float) -> void:
	update_apples(delta)
	plate.scale = Interpolator.good_lerp_vector(plate.scale, Vector2.ONE * 0.865, 0.001, delta)
	pass

func update_apples(delta):
	var scale_1 = Vector2.ONE * ( 1.0 if apple_count >= 1 else 0.0)
	var scale_2 = Vector2.ONE * ( 1.0 if apple_count >= 2 else 0.0)
	var scale_3 = Vector2.ONE * ( 1.0 if apple_count >= 3 else 0.0)
	
	apple_1.scale = Interpolator.good_lerp_vector(apple_1.scale, scale_1, 0.05, delta)
	apple_2.scale = Interpolator.good_lerp_vector(apple_2.scale, scale_2, 0.05, delta)
	apple_3.scale = Interpolator.good_lerp_vector(apple_3.scale, scale_3, 0.05, delta)
	pass


func _on_refill_button_pressed() -> void:
	apple_count += 1
	apple_count = clamp(apple_count, 0, 3)
	bop_plate()
	pass # Replace with function body.

func bop_plate():
	plate.scale *= Vector2.ONE * 1.25
	pass
