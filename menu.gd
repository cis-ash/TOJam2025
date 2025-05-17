extends Node2D
@export var credits_scene : PackedScene
@export var main_scene : PackedScene

func _ready() -> void:
	$Credits/AnimatedSprite2D.play("default")
	pass

var vibrate_credits : bool = false
var play_hover : bool = false
var play_scale : float = 0.0
@onready var play_text: Sprite2D = $Canvas/Play

var spinny : Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:
	if vibrate_credits:
		$Credits.scale = Vector2.ONE + Vector2.RIGHT.rotated(randf() * TAU) * 0.01
	else:
		$Credits.scale = Vector2.ONE
	
	
	spinny = spinny.rotated(delta * TAU * 3.0)
	play_scale = Interpolator.good_lerp(play_scale, 1.0 if play_hover else 0.0, 0.2, delta)
	
	play_text.scale = Vector2.ONE * (1.0 + play_scale * 0.5) + (spinny * play_scale * 0.15)
	
func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_packed(credits_scene)
	pass # Replace with function body.


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)
	pass # Replace with function body.


func _on_credits_button_mouse_entered() -> void:
	vibrate_credits = true
	pass # Replace with function body.


func _on_credits_button_mouse_exited() -> void:
	vibrate_credits = false
	pass # Replace with function body.


func _on_play_button_mouse_entered() -> void:
	play_hover = true
	$Canvas/Play/GPUParticles2D.emitting = true
	pass # Replace with function body.


func _on_play_button_mouse_exited() -> void:
	play_hover = false
	$Canvas/Play/GPUParticles2D.emitting = false
	pass # Replace with function body.
