extends Area2D

var velocity = Vector2.ZERO
var speed = 150
var screensize = Vector2(1920, 1080)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_viewport_rect().size
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	velocity = Input.get_vector("andar_esquerda", "andar_direita", "andar_cima", "andar_baixo")
	position += velocity * delta * speed
	
	if velocity.length() > 0:
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
