extends Node2D

@export_file("*.tscn") var toLevelFile : String

func _ready() -> void:
	MusicMenu.get_child(0).stop()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_cancel") or event.is_action_pressed("menu_accept"):
		Loader.loadingScreen2Scene(toLevelFile)

func _on_video_stream_player_finished() -> void:
	Loader.loadingScreen2Scene(toLevelFile)
