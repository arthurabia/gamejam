extends TextureButton

func _ready():
	connect("pressed", self, "_button_pressed")
	pass # Replace with function body.

func _button_pressed():
	print(32)
	get_tree().change_scene("res://scenes/World.tscn")
	
func _physics_process(delta):
	pass