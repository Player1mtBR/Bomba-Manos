extends Node2D

var projectile01Scene = preload("res://scenes/levels/campaign/extras/projectile_01.tscn")
var canAttack := true
var attackCooldown := 1.0
	
func _ready() -> void:
	pass
	#await get_tree().create_timer(1.0).timeout
	#attackLeft($"attackSpawn/left/2")

func _process(delta: float) -> void:
		if canAttack == true:
			var phRandom = randi_range(1, 3)
			canAttack = false
			match phRandom:
				1:
					attackTop($"attackSpawn/top/3")
				2:
					attackLeft($"attackSpawn/left/2")
				3:
					attackRight($"attackSpawn/right/2")
			await get_tree().create_timer(attackCooldown).timeout
			canAttack = true



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
