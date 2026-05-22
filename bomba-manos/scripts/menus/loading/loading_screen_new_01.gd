extends CanvasLayer

@export_file("*.tscn") var path2Scene : String
var randValue4Loading = randi_range(10, 30)

func _ready() -> void:
	ResourceLoader.load_threaded_request(path2Scene) # carregamento no background
	UnlockStuff.iddqd = false
	$Control/TextureProgressBar.value = randValue4Loading
	printt(randValue4Loading)
	
func _process(delta: float) -> void:
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(path2Scene, progress)
	
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		$Control/TextureProgressBar.value = progress[0] * 100
	
	if ResourceLoader.load_threaded_get_status(path2Scene) == ResourceLoader.THREAD_LOAD_LOADED:
		$Control/TextureProgressBar.value = 100.0
		set_process(false)
		var newScene : PackedScene = ResourceLoader.load_threaded_get(path2Scene) # var recebe a cena cxarregada
		#await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_packed(newScene)
