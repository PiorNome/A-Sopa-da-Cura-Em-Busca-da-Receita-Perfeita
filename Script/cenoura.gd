extends Area2D
@onready var sprite = $Sprite2D
@export var id:int
@export var nome:String
var img:ImageTexture
func _ready() -> void:
	var imagem_completa = sprite.texture.get_image()
	
	# 2. Recorta apenas a área da cenoura definida no Region do Sprite2D
	var imagem_recortada = imagem_completa.get_region(sprite.region_rect)
	
	# 3. Cria a ImageTexture apenas com o pedaço recortado
	img = ImageTexture.create_from_image(imagem_recortada)
