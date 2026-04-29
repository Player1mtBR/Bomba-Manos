extends Node2D

@export var id := 0
var portal_is_locked := false

func lock_portal()->void:
	portal_is_locked = true
	await get_tree().create_timer(2).timeout
	portal_is_locked = false
	
#func _on_teleport_tunel_body_entered(body: Node2D) -> void:
	#if body is CharacterBody2D:
		#if not portal_is_locked:
			#body.teleport(self)
func _on_area_entered(area):
	print("Entrou:", area)
