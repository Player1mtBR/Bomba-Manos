@tool #run code in editor, pretty cool
extends Control
class_name LevelIcon

@export var level_name := "1"

@export var next_level_left : LevelIcon
@export var next_level_right : LevelIcon
@export var next_level_up : LevelIcon
@export var next_level_down : LevelIcon



func _ready() -> void:
	$WorldLabel.text = "(Nível " + level_name + ")"
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$WorldLabel.text = "(Nível " + level_name + ")"
