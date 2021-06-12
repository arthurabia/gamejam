extends Node2D

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
#La liste de construction pour savoir quoi supprimer

export var selectedBuilding = 99
#Va changer à chaque clic, 99 car au début ce n'est rien

export var canDelete = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	pass