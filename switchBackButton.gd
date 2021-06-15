extends Button
onready var gameState = get_node("/root/gameState")
onready var counterTurn = get_node("../counterTurn")
onready var switchButton = get_node("../switchButton")
onready var ui = get_node("../UI")
onready var mapOnTop = get_node("../mapOnTop")
onready var mapOnTopAlter = get_node("../mapOnTopAlter")
onready var counterScore = get_node("../counterScore")
onready var counterScoreAlter = get_node("../counterScoreAlter")
onready var uialter = get_node("../UIalter")
onready var building1 = get_node("../UI/building1")
onready var building2 = get_node("../UI/building2")
onready var building3 = get_node("../UI/building3")
onready var building4 = get_node("../UI/building4")
onready var building5 = get_node("../UI/building5")
onready var labelQuest = get_node("../Label")
onready var postapoSong = get_node("/root/World/postapoSong")
onready var fantasySong = get_node("/root/World/fantasySong")

func _ready():
	connect("pressed", self, "_button_pressed")
	pass # Replace with function body.

func _button_pressed():
	visible = false
	switchButton.visible = true
	#Ce qui est revisible
	ui.visible = true
	counterTurn.visible = true
	mapOnTop.visible = true
	counterScore.visible = true
	#Ce qui est caché
	uialter.visible = false
	mapOnTopAlter.visible = false
	counterScoreAlter.visible = false
	#Les Labels et cie
	for cards in uialter.get_children():
		if cards.name != "Label":
			cards.visible = false
			
	if gameState.numberBuildings["tent"] == 6:
		building2.visible = true
		labelQuest.text = "Exercice 2 : build 3 adult dungeons"
		
	if gameState.numberBuildings["dungeon"] == 3:
		building3.visible = true
		labelQuest.text = "Exercice 3 : build 3 temples"
		
	if gameState.numberBuildings["temple"] == 3:
		building4.visible = true
		labelQuest.text = "Exercice 4 : build 2 concert halls"
		
	if gameState.numberBuildings["concert"] == 2:
		building5.visible = true
		labelQuest.text = "Exercice 5 : build 1 quidditch stadium !"
	postapoSong.stop()
	fantasySong.play()
	
func _physics_process(delta):
	if visible:
		gameState.selectedBuilding = 100


		
	pass