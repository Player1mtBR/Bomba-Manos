@tool #run code in editor, pretty cool
extends Control

@export var world_index := 1
@export var go_2_level_packed := load("res://scenes/menus/worldSelectScenes/campaign_level_select_01.tscn") #defaultWorld 2 load

@onready var go_2_level : LevelSelect = go_2_level_packed.instantiate()

func _ready() -> void:
	$WorldLabel.text = "(Mundo 0" + str(world_index) + ")"
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$WorldLabel.text = "(Mundo 0" + str(world_index) + ")"
