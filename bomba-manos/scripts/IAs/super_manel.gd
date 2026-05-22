extends Node2D

var projectile01Scene = preload("res://scenes/levels/campaign/extras/projectile_01.tscn")
var canAttack := true
var attackCooldown1 := 0.1
var attackCooldown2 := 0.25
var attackCooldown3 := 0.5
var attackCooldown4 := 1.0
var attackCooldown5 := 3.0
	
func _ready() -> void:
	pass
	#await get_tree().create_timer(1.0).timeout
	#attackLeft($"attackSpawn/left/2")

func _process(delta: float) -> void:
		if canAttack == true:
			var phRandom = randi_range(4, 4)
			canAttack = false
			match phRandom:
				1:
					attackZigzag()
				2:
					attackLeft01()
				3:
					attackLeft02()
				4:
					attackCircle()
				
			await get_tree().create_timer(attackCooldown5).timeout
			canAttack = true

func attackZigzag():
	attackTop($"attackSpawn/top/1")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/2")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/3")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/4")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/5")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/4")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/3")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/2")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/1")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/2")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/3")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/4")
	await get_tree().create_timer(attackCooldown1).timeout
	attackTop($"attackSpawn/top/5")
	
func attackCircle():
	attackLeft($"attackSpawn/left/3")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/left/2")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/left/1")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/top/1")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/top/2")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/top/3")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/top/4")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/top/5")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/right/1")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/right/2")
	await get_tree().create_timer(attackCooldown1).timeout
	attackLeft($"attackSpawn/right/3")
	await get_tree().create_timer(attackCooldown1).timeout
	
	
	
	


func attackLeft01():
	attackLeft($"attackSpawn/left/1")
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft($"attackSpawn/left/2")
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft($"attackSpawn/left/3")
	await get_tree().create_timer(attackCooldown2).timeout
	
func attackLeft02():
	attackLeft($"attackSpawn/left/3")
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft($"attackSpawn/left/1")
	await get_tree().create_timer(attackCooldown2).timeout
	attackLeft($"attackSpawn/left/2")
	await get_tree().create_timer(attackCooldown1).timeout



func attackLeft(pos):
	shoot01(Vector2.RIGHT, 300.0, pos.global_position)
	
func attackRight(pos):
	shoot01(Vector2.LEFT, 300.0, pos.global_position)

func attackTop(pos):
	shoot01(Vector2.DOWN, 300.0, pos.global_position)


	
func shoot01(direction : Vector2, speed : float, projPosition : Vector2):
	var new_projectile = projectile01Scene.instantiate()
	new_projectile.velocity = direction.normalized() * speed
	new_projectile.position = projPosition
	new_projectile.canCharge = true
	get_parent().add_child(new_projectile)
