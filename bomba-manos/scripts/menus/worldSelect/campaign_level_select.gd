extends Control

class_name LevelSelect

@onready var currentLevel :=  $LevelIcon
var currentWorld := 0
var return2WorldSelect : Node

func _ready() -> void:
	$playerIcon.global_position = currentLevel.global_position
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_left") and currentLevel.next_level_left:
		currentLevel = currentLevel.next_level_left
		$playerIcon.global_position = currentLevel.global_position
		
	if event.is_action_pressed("menu_right") and currentLevel.next_level_right:
		currentLevel = currentLevel.next_level_right
		$playerIcon.global_position = currentLevel.global_position
		
	if event.is_action_pressed("menu_up") and currentLevel.next_level_up:
		currentLevel = currentLevel.next_level_up
		$playerIcon.global_position = currentLevel.global_position
		
	if event.is_action_pressed("menu_down") and currentLevel.next_level_down:
		currentLevel = currentLevel.next_level_down
		$playerIcon.global_position = currentLevel.global_position
		
	if event.is_action_pressed("menu_cancel"):
		get_tree().get_root().add_child(return2WorldSelect)
		get_tree().current_scene = return2WorldSelect
		get_tree().get_root().remove_child(self)
		
	
