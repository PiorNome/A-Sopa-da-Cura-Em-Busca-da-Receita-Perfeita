extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and $CanvasLayer/VideoStreamPlayer.is_playing():
		_on_video_stream_player_finished()
	pass


func _on_bad_apple_pressed() -> void:
	if not $CanvasLayer/VideoStreamPlayer.is_playing():
		$AudioStreamPlayer2D.stop()
		$"CanvasLayer/Bad Apple".hide()
		$CanvasLayer/Fechar.hide()
		$CanvasLayer/Iniciar.hide()
		$CanvasLayer/Node2D.hide()
		
		$CanvasLayer/Label.show()
		await get_tree().create_timer(3).timeout
		
		$CanvasLayer/Label.hide()
		$CanvasLayer/VideoStreamPlayer.show()
		$CanvasLayer/VideoStreamPlayer.play()
		


func _on_fechar_pressed() -> void:
	if $CanvasLayer/VideoStreamPlayer.is_playing():
		$CanvasLayer/VideoStreamPlayer.stop()
		await get_tree().process_frame
	get_tree().quit()


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/main.tscn")


func _on_video_stream_player_finished() -> void:
	if $CanvasLayer/VideoStreamPlayer.is_playing():
		$CanvasLayer/VideoStreamPlayer.stop()
		
	$CanvasLayer/Node2D.show()
	$"CanvasLayer/Bad Apple".show()
	$CanvasLayer/Iniciar.show()
	$CanvasLayer/Fechar.show()
	$CanvasLayer/VideoStreamPlayer.hide()
	$AudioStreamPlayer2D.play()
