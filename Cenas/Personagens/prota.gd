extends CharacterBody2D

const JUMP_VELOCITY = -400.0

# isso aq só serve pra definir a velocidade base em algumas partes do código
const SPEED = 150

# mudança do Shinwa
# velocidade de andar
var speed = SPEED
# quanto maior, maior a velocidade da corrida
var increment_speed = 150
var is_running = false


var vida = 3
var pode_andar = true
var itens_pegos = {
	0: false,
	1: false,
	2: false,
	3: false
}
@onready var slots = [
	$CanvasLayer/Inventario/Slot1/Imagem, 
	$CanvasLayer/Inventario/Slot2/Imagem, 
	$CanvasLayer/Inventario/Slot3/Imagem, 
	$CanvasLayer/Inventario/Slot4/Imagem, 
	$CanvasLayer/Inventario/Slot5/Imagem
]

var inventario = {}

signal mudar_cenario(caminho:String, localizacao)

func _ready() -> void:
	for i in range(5):
		inventario[i] = null

func _physics_process(_delta: float) -> void:
	# eu fiz uma mudança aq (ps: hhiii my name is Shinwa)
	# De preferência, faz um menu de verdade pro jogo, pra pessoa poder apertar em voltar
	# pro menu inicial ou continuar o jogo 
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_file("res://Cenas/Mapas/main menu.tscn")
	# nao gosto de deixar desse jeito, mas funciona
	if Input.is_action_pressed("correr"):
		speed += increment_speed
		is_running = true
	if Input.is_action_just_released("correr"):
		speed = SPEED
		is_running = false
		
		# Cria um vetor com as direções X e Y baseadas nas teclas pressionadas
	var direction = Input.get_vector("andar_esquerda", "andar_direita", "andar_cima", "andar_baixo")
	
	if pode_andar:
		if direction != Vector2.ZERO:
			velocity = direction * speed
		else:
			# Para o personagem suavemente quando solta as teclas
			velocity = velocity.move_toward(Vector2.ZERO, speed)
					
		if direction.length() > 0:
			# mais modificações do Shinwa
			if is_running:
				if velocity.x > 0:
					$AnimatedSprite2D.animation = "right_run"
				elif velocity.x < 0:
					$AnimatedSprite2D.animation = "left_run"
				elif velocity.y > 0:
					$AnimatedSprite2D.animation = "down_run"
				elif velocity.y < 0:
					$AnimatedSprite2D.animation = "up_run"
			elif not is_running:
				if velocity.x > 0:
					$AnimatedSprite2D.animation = "Direito"
				elif velocity.x < 0:
					$AnimatedSprite2D.animation = "Esquerda"
				elif velocity.y > 0:
					$AnimatedSprite2D.animation = "Baixo"
				elif velocity.y < 0:
					$AnimatedSprite2D.animation = "Cima"
			else:
				$AnimatedSprite2D.frame = 1
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		$AnimatedSprite2D.frame = 1
		
	$AnimatedSprite2D.play()
	# Move o personagem e lida com as colisões do TileMap automaticamente
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ataque_Inimigo"):
		vida -= 1
		
		if vida == 0:
			pass # Cena de game over
			
	if area.is_in_group("Item"):
		adicionar_ao_inventario(area)
		if itens_pegos[0] and itens_pegos[1] and itens_pegos[2] and itens_pegos[3]:
			var textos = [{
				"texto_fala": "Eu peguei todos os ingredientes.",
				"imagem_personagem": null,
				"nome": "Pensamento"
			},{
				"texto_fala": "Eu devia voltar para casa para fazer a sopa.",
				"imagem_personagem": null,
				"nome": "Pensamento"
			}]
			falas(textos)
		elif area.id == 0:
			var textos = [{
				"texto_fala": "Eu peguei a cenoura!!!",
				"imagem_personagem": null,
				"nome": "Pensamento"
			},{
				"texto_fala": "Agora eu devo procurar os outros ingredientes",
				"imagem_personagem": null,
				"nome": "Pensamento"
			}]
			falas(textos)
		elif area.id == 1:
			var textos = [{
				"texto_fala": "Eu peguei a mandioca!!!",
				"imagem_personagem": null,
				"nome": "Pensamento"
			},{
				"texto_fala": "Agora eu devo procurar os outros ingredientes",
				"imagem_personagem": null,
				"nome": "Pensamento"
			}]
			falas(textos)
		elif area.id == 2:
			var textos = [{
				"texto_fala": "Eu peguei a batata!!!",
				"imagem_personagem": null,
				"nome": "Pensamento"
			},{
				"texto_fala": "Agora eu devo procurar os outros ingredientes",
				"imagem_personagem": null,
				"nome": "Pensamento"
			}
			]
			falas(textos)
		elif area.id == 4:
			var textos = [{
				"texto_fala": "Eu peguei a cebola!!!",
				"imagem_personagem": null,
				"nome": "Pensamento"
			},{
				"texto_fala": "Agora eu devo procurar os outros ingredientes",
				"imagem_personagem": null,
				"nome": "Pensamento"
			}
			]
			falas(textos)
		area.queue_free()

func adicionar_ao_inventario(item):
	var itens_inventario = []
	for chave in inventario:
		if inventario[chave] != null:
			itens_inventario.append(inventario[chave]["id"])
	if item.id not in itens_inventario:
		var _slot_encontrado = false
		for chave in inventario.keys():
			if inventario[chave] == null:
				_slot_encontrado = true
				inventario[chave] = {
					"id": item.id,
					"Nome": item.nome,
					"quantidade": 1,
					"img": item.img
				}
				atualizar_inventario()
				break
	else:
		for chave in inventario:
			if inventario[chave]["id"] == item.id:
				inventario[chave]["quantidade"] += 1
				break

func _on_colisão_portal_area_entered(area: Area2D) -> void:
	if area.is_in_group("portal"):
		if area.teleporte_ativo:
			mudar_cenario.emit(area.proxima_cena, area.localizacao_teleporte)

func lock_move(mover:bool):
	pode_andar = mover
	if pode_andar:
		$CanvasLayer/Inventario.show()
	else:
		$CanvasLayer/Inventario.hide()
	$AnimatedSprite2D.frame = 1
	$AnimatedSprite2D.play()

func falas(textos: Array):
	lock_move(false)
	for fala in textos:
		$CanvasLayer/ColorRect/balao_fala.hide()
		var texto_fala = fala["texto_fala"]
		var imagem = fala["imagem_personagem"]
		var nome = fala["nome"]
		
		$CanvasLayer/ColorRect/balao_fala.mudar_fala(nome, texto_fala, imagem)
		$CanvasLayer/ColorRect/balao_fala.show()
		
		await get_tree().process_frame
		
		while Input.is_action_pressed("interagir"):
			await get_tree().process_frame
			
		while not Input.is_action_just_pressed("interagir"):
			await get_tree().process_frame
			
	$CanvasLayer/ColorRect/balao_fala.hide()
	lock_move(true)
	
func atualizar_inventario():
	for chave in inventario:
		if inventario[chave] != null:
			var img = slots[0]
			img.texture = inventario[chave]["img"]
		else:
			var img = slots[chave]
			img.texture = null
		
	pass
