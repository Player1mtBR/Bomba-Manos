extends Node2D

@export var generatorId := 1

@onready var generatorManager := get_parent().get_node("GeneratorManager")

func _ready():
	generatorManager.registerBarrier(generatorId, self)

func destroy():
	queue_free()
