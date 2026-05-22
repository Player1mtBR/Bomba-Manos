extends CanvasLayer

func _ready() -> void:
	visible = false
	get_tree().paused = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_cancel"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		
		else:
			visible = true
			$VBoxContainer/continuar.grab_focus()
			get_tree().paused = true
			

func _on_continuar_pressed() -> void:
	visible = false
	get_tree().paused = false

func _on_sair_pressed() -> void:
	visible = false
	CurrentLevelManager.currentEnemiesAlive = 0
	get_tree().paused = false
	Loader.loadingScreen2Scene("res://scenes/menus/main_menu.tscn")
