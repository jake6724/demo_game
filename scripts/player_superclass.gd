extends CharacterBody2D
class_name player_superclass

@export var speed = 300.0

# Character stats
var jump_counter = 0
var jump_max = 1

var ground_speed = 350.0 
var roll_speed = ground_speed * 1.5

var air_speed = ground_speed / 1.5
var jump_velocity = -500.0
var fast_fall_velocity = 10

var damage = 10.0
var health = 0.0

# Signals
signal health_updated

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2
var actions = ["roll", "attack"]
var facing = -1
func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		facing = direction
		switch_direction(direction) 

	#if Input.is_action_just_pressed("attack") and not ap.current_animation in actions:
		#velocity = Vector2(0, 0)
	if is_on_floor():
		jump_counter = 0
		if Input.is_action_just_pressed("roll") and not ap.current_animation in actions:
			velocity.x = roll_speed * facing
		elif not ap.current_animation in actions:
			if Input.is_action_just_pressed("jump"):
				jump_counter += 1
				velocity.y = jump_velocity
			if direction:
				velocity.x = direction * ground_speed
			else:
				velocity.x = move_toward(velocity.x, 0, ground_speed)
	
	# Add the gravity.
	elif not is_on_floor():
		velocity.y += gravity * delta
		# fast fall
		if Input.is_action_just_pressed("fast_fall") and velocity.y >= 0:
			velocity.y += gravity * delta * fast_fall_velocity
		# double jummp
		if Input.is_action_just_pressed("jump") and jump_counter < 100:
			jump_counter += 1
			velocity.y = jump_velocity
		if direction:
			velocity.x = direction * air_speed
		else:
			velocity.x = move_toward(velocity.x, 0, air_speed)
		
	# Take damage (HUD testing) 
	if Input.is_action_just_pressed("take_damage"):
		update_health(10.0)
		
	move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if ap.current_animation in actions:
		return
	if Input.is_action_just_pressed("attack"):
		ap.play("attack")
	elif is_on_floor():
		if Input.is_action_just_pressed("roll"):
			ap.play("roll")
		else:
			if direction == 0:
				ap.play("idle")
			else:
				ap.play("run")
	elif not ap.current_animation in actions:
		if velocity.y < 0: 
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")
		
func switch_direction(direction):
	if ap.current_animation in actions:
		return
	sprite.flip_h = (direction == -1)
	sprite.position.x = direction * 4
	
func update_health(damage_recieved):
	health += float(damage_recieved)
	health_updated.emit(health)
