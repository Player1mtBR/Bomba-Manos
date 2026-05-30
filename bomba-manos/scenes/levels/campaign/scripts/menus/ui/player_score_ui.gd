extends Control

@onready var characterIcon := $CharIcon
@onready var deadMarker := $CharIcon/DeadMarker
@onready var killsLabel := $killcount/killcountValue
@onready var winsLabel := $wincount/wincountLabel
var playerId := 0

func setupUi(setPlayerId):
	playerId = setPlayerId
	updateUi()
	
func updateUi():
	if not VersusScoreManager.playerScores.has(playerId):
		return
	var getFromScoreManager = VersusScoreManager.playerScores[playerId]
	
	#print("UI UPDATE | player:",playerId," | data: ",getFromScoreManager)

#character icon
	if getFromScoreManager["character"] != null:
		characterIcon.texture = VersusMatchSettings.characterList[getFromScoreManager["character"]]["icon"]

	killsLabel.text = str(getFromScoreManager["kills"])
	#print("kills", getFromScoreManager["kills"])
	winsLabel.text = str(getFromScoreManager["wins"])
	#print("wins", getFromScoreManager["wins"])
	deadMarker.visible = not getFromScoreManager["alive"]
	

	
func getCharacterIcon(characterRes):
	for characterId in VersusMatchSettings.characterList:
		if VersusMatchSettings.characterList[characterId] == characterRes:
			return VersusMatchSettings.characterIcons[characterId]
	return null
