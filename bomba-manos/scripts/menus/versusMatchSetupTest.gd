extends Control

@onready var BOMBAMAN := preload("res://assets/res/spriteframes/bombaman-Sprite-Frames.tres")
@onready var UREIAMAN := preload("res://assets/res/spriteframes/ureiaman-Sprite-Frames.tres")
@onready var RANGERMAN := preload("res://assets/res/spriteframes/rangerman-Sprite-Frames.tres")
@onready var MINIMAN := preload("res://assets/res/spriteframes/miniman-Sprite-Frames.tres")

@export var setPlayerCount := 0


#func _ready() -> void:

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_cancel"):
		Loader.loadingScreen2Scene("res://scenes/menus/main_menu.tscn")
