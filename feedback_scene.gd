extends Node2D
class_name FeedbackScene

@onready var feedback_1: Feedback = $Feedback1
@onready var feedback_2: Feedback = $Feedback2
@onready var feedback_3: Feedback = $Feedback3

var active = false

var final_quality : float = 0.0

func activate(quality: float):
	print("END ACTIVATED")
	active = true
	hide_main()
	final_quality = quality
	feedback_1.generate_feedback(quality > randf_range(0.1, 0.5))
	feedback_2.generate_feedback(quality > randf_range(0.2, 0.7))
	feedback_3.generate_feedback(quality > randf_range(0.3, 0.9))
	await get_tree().create_timer(2.0).timeout
	await feedback_1.show_feedback()
	await feedback_2.show_feedback()
	await feedback_3.show_feedback()
	show_postit = true
	pass

func hide_main():
	await get_tree().create_timer(5.0).timeout
	$"../Artist".visible = false
	$"../CentreFrame".visible = false

	pass

var show_postit : bool = false

func _process(delta: float) -> void:
	if active:
		position = Interpolator.good_lerp_vector(position, Vector2(960.0, 540.0), 0.2, delta)
	if show_postit:
		$PostitNote.position.y = Interpolator.good_lerp($PostitNote.position.y, 500.0, 0.1, delta)
