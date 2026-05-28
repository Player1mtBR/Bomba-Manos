extends Node

const savefilePath := "user://BOMBA_MANOS_SAVEGAME.json"

var savingEnabled := true

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

	
}

func _ready() -> void:
	loadGame()
	checkCompletion()

func _process(delta: float) -> void:
	pass
	
	
func _input(event: InputEvent) -> void:
	if isOnMenu and Input.is_action_pressed("Shift") and Input.is_action_pressed("code_B") and Input.is_action_pressed("code_O") and Input.is_action_pressed("code_M") and Input.is_action_pressed("code_A"):
		print("Unlock all stuff")
		savingEnabled = false
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
		savingEnabled = false
		MusicMenu.get_child(2).play()
		print("Degreelessness mode ON \nYou feel lighter")
		
func checkCompletion():
	if world01Completed and world02Completed and world03Completed and world04Completed:
		world05Unlocked = true
		
	world01Completed = completedLevels["W01L05"]
	
	world02Completed = completedLevels["W02L05"]
	
	world03Completed = completedLevels["W03L05"]
	
	world04Completed = completedLevels["W04L05"]
	
	world05Completed = completedLevels["W05L01"]
	

func saveProgress():
	print("Can save game: ", savingEnabled)
	if savingEnabled == true:
		print("INITIATING SAVE PROTOCOL")
		var saveData = {
			"completedLevels": completedLevels
		}

		var file2Use = FileAccess.open(
			savefilePath,
			FileAccess.WRITE
		)

		file2Use.store_string(
			JSON.stringify(saveData)
		)

		file2Use.close()

		print("GOTCHA! PROGRESS SAVED!")
		
func loadGame():

	if not FileAccess.file_exists(savefilePath):
		print("WE COULDN'T FIND ANY SAVE!")
		return

	var file = FileAccess.open(
		savefilePath,
		FileAccess.READ
	)

	var textFromJsonFile = file.get_as_text()
	file.close()

	var jsonFile = JSON.new()
	var result = jsonFile.parse(textFromJsonFile)
	
	if result == OK:
		var data = jsonFile.data
		completedLevels = data["completedLevels"]
		print("GAME LOADED SUCCESSFULLY MY DUDES")
	else:
		print("OH, NO! THE SAVE HAS BEEN CORUPTED BY MANEL")
		
func deleteAllProgress():
	if FileAccess.file_exists(savefilePath):
		var absoluteFilePath = ProjectSettings.globalize_path(savefilePath)
		
		DirAccess.remove_absolute(absoluteFilePath)
		for level in completedLevels:
			completedLevels[level] = false
			
	print("IT'S ALL GONE NOW")
