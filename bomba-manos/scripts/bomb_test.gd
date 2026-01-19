extends Node2D

func _ready():
	kaboom()
	
func kaboom():
	await get_tree().create_timer(3.0).timeout
	print("MIBOOMBA")
	queue_free() ## deleta o node da cena
