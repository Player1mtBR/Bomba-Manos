extends Node2D

@onready var animPlayer := $AnimatedSprite2D

func _ready() -> void:
	animPlayer.play("kaboom")
	await animPlayer.animation_finished
	queue_free()
