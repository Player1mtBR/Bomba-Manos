extends Node2D

@onready var raycastsBomba := $raycasts
@onready var explosionScene := preload("res://scenes/explosion_test.tscn")

@export var blastRadius := 2

var tileSize := 16

var raycastFirstTarget

func _ready():
	kaboom()
	
func kaboom():
	await get_tree().create_timer(3.0).timeout
	#print("MIBOOMBA")
	spawnExplosion(global_position)
	checkCollision()
	queue_free() ## deleta o node da cena


func checkCollision():
	for bombaRaycasts in raycastsBomba.get_children():
		if bombaRaycasts.is_colliding():
			var bombaCollider = bombaRaycasts.get_collider()
			print(bombaRaycasts.get_collider().name)
			if bombaCollider.name == "StaticBody2D" or bombaCollider.name == "gridPlayer01":
				spawnExplosion(bombaRaycasts.global_position + bombaRaycasts.target_position)
			
		else:
			var distanceExploded := 0
			while distanceExploded < blastRadius and bombaRaycasts.is_colliding() == false:
				distanceExploded += 1
				#print("before", bombaRaycasts.position)
				bombaRaycasts.global_position += bombaRaycasts.target_position
				#print("after", bombaRaycasts.position)
				bombaRaycasts.force_raycast_update()
				spawnExplosion(bombaRaycasts.global_position)#* Vector2(1, 1) * distanceExploded)
			if bombaRaycasts.is_colliding() and distanceExploded < blastRadius:
					var bombaCollider = bombaRaycasts.get_collider()
					#print(bombaRaycasts.get_collider().name)
					if bombaCollider.name == "StaticBody2D":
						spawnExplosion(bombaRaycasts.global_position + bombaRaycasts.target_position)

				
			
func spawnExplosion(explosionSpawnPosition := Vector2()):
	var newExplosion = explosionScene.instantiate()
	newExplosion.position = explosionSpawnPosition
	get_tree().root.add_child(newExplosion)
