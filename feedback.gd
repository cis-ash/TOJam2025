extends Node2D
class_name Feedback

@onready var happy_face: Node2D = $Face/HappyFace
@onready var sad_face: Node2D = $Face/SadFace
@onready var bubble: Node2D = $Bubble
@onready var label: Label = $Bubble/BubbleWibbler/Label

var good_feedback : Array[String] = [
	"Wow, you must have worked hard on this!",
	"This tells a deep story.",
	"The soulful gaze of the goat is doing something to me.",
	"It’s peam!",
	"Expressive brushwork!",
	"I can see this in a gallery!",
	]
var bad_feedback : Array[String] = [
	"The colours could use some refining.",
	"I think that it’s… unique?",
	"This looks more rushed than energetic.",
	"Is this like, anime?",
	"I think it’s weird.",
	"You should make this into an NFT.",
	"A buddy of mine needs a logo for his pocket knife business, you should talk to him.",
	]

func _ready() -> void:
	generate_feedback(randf() > 0.5)
	pass

func generate_feedback(positive : bool):
	happy_face.visible = positive
	sad_face.visible = not positive
	if positive:
		label.text = good_feedback[randi()%good_feedback.size()]
	else:
		label.text = bad_feedback[randi()%bad_feedback.size()]
	label.visible_ratio = 0.0
	pass

@onready var face: Node2D = $Face

func _process(delta: float) -> void:
	face.scale = Interpolator.good_lerp_vector(face.scale, Vector2.ONE * (1.0 if show_face else 0.0), 0.05, delta)
	bubble.scale = Interpolator.good_lerp_vector(bubble.scale, Vector2.ONE * (1.0 if show_bubble else 0.0), 0.1, delta)
	if (label.visible_ratio < 1.0 and show_text):
		label.visible_ratio += delta
	pass

var show_face : bool = false
var show_bubble : bool = false
var show_text : bool = false
func show_feedback():
	show_face = true
	await get_tree().create_timer(0.5).timeout
	show_bubble = true
	await get_tree().create_timer(0.5).timeout
	show_text = true
	await get_tree().create_timer(1.0).timeout
	pass
