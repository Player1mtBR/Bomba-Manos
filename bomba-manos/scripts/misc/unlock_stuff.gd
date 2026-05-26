extends Node

var isOnMenu = false
var unlockAll := false
var iddqd := false
#WORLDS
var world05Unlocked := false

var world01Completed := false
var world02Completed := false
var world03Completed := false
var world04Completed := false
var world05Completed := false

#lEVELS
var completedLevels := {
	"W01L01" : false,
	"W01L02" : false,
	"W01L03" : false,
	"W01L04" : false,
	"W01L05" : false,
	
	"W02L01" : false,
	"W02L02" : false,
	"W02L03" : false,
	"W02L04" : false,
	"W02L05" : false,
	
	"W03L01" : false,
	"W03L02" : false,
	"W03L03" : false,
	"W03L04" : false,
	"W03L05" : false,
	
	"W04L01" : false,
	"W04L02" : false,
	"W04L03" : false,
	"W04L04" : false,
	"W04L05" : false,
	
	"W05L01" : false,
	"W05L02" : false,
	"W05L03" : false,
	"W05L04" : false,
	"W05L05" : false,
	
}

func _process(delta: float) -> void:
	if world01Completed and world02Completed and world03Completed and world04Completed:
		world05Unlocked = true
		
		
	
"""func unlockLevel(level2unlock):
	var levelName = str(level2unlock)
	set(levelName, true)
"""

	
func _input(event: InputEvent) -> void:
	if isOnMenu and Input.is_action_pressed("Shift") and Input.is_action_pressed("code_B") and Input.is_action_pressed("code_O") and Input.is_action_pressed("code_M") and Input.is_action_pressed("code_A"):
		print("Unlock all stuff")
		MusicMenu.get_child(1).play()
		unlockAll = true
		
		world05Unlocked = true
		world01Completed = true
		world02Completed = true
		world03Completed = true
		world04Completed = true
		world05Completed = true
		
		for level in completedLevels:
			completedLevels[level] = true
		
	if Input.is_action_pressed("Shift") and Input.is_action_pressed("code_I") and Input.is_action_pressed("code_I") and Input.is_action_pressed("code_D") and Input.is_action_pressed("code_Q"):
		iddqd = true
		MusicMenu.get_child(2).play()
		print("Degreelessness mode ON \nYou feel lighter")
		
