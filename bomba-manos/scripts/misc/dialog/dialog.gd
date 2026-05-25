extends Node2D

@onready var tocadorDeSom := $AudioStreamPlayer

@export var falasDosPersonagens : Array[AudioStream] = []

var shouldStart := true
var dialogIndex := 0

func _ready() -> void:
	await get_tree().create_timer(3.0, false).timeout
	$Visual.visible = true
	
	dialogIndex = 0
	if falasDosPersonagens.size() > 0:
		playDialog()
		
func playDialog():
	tocadorDeSom.stream = falasDosPersonagens[dialogIndex]
	tocadorDeSom.play()
	await tocadorDeSom.finished
	dialogIndex += 1
	
	if dialogIndex < falasDosPersonagens.size():
		playDialog()
	else:
		$Visual.visible = false
