extends KinematicBody2D
signal hit_by_enemy

var velocity = Vector2()
var directions = ["right", "left"]
var current_direction = directions[randi() % directions.size()]
var switch_directions = {
	"right":"left",
	"left":"right"
}

func change_direction():
	if is_on_wall():
		current_direction = switch_directions[current_direction]
	
	if current_direction == "right":
		position.x += 1
		$AnimatedSprite.flip_h = true
	else:
		position.x -= 1 
		$AnimatedSprite.flip_h = false

func _physics_process(delta):
	$AnimatedSprite.play("run")
	
	change_direction()
	move_and_slide(velocity)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Player":
			$AnimatedSprite.animation = "attack"
			emit_signal("hit_by_enemy")
			


