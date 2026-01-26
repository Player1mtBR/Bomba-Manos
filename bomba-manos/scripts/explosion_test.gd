extends Node2D

@export var animDir := 0

@onready var animPlayer := $AnimatedSprite2D
@onready var audioPlayer := $AudioStreamPlayer2D

func _ready() -> void:
	#print(position)
	match animDir: ##switch
		0:
			#audioPlayer.playing = true
			animPlayer.play("kaboom")
			
		1:
			animPlayer.play("upMid")
			
		11:
			animPlayer.play("upEnd")
			
		2:
			animPlayer.play("downMid")
		
		22:
			animPlayer.play("downEnd")
		
		3:
			animPlayer.play("leftMid")
			
		33:
			animPlayer.play("leftEnd")
			
		4:
			animPlayer.play("rightMid")
		
		44:
			animPlayer.play("rightEnd")
			
			
	await animPlayer.animation_finished
	queue_free()
