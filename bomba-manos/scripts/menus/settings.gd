extends Control

func _ready() -> void:
	$reset.grab_focus()

func _on_reset_pressed() -> void:
	UnlockStuff.deleteAllProgress()
