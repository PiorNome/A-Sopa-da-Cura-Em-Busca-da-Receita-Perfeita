extends Node2D

var cena_atual:Node = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var prota = $"Nó_Prota/Prota"
	prota.mudar_cenario.connect(mudar_nó)
	
	mudar_nó("res://Cenas/Mapas/Quarto_Inicial.tscn", [218.0,121.0])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func mudar_nó(caminho_nova_cena:String, localizacao):
	
	var tempotimer = 0.001
	
	$"Nó_Prota/Prota".lock_move(false)
	while true:
		if $CanvasLayer/ColorRect.color.a >= 1:
			break
		else:
			$CanvasLayer/ColorRect.color[3] += 0.02
		await get_tree().create_timer(tempotimer).timeout
	
	if cena_atual != null:
		cena_atual.queue_free()
	$"Nó_Prota/Prota".position.x = localizacao[0]
	$"Nó_Prota/Prota".position.y = localizacao[1]
	
	var nova_cena = load(caminho_nova_cena)
	cena_atual = nova_cena.instantiate()
	
	$"Nó_mapa".call_deferred("add_child", cena_atual)
	
	await get_tree().create_timer(0.5).timeout
	
	while true:
		if $CanvasLayer/ColorRect.color.a <= 0:
			break
		else:
			$CanvasLayer/ColorRect.color[3] -= 0.02
		await get_tree().create_timer(tempotimer).timeout
	$"Nó_Prota/Prota".lock_move(true)
	
	pass
	
