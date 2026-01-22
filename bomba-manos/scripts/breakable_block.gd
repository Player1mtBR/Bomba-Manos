extends Node2D

@onready var blockRaycast = $RayCast2D

var canSpawn := 1

func _ready() -> void:
	canSpawn = randi_range(0, 1) ##random int, se for igual a zero o bloco ñ spawna
	if canSpawn == 0:
		queue_free()

func _process(delta: float) -> void:
	pass
	#if blockRaycast.is_colliding():
	#	if blockRaycast.get_collider().name == "ExplosionArea":
	#		destroy()

func destroy():
	$AnimatedSprite2D.play("destroy")
	await get_tree().create_timer(1.0).timeout
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
	#print(body.name)
	#if body.name == "ExplosionBody":
	#	destroy()


func _on_area_2d_area_entered(area: Area2D) -> void:
	#print(area.name)
	if area.name == "ExplosionArea":
		destroy()
