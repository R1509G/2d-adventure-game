extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size
var speed = 1000


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	var movement = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	if Input.is_action_pressed("jump"):
		movement.y -= 2
		
	print(movement.length())

	if movement.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	if movement.x != 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = movement.x < 0
	else:
		$AnimatedSprite.animation = "stand"
	if movement.y < 0:
		$AnimatedSprite.animation = "jump" 
		movement.y+=1
		
	
	movement = movement.normalized()
	move_and_slide(movement * speed * delta, Vector2.DOWN)
	#position.x = clamp(position.x, 0, screen_size.x)
	
