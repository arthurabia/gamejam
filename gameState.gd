extends Node2D
onready var mort = get_node("/root/World/mort")
onready var postapoSong = get_node("/root/World/postapoSong")
onready var fantasySong = get_node("/root/World/fantasySong")

export var gameMap = [
	[99, 99, 99, 99, 99, 99, 99, 99],
	[99, 99, 99, 99, 99, 99, 99, 99],
	[99, 99, 99, 99, 99, 99, 99, 99],
	[99, 99, 99, 99, 99, 99, 99, 99],
	[99, 99, 99, 99, 99, 99, 99, 99],
	[99, 99, 99, 99, 99, 99, 99, 99],
	[99, 99, 99, 99, 99, 99, 99, 99],
	[99, 99, 99, 99, 99, 99, 99, 99],
]
#La grille pour les deux mondes, les chiffres changeront pour indiquer les batiments

export var listConstruction = []
export var listConstructionSize = []
#La liste de construction pour savoir quoi supprimer

export var selectedBuilding = 100
#Va changer à chaque clic, 99 car au début ce n'est rien

export var turns = {
	"turn" : 0,
	"phase": 0,
	"mustSwitch" : false,
}

export var score ={
	"magicFaith" : 5,
	"magicPop" : 7,
	"magicHap" : 7,
	"postapoFaith" : 7,
	"postapoPop" : 5,
	"postapoHap" : 7,
}

export var numberBuildings={
	"tent":0,
	"dungeon":0,
	"temple":0,
	"concert":0,
	"oasis":0,
}
var gameOver = false

func _ready():
	fantasySong.play()
	yield(get_tree().create_timer(1.0), "timeout")
	print(mort)
	pass # Replace with function body.

func _physics_process(delta):
		
	if score.magicFaith < 1 or score.magicPop < 1 or score.magicHap < 1 or score.postapoFaith < 1 or score.postapoPop < 1 or score.postapoHap < 1 and not gameOver:
		var reason = score.keys()[score.values().find(0)]
		selectedBuilding = 100
		if reason == "magicFaith" or reason == "postapoFaith":
			reason = "Faith"
		if reason == "magicPop" or reason == "postapoPop":
			reason = "Population"
		if reason == "magicHap" or reason == "postapoHap":
			reason = "Happiness"
		get_tree().change_scene("res://scenes/lose.tscn")
	
	if numberBuildings["oasis"] == 1 :
		get_tree().change_scene("res://scenes/win.tscn")
	
	if turns["phase"] == 3:
		turns["mustSwitch"] = true
	pass
	
