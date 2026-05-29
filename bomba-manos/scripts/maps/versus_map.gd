extends Node2D

@onready var bombaSfx := $bombaSfx

#@onready var playerNodes := $entities/players

@onready var spawnPoints : Array[Node2D] = [
	$player1Pos,
	$player2Pos,
	$player3Pos,
	$player4Pos
]

var playerScene := preload(
	"res://scenes/entities/players/mpPlayer.tscn"
)
	
func _ready() -> void:
	VersusScoreManager.setupPlayers()
	spawnAllPlayers()
	$VersusScoreUI.createUiElements()
	$Control/AnimationPlayer.play("begin")

func _process(delta: float) -> void:
	if GlobalScript.triggerBombaSfx:
		bombaSfx.play()
		GlobalScript.triggerBombaSfx = false

func spawnPlayer(setId, setCharacter):
	if setId <= 0 or setId > spawnPoints.size():
		print("erro - invalid player id: ", setId)
		return

	var playerInstance = playerScene.instantiate()
	playerInstance.playerId = setId
	playerInstance.charSkin = VersusMatchSettings.characterList[setCharacter]["spriteFrames"]
	playerInstance.global_position = spawnPoints[setId - 1].global_position
	get_tree().current_scene.call_deferred("add_child", playerInstance)

func spawnAllPlayers():
	if VersusMatchSettings.playerCount >= 1:
		spawnPlayer(1, VersusMatchSettings.p1Char)
	if VersusMatchSettings.playerCount >= 2:
		spawnPlayer(2, VersusMatchSettings.p2Char)
	if VersusMatchSettings.playerCount >= 3:
		spawnPlayer(3, VersusMatchSettings.p3Char)
	if VersusMatchSettings.playerCount >= 4:
		spawnPlayer(4, VersusMatchSettings.p4Char)
