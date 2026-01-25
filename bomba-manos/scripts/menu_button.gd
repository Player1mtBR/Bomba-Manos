extends Control
@onready var SelectPlayer := preload("res://scenes/PlayerSelector.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(SelectPlayer)
	
func _on_button_2_pressed() -> void:
	get_tree().quit()
