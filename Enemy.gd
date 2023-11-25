extends KinematicBody2D

var velocity = Vector2()
var current_direction = "right"
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
			get_node("%Player").position = Vector2.ZERO
			


