extends CharacterBody2D
class_name GameCharacter

# This class handles all the boring shit that the player and enemy
# classes both have to set up and do to work

# Character nodes 
@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var movement_sm = $MovementStateMachine
@onready var action_sm = $ActionStateMachine
@onready var label_current_movement_state = $LabelCurrentMovementState
@onready var label_current_action_state = $LabelCurrentActionState

# Hitbox nodes 
var hitbox_collisions: Array
var combat_hitboxes_parent: Node2D

# Character condition (Used by state machines)
enum condition{GROUNDED, IN_AIR, ON_LEDGE}
var current_condition: int # A value of condition enum
var is_active: bool

# Signals
signal character_ready
signal health_updated
signal character_hurtbox_entered

# Character input data
var x_input: float 
var y_input: float 

# Character state data 
var current_movement_state: State
var current_action_state: State

# Character stats
#Movement
var jump_counter: int 
var jump_max: int # How many jumps character has 
var run_speed: float
var walk_speed:float
var run_threshold: float
var air_speed: float
var jump_velocity: float
var fast_fall_velocity:float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Combat
var health: float
var weight: float
var knockback_resistance: float
#Knockback state values
var kb: float
var ls: float
var lv: Vector2
var ad: Vector2
var knocked_right: bool 
var knocked_down: bool
var hs: int 

func set_character_stats():
	pass
	
func _ready(): 
	# Set stats in child class
	set_character_stats()
	
	# Set default state for labels
	label_current_movement_state.text = str(movement_sm.initial_state.state_name)
	label_current_action_state.text = str(action_sm.initial_state.state_name)
	
	# Connect to StateMachine signals
	movement_sm.change_current_state.connect(on_change_current_movement_state)
	action_sm.change_current_state.connect(on_change_current_action_state)
	
	# Set character default state names
	current_movement_state = movement_sm.initial_state
	current_action_state = action_sm.initial_state
	
	# Default character conditions
	is_active = false
	
	# Emit that character is ready and loaded;
	# used for loading character nodes (ex. AnimationPlayer)
	# in other classes like states
	# since states cannot access character data until character has loaded, 
	# but children (the states) load before parent (GameCharacter)
	character_ready.emit()
	
	# Set up hitboxes array 
	# Array items are lists of:
	# [HitboxCollision obj, vector2 of obj initial pos]
	# All hitboxes MUST have exactly 1 CHILD, a collision shape 2D
	combat_hitboxes_parent = get_node("Sprite2D/CombatHitboxes")
	var collider_obj
	var collider_obj_init_pos
	if combat_hitboxes_parent.get_child_count() > 0:
		for child in combat_hitboxes_parent.get_children():
			collider_obj = child.get_child(0)
			collider_obj_init_pos = collider_obj.position
			hitbox_collisions.append([collider_obj, collider_obj_init_pos])

func _physics_process(_delta):
	pass

func set_character_direction(direction):
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
	# *Called by set_character_direction()*
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

func on_change_current_movement_state(new_state):
	label_current_movement_state.text = new_state.state_name
	current_movement_state = new_state
	
func on_change_current_action_state(new_state):
	label_current_action_state.text = new_state.state_name
	current_action_state = new_state

func update_health(damage_taken):
	health += float(damage_taken)
	health_updated.emit(health)
	
func hurtbox_entered(damage, new_kb, new_ls, new_lv, new_ad, new_hs):
	update_health(damage)
	
	kb = new_kb
	ls = new_ls
	lv = new_lv
	ad = new_ad
	hs = new_hs
	
	if ad.x <= 0:
		knocked_right = true
	else:
		knocked_right = false 
		
	if ad.y >= 0: # TODO: I don't think this is set up correctly
		knocked_down = true
	else:
		knocked_down = false 
	
	character_hurtbox_entered.emit()
