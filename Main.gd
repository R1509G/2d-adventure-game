extends Node2D

var camera_origin
var pauseButton_origin
var score_origin
var menu_origin
var health_origin
var LevelLabel_origin
var game_over_screen_origin
var camera_position

func _notification(code):
	if code == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		get_tree().paused = true 
		$MenuScreen/ColorRect2.show()
		$BackgroundMusic.stop()
	elif code == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		$BackgroundMusic.play()

func generate_enemy():
	var enemy_scene = preload("res://Enemy.tscn")
	for i in range(5):
		var enemy = enemy_scene.instance()
		enemy.position.x =  randi() % int(get_viewport_rect().size.x) + 1000
		add_child(enemy)
		
		
func _ready():
	randomize()
	$Gameover.hide()
	camera_origin = $Player/Camera2D.transform.origin
	pauseButton_origin = $PauseButton.get_rect().position
	score_origin = $Score.get_rect().position
	menu_origin = $MenuScreen.transform.origin
	health_origin = $PlayerHealth.transform.origin
	LevelLabel_origin = $LevelLabel.get_rect().position
	game_over_screen_origin = $Gameover.transform.origin
	camera_position = $Player/Camera2D.get_camera_position() - $Player/Camera2D.get_camera_screen_center()
	$Gameover.create_hearts()
	$LevelLabel.text = "level: " + str(State.current_level)	
	update_background()
	#generate_enemy()
	
	
	
func update_positions(nodeName, camera_center, node_origin, position_name = "rect_position"):
	get_node(nodeName)[position_name] = camera_center + Vector2(camera_position.x + node_origin.x, camera_position.y - camera_origin.y + node_origin.y)


func _process(delta):
	var camera_center = $Player/Camera2D.get_camera_screen_center()

	update_positions("Score",camera_center, score_origin)
	update_positions("LevelLabel",camera_center, LevelLabel_origin)
	update_positions("PauseButton", camera_center, pauseButton_origin)
	update_positions("MenuScreen", camera_center, menu_origin, "position")
	update_positions("PlayerHealth", camera_center, health_origin, "position" )
	update_positions("Gameover", camera_center, game_over_screen_origin, "position" )
	
	

func _on_PauseButton_pressed():
	get_tree().paused = true
	$PauseButton.hide()
	$MenuScreen.show_menu()

func update_background():
	var path = "res://images/bg/bg%s.png" % State.current_level
	var next_level_texture = ResourceLoader.load(path)
	$Levels/Background.texture = next_level_texture
	

func _on_Levels_new_level():
	State.current_level += 1
	$LevelLabel.text = "level: " + str(State.current_level)
	update_background()
	$Player.position = Vector2.ZERO
	$Gameover.reset_game()
