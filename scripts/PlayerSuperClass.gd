extends GameCharacter
class_name PlayerSuperClass

func set_character_stats():
	# Movement
	jump_counter = 0
	jump_max = 2 # How many jumps character has 
	run_speed = 500.0 
	walk_speed = 150.0
	run_threshold = 0.3 # When to transition from walk to run
	air_speed = 300.0
	jump_velocity = -500.0
	fast_fall_velocity= 10.0
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2
	# Combat
	health = 0.0
	weight = 100.0
	knockback_resistance = 1.0 

func _physics_process(delta):
	# Get player input for movement states
	x_input = Input.get_axis("move_left", "move_right")
	y_input = Input.get_axis("move_up", "move_down")
	
	# Set sprite direction
	set_character_direction(x_input)
	
	# Set current condition
	if is_on_floor():
		current_condition = condition.GROUNDED
	else:
		current_condition = condition.IN_AIR
	
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Add fast fall ability (only after player has hit jump peak) 
	if Input.is_action_just_pressed("move_down") and not is_on_floor() and velocity.y >= 0:
		velocity.y += gravity * delta * fast_fall_velocity
		
	move_and_slide()
