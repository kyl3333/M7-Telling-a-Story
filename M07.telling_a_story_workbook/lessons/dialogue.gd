extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton

var current_item_index := 0
var dialogue_items: Array[String] = [
	"I was minding my own business,",
	"But all of the suddens...",
	"Larry.",
	"He fatal errored all over my Godot project",
]

func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item
	
func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else: 
		show_text()
	
func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)
