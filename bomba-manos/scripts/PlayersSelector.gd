extends Control

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

func _input(event):
	# Movimentação P1
	if not p1_pronto:
		# Movimentação P1
		if event.is_action_pressed("p1_moveRight"):  p1_pos = (p1_pos + 1) % 4
		if event.is_action_pressed("p1_moveLeft"): p1_pos = (p1_pos - 1 + 4) % 4 # Soma 4 para evitar números negativos	
		if event.is_action_pressed("p1_kill"): p1_pronto = true

	# Movimentação P2
	if not p2_pronto:
		if event.is_action_pressed("p2_moveRight"):  p2_pos = (p2_pos + 1) % 4
		if event.is_action_pressed("p2_moveLeft"): p2_pos = (p2_pos - 1 + 4) % 4 # Soma 4 para evitar números negativos	
		if event.is_action_pressed("p2_kill"): p2_pronto = true

	atualizar_posicao_cursores()
	verificar_selecao()

func atualizar_posicao_cursores():
	if container_personagens.get_child_count() > 0:
		var node_p1 = container_personagens.get_child(p1_pos)
		var node_p2 = container_personagens.get_child(p2_pos)
		
		# Pegamos a posição global do personagem e subtraímos metade do tamanho do cursor
		# Isso faz com que o centro do ColorRect fique sobre o centro do CharacterBody2D
		cursor_p1.global_position = node_p1.global_position - (cursor_p1.size / 2)
		cursor_p2.global_position = node_p2.global_position - (cursor_p2.size / 2)
	

func verificar_selecao():
	print(p1_pos)
	print(p2_pos)
	pass
	#if p1_pronto and p2_pronto:
		# Salva a escolha no Singleton Global
		#Global.p1_escolhido = p1_pos
		#Global.p2_escolhido = p2_pos
		
		#print("P1 escolheu: ", p1_pos, " | P2 escolheu: ", p2_pos)

		# Para a música (usando o MusicPlayer que criamos no início)
		#if has_node("/root/MusicPlayer"):
		#	get_node("/root/MusicPlayer").stop() 

		# Muda para a cena da partida
		#get_tree().change_scene_to_file("res://cena_jogo.tscn")
