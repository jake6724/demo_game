extends CharacterBody2D
class_name PlayerSuperClass

@export var speed = 300.0

# Player condition used in states
enum condition{
	GROUNDED,
	IN_AIR,
	ON_LEDGE,
}

var current_condition = condition.GROUNDED

# Character stats
var jump_counter = 0
var jump_max = 100

var run_speed = 300.0 
var walk_speed = 200.0
var run_threshold = .8


var air_speed = 200.0
var jump_velocity = -400.0
var fast_fall_velocity = 20

var damage = 10.0
var health = 0.0

var x_input 

# Signals
signal health_updated

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var pmsm = $PlayerMovementStateMachine
@onready var label_current_state = $LabelCurrentState

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready(): 
	label_current_state.text = str(pmsm.initial_state.state_name)
	# Connect to StateMachine signals
	pmsm.change_current_state.connect(on_change_current_state)
	condition.GROUNDED

func _physics_process(delta):
	print(current_condition)
	x_input = Input.get_axis("move_left", "move_right")
	# Reset animation vars ? 
	#is_attacking = false 
	
	# Reset jumping if player is on floor 
	if is_on_floor():
		current_condition = condition.GROUNDED
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
			current_condition = condition.IN_AIR
		
	## Get the input direction and handle the movement/deceleration.
	## Determine whether to use horizontal ground or air speed 
	var direction = Input.get_axis("move_left", "move_right")
	#if is_on_floor():
		#if direction:
			#velocity.x = direction * ground_speed
		#else:
			#velocity.x = move_toward(velocity.x, 0, ground_speed)
	#else:
		#if direction:
			#velocity.x = direction * air_speed
		#else:
			#velocity.x = move_toward(velocity.x, 0, air_speed)
	
	#if direction != 0:
		#switch_direction(direction) 
		
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
func switch_direction(direction):
	sprite.flip_h = (direction == -1)
	sprite.position.x = direction * 4
	
func update_health(damage_recieved):
	health += float(damage_recieved)
	health_updated.emit(health)
	
func print_left_stick_values():
	var left_stick_value = Input.get_axis("move_left", "move_right")
	print(left_stick_value)
