extends Node2D

@onready var bombaSfx := $bombaSfx
#@onready var selectedPlayer1 : CharacterBody2D
#@onready var selectedPlayer2 : CharacterBody2D
@onready var BombaMan := preload("res://scenes/entities/players/messias.tscn").instantiate()
@onready var UreiaMan := preload("res://scenes/entities/players/pedro.tscn").instantiate()
@onready var RangerMan := preload("res://scenes/entities/players/igor.tscn").instantiate()
@onready var MiniMan := preload("res://scenes/entities/players/p1mt.tscn").instantiate()

@onready var playerNodes := $players
@onready var p1Pos := $player1Pos
@onready var p2Pos := $player2Pos

func _ready() -> void:
	MusicMenu.get_child(0).stop()
	match GlobalScript.selectedPlayer1:
		1:
			spawnCharacter(1, BombaMan, p1Pos)
		2:
			spawnCharacter(1, UreiaMan, p1Pos)
		3:
			spawnCharacter(1, RangerMan, p1Pos)
		4:
			spawnCharacter(1, MiniMan, p1Pos)
	
	match GlobalScript.selectedPlayer2:
		1:
			spawnCharacter(2, BombaMan, p2Pos)
		2:
			spawnCharacter(2, UreiaMan, p2Pos)
		3:
			spawnCharacter(2, RangerMan, p2Pos)
		4:
			spawnCharacter(2, MiniMan, p2Pos)
	"""
	for character in playerNodes.get_children():## p/ seletor de personagem
		if character.playerID != GlobalScript.selectedPlayer1 and character.playerID != GlobalScript.selectedPlayer2:
			character.queue_free()
			
			
		if character.playerID == GlobalScript.selectedPlayer1:
			character.playerID = 1
			character.position = p1Pos.global_position
		
		if character.playerID == GlobalScript.selectedPlayer2:
			character.playerID = 2
			character.position = p2Pos.global_position #prestou disgramaaaaaaaaaaaaaaaa
	"""
			

func spawnCharacter(id, character, pos):
	await get_tree().create_timer(0.1).timeout
	get_tree().root.call_deferred("add_child", character)
	character.playerID = id
	character.position = pos.position

func _process(delta: float) -> void:
	if GlobalScript.triggerBombaSfx == true:
		bombaSfx.play()
		GlobalScript.triggerBombaSfx = false
