extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size
var speed = 5000
var gravity = 98  # Adjust gravity to suit your game

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var movement = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		movement.x += 1
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	if Input.is_action_just_pressed("jump") :
		movement.y -=  83
		

	if movement.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	if movement.x != 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = movement.x < 0
	else:
		$AnimatedSprite.animation = "stand"
		
	
		
	velocity.y += gravity * delta
	if is_on_floor():
		velocity.y = 0
	
	if velocity.y > 2:
		$AnimatedSprite.animation = "jump"


	move_and_slide(velocity + movement * speed * delta, Vector2.UP)

	position.x = clamp(position.x, 0, screen_size.x)
