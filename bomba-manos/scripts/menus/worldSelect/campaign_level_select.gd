extends Control

class_name LevelSelect

@onready var currentLevel :=  $LevelIcon
var currentWorld := 0
var return2WorldSelect : Node

func _ready() -> void:
	$playerIcon.global_position = currentLevel.global_position
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_left") and currentLevel.nextLevelLeft and currentLevel.nextLevelLeft.locked == false:
		currentLevel = currentLevel.nextLevelLeft
		$playerIcon.global_position = currentLevel.global_position
		
	if event.is_action_pressed("menu_right") and currentLevel.nextLevelRight and currentLevel.nextLevelRight.locked == false:
		currentLevel = currentLevel.nextLevelRight
		$playerIcon.global_position = currentLevel.global_position
		
	if event.is_action_pressed("menu_up") and currentLevel.nextLevelUp:
		currentLevel = currentLevel.nextLevelUp
		$playerIcon.global_position = currentLevel.global_position
		
	if event.is_action_pressed("menu_down") and currentLevel.nextLevelDown:
		currentLevel = currentLevel.nextLevelDown
		$playerIcon.global_position = currentLevel.global_position
		
	if event.is_action_pressed("menu_accept"):
		if currentLevel.level2Load:
			Loader.loadingScreen2Scene(currentLevel.level2Load)
		
	if event.is_action_pressed("menu_cancel"):
		get_tree().get_root().add_child(return2WorldSelect)
		get_tree().current_scene = return2WorldSelect
		get_tree().get_root().remove_child(self)
		
	
