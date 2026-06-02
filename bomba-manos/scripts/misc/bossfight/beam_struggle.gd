extends Node2D

var beamStruggleValue := 50.0
var percent2move : float
var toggleManelPower := false
var isActive := false

func _ready() -> void:
	$TextureProgressBar.value = beamStruggleValue

func _process(delta: float) -> void:
	if isActive == true:
		#$TextureProgressBar.value = beamStruggleValue
		percent2move = beamStruggleValue / $TextureProgressBar.max_value
		$TextureProgressBar/Sprite2D.position.x = lerp($TextureProgressBar/Sprite2D.position.x, (1.0 - percent2move) * $TextureProgressBar.size.x, delta)
		
		if toggleManelPower == true:
			beamStruggleValue -= 10 * delta
		else:
			beamStruggleValue -= 3.5 * delta
			
		if $TextureProgressBar.value != beamStruggleValue:
			$TextureProgressBar.value = lerp($TextureProgressBar.value, beamStruggleValue, delta)
		
		if Input.is_action_just_pressed("p1_bomb"):
			if beamStruggleValue <= 102:
				beamStruggleValue += 3
		if beamStruggleValue >= 100.0:
			isActive = false
			$"../AnimationPlayer".play("win")
			await get_tree().create_timer(3.0, false).timeout
			Loader.loadingScreen2Scene("res://scenes/cutscenes/cutscene_03.tscn")
		if beamStruggleValue <= -10.0:
			isActive = false
			$"../MegazordJP".killMegazord()
		

func _on_timer_timeout() -> void:
	toggleManelPower = !toggleManelPower
	$Timer.start()
