extends Node

var manelBombasCount := 0

var triggerLaugh := false
var triggerCameraShake := false
var triggerBombaSfx := false

var currentPlayers := 0

var MANEL_WINS := false
var checkIfAreAllDead := true

var selectedPlayer1 #: CharacterBody2D
var selectedPlayer2 #: CharacterBody2D


##Manel, Missia, Igão, Ureia, Anão
var playerScores := [0, 0, 0, 0, 0]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		restartLevel()
	
	if currentPlayers == 0 and checkIfAreAllDead == true and manelBombasCount != 0:
		print("all dead")
		checkIfAreAllDead = false
		MANEL_WINS = true
		print("manel wins")

func restartLevel():
	currentPlayers = 0
	manelBombasCount = 0
	triggerLaugh = false
	triggerCameraShake = false
	currentPlayers = 0
	MANEL_WINS = false
	checkIfAreAllDead = true
	get_tree().reload_current_scene()
	
func addPoint2Player(idNum):
	playerScores[idNum] += 1
	print(playerScores)
	
func removePointFromPlayer(idNum):
	playerScores[idNum] -= 1
	print(playerScores)
