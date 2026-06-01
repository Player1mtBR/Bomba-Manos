extends Control

func _ready() -> void:
	VersusScoreManager.resetScores()
	
	$AnimationPlayer.play("menu_intro")
	$Control/start.grab_focus()
	CurrentLevelManager.deathCount = 0

	for child in $Control/Buttons/VBoxContainer.get_children():

		if child is Button:
			child.focus_entered.connect(_onButtonFocused)
			child.pressed.connect(_onButtonPressed)
	
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("await_start_press")

func _onButtonFocused():

	if $buttonDefaultSfx.playing:
		$buttonDefaultSfx.stop()

	$buttonDefaultSfx.play()
	
func _onButtonPressed():
	$buttonSelectSfx.play()

func _process(delta: float) -> void:
	UnlockStuff.isOnMenu = true
	
func _on_campanha_pressed() -> void:
	UnlockStuff.isOnMenu = false
	Loader.loadingScreen2Scene("res://scenes/cutscenes/cutscene_01.tscn")
	
func _on_versus_pressed() -> void:
	UnlockStuff.isOnMenu = false
	Loader.loadingScreen2Scene("res://scenes/menus/versusMatchSetupTest.tscn")

func _on_configurações_pressed() -> void:
	$settingsMenu.settings_focus()

func _on_créditos_pressed() -> void:
	Loader.loadingScreen2Scene("res://scenes/menus/credits.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	$AnimationPlayer.play("buttons_show")
	$startSfx.play()
	MusicMenu.get_child(0).play()
	
	$Control/start.visible = false
	$Control/Buttons/VBoxContainer.visible = true
	$Control/Buttons/VBoxContainer/Campanha.grab_focus()
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("loop")
	
