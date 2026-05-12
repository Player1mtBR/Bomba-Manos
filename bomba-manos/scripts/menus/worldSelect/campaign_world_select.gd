extends Control

@onready var worldList :=  [$WorldIcon, $WorldIcon2, $WorldIcon3, $WorldIcon4, $WorldIcon5]
var currentWorld := 0

var lockedWorld05 := true #placeholder var

func _ready() -> void:
	$playerIcon.global_position = worldList[currentWorld].global_position
	
	if lockedWorld05 == true: #placeholder
		worldList.pop_back()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_left") and currentWorld > 0:
		currentWorld -= 1
		$playerIcon.global_position = worldList[currentWorld].global_position
	
	if event.is_action_pressed("menu_right") and currentWorld < (worldList.size() - 1) :
		currentWorld += 1
		$playerIcon.global_position = worldList[currentWorld].global_position
		
		
	if event.is_action_pressed("menu_accept"):
		if worldList[currentWorld].go_2_level:
			worldList[currentWorld].go_2_level.return2WorldSelect = self
			#loading shenanigans
			get_tree().get_root().add_child(worldList[currentWorld].go_2_level)
			get_tree().current_scene = worldList[currentWorld].go_2_level
			get_tree().get_root().remove_child(self)
			
