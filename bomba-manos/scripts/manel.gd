extends Node2D

@onready var voiceLines := $voiceLines
@onready var animPlayer := $AnimatedSprite2D

@onready var voice01 := $voiceLines/nComamBomba
@onready var voice02 := $voiceLines/risada
@onready var voice03 := $voiceLines/taComendoBombaDenovo

var canMove := true
var moveSpeed := 25
var moveLeft2Right := true
var wonMatch := false


func _process(delta: float) -> void:
	#if GlobalScript.currentPlayers == 0 and canMove == true:
	if GlobalScript.MANEL_WINS == true and canMove == true:
		victoryPose()
	
	if GlobalScript.manelBombasCount == 10:
		playVoice(randi_range(1, 3))
		GlobalScript.manelBombasCount = 0
		
	if GlobalScript.triggerLaugh == true:
		GlobalScript.triggerLaugh = false
		playVoice(2)
		
	if canMove == true and GlobalScript.MANEL_WINS == false:
		if moveLeft2Right == true:
			position.x += moveSpeed * delta
			
			if position.x >= 90.0:
				moveLeft2Right = !moveLeft2Right
			
		else:
			position.x -= moveSpeed * delta
			
			if position.x <= -90.0:
				moveLeft2Right = !moveLeft2Right
				
		
		
		
## mudar implementacao dps
func playVoice(voice):
	canMove = false
	#var voiceStr = str(voice)
	match voice:
		1:
			voice01.play()
			animPlayer.play("talk")
			await get_tree().create_timer(2.4).timeout
			
		2:
			voice02.play()
			animPlayer.play("laugh")
			await get_tree().create_timer(2.1).timeout
			
		3:
			voice03.play()
			animPlayer.play("talk")
			await get_tree().create_timer(2.5).timeout
			
	if wonMatch == false:
		animPlayer.play("walking")
		canMove = true
			
func victoryPose():
	canMove = false
	wonMatch = true
	await get_tree().create_timer(0.5).timeout
	GlobalScript.MANEL_WINS = false
	#wonMatch = true
	animPlayer.play("laugh")
	voice02.play()
	#await voice02.finished
	print("manel victory pose")
	GlobalScript.addPoint2Player(0) ##Manel ID = 0
	await get_tree().create_timer(5.0).timeout
	GlobalScript.restartLevel()
