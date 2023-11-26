extends Node2D
signal new_level

var screen_size

func _ready():
	screen_size = $Background.get_rect().size


func _process(delta):
	if State.distance_traveled > screen_size.x - 300:
		emit_signal("new_level") 
		
