extends CharacterBody2D

## escrever ":" define o tipo da variável, pode usar := pra definir o tipo e valor ao mesmo tempo tbm
@export var ia_ID := 0 ##permite usar um único script para o input de todos os jogadores
@export var iaMoveDelay := 0.8
@export var smartChance := 1.0 # 0.0 = totalmente aleatório, 1.0 = sempre persegue
var player := "res://scenes/entities/players/basePlayer.tscn"

## @onready define a var na hora que o node é inicializado
@onready var animIaNode := $AnimatedSprite2D
##raycasts
@onready var raycastUp := $collisionRaycasts/up
@onready var raycastDown := $collisionRaycasts/down
@onready var raycastLeft := $collisionRaycasts/left
@onready var raycastRight := $collisionRaycasts/right

var isIaAlive := true
var canIaMove := true
var inputMoveDirection

func _ready() -> void:
	inputMoveDirection = _randomDirection() # escolhe uma direção inicial aleatória

func _physics_process(delta: float) -> void:## roda a cada frame de física
	## checha input e se o raycast ta colidindo pra poder andar
	if isIaAlive and canIaMove:
		_decideDirection()
		if inputMoveDirection != Vector2(0, 0):
			_playAnim()
			
	if inputMoveDirection == Vector2(0, 0) and canIaMove and isIaAlive:
		animIaNode.stop()

# -------------------------------------------------------
# Lógica de decisão
# -------------------------------------------------------
func _decideDirection() -> void:
	var rayForDir = _raycastFor(inputMoveDirection)

	# se a direção atual está livre, continua nela
	if rayForDir and not rayForDir.is_colliding():
		return

	# bateu em algo — escolhe nova direção
	inputMoveDirection = _chooseNewDirection()
	var rayNew = _raycastFor(inputMoveDirection)
	if rayNew and not rayNew.is_colliding():
		return

func _chooseNewDirection() -> Vector2:
	# com smartChance de probabilidade, tenta se aproximar do jogador
	if player and randf() < smartChance:
		var preferred = _directionTowardsTarget()
		var ray = _raycastFor(preferred)
		if ray and not ray.is_colliding():
			return preferred

	# caso contrário, escolhe aleatório entre as direções livres
	var free = _freeDirections()
	if free.is_empty():
		return inputMoveDirection # preso, mantém
	free.shuffle()
	return free[0]

func _directionTowardsTarget() -> Vector2:
	var diff: Vector2 = player.position - position # prefere o eixo com maior diferença
	if abs(diff.x) >= abs(diff.y):
		return Vector2(sign(diff.x), 0)
	else:
		return Vector2(0, sign(diff.y))

func _freeDirections() -> Array:
	var dirs := [Vector2(0,-1), Vector2(0,1), Vector2(-1,0), Vector2(1,0)]
	var result := []
	for d in dirs:
		var ray = _raycastFor(d)
		if ray and not ray.is_colliding():
			result.append(d)
	return result

func _randomDirection() -> Vector2:
	var dirs := [Vector2(0,-1), Vector2(0,1), Vector2(-1,0), Vector2(1,0)]
	dirs.shuffle()
	return dirs[0]

func _raycastFor(dir: Vector2):
	if dir == Vector2(0, -1): return raycastUp
	if dir == Vector2(0,  1): return raycastDown
	if dir == Vector2(-1, 0): return raycastLeft
	if dir == Vector2(1,  0): return raycastRight
	return null

func _playAnim() -> void:
	if inputMoveDirection == Vector2(0, -1): animIaNode.play("up")
	elif inputMoveDirection == Vector2(0,  1): animIaNode.play("down")
	elif inputMoveDirection == Vector2(-1, 0): animIaNode.play("left")
	elif inputMoveDirection == Vector2(1,  0): animIaNode.play("right")
	if inputMoveDirection:
		if canIaMove:
			canIaMove = false
			var moveTween = create_tween()
			moveTween.tween_property(self, "position", position + inputMoveDirection * 16, iaMoveDelay)
			await get_tree().create_timer(iaMoveDelay).timeout
			
			canIaMove = true
			
func killIa():
	isIaAlive = false
	animIaNode.play("die")
		
	await animIaNode.animation_finished
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "ExplosionArea":
		killIa()
