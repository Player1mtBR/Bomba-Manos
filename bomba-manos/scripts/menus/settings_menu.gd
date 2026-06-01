extends CanvasLayer

@onready var busMaster := $Control/settings/AUDIO/master2
@onready var busOST := $Control/settings/AUDIO/musica
@onready var busVoices := $Control/settings/AUDIO/vozse
@onready var busSFX := $Control/settings/AUDIO/efeitos2

var previousFocusedButton : Control

func _ready() -> void:
	visible = false
	AudioServer.set_bus_volume_db(0, linear_to_db(busMaster.value / 15))
	AudioServer.set_bus_volume_db(1, linear_to_db(busOST.value / 15))
	AudioServer.set_bus_volume_db(2, linear_to_db(busVoices.value / 15))
	AudioServer.set_bus_volume_db(3, linear_to_db(busSFX.value / 15))


func settings_focus():
	previousFocusedButton = get_viewport().gui_get_focus_owner()
	visible = true
	$Control/settings/AUDIO/master2.grab_focus()


func _on_master_2_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value / 15))
	
func _on_musica_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value / 15))

func _on_vozse_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value / 15))
	
func _on_efeitos_2_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(3, linear_to_db(value / 15))

	
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("menu_cancel"):
		visible = false
		#previousFocusedButton.visible = true
		if is_instance_valid(previousFocusedButton):
			previousFocusedButton.grab_focus()
