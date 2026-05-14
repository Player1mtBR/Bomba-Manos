@tool #run code in editor, pretty cool
extends Control

@export var worldIndex := 1
@export var go2LevelPacked := load("res://scenes/menus/worldSelectScenes/campaign_level_select_01.tscn") #defaultWorld 2 load

@onready var go2Level : LevelSelect = go2LevelPacked.instantiate()

func _ready() -> void:
	$WorldLabel.text = "(Mundo 0" + str(worldIndex) + ")"
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$WorldLabel.text = "(Mundo 0" + str(worldIndex) + ")"
