extends Node


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		get_tree().paused = true 
		$Player/MenuScreen/ColorRect2.show()
		$BackgroundMusic.stop()
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		$BackgroundMusic.play()

func _ready():
	pass 




