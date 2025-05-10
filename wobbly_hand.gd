@tool
extends Line2D

@export var line_points : int = 20
@export var line_length : float = 500.0
@export var total_bend : float = 1.0
@export var sine_speed : float = 1.0
@export var sine_width : float = 3.0
@export var sine_bend : float = 1.0
@export var sine_influence_curve : Curve

var sine_time : float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	sine_time += delta * sine_speed
	sine_time = wrapf(sine_time, 0.0, 1.0)
	move_line_points()
	pass


func move_line_points() -> void:
	var points_array : Array = []
	var last_position = Vector2.ZERO
	var last_direction = Vector2.RIGHT
	var segment_length = line_length / float(line_points)
	var segment_bend = total_bend / float(line_points)
	var segment_sine_bend = sine_bend / float(line_points)
	for i in range(line_points):
		var line_progress : float = float(i) / float(line_points)
		var new_direction : Vector2 = last_direction.rotated(segment_bend).rotated(
				(sin( (sine_time * TAU) + line_progress * sine_width)) 
				* segment_sine_bend * sine_influence_curve.sample(line_progress))
		var new_segment : Vector2 = new_direction * segment_length 
		var new_point : Vector2 = last_position + new_segment;
		
		points_array.append(new_point)
		
		last_position = new_point
		last_direction = new_direction
	
	var packed_points_array : PackedVector2Array = PackedVector2Array(points_array)
	points = packed_points_array
	pass
