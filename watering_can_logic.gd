extends Node2D
class_name WateringCan

@export var watering : bool = false

@onready var drop_1: CPUParticles2D = $"../Drop1"
@onready var drop_2: CPUParticles2D = $"../Drop2"
@onready var drop_3: CPUParticles2D = $"../Drop3"
@onready var flower_logic: Flower = %FlowerLogic

func _on_button_button_down() -> void:
	watering = true
	update_emitters_and_flower()
	pass # Replace with function body.


func _on_button_button_up() -> void:
	watering = false
	update_emitters_and_flower()
	pass # Replace with function body.

func update_emitters_and_flower():
	drop_1.emitting = watering
	drop_2.emitting = watering
	drop_3.emitting = watering
	flower_logic.being_watered = watering
	$"WateringCanWatering(continuous)".playing = watering
	pass
