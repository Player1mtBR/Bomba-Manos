extends Node2D

@export_file("*.tscn") var nextLevel : String

func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name == "Area2Dplayer":
		Loader.loadingScreen2Scene(nextLevel)
