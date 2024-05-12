extends GameCharacter
class_name EnemySuperClass

signal enemy_hurtbox_entered

func set_character_stats():
	# Movement
	jump_counter = 0
	jump_max = 2 # How many jumps character has 
	run_speed = 300.0 
	walk_speed = 200.0
	run_threshold = .8 # When to transition from walk to run
	air_speed = 250.0
	jump_velocity = -400.0
	fast_fall_velocity= 20.0
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	# Combat
	health = 0.0
	weight = 100.0
	knockback_resistance = 1.0 

func _physics_process(delta):
	# Set sprite direction
	set_character_direction(velocity.x)
	
	# Set current condition
	if is_on_floor():
		current_condition = condition.GROUNDED
	else:
		current_condition = condition.IN_AIR
	
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
