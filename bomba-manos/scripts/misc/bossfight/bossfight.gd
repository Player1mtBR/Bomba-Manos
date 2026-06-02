extends Node2D

var powerNeeded
var chargingPower := 0
var waitToDefeat := 5.0

func _ready() -> void:
	MusicMenu.get_child(0).stop()
	PortalTransition.bossOut()
	await get_tree().create_timer(45.0, false).timeout
	$AudioStreamPlayer.play

func finalAttack():
	print("idk")
