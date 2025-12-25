extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _play_music():
	if is_playing():
		return
	play()


