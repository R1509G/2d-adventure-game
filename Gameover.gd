extends Node2D

func _process(delta):
	var new_texture = State.music_on_texture if State.isBackgroundMusicOn else State.music_off_texture
	$ColorRect2/MusicButton/Sprite.texture = new_texture

func game_over():
	$".".show()
	get_tree().paused = true
	
func create_filled_hearts(hearts_count):
	for i in range(hearts_count):
			var sprite = Sprite.new()
			var texture = preload("res://images/hearts-fill.png")
			sprite.texture = texture
			sprite.position.x = State.hearts_offset * i
			get_node("%PlayerHealth").add_child(sprite)
	
func create_hearts():
	var has_full_chance = State.player_chances == State.player_max_chances
	if !has_full_chance:
		create_filled_hearts(State.player_chances)
		for i in range(State.player_max_chances - State.player_chances):
			var sprite = Sprite.new()
			var texture = preload("res://images/hearts-outlined.png")
			sprite.texture = texture
			sprite.position.x = State.hearts_offset * (i + State.player_chances)
			get_node("%PlayerHealth").add_child(sprite)
	else:
		create_filled_hearts(State.player_max_chances)
		

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

func reset_game():
	State.player_chances = State.player_max_chances
	State.distance_traveled = 0
	get_tree().call_group("enemies", "queue_free")
	get_node("%Player").position = Vector2.ZERO

func _on_RetryButton_pressed():
	get_tree().paused = false
	$".".hide()
	reset_game()
	create_hearts()
	
