extends Node2D

func _process(delta):
	var new_texture = State.music_on_texture if State.isBackgroundMusicOn else State.music_off_texture
	$ColorRect2/MusicButton/Sprite.texture = new_texture

func game_over():
	$".".show()
	get_tree().paused = true
	
func create_hearts():
	for i in range(State.player_chances):
		var sprite = Sprite.new()
		var texture = preload("res://images/hearts-fill.png")
		sprite.texture = texture
		sprite.position.x = 55 * i
		get_node("%PlayerHealth").add_child(sprite)

func _on_Enemy_hit_by_enemy():
	State.player_chances -= 1
	
	if State.player_chances == 0:
		game_over()
	else:
		get_node("%Player").position = Vector2.ZERO
		var sprite = get_node("%PlayerHealth").get_child(State.player_chances)
		if sprite:
			var texture =  preload("res://images/hearts-outlined.png")
			sprite.texture = texture


func _on_RetryButton_pressed():
	get_tree().paused = false
	$".".hide()
	State.player_chances = get_node("%PlayerHealth").get_child_count()
	State.distance_traveled = 0
	get_node("%Player").position = Vector2.ZERO
	create_hearts()
	
