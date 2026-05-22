extends Area2D

@export var damage := 1
@export var canCharge := false
@export var lifetime := 10
#@export var projectileSpeed := 1.0

var velocity : Vector2 = Vector2()

func _ready() -> void:
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
func _physics_process(delta: float) -> void:
	position += velocity * delta # * projectileSpeed
	
	
	for area in get_overlapping_areas():
		print(area.name)
		if area.is_in_group("shield"):
			if canCharge == true:
				area.get_parent().chargePower(1)
				print(area.get_parent())
			destroyProjectile()
			

func destroyProjectile():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("pew collided with: ",body.name)
	if body.name == "MegazordJP":
		body.takeDamage(damage)
		destroyProjectile()
	
