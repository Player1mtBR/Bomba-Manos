extends Node2D

@onready var posLeft := [
	$"attackSpawn/left/1",
	$"attackSpawn/left/2",
	$"attackSpawn/left/3"
]
@onready var posRight := [
	$"attackSpawn/right/1",
	$"attackSpawn/right/2",
	$"attackSpawn/right/3"
]
@onready var posTop := [
	$"attackSpawn/top/1",
	$"attackSpawn/top/2",
	$"attackSpawn/top/3",
	$"attackSpawn/top/4",
	$"attackSpawn/top/5"
]

var skipIntro := true
var phase := 1

var projectile01Scene = preload("res://scenes/levels/campaign/extras/projectile_01.tscn")
var projectile02Scene = preload("res://scenes/levels/campaign/extras/projectile_02.tscn")
var laser01Scene = preload("res://scenes/levels/campaign/extras/laser_01.tscn")

var coolAnimation := false
	
var canAttack := false
var chargedCount := 6
var chargeCountCap := 6 #phase01 = 6, phase02 = 4, phase03 = 2

var attackCooldown1 := 0.1
var attackCooldown2 := 0.25
var attackCooldown3 := 0.5
var attackCooldown4 := 1.0
var attackCooldown5 := 3.0
var attackCooldown6 := 5.0

var useLastAttack := true

var currentAttack : Callable

var phase01Projectiles : Array[Callable] = [ ##functions inside an array cant use parenthesis
	attackLeft01,
	attackLeft02,
	attackRight01,
	attackRight02,
	attackTop01,
	attackTop02
]

var phase01Lasers : Array[Callable] = [
	attackLaserLeft01,
	attackLaserLeft02,
	attackLaserTop01,
	attackLaserTop02
]

var phase02Projectiles : Array[Callable] = [
	attackCircle,
	attackCircle02,
	attackZigzag,
	attackLeft03,
	attackRight03
]

var phase02Lasers : Array[Callable] = [
	attackLaserTop2Middle,
	attackLaserTop2Bottom,
	attackLaserBottom2Top,
	attackLaserLeft2Right,
	attackLaserRight2Left
]

var phase03Projectiles : Array[Callable] = [
	attackP301,
	attackP302
]

var phase03Lasers : Array[Callable] = [
	attackLaserCorners,
	attackLaserLeftCornerUp,
	attackLaserLeftCornerDown,
	attackLaserRightCornerUp,
	attackLaserRightCornerDown,
]

func _ready() -> void:
	#aaprint("aaa"+str(phase))
	if skipIntro == false:
		coolAnimation = true
		$AnimationPlayer.play("intro")
		await get_tree().create_timer(10.0, false).timeout
		$sfx/risadaPessecopata.play()
		$"../soundtrack".play()
		await $AnimationPlayer.animation_finished
		coolAnimation = false
	await get_tree().create_timer(0.1, false).timeout
	$visual.visible = true
	
	$"../soundtrack".play()
	#await get_tree().create_timer(3.0).timeout
	canAttack = true
	print(coolAnimation, canAttack)


func _physics_process(delta: float) -> void:
	pass
	#for area in $Area2D.get_overlapping_areas():
	#	print("area",area.name)
		#if area.name

func _process(delta: float) -> void:
	if coolAnimation == true:
		canAttack = false
	
	if canAttack == true and coolAnimation == false and phase < 4:
		var phRandom : int
		if chargedCount > 0:
			phRandom = randi_range(2, 4)
		elif chargedCount <= -5:
			phRandom = randi_range(1, 1) #if 5 attacks passed, charged sttack guaranteed
		else:
			phRandom = randi_range(1, 4)

		canAttack = false
		print("phase check", phase)
		playAttackAnim()
		match phRandom:
			0:
				attackLaserCorners()
				chargedCount -= 1
			1:
				if chargedCount <= 0:
					chooseCharged()
					chargedCount = chargeCountCap
					#$visual/AnimatedSprite2D.play("attack01")
					$sfx/risadaPessecopata.play()
			2:
				chooseLaser()
				chargedCount -= 1
				#$visual/AnimatedSprite2D.play("attack02")
				#print("laser")
			3:
				chooseProjectile()
				#chargedCount -= 1
				#$visual/AnimatedSprite2D.play("attack03")
				#print("pew")
			4:
				chooseProjectile()
				chargedCount -= 1
				#$visual/AnimatedSprite2D.play("attack04")
				#print("pew")
				
		#print("chargedCount: ",chargedCount)
					
		#canAttack = false
		#print("can attack ", canAttack)
		print("remaining to charge: ", chargedCount," / ",chargeCountCap)
		await $visual/AnimatedSprite2D.animation_finished
		if coolAnimation == false:
			playIdleAnim()
		await get_tree().create_timer(attackCooldown5, false).timeout
		#canAttack = true
	
	if phase >= 4 and useLastAttack == true:
		useLastAttack = false
		finalAttack()
	
			
func chooseProjectile():
	match phase:
		1:
			currentAttack = phase01Projectiles.pick_random()
			print(currentAttack)
			currentAttack.call()
			#phase01Projectiles.pick_random().call() #will choose a random attack from the array, and  use call
		2:
			currentAttack = phase02Projectiles.pick_random()
			print(currentAttack)
			currentAttack.call()
		3:
			currentAttack = phase03Projectiles.pick_random()
			print(currentAttack)
			currentAttack.call()
	await currentAttack.call()
	if coolAnimation == false:
		canAttack = true
			
func chooseLaser():
	match phase:
		1:
			currentAttack = phase01Lasers.pick_random()
			print(currentAttack)
			currentAttack.call()
		2:
			currentAttack = phase02Lasers.pick_random()
			print(currentAttack)
			currentAttack.call()
		3:
			currentAttack = phase03Lasers.pick_random()
			print(currentAttack)
			currentAttack.call()
	await currentAttack.call()
	if coolAnimation == false:
		canAttack = true
	
func chooseCharged():
	var chargedDirection = randi_range(1, 3)
	var randLeftRight = randi_range(0, 2)
	var randTop = randi_range(0, 4)
	
	match chargedDirection:
		1:
			chargeAttackLeft(posLeft[randLeftRight])
		2:
			chargeAttackRight(posRight[randLeftRight])
		3:
			chargeAttackTop(posTop[randTop])
	await get_tree().create_timer(attackCooldown5, false).timeout
	if coolAnimation == false:
		canAttack = true
	
	match phase:
		1:
			pass
		2:
			pass
		3:
			pass

func attackZigzag():
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown5, false).timeout
	
func attackCircle():
	attackLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown3, false).timeout
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown3, false).timeout
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackRight(posRight[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackRight(posRight[2])
	await get_tree().create_timer(attackCooldown6, false).timeout
	
func attackCircle02():
	attackRight(posRight[2])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackRight(posRight[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown3, false).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown3, false).timeout
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown1, false).timeout
	attackLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown5, false).timeout
	


func attackLeft01():
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown4, false).timeout
	
	
func attackLeft02():
	attackLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown4, false).timeout
	

func attackLeft03():
	for i in range(5):	
		for i2 in range(3):
			attackLeft(posLeft[i2])
			await get_tree().create_timer(attackCooldown2, false).timeout
		attackTop(posTop[i])
	await get_tree().create_timer(attackCooldown4, false).timeout


func attackRight01():
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackRight(posRight[1])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackRight(posRight[2])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackRight(posRight[1])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown4, false).timeout
	
	
func attackRight02():
	attackRight(posRight[2])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackRight(posRight[1])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackRight(posRight[2])
	await get_tree().create_timer(attackCooldown4, false).timeout
	
func attackRight03():
	for i in range(4, -1, -1):	
		for i2 in range(3):
			attackRight(posRight[i2])
			await get_tree().create_timer(attackCooldown2, false).timeout
		attackTop(posTop[i])
	await get_tree().create_timer(attackCooldown4, false).timeout
	
func attackTop01():
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown4, false).timeout
	
	
func attackTop02():
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown2, false).timeout
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown4, false).timeout
	

func attackP301():
	attackZigzag()
	attackLaserTop2Middle()
	await get_tree().create_timer(attackCooldown5, false).timeout
	attackZigzag()
	attackLaserTop01()
	await get_tree().create_timer(attackCooldown5, false).timeout
	attackZigzag()
	attackLaserTop02()
	await get_tree().create_timer(attackCooldown6, false).timeout

func attackP302():
	attackCircle()
	await get_tree().create_timer(attackCooldown5, false).timeout
	attackCircle02()
	attackLeft01()
	await get_tree().create_timer(attackCooldown5, false).timeout
	attackCircle()
	attackRight02()
	await get_tree().create_timer(attackCooldown5, false).timeout
	attackTop01()
	attackTop02()
	await get_tree().create_timer(attackCooldown5, false).timeout
	attackLeft01()
	await get_tree().create_timer(attackCooldown3, false).timeout
	attackRight02()
	#await get_tree().create_timer(attackCooldown2, false).timeout
	attackLaserTop2Middle()
	await get_tree().create_timer(attackCooldown5, false).timeout

func attackLaserLeft01():
	laserLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown4, false).timeout
	laserLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	
func attackLaserLeft02():
	laserLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown5, false).timeout
	laserLeft(posLeft[2])
	laserLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	
func attackLaserTop01():
	laserTop(posTop[2])
	await get_tree().create_timer(attackCooldown5, false).timeout
	laserTop(posTop[4])
	laserTop(posTop[0])
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	
func attackLaserTop02():
	laserTop(posTop[1])
	laserTop(posTop[3])
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	
func attackLaserTop2Middle():
	laserTop(posTop[0])
	laserTop(posTop[4])
	await get_tree().create_timer(attackCooldown4, false).timeout
	laserTop(posTop[2])
	await get_tree().create_timer(attackCooldown4, false).timeout
	laserTop(posTop[1])
	laserTop(posTop[3])
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	
func attackLaserTop2Bottom():
	laserLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown3, false).timeout
	laserLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown4, false).timeout
	
	
func attackLaserBottom2Top():
	laserLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown3, false).timeout
	laserLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown4, false).timeout
	
	
func attackLaserLeft2Right():
	laserTop(posTop[0])
	await get_tree().create_timer(attackCooldown3, false).timeout
	laserTop(posTop[1])
	await get_tree().create_timer(attackCooldown3, false).timeout
	laserTop(posTop[2])
	await get_tree().create_timer(attackCooldown3, false).timeout
	laserTop(posTop[3])
	await get_tree().create_timer(attackCooldown4, false).timeout
	
	
func attackLaserRight2Left():
	laserTop(posTop[4])
	await get_tree().create_timer(attackCooldown3, false).timeout
	laserTop(posTop[3])
	await get_tree().create_timer(attackCooldown3, false).timeout
	laserTop(posTop[2])
	await get_tree().create_timer(attackCooldown3, false).timeout
	laserTop(posTop[1])
	await get_tree().create_timer(attackCooldown4, false).timeout
	
	
func attackLaserLeftCornerUp():
	attackLaserRight2Left()
	await get_tree().create_timer(attackCooldown4, false).timeout
	attackLaserBottom2Top()
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	
func attackLaserLeftCornerDown():
	attackLaserRight2Left()
	await get_tree().create_timer(attackCooldown4, false).timeout
	attackLaserTop2Bottom()
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	
func attackLaserRightCornerUp():
	attackLaserLeft2Right()
	await get_tree().create_timer(attackCooldown4, false).timeout
	attackLaserBottom2Top()
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	
func attackLaserRightCornerDown():
	attackLaserLeft2Right()
	await get_tree().create_timer(attackCooldown4, false).timeout
	attackLaserTop2Bottom()
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	
func attackLaserCorners(): #BAD LOGIC
	attackLaserRightCornerUp()
	await get_tree().create_timer(attackCooldown5, false).timeout
	attackLaserRightCornerDown()
	await get_tree().create_timer(attackCooldown5, false).timeout
	attackLaserLeftCornerDown()
	await get_tree().create_timer(attackCooldown5, false).timeout
	attackLaserLeftCornerUp()
	await get_tree().create_timer(attackCooldown5, false).timeout
	
	

func chargeAttackTop(pos):
	#$visual/AnimatedSprite2D.play("default")
	shoot02(Vector2.DOWN, 300.0, pos.global_position, 0.0)
	
func chargeAttackLeft(pos):
	#$visual/AnimatedSprite2D.play("default")
	shoot02(Vector2.RIGHT, 300.0, pos.global_position, -90.0)

func chargeAttackRight(pos):
	#$visual/AnimatedSprite2D.play("default")
	shoot02(Vector2.LEFT, 300.0, pos.global_position, 90.0)


func attackLeft(pos):
	shoot01(Vector2.RIGHT, 300.0, pos.global_position, -90.0)
	
func attackRight(pos):
	shoot01(Vector2.LEFT, 300.0, pos.global_position, 90.0)

func attackTop(pos):
	shoot01(Vector2.DOWN, 300.0, pos.global_position, 0.0)
	
	
func laserLeft(pos):
	laser01(pos.rotation, pos.global_position)
	
func laserTop(pos):
	laser01(90, pos.global_position)
	
	
func shoot01(direction : Vector2, speed : float, projPosition : Vector2, projRotation : float):
	if coolAnimation == false:
		var new_projectile = projectile01Scene.instantiate()
		new_projectile.velocity = direction.normalized() * speed
		new_projectile.position = projPosition
		new_projectile.rotation = deg_to_rad(projRotation)
		get_parent().add_child(new_projectile)
	
func shoot02(direction : Vector2, speed : float, projPosition : Vector2, projRotation : float):
	if coolAnimation == false:
		var new_projectile = projectile02Scene.instantiate()
		new_projectile.velocity = direction.normalized() * speed
		new_projectile.position = projPosition
		new_projectile.rotation = deg_to_rad(projRotation)
		get_parent().add_child(new_projectile)
	
func laser01(setRotation : float, laserPosition : Vector2):
	if coolAnimation == false:
		var new_laser = laser01Scene.instantiate()
		new_laser.rotation = deg_to_rad(setRotation)
		new_laser.position = laserPosition
		get_parent().add_child(new_laser)
		#print(new_laser.rotation)
	
func takeDamage():
	coolAnimation = true
	canAttack = false
	
	$AnimationPlayer.play("damage")
	coolAnimation = true
	await $AnimationPlayer.animation_finished
	canAttack = false
	
	$visual/AnimatedSprite2D.play("hit0"+str(phase))
	coolAnimation = true
	
	canAttack = false
	phase += 1
	chargeCountCap -= 2
	chargedCount = chargeCountCap
	print("manel hit, phase ", phase)
	$AnimationPlayer.play("manel_generic_fade")
	coolAnimation = true
	await get_tree().create_timer(2.5, false).timeout
	canAttack = false
	
	$visual/AnimatedSprite2D.offset = Vector2(0, 48)
	$visual.position = Vector2(0, 0)
	
	
	if phase == 3: 
		$"../Background/phase03BG".visible = true
		$visual/AnimatedSprite2D.scale = Vector2(2.75, 2.75)
		$visual/AnimatedSprite2D.position.y = -32.0
		$visual/leftHand.visible = true
		$visual/rightHand.visible = true
	
	
	await $visual/AnimatedSprite2D.animation_finished

	$sfx/risadaPessecopata.play()
	await get_tree().create_timer(3.0, false).timeout
		
	$sfx/risadaPessecopata.play()
	print("begin next phase")
	coolAnimation = false
	canAttack = true
	
func finalAttack():
	await get_tree().create_timer(5.0, false).timeout
	coolAnimation = true
	$"../MegazordJP".canMove = false
	$"../stuff2Animate/megaBomb/AnimationPlayer".play("go")
	#$"../stuff2Animate/megaBomb".visible = true
	await get_tree().create_timer(4.7, false).timeout
	#$"../Camera2D".camShake01Trigger = true
	$"../FinalAttack".isActive = true
	pass

func playIdleAnim():
	match phase:
		1:
			$AnimationPlayer.play("manelFloat")
			$visual/AnimatedSprite2D.play("default")
		2:
			$visual/AnimatedSprite2D.play("idle_phase02")
		3:
			$visual/AnimatedSprite2D.play("idle_phase03")
		4:
			$visual/AnimatedSprite2D.play("idle_phase03")

func playAttackAnim():
	match phase:
		1:
			$visual/AnimatedSprite2D.play("attack01")
		2:
			$visual/AnimatedSprite2D.play("attack02")
		3:
			$visual/AnimatedSprite2D.play("attack03")
		4:
			$visual/AnimatedSprite2D.play("attack03")

func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("area ",area.name)
	#if area.get_parent().name == "Attack":
		takeDamage()
