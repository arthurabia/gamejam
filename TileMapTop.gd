extends TileMap
onready var testText = get_node("../TextEdit")
var gridcCoordinates = [0,0]

func _ready():
	pass
	
func _unhandled_input(event):
	if Input.is_mouse_button_pressed(1):
		var mousePosition = event.position
		gridcCoordinates = Vector2(world_to_map(mousePosition).x - 5,world_to_map(mousePosition).y)
		if gridcCoordinates.x > 0 and gridcCoordinates.x < 9 and gridcCoordinates.y > 0 and gridcCoordinates.y < 9:
			testText.set_text("Cellule touchée : " + String(gridcCoordinates))
		else:
			testText.set_text("Cellule touchée : Aucune !")
	