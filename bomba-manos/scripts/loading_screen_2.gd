extends Node2D
@export var loadingScene := 1
@onready var selectPlayer := preload("res://scenes/PlayerSelector.tscn")
@onready var labScene := preload("res://scenes/levels/lab_test_01.tscn")

func _ready() -> void:
	if loadingScene == 1:
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_packed(selectPlayer)
		
	if loadingScene == 2:
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(labScene)
