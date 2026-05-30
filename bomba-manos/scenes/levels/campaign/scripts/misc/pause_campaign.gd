extends CanvasLayer

func _ready() -> void:
	visible = false
	get_tree().paused = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_game"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
			AudioServer.set_bus_effect_enabled(1, 0, false)
		
		else:
			AudioServer.set_bus_effect_enabled(1, 0, true)
			visible = true
			$VBoxContainer/continuar.grab_focus()
			get_tree().paused = true
			

func _on_continuar_pressed() -> void:
	visible = false
	get_tree().paused = false
	AudioServer.set_bus_effect_enabled(1, 0, false)

func _on_sair_pressed() -> void:
	visible = false
	CurrentLevelManager.currentEnemiesAlive = 0
	get_tree().paused = false
	Loader.loadingScreen2Scene("res://scenes/menus/main_menu.tscn")
	if PortalTransition.isPlaying:
		PortalTransition.stopAnim()
	PortalTransition.endAnimation()
	AudioServer.set_bus_effect_enabled(1, 0, false)


func _on_config_pressed() -> void:
	pass # Replace with function body.
