extends CharacterBody2D

var hp := 10
var movespeed := 300

var chargedPower := 0

var canAttack := false
var canParry := false
var parryTime := 1.0

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_swap_bomb"):
		jpBlock()
	if Input.is_action_just_released("p1_swap_bomb"):
		$Shield.visible = false
		
	if Input.is_action_just_pressed("p1_bomb") and canAttack:
		jpAttack()
		
		
	
func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("p1_moveLeft", "p1_moveRight")
	velocity.x = (direction * movespeed)
	move_and_slide()

func jpBlock():
	print("Blocking")
	$Shield.visible = true
	
func jpAttack():
	print("Attack")
