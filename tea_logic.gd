@tool
extends Node2D
class_name Tea

@export_range(0.0, 1.0) var fullness = 1.0
@export var time_to_refill : float = 2.0
@onready var tea: Sprite2D = $Tea
@export var refilling : bool = false

func _ready() -> void:
	fullness = 1.0

func _process(delta: float) -> void:
	if (refilling):
		%ArtistGameLogic.distract()
		fullness = clamp(fullness + delta / time_to_refill, 0.0, 1.0)
	
	scale = Interpolator.good_lerp_vector(scale, Vector2.ONE, 0.1, delta)
	update_tea_fill()
	pass

func update_tea_fill():
	tea.material.set_shader_parameter("fraction", fullness)
	pass


func _on_refill_button_down() -> void:
	refilling = true
	$TeaRefill.playing = true
	pass # Replace with function body.


func _on_refill_button_up() -> void:
	refilling = false
	$TeaRefill.playing = false
	pass # Replace with function body.
