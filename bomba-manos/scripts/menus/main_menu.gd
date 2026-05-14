extends Control

func _ready() -> void:
	$Control/Buttons/VBoxContainer/Campanha.grab_focus()
	
func _process(delta: float) -> void:
	pass
	
func _on_campanha_pressed() -> void:
	Loader.loadingScreen2Scene("res://scenes/menus/worldSelectScenes/campaign_world_select.tscn")
