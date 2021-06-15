extends TileMap
onready var gameState = get_node("/root/gameState")
onready var counterTurn = get_node("../counterTurn")
onready var mapOnTopAlter = get_node("../mapOnTopAlter")
onready var uialter = get_node("../UIalter")
onready var buildSound = get_node("../buildSound")
onready var destroySound = get_node("../destroySound")

var gridCoordinates = [0,0]

func _ready():
#	yield(get_tree().create_timer(4.0), "timeout")
#	print(GameState.gameMap[2][3])
	pass
	
func _unhandled_input(event):
	if Input.is_action_just_released("ui_click") and gameState.selectedBuilding != 100:
		var mousePosition = event.position
		var preGridCoordinates = (world_to_map(mousePosition))
		gridCoordinates = Vector2(world_to_map(mousePosition).y, world_to_map(mousePosition).x - 5)
		if gridCoordinates.x > 0 and gridCoordinates.x < 9 and gridCoordinates.y > 0 and gridCoordinates.y < 9:
			if gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1] == 99 and gameState.selectedBuilding != 99:
				if isMoveLegal(gameState.selectedBuilding):
					countOtherTiles(gameState.selectedBuilding)
					set_cellv(preGridCoordinates,gameState.selectedBuilding)
					mapOnTopAlter.set_cellv(preGridCoordinates,gameState.selectedBuilding)
					addScore(gameState.selectedBuilding)
					print("Cellule changée : " + String(gridCoordinates) + "Et le bâtiment sélectionné est :" + String(gameState.selectedBuilding))
				else:
					print("Move non possible pour " + String(gridCoordinates))
			elif gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1] != 99 and gameState.selectedBuilding == 99:
				deleteBuilding(gridCoordinates)
			else:
				print("Cellule déja prise : " + String(gridCoordinates) + "Et le bâtiment sélectionné est :" + String(gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1]))
		else:
			print("Cellule touchée : Aucune ! "  + "Et le bâtiment sélectionné est :" + String(gameState.selectedBuilding))
	
func countOtherTiles(number) :#On ajoute les cases en plus de la case primaire pour empêcher de créer par dessus
	gameState.turns["phase"] += 1
	adjustTurn()
	match number:
		2:
			gameState.gameMap[gridCoordinates.x-1][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.listConstruction.append([gridCoordinates.x,gridCoordinates.y]) #On stocke les ensembles de bâtiments pour la suppresion
			showBuiltLastTurn(0)
			gameState.numberBuildings["tent"] += 1
			buildSound.play()
		3:
			gameState.gameMap[gridCoordinates.x-1][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x-1][gridCoordinates.y] = gameState.selectedBuilding
			gameState.listConstruction.append([[gridCoordinates.x,gridCoordinates.y],[gridCoordinates.x,gridCoordinates.y+1]]) #On stocke les ensembles de bâtiments pour la suppresion
			showBuiltLastTurn(3)
			gameState.numberBuildings["dungeon"] += 1
			buildSound.play()
		4: 
			gameState.gameMap[gridCoordinates.x-1][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y+1] = gameState.selectedBuilding
			gameState.listConstruction.append([\
			[gridCoordinates.x,gridCoordinates.y],\
			[gridCoordinates.x,gridCoordinates.y+1],\
			[gridCoordinates.x+1,gridCoordinates.y+1],\
			[gridCoordinates.x+1,gridCoordinates.y+2]\
			])
			showBuiltLastTurn(6)
			gameState.numberBuildings["temple"] += 1
			buildSound.play()
			
		5: 
			gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y+1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y+1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y+1] = gameState.selectedBuilding
			gameState.listConstruction.append([\
			[gridCoordinates.x,gridCoordinates.y],\
			[gridCoordinates.x,gridCoordinates.y+1],\
			[gridCoordinates.x,gridCoordinates.y+2],\
			[gridCoordinates.x+1,gridCoordinates.y],\
			[gridCoordinates.x+1,gridCoordinates.y+1],\
			[gridCoordinates.x+1,gridCoordinates.y+2],\
			[gridCoordinates.x+2,gridCoordinates.y],\
			[gridCoordinates.x+2,gridCoordinates.y+1],\
			[gridCoordinates.x+2,gridCoordinates.y+2]\
			])
			showBuiltLastTurn(9)
			gameState.numberBuildings["concert"] += 1
			buildSound.play()
			
		6: #El Big Boss
			gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y+1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y+2] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y+1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x][gridCoordinates.y+2] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y+1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y+2] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 2][gridCoordinates.y-1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 2][gridCoordinates.y] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 2][gridCoordinates.y+1] = gameState.selectedBuilding
			gameState.gameMap[gridCoordinates.x + 2][gridCoordinates.y+2] = gameState.selectedBuilding
			gameState.listConstruction.append([\
			[gridCoordinates.x,gridCoordinates.y],\
			[gridCoordinates.x,gridCoordinates.y+1],\
			[gridCoordinates.x,gridCoordinates.y+2],\
			[gridCoordinates.x,gridCoordinates.y+3],\
			[gridCoordinates.x+1,gridCoordinates.y],\
			[gridCoordinates.x+1,gridCoordinates.y+1],\
			[gridCoordinates.x+1,gridCoordinates.y+2],\
			[gridCoordinates.x+1,gridCoordinates.y+3],\
			[gridCoordinates.x+2,gridCoordinates.y],\
			[gridCoordinates.x+2,gridCoordinates.y+1],\
			[gridCoordinates.x+2,gridCoordinates.y+2],\
			[gridCoordinates.x+2,gridCoordinates.y+3],\
			[gridCoordinates.x+3,gridCoordinates.y],\
			[gridCoordinates.x+3,gridCoordinates.y+1],\
			[gridCoordinates.x+3,gridCoordinates.y+2],\
			[gridCoordinates.x+3,gridCoordinates.y+3]\
			])
			showBuiltLastTurn(12)
			gameState.numberBuildings["oasis"] += 1
			buildSound.play()
			
	print(gameState.numberBuildings)
			
			
func isMoveLegal(number):
	if !gameState.turns["mustSwitch"]:
		match number:
			3: #Le petit bloc en 1-1, la ligne dessous est OK
				return gridCoordinates.y != 8 \
				and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1] == 99 \
				and gameState.gameMap[gridCoordinates.x -1][gridCoordinates.y] == 99 \
				
			4: #LE tetris Block
				return gridCoordinates.y < 7 \
				and  gridCoordinates.x != 8 \
				and gameState.gameMap[gridCoordinates.x-1][gridCoordinates.y-1] == 99 \
				and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y] == 99 \
				and gameState.gameMap[gridCoordinates.x][gridCoordinates.y] == 99 \
				and gameState.gameMap[gridCoordinates.x][gridCoordinates.y+1] == 99 \
				
			5: #LE 3 * 3
				return gridCoordinates.y < 7 \
				and  gridCoordinates.x < 7 \
				and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1] == 99 \
				and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y] == 99 \
				and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y+1] == 99 \
				and gameState.gameMap[gridCoordinates.x][gridCoordinates.y-1] == 99 \
				and gameState.gameMap[gridCoordinates.x][gridCoordinates.y] == 99 \
				and gameState.gameMap[gridCoordinates.x][gridCoordinates.y+1] == 99 \
				and gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y-1] == 99 \
				and gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y] == 99 \
				and gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y+1] == 99 \
				
			6: 
				return gridCoordinates.y < 6 \
				and  gridCoordinates.x < 6 \
				and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y-1] == 99\
				and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y] == 99\
				and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y+1] == 99\
				and gameState.gameMap[gridCoordinates.x - 1][gridCoordinates.y+2] == 99\
				and gameState.gameMap[gridCoordinates.x][gridCoordinates.y-1] == 99\
				and gameState.gameMap[gridCoordinates.x][gridCoordinates.y] == 99\
				and gameState.gameMap[gridCoordinates.x][gridCoordinates.y+1] == 99\
				and gameState.gameMap[gridCoordinates.x][gridCoordinates.y+2] == 99\
				and gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y-1] == 99\
				and gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y] == 99\
				and gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y+1] == 99\
				and gameState.gameMap[gridCoordinates.x + 1][gridCoordinates.y+2] == 99\
				and gameState.gameMap[gridCoordinates.x + 2][gridCoordinates.y-1] == 99\
				and gameState.gameMap[gridCoordinates.x + 2][gridCoordinates.y] == 99\
				and gameState.gameMap[gridCoordinates.x + 2][gridCoordinates.y+1] == 99\
				and gameState.gameMap[gridCoordinates.x + 2][gridCoordinates.y+2] == 99\
				
			_:
				return true
	else:
		return false
	
func adjustTurn():
	match gameState.turns["phase"]:
		#CHECKER COMMENT QUE LE TOUR EST MONTÉ ? PEUT ETRE UNE FONCTION ICI QUI REMONTE AVEC CHAQUE CLICK
		0:
			counterTurn.get_child(0).get_child(0).visible = false
			counterTurn.get_child(1).get_child(0).visible = false
			counterTurn.get_child(2).get_child(0).visible = false
		1:
			counterTurn.get_child(0).get_child(0).visible = true
			counterTurn.get_child(1).get_child(0).visible = false
			counterTurn.get_child(2).get_child(0).visible = false
		2:
			counterTurn.get_child(0).get_child(0).visible = true
			counterTurn.get_child(1).get_child(0).visible = true
			counterTurn.get_child(2).get_child(0).visible = false
		3:
			counterTurn.get_child(0).get_child(0).visible = true
			counterTurn.get_child(1).get_child(0).visible = true
			counterTurn.get_child(2).get_child(0).visible = true


func addScore(number):
	match number:
		2:
			gameState.score["magicFaith"] += 2
			gameState.score["magicPop"] -= 1
			gameState.score["postapoPop"] += 2
			gameState.score["postapoHap"] -= 1
		3:
			gameState.score["magicPop"] += 3
			gameState.score["magicHap"] -= 2
			gameState.score["postapoHap"] += 3
			gameState.score["postapoFaith"] -= 2
		4:
			gameState.score["magicHap"] += 4
			gameState.score["magicFaith"] -= 6
			gameState.score["postapoFaith"] += 4
			gameState.score["postapoPop"] -= 6
		5:
			gameState.score["magicFaith"] += 5
			gameState.score["magicPop"] -= 4
			gameState.score["postapoPop"] += 5
			gameState.score["postapoHap"] -= 4
		6:
			gameState.score["magicPop"] += 15
			gameState.score["magicHap"] -= 14
			gameState.score["postapoHap"] += 15
			gameState.score["postapoFaith"] -= 14

func reduceScore(buildingSize):
	match buildingSize:
		1:
			gameState.score["magicFaith"] -= 2
			gameState.score["magicPop"] += 1
			gameState.score["postapoPop"] -= 2
			gameState.score["postapoHap"] += 1
		2:
			gameState.score["magicPop"] -= 3
			gameState.score["magicHap"] += 2
			gameState.score["postapoHap"] -= 3
			gameState.score["postapoFaith"] += 2
		4:
			gameState.score["magicHap"] -= 4
			gameState.score["magicFaith"] += 6
			gameState.score["postapoFaith"] -= 4
			gameState.score["postapoPop"] += 6
		9:
			gameState.score["magicFaith"] -= 5
			gameState.score["magicPop"] += 4
			gameState.score["postapoPop"] -= 5
			gameState.score["postapoHap"] += 4
		16:
			gameState.score["magicPop"] -= 15
			gameState.score["magicHap"] += 14
			gameState.score["postapoHap"] -= 15
			gameState.score["postapoFaith"] += 14

func deleteBuilding(position):
	if !gameState.turns["mustSwitch"]:
		gameState.turns["phase"] += 1
		adjustTurn()
		destroySound.play()
		for building in gameState.listConstruction:
			if building == [position.x,position.y] or building.has([position.x,position.y]):
				if typeof(building[0]) == 3: #ARRAY ENUM ASKIP
					reduceScore(1)
					gameState.gameMap[building[0]-1][building[1]-1] = 99
					var preGridCoordinates = Vector2(position.y + 5, position.x)
					set_cellv(preGridCoordinates,-1)
					mapOnTopAlter.set_cellv(preGridCoordinates,-1)
					gameState.listConstruction.erase(building)
				else :
					reduceScore(building.size())
					for cell in building:
						gameState.gameMap[cell[0]-1][cell[1]-1] = 99
						var preGridCoordinates = Vector2(building[0][1] + 5, building[0][0]) #Tu as inversé comme ligne 67 le y et le x
						set_cellv(preGridCoordinates,-1)
						mapOnTopAlter.set_cellv(preGridCoordinates,-1)
						gameState.listConstruction.erase(building)

func showBuiltLastTurn(number):
	if uialter.get_child(number + 1).visible and uialter.get_child(number + 2).visible and not uialter.get_child(number + 3).visible:
		uialter.get_child(number + 3).visible = true
	elif uialter.get_child(number + 1).visible and not uialter.get_child(number + 2).visible and not uialter.get_child(number + 3).visible:
		uialter.get_child(number + 2).visible = true
	elif not uialter.get_child(number + 1).visible and not uialter.get_child(number + 2).visible and not uialter.get_child(number + 3).visible:
		uialter.get_child(number + 1).visible = true

func _physics_process(delta):
	pass