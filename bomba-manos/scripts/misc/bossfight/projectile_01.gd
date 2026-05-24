extends Area2D

@export var damage := 1
@export var canCharge := false
@export var lifetime := 10
#@export var projectileSpeed := 1.0
var spawn := true

var velocity : Vector2 = Vector2()
var chargeMult := 1

func _ready() -> void:
	modulate = Color(10, 10, 10)
	await get_tree().create_timer(0.25).timeout
	if canCharge == true:
		chargeMult = 2
		await get_tree().create_timer(0.5).timeout
		modulate = Color(1, 100, 1)
	else:
		modulate = Color(1, 1, 1)
	spawn = false
	$shootSfx
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
func _physics_process(delta: float) -> void:
	if spawn == false and monitoring == true:
		#rotation += 1.0 * delta * 100
		position += velocity * delta * chargeMult # * projectileSpeed
	
	
		for area in get_overlapping_areas():
			#print(area.name)
			if area.is_in_group("shield"):
				if canCharge == true:
					area.get_parent().chargePower(1)
					print(area.get_parent())
				destroyProjectile()
			

func destroyProjectile():
	set_deferred("monitoring", false) # no errors
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	#print("pew collided with: ",body.name)
	if body.name == "MegazordJP":
		if canCharge == true:
			damage += 1
		body.takeDamage(damage)
		destroyProjectile()
	
