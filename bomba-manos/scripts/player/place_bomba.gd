extends Node2D

@onready var bombaScene := preload("res://scenes/bomb_test.tscn") ##carregando cena em uma variavel
#var playerParent = null
var tileSize := 16

func _ready() -> void:
	#var playerParent = get_parent()
	pass

func _process(delta: float) -> void:
	pass

func placeBombOnMap():
	var newBomba = bombaScene.instantiate() ## definindo instancia da bomba
	
	var setBombaPosition = Vector2(round(get_parent().position.x / tileSize) * tileSize, round(get_parent().position.y / tileSize) * tileSize)
	## Vector2 arredonda posicao do node pai q é o player e divide por 16 q é o tamanho do tileset e multiplica por 16 pra dar o valor que "encaixa" no quadradin
	
	newBomba.position = setBombaPosition ## definindo posicao aqui pq tava atualizando a posicao a cada chamada
	
	get_tree().root.add_child(newBomba) ## pega o root da cena e cria um node 
	
	#print("É BOMBA")
	
