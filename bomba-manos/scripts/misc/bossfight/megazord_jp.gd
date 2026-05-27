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
var currentBlock := ""
var canAttack := false
var isAttacking := false
var canParry := true

var currentDirection : Vector2

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
				canBlock = false
				jpAttack()
				movePlayer2AttackPosition(delta)
		
	if Input.is_action_just_pressed("p2_moveUp"):
		change_block("up")

	elif Input.is_action_just_pressed("p2_moveLeft"):
		change_block("left")

	elif Input.is_action_just_pressed("p2_moveRight"):
		change_block("right")



	if currentBlock == "up" and Input.is_action_just_released("p2_moveUp"):
		stop_block()

	elif currentBlock == "left" and Input.is_action_just_released("p2_moveLeft"):
		stop_block()

	elif currentBlock == "right" and Input.is_action_just_released("p2_moveRight"):
		stop_block()
	
		
	##MOVEMENT ANIMATION SYSTEm
	if canMove == true:
		if Input.is_action_just_pressed("p1_moveLeft"):
			currentDirection = Vector2(-1, 0)
			if $AnimatedSprite2D.animation != "go_left":
				$AnimatedSprite2D.play("go_left")
			
		if Input.is_action_just_pressed("p1_moveRight"):
			currentDirection = Vector2(1, 0)
			if $AnimatedSprite2D.animation != "go_right":
				$AnimatedSprite2D.play("go_right")
				
		elif Input.is_action_just_pressed("p1_moveUp") and currentDirection != Vector2(-1, 0) and currentDirection != Vector2(1, 0):
			currentDirection = Vector2(0, -1)
			if $AnimatedSprite2D.animation != "foward":
				$AnimatedSprite2D.play("foward")
			
		elif Input.is_action_just_pressed("p1_moveDown") and currentDirection != Vector2(-1, 0) and currentDirection != Vector2(1, 0):
			currentDirection = Vector2(0, 1)
			if $AnimatedSprite2D.animation != "back":
				$AnimatedSprite2D.play("back")
				
				
		if Input.is_action_just_released("p1_moveLeft"):
			if currentDirection == Vector2(-1, 0):
				$AnimatedSprite2D.play("return_left")
				currentDirection = Vector2(0, 0)
				

				
		if Input.is_action_just_released("p1_moveRight"):
			if currentDirection == Vector2(1, 0):
				$AnimatedSprite2D.play("return_right")
				currentDirection = Vector2(0, 0)
				
		if Input.is_action_just_released("p1_moveUp"):
			if currentDirection == Vector2(0, -1):
				$AnimatedSprite2D.play("idle")
				currentDirection = Vector2(0, 0)
		
		if Input.is_action_just_released("p1_moveDown") and currentDirection != Vector2(-1, 0) and currentDirection != Vector2(1, 0):
			if currentDirection == Vector2(0, 1):
				$AnimatedSprite2D.play("idle")
				currentDirection = Vector2(0, 0)
		
				
				
	
func _physics_process(delta: float) -> void:
	if canMove:
		var direction = Input.get_vector("p1_moveLeft", "p1_moveRight", "p1_moveUp", "p1_moveDown")
		velocity = (direction * movespeed)
		move_and_slide()
	
func chargePower(amount):
	if canParry == true:
		$AnimationPlayer.play("charge")
		$sfx/charge.play()
		chargedPower += amount
		hp += 2
		$AnimationPlayer.play("heal")
		for i in range(4):
			modulate = Color(10, 10, 10)
			await get_tree().create_timer(0.05, false).timeout
			modulate = Color(1, 1, 1)
			await get_tree().create_timer(0.05, false).timeout
		if hp > 10:
			hp = 10
		if chargedPower >= 3:
			canAttack = true
			$sfx/fullpower.play()
			$AnimationPlayer.play("fullpower")
		
		await $AnimationPlayer.animation_finished
		if hp < 5:
			$AnimationPlayer.play("low_health")
			

func change_block(direction : String):

	disable_all_shields()
	parryTimer.stop()
	parryTimer.start()
	match direction:
		"up":
			jpBlockUp()
		"left":
			jpBlockLeft()
		"right":
			jpBlockRight()
			
	currentBlock = direction
	isBlocking = true
	
func jpBlockUp():
	$sfx/shield.play()
	#print("Blocking")
	$ShieldUP.visible = true
	$ShieldUP/CollisionShape2D.disabled = false
	$ShieldUP/AnimatedSprite2D.play("default")
	isBlocking = true
	
func jpBlockLeft():
	$sfx/shield.play()
	#print("Blocking")
	$ShieldLEFT.visible = true
	$ShieldLEFT/CollisionShape2D.disabled = false
	$ShieldLEFT/AnimatedSprite2D.play("default")
	isBlocking = true
	
func jpBlockRight():
	$sfx/shield.play()
	#print("Blocking")
	$ShieldRIGHT.visible = true
	$ShieldRIGHT/CollisionShape2D.disabled = false
	$ShieldRIGHT/AnimatedSprite2D.play("default")
	isBlocking = true
	
func stop_block():
	disable_all_shields()
	isBlocking = false
	currentBlock = ""
	parryTimer.stop()
	showGreenShield()
	
func disable_all_shields():
	$ShieldUP.visible = false
	$ShieldLEFT.visible = false
	$ShieldRIGHT.visible = false
	$ShieldUP/CollisionShape2D.disabled = true
	$ShieldLEFT/CollisionShape2D.disabled = true
	$ShieldRIGHT/CollisionShape2D.disabled = true
	
func jpAttack():
	$AnimatedSprite2D.play("shoot")
	$sfx/attack.play()
	$sfx/bombarangers.play()
	$AnimationPlayer.play("power_drain")
	$"../SuperManel".coolAnimation = true
	$"../Icons/Faces".modulate = Color(0, 1, 0)
	canAttack = false
	isAttacking = true
	invincible = true
	#print("Attack")
	$Attack.visible = true
	$Attack/Area2D/CollisionShape2D.disabled = false
	await get_tree().create_timer(1.0, false).timeout
	chargedPower = 2
	await get_tree().create_timer(1.0, false).timeout
	chargedPower = 1
	await get_tree().create_timer(1.0, false).timeout
	chargedPower = 0
	$AnimationPlayer.play("charge")
	$Attack.visible = false
	$Attack/Area2D/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("idle")
	canMove = true
	canBlock = true
	#print("power ", chargedPower)
	isAttacking = false
	invincible = false
	$"../SuperManel".coolAnimation = false
	$"../Icons/Faces".modulate = Color(1, 1, 1)
	
func movePlayer2AttackPosition(delta):
	canMove = false
	position.x = move_toward(position.x, 428.0, delta)
	position.y = move_toward(position.y, 320.0, delta * movespeed)

func showGreenShield():
	$ShieldUP/CollisionShape2D.disabled = true
	$ShieldLEFT/CollisionShape2D.disabled = true
	$ShieldRIGHT/CollisionShape2D.disabled = true
	$ShieldUP/AnimatedSprite2D.stop()
	$ShieldLEFT/AnimatedSprite2D.stop()
	$ShieldRIGHT/AnimatedSprite2D.stop()
	canParry = true
	#print("can parry = ", canParry)
	
func takeDamage(amount):
	if UnlockStuff.iddqd == true: #debug damage
		for i in range(4):
			modulate = Color(1, 0, 0)
			await get_tree().create_timer(0.05, false).timeout
			modulate = Color(1, 1, 1)
			await get_tree().create_timer(0.05, false).timeout
			
	if invincible == false:
		$"../Icons/Faces".modulate = Color(1, 0, 0)
		$"../Camera2D".camShake01Trigger = true
	
		invincible = true
		#print("invincible")
		$sfx/hit.play()
		$AnimationPlayer.play("damage")
		hp -= amount
		if hp < 5:
			$AnimationPlayer.play("low_health")
		if hp <= 0:
			killMegazord()
		for i in range(4):
			modulate = Color(1, 0, 0)
			await get_tree().create_timer(0.05, false).timeout
			modulate = Color(1, 1, 1)
			await get_tree().create_timer(0.05, false).timeout
			
		#await get_tree().create_timer(invincibilityTime, false).timeout
		$"../Icons/Faces".modulate = Color(1, 1, 1)
		invincible = false
		#print("vulnerable")
	
func killMegazord():
	print("GAME OVER DUDES")
	$"../AnimationPlayer".play("defeat")
	$"../SuperManel".coolAnimation = true
	$sfx/defeat.play()
	canAttack = false
	canBlock = false
	$"../Camera2D".camShake01Trigger = false
	await $"../AnimationPlayer".animation_finished
	Loader.loadingScreen2Scene("res://scenes/menus/worldSelectScenes/campaign_level_select_05.tscn")
	#CurrentLevelManager.restartLevel()

func _on_parry_timer_timeout() -> void:
	$ShieldUP/green.visible = false
	$ShieldLEFT/green2.visible = false
	$ShieldRIGHT/green3.visible = false
	canParry = false
	#print("can parry = ", canParry)


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "return_left" or $AnimatedSprite2D.animation == "return_right":
		
		$AnimatedSprite2D.play("idle")
