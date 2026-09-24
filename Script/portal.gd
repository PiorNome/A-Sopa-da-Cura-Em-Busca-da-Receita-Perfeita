extends Area2D


@export_file() var proxima_cena
@export var posicao_x: float
@export var posicao_y:float
var localizacao_teleporte = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	localizacao_teleporte.append(posicao_x)
	localizacao_teleporte.append(posicao_y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
