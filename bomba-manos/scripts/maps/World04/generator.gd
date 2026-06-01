extends Node2D

@export var generatorId := 1

@onready var generatorManager := get_parent().get_node("GeneratorManager")

var disabled := false

func _ready():
	print("Generator ready")
	print($Area2D.area_entered.is_connected(_on_area_2d_area_entered))
	generatorManager.registerGenerator(generatorId, self)


func disable():
	disabled = true
	$AnimatedSprite2D.play("disabled")
	generatorManager.checkGenerators(generatorId)
	await get_tree().create_timer(2.0, false).timeout
	enable()

func destroy():
	#CurrentLevelManager.currentEnemiesAlive -= 1
	$AnimatedSprite2D.play("destroy")
	await get_tree().create_timer(1.0).timeout
	queue_free()
	
func enable():
	$AnimatedSprite2D.play("default")
	disabled = false
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "ExplosionArea":
		disable()
