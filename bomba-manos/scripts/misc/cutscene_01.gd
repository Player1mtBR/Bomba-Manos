extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_cancel") or event.is_action_pressed("menu_accept"):
		Loader.loadingScreen2Scene("res://scenes/menus/worldSelectScenes/campaign_world_select.tscn")



func _on_video_stream_player_finished() -> void:
	Loader.loadingScreen2Scene("res://scenes/menus/worldSelectScenes/campaign_world_select.tscn")
