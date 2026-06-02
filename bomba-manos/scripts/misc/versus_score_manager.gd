extends Node

var playerScores := {}
var draws := 0
var matchEnded := false
var addKill := 0

var checkingIfMatchEnded := false

signal drawRegistered
signal killRegistered

func setupPlayers():
	matchEnded = false

	for i in range(VersusMatchSettings.playerCount):
		var playerId = i + 1
			
		if not playerScores.has(playerId): #will chewck if the dict has the current player id
			playerScores[playerId] = {
				"kills": 0,
				"wins": 0,
				"alive": true,
				"character": getCharFromPlayer(playerId)
			}
#reset only the alive value
		playerScores[playerId]["alive"] = true 


func getCharFromPlayer(playerId):
	match playerId:
		1:
			return VersusMatchSettings.p1Char
		2:
			return VersusMatchSettings.p2Char
		3:
			return VersusMatchSettings.p3Char
		4:
			return VersusMatchSettings.p4Char
	return null
	

	
func registerKill(killerId, victimId):
	addKill += 1
	if not playerScores.has(killerId):
		return
	

	# UNALIVED ._.
	if killerId == victimId:
		playerScores[killerId]["kills"] -= 1
		
		print("Player ", killerId, " committed suicide")
		return

	playerScores[killerId]["kills"] += 1 ## DEITEI UM
	killRegistered.emit()


func registerDeath(playerId):
	if matchEnded:
		return
	if not playerScores.has(playerId):
		return
	playerScores[playerId]["alive"] = false
	
	if checkingIfMatchEnded == true:
		return
	checkingIfMatchEnded = true
	
	call_deferred("checkMatchEnd")


func checkMatchEnd():
	checkingIfMatchEnded = false
	
	if matchEnded:
		return
		
	var alivePlayers := []
	for playerId in playerScores:
		if playerScores[playerId]["alive"]:
			alivePlayers.append(playerId)


	## A DRAW WOMP WOMP
	if alivePlayers.size() == 0:
		drawRegistered.emit()
		draws += 1
		matchEnded = true
		print("Draw")
		print(draws)
		restartMatch()

	# WINNER CHICKEN DINNER
	if alivePlayers.size() == 1:
		var winnerId = alivePlayers[0]
		playerScores[winnerId]["wins"] += 1
		matchEnded = true
		print("WINNER: player 0", winnerId)
		print(playerScores)
		
		var winnerPlayerNode = getWinnerNode(winnerId)
		if winnerPlayerNode:
			winnerPlayerNode.playWinAnim()
		
		restartMatch()

func resetScores():
	playerScores.clear()
	draws = 0
	matchEnded = false
	
func restartMatch():
	if matchEnded == false:
		return
	await get_tree().create_timer(5.0, false).timeout
	Loader.loadingScreen2Scene(
		VersusMatchSettings.mapToLoad
	)
	
func getWinnerNode(winnerId):
	var players = get_tree().get_nodes_in_group("MP_player")
	for player in players:
		if player.playerId == winnerId:
			return player
	return null
