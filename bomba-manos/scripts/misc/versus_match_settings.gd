extends Node

var mapList = {
	0 : "res://scenes/levels/versus/LAB_INFO_01.tscn"
}
var characterList = {
	1 : preload("res://assets/res/spriteframes/bombaman-Sprite-Frames.tres"),
	2 : preload("res://assets/res/spriteframes/ureiaman-Sprite-Frames.tres"),
	3 : preload("res://assets/res/spriteframes/rangerman-Sprite-Frames.tres"),
	4 : preload("res://assets/res/spriteframes/miniman-Sprite-Frames.tres")
	
}

var mapToLoad : String
var playerCount : int
var p1Char 
var p2Char
var p3Char
var p4Char


var matchStarted := false

var player1Alive := false
var player2Alive := false
var player3Alive := false
var player4Alive := false

func setupMatch(setPlayerCount, setP1Char, setP2Char, setP3Char, setP4Char):
	playerCount = setPlayerCount
	match playerCount:
		2:
			p1Char = characterList[setP1Char]
			p2Char = characterList[setP2Char]
		3:
			p1Char = characterList[setP1Char]
			p2Char = characterList[setP2Char]
			p3Char = characterList[setP3Char]
		4:
			p1Char = characterList[setP1Char]
			p2Char = characterList[setP2Char]
			p3Char = characterList[setP3Char]
			p4Char = characterList[setP4Char]
	
func setMap(mapId):
	mapToLoad = mapList[mapId]
	
	Loader.loadingScreen2Scene(mapToLoad)
