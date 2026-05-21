extends CharacterBody2D

var hp := 10
var movespeed := 300

var chargedPower := 0

var canMove := true
var canBlock := true
var isBlocking := false
var canAttack := false
var canParry := false
var parryTime := 1.0

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("p1_swap_bomb"):
		jpBlock()
	if Input.is_action_just_released("p1_swap_bomb"):
		pass
		#$Shield.visible = false
		
	#for test only:
	if Input.is_action_just_pressed("menu_accept"):
		chargePower(1)
		
	if canBlock:
		if isBlocking == false:
			if Input.is_action_just_pressed("p1_bomb") and canAttack:
				canBlock == false
				jpAttack()
				movePlayer2AttackPosition(delta)
		
			if Input.is_action_just_pressed("p2_moveUp"):
				jpBlockUp()
				
			elif Input.is_action_just_pressed("p2_moveLeft"):
				jpBlockLeft()
				
			elif Input.is_action_just_pressed("p2_moveRight"):
				jpBlockRight()
		
	if Input.is_action_just_released("p2_moveUp"):
		$ShieldUP.visible = false
		isBlocking = false
		
	if Input.is_action_just_released("p2_moveLeft"):
		$ShieldLEFT.visible = false
		isBlocking = false
		
	if Input.is_action_just_released("p2_moveRight"):
		$ShieldRIGHT.visible = false
		isBlocking = false
		
	if chargedPower <= 0:
		$"../Icons/powerBar/1".visible = false
		$"../Icons/powerBar/2".visible = false
		$"../Icons/powerBar/3".visible = false
	if chargedPower >= 1:
		$"../Icons/powerBar/1".visible = true
	if chargedPower >= 2:
		$"../Icons/powerBar/1".visible = true
		$"../Icons/powerBar/2".visible = true
	if chargedPower >= 3:
		$"../Icons/powerBar/1".visible = true
		$"../Icons/powerBar/2".visible = true
		$"../Icons/powerBar/3".visible = true
	
func _physics_process(delta: float) -> void:
	if canMove:
		var directionX = Input.get_vector("p1_moveLeft", "p1_moveRight", "p1_moveUp", "p1_moveDown")
		velocity = (directionX * movespeed)
		move_and_slide()
	
func chargePower(amount):
	chargedPower += amount
	if chargedPower >= 3:
		canAttack = true

func jpBlock():
	print("Blocking")
	#$Shield.visible = true
	
func jpBlockUp():
	print("Blocking")
	$ShieldUP.visible = true
	isBlocking = true
	
func jpBlockLeft():
	print("Blocking")
	$ShieldLEFT.visible = true
	isBlocking = true
	
func jpBlockRight():
	print("Blocking")
	$ShieldRIGHT.visible = true
	isBlocking = true
	
func jpAttack():
	canAttack = false
	print("Attack")
	$Attack.visible = true
	await get_tree().create_timer(3.0).timeout
	$Attack.visible = false
	canMove = true
	chargedPower = 0
	canBlock = true
	print("power ", chargedPower)
	
func movePlayer2AttackPosition(delta):
	canMove = false
	position.x = 428
	position.y = 320
