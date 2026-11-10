extends CharacterBody2D

const JUMP_VELOCITY = -400.0
const SPEED = 150
var vida = 3
var pode_andar = true

var inventario = {}

signal mudar_cenario(caminho:String, localizacao)

func _ready() -> void:
	for i in range(31):
		inventario[i] = null

func _physics_process(_delta: float) -> void:
	# Cria um vetor com as direções X e Y baseadas nas teclas pressionadas
	var direction = Input.get_vector("andar_esquerda", "andar_direita", "andar_cima", "andar_baixo")
	
	if pode_andar:
		if direction != Vector2.ZERO:
			velocity = direction * SPEED
		else:
			# Para o personagem suavemente quando solta as teclas
			velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		
		if direction.length() > 0:
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
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
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
		var slot_encontrado = false
		
		var itens_inventario = []
		
		for chave in inventario.keys():
			if inventario[chave] == null:
				slot_encontrado = true
				inventario[chave] = {
					"id": area.id,
					"Nome": "Cenoura",
					"quantidade": 1
					}
				
				var textos = [{
					"texto_fala": "Eu peguei a cenoura!!!",
					"imagem_personagem": null,
					"nome": "Pensamento"
				},{
					"texto_fala": "Agora eu devo procurar os outros ingredientes",
					"imagem_personagem": null,
					"nome": "Pensemento"
				}
				]
				falas(textos)
				break
				#area.queue_free()
		
		if not slot_encontrado:
			var textos = []
			if area.id in [0,1,2,3]:
				textos += [{
					"texto_fala": "Eu já peguei a cenoura!!!",
					"imagem_personagem": null,
					"nome": "Pensamento"
				},{
					"texto_fala": "Eu devo procurar os outros ingredientes",
					"imagem_personagem": null,
					"nome": "Pensemento"
				}
				]
				
			area.queue_free()
			falas(textos)
	

func _on_colisão_portal_area_entered(area: Area2D) -> void:
	if area.is_in_group("portal"):
		if area.teleporte_ativo:
			mudar_cenario.emit(area.proxima_cena, area.localizacao_teleporte)

func lock_move(mover:bool):
	pode_andar = mover
	$AnimatedSprite2D.frame = 1
	$AnimatedSprite2D.play()

func falas(textos: Array):
	lock_move(false)
	for fala in textos:
		$ColorRect/balao_fala.hide()
		var texto_fala = fala["texto_fala"]
		var imagem = fala["imagem_personagem"]
		var nome = fala["nome"]
		
		$ColorRect/balao_fala.mudar_fala(nome, texto_fala, imagem)
		$ColorRect/balao_fala.show()
		
		await get_tree().process_frame
		
		while Input.is_action_pressed("interagir"):
			await get_tree().process_frame
			
		while not Input.is_action_just_pressed("interagir"):
			await get_tree().process_frame
			
	$ColorRect/balao_fala.hide()
	lock_move(true)
