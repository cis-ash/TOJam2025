extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _on_title_button_mouse_entered() -> void:
	animated_sprite_2d.speed_scale = 1.0
	if not animated_sprite_2d.is_playing():
		animated_sprite_2d.play("default")
	pass # Replace with function body.


func _on_title_button_mouse_exited() -> void:
	animated_sprite_2d.speed_scale = -1.0
	if not animated_sprite_2d.is_playing():
		animated_sprite_2d.play("default")
	pass # Replace with function body.
