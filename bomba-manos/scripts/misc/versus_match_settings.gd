extends Node

var mapList = {
	0 :{
		"name" : "LAB 21",
		"scene" : "res://scenes/levels/versus/LAB_INFO_01.tscn"
		},
	
	1 :{
		"name" : "LAB 21 copia",
		"scene" : "res://scenes/levels/versus/LAB_INFO_01.tscn"
		}
}

var characterList = {

	1 : {
		"name": "Mano",
		"spriteFrames": preload("res://assets/res/spriteframes/bombaman-Sprite-Frames.tres"),
		"icon": preload("res://assets/sprites/levels/campaign/extras/faces1.png")
	},
	2 : {
		"name": "S. Hero",
		"spriteFrames": preload("res://assets/res/spriteframes/ureiaman-Sprite-Frames.tres"),
		"icon": preload("res://assets/sprites/levels/campaign/extras/faces2.png")
	},
	3 : {
		"name": "Gaspar",
		"spriteFrames": preload("res://assets/res/spriteframes/rangerman-Sprite-Frames.tres"),
		"icon": preload("res://assets/sprites/levels/campaign/extras/faces3.png")
	},
	4 : {
		"name": "Sentinela",
		"spriteFrames": preload("res://assets/res/spriteframes/miniman-Sprite-Frames.tres"),
		"icon": preload("res://assets/sprites/levels/campaign/extras/faces4.png")
	}
}

var mapToLoad : String
var playerCount : int

var p1Char
var p2Char
var p3Char
var p4Char

var matchStarted := false

func setupMatch(
	setPlayerCount,
	setP1Char,
	setP2Char,
	setP3Char,
	setP4Char
):
	playerCount = setPlayerCount

	match playerCount:
		2:
			p1Char =  setP1Char
			p2Char =  setP2Char
		3:
			p1Char =  setP1Char
			p2Char =  setP2Char
			p3Char =  setP3Char
		4:
			p1Char =  setP1Char
			p2Char =  setP2Char
			p3Char =  setP3Char
			p4Char =  setP4Char

func setMap(mapId):
	mapToLoad = mapList[mapId]
	Loader.loadingScreen2Scene(mapToLoad)
