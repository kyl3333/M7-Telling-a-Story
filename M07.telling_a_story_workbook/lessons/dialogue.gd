extends Control

@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %Expression
@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

var expressions := {
	"happy": preload ("res://assets/emotion_happy.png"),
	"regular": preload ("res://assets/emotion_regular.png"),
	"sad": preload ("res://assets/emotion_sad.png"),
}
var current_item_index := 0
var dialogue_items: Array[Dictionary] = [
	{
		"expression": expressions["happy"],
		"text": "I was minding my own business,",
	},
	{
		"expression": expressions["regular"],
		"text": "But all of the suddens...",
	},
	{
		"expression": expressions["sad"],
		"text": "Larry.",
	},
	{
		"expression": expressions["sad"],
		"text": "He fatal errored all over my Godot project",
	},
]

func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	expression.texture = current_item["expression"]
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration := 1.2
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	var sound_max_offset := audio_stream_player.stream.get_length() - text_appearing_duration
	var sound_start_position := randf() * sound_max_offset
	audio_stream_player.play(sound_start_position)
	tween.finished.connect(audio_stream_player.stop)
	
func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else: 
		show_text()
	
func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)
