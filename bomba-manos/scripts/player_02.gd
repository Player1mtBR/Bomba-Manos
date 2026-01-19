extends CharacterBody2D
"""
**************************
NÃO UTILIZAR, SCRIPT SERÁ RECRIADO A PARTIR DO PLAYER1 QUANDO FOR FINALIZADO
**************************
"""

## escrever ":" define o tipo da variável, pode usar := pra definir o tipo e valor ao mesmo tempo tbm
@export var playerMoveSpeed := 50

## @onready define a var na hora que o node é inicializado
@onready var placeBombaNode := $PlaceBomba ##coloca a referência ao node "$" em uma variável
@onready var animPlayerNode := $AnimatedSprite2D

var isPlayerAlive := true
var maxBombasAtOnce := 2
var placedBombas := 0

var playerDirection : Vector2 ##utiliza vetor (x, y) para definir a direção que o jogador se move
#var playerVelocity : Vector2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p2_bomb") and placedBombas < maxBombasAtOnce:
		placeBombaNode.placeBombOnMap() ##puxa a funcao que está no node
		print("placed bombas: ", placedBombas)
		placedBombas += 1
		await get_tree().create_timer(3.0).timeout ## cria um novo timer e aguarda o sinal de quando acaba o timer
		placedBombas -= 1

func _physics_process(delta: float) -> void:## roda a cada frame de física
	
	##get_axis define um valor negativo e positivo pra ação
	playerDirection.x = Input.get_axis("p2_moveLeft", "p2_moveRight")
	playerDirection.y = Input.get_axis("p2_moveUp", "p2_moveDown")
	
	##fix pro movimento diagonal
	playerDirection = playerDirection.normalized()
	
	##checa se tem o input de movimento
	if playerDirection and isPlayerAlive:
		##velocity vai usar o valor da playerDirection e multiplicar pela moveSpeed
		velocity = playerDirection * playerMoveSpeed ##velocity é alterada a cada chamada do move_and_slide
		
	else:
		##desacelerar pra 0 quando não tiver movimento
		velocity = velocity.move_toward(Vector2.ZERO, playerMoveSpeed)
		if isPlayerAlive:
			animPlayerNode.stop()
		
	
	if Input.is_action_just_pressed("p2_kill"):
		killPlayer()
	
	#input up - down -left - right
	
	##usable for anim test
	if isPlayerAlive:
		if Input.is_action_pressed("p2_moveUp"):
			animPlayerNode.play("move_up")
			#self.global_position.y -= moveSpeed * delta
		elif Input.is_action_pressed("p2_moveDown"):
			animPlayerNode.play("move_down")
			#self.global_position.y += moveSpeed * delta
		elif Input.is_action_pressed("p2_moveLeft"):
			animPlayerNode.play("move_left")
			#self.global_position.x -= moveSpeed * delta
		elif Input.is_action_pressed("p2_moveRight"):
			animPlayerNode.play("move_right")
			#self.global_position.x += moveSpeed * delta
	
	
	move_and_slide() ##built-in function that handles movement, some collisions etc
	
func killPlayer():
	isPlayerAlive = false
	animPlayerNode.play("die")
