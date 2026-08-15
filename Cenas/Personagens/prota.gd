extends CharacterBody2D

const JUMP_VELOCITY = -400.0

const SPEED = 150

func _physics_process(_delta: float) -> void:
	# Cria um vetor com as direções X e Y baseadas nas teclas pressionadas
	var direction = Input.get_vector("andar_esquerda", "andar_direita", "andar_cima", "andar_baixo")
	
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
	
	$AnimatedSprite2D.play()

	# Move o personagem e lida com as colisões do TileMap automaticamente
	move_and_slide()
