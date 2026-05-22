extends Node

var currentEnemiesAlive := 0
var isPlayerDead := false

func _process(delta: float) -> void:
	print("Enemies alive: ",currentEnemiesAlive)
	
func decreaseEnemyCount():
	currentEnemiesAlive -= 1
