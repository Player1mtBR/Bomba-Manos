@tool #run code in editor, pretty cool
extends Control
class_name LevelIcon

@export var levelName := "1"
@export_file("*.tscn") var level2Load : String
@export var levelIconTexture : Texture

@export var unlockRequirement : String = ""
@export var locked := false

@export var nextLevelLeft : LevelIcon
@export var nextLevelRight : LevelIcon
@export var nextLevelUp : LevelIcon
@export var nextLevelDown : LevelIcon



func _ready() -> void:
	$WorldLabel.text = "(Nível " + levelName + ")"
	if levelIconTexture != null:
		$Sprite2D.texture = levelIconTexture
	
	if unlockRequirement != "":
		locked = !UnlockStuff.completedLevels[unlockRequirement]
	
	if locked == true:
		$locked.visible = true
	
func _process(delta: float) -> void:
	
	
	if Engine.is_editor_hint():
		$WorldLabel.text = "(Nível " + levelName + ")"
