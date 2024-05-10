extends Node2D
class_name StateMachine

@export var initial_state : State 
@onready var player : PlayerSuperClass
@onready var enemy : EnemySuperClass

var current_state :  State
var states : Dictionary = {} 

signal change_current_state

func _ready():
	# Check through all children of 'StateMachine' node 
	# and add to states dict if child is of 'State' class
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			# Connect to child's transition signal
			child.transition.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.state_update(delta)
		
func _physics_process(delta):
	if  current_state:
		current_state.state_physics_update(delta)
		
func on_child_transition(state, new_state_name):
	# Only transition if the state that called this function
	# IS the current state
	if state != current_state:
		return 
	
	# Do not transition if the new state cannot be found
	# in states dict
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return 
		
	# If a state is currently running, run its exit function
	if current_state:
		current_state.exit()
	
	# Run the new states enter function
	new_state.enter()
	
	# Set current state to the new state, and emit state change signal
	current_state = new_state
	change_current_state.emit(new_state)
