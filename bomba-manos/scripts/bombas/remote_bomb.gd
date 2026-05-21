extends Node2D

@onready var raycastsBomba := $raycasts
@onready var chainReaction := $ChainReactionArea
@onready var bombBlocksPlayer := $bombBlocksPlayer/CollisionShape2D
@onready var audioPlayer := $AudioStreamPlayer2D
@onready var kaboomAudio := $AudioStreamPlayer2D2


@onready var explosionScene := preload("res://scenes/objects/bombas/explosion_base.tscn")

@export var blastRadius := 2 #base = 2

var tileSize := 16

func _ready():
	audioPlayer.playing = true
	#await get_tree().create_timer(3.0).timeout
	#GlobalScript.triggerBombaSfx = true
	#kaboom()
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("p1_bomb"):
		if $Timer.is_stopped():
			$Timer.start()
	
	if Input.is_action_just_released("p1_bomb"):
		$Timer.stop()
	
func kaboom():
	print("kaboom")
	GlobalScript.triggerCameraShake = true
	spawnExplosion(0, global_position)
	checkCollision()
	#await audioPlayer2.finished
	queue_free() ## deleta o node da cena
	
	"""
	kaboomAudio.playing = true
	$ChainReactionArea/CollisionShape2D.set_deferred("disabled", true)
	$bombBlocksPlayer/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(1.0).timeout
	call_deferred("queue_free") ## deleta o node da cena
	"""


func checkCollision():
	for bombaRaycasts in raycastsBomba.get_children():
		var setExplosionAnim := 0
		if bombaRaycasts.is_colliding():
			var bombaCollider = bombaRaycasts.get_collider()
			#print(bombaRaycasts.get_collider().name)
			if bombaCollider.name == "StaticBody2D" or bombaCollider.name == "gridPlayer01":
				
				spawnExplosion(setExplosionAnim, bombaRaycasts.global_position + bombaRaycasts.target_position)
			
		else:
			var distanceExploded := 0
			
			while distanceExploded < blastRadius and bombaRaycasts.is_colliding() == false:
				distanceExploded += 1
				#print("before", bombaRaycasts.position)
				bombaRaycasts.global_position += bombaRaycasts.target_position
				#print("after", bombaRaycasts.position)
				bombaRaycasts.force_raycast_update()
				
				if bombaRaycasts.target_position.y < 0: # cima
					setExplosionAnim = 1
					print(1)
					if distanceExploded == blastRadius:
						setExplosionAnim = 11
						print(11)
					#print("KABOOM DIST: ",distanceExploded)
					
						
				if bombaRaycasts.target_position.y > 0: # baixo
					setExplosionAnim = 2
					if distanceExploded == blastRadius:
						setExplosionAnim = 22
						
				if bombaRaycasts.target_position.x < 0: # esquerda
					setExplosionAnim = 3
					if distanceExploded == blastRadius:
						setExplosionAnim = 33
						
				if bombaRaycasts.target_position.x > 0: # direita
					setExplosionAnim = 4
					if distanceExploded == blastRadius:
						setExplosionAnim = 44
						
				spawnExplosion(setExplosionAnim, bombaRaycasts.global_position)
				
			if bombaRaycasts.is_colliding() and distanceExploded < blastRadius:
					var bombaCollider = bombaRaycasts.get_collider()
					#print(bombaRaycasts.get_collider().name)
					
					if bombaCollider.name == "StaticBody2D":
						spawnExplosion(setExplosionAnim, bombaRaycasts.global_position + bombaRaycasts.target_position)

				
			
func spawnExplosion(setExplosionAnim, explosionSpawnPosition := Vector2()):
	var newExplosion = explosionScene.instantiate()
	newExplosion.position = explosionSpawnPosition
	#match :
	
	
	newExplosion.animDir = setExplosionAnim
	get_tree().root.call_deferred("add_child", newExplosion) ##spawn fixed


func _on_chain_reaction_area_area_entered(area: Area2D) -> void:
	if area.name == "ExplosionArea":
		kaboom()


func _on_timer_timeout() -> void:
	kaboom()
