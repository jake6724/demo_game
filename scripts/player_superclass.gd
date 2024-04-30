extends CharacterBody2D
class_name player_superclass

@export var speed = 300.0

# Character stats
var jump_counter = 0
var jump_max = 1

var ground_speed = 300.0 

var air_speed = 200.0
var jump_velocity = -400.0
var fast_fall_velocity = 20

var damage = 10.0
var health = 0.0

# Animation vars 
var is_attacking = false 

# Signals
signal health_updated

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Reset animation vars ? 
	#is_attacking = false 
	
	# Reset jumping if player is on floor 
	if is_on_floor():
		jump_counter = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Add fast fall ability (only after player has hit jump peak) 
	if Input.is_action_just_pressed("fast_fall") and not is_on_floor() and velocity.y >= 0:
		velocity.y += gravity * delta * fast_fall_velocity

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if jump_counter <= jump_max:
			jump_counter += 1 
			velocity.y = jump_velocity # negative values go up 
		
	# Get the input direction and handle the movement/deceleration.
	# Determine whether to use horizontal ground or air speed 
	var direction = Input.get_axis("move_left", "move_right")
	if is_on_floor():
		if direction:
			velocity.x = direction * ground_speed
		else:
			velocity.x = move_toward(velocity.x, 0, ground_speed)
	else:
		if direction:
			velocity.x = direction * air_speed
		else:
			velocity.x = move_toward(velocity.x, 0, air_speed)
	
	if direction != 0:
		switch_direction(direction)
		
	move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0: 
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")
		
func switch_direction(direction):
	sprite.flip_h = (direction == -1)
	sprite.position.x = direction * 4
	
func update_health(damage_recieved):
	health += damage_recieved
	

