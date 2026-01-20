extends Node2D

var canSpawn := 1

func _ready() -> void:
	canSpawn = randi_range(0, 1) ##random int, se for igual a zero o bloco ñ spawna
	if canSpawn == 0:
		destroy()

func destroy():
	$AnimatedSprite2D.play("destroy")
	await get_tree().create_timer(1.0).timeout
	queue_free()
