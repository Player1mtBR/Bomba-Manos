extends Node2D

@onready var bombaSfx := $bombaSfx

@onready var playerNodes := $entities/players

@onready var spawnPoints : Array[Node2D] = [
	$player1Pos,
	$player2Pos,
	$player3Pos,
	$player4Pos
]

var playerScene := preload("res://scenes/entities/players/mpPlayer.tscn")


func _ready() -> void:
	print(spawnPoints)
	spawnAllPlayers()

func spawnPlayer(setId, setCharacter):
	print(setId)
	if setId <= 0 or setId > spawnPoints.size():
		print("invalid player id: ", setId)
	
	var playerInstance = playerScene.instantiate()
	
	playerInstance.playerID = setId
	playerInstance.charSkin = setCharacter
	playerInstance.position = spawnPoints[setId - 1].global_position
	$players.add_child(playerInstance)
	
func spawnAllPlayers(): #FINALLY 
	if VersusMatchSettings.playerCount >= 1:
		spawnPlayer(1, VersusMatchSettings.p1Char)
		
	if VersusMatchSettings.playerCount >= 2:
		spawnPlayer(2, VersusMatchSettings.p2Char)
		
	if VersusMatchSettings.playerCount >= 3:
		spawnPlayer(3, VersusMatchSettings.p3Char)
		
	if VersusMatchSettings.playerCount == 4:
		spawnPlayer(4, VersusMatchSettings.p4Char)
		

func _process(delta: float) -> void:
	if GlobalScript.triggerBombaSfx == true:
		bombaSfx.play()
		GlobalScript.triggerBombaSfx = false
