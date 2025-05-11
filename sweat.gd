@tool
extends Node2D
class_name Sweat

@export var sweating : bool = false
@onready var drop_1: CPUParticles2D = $Drop1
@onready var drop_2: CPUParticles2D = $Drop2
@onready var drop_3: CPUParticles2D = $Drop3


func _process(delta: float) -> void:
	drop_1.emitting = sweating
	drop_2.emitting = sweating
	drop_3.emitting = sweating
	pass
