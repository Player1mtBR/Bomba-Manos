extends Node

var currentEnemiesAlive := 0
var isPlayer1Dead := false
var currentLevelName : String
var campaignMap := false
var levelComplete := false
var deathCount := 0

func _process(delta: float) -> void:
	pass
	#print("Enemies alive: ",currentEnemiesAlive)
	
func decreaseEnemyCount():
	currentEnemiesAlive -= 1
	
func restartLevel():
	currentEnemiesAlive = 0
	var currentScenePath = get_tree().current_scene.scene_file_path
	Loader.loadingScreen2Scene(currentScenePath)
