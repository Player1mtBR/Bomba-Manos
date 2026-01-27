extends Control

@onready var lab01Scene := load("res://scenes/loading_screen2.tscn")

# Referências aos cursores e UI
@onready var cursor_p1 = $ColorRect
@onready var cursor_p2 = $ColorRect2

var p1_pos = 0
var p2_pos = 1

@onready var container_personagens = $HBoxContainer
var personagens = [1, 2, 3, 4]

var p1_pronto = false
var p2_pronto = false

func _ready():
	await get_tree().process_frame
	atualizar_posicao_cursores()

func _process(delta: float) -> void:
	# Movimentação P1
	if not p1_pronto:
		# Movimentação P1
		if Input.is_action_just_pressed("p1_moveRight"):  p1_pos = (p1_pos + 1) % 4
		if Input.is_action_just_pressed("p1_moveLeft"): p1_pos = (p1_pos - 1 + 4) % 4 # Soma 4 para evitar números negativos	
		if Input.is_action_just_pressed("p1_bomb"): p1_pronto = true

	# Movimentação P2
	if not p2_pronto:
		if Input.is_action_just_pressed("p2_moveRight"):  p2_pos = (p2_pos + 1) % 4
		if Input.is_action_just_pressed("p2_moveLeft"): p2_pos = (p2_pos - 1 + 4) % 4 # Soma 4 para evitar números negativos	
		if Input.is_action_just_pressed("p2_bomb"): p2_pronto = true

	atualizar_posicao_cursores()
	verificar_selecao()

func atualizar_posicao_cursores():
	if container_personagens.get_child_count() > 0:
		var node_p1 = container_personagens.get_child(p1_pos)
		var node_p2 = container_personagens.get_child(p2_pos)
		
		cursor_p1.global_position = node_p1.global_position - (cursor_p1.size / 2)
		cursor_p2.global_position = node_p2.global_position - (cursor_p2.size / 2)
	

func verificar_selecao():
	#print(p1_pos)
	#print(p2_pos)
	
	if p1_pronto == true and p2_pronto == true:
		p1_pos += 1 ## add 1 pra funcionar com os ids de jogador ja existentes
		p2_pos += 1
		print(p1_pos)
		print(p2_pos)
		GlobalScript.selectedPlayer1 = p1_pos
		GlobalScript.selectedPlayer2 = p2_pos
		get_tree().change_scene_to_packed(lab01Scene)
