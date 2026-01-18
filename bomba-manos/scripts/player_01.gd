extends CharacterBody2D

# escrever ":" define o tipo da variável, pode usar := pra definir o tipo e valor ao mesmo tempo tbm
@export var playerMoveSpeed := 50
var playerDirection : Vector2
#var playerVelocity : Vector2

func _physics_process(delta: float) -> void:
	playerDirection.x = Input.get_axis("p1_moveLeft", "p1_moveRight")
	playerDirection.y = Input.get_axis("p1_moveUp", "p1_moveDown")
	
	#diagonal movement speed fix
	playerDirection = playerDirection.normalized()
	
	#check if player is moving
	if playerDirection:
		#velocity will use the direction and multiply by the movespeed
		velocity = playerDirection * playerMoveSpeed #velocity is changed on move_and_slide
		
	else:
		#slow down to 0 when not moving
		velocity = velocity.move_toward(Vector2.ZERO, playerMoveSpeed)
		
	
	#input up - down -left - right
	
	"""
	if Input.is_action_pressed("p1_moveUp"):
		self.global_position.y -= moveSpeed * delta
	elif Input.is_action_pressed("p1_moveDown"):
		self.global_position.y += moveSpeed * delta
	elif Input.is_action_pressed("p1_moveLeft"):
		self.global_position.x -= moveSpeed * delta
	elif Input.is_action_pressed("p1_moveRight"):
		self.global_position.x += moveSpeed * delta
	"""
	
	move_and_slide() #built-in function that handles movement, collisions etc
