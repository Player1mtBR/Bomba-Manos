extends Control
#não consigo mais trabalhar hoje, vou fazer o commit e depois continuo ass. p1mt

var setMatchPlayerCount := 0

var Player1Char := 0
var Player2Char := 0
var Player3Char := 0
var Player4Char := 0

var setMapId := 0

var menuOrder := 0

var Player1Selected := false
var Player2Selected := false
var Player3Selected := false
var Player4Selected := false



func _ready() -> void: #OPENING MENU
	$"playerCountSelect/2players".grab_focus()
	
func _process(delta: float) -> void:
	match setMatchPlayerCount:
		2:
			if menuOrder == 1 and Player1Selected and Player2Selected:
				menuOrder = 2
				$CharSelect2.visible = false
				$startMatch.visible = true
				$startMatch/changeMap.grab_focus()
#---------------------------------------
#PLAYER COUNT SELECTED
#----------------------$startMatch/change map-----------------

#---------------------------------------
#2 PLAYERS
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
#2 PLAYERS PLAYER 1
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
#2 PLAYERS PLAYER 1 CHARACTER SELECTED
#---------------------------------------	
func _2Ps_P2_bombaman_pressed() -> void:
	setPlayerChar(2, 2, 1)


func setPlayerChar(playerCount, playerNum, CharNum):
	match playerNum:
		1:
			Player1Char = 1
			Player1Selected = true
			match playerCount:
				2:
					#$CharSelect2/player1.visible = false
					if Player2Selected == false:
						$CharSelect2/player2/bombaman.grab_focus()
		2:
			Player2Char = 1
			Player2Selected = true
			if Player1Selected == false:
				$CharSelect2/player1/bombaman.grab_focus()
					

func _on_begin_pressed() -> void:
	print("players: ",setMatchPlayerCount)
	print("Player1: ", Player1Char)
	print("Player2: ", Player2Char)
	print("Player3: ", Player3Char)
	print("Player4: ", Player4Char)
	print("Map selected: ", setMapId)
