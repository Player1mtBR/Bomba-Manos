extends CanvasLayer

var isPlaying := false

func startAnimation():
	isPlaying = true
	$AnimationPlayer.play("in")
	$Timer.start()
	
func endAnimation():
	isPlaying = true
	$AnimationPlayer.play("out")
	$Timer.start()

func saveAnimation():
	#isPlaying = true
	$AnimationPlayer2.play("saved")
	
func cheatAnimation():
	#isPlaying = true
	$AnimationPlayer2.play("cheats")

func _on_timer_timeout() -> void:
	isPlaying = false
