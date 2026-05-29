extends Control

@onready var box2Display := $HBoxContainer
@onready var manelCounter := $Sprite2D/ManelCounter

var playerScoreUiScene := preload("res://scenes/menus/ui/player_score_ui.tscn")
var uiElements := []
	
func _process(delta):
	for uiElement in uiElements:
		uiElement.updateUi()
	manelCounter.text = str(VersusScoreManager.draws)

func createUiElements():
#delete after restar
	for uiElement in uiElements:
		uiElement.queue_free()

	uiElements.clear()
	
	print(VersusScoreManager.playerScores)
	for playerId in VersusScoreManager.playerScores.keys():
		print(VersusScoreManager.playerScores)
		var uiInstance = playerScoreUiScene.instantiate()
		box2Display.add_child(uiInstance)
		#await uiInstance.ready
		uiInstance.setupUi(playerId)
		uiElements.append(uiInstance)
