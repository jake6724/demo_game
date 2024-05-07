extends CharacterBody2D
class_name PlayerSuperClass

# Player nodes 
@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var movement_sm = $PlayerMovementStateMachine
@onready var action_sm = $PlayerActionStateMachine
@onready var label_current_state = $LabelCurrentState

# Player condition (Used by state machines)
enum condition{GROUNDED, IN_AIR, ON_LEDGE}
var current_condition = condition.GROUNDED
var is_active

# Signals
signal health_updated

# Player input data
var x_input 
var y_input 

# Character stats
var jump_counter: int = 0
var jump_max: int = 100
var run_speed: float = 300.0 
var walk_speed:float = 200.0
var run_threshold: float = .8
var air_speed: float = 200.0
var jump_velocity: float = -400.0
var fast_fall_velocity:float = 20.0
var damage: float = 10.0
var health: float = 0.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready(): 
	# Set default state for state label
	label_current_state.text = str(movement_sm.initial_state.state_name)
	
	# Connect to StateMachine signals
	movement_sm.change_current_state.connect(on_change_current_state)
	action_sm.change_current_state.connect(on_change_current_state)
	
	# Default player conditions
	condition.GROUNDED
	is_active = false

func _physics_process(delta):
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
	
	# Reset jumping if player is on floor 
	if is_on_floor():
		current_condition = condition.GROUNDED
		jump_counter = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Add fast fall ability (only after player has hit jump peak) 
	if Input.is_action_just_pressed("move_down") and not is_on_floor() and velocity.y >= 0:
		velocity.y += gravity * delta * fast_fall_velocity

	# Handle jump.
	if Input.is_action_just_pressed("move_up"):
		if jump_counter <= jump_max:
			jump_counter += 1 
			velocity.y = jump_velocity # negative values go up 
			current_condition = condition.IN_AIR
		
	# Take damage (HUD testing) 
	if Input.is_action_just_pressed("take_damage"):
		update_health(10.0)
		
	move_and_slide()
	#update_animations(direction)
	#print_left_stick_values() 
	
func on_change_current_state(new_state_name):
	label_current_state.text = new_state_name
	
#func update_animations(direction):
	#if is_on_floor():
		#if direction == 0:
			#ap.play("idle")
		#else:
			#ap.play("run")
	#else:
		#if velocity.y < 0: 
			#ap.play("jump")
		#elif velocity.y > 0:
			#ap.play("fall")
		#
		
func set_player_sprite_direction(direction):
	if direction != 0:
		sprite.flip_h = (direction <= -0.001)
		sprite.position.x = direction * 4

func switch_direction(direction):
	sprite.flip_h = (direction == -1)
	sprite.position.x = direction * 4
	
func update_health(damage_recieved):
	health += float(damage_recieved)
	health_updated.emit(health)
	
func print_left_stick_values():
	var left_stick_value = Input.get_axis("move_left", "move_right")
	print(left_stick_value)
