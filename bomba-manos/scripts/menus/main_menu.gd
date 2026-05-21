extends Control

func _ready() -> void:
	$Control/Buttons/VBoxContainer/Campanha.grab_focus()
	
func _process(delta: float) -> void:
	UnlockStuff.isOnMenu = true
	
func _on_campanha_pressed() -> void:
	UnlockStuff.isOnMenu = false
	Loader.loadingScreen2Scene("res://scenes/menus/worldSelectScenes/campaign_world_select.tscn")
	
func _on_versus_pressed() -> void:
	UnlockStuff.isOnMenu = false
	Loader.loadingScreen2Scene("res://scenes/menus/versusMatchSetupTest.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()
