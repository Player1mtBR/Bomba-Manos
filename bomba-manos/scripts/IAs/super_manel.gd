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


var projectile01Scene = preload("res://scenes/levels/campaign/extras/projectile_01.tscn")
var projectile02Scene = preload("res://scenes/levels/campaign/extras/projectile_02.tscn")
var laser01Scene = preload("res://scenes/levels/campaign/extras/laser_01.tscn")

var coolAnimation := false
	
var canAttack := false
var canAttackProjectile := true
var canAttackLaser := true
#var canAttackCharged := false
var chargedCount := 5
var phase := 1
var wait4awesomeness := false

var attackCooldown1 := 0.1
var attackCooldown2 := 0.25
var attackCooldown3 := 0.5
var attackCooldown4 := 1.0
var attackCooldown5 := 3.0
var attackCooldown6 := 5.0

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

func _ready() -> void:
	print("aaa"+str(phase))
	coolAnimation = true
	$AnimationPlayer.play("intro")
	await get_tree().create_timer(10.0).timeout
	$sfx/risadaPessecopata.play()
	$"../soundtrack".play()
	await $AnimationPlayer.animation_finished
	coolAnimation = false
	canAttack = true
	
	#await get_tree().create_timer(1.0).timeout
	#attackLeft($"attackSpawn/left/2")

func _physics_process(delta: float) -> void:
	for area in $Area2D.get_overlapping_areas():
			print("area",area.name)
			#if area.name

func _process(delta: float) -> void:
		if canAttack == true and wait4awesomeness == false:
			var phRandom : int
			if chargedCount > 0:
				phRandom = randi_range(2, 4)
			else:
				phRandom = randi_range(1, 4)

			canAttack = false
			$AnimationPlayer.play("manelFloat")
			match phRandom:
				0:
					attackLaserCorners()
					chargedCount -= 1
				1:
					if chargedCount <= 0:
						chooseCharged()
						chargedCount = 5
						$visual/AnimatedSprite2D.play("attack01")
						$sfx/risadaPessecopata.play()
				2:
					chooseLaser()
					chargedCount -= 1
					$visual/AnimatedSprite2D.play("attack02")
					print("laser")
				3:
					chooseProjectile()
					chargedCount -= 1
					$visual/AnimatedSprite2D.play("attack03")
					print("pew")
				4:
					chooseProjectile()
					chargedCount -= 1
					$visual/AnimatedSprite2D.play("attack04")
					print("pew")
					
			#print("chargedCount: ",chargedCount)
						
					
			await $visual/AnimatedSprite2D.animation_finished
			$visual/AnimatedSprite2D.play("default")
			await get_tree().create_timer(attackCooldown5).timeout
			canAttack = true
			
			
func chooseProjectile():
	match phase:
		1:
			phase01Projectiles.pick_random().call() #will choose a random attack from the array, and  use call
		2:
			pass
		3:
			pass
			
func chooseLaser():
	match phase:
		1:
			phase01Lasers.pick_random().call()
		2:
			pass
		3:
			pass
	
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
	match phase:
		1:
			pass
		2:
			pass
		3:
			pass

func attackZigzag():
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown1).timeout
	
func attackCircle():
	attackLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown3).timeout
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown3).timeout
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown1).timeout
	attackRight(posRight[1])
	await get_tree().create_timer(attackCooldown1).timeout
	attackRight(posRight[2])
	await get_tree().create_timer(attackCooldown1).timeout



func attackLeft01():
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown3).timeout
	
func attackLeft02():
	attackLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown3).timeout
	


func attackRight01():
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown2).timeout
	attackRight(posRight[1])
	await get_tree().create_timer(attackCooldown2).timeout
	attackRight(posRight[2])
	await get_tree().create_timer(attackCooldown2).timeout
	attackRight(posRight[1])
	await get_tree().create_timer(attackCooldown2).timeout
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown2).timeout
	
func attackRight02():
	attackRight(posRight[2])
	await get_tree().create_timer(attackCooldown2).timeout
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown2).timeout
	attackRight(posRight[1])
	await get_tree().create_timer(attackCooldown2).timeout
	attackRight(posRight[0])
	await get_tree().create_timer(attackCooldown2).timeout
	attackRight(posRight[2])
	await get_tree().create_timer(attackCooldown2).timeout
	
	
	
func attackTop01():
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown2).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown2).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown2).timeout
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown2).timeout
	
func attackTop02():
	attackTop(posTop[4])
	await get_tree().create_timer(attackCooldown2).timeout
	attackTop(posTop[3])
	await get_tree().create_timer(attackCooldown2).timeout
	attackTop(posTop[2])
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop(posTop[1])
	await get_tree().create_timer(attackCooldown2).timeout
	attackTop(posTop[0])
	await get_tree().create_timer(attackCooldown2).timeout
	

func attackLaserLeft01():
	laserLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown4).timeout
	laserLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown4).timeout
	
func attackLaserLeft02():
	laserLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown5).timeout
	laserLeft(posLeft[2])
	laserLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown4).timeout
	
func attackLaserTop01():
	laserTop(posTop[2])
	await get_tree().create_timer(attackCooldown5).timeout
	laserTop(posTop[4])
	laserTop(posTop[0])
	await get_tree().create_timer(attackCooldown4).timeout
	
func attackLaserTop02():
	laserTop(posTop[1])
	laserTop(posTop[3])
	await get_tree().create_timer(attackCooldown4).timeout


	
func attackLaserTop2Middle():
	
	laserTop(posTop[0])
	laserTop(posTop[4])
	await get_tree().create_timer(attackCooldown4).timeout
	laserTop(posTop[2])
	await get_tree().create_timer(attackCooldown4).timeout
	laserTop(posTop[1])
	laserTop(posTop[3])
	await get_tree().create_timer(attackCooldown4).timeout
	
func attackLaserTop2Bottom():
	laserLeft(posLeft[0])
	await get_tree().create_timer(attackCooldown3).timeout
	laserLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown3).timeout
	
func attackLaserBottom2Top():
	laserLeft(posLeft[2])
	await get_tree().create_timer(attackCooldown3).timeout
	laserLeft(posLeft[1])
	await get_tree().create_timer(attackCooldown3).timeout
	
	
func attackLaserLeft2Right():
	laserTop(posTop[0])
	await get_tree().create_timer(attackCooldown3).timeout
	laserTop(posTop[1])
	await get_tree().create_timer(attackCooldown3).timeout
	laserTop(posTop[2])
	await get_tree().create_timer(attackCooldown3).timeout
	laserTop(posTop[3])
	await get_tree().create_timer(attackCooldown3).timeout
	
func attackLaserRight2Left():
	laserTop(posTop[4])
	await get_tree().create_timer(attackCooldown3).timeout
	laserTop(posTop[3])
	await get_tree().create_timer(attackCooldown3).timeout
	laserTop(posTop[2])
	await get_tree().create_timer(attackCooldown3).timeout
	laserTop(posTop[1])
	await get_tree().create_timer(attackCooldown3).timeout
	
	
func attackLaserLeftCornerUp():
	attackLaserRight2Left()
	await get_tree().create_timer(attackCooldown4).timeout
	attackLaserBottom2Top()
	await get_tree().create_timer(attackCooldown6).timeout
	
func attackLaserLeftCornerDown():
	attackLaserRight2Left()
	await get_tree().create_timer(attackCooldown4).timeout
	attackLaserTop2Bottom()
	await get_tree().create_timer(attackCooldown6).timeout
	
func attackLaserRightCornerUp():
	attackLaserLeft2Right()
	await get_tree().create_timer(attackCooldown4).timeout
	attackLaserBottom2Top()
	await get_tree().create_timer(attackCooldown6).timeout
	
func attackLaserRightCornerDown():
	attackLaserLeft2Right()
	await get_tree().create_timer(attackCooldown4).timeout
	attackLaserTop2Bottom()
	await get_tree().create_timer(attackCooldown6).timeout
	
func attackLaserCorners(): #BAD LOGIC
	attackLaserRightCornerUp()
	await get_tree().create_timer(10).timeout
	attackLaserRightCornerDown()
	await get_tree().create_timer(10).timeout
	attackLaserLeftCornerDown()
	await get_tree().create_timer(10).timeout
	attackLaserLeftCornerUp()
	await get_tree().create_timer(10).timeout
	
	

func chargeAttackTop(pos):
	$visual/AnimatedSprite2D.play("default")
	shoot02(Vector2.DOWN, 300.0, pos.global_position, 0.0)
	
func chargeAttackLeft(pos):
	$visual/AnimatedSprite2D.play("default")
	shoot02(Vector2.RIGHT, 300.0, pos.global_position, -90.0)

func chargeAttackRight(pos):
	$visual/AnimatedSprite2D.play("default")
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
	var new_projectile = projectile01Scene.instantiate()
	new_projectile.velocity = direction.normalized() * speed
	new_projectile.position = projPosition
	new_projectile.rotation = deg_to_rad(projRotation)
	get_parent().add_child(new_projectile)
	
func shoot02(direction : Vector2, speed : float, projPosition : Vector2, projRotation : float):
	var new_projectile = projectile02Scene.instantiate()
	new_projectile.velocity = direction.normalized() * speed
	new_projectile.position = projPosition
	new_projectile.rotation = deg_to_rad(projRotation)
	get_parent().add_child(new_projectile)
	
func laser01(setRotation : float, laserPosition : Vector2):
	var new_laser = laser01Scene.instantiate()
	new_laser.rotation = deg_to_rad(setRotation)
	new_laser.position = laserPosition
	get_parent().add_child(new_laser)
	print(new_laser.rotation)
	
func takeDamage():
	canAttack = false
	$visual/AnimatedSprite2D.play("hit0"+str(phase))
	phase += 1
	await $visual/AnimatedSprite2D.animation_finished
	$sfx/risadaPessecopata.play()
	await get_tree().create_timer(3.0).timeout
	canAttack = true
	
	if phase >= 4:
		pass ##maybe mash buttons


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	#if area.get_parent().name == "Attack":
		#takeDamage()
