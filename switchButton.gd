extends Button
onready var gameState = get_node("/root/gameState")
onready var counterTurn = get_node("../counterTurn")
onready var switchBackButton = get_node("../switchBackButton")
onready var ui = get_node("../UI")
onready var mapOnTop = get_node("../mapOnTop")
onready var mapOnTopAlter = get_node("../mapOnTopAlter")
onready var counterScore = get_node("../counterScore")
onready var counterScoreAlter = get_node("../counterScoreAlter")
onready var uialter = get_node("../UIalter")
onready var postapoSong = get_node("/root/World/postapoSong")
onready var fantasySong = get_node("/root/World/fantasySong")

func _ready():
	connect("pressed", self, "_button_pressed")
	pass # Replace with function body.

func _button_pressed():
	gameState.turns["phase"] = 0
	gameState.turns["turn"] += 1
	print(gameState.turns["phase"])
	print(gameState.turns["turn"])
	print( gameState.turns["mustSwitch"])
	gameState.turns["mustSwitch"] = false
	counterTurn.get_child(0).get_child(0).visible = false
	counterTurn.get_child(1).get_child(0).visible = false
	counterTurn.get_child(2).get_child(0).visible = false
	self.visible = false
	switchBackButton.visible = true
	#Maintenant ce qui saute
	ui.visible = false
	counterTurn.visible = false
	mapOnTop.visible = false
	counterScore.visible = false
	#Ce qui est visible, ne pas oublier le texte
	mapOnTopAlter.visible = true
	counterScoreAlter.visible = true
	uialter.visible = true
	postapoSong.play()
	fantasySong.stop()

func _physics_process(delta):
	
	if gameState.turns["mustSwitch"]:
		disabled = false
		for building in ui.get_children():
			building.release_focus()
	else :
		disabled = true