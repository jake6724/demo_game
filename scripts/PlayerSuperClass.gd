extends CharacterBody2D
class_name PlayerSuperClass

# Player nodes 
@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var movement_sm = $PlayerMovementStateMachine
@onready var action_sm = $PlayerActionStateMachine
@onready var label_current_movement_state = $LabelCurrentMovementState
@onready var label_current_action_state = $LabelCurrentActionState

# Hitbox nodes 
@onready var jab_hitbox_collision = $"Sprite2D/CombatHitboxes/JabHitbox/JabCollision"
@onready var jab_hitbox_collision_init_pos = jab_hitbox_collision.position
var hitbox_collisions: Array
var combat_hitboxes_parent


# Player condition (Used by state machines)
enum condition{GROUNDED, IN_AIR, ON_LEDGE}
var current_condition = condition.GROUNDED
var is_active

# Signals
signal player_ready
signal health_updated

# Player input data
var x_input 
var y_input 

# Player state data 
var current_movement_state
var current_action_state

# Character stats
var jump_counter: int = 0
var jump_max: int = 2
var run_speed: float = 300.0 
var walk_speed:float = 200.0
var run_threshold: float = .8
var air_speed: float = 250.0
var jump_velocity: float = -400.0
var fast_fall_velocity:float = 20.0
var damage: float = 10.0
var health: float = 0.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready(): 
	# Set default state for labels
	label_current_movement_state.text = str(movement_sm.initial_state.state_name)
	label_current_action_state.text = str(action_sm.initial_state.state_name)
	
	# Connect to StateMachine signals
	movement_sm.change_current_state.connect(on_change_current_movement_state)
	action_sm.change_current_state.connect(on_change_current_action_state)
	
	# Set player default state names
	current_movement_state = movement_sm.initial_state.state_name
	current_action_state = action_sm.initial_state.state_name
	
	# Default player conditions
	is_active = false
	
	# Emit that player is ready and loaded;
	# used for loading player nodes (ex. AnimationPlayer
	# in other classes like states
	# since states can access until player has loaded, 
	# but children (the states) load before parent (PlayerSuperClass)
	player_ready.emit()
	
	# Set up hitboxes array 
	# Array items are lists of:
	# [HitboxCollision obj, vector2 obj initial pos]
	# All hitboxes MUST have 1 CHILD, a collision shape 2D
	combat_hitboxes_parent = get_node("Sprite2D/CombatHitboxes")
	var collider_obj
	var collider_obj_init_pos
	for child in combat_hitboxes_parent.get_children():
		collider_obj = child.get_child(0)
		collider_obj_init_pos = collider_obj.position
		hitbox_collisions.append([collider_obj, collider_obj_init_pos])

func _physics_process(delta):
	#$"AnimationPlayer".advance(0)
	#print(velocity.y)
	# Get player input for movement states
	x_input = Input.get_axis("move_left", "move_right")
	y_input = Input.get_axis("move_up", "move_down")
	
	# Set sprite direction
	set_player_sprite_direction(x_input)
	
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

func set_player_sprite_direction(direction):
	if direction != 0:
		if direction <= -0.001:
			# Flip sprite and invert hitboxes initial position x
			sprite.flip_h = true
			#jab_hitbox_collision.position.x = - jab_hitbox_collision_init_pos.x
			set_hitbox_colliders_direction(true)
		else:
			# Unflip sprite, set hitbox position to initial x position
			sprite.flip_h = false
			#jab_hitbox_collision.position.x = jab_hitbox_collision_init_pos.x
			set_hitbox_colliders_direction(false)	

func set_hitbox_colliders_direction(should_flip: bool):
	# For each item in hit box collisions, get the collider obj
	# and set it equal to the collider obj's initial position,
	# or its initial position inverted.
	# Item = [Collider obj, Collider obj initial pos as a 2d vector]
	if should_flip:
		for c in hitbox_collisions:
			c[0].position.x = - c[1].x
	else:
		for c in hitbox_collisions:
			c[0].position.x = c[1].x

func on_change_current_movement_state(new_state_name):
	label_current_movement_state.text = new_state_name
	current_movement_state = new_state_name
	
func on_change_current_action_state(new_state_name):
	label_current_action_state.text = new_state_name
	current_action_state = new_state_name

func update_health(damage_taken):
	health += float(damage_taken)
	health_updated.emit(health)
	
func print_left_stick_values():
	var left_stick_value = Input.get_axis("move_left", "move_right")
	print(left_stick_value)
