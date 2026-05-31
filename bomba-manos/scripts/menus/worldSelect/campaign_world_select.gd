extends Control

@onready var worldList :=  [$WorldIcon, $WorldIcon2, $WorldIcon3, $WorldIcon4, $WorldIcon5]
var currentWorld := 0

func _ready() -> void:
	if PortalTransition.isPlaying == false:
		PortalTransition.endAnimation()
	if MusicMenu.get_child(0).playing == false:
		MusicMenu.get_child(0).play()
	$playerIcon.global_position = worldList[currentWorld].global_position
	
	if UnlockStuff.world05Unlocked == false: #placeholder
		worldList.pop_back()
		$WorldIcon5/locked.visible = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_left") and currentWorld > 0:
		currentWorld -= 1
		$playerIcon.global_position = worldList[currentWorld].global_position
	
	if event.is_action_pressed("menu_right") and currentWorld < (worldList.size() - 1) :
		currentWorld += 1
		$playerIcon.global_position = worldList[currentWorld].global_position
		
		
	if event.is_action_pressed("menu_accept"):
		if worldList[currentWorld].go2Level:
			worldList[currentWorld].go2Level.return2WorldSelect = self
			#loading shenanigans
			get_tree().get_root().add_child(worldList[currentWorld].go2Level)
			get_tree().current_scene = worldList[currentWorld].go2Level
			get_tree().get_root().remove_child(self)
	if event.is_action_pressed("menu_cancel"):
		Loader.loadingScreen2Scene("res://scenes/menus/main_menu.tscn")
			
func _process(delta: float) -> void:
	if UnlockStuff.world05Unlocked == true:
		worldList.append($WorldIcon5)
		$WorldIcon5/locked.visible = false
