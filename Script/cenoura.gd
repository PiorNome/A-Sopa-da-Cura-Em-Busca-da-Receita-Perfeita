extends Area2D
@onready var animated_sprite = $AnimatedSprite2D
@export var id:int
@export var nome:String
var img:ImageTexture
func _ready() -> void:
	var anim = animated_sprite.animation
	var frame_idx = animated_sprite.get_frame()
	
	# 1. Pega a textura original (que geralmente é uma AtlasTexture)
	var textura_original = animated_sprite.sprite_frames.get_frame_texture(anim, frame_idx)
	
	# 2. Pega os dados de imagem puros (a folha inteira ou o atlas)
	var imagem_completa : Image = textura_original.get_image()
	
	# 3. Se for uma AtlasTexture, recorta apenas a região do frame atual
	if textura_original is AtlasTexture:
		var regiao : Rect2 = textura_original.region
		imagem_completa = imagem_completa.get_region(regiao)
	
	# 4. Cria e retorna a nova ImageTexture a partir dos pixels recortados
	img = ImageTexture.create_from_image(imagem_completa)
