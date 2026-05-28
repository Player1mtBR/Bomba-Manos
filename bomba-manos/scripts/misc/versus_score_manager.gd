extends Node

var playerScores := {}
var draws := 0
var matchEnded := false


func setupPlayers():
	playerScores.clear()
	matchEnded = false

	for i in range(VersusMatchSettings.playerCount):
		var playerId = i + 1
		playerScores[playerId] = {
			"kills": 0,
			"wins": 0,
			"alive": true,
			"character": getCharFromPlayer(playerId)
		}


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
	if not playerScores.has(killerId):
		return
	

	# UNALIVED ._.
	if killerId == victimId:
		playerScores[killerId]["kills"] = max(
			playerScores[killerId]["kills"] - 1,
			0
		)
		
		print("Player ", killerId, " committed suicide")
		return

	playerScores[killerId]["kills"] += 1 ## DEITEI UM


func registerDeath(playerId):
	if matchEnded:
		return
	if not playerScores.has(playerId):
		return
	playerScores[playerId]["alive"] = false
	checkMatchEnd()


func checkMatchEnd():
	var alivePlayers := []
	for playerId in playerScores:
		if playerScores[playerId]["alive"]:
			alivePlayers.append(playerId)


	## A DRAW WOMP WOMP
	if alivePlayers.size() == 0:
		draws += 1
		matchEnded = true
		print("Draw")
		return

	# WINNER CHICKEN DINNER
	if alivePlayers.size() == 1:
		var winnerId = alivePlayers[0]
		playerScores[winnerId]["wins"] += 1
		matchEnded = true
		print("WINNER: ", winnerId)
		print(playerScores)

func resetScores():
	playerScores.clear()
	draws = 0
	matchEnded = false
