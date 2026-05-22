extends CharacterBody2D

@export var ia_ID := 0
@export var iaMoveDelay := 0.8
@export var smartChance := 1.0
@export var passosParaSugerir := 3

@onready var animIaNode   := $AnimatedSprite2D
@onready var raycastUp    := $collisionRaycasts/up
@onready var raycastDown  := $collisionRaycasts/down
@onready var raycastLeft  := $collisionRaycasts/left
@onready var raycastRight := $collisionRaycasts/right

var isIaAlive  := true
var canIaMove  := true
var inputMoveDirection : Vector2

var playerNode
var playerPosition    := Vector2()
var lastPassosChecked := 0

# --- controle de reavaliação ---
var passosDaIa        := 0   # quantos passos a IA já deu
var passosParaRever   := 2   # a cada X passos da IA, reavalia direção mesmo sem parede


var shouldDecrease := true
var shouldIncrease := true

func _ready() -> void:
	
	if shouldIncrease:
		shouldIncrease = false
		CurrentLevelManager.currentEnemiesAlive += 1
		print("Enemies: ", CurrentLevelManager.currentEnemiesAlive)
	
	playerNode = $"../../players/basePlayer02"
	if playerNode:
		playerPosition = playerNode.global_position
	inputMoveDirection = _randomDirection()

# -------------------------------------------------------
# Atualiza alvo com base nos passos do player
# -------------------------------------------------------
func _process(_delta: float) -> void:
	if not is_instance_valid(playerNode):
		return

	var passosAtuais : int = playerNode.getPlayerPassos()
	if passosAtuais - lastPassosChecked >= passosParaSugerir:
		lastPassosChecked = passosAtuais
		playerPosition = playerNode.global_position

# -------------------------------------------------------
# Física
# -------------------------------------------------------
func _physics_process(_delta: float) -> void:
	if isIaAlive and canIaMove:
		_decideDirection()
		if inputMoveDirection != Vector2(0, 0):
			_playAnim()

	if inputMoveDirection == Vector2(0, 0) and canIaMove and isIaAlive:
		animIaNode.stop()

# -------------------------------------------------------
# Lógica de decisão — agora reavalia periodicamente
# -------------------------------------------------------
func _decideDirection() -> void:
	var ray = _raycastFor(inputMoveDirection)
	var bloqueado = ray == null or ray.is_colliding()

	# força reavaliação se bateu em parede OU se já andou X passos
	if bloqueado or passosDaIa >= passosParaRever:
		passosDaIa = 0
		inputMoveDirection = _chooseNewDirection()

func _chooseNewDirection() -> Vector2:
	# --- tenta a direção ideal em direção ao player ---
	if playerNode and randf() < smartChance:
		var preferred = _directionTowards(playerPosition)

		# evita continuar na mesma direção se o player está em outra
		var ray = _raycastFor(preferred)
		if ray and not ray.is_colliding():
			return preferred

		# direção ideal bloqueada — tenta o eixo perpendicular
		var perp = _perpendicularDirections(preferred)
		for d in perp:
			var r = _raycastFor(d)
			if r and not r.is_colliding():
				return d

	# --- fallback aleatório entre direções livres ---
	var free = _freeDirections()
	# prefere não voltar atrás se tiver outra opção
	var semVoltar = free.filter(func(d): return d != -inputMoveDirection)
	if not semVoltar.is_empty():
		semVoltar.shuffle()
		return semVoltar[0]

	if not free.is_empty():
		free.shuffle()
		return free[0]

	return inputMoveDirection  # preso, mantém

# retorna as duas direções perpendiculares a uma dada direção
func _perpendicularDirections(dir: Vector2) -> Array:
	if dir.x != 0:  # vinha horizontal → tenta vertical
		return [Vector2(0, -1), Vector2(0, 1)]
	else:           # vinha vertical → tenta horizontal
		return [Vector2(-1, 0), Vector2(1, 0)]

func _directionTowards(alvo: Vector2) -> Vector2:
	var diff := alvo - position
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
	if   inputMoveDirection == Vector2(0, -1): animIaNode.play("up")
	elif inputMoveDirection == Vector2(0,  1): animIaNode.play("down")
	elif inputMoveDirection == Vector2(-1, 0): animIaNode.play("left")
	elif inputMoveDirection == Vector2(1,  0): animIaNode.play("right")

	if inputMoveDirection and canIaMove:
		canIaMove = false
		var moveTween = create_tween()
		moveTween.tween_property(self, "position", position + inputMoveDirection * 16, iaMoveDelay)
		await get_tree().create_timer(iaMoveDelay).timeout
		passosDaIa += 1   # conta passo concluído
		canIaMove = true

func killIa():
	if shouldDecrease:
		shouldDecrease = false
		CurrentLevelManager.decreaseEnemyCount()
		print("Enemies: ", CurrentLevelManager.currentEnemiesAlive)
	isIaAlive = false
	animIaNode.play("die")
	await animIaNode.animation_finished
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "ExplosionArea":
		killIa()
