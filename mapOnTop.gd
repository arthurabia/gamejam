extends TileMap
onready var testText = get_node("../TextEdit")
onready var gameState = get_node("/root/gameState")
var gridCoordinates = [0,0]

func _ready():
#	yield(get_tree().create_timer(4.0), "timeout")
#	print(GameState.gameMap[2][3])
	pass
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_click"):
		var mousePosition = event.position
		var preGridCoordinates = (world_to_map(mousePosition))
		gridCoordinates = Vector2(world_to_map(mousePosition).y, world_to_map(mousePosition).x - 5)
		if gridCoordinates.x > 0 and gridCoordinates.x < 9 and gridCoordinates.y > 0 and gridCoordinates.y < 9:
			if gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1] == 99 and gameState.selectedBuilding != 99:
				if isMoveLegal(gameState.selectedBuilding):
					countOtherTiles(gameState.selectedBuilding)
					set_cellv(preGridCoordinates,gameState.selectedBuilding)
					testText.set_text("Cellule changée : " + String(gridCoordinates) + "Et le bâtiment sélectionné est :" + String(gameState.selectedBuilding))
					print(gameState.listConstruction)
				else:
					testText.set_text("Move non possible pour " + String(gridCoordinates))
			elif gameState.selectedBuilding == 99:
				deleteBuilding(gridCoordinates)
			else:
				testText.set_text("Cellule déja prise : " + String(gridCoordinates) + "Et le bâtiment sélectionné est :" + String(gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1]))
		else:
			testText.set_text("Cellule touchée : Aucune ! "  + "Et le bâtiment sélectionné est :" + String(gameState.selectedBuilding))
	
func countOtherTiles(number) :#On ajoute les cases en plus de la case primaire pour empêcher de créer par dessus
	match number:
		0:
			gameState.gameMap[gridCoordinates.x-1][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.listConstruction.append([gridCoordinates.x,gridCoordinates.y]) #On stocke les ensembles de bâtiments pour la suppresion
		1: 
			gameState.gameMap[gridCoordinates.x-1][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y] = gameState.selectedBuilding
			gameState.listConstruction.append([\
			[gridCoordinates.x,gridCoordinates.y],\
			[gridCoordinates.x,gridCoordinates.y+1],\
			[gridCoordinates.x+1,gridCoordinates.y],\
			[gridCoordinates.x+1,gridCoordinates.y+1]
			])
			
func isMoveLegal(number):
	match number:
		1:
			return gridCoordinates.x != 8 \
			and gridCoordinates.y != 8\
			and gameState.gameMap[gridCoordinates.x][gridCoordinates.y-1] == 99 \
			and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y] == 99 \
			and gameState.gameMap[gridCoordinates.x][gridCoordinates.y] == 99 \
			
		_:
			return true
	
func deleteBuilding(position):
	for building in gameState.listConstruction:
		if building == [position.x,position.y] or building.has([position.x,position.y]):
			if building.size() == 2:
				gameState.gameMap[building[0]-1][building[1]-1] = 99
				var preGridCoordinates = Vector2(position.y + 5, position.x)
				set_cellv(preGridCoordinates,-1)
			else :
				print(building[0])
				for cell in building:
					gameState.gameMap[cell[0]-1][cell[1]-1] = 99
					var preGridCoordinates = Vector2(building[0][1] + 5, building[0][0]) #Tu as inversé comme ligne 67 le y et le x
					set_cellv(preGridCoordinates,-1)
	print(gameState.gameMap)
	pass
	
func _physics_process(delta):
	pass