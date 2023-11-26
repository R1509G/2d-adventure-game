extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var gravity = 98


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = Vector2.ZERO
	if Input.is_action_just_pressed("space"):
		movement.x += 50
		
	velocity.y += gravity * delta

	if is_on_floor():
		velocity.y = 0
		
	move_and_slide(velocity+movement*delta*8000,Vector2.UP)
