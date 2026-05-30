extends Node2D

@export_file("*.tscn") var toLevelFile : String
@export var awaitBeforeLoad : float

func _ready() -> void:
	MusicMenu.get_child(0).stop()
	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.play("default")
		await get_tree().create_timer(awaitBeforeLoad, false).timeout
		PortalTransition.bossIn()
		await get_tree().create_timer(1.5, false).timeout
		Loader.loadingScreen2Scene(toLevelFile)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_cancel") or event.is_action_pressed("pause_game"): #or event.is_action_pressed("menu_accept"):
		Loader.loadingScreen2Scene(toLevelFile)

func _on_video_stream_player_finished() -> void:
	pass
#	Loader.loadingScreen2Scene(toLevelFile)
