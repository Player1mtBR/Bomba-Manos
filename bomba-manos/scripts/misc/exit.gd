extends Node2D

@export var levelIdentifier : String
#@export var nextLevelName : String
#@export var currentWorld := 0
#@export var currentLevel := 0
@export_file("*.tscn") var nextLevel : String

#var worldIndentifierString : String = "W0"+str(currentWorld)+"L0"+str(currentLevel)

func _ready() -> void:
	CurrentLevelManager.currentLevelName = levelIdentifier
	CurrentLevelManager.campaignMap = true

func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name == "Area2Dplayer":
		CurrentLevelManager.levelComplete = true
		Loader.loadingScreen2Scene(nextLevel)
		#UnlockStuff.
		UnlockStuff.completedLevels[levelIdentifier] = true
		print(UnlockStuff.completedLevels[levelIdentifier], " Completed")

func _process(delta: float) -> void:
	if CurrentLevelManager.currentEnemiesAlive <= 0:
		visible = true
		$Area2D.monitoring = true
