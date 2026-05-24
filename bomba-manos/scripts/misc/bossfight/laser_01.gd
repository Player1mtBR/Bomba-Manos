extends Area2D

@export var damage := 2
@export var lifetime := 3
var awaitTime := 2.0

func _ready() -> void:
	for i in range(5):
		$CollisionShape2D/danger.visible = true
		await get_tree().create_timer(0.1).timeout
		$CollisionShape2D/danger.visible = false
		await get_tree().create_timer(0.1).timeout

	modulate = Color(10, 10, 10)
	$CollisionShape2D/spriteLightning.visible = true
	$sfx.play()
	await get_tree().create_timer(0.25).timeout
	modulate = Color(1, 1, 1)
	monitoring = true
	await get_tree().create_timer(0.5).timeout
	destroyLaser()
	
func _process(delta: float) -> void:
	pass
	'''while true:
		$CollisionShape2D/danger.visible = true
		await get_tree().create_timer(0.5).timeout
		$CollisionShape2D/danger.visible = false
		await get_tree().create_timer(0.5).timeout
'''
			

func destroyLaser():
	monitoring = false
	#$AnimationPlayer.play("fade_out")
	#await $AnimationPlayer.animation_finished
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	#print("laser collided with: ",body.name)
	if body.name == "MegazordJP":
		body.takeDamage(damage)
		#destroyLaser()
	
