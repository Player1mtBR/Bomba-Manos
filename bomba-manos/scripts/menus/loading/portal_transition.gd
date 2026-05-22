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


func _on_timer_timeout() -> void:
	isPlaying = false
