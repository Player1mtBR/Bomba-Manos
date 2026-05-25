extends Node2D

var powerNeeded
var chargingPower := 0
var waitToDefeat := 5.0

func _ready() -> void:
	MusicMenu.get_child(0).stop()

func finalAttack():
	print("idk")
