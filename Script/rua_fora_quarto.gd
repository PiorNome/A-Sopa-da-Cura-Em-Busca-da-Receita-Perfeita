extends Node2D
var som_porta = preload("res://Assets/Sounds/door-opening-closing.mp3")
@onready var audio_player = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Protagonista"):
		
		pass # Repl

func _on_portal_quarto_inicial_body_entered(_body: Node2D) -> void:
	audio_player.stream = som_porta
	audio_player.play()
	pass # Replace with function body.
