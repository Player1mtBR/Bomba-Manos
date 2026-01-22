extends Node2D

@onready var voiceLines = $voiceLines


@onready var voice01 = $voiceLines/nComamBomba
@onready var voice02 = $voiceLines/risada
@onready var voice03 = $voiceLines/taComendoBombaDenovo


func _process(delta: float) -> void:
	if GlobalScript.manelBombasCount == 3:
		playVoice(randi_range(1, 3))
		GlobalScript.manelBombasCount = 0
		
		
## mudar implementacao dps
func playVoice(voice):
	#var voiceStr = str(voice)
	match voice:
		1:
			voice01.play()
		
		2:
			voice02.play()
			
		3:
			voice03.play()
