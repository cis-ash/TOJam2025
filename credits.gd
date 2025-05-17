extends Node2D
@onready var ashy: Node2D = $Ashy
@onready var juneau: Node2D = $Juneau
@onready var kento: Node2D = $Kento
@onready var left: Node2D = $Left
@onready var middle: Node2D = $Middle
@onready var right: Node2D = $Right

var vibrate : bool = false

func _ready() -> void:
	$Credits/AnimatedSprite2D.play("default")
	pass

func _process(delta: float) -> void:
	if vibrate:
		$Credits.scale = Vector2.ONE + Vector2.RIGHT.rotated(randf() * TAU) * 0.01
	else:
		$Credits.scale = Vector2.ONE

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
	pass # Replace with function body.


func _on_credits_button_mouse_entered() -> void:
	vibrate = true
	pass # Replace with function body.


func _on_credits_button_mouse_exited() -> void:
	vibrate = false
	pass # Replace with function body.
