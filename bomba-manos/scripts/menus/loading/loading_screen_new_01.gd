extends CanvasLayer

@export_file("*.tscn") var path2Scene : String
#var randValue4Loading = randi_range(10, 30)
var update := 0.0

func _ready() -> void:
	ResourceLoader.load_threaded_request(path2Scene) # carregamento no background
	UnlockStuff.iddqd = false
	#$Control/TextureProgressBar.value = randValue4Loading
	#print(randValue4Loading)
	
func _process(delta: float) -> void:
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(path2Scene, progress)
	
	if progress[0] > update:
		update = progress[0]
	
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		if $Control/TextureProgressBar.value < update:
			$Control/TextureProgressBar.value = lerp($Control/TextureProgressBar.value, update, delta)
	
	if ResourceLoader.load_threaded_get_status(path2Scene) == ResourceLoader.THREAD_LOAD_LOADED:
		$Control/TextureProgressBar.value = 100.0
		set_process(false)
		var newScene : PackedScene = ResourceLoader.load_threaded_get(path2Scene) # var recebe a cena cxarregada
		await get_tree().create_timer(0.25).timeout
		print(newScene)
		get_tree().change_scene_to_packed(newScene)
		
