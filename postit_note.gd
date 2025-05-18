extends Node2D


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")
	pass # Replace with function body.


func _on_menu_button_mouse_entered() -> void:
	$MenuPostit/ToMenu.modulate = Color.BLACK
	pass # Replace with function body.


func _on_menu_button_mouse_exited() -> void:
	$MenuPostit/ToMenu.modulate = Color.from_string("3f3f3f", Color.BLACK)
	pass # Replace with function body.


func _on_credits_button_mouse_entered() -> void:
	$MenuPostit/ToCredits.modulate = Color.BLACK
	pass # Replace with function body.


func _on_credits_button_mouse_exited() -> void:
	$MenuPostit/ToCredits.modulate = Color.from_string("3f3f3f", Color.BLACK)
	pass # Replace with function body.
