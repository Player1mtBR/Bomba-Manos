extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_cancel"):
		Loader.loadingScreen2Scene("res://scenes/menus/main_menu.tscn")
