extends PhysicsBody2D
@onready var bottom: CollisionShape2D = $Bottom
@onready var top: CollisionShape2D = $Top
@onready var left: CollisionShape2D = $Left
@onready var right: CollisionShape2D = $Right
@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	#get_window().size_changed.connect(move_walls)
	move_walls()
	pass

func _process(delta: float) -> void:
	call_deferred("move_walls")
	pass

func move_walls():
	var window_size : Vector2 = get_window().size
	var window_position : Vector2 = get_window().position
	camera_2d.position = window_position + window_size * 0.5
	top.position = window_position + window_size * Vector2(0.5, 0)
	bottom.position = window_position + window_size * Vector2(0.5, 1)
	left.position = window_position + window_size * Vector2(0, 0.5)
	right.position = window_position + window_size * Vector2(1, 0.5)
	#print(last_pos - Vector2(get_window().position))
	pass
