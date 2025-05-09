extends RigidBody2D

var mouse_over : bool = false
var grabbed : bool = false


func _on_mouse_entered() -> void:
	mouse_over = true
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	mouse_over = false
	pass # Replace with function body.
	

@onready var line_2d: Line2D = $Line2D

var grab_position : Vector2 = Vector2.ZERO
@export var mouse_strength : float = 20.0
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("click") && mouse_over):
		grab_position = get_local_mouse_position()
		grabbed = true
		line_2d.points[0] = Vector2.ZERO
		line_2d.points[1] = Vector2.ZERO
		line_2d.position = grab_position
		line_2d.visible = true
	
	if (grabbed):
		var to_mouse = get_global_mouse_position() - to_global(grab_position)
		to_mouse = to_mouse.normalized() * min(to_mouse.length() , 50.0)
		apply_force(to_mouse * mouse_strength, grab_position)
		to_mouse = to_mouse.rotated(-global_rotation)
		line_2d.points[1] = to_mouse
		
		
	
	if (Input.is_action_just_released("click") and grabbed):
		grabbed = false
		line_2d.visible = false
	pass
