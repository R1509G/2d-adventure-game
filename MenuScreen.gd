extends Node2D


func show_menu():
	$ColorRect.show()
	$ColorRect2.show()
	
func hide_menu():
	$ColorRect.hide()
	$ColorRect2.hide()
	

func _ready():
	hide_menu()	
	

func _process(delta):
	var new_texture = State.music_on_texture if State.isBackgroundMusicOn else State.music_off_texture
	$ColorRect2/MusicButton/Sprite.texture = new_texture

func _on_ResumeButton_pressed():
	get_tree().paused = false
	hide_menu()
	get_node("%PauseButton").show()
	


func _on_HomeButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://HomeScreen.tscn")


func _on_MusicButton_pressed():	
	State.isBackgroundMusicOn = not State.isBackgroundMusicOn 



