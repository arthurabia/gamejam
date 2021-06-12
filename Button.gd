extends Button
var test = load("res://assets/test.png")
onready var all = $"/root/World"

func _ready():
	connect("pressed", self, "_button_pressed")
	pass # Replace with function body.

func _button_pressed():
	Input.set_custom_mouse_cursor(test)
	
