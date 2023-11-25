extends KinematicBody2D

var speed = 5000
var gravity = 98
var velocity = Vector2.ZERO
var initial_position = position.x


func _ready():
	get_viewport_rect().size
	

func update_score():
	print(position.x,State.distance_traveled)
	var score = round(position.x) 
	
	if score >= State.distance_traveled:
		State.distance_traveled = score
		get_node("%Score").text = "Distance: " + str(score)

func handle_movement():
	var movement = Vector2.ZERO
	
	movement.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	if Input.is_action_just_pressed("space"):
		movement.y -= 53
	
	if movement.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	return movement

func handle_attack():
	if Input.is_action_pressed("left_click"):
		$AnimatedSprite.animation = "attack"
		$AnimatedSprite.set_frame(3)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision and collision.collider and collision.collider.name == "Enemy":
					collision.collider.queue_free()
	


func handle_animation(movement):
		if movement.x != 0:
			$AnimatedSprite.animation = "run"
			$AnimatedSprite.flip_h = movement.x < 0
		else:
			$AnimatedSprite.animation = "stand" if is_on_floor()  else "jump"  
			
func apply_gravity(delta):
	velocity.y += gravity * delta

	if is_on_floor():
		velocity.y = 0

func _physics_process(delta):
	var movement = handle_movement()
	
	handle_animation(movement)
	apply_gravity(delta)
	update_score()
	handle_attack()
	move_and_slide(velocity + movement * speed * delta, Vector2.UP)
	#position.x = clamp(position.x, 0, 1000)
	

