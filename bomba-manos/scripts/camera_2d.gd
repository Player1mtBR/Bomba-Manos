extends Camera2D

var cameraShakeStrength = 0.0
var cameraOffset = 1.5

func _process(delta: float) -> void:
	if GlobalScript.triggerCameraShake == true:
		cameraShakeStrength = lerp(5.0, 0.0, delta) ##interpolate the shake stregght to 0 with delta as weight
		offset.x = randf_range(-cameraOffset, cameraOffset)
		offset.y = randf_range(-cameraOffset, cameraOffset)
		await get_tree().create_timer(0.5).timeout
		GlobalScript.triggerCameraShake = false
