extends Button
onready var gameState = get_node("/root/gameState")
export var buildingType = 0

func _ready():
	connect("pressed", self, "_button_pressed")
	pass # Replace with function body.

func _button_pressed():
	var value = buildingType
	gameState.selectedBuilding = value
	
	
