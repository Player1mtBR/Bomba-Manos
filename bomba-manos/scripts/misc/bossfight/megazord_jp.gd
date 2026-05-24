extends CharacterBody2D

var hp := 10
var movespeed := 300

@onready var parryTimer = $ParryTimer

var chargedPower := 0
var invincible := false
var invincibilityTime := 1.0

var canMove := true
var canBlock := true
var isBlocking := false
var canAttack := false
var isAttacking := false
var canParry := true

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	$"../Icons/healthBarMegazordJP/TextureProgressBar".value = hp
	$"../Icons/powerBar/TextureProgressBar".value = chargedPower
	$"../Icons/powerBar/TextureProgressBar2".value = chargedPower
	if UnlockStuff.iddqd == true:
		invincible = true
		chargedPower = 3
		canAttack = true
		
	if canBlock:
		if isBlocking == false:
			if Input.is_action_just_pressed("p1_bomb") and canAttack == true:
				canBlock == false
				jpAttack()
				movePlayer2AttackPosition(delta)
		
			if Input.is_action_just_pressed("p2_moveUp"):
				jpBlockUp()
				parryTimer.start()
				
			elif Input.is_action_just_pressed("p2_moveLeft"):
				jpBlockLeft()
				parryTimer.start()
				
			elif Input.is_action_just_pressed("p2_moveRight"):
				jpBlockRight()
				parryTimer.start()
		
	if Input.is_action_just_released("p2_moveUp"):
		$ShieldUP.visible = false
		isBlocking = false
		parryTimer.stop()
		showGreenShield()
		
	if Input.is_action_just_released("p2_moveLeft"):
		$ShieldLEFT.visible = false
		isBlocking = false
		parryTimer.stop()
		showGreenShield()
		
	if Input.is_action_just_released("p2_moveRight"):
		$ShieldRIGHT.visible = false
		isBlocking = false
		parryTimer.stop()
		showGreenShield()
	
func _physics_process(delta: float) -> void:
	if canMove:
		var direction = Input.get_vector("p1_moveLeft", "p1_moveRight", "p1_moveUp", "p1_moveDown")
		velocity = (direction * movespeed)
		move_and_slide()
	
func chargePower(amount):
	if canParry == true:
		$sfx/charge.play()
		chargedPower += amount
		if chargedPower >= 3:
			canAttack = true
			$sfx/fullpower.play()

func jpBlock():
	print("Blocking")
	#$Shield.visible = true
	
func jpBlockUp():
	$sfx/shield.play()
	print("Blocking")
	$ShieldUP.visible = true
	$ShieldUP/CollisionShape2D.disabled = false
	isBlocking = true
	
func jpBlockLeft():
	$sfx/shield.play()
	print("Blocking")
	$ShieldLEFT.visible = true
	$ShieldLEFT/CollisionShape2D.disabled = false
	isBlocking = true
	
func jpBlockRight():
	$sfx/shield.play()
	print("Blocking")
	$ShieldRIGHT.visible = true
	$ShieldRIGHT/CollisionShape2D.disabled = false
	isBlocking = true
	
func jpAttack():
	$sfx/attack.play()
	$"../SuperManel".wait4awesomeness = true
	$"../Icons/Faces".modulate = Color(0, 1, 0)
	canAttack = false
	isAttacking = true
	invincible = true
	print("Attack")
	$Attack.visible = true
	$Attack/Area2D/CollisionShape2D.disabled == false
	await get_tree().create_timer(1.0).timeout
	chargedPower = 2
	await get_tree().create_timer(1.0).timeout
	chargedPower = 1
	await get_tree().create_timer(1.0).timeout
	chargedPower = 0
	$Attack.visible = false
	$Attack/Area2D/CollisionShape2D.disabled == true
	canMove = true
	canBlock = true
	print("power ", chargedPower)
	isAttacking = false
	invincible = false
	$"../SuperManel".wait4awesomeness = false
	$"../Icons/Faces".modulate = Color(1, 1, 1)
	
func movePlayer2AttackPosition(delta):
	canMove = false
	position.x = move_toward(position.x, 428.0, delta)
	position.y = move_toward(position.y, 320.0, delta * movespeed)

func showGreenShield():
	$ShieldUP/green.visible = true
	$ShieldLEFT/green2.visible = true
	$ShieldRIGHT/green3.visible = true
	$ShieldUP/CollisionShape2D.disabled = true
	$ShieldLEFT/CollisionShape2D.disabled = true
	$ShieldRIGHT/CollisionShape2D.disabled = true
	canParry = true
	print("can parry = ", canParry)
	
func takeDamage(amount):
	if invincible == false:
		$"../Icons/Faces".modulate = Color(1, 0, 0)
		$"../Camera2D".camShake01Trigger = true
	
		invincible = true
		print("invincible")
		$sfx/hit.play()
		hp -= amount
		if hp <= 0:
			killMegazord()
		for i in range(4):
			modulate = Color(1, 0, 0)
			await get_tree().create_timer(0.05).timeout
			modulate = Color(1, 1, 1)
			await get_tree().create_timer(0.05).timeout
			
		#await get_tree().create_timer(invincibilityTime).timeout
		$"../Icons/Faces".modulate = Color(1, 1, 1)
		invincible = false
		print("vulnerable")
	
func killMegazord():
	print("GAME OVER DUDES")
	CurrentLevelManager.restartLevel()

func _on_parry_timer_timeout() -> void:
	$ShieldUP/green.visible = false
	$ShieldLEFT/green2.visible = false
	$ShieldRIGHT/green3.visible = false
	canParry = false
	print("can parry = ", canParry)
