extends Node2D

var camera_origin
var pauseButton_origin
var score_origin
var menu_origin
var health_origin
var game_over_screen_origin
var camera_position

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		get_tree().paused = true 
		$MenuScreen/ColorRect2.show()
		$BackgroundMusic.stop()
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		$BackgroundMusic.play()

func _ready():
	$Gameover.hide()
	camera_origin = $Player/Camera2D.transform.origin
	pauseButton_origin = $PauseButton.get_rect().position
	score_origin = $Score.get_rect().position
	menu_origin = $MenuScreen.transform.origin
	health_origin = $PlayerHealth.transform.origin
	game_over_screen_origin = $Gameover.transform.origin
	camera_position = $Player/Camera2D.get_camera_position() - $Player/Camera2D.get_camera_screen_center()
	$Gameover.create_hearts()
	
func update_positions(nodeName, camera_center, node_origin, position_name = "rect_position"):
	get_node(nodeName)[position_name] = camera_center + Vector2(camera_position.x + node_origin.x, camera_position.y - camera_origin.y + node_origin.y)


func _process(delta):
	var camera_center = $Player/Camera2D.get_camera_screen_center()

	update_positions("Score",camera_center, score_origin)
	update_positions("PauseButton", camera_center, pauseButton_origin)
	update_positions("MenuScreen", camera_center, menu_origin, "position")
	update_positions("PlayerHealth", camera_center, health_origin, "position" )
	update_positions("Gameover", camera_center, game_over_screen_origin, "position" )
	

func _on_PauseButton_pressed():
	get_tree().paused = true
	$PauseButton.hide()
	$MenuScreen.show_menu()



	
