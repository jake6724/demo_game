extends GameCharacter
class_name PlayerSuperClass

func set_character_stats():
	# Movement
	jump_counter = 0
	jump_max = 2 # How many jumps character has 
	jump_velocity = -400.0
	jump_threshold = -0.2
	run_speed = 300.0 
	walk_speed = 200.0
	walk_threshold = .5
	run_threshold = .8 # When to transition from walk to run
	air_speed = 250.0
	fast_fall_velocity= 3
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	# Combat
	ftilt_threshold = .01
	utilt_threshold = -.01
	health = 0.0
	weight = 100.0
	knockback_resistance = 1.0 
	# Set layers
	self.set_collision_layer_value(1, true)
	self.set_collision_mask_value(3, true)
	self.set_collision_mask_value(9, true)

func _physics_process(delta):
	print("0X: ", Input.get_axis("move_left", "move_right"))
	print("0Y: ", Input.get_axis("move_up", "move_down"))
	#print("1X: ", Input.get_axis("forward_smash_left", "forward_smash_right" ))
	# print(is_active)
	
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
	# if Input.is_action_just_pressed("move_down") and not is_on_floor() and velocity.y >= 0:
	# 	velocity.y += gravity * delta * fast_fall_velocity
	# 	print(velocity.y)

	move_and_slide()
