extends CharacterBody2D

## escrever ":" define o tipo da variável, pode usar := pra definir o tipo e valor ao mesmo tempo tbm
@export var playerId := 0 ##permite usar um único script para o input de todos os jogadores
@export var isPlayerOnMenu := false
@export var charSkin := SpriteFrames 


@export var bombaEX := 1 #01 NORMAL - 02 MESSIAS - 03 MASCARA 04 - FANTASMA - 05 REMOTO

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
var useSpawnDelay := true

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
	await get_tree().create_timer(3.0, false).timeout
	useSpawnDelay = false
	
func _process(delta: float) -> void:

	
	if Input.is_action_just_pressed("p"+str(playerId)+"_bomb") and placedBombas < maxBombasAtOnce and isPlayerAlive == true \
	 and CurrentLevelManager.levelComplete == false and wonMatch == false and useSpawnDelay == false:
		placeBombaNode.placeBombOnMap(equippedBomb, playerId) ##puxa a funcao que está no node
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

	
	if Input.is_action_just_pressed("p"+str(playerId)+"_swap_bomb"):
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
	if isPlayerAlive == true and canPlayerMove == true and UnlockStuff.iddqd == false \
	and wonMatch == false and useSpawnDelay == false:
		#print(raycastUp.get_collider())
		if Input.is_action_pressed("p"+str(playerId)+"_moveUp") and raycastUp.is_colliding() == false:
			inputMoveDirection = Vector2(0, -1)
			movePlayer()
			animPlayerNode.play("move_up")
			
		elif Input.is_action_pressed("p"+str(playerId)+"_moveDown") and raycastDown.is_colliding() == false:
			inputMoveDirection = Vector2(0, 1)
			movePlayer()
			animPlayerNode.play("move_down")
			
		elif Input.is_action_pressed("p"+str(playerId)+"_moveLeft") and raycastLeft.is_colliding() == false:
			inputMoveDirection = Vector2(-1, 0)
			movePlayer()
			animPlayerNode.play("move_left")
			
		elif Input.is_action_pressed("p"+str(playerId)+"_moveRight") and raycastRight.is_colliding() == false:
			inputMoveDirection = Vector2(1, 0)
			movePlayer()
			animPlayerNode.play("move_right")
			
	##kill anim test
	#if Input.is_action_just_pressed("p1_kill"):
	#	killPlayer()
	
	if inputMoveDirection == Vector2(0, 0) and canPlayerMove and isPlayerAlive and wonMatch == false:
		animPlayerNode.stop()
	


func movePlayer(): ##tween vai levar de um valor a outro de forma gradual
	if inputMoveDirection:
		if canPlayerMove:
			canPlayerMove = false
			var moveTween = create_tween()
			moveTween.tween_property(self, "position", position + inputMoveDirection * 16, playerMoveDelay)
			await get_tree().create_timer(playerMoveDelay, false).timeout
			passos += 1
			canPlayerMove = true
			
func killPlayer(killerId):
	animPlayerNode.play("die")
	if isPlayerAlive == true:
		isPlayerAlive = false

	VersusScoreManager.registerKill(killerId, playerId)
	VersusScoreManager.registerDeath(playerId)
	await animPlayerNode.animation_finished
	queue_free()
	
func playWinAnim():
	animPlayerNode.play("win")
	wonMatch = true

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
		pass
		#killPlayer()
		
	if area.name == "Mob" and UnlockStuff.iddqd == false:
		pass
		#killPlayer()

	if area.name == "teleportTunel":
		teleport(1)
	elif area.name == "teleportTunel2":
		teleport(2)

func _on_remote_bomb_reset_timer_timeout() -> void:
	print("reset bombs")
	placedBombas = 0
