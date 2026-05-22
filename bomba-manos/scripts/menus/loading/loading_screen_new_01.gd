extends CanvasLayer

@export_file("*.tscn") var path2Scene : String

func _ready() -> void:
	ResourceLoader.load_threaded_request(path2Scene) # carregamento no background
	UnlockStuff.iddqd = false
	
func _process(delta: float) -> void:
	if ResourceLoader.load_threaded_get_status(path2Scene) == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		var newScene : PackedScene = ResourceLoader.load_threaded_get(path2Scene) # var recebe a cena cxarregada
		get_tree().change_scene_to_packed(newScene)
