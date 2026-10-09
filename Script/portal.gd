extends Area2D


@export_file() var proxima_cena
@export var posicao_x: float
@export var posicao_y:float
var localizacao_teleporte = []
var teleporte_ativo = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	localizacao_teleporte.append(posicao_x)
	localizacao_teleporte.append(posicao_y)
	print("Criando timer")
	var timer = Timer.new()
	timer.wait_time = 0.5      # Tempo de espera em segundos
	timer.one_shot = true
	print("Adicionando a um nó pai")
	add_child(timer)
	print("Conectando o timeout")
	timer.timeout.connect(_ativar_portal)
	
	timer.start()
	
func _ativar_portal():
	teleporte_ativo = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Protagonista"):
		teleporte_ativo = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Protagonista"):
		teleporte_ativo = true
