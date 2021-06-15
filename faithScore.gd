extends Label
onready var gameState = get_node("/root/gameState")

func _ready():
	pass

func _physics_process(delta):
	if get_parent().name == 'counterScore':
		text = String(gameState.score["magicFaith"])
	else :
		text = String(gameState.score["postapoFaith"])