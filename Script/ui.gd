extends Control

func mudar_fala(texto_fala: String = "", cor_borda: Color = Color(0.30, 0.50, 0.52, 1.00), cor_fundo: Color = Color(0,0,0,1), imagem_personagem: ImageTexture = null
	): # :(
	$Label.text = texto_fala
	if not imagem_personagem == null:
		$TextureRect.texture = imagem_personagem
	
	var stylebox: StyleBoxFlat = $Panel.get_theme_stylebox("panel")
	
	stylebox.bg_color = cor_fundo
	stylebox.border_color = cor_borda
