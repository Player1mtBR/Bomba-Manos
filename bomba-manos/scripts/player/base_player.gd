extends CharacterBody2D

## escrever ":" define o tipo da variável, pode usar := pra definir o tipo e valor ao mesmo tempo tbm
@export var playerID := 0 ##permite usar um único script para o input de todos os jogadores
@export var isPlayerOnMenu := false
@export var charSkin := SpriteFrames
@export var DieSound := AudioStreamMP3 #test

@export var bombaEX := 1 #01 NORMAL - 02 MESSIAS - 03 MASCARA 04 - FANTASMA - 05 REMOTO

## @onready define a var na hora que o node é inicializado
@onready var placeBombaNode := $PlaceBomba ##coloca a referência ao node "$" em uma variável
@onready var animPlayerNode := $AnimatedSprite2D
##raycasts
@onready var raycastUp := $collisionRaycasts/up
@onready var raycastDown := $collisionRaycasts/down
@onready var raycastLeft := $collisionRaycasts/left
@onready var raycastRight := $collisionRaycasts/right
@onready var Diesom := $DIE

var isPlayerAlive := true
var wonMatch := false

var canPlayerMove := true
var playerMoveDelay := 0.3

@export var maxBombasAtOnce := 2
var placedBombas := 0
var passos := 0 

var equippedBomb := 1

var inputMoveDirection

var playerDirection : Vector2 ##utiliza vetor (x, y) para definir a direção que o jogador se move

#for IDDQD
var movespeed := 100

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
	
	if Input.is_action_just_pressed("p"+str(playerID)+"_bomb") and placedBombas < maxBombasAtOnce and isPlayerAlive == true and CurrentLevelManager.levelComplete == false:
		placeBombaNode.placeBombOnMap(equippedBomb, playerID) ##puxa a funcao que está no node
		if equippedBomb == 1:
			placedBombas += 1
			#GlobalScript.manelBombasCount += 1 ##contador Manel ###REMOVE COMMENT FOR MULTIPLAYER
			#print("placed bombas: ", placedBombas)
			await get_tree().create_timer(3.0, false).timeout ## cria um novo timer e aguarda o sinal de quando acaba o timer
			placedBombas -= 1
			
		if equippedBomb == 5: #remote bomba
			placedBombas += 1
	if Input.is_action_pressed("p1_bomb") and placedBombas == 2:
		if $remoteBombResetTimer.is_stopped():
			$remoteBombResetTimer.start()
			print("timer started")

	if Input.is_action_just_released("p1_bomb"):
		$remoteBombResetTimer.stop()
		print("timer stopped")

	#if Input.is_action_just_pressed("p"+str(playerID)+"_bomb") and placedBombas < maxBombasAtOnce and isPlayerAlive == true:
	#	placeBombaNode.placeBombOnMap(equippedBomb, playerID) ##puxa a funcao que está no node
	#	placedBombas += 1
	#	#GlobalScript.manelBombasCount += 1 ##contador Manel ###REMOVE COMMENT FOR MULTIPLAYER
	#	#print("placed bombas: ", placedBombas)
	#	await get_tree().create_timer(3.0, false).timeout ## cria um novo timer e aguarda o sinal de quando acaba o timer
	#	placedBombas -= 1
	
	if Input.is_action_just_pressed("p"+str(playerID)+"_swap_bomb"):
		if equippedBomb == 1:
			equippedBomb = bombaEX
		elif equippedBomb == bombaEX:
			equippedBomb = 1
			
		print("Equipped bomb: ",equippedBomb)
		
	if Input.is_action_just_released("p1_bomb") and placedBombas <= 1:
		$remoteBombResetTimer.stop()
		

func getPlayerPassos():
	return passos

func _physics_process(delta: float) -> void:## roda a cada frame de física
	inputMoveDirection = Vector2(0, 0) ##qual direcao e pra andar
	
	## checha input e se o raycast ta colidindo pra poder andar
	if isPlayerAlive == true and canPlayerMove == true and UnlockStuff.iddqd == false:
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
	
	if inputMoveDirection == Vector2(0, 0) and canPlayerMove and isPlayerAlive:
		animPlayerNode.stop()
	
	if isPlayerOnMenu:
		animPlayerNode.play("rotate")
		
		
	#IDDQD movement
	if UnlockStuff.iddqd == true:
		var direction = Input.get_vector("p1_moveLeft", "p1_moveRight", "p1_moveUp", "p1_moveDown")
		velocity = (direction * movespeed)
		move_and_slide()

func movePlayer(): ##tween vai levar de um valor a outro de forma gradual
	if inputMoveDirection:
		if canPlayerMove:
			canPlayerMove = false
			var moveTween = create_tween()
			moveTween.tween_property(self, "position", position + inputMoveDirection * 16, playerMoveDelay)
			await get_tree().create_timer(playerMoveDelay, false).timeout
			passos += 1
			canPlayerMove = true
			
func killPlayer():
	CurrentLevelManager.deathCount += 1
	GlobalScript.currentPlayers -= 1
	if GlobalScript.currentPlayers > 1:
		GlobalScript.triggerLaugh = true
	isPlayerAlive = false
	Diesom.play()
	animPlayerNode.play("die")
	
	
	if wonMatch == true:
		GlobalScript.removePointFromPlayer(playerID)
		print(GlobalScript.playerScores)
		
	await animPlayerNode.animation_finished
	if CurrentLevelManager.campaignMap == true:
		CurrentLevelManager.restartLevel()
	queue_free()
	
func victory():
	canPlayerMove = false
	wonMatch = true
	print(playerID, "victory")
	GlobalScript.addPoint2Player(playerID)
	#isPlayerAlive = false
	animPlayerNode.play("win")
	
	await get_tree().create_timer(4.0, false).timeout
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
		#await get_tree().create_timer(0.5, false).timeout
	elif id_tunel == 2:
		destino = teleportTunel
		#await get_tree().create_timer(0.5, false).timeout
	canPlayerMove = false
	global_position = destino.global_position
	await get_tree().create_timer(0.1, false).timeout
	canPlayerMove = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "ExplosionArea" and UnlockStuff.iddqd == false:
		killPlayer()
		
	if area.name == "Mob" and UnlockStuff.iddqd == false:
		killPlayer()

	if area.name == "teleportTunel":
		teleport(1)
	elif area.name == "teleportTunel2":
		teleport(2)

func _on_remote_bomb_reset_timer_timeout() -> void:
	print("reset bombs")
	placedBombas = 0
