extends Node2D

@onready var tocadorDeSom := $AudioStreamPlayer

@export var falasDosPersonagens : Array[AudioStream] = []
@export var legendas : Array[String] = []

@onready var coisosArray : Array[Sprite2D] = [
	$"Visual/coisos/1",
	$"Visual/coisos/2",
	$"Visual/coisos/3",
	$"Visual/coisos/4",
	$"Visual/coisos/5",
	$"Visual/coisos/6",
	$"Visual/coisos/7",
	$"Visual/coisos/8",
	$"Visual/coisos/9"
]

var shouldStart := true
var dialogIndex := 0

func _ready() -> void:
	await get_tree().create_timer(2.0, false).timeout
	$Visual.visible = true
	$Visual/AnimationPlayer2.play("fade")
	$Visual/AnimationPlayer.play("talk")
	
	dialogIndex = 0
	if falasDosPersonagens.size() > 0:
		playDialog()
		
func _process(delta: float) -> void:
	if $Visual.visible == true:
		#modulateEqualizerEffect()
		if $Visual/Label.visible_ratio < 1.0:
			#await get_tree().create_timer(2, false).timeout
			$Visual/Label.visible_ratio += 0.025
		
func playDialog():
	$Visual/Label.visible_ratio = 0.0
	$Visual/Label.text = legendas[dialogIndex]
	tocadorDeSom.stream = falasDosPersonagens[dialogIndex]
	tocadorDeSom.play()
		
	await tocadorDeSom.finished
	dialogIndex += 1
	
	if dialogIndex < falasDosPersonagens.size():
		playDialog()
	else:
		$Visual/AnimationPlayer2.play_backwards("fade")
		await $Visual/AnimationPlayer2.animation_finished
		$Visual.visible = false

func modulateEqualizerEffect():
	for coiso in coisosArray:
		coisosArray[coiso].scale.y = randf_range(-0.5, -0.01)
		
