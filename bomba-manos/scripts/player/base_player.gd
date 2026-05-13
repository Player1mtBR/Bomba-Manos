extends CharacterBody2D

## escrever ":" define o tipo da variável, pode usar := pra definir o tipo e valor ao mesmo tempo tbm
@export var playerID := 0 ##permite usar um único script para o input de todos os jogadores
@export var isPlayerOnMenu := false
@export var charSkin := SpriteFrames #test

## @onready define a var na hora que o node é inicializado
@onready var placeBombaNode := $PlaceBomba ##coloca a referência ao node "$" em uma variável
@onready var animPlayerNode := $AnimatedSprite2D
##raycasts
@onready var raycastUp := $collisionRaycasts/up
@onready var raycastDown := $collisionRaycasts/down
@onready var raycastLeft := $collisionRaycasts/left
@onready var raycastRight := $collisionRaycasts/right

var isPlayerAlive := true
var wonMatch := false

var canPlayerMove := true
var playerMoveDelay := 0.3

var maxBombasAtOnce := 2
var placedBombas := 0
var passos := 0 

var inputMoveDirection

var playerDirection : Vector2 ##utiliza vetor (x, y) para definir a direção que o jogador se move

func _ready() -> void:
	animPlayerNode.sprite_frames = charSkin
	if isPlayerOnMenu == false:
		#playerID = GlobalScript.selectedPlayer1
		#GlobalScript.currentPlayers += 1               ###remove comment
		print(GlobalScript.currentPlayers)
		#if playerID != GlobalScript.selectedPlayer1 and playerID != GlobalScript.selectedPlayer2:
		#	queue_free()
	
func _process(delta: float) -> void:
	#if GlobalScript.currentPlayers == 1 and canPlayerMove == true and isPlayerAlive == true:
	#	victory()
	
	if Input.is_action_just_pressed("p"+str(playerID)+"_bomb") and placedBombas < maxBombasAtOnce and wonMatch == false and isPlayerAlive == true and isPlayerOnMenu == false:
		placeBombaNode.placeBombOnMap(1, playerID) ##puxa a funcao que está no node
		placedBombas += 1
		#GlobalScript.manelBombasCount += 1 ##contador Manel ###REMOVE COMMENT FOR MULTIPLAYER
		#print("placed bombas: ", placedBombas)
		await get_tree().create_timer(3.0).timeout ## cria um novo timer e aguarda o sinal de quando acaba o timer
		placedBombas -= 1
		
	if Input.is_action_just_pressed("p"+str(playerID)+"_bomb") and placedBombas < maxBombasAtOnce and wonMatch == false and isPlayerAlive == true and isPlayerOnMenu == false:
		placeBombaNode.placeBombOnMap(1, playerID) ##puxa a funcao que está no node
		placedBombas += 1
		#GlobalScript.manelBombasCount += 1 ##contador Manel ###REMOVE COMMENT FOR MULTIPLAYER
		#print("placed bombas: ", placedBombas)
		await get_tree().create_timer(3.0).timeout ## cria um novo timer e aguarda o sinal de quando acaba o timer
		placedBombas -= 1
		

func getPlayerPassos():
	return passos

func _physics_process(delta: float) -> void:## roda a cada frame de física
	inputMoveDirection = Vector2(0, 0) ##qual direcao e pra andar
	
	## checha input e se o raycast ta colidindo pra poder andar
	if isPlayerAlive == true and canPlayerMove == true:
		#print(raycastUp.get_collider())
		if Input.is_action_pressed("p"+str(playerID)+"_moveUp") and raycastUp.is_colliding() == false:
			inputMoveDirection = Vector2(0, -1)
			movePlayer()
			animPlayerNode.play("move_up")
			
		elif Input.is_action_pressed("p"+str(playerID)+"_moveDown") and raycastDown.is_colliding() == false:
			inputMoveDirection = Vector2(0, 1)
			movePlayer()
			animPlayerNode.play("move_down")
			
		elif Input.is_action_pressed("p"+str(playerID)+"_moveLeft") and raycastLeft.is_colliding() == false:
			inputMoveDirection = Vector2(-1, 0)
			movePlayer()
			animPlayerNode.play("move_left")
			
		elif Input.is_action_pressed("p"+str(playerID)+"_moveRight") and raycastRight.is_colliding() == false:
			inputMoveDirection = Vector2(1, 0)
			movePlayer()
			animPlayerNode.play("move_right")
			
	##kill anim test
	#if Input.is_action_just_pressed("p1_kill"):
	#	killPlayer()
	
	if inputMoveDirection == Vector2(0, 0) and canPlayerMove and isPlayerAlive and isPlayerOnMenu == false:
		animPlayerNode.stop()
	
	if isPlayerOnMenu:
		animPlayerNode.play("rotate")

func movePlayer(): ##tween vai levar de um valor a outro de forma gradual
	if inputMoveDirection and isPlayerOnMenu == false:
		if canPlayerMove:
			canPlayerMove = false
			var moveTween = create_tween()
			moveTween.tween_property(self, "position", position + inputMoveDirection * 16, playerMoveDelay)
			await get_tree().create_timer(playerMoveDelay).timeout
			passos += 1
			canPlayerMove = true
			
func killPlayer():
	GlobalScript.currentPlayers -= 1
	if GlobalScript.currentPlayers > 1:
		GlobalScript.triggerLaugh = true
	isPlayerAlive = false
	animPlayerNode.play("die")
	
	if wonMatch == true:
		GlobalScript.removePointFromPlayer(playerID)
		print(GlobalScript.playerScores)
		
	await animPlayerNode.animation_finished
	queue_free()
	
func victory():
	canPlayerMove = false
	wonMatch = true
	print(playerID, "victory")
	GlobalScript.addPoint2Player(playerID)
	#isPlayerAlive = false
	animPlayerNode.play("win")
	
	await get_tree().create_timer(4.0).timeout
	if isPlayerAlive == true:
		queue_free()
		
		GlobalScript.restartLevel()
	#else:
	#	GlobalScript.removePointFromPlayer(playerID)
	#	print(GlobalScript.playerScores)

@export var teleportTunel: Node2D  
@export var teleportTunel2: Node2D
func teleport(id_tunel: int) -> void:
	var destino
	if id_tunel == 1:
		destino = teleportTunel2
		#await get_tree().create_timer(0.5).timeout
	elif id_tunel == 2:
		destino = teleportTunel
		#await get_tree().create_timer(0.5).timeout
	canPlayerMove = false
	global_position = destino.global_position
	await get_tree().create_timer(0.1).timeout
	canPlayerMove = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "ExplosionArea":
		killPlayer()
		
	if area.name == "Mob":
		killPlayer()

	if area.name == "teleportTunel":
		teleport(1)
	elif area.name == "teleportTunel2":
		teleport(2)


	
