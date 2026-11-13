extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_bad_apple_pressed() -> void:
	if not $CanvasLayer/VideoStreamPlayer.is_playing():
		$CanvasLayer/VideoStreamPlayer.show()
		$"CanvasLayer/Bad Apple".hide()
		$CanvasLayer/VideoStreamPlayer.play()
		$AudioStreamPlayer2D.stop()	


func _on_fechar_pressed() -> void:
	if $CanvasLayer/VideoStreamPlayer.is_playing():
		$CanvasLayer/VideoStreamPlayer.stop()
		await get_tree().process_frame
	get_tree().quit()


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/main.tscn")


func _on_video_stream_player_finished() -> void:
		$"CanvasLayer/Bad Apple".show()
		$CanvasLayer/VideoStreamPlayer.hide()
		$AudioStreamPlayer2D.play()
