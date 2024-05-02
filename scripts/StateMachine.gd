extends Node2D

@export var initial_state : State 

var current_state :  State
var states : Dictionary = {} 

func _ready():
	print("StateMachine ready")
	# Check through all children of 'StateMachine' node 
	# and add to states dict if child is of 'State' class
	for child in get_children():
		if child is State:
			print("StateMachine child state found")
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			
	if initial_state:
		print("Initial state valid")
		initial_state.enter()
		current_state = initial_state
		print("StateMachine initial state:", current_state)
			
func _process(delta):
	if current_state:
		current_state.state_update(delta)
		
func _physics_process(delta):
	if  current_state:
		current_state.state_physics_update(delta)
		
func on_child_transition(state, new_state_name):
	# Only transition if the state that called this function
	# is the current state
	if state != current_state:
		return 
	
	# Do not transition if the new state cannot be found
	# in states dict
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return 
		
	# If a state is currently running
	# (Should always be true unless one isn't instantiated ?) 
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state
