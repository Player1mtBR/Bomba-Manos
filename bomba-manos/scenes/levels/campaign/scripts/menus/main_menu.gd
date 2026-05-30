extends Control

func _ready() -> void:
#	$Control/start.grab_focus()
	$Control/Buttons/VBoxContainer/Campanha.grab_focus()
	CurrentLevelManager.deathCount = 0
	if MusicMenu.get_child(0).playing == false:
		MusicMenu.get_child(0).play()
	
func _process(delta: float) -> void:
	UnlockStuff.isOnMenu = true
	
func _on_campanha_pressed() -> void:
	UnlockStuff.isOnMenu = false
	Loader.loadingScreen2Scene("res://scenes/cutscenes/cutscene_01.tscn")
	
func _on_versus_pressed() -> void:
	UnlockStuff.isOnMenu = false
	Loader.loadingScreen2Scene("res://scenes/menus/versusMatchSetupTest.tscn")

func _on_configurações_pressed() -> void:
	Loader.loadingScreen2Scene("res://scenes/menus/settings.tscn")

func _on_créditos_pressed() -> void:
	Loader.loadingScreen2Scene("res://scenes/menus/credits.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	$Control/start.visible = false
	$Control/Buttons/VBoxContainer.visible = true
	$Control/Buttons/VBoxContainer/Campanha.grab_focus()
