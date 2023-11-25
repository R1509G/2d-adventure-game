extends AudioStreamPlayer


func _process(delta):
	set_stream_paused(not State.isBackgroundMusicOn)
	
