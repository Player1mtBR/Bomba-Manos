extends Node

func loadingScreen2Scene(scenetarget: String):
	var loadingScreen = preload("res://scenes/menus/loading/loading_screen_new_01.tscn").instantiate()
	loadingScreen.path2Scene = scenetarget
	get_tree().current_scene.add_child(loadingScreen)
