extends Node2D

@onready var raycastsBomba := $raycasts
@onready var explosionScene := preload("res://scenes/explosion_test.tscn")

@export var blastRadius := 2

var raycastFirstTarget

func _ready():
	kaboom()
	
func kaboom():
	await get_tree().create_timer(3.0).timeout
	print("MIBOOMBA")
	checkCollision()
	queue_free() ## deleta o node da cena

"""
************************
IGNORAR, Ñ ESTÁ PRONTO
************************
"""


func checkCollision():
	print("chamou checkCollision ok")
	var raycastTempColliders := [] ## guarda lugar dos colliders
	var raycastFinalColliders := [] ## spawna a explosao na colisao
	
	for bombaRaycasts in raycastsBomba.get_children():
		print("chamou get_child ok")
		var raycastFirstTarget = bombaRaycasts.target_position
		
		for tile in blastRadius: ##repete de acordo coom o alcançe
			print("chamou quadradins ok")
			bombaRaycasts.target_position = raycastFirstTarget * (Vector2(1, 1) * (tile + 1)) ##pula pra proxima posição
			print(bombaRaycasts.target_position)
			print("ir pra raycast")
			if bombaRaycasts.is_colliding():
				print("chamou checarColisaoRaydfefe ok")
				var bombaCollider = bombaRaycasts.get_collider() ##pega o q q ta colidindo
				print(bombaCollider)
				
				raycastTempColliders.append(bombaCollider) ##add o q ta colidindo na array
				bombaRaycasts.add_exception(bombaCollider) ##add como exceção pra ñ colidir dnv
				bombaRaycasts.force_raycast_update()##atualiza pra checar a colisao na nova posicao
			else:
				print("n ta colidindo")
				break ## se ñ ta colidindo, sai do loop
			
	## removendo raycasts duplicados
	for bombaCollider in raycastTempColliders: ## loop pelos colliders temp
		if not bombaCollider in raycastFinalColliders: ## add na array definitiva
			raycastFinalColliders.append(bombaCollider)

	for bombaCollider in raycastFinalColliders: ## explodir em cada posição de collider
		print(raycastFinalColliders)
		spawnExplosion(bombaCollider)
		
func spawnExplosion(bombaCollider):
	var newExplosion = explosionScene.instantiate()
	newExplosion.global_position = bombaCollider.global_position
	get_tree().root.add_child(newExplosion)
