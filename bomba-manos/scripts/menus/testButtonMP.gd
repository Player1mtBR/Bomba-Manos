extends Control
"""
MAP IDs
0 - testmap
1 - sala de aula Manel
"""

var mapList := [0, 1]

var setMatchPlayerCount := 0

var player1Char := 0
var player2Char := 0
var player3Char := 0
var player4Char := 0

var setMapId := 0

var menuOrder := 0

var player1Selected := false
var player2Selected := false
var player3Selected := false
var player4Selected := false



func _ready() -> void: #OPENING MENU
	$"playerCountSelect/2players".grab_focus()
	
func _process(delta: float) -> void: #CHECK PLAYER COUNT MENU
	match setMatchPlayerCount:
		2:
			if menuOrder == 1 and player1Selected and player2Selected:
				menuOrder = 2
				$CharSelect2.visible = false
				$startMatch.visible = true
				$startMatch/changeMap.grab_focus()
		3:
			if menuOrder == 1 and player1Selected and player2Selected and player3Selected:
				menuOrder = 2
				$CharSelect2.visible = false
				$startMatch.visible = true
				$startMatch/changeMap.grab_focus()
		4:
			if menuOrder == 1 and player1Selected and player2Selected and player3Selected and player4Selected:
				menuOrder = 2
				$CharSelect2.visible = false
				$startMatch.visible = true
				$startMatch/changeMap.grab_focus()
#---------------------------------------
# 2 PLAYERS
#---------------------------------------
func _on_2_players_pressed() -> void:
	menuOrder = 1
	setMatchPlayerCount = 2
	$playerCountSelect.visible = false
	$CharSelect2.visible = true
	$CharSelect2/player3.visible = false
	$CharSelect2/player4.visible = false
	$CharSelect2/player1/bombaman.grab_focus()
#---------------------------------------
# 3 PLAYERS
#---------------------------------------
func _on_3_players_pressed() -> void:
	menuOrder = 1
	setMatchPlayerCount = 3
	$playerCountSelect.visible = false
	$CharSelect2.visible = true
	$CharSelect2/player4.visible = false
	$CharSelect2/player1/bombaman.grab_focus()
#---------------------------------------
# 4 PLAYERS
#---------------------------------------
func _on_4_players_pressed() -> void:
	menuOrder = 1
	setMatchPlayerCount = 4
	$playerCountSelect.visible = false
	$CharSelect2.visible = true
	$CharSelect2/player1/bombaman.grab_focus()
#---------------------------------------
# PLAYER 1
#---------------------------------------
func _2Ps_P1_bombaman_pressed() -> void:
	setPlayerChar(2, 1, 1)

func _2Ps_P1_ureiaman_pressed() -> void:
	setPlayerChar(2, 1, 2)
	
func _2Ps_P1_rangerman_pressed() -> void:
	setPlayerChar(2, 1, 3)

func _2Ps_P1_miniman_pressed() -> void:
	setPlayerChar(2, 1, 4)

func _2Ps_P1_secret01_pressed() -> void:
	setPlayerChar(2, 1, 5)
#---------------------------------------
# PLAYER 2
#---------------------------------------	
func _2Ps_P2_bombaman_pressed() -> void:
	setPlayerChar(2, 2, 1)
	
func _2Ps_P2_ureiaman_pressed() -> void:
	setPlayerChar(2, 2, 2)

func _2Ps_P2_rangerman_pressed() -> void:
	setPlayerChar(2, 2, 3)
	
func _2Ps_P2_miniman_pressed() -> void:
	setPlayerChar(2, 2, 4)

func _2Ps_P2_secret01_pressed() -> void:
	setPlayerChar(2, 2, 5)
#---------------------------------------
# PLAYER 3
#---------------------------------------
func _3Ps_P3_bombaman_pressed() -> void:
	setPlayerChar(3, 3, 1)


func _3Ps_P3_ureiaman_pressed() -> void:
	setPlayerChar(3, 3, 2)


func _3Ps_P3_rangerman_pressed() -> void:
	setPlayerChar(3, 3, 3)


func _3Ps_P3_miniman_pressed() -> void:
	setPlayerChar(3, 3, 4)


func _3Ps_P3_secret_pressed() -> void:
	setPlayerChar(3, 3, 5)
#---------------------------------------
# PLAYER 4
#---------------------------------------
func _4Ps_P4_bombaman_pressed() -> void:
	setPlayerChar(4, 4, 1)


func _4Ps_P4_ureiaman_pressed() -> void:
	setPlayerChar(4, 4, 2)


func _4Ps_P4_rangerman_pressed() -> void:
	setPlayerChar(4, 4, 3)


func _4Ps_P4_miniman_pressed() -> void:
	setPlayerChar(4, 4, 4)


func _4Ps_P4_secret_pressed() -> void:
	setPlayerChar(4, 4, 5)


func setPlayerChar(playerCount, playerNum, charNum):
	match playerNum:
		1:
			player1Char = charNum
			player1Selected = true
			displaySelectedChar(playerNum, charNum)
			#if player2Selected == false:
			#	$CharSelect2/player2/bombaman.grab_focus()
		2:
			player2Char = charNum
			player2Selected = true
			displaySelectedChar(playerNum, charNum)
			#if player1Selected == false:
			#	$CharSelect2/player1/bombaman.grab_focus()
		3:
			player3Char = charNum
			player3Selected = true
			displaySelectedChar(playerNum, charNum)
		4:
			player4Char = charNum
			player4Selected = true
			displaySelectedChar(playerNum, charNum)
			
					
func displaySelectedChar(playerNum, charNum) -> void:
	match playerNum:
		1:
			match charNum:
				1:
					$CharSelect2/player1/Label.text = "Mano\nPlayer 1"
				2:
					$CharSelect2/player1/Label.text = "S. Hero\nPlayer 1"
				3:
					$CharSelect2/player1/Label.text = "Gaspar\nPlayer 1"
				4:
					$CharSelect2/player1/Label.text = "Sentinela\nPlayer 1"
				5:
					$CharSelect2/player1/Label.text = "???\nPlayer 1"
					
		2:
			match charNum:
				1:
					$CharSelect2/player2/Label.text = "Mano\nPlayer 2"
				2:
					$CharSelect2/player2/Label.text = "S. Hero\nPlayer 2"
				3:
					$CharSelect2/player2/Label.text = "Gaspar\nPlayer 2"
				4:
					$CharSelect2/player2/Label.text = "Sentinela\nPlayer 2"
				5:
					$CharSelect2/player2/Label.text = "???\nPlayer 2"
		3:
			match charNum:
				1:
					$CharSelect2/player3/Label.text = "Mano\nPlayer 3"
				2:
					$CharSelect2/player3/Label.text = "S. Hero\nPlayer 3"
				3:
					$CharSelect2/player3/Label.text = "Gaspar\nPlayer 3"
				4:
					$CharSelect2/player3/Label.text = "Sentinela\nPlayer 3"
				5:
					$CharSelect2/player3/Label.text = "???\nPlayer 3"
		4:
			match charNum:
				1:
					$CharSelect2/player4/Label.text = "Mano\nPlayer 4"
				2:
					$CharSelect2/player4/Label.text = "S. Hero\nPlayer 4"
				3:
					$CharSelect2/player4/Label.text = "Gaspar\nPlayer 4"
				4:
					$CharSelect2/player4/Label.text = "Sentinela\nPlayer 4"
				5:
					$CharSelect2/player4/Label.text = "???\nPlayer 4"

func _on_begin_pressed() -> void:
	print("players: ",setMatchPlayerCount)
	print("Player1: ", player1Char)
	print("Player2: ", player2Char)
	print("Player3: ", player3Char)
	print("Player4: ", player4Char)
	print("Map selected: ", setMapId)
	VersusMatchSettings.setupMatch(
		setMatchPlayerCount,
		player1Char,
		player2Char,
		player3Char,
		player4Char
	)
	
	VersusMatchSettings.setMap(setMapId)
