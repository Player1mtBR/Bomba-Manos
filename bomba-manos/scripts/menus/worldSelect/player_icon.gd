extends Node2D

@export var characterSkin : SpriteFrames

func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = characterSkin
