extends StateMachine
class_name PlayerActionStateMachine

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

	# Get player reference
	player = get_tree().get_first_node_in_group("Player")
	# Connect to player's 'player_ready' signal 
	player.character_ready.connect(on_character_ready)

func on_character_ready():
	initialize_states()
	
func initialize_states():
	var state_to_initialize: State
	for s in states:
		state_to_initialize = states[s]
		state_to_initialize.state_initialize()
