extends Node2D

var hp := 10
var movespeed := 300

var chargedPower := 0

var can_attack := false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	
	var direction = Input.get_axis("p1_moveLeft", "p1_moveRight")
	position.x += (direction * delta * movespeed)
	
	if Input.is_action_pressed("p1_swap_bomb"):
		jpBlock()
		
	if Input.is_action_just_pressed("p1_bomb") and can_attack:
		jpAttack()
	
func _physics_process(delta: float) -> void:
	pass

func jpBlock():
	print("Blocking")
	
func jpAttack():
	print("Attack")
