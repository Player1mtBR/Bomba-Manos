extends Node2D
@onready var SelectPlayer := preload("res://scenes/PlayerSelector.tscn")
func _on_pressed() -> void:
	SelectPlayer.instace()


func _on_button_2_pressed() -> void:
	pass
