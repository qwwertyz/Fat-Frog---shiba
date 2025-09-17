extends CharacterBody2D


const SPEED = 4000.0
const JUMP_VELOCITY = -500.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction<0:
		animated_sprite_2d.flip_h = true
	
	#play animations
	if is_on_floor():
		if direction==0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
		
		
	if direction and is_on_floor():
		Engine.time_scale = 0.3
		velocity.x = direction * SPEED
		velocity.y = JUMP_VELOCITY
		
		while not is_on_floor():
			velocity.x = direction * SPEED
			
		Engine.time_scale = 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) #speed is glide.

	move_and_slide()
